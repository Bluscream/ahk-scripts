#Include <bluscream>
#Include <JSON>
#INCLUDE <Acc>
#Include <logtail>
#Include <Class_SQLiteDB>

#SingleInstance, Force
#NoEnv
#Persistent
global rc_dir := "C:\Users\blusc\AppData\Local\Ripcord\"
global rc_exe := "Ripcord.exe"
global rc_db := "discord_client.ripdb"
Menu, Tray, Icon, % rc_dir . rc_exe, 1
#NoTrayIcon
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
;
global rc_title := "ahk_class Qt5QWindowIcon ahk_exe " . rc_exe
global vc_title := "Ripcord Voice Chat " . rc_title

global log_pattern := "^(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2}\.\d{3})\s+(\w+)\s(.*)$"
global msg_pattern := "^(\w+):\s+(.*)$"
global error_pattern := "^(.*): (\{.*\}) --- Error transferring (.*) - server replied: (.*)$"
global error_pattern_ws := "^Voice WebSocket disconnected with code (\d+) and reason (.*)$"

global error_codes_ws := { "4001": "Unknown opcode", "4003": "Not authenticated", "4004": "Authentication failed", "4005": "Already authenticated", "4006": "Session no longer valid", "4009": "Session timeout", "4011": "Server not found", "4012": "Unknown protocol", "4014": "Disconnected (channel was deleted or you were kicked)", "4015": "Voice server crashed", "4016": "Unknown encryption mode" }
global texts := { "Waiting for server":0, "Opening WebSocket":0, "Connected":0, "Disconnected":0 }
global old_status := ""

global check_delay_s := 5000

lt_chat := new LogTailer(rc_dir . "ripcord.log", Func("OnNewLogLine"), true) ; , "CP1200")

global DB := New SQLiteDB
global db_connected := false
global SQL := "SELECT * FROM message WHERE UPPER(content) LIKE UPPER('%"
global sql_result := ""
global guisize_exec := 0

hook()
OnExit, ExitSub

#IfWinActive ahk_exe Ripcord.exe
^f::
    if (!db_connected) {
        if (!DB.OpenDB(rc_dir . rc_db, "R", false)) {
           MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
           ExitApp
        }
        db_connected := true
    }
    InputBox, UserInput, Search Message, , , 400, 100
    if (ErrorLevel) {
        return
    }
    _sql := SQL . UserInput . "%');"
    if (!DB.GetTable(_sql, sql_result)) {
        MsgBox, 16, SQLite Error: GetTable, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    } else {
       Gui, Destroy
       Gui, +Resize
       ; Gui, Add, Text, xm, % "RowCount: " . sql_result.RowCount
       ; Gui, Add, Text, xm, % "ColumnCount: " . sql_result.ColumnCount
       ; Gui, Add, Text, xm, % "sql: " . _sql
       columns := "|".Join(sql_result.ColumnNames)
       ; Gui, Add, Text, xm, % "Columns: " . columns
       Gui, Add, ListView, w500 h300 vMyListView Grid -ReadOnly, % columns
       GuiControl, -Redraw, MyListView
        For Each, Row In sql_result.Rows
            LV_Add("", Row*)
        ; Loop, % sql_result.ColumnCount {
            ; LV_ModifyCol(A_Index,100)
        ; }
        GuiControl, +Redraw, MyListView
        LV_ModifyCol()
        Gui, Show, AutoSize Center, % "Found " . sql_result.RowCount . " Messages for """ . UserInput . """"
    }

; DB.CloseDB()
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
            MsgBox, 0x10, % "Ripcord - " . error1 , % error2
            MsgBox, 0x10, % "rc", % error_codes_ws[error1]
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