#Include <bluscream>
#Include <JSON>
#INCLUDE <Acc>
#Include <logtail>
#Include <Class_SQLiteDB>

#SingleInstance, Force
#NoEnv
#Persistent
dir := new Paths.User().localappdata.combine("ripcord")
exe := dir.combineFile("Ripcord.exe")
Menu, Tray, Icon, % exe.path, 1
global dbfile := dir.combineFile("discord_client.ripdb")
; #NoTrayIcon
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
;
global rc_title := "ahk_class Qt5QWindowIcon ahk_exe " . exe.fullname
global vc_title := "Ripcord Voice Chat " . rc_title

global log_pattern := "^(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2}\.\d{3})\s+(\w+)\s(.*)$"
global msg_pattern := "^(\w+):\s+(.*)$"
global error_pattern := "^(.*): (\{.*\}) --- Error transferring (.*) - server replied: (.*)$"
global error_pattern_ws := "^Voice WebSocket disconnected with code (\d+) and reason (.*)$"

global error_codes_ws := { "4001": "Unknown opcode", "4003": "Not authenticated", "4004": "Authentication failed", "4005": "Already authenticated", "4006": "Session no longer valid", "4009": "Session timeout", "4011": "Server not found", "4012": "Unknown protocol", "4014": "Disconnected (channel was deleted or you were kicked)", "4015": "Voice server crashed", "4016": "Unknown encryption mode" }
global texts := { "Waiting for server":0, "Opening WebSocket":0, "Connected":0, "Disconnected":0 }
global old_status := ""

global check_delay_s := 5000

lt_chat := new LogTailer(dir.combineFile("ripcord.log").path, Func("OnNewLogLine"), true) ; , "CP1200")

global DB := New SQLiteDB
global db_connected := false
global MSG_SQL := "SELECT * FROM message WHERE UPPER(content) LIKE UPPER('%${SEARCH}%');"
global MSG_SQL_ := "SELECT user.name AS Author, guild.name AS Server, guild_channel.name AS Channel, message.content AS Message, message.id AS Timestamp FROM message JOIN guild_channel ON message.channel_id = guild_channel.id JOIN guild ON guild_channel.id = guild.id JOIN user ON message.author_id = user.id WHERE UPPER(message.content) LIKE UPPER('%${SEARCH}%');"
global USR_SQL := "SELECT user.id, user.name FROM user"
global ROLE_SQL := "SELECT role.id, role.name from role WHERE role.mentionable == 1"
global User_Map := ComObjCreate("Scripting.Dictionary")
global Role_Map := ComObjCreate("Scripting.Dictionary")
global Result := ""
global Users := ""
global Roles := ""
global guisize_exec := 0

hook()
OnExit, ExitSub

#IfWinActive ahk_exe Ripcord.exe
^f::
    if (!db_connected) {
        if (!DB.OpenDB(dbfile.path, "R", false)) {
           MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
           ExitApp
        }
        db_connected := true
    }
    InputBox, UserInput, Search Message, , , 400, 100
    if (ErrorLevel) {
        return
    }
    _msg_sql := StrReplace(MSG_SQL, "${SEARCH}", StrReplace(UserInput, "'", "''")) ; sanitize SQL query
    if (!DB.GetTable(_msg_sql, Result) || !DB.GetTable(USR_SQL, Users) || !DB.GetTable(ROLE_SQL, Roles)) {
        MsgBox, 16, SQLite Error: GetTable, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    } else {
       Gui, Destroy
       Gui, +Resize
       For Each, Row In Users.Rows {
           If( !User_Map.Exists( Row[1] ) )
               User_Map.Add( Row[1], Row[2] )
               
       }
       For Each, Row In Roles.Rows {
           If( !Role_Map.Exists( Row[1] ) )
               Role_Map.Add( Row[1], Row[2] )
       }
       Gui, Add, Text, xm, % "Rows: " . Result.RowCount . " | Columns: " . Result.ColumnCount . " | Users: " . User_Map.Count() . " | Roles: " . Role_Map.Count()
       Gui, Add, Text, xm, % "sql: " . _msg_sql
       columns := "|".Join(Result.ColumnNames)
       Gui, Add, Text, xm, % "Columns: " . columns
       Gui, Add, ListView, w1000 h300 vMyListView Grid -ReadOnly, % columns
       GuiControl, -Redraw, MyListView
        For Each, Row In Result.Rows {
            While( RegExMatch(Row[7], "\<\@.*\>" ) ) { ; string replacement for usernames
                    ; get start & end positions
                    StartPos := InStr( Row[7], "<@" ) + 2
                    EndPos := InStr( Row[7], ">", false, StartPos )
                    Exclamation := ( ( RegExMatch(Row[7], "\<\@(!|&).*\>" ) ) ? SubStr( Row[7], StartPos++, 1 ) : "" ) ; if special mention (owner / role ), adjust start pos + add special char
                    ; put it all together to get the string to replace, and the replacement string
                    Mention := SubStr( Row[7], StartPos, EndPos - StartPos )
                    ReplaceMe := "<@" . Exclamation . Mention . ">"                  
                    Replacement := "@" . ( ( User_Map.Exists( Mention ) ) ?  User_Map.Item[ Mention ] : Role_Map.Item[ Mention ] ) ; replace mention with either the user name or the role name
                    Row[7] := StrReplace( Row[7], ReplaceMe, Replacement ) ; do the replacement
            }
            ; convert message id to timestamp
            MsgUTC := 1970
            Epoch := Floor( ( ( Format("{:d}", Row[1] ) >> 22 ) + 1420070400000 ) / 1000 )
            EnvAdd MsgUTC, Epoch, Seconds
            ; format the timestamp
            FormatTime, MsgUTC, %MsgUTC%, yyyy-MM-dd HH:mm
            Row[1] := MsgUTC
            LV_Add("", Row*)
        }
        GuiControl, +Redraw, MyListView
        LV_ModifyCol()
        Gui, Show, AutoSize Center, % "Found " . Result.RowCount . " Messages for """ . UserInput . """"
    }

; DB.CloseDB()
Return

MyListView:
    If !(A_GuiEvent == "RightClick") {
        Return
    }
    Gui, Submit, Nohide
    LV_GetText(c1, A_EventInfo , 1)
    LV_GetText(c2, A_EventInfo , 2)
    LV_GetText(c3, A_EventInfo , 3)
    LV_GetText(c4, A_EventInfo , 3)
    LV_GetText(c5, A_EventInfo , 3)
    LV_GetText(c6, A_EventInfo , 3)
    LV_GetText(c7, A_EventInfo , 3)
    clipboard := c1 . "|" . c2 . "|" . c3 . "|" . c4 . "|" . c5 . "|" . c6 . "|" . c7
    Return

GuiSize:
    if (A_EventInfo = 1) {
        return
    }
    if (guisize_exec < 3) {
        guisize_exec++
        return
    }
    GuiControl, Move, MyListView, % "w" . (A_GuiWidth - 20) . " h" . (A_GuiHeight - 20)
    return

ExitSub:
    unhook()
    ahk_exe := StrSplit(A_AhkPath, "\")
    for objItem in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where Name = '" . ahk_exe[ahk_exe.MaxIndex()] . "'")
    {
        if (InStr(objItem.CommandLine, """" . A_ScriptFullPath . """")) {
            Process, Close, % objItem.ProcessId
        }
    }


OnNewLogLine(FileLine) {
    validLine := RegExMatch(FileLine, log_pattern, msg)
    if (!validLine){
        scriptlog("INVALID: " . FileLine)
        Return
    } else if (RegExMatch(msg4, msg_pattern, message)){
        if (RegExMatch(message2,error_pattern, error)){
            error2 := error2
            json := JSON.Load(error2)
            MsgBox, 0x10, % "Ripcord - " . error1 , % error4 . " (" . json.message . ")`r`n`r`n" . error3
        } else if (RegExMatch(message2,error_pattern_ws, error)) {
            MsgBox, 0x10, % "Ripcord - " . error1 , % error2 . " " error_codes_ws[error1]
        } else {
            ; scriptlog("msg4 " . msg4)
        }
        Return
    } else {
        scriptlog("INVALID msg: " . msg)
    }
    Return
}


checkCallStatus() {
    MsgBox % getCallStatus()
}

getCallStatus() {
    return Acc_Get("Name", "4.1.10", 0, vc_title)
}

onTextChanged(hHook, event, hWnd, idObject, idChild, eventThread, eventTime) {
    acc := Acc_ObjectFromEvent(_idChild_, hWnd, idObject, idChild)
    try {
        if (acc.accRole(0) == 41) {
            call_status := acc.accName(0)
            if (texts.HasKey(call_status) == 1) {
                onCallStatusChanged(call_status)
            }
        }
    } catch e {
        ; ScriptLog("Failed onTextChanged: " . e)
    }
}

onCallStatusChanged(new_status) {
    if (new_status == old_status) {
        return
    }
    ScriptLog("Call Status Changed | Old: " . old_status . "`t`tNew: " . new_status)
    if (new_status == "Disconnected") {
        ScriptLog("Call was disconnected, checking again in " . check_delay_s / 1000 . " seconds...")
        SetTimer, ReCheckCallStatus, % check_delay_s
    }
    old_status := new_status
}

ReCheckCallStatus:
    SetTimer, ReCheckCallStatus, Off
    if (getCallStatus() == "Disconnected") {
        text := "Call is still disconnected after " . check_delay_s / 1000 . " seconds, recalling..."
        ScriptLog(text)
        MsgBox,, "Ripcord Voice Call", % text
        WinClose, % vc_title
    }

hook() {
    pCallback := RegisterCallback("onTextChanged")
    Acc_SetWinEventHook(0x800C, 0x800C, pCallback)
    ; ScriptLog("Hooked onTextChanged to " . pCallback)
}
unhook() {
    Acc_UnhookWinEvent(pCallback)
}

; ^q::hook()
; ^w::unhook()
; ^e::checkCallStatus()