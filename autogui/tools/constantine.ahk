﻿#SingleInstance Force
#NoEnv
#NoTrayIcon
SetBatchLines -1
SetWorkingDir %A_ScriptDir%

#Include %A_ScriptDir%\..\Lib\AutoXYWH.ahk

Global Title := "Constantine - Windows API Constants Explorer"
, Version   := "1.1.1"
, Filename  := "Windows.xml"
, IconLib   := A_ScriptDir . "\..\Icons\Constantine.icl"
, NT6       := DllCall("GetVersion") & 0xFF > 5
, Grid      := False
, Theme     := True
, GroupView := (NT6) ? True : False
, TVFocus   := False
, XMLItems  := []
, Expand    := []
, Sorting   := [0, "Sort"]
, hCursor   := DllCall("LoadCursor", "Ptr", 0, "Ptr", 32644, "Ptr")
, IniFile
, hMainWnd := 0
, hTV := 0
, hLV := 0

If (FileExist(A_AppData . "\AutoGUI\Constantine.ini")) {
    IniFile := A_AppData . "\AutoGUI\Constantine.ini"
} Else {
    IniFile := A_ScriptDir . "\Constantine.ini"
}

Menu Tray, Icon, %IconLib%

Menu FileMenu, Add, &Open...`tCtrl+O, Open
Menu FileMenu, Add, &Reload`tCtrl+R, Reload
Menu FileMenu, Add
Menu FileMenu, Add, &Save...`tCtrl+S, Save
Menu FileMenu, Add
Menu FileMenu, Add, E&xit`tAlt+Q, GuiClose

Menu EditMenu, Add, &Copy`tCtrl+C, Copy
Menu EditMenu, Add
Menu EditMenu, Add, Select &All`tCtrl+A, SelectAll

    Menu SortByMenu, Add, &Name, SortBy, Radio
    Menu SortByMenu, Add, &Value, SortBy, Radio
    Menu SortByMenu, Add
    Menu SortByMenu, Add, &Ascending, SortBy, Radio
    Menu SortByMenu, Add, &Descending, SortBy, Radio
    Menu SortByMenu, Add
    Menu SortByMenu, Add, &Unsorted, SortBy, Radio
    Menu SortByMenu, Check, &Unsorted
Menu ViewMenu, Add, Sort By, :SortByMenu
Menu ViewMenu, Add
Menu ViewMenu, Add, Group &View, ToggleGroupView
Menu ViewMenu, Add, Explorer &Theme, ToggleTheme
Menu ViewMenu, Add, Show &Grid, ToggleGrid

If (NT6) {
    Menu ViewMenu, Check, Group &View
    Menu ViewMenu, Check, Explorer &Theme
} Else {
    Menu ViewMenu, Disable, Group &View
    Menu ViewMenu, Disable, Explorer &Theme
}

Menu HelpMenu, Add, &About, About

Menu MenuBar, Add, &File, :FileMenu
Menu MenuBar, Add, &Edit, :EditMenu
Menu MenuBar, Add, &View, :ViewMenu
Menu MenuBar, Add, &Help, :HelpMenu

ImgLst := IL_Create(8)
IL_Add(ImgLst, IconLib, 2) ; Icon1: Windows logo (root)
IL_Add(ImgLst, IconLib, 3) ; Icon2: folder
IL_Add(ImgLst, IconLib, 4) ; Icon3: styles
IL_Add(ImgLst, IconLib, 5) ; Icon4: messages
IL_Add(ImgLst, IconLib, 6) ; Icon5: notifications
IL_Add(ImgLst, IconLib, 7) ; Icon6: window messages/notifications
IL_Add(ImgLst, IconLib, 8) ; Icon7: generic icon (gear)

Gui +Resize hWndhMainWnd
Gui Menu, MenuBar
Gui Font, s9, Segoe UI

Gui Add, TreeView, hWndhTV gTreeViewHandler ImageList%ImgLst% x0 y0 w190 h506
SendMessage 0x112C, 0, 0x24,, ahk_id %hTV% ; TVM_SETEXTENDEDSTYLE (autoscroll and double buffer)

Gui Add, ListView, hWndhLV vLV x194 y0 h506 w369 LV0x14000, Constant|Value
    LV_ModifyCol(1, 250)
    LV_ModifyCol(2, "95 Integer Left")
    LV_SetImageList(ImgLst, 1)

Gui Add, Text, hWndhSeparator x0 y505 w568 h2 0x10
Gui Add, Progress, hWndhFooter x-1 y506 w565 h48 BackgroundF1F5FB +0x4000000 +E0x4 Disabled
Gui Add, Picture, hWndhPicSearch gSearch x198 y513 w16 h16 Icon10, %IconLib%
Gui Add, Edit, hWndhEdtSearch vKeyword gSearch x218 y512 w200 h21
DllCall("SendMessage", "Ptr", hEdtSearch, "UInt", 0x1501, "Ptr", 1, "WStr", "Search", "Ptr") ; Hint text

Gui Show, w563 h542 Hide, %Title%

Load:
o := ComObjCreate("MSXML2.DOMDocument.6.0")
o.async := False
o.load(Filename)

RootNode := o.selectSingleNode("/dir")

If !(RootName := RootNode.getAttribute("name")) {
    RootName := "Constants"
}

All := TV_Add(RootName, "", "Icon1")
RootNode.setAttribute("ID", 0)
XMLItems[All] := 0
LoadTreeView(RootNode.childNodes, All, "/dir/")

TV_Modify(All, "+Expand")
If (Expand.Length()) {
    For Each, Item in Expand {
        TV_Modify(Item, "+Expand")
    }
}

; Command line parameters
Key := ""
Find := ""
Loop %0% {
    Param := %A_Index%
    If (Param = "/key") {
        Key := % A_Index + 1
        Key := %Key%
    } Else If (Param = "/find") {
        Find := % A_Index + 1
        Find := %Find%
    }
}

If (Key == "" && Find == "") {
    IniRead Key, %IniFile%, Options, LastKey
}

If (Key != "") {
    JumpToKey(Key)
}

If (Find != "") {
    GuiControl,, %hEdtSearch%, %Find%
}

If (FileExist(IniFile)) {
    IniRead X, %IniFile%, Position, X
    IniRead Y, %IniFile%, Position, Y
    IniRead W, %IniFile%, Position, Width
    IniRead H, %IniFile%, Position, Height
    IniRead State, %IniFile%, Position, State, 1

    SetWindowPlacement(hMainWnd, X, Y, W, H, State)
}

Gui Show

GuiControl Focus, %hEdtSearch%

If (NT6) {
    SetExplorerTheme(hTV)
    SetExplorerTheme(hLV)
}

OnMessage(0x200, "OnWM_MOUSEMOVE")
OnMessage(0x20,  "OnWM_SETCURSOR")
OnMessage(0x16,  "SaveSettings") ; WM_ENDSESSION
Return

LoadTreeView(Nodes, TVParentID, XMLPath) {
    Global
    Static Counter := 0

    For Node in Nodes {
        If (Node.baseName == "item") {
            Continue
        }

        Counter++

        Node.setAttribute("ID", Counter)

        NodeName := Node.getAttribute("name")
        If (NodeName == "") {
            NodeName := "Constants"
        }

        If !(Desc := Node.getAttribute("desc")) {
            Desc := NodeName
        }
        
        LV_InsertGroup(hLV, Counter, Desc)

        Attrib := Node.getAttribute("attrib")

        ; Hidden nodes
        If (InStr(Attrib, "h", 1)) {
            TVItemID := -1
        } Else {
            TVItemID := TV_Add(NodeName, TVParentID, "Icon2")
        }

        ; Initially expanded nodes
        If (InStr(Attrib, "x")) {
            Expand.Push(TVItemID)
        }

        Path := XMLPath . Node.baseName

        XMLItems[TVItemID] := Counter

        If (Node.hasChildNodes) {
            LoadTreeView(Node.childNodes, TVItemID, Path . "/")
        }
    }
}

TreeViewHandler:
    If (!TVFocus) {
        TVFocus := True
        Return
    }

    TVItemId := TV_GetSelection()
    Node     := o.selectSingleNode("//dir[@ID=""" . XMLItems[TVItemID] . """]")
    Items    := Node.getElementsByTagName("item")

    TV_GetText(ItemText, TVItemId)

    GuiControl -Redraw, SysListView321
    LV_Delete()
    For Item in Items {
        Const := Item.getAttribute("const")

        LV_Add(GetIcon(Item), Const, Item.getAttribute("value"))

        GroupID := Item.parentNode.getAttribute("ID")
        If (GroupID) {
            LV_SetGroup(hLV, A_Index, GroupID)
        }

    }
    GuiControl +Redraw, SysListView321

    If (Sorting[1]) {
        SortBy(Sorting)
    }

    SendMessage 0x109D, %GroupView%, 0,, ahk_id %hLV% ; LVM_ENABLEGROUPVIEW
Return

Search:
    Gui Submit, NoHide

    If (!TVItemId := TV_GetSelection()) {
        Return
    }

    Node  := o.selectSingleNode("//dir[@ID=""" . XMLItems[TVItemID] . """]")
    Items := Node.getElementsByTagName("item")

    If (Keyword == "0x") {
        Return
    }

    If Keyword is Integer
    {
        Keyword += 0
        Int := True
    } Else {
        Int := False
    }

    GuiControl -Redraw, SysListView321
    LV_Delete()
    Row := 0

    For Item in Items {
        Const := Item.getAttribute("const")
        Value := Item.getAttribute("value")

        If (Int && (Keyword == (Value + 0))) {
            Row := LV_Add(GetIcon(Item), Const, Value)
        } Else If (RegExMatch(Const, "i)" . Keyword)) {
            Row := LV_Add(GetIcon(Item), Const, Value)
        } Else {
            Row := 0
        }

        If (Row && GroupID := Item.parentNode.getAttribute("ID")) {
            LV_SetGroup(hLV, Row, GroupID)
        }
    }

    GuiControl +Redraw, SysListView321

    If (Sorting[1]) {
        SortBy(Sorting)
    }

    SendMessage 0x109D, %GroupView%, 0,, ahk_id %hLV% ; LVM_ENABLEGROUPVIEW
Return

GetIcon(Item) {
    Type := Item.parentNode.getAttribute("type")
    If (Type == "") {
        Name := Item.parentNode.getAttribute("name")
        If (Name == "Messages") {
            Type := 1
        } Else If (Name == "Notifications") {
            Type := 2
        } Else If (Name == "Styles" || Name == "ExStyles") {
            Type := 4
        } Else {
            Type := 0
        }
    }

    If (Type == 0) {
        Icon := "Icon7"
    } Else If (Type == 1) { ; Messages
        Icon := "Icon4"
    } Else If (Type == 2) { ; Notifications
        Icon := "Icon5"
    } Else If (Type == 3) { ; Message/notification
        Icon := "Icon6"
    } Else If (Type == 4) { ; Styles
        Icon := "Icon3"
    } Else {
        Icon := "Icon7"
    }

    Return Icon
}

GuiContextMenu:
    If (A_GuiControl != "LV" || !(Row := LV_GetNext())) {
        Return
    }

    LV_GetText(Const, Row)
    LV_GetText(Value, Row, 2)
    Count := LV_GetCount("Selected")
    g_Prefix := StrSplit(Const, "_")[1] . "_"
    Uniform := IsUniformType(g_Prefix)

    Try {
        Menu ContextMenu, DeleteAll
    }

    Menu ContextMenu, Add, Copy As Variable, Copy

    If (IsMessage()) {
        Menu ContextMenu, Add, Copy For SendMessage, Copy
        If (Uniform && g_Prefix == "WM_") {
            Menu ContextMenu, Add, Copy For OnMessage, Copy        
        }
    } Else If (Count > 1 && Uniform) {
        Menu ContextMenu, Add, Copy Sum of Values, Sum
    }
    Menu ContextMenu, Add
    Menu ContextMenu, Add, Google %Const%, GoogleSearch
    Menu ContextMenu, Show, %A_GuiX%, %A_GuiY%
Return

SelectAll:
    Gui +LastFound
    ControlGetFocus Focus
    If (Focus == "Edit1") {
        Send ^A
        Return
    }

    ControlFocus, SysListView321
    LV_Modify(0, "Select")
Return

Copy:
    ControlGetFocus Focus, ahk_id %hMainWnd%
    If (Focus == "Edit1") {
        Send ^C
        Return
    }

    Row := 0, Output := "", Messages := []

    While (Row := LV_GetNext(Row)) {
        LV_GetText(Const, Row)
        LV_GetText(Value, Row, 2)

        ; Remove leading zeros from hex value
        If (InStr(Value, "0x0")) {
            SetFormat Integer, Hex
            Value |= 0
        }

        If (A_ThisMenuItem == "Copy For SendMessage") {
            Output .= "SendMessage " . Value . ", wParam, lParam,, ahk_id %hWnd% `; " . Const . "`n"
        } Else If (A_ThisMenuItem == "Copy For OnMessage") {
            Output .= "OnMessage(" . Value . ", ""On" . Const . """)`n"
            Messages.Push(Const)
        } Else {
            If (GetKeyState("Shift", "P")) {
                Output .= Const . "`n"
            } Else {
                Output .= Const . " := " . Value . "`n"
            }
        }
    }

    Loop % Messages.Length() {
        Output .= "`nOn" . Messages[A_Index] . "(wParam, lParam, msg, hWnd) {`n`n}`n"
    }

    Clipboard := RTrim(Output, "`n")
Return

Sum:
    SetFormat Integer, Hex
    
    Row := 0
    Sum := 0
    While (Row := LV_GetNext(Row)) {
        LV_GetText(Value, Row, 2)
        Sum += Value
    }

    Clipboard := Sum
Return

GoogleSearch:
    LV_GetText(Const, LV_GetNext())
    Try {
        Run https://www.google.com/#q=%Const%&btnI
    }
Return

IsMessage() {
    Static Const, Value, Row, RegEx := "^(WM|BM|BCM|CBEM|DTM|EM|HDM|HKM|LM|LVM|MCM|PBM|RB|SBM|TBM|STM|TCM|TB|TTM|TVM|UDM|CCM|TDM)_"

    TV_GetText(Category, TV_GetSelection())
    If (Category == "Messages") {
        Return True    
    }

    Row := 0
    While (Row := LV_GetNext(Row)) {
        LV_GetText(Const, Row)
        LV_GetText(Value, Row, 2)
        s := SubStr(Const, 1, 3)
        If (RegExMatch(Const, RegEx, Match)
        || (s == "SB_" && Value > 0x400)
        || ((s == "CB_" || s == "LB_") && (!Const ~= "(OKAY|ERR|ERRSPACE)$"))) {
            Continue
        } Else {
            Return False
        }
    }

    Return True
}

IsUniformType(Prefix) {
    Local Row, Const

    Row := 0
    While (Row := LV_GetNext(Row)) {
        LV_GetText(Const, Row)
        If (SubStr(Const, 1, InStr(Const, "_")) != Prefix) {
            Return False
        }
    }

    Return True
}

Open:
    FileSelectFile Filename, 3, %A_ScriptDir%,, XML Files (*.xml)
    If (ErrorLevel) {
        Return
    }
Reload:
    TV_Delete()
    LV_Delete()
    GoSub Load
    GuiControl Focus, %hTV%
Return

Save:
    FileSelectFile SelectedFile, S16, Constants.ahk, Save, AutoHotkey Scripts (*.ahk)
    If (ErrorLevel) {
        Return
    }

    Output := ""
    Loop % LV_GetCount() {
        LV_GetText(Const, A_Index)
        LV_GetText(Value, A_Index, 2)
        Output .= Const . " := " . Value . "`n"
    }

    FileDelete %SelectedFile%
    FileAppend %Output%, %SelectedFile%
Return

About:
    DllCall("PrivateExtractIcons"
        , "Str"  , IconLib
        , "Int" , 0
        , "Int" , 32, "Int", 32
        , "Ptr*", hIcon := 0
        , "UInt" , 0, "UInt", 1, "UInt", 0)
    DllCall("shell32.dll\ShellAbout"
        , "Ptr", hMainWnd
        , "Str", "Constantine"
        , "Str", Title . " v" . Version . "`n"
        . o.getElementsByTagName("item").length . " constants."
        , "Ptr", hIcon)
Return

GuiSize:
    If (A_EventInfo == 1) {
        Return
    }

    AutoXYWH("h*" , hTV)
    ;AutoXYWH("wh*", hLV)
    AutoXYWH("yw*", hSeparator, hFooter)
    AutoXYWH("y*" , hPicSearch, hEdtSearch)

    GuiControlGet TVPos, Pos, %hTV%
    GuiControl Move, %hLV%, % "w" . (A_GuiWidth - (TVPosW + 4)) . " h" . TVPosH
Return

GuiEscape:
    Gui Submit, NoHide
    If (Keyword != "") {
        GuiControl,, %hEdtSearch%
        Return
    }
Return

GuiClose:
    SaveSettings()
    ExitApp

ToggleGrid:
    Menu ViewMenu, ToggleCheck, %A_ThisMenuItem%
    Grid := !Grid
    if (Grid) {
        GuiControl, +Grid, SysListView321
    } else {
        GuiControl, -Grid, SysListView321
    }
Return

ToggleTheme:
    Menu ViewMenu, ToggleCheck, %A_ThisMenuItem%

    If (Theme := !Theme) {
        String := "Explorer"
        Gui Font, s9, Segoe UI
    } Else {
        String := ""
        Gui Font, s8, Ms Shell Dlg 2
    }

    SetExplorerTheme(hTV, String)
    SetExplorerTheme(hLV, String)
    GuiControl Font, SysTreeView321
    GuiControl Font, SysListView321
Return

OnWM_MOUSEMOVE(wParam, lParam, msg, hWnd) {
    Global hFooter, hLV
    Static PrevX := -1, x2 := -1

    If (hWnd == hMainWnd) {
        CoordMode Mouse, Client
        MouseGetPos x1

        GuiControlGet lv, Pos, %hLV%
        GuiControlGet tv, Pos, %hTV%
        TVOffset := x1 - tvw

        While (GetKeyState("LButton", "P")) {
            MouseGetPos x2
            If (x2 == PrevX) {
                Continue
            }
            PrevX := x2

            x := lvx + (x2 - x1)
            w := lvw + (x1 - PrevX)
            GuiControl Move, %hLV%, % "x" . x . " w" . w
            GuiControl Move, %hTV%, % "w" . x2 - TVOffset
            Sleep 1
        }

        If (x2 == x1) {
            Return
        }
    }
}

OnWM_SETCURSOR(wParam, lParam, msg, hWnd) {
    CoordMode Mouse, Client
    MouseGetPos x, y
    GuiControlGet tv, Pos, %hTV%
    GuiControlGet lv, Pos, %hLV%

    If (x > (tvx + tvw) && (x < lvx) && (y < (tvy + tvh))) {
        DllCall("SetCursor", "Ptr", hCursor)
        Return True
    }
}

SetExplorerTheme(hWnd, e := "Explorer") {
    Return DllCall("UxTheme.dll\SetWindowTheme", "Ptr", hWnd, "WStr", e, "Ptr", 0)
}

SortBy:
    Menu SortByMenu, Uncheck, &Unsorted

    If (A_ThisMenuItem == "&Name") {
        Sorting[1] := 1
        Menu SortByMenu, Uncheck, &Value
    } Else If (A_ThisMenuItem == "&Value") {
        Sorting[1] := 2
        Menu SortByMenu, Uncheck, &Name
    } Else If (A_ThisMenuItem == "&Ascending") {
        Sorting[2] := "Sort"
        Menu SortByMenu, Uncheck, &Descending
    } Else If (A_ThisMenuItem == "&Descending") {
        Sorting[2] := "SortDesc Logical"
        Menu SortByMenu, Uncheck, &Ascending
    } Else {
        Menu SortByMenu, Uncheck, &Name
        Menu SortByMenu, Uncheck, &Value
        Menu SortByMenu, Uncheck, &Ascending
        Menu SortByMenu, Uncheck, &Descending
        Menu SortByMenu, Check, %A_ThisMenuItemPos%&
        Sorting := [0, "Sort"]
        GoSub TreeViewHandler
        GoSub Search
        Return
    }

    If (Sorting[1] == 0) {
        Sorting[1] := 2 ; Value
    }

    Menu SortByMenu, Check, %A_ThisMenuItemPos%&
    SortBy(Sorting)
Return

SortBy(Param) {
    LV_ModifyCol(Param[1], Param[2])
}

; Based on functions from LV_EX written by just_me
LV_InsertGroup(hLV, GroupID, Header, Index := -1) {
    Static iGroupId := (A_PtrSize == 8) ? 36 : 24
    NumPut(VarSetCapacity(LVGROUP, 56, 0), LVGROUP, 0)
    NumPut(0x15, LVGROUP, 4, "UInt") ; mask: LVGF_HEADER|LVGF_STATE|LVGF_GROUPID
    NumPut((A_IsUnicode) ? &Header : UTF16(Header, @), LVGROUP, 8, "Ptr") ; pszHeader
    NumPut(GroupID, LVGROUP, iGroupId, "Int") ; iGroupId
    NumPut(0x8, LVGROUP, iGroupId + 8, "Int") ; state: LVGS_COLLAPSIBLE
    SendMessage 0x1091, %Index%, % &LVGROUP,, ahk_id %hLV% ; LVM_INSERTGROUP
    Return ErrorLevel
}

LV_SetGroup(hLV, Row, GroupID) {
    Static iGroupId := (A_PtrSize == 8) ? 52 : 40
    VarSetCapacity(LVITEM, 58, 0)
    NumPut(0x100, LVITEM, 0, "UInt")  ; mask: LVIF_GROUPID
    NumPut(Row - 1, LVITEM, 4, "Int") ; iItem
    NumPut(GroupID, LVITEM, iGroupId, "Int")
    SendMessage 0x1006, 0, &LVITEM,, ahk_id %HLV% ; LVM_SETITEMA
    Return ErrorLevel
}

ToggleGroupView:
    GroupView := !GroupView
    SendMessage 0x109D, %GroupView%, 0,, ahk_id %hLV% ; LVM_ENABLEGROUPVIEW
    Menu ViewMenu, ToggleCheck, Group &View
Return

UTF16(String, ByRef Var) {
    VarSetCapacity(Var, StrPut(String, "UTF-16") * 2, 0)
    StrPut(String, &Var, "UTF-16")
    Return &Var
}

JumpToKey(KeyPath, KeyName := "", ItemID := 0) {
    Static aPath := [], Index := 1

    If (!aPath.Length()) {
        aPath := StrSplit(KeyPath, "\")
        If (!aPath.Length()) {
            Return
        }
    }

    If (KeyName == "") {
        KeyName := aPath[1]
    }

    Loop {
        TV_GetText(ItemText, ItemID)

        If (ItemText == KeyName) {
            Index++

            ChildID := TV_GetChild(ItemID)

            If (!ChildID || Index > aPath.Length()) {
                TV_Modify(TV_GetParent(ItemID), "+Expand")
                TV_Modify(ItemID, "+Select")
                GoSub Search
                Return
            }

            JumpToKey(KeyPath, aPath[Index], ChildID)
        }

        ItemID := TV_GetNext(ItemID)
        If (!ItemID) {
            Break
        }
    }
}

SaveSettings() {
    If (!FileExist(IniFile)) {
        Sections := "[Options]`n`n[Position]`n"
        FileAppend %Sections%, %IniFile%, UTF-16
        If (ErrorLevel) {
            FileCreateDir %A_AppData%\AutoGUI
            IniFile := A_AppData . "\AutoGUI\Constantine.ini"
            FileDelete %IniFile%
            FileAppend %Sections%, %IniFile%, UTF-16
        }
    }

    IniWrite AutoHotkey, %IniFile%, Options, Language

    ItemID := TV_GetSelection()
    KeyPath := ""
    Loop {
        TV_GetText(ItemText, ItemID)
        KeyPath := ItemText  . "\" . KeyPath
        ItemID := TV_GetParent(ItemID)
        If (!ItemID) {
            Break
        }
    }

    KeyPath := RTrim(KeyPath, "\")
    IniWrite %KeyPath%, %IniFile%, Options, LastKey

    Pos := GetWindowPlacement(hMainWnd)
    IniWrite % Pos.x, %IniFile%, Position, X
    IniWrite % Pos.y, %IniFile%, Position, Y
    IniWrite % Pos.w, %IniFile%, Position, Width
    IniWrite % Pos.h, %IniFile%, Position, Height
    State := Pos.showCmd == 2 ? 1 : Pos.showCmd
    IniWrite %State%, %IniFile%, Position, State
}

GetWindowPlacement(hWnd) {
    NumPut(VarSetCapacity(WINDOWPLACEMENT, 44, 0), WINDOWPLACEMENT, 0, "UInt")
    DllCall("GetWindowPlacement", "Ptr", hWnd, "Ptr", &WINDOWPLACEMENT)
    Result := {}
    Result.x := NumGet(WINDOWPLACEMENT, 28, "Int")
    Result.y := NumGet(WINDOWPLACEMENT, 32, "Int")
    Result.w := NumGet(WINDOWPLACEMENT, 36, "Int") - Result.x
    Result.h := NumGet(WINDOWPLACEMENT, 40, "Int") - Result.y
    Result.showCmd := NumGet(WINDOWPLACEMENT, 8, "UInt") ; 1 = normal, 2 = minimized, 3 = maximized
    Return Result
}

SetWindowPlacement(hWnd, x, y, w, h, showCmd) {
    NumPut(VarSetCapacity(WINDOWPLACEMENT, 44, 0), WINDOWPLACEMENT, 0, "UInt")
    NumPut(x, WINDOWPLACEMENT, 28, "Int")
    NumPut(y, WINDOWPLACEMENT, 32, "Int")
    NumPut(w + x, WINDOWPLACEMENT, 36, "Int")
    NumPut(h + y, WINDOWPLACEMENT, 40, "Int")
    NumPut(showCmd, WINDOWPLACEMENT, 8, "UInt")
    Return DllCall("SetWindowPlacement", "Ptr", hWnd, "Ptr", &WINDOWPLACEMENT)
}
