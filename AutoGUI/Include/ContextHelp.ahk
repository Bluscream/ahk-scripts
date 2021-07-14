OpenHelpFile(Keyword := "") {
    If (Keyword == "" || StrLen(Keyword) > 50) {
        Run hh mk:@MSITStore:%g_HelpFile%::/docs/AutoHotkey.htm
        Return
    }

    n := TabEx.GetSel()
    If (Sci[n].GetCharAt(Sci[n].WordStartPosition(Sci[n].GetCurrentPos(), True) - 1) == 35) {
        Keyword := "_" . Keyword ; The keyword is a directive, but the "#" sign was not selected.
    }

    Keyword := StrReplace(Keyword, "#", "_",, 1) ; Replace # with _ in directives
    Keyword := Trim(Keyword, " `t.,:")

    Prefix := SubStr(Keyword, 1, 3)
    If (Prefix = "LV_" || Prefix = "IL_") {
        HTMLPage := "ListView.htm#" . Keyword

    } Else If (Prefix = "TV_") {
        HTMLPage := "TreeView.htm#" . Keyword

    } Else If (Prefix = "SB_") {
        HTMLPage := "GuiControls.htm#" . Keyword

    } Else If (Keyword = "StrPut" || Keyword = "StrGet") {
        HTMLPage := "StrPutGet.htm"

    } Else If (RegExMatch(Keyword, "i)Str(Len|Replace|Split)", Match)) {
        HTMLPage := "String" . Match1 . ".htm"

    } Else If (Keyword = "SendMessage") {
        HTMLPage := "PostMessage.htm"

    } Else If (Keyword = "RunWait") {
        HTMLPage := "Run.htm"

    } Else If (Keyword = "If") {
        HTMLPage := "IfExpression.htm"

    ; Gui events
    } Else If (Keyword ~= "i)^Gui(Close|Escape|Size|ContextMenu|DropFiles)$") {
        HTMLPage := "Gui.htm#" . Keyword

    ; Math functions
    } Else If (Keyword ~= "i)^(Abs|Ceil|Exp|Floor|Log|Ln|Mod|Round|Sqrt|Sin|Cos|Tan|ASin|ACos|ATan)$") {
        HTMLPage := "Math.htm#" . Keyword

    ; Object methods
    } Else If (Keyword ~= "i)^(Obj)?(InsertAt|RemoveAt|Push|Pop|Delete|MinIndex|MaxIndex|Length|SetCapacity|GetCapacity|GetAddress|NewEnum|HasKey|Clone|ObjRawSet|Count)$") {
        If (Keyword != "ObjRawSet") {
            Keyword := StrReplace(Keyword, "Obj")
        }

        If (Keyword = "MinIndex" || Keyword = "MaxIndex") {
            Keyword := "MinMaxIndex"
        }

        HTMLPage := "/docs/objects/Object.htm#" . Keyword

    } Else If (Keyword = "ObjRelease") {
        HTMLPage := "ObjAddRef.htm"

    ; GUI control types
    } Else If (Keyword ~= "i)^(Button|CheckBox|ComboBox|Custom|DateTime|DropDownList|GroupBox|Link|ListBox|MonthCal|Picture|Radio|Slider|StatusBar|Tab(2)?|Text|UpDown|ActiveX)$") {
        HTMLPage := "GuiControls.htm#" . Keyword

    } Else If (Keyword ~= "i)^(Hotkey|Progress|Edit)$") {
        CurLine := GetCurrentLine()
        If (RegExMatch(CurLine, "i)^\s*Gui")) {
            HTMLPage := "GuiControls.htm#" . Keyword
        } Else {
            HTMLPage := Keyword . ".htm"
        }
    } Else If (Keyword = "Tab3") {
        HTMLPage := "GuiControls.htm#Tab"

    } Else If (Keyword = "DDL") {
        HTMLPage := "GuiControls.htm#DropDownList"

    } Else If (Keyword = "Pic") {
        HTMLPage := "GuiControls.htm#Picture"

    ; Built-in variables
    } Else If (SubStr(Keyword, 1, 2) = "A_") {
        If (Keyword ~= "i)A_LoopFile") {
            HTMLPage := "LoopFile.htm"
        } Else If (Keyword ~= "i)A_LoopReg") {
            HTMLPage := "LoopReg.htm"
        } Else If (Keyword = "A_LoopField") {
            HTMLPage := "LoopParse.htm"
        } Else If (Keyword = "A_LoopReadLine") {
            HTMLPage := "LoopReadFile.htm"
        } Else {
            HTMLPage := "/docs/Variables.htm#BuiltIn"
        }

    } Else If (Keyword = "True" || Keyword = "False") {
        HTMLPage := "Variables.htm#Boolean"

    } Else If (Keyword = "IfNotExist") {
        HTMLPage := "IfExist.htm"

    } Else If (Keyword ~= "i)_IfWin(Not)?(Active|Exist)") {
        HTMLPage := "_IfWinActive.htm"

    } Else If (Keyword ~= "i)(If)?Win(Not)?Exist") {
        HTMLPage := "WinExist.htm"

    } Else If (Keyword ~= "i)(If)?Win(Not)?Active") {
        HTMLPage := "WinActive.htm"

    } Else If (Keyword ~= "i)GetKey(Name|VK|SC)") {
        HTMLPage := "GetKey.htm"

    ; Function object methods
    } Else If (Keyword ~= "i)^(Call|Bind|Name|IsBuiltIn|IsVariadic|MinParams|MaxParams|IsByRef|IsOptional)$") {
        HTMLPage := "/docs/objects/Func.htm"

    } Else If (Keyword = "HICON" || Keyword = "HBITMAP") {
        HTMLPage := "/docs/misc/ImageHandles.htm"

    } Else If (Keyword ~= "i)^(Clipboard|WinTitle|Arrays|ErrorLevel|Labels|Styles|Threads)$") {
        HTMLPage := "/docs/misc/" . Keyword . ".htm"

    } Else If (Keyword = "ClipboardAll") {
        HTMLPage := "/docs/misc/Clipboard.htm#ClipboardAll"

    } Else If (Keyword ~= "i)^(Object|Func|File)$") {
        HTMLPage := "/docs/objects/" . Keyword . ".htm"

    } Else If (Keyword = "StringTrimRight") {
        HTMLPage := "StringTrimLeft.htm"

    } Else If (Keyword = "_IncludeAgain") {
        HTMLPage := "_Include.htm"

    } Else If (RegExMatch(Keyword, "i)(Join|LTrim)", Match)) {
        HTMLPage := "/docs/Scripts.htm#" . Match1

    } Else If (Keyword ~= "i)^(Functions|Objects|FAQ|Hotkeys|Hotstrings|KeyList|Scripts|Tutorial|Variables)$") {
        HTMLPage := "/docs/" . Keyword . ".htm"

    } Else {
        HTMLPage := Keyword . ".htm"
    }

    If (!InStr(HTMLPage, "/")) {
        HTMLPage := "/docs/commands/" . HTMLPage
    }

    Run hh mk:@MSITStore:%g_HelpFile%::%HTMLPage%
}
