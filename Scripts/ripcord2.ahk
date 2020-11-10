#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

#Include <bluscream>
#Include <Class_SQLiteDB>

dir := new Paths.User().localappdata.combine("ripcord")
exe := dir.combineFile("Ripcord.exe")
Menu Tray, Icon, % exe.path
global dbfile := dir.combineFile("discord_client.ripdb")

global DB := New SQLiteDB
global MSG_SQL := "SELECT user.name AS Author, guild.name AS Server, guild_channel.name AS Channel, message.content AS Message, message.id AS Timestamp FROM message JOIN guild_channel ON message.channel_id = guild_channel.id JOIN guild ON guild_channel.id = guild.id JOIN user ON message.author_id = user.id WHERE UPPER(message.content) LIKE UPPER('%${SEARCH}%');"
global USR_SQL := "SELECT user.id, user.name FROM user"
global ROLE_SQL := "SELECT role.id, role.name from role WHERE role.mentionable == 1"
global User_Map := ComObjCreate("Scripting.Dictionary")
global Role_Map := ComObjCreate("Scripting.Dictionary")
global Result := ""
global Users := ""
global Roles := ""
if (!DB.OpenDB(dbfile.path)) {
   MsgBox, 16, SQLite Error, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
   ExitApp
}


#IfWinActive ahk_exe Ripcord.exe
^f::
    InputBox, UserInput, Search Message, , , 400, 100
    if (ErrorLevel) {
        return
    }
    ; sanitize SQL query
    _msg_sql := StrReplace(MSG_SQL, "${SEARCH}", StrReplace(UserInput, "'", "''"))
    
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

       ; Gui, Add, Text, xm, % "RowCount: " . Result.RowCount
       ; Gui, Add, Text, xm, % "ColumnCount: " . Result.ColumnCount
       ; Gui, Add, Text, xm, % "sql: " . _sql
       columns := "|".Join(Result.ColumnNames)
       ; Gui, Add, Text, xm, % "Columns: " . columns
       Gui, Add, ListView, w500 h300 vMyListView Grid -ReadOnly, % columns
       GuiControl, -Redraw, MyListView
        For Each, Row In Result.Rows {
            
            ; string replacement for usernames
            While( RegExMatch(Row[4], "\<\@.*\>" ) ) {
                    ; get start & end positions
                    StartPos := InStr( Row[4], "<@" ) + 2
                    EndPos := InStr( Row[4], ">", false, StartPos )
                    
                    ; if special mention (owner / role ), adjust start pos + add special char
                    Exclamation := ( ( RegExMatch(Row[4], "\<\@(!|&).*\>" ) ) ? SubStr( Row[4], StartPos++, 1 ) : "" )
                    
                    ; put it all together to get the string to replace, and the replacement string
                    Mention := SubStr( Row[4], StartPos, EndPos - StartPos )
                    ReplaceMe := "<@" . Exclamation . Mention . ">"                  

                    ; replace mention with either the user name or the role name
                    Replacement := "@" . ( ( User_Map.Exists( Mention ) ) ?  User_Map.Item[ Mention ] : Role_Map.Item[ Mention ] )
                    
                    ; do the replacement
                    Row[4] := StrReplace( Row[4], ReplaceMe, Replacement )
            }
            
            ; convert message id to timestamp
            MsgUTC := 1970
            Epoch := Floor( ( ( Format("{:d}", Row[5] ) >> 22 ) + 1420070400000 ) / 1000 )
            EnvAdd MsgUTC, Epoch, Seconds
            
            ; format the timestamp
            FormatTime, MsgUTC, %MsgUTC%, yyyy-MM-dd HH:mm
            Row[5] := MsgUTC
            
            LV_Add("", Row*)
        }
        GuiControl, +Redraw, MyListView
        LV_ModifyCol()
        Gui, Show, AutoSize Center, % "Found " . Result.RowCount . " Messages for """ . UserInput . """"
    }

global exec := 0
GuiSize:
    if (A_EventInfo = 1) {
        return
    }
    if (exec < 3) {
        exec++
        return
    }
    GuiControl, Move, MyListView, % "w" . (A_GuiWidth - 20) . " h" . (A_GuiHeight - 20)
    return

; DB.CloseDB()
Return