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
global SQL := "SELECT * FROM message WHERE UPPER(content) LIKE UPPER('%"
global Result := ""
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
    _sql := SQL . UserInput . "%');"
    if (!DB.GetTable(_sql, Result)) {
        MsgBox, 16, SQLite Error: GetTable, % "Msg:`t" . DB.ErrorMsg . "`nCode:`t" . DB.ErrorCode
    } else {
       Gui, Destroy
       Gui, +Resize
       ; Gui, Add, Text, xm, % "RowCount: " . Result.RowCount
       ; Gui, Add, Text, xm, % "ColumnCount: " . Result.ColumnCount
       ; Gui, Add, Text, xm, % "sql: " . _sql
       columns := "|".Join(Result.ColumnNames)
       ; Gui, Add, Text, xm, % "Columns: " . columns
       Gui, Add, ListView, w500 h300 vMyListView Grid -ReadOnly, % columns
       GuiControl, -Redraw, MyListView
        For Each, Row In Result.Rows
            LV_Add("", Row*)
        ; Loop, % Result.ColumnCount {
            ; LV_ModifyCol(A_Index,100)
        ; }
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