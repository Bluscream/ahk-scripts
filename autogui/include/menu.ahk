﻿; File Menu
;AddMenu("AutoFileMenu", "&New File`tCtrl+N", "NewTab", IconLib, 7)
AddMenu("AutoFileMenu", "New From &Template`tCtrl+T", "NewFromTemplate", IconLib, 100)
AddMenu("AutoFileMenu", "Script &Directives...`tCtrl+P", "ScriptDirectives", IconLib, 2)
Menu AutoFileMenu, Add
AddMenu("AutoFileMenu", "New &GUI`tAlt+G", "NewGUI", IconLib, 6)
AddMenu("AutoFileMenu", "&Import GUI...`tCtrl+I", "ImportGUI", IconLib, 40)
Menu AutoFileMenu, Add
AddMenu("AutoFileMenu", "&Open File...`tCtrl+O", "Open", IconLib, 9)
AddMenu("AutoFileMenu", "Open Included File...", "ShowIncludesDialog", IconLib, 101)
Menu AutoFileMenu, Add
AddMenu("AutoFileMenu", "Recent &Files",, IconLib, 42)
Menu AutoFileMenu, Disable, Recent &Files
Menu AutoFileMenu, Add
AddMenu("AutoFileMenu", "&Save`tCtrl+S", "Save", IconLib, 10)
Menu AutoFileMenu, Add, Save &As...`tCtrl+Shift+S, SaveAs
AddMenu("AutoFileMenu", "Save All", "SaveAll", IconLib, 125)
Menu AutoFileMenu, Add, Save a Copy As..., SaveCopy
Menu AutoFileMenu, Add
AddMenu("AutoFileMenu", "&Load Session",, IconLib, 102)
Menu AutoFileMenu, Add, Save Session..., SaveSession
Menu AutoFileMenu, Add
AddMenu("AutoFileMenu", "&Close File`tCtrl+W", "CloseTab", IconLib, 8)
Menu AutoFileMenu, Add, Close All Files, CloseAllTabs
Menu AutoFileMenu, Add
AddMenu("AutoFileMenu", "Convert to &Executable...", "Compile", IconLib, 13)
Menu AutoFileMenu, Add
Menu AutoFileMenu, Add, E&xit`tAlt+Q, AutoClose

; Edit Menu
;Menu AutoEditMenu, Add, &Undo`tCtrl+Z, Undo
Menu AutoEditMenu, Add, R&edo`tCtrl+Y, Redo
Menu AutoEditMenu, Add
Menu AutoEditMenu, Add, Cu&t`tCtrl+X, Cut
Menu AutoEditMenu, Add, &Copy`tCtrl+C, Copy
Menu AutoEditMenu, Add, &Paste`tCtrl+V, Paste
Menu AutoEditMenu, Add, &Delete`tDel, Clear
Menu AutoEditMenu, Add, Select &All`tCtrl+A, SelectAll
Menu AutoEditMenu, Add
Menu AutoEditMenu, Add, Duplicate Line`tCtrl+Down, DuplicateLine
Menu AutoEditMenu, Add, Move Line Up`tCtrl+Shift+Up, MoveLineUp
Menu AutoEditMenu, Add, Move Line Down`tCtrl+Shift+Down, MoveLineDown
Menu AutoEditMenu, Add
Menu AutoEditMenu, Add, Autocomplete Keyword`tCtrl+Enter, M_AutoComplete
Menu AutoEditMenu, Add, Show Calltip`tCtrl+Space, M_ShowCalltip
Menu AutoEditMenu, Add, Insert Parameters`tCtrl+Insert, M_InsertParameters
Menu AutoEditMenu, Add
Menu AutoEditMenu, Add, &Insert Date and Time`tCtrl+D, InsertDateTime
Menu AutoEditMenu, Add
Menu AutoEditMenu, Add, Set as &Read-Only, ToggleReadOnly

; Search Menu
;Menu AutoSearchMenu, Add, &Find...`tCtrl+F, ShowFindDialog
Menu AutoSearchMenu, Add, Find &Next`tF3, FindNext
Menu AutoSearchMenu, Add, Find &Previous`tShift+F3, FindPrev
AddMenu("AutoSearchMenu", "&Replace...`tCtrl+H", "ShowReplaceDialog", IconLib, 22)
Menu AutoSearchMenu, Add
AddMenu("AutoSearchMenu", "Find in Files...`tCtrl+Shift+F", "FindInFiles", IconLib, 23)
Menu AutoSearchMenu, Add
AddMenu("AutoSearchMenu", "&Go to Line...`tCtrl+G", "ShowGoToLineDialog", IconLib, 129)
Menu AutoSearchMenu, Add
AddMenu("AutoSearchMenu", "&Mark Current Line`tF2", "ToggleBookmark", IconLib, 130)
AddMenu("AutoSearchMenu", "Mark &Selected Text`tCtrl+M", "MarkSelectedText", IconLib, 131)
Menu AutoSearchMenu, Add, Go to Next Mark`tCtrl+PgDn, GoToNextMark
Menu AutoSearchMenu, Add, Go to Previous Mark`tCtrl+PgUp, GoToPreviousMark
Menu AutoSearchMenu, Add, Clear All Mar&ks`tAlt+M, ClearAllMarks
Menu AutoSearchMenu, Add
AddMenu("AutoSearchMenu", "Go to Matching &Brace`tCtrl+B", "GoToMatchingBrace", IconLib, 132)

; Convert Menu
;Menu AutoConvertMenu, Add, &UPPERCASE`tCtrl+Shift+U, Uppercase
Menu AutoConvertMenu, Add, &lowercase`tCtrl+Shift+L, Lowercase
Menu AutoConvertMenu, Add, &Title Case`tCtrl+Shift+T, TitleCase
Menu AutoConvertMenu, Add
Menu AutoConvertMenu, Add, Decimal to &Hexadecimal`tCtrl+Shift+H, Dec2Hex
Menu AutoConvertMenu, Add, Hexadecimal to &Decimal`tCtrl+Shift+D, Hex2Dec
Menu AutoConvertMenu, Add
Menu AutoConvertMenu, Add, Win32 Constant: Declare, ReplaceConstant
Menu AutoConvertMenu, Add, Win32 Constant: SendMessage, ReplaceConstant
Menu AutoConvertMenu, Add, Win32 Constant: OnMessage, ReplaceConstant
Menu AutoConvertMenu, Add
Menu AutoConvertMenu, Add, Comment/Uncomment`tCtrl+K, ToggleComment

; Control Menu (menu bar)
;AddMenu("AutoControlMenu", "Change Text...", "ChangeText", IconLib, 14)
Menu AutoControlMenu, Add
AddMenu("AutoControlMenu", "Cut", "CutControl", IconLib, 15)
AddMenu("AutoControlMenu", "Copy", "CopyControl", IconLib, 16)
AddMenu("AutoControlMenu", "Paste", "PasteControl", IconLib, 17)
AddMenu("AutoControlMenu", "Delete", "DeleteSelectedControls", IconLib, 18)
Menu AutoControlMenu, Add
AddMenu("AutoControlMenu", "Select &All", "SelectAllControls", IconLib, 41)
AddMenu("AutoControlMenu", "Select &None", "DestroySelection", IconLib, 134)
Menu AutoControlMenu, Add
AddMenu("AutoControlMenu", "Position and Size...", "ShowAdjustPositionDialog", IconLib, 75)
AddMenu("AutoControlMenu", "Font...", "ShowFontDialog", IconLib, 20)
AddMenu("AutoControlMenu", "Options...", "ShowControlOptions", IconLib, 91)
Menu AutoControlMenu, Add
AddMenu("AutoControlMenu", "Properties", "ShowProperties", IconLib, 25)

; Layout Menu
;AddMenu("AutoLayoutMenu", "Align &Lefts", "AlignLefts", IconLib, 26)
AddMenu("AutoLayoutMenu", "Align &Rights", "AlignRights", IconLib, 27)
AddMenu("AutoLayoutMenu", "Align &Tops", "AlignTops", IconLib, 28)
AddMenu("AutoLayoutMenu", "Align &Bottoms", "AlignBottoms", IconLib, 29)
Menu AutoLayoutMenu, Add
AddMenu("AutoLayoutMenu", "&Center Horizontally", "CenterHorizontally", IconLib, 30)
AddMenu("AutoLayoutMenu", "Center &Vertically", "CenterVertically", IconLib, 31)
Menu AutoLayoutMenu, Add
AddMenu("AutoLayoutMenu", "Hori&zontally Space", "HorizontallySpace", IconLib, 33)
AddMenu("AutoLayoutMenu", "V&ertically Space", "VerticallySpace", IconLib, 32)
Menu AutoLayoutMenu, Add
AddMenu("AutoLayoutMenu", "Make Same &Width", "MakeSameWidth", IconLib, 34)
AddMenu("AutoLayoutMenu", "Make Same &Height", "MakeSameHeight", IconLib, 35)
AddMenu("AutoLayoutMenu", "Make Same &Size", "MakeSameSize", IconLib, 36)
Menu AutoLayoutMenu, Add
AddMenu("AutoLayoutMenu", "Stretch Horizontally", "StretchControl", IconLib, 97)
AddMenu("AutoLayoutMenu", "Stretch Vertically", "StretchControl", IconLib, 98)

; Window Menu (menu bar)
;AddMenu("AutoWindowMenu", "Change &Title...", "ChangeTitle", IconLib, 37)
Menu AutoWindowMenu, Add
AddMenu("AutoWindowMenu", "Fit Window to Contents", "AutoSizeWindow", IconLib, 99)
AddMenu("AutoWindowMenu", "Change Font for All Controls...", "WinShowFontDialog", IconLib, 20)
AddMenu("AutoWindowMenu", "Options...", "ShowWindowOptions", IconLib, 91)
Menu AutoWindowMenu, Add
AddMenu("AutoWindowMenu", "&Show/Hide Preview Window`tF11", "ShowChildWindow", IconLib, 38)
AddMenu("AutoWindowMenu", "&Repaint", "RedrawWindow", IconLib, 39)
Menu AutoWindowMenu, Add
If (g_SysTrayIcon) {
    AddMenu("AutoWindowMenu", "Re&create From Script", "RecreateFromScript", IconLib, 40)
    Menu AutoWindowMenu, Add
}
AddMenu("AutoWindowMenu", "&Properties", "ShowWindowProperties", IconLib, 25)

; View Menu
;Menu AutoViewMenu, Add, &Editor Mode, SwitchToEditorMode, Radio
Menu AutoViewMenu, Add, &Design Mode, SwitchToDesignMode, Radio
Menu AutoViewMenu, Add
Menu AutoViewTabBarMenu, Add, Top, SetTabBarPos, Radio
Menu AutoViewTabBarMenu, Add, Bottom, SetTabBarPos, Radio
Menu AutoViewTabBarMenu, Add
Menu AutoViewTabBarMenu, Add, Standard, SetTabBarStyle, Radio
Menu AutoViewTabBarMenu, Add, Buttons, SetTabBarStyle, Radio
Menu AutoViewMenu, Add, Tab Bar, :AutoViewTabBarMenu
Menu AutoViewMenu, Add
Menu AutoViewMenu, Add, &Line Numbers, ToggleLineNumbers
Menu AutoViewMenu, Add, Symbol Margin, ToggleSymbolMargin
Menu AutoViewMenu, Add, &Fold Margin, ToggleCodeFolding
Menu AutoViewMenu, Add
Menu AutoViewMenu, Add, Collapse All Folds, CollapseFolds
Menu AutoViewMenu, Add, Expand All Folds, ExpandFolds
Menu AutoViewMenu, Add
Menu AutoViewMenu, Add, &Wrap Long Lines, ToggleWordWrap
Menu AutoViewMenu, Add, &Show White Spaces, ToggleWhiteSpaces
Menu AutoViewMenu, Add
Menu AutoViewMenu, Add, Syntax &Highlighting, ToggleSyntaxHighlighting
Menu AutoViewMenu, Add, Highlight &Active Line, ToggleHighlightActiveLine
Menu AutoViewMenu, Add, Highlight Identical Te&xt, ToggleHighlightIdenticalText
Menu AutoViewMenu, Add
Menu AutoViewMenu, Add, Enable Dark Theme, ToggleTheme
Menu AutoViewMenu, Add
AddMenu("AutoViewZoomMenu", "Zoom In`tCtrl+Num +", "ZoomIn", IconLib, 88)
AddMenu("AutoViewZoomMenu", "Zoom Out`tCtrl+Num -", "ZoomOut", IconLib, 89)
Menu AutoViewZoomMenu, Add, Reset Zoom`tCtrl+Num 0, ResetZoom
Menu AutoViewMenu, Add, Zoom, :AutoViewZoomMenu
Menu AutoViewMenu, Add
AddMenu("AutoViewMenu", "Change Editor Font...", "ChangeEditorFont", IconLib, 20)

; Options Menu
;Menu AutoOptionsMenu, Add, &Code Completion, ToggleAutoComplete
Menu AutoOptionsMenu, Add, Code &ToolTips, ToggleCalltips
Menu AutoOptionsMenu, Add, Autoclose &Brackets, ToggleAutoBrackets
Menu AutoOptionsMenu, Add, Indentation Settings..., ShowIndentationDialog
Menu AutoOptionsMenu, Add
Menu AutoOptionsGuiMenu, Add, Show &Grid, ToggleGrid
Menu AutoOptionsGuiMenu, Add, S&nap to Grid, ToggleSnapToGrid
Menu AutoOptionsMenu, Add, GUI Designer, :AutoOptionsGuiMenu
Menu AutoOptionsMenu, Add
Menu AutoOptionsMenu, Add, Debug Settings..., SetDebugPort
Menu AutoOptionsMenu, Add
Menu AutoOptionsMenu, Add, Backup Settings..., ShowBackupDialog
Menu AutoOptionsMenu, Add
Menu AutoOptionsMenu, Add, Remember Session, ToggleRememberSession
Menu AutoOptionsMenu, Add
Menu AutoOptionsMenu, Add, Ask to Save on Exit, ToggleAskToSaveOnExit
If (g_SysTrayIcon) {
    Menu AutoOptionsMenu, Add
    Menu AutoOptionsMenu, Add, Save Settings Now, SaveSettings
}
;Menu AutoOptionsMenu, Add
;AddMenu("AutoOptionsMenu", "&Settings...", "ShowSettings", IconLib, 43)

; Run Menu
;AddMenu("AutoRunMenu", "&AutoHotkey 32-bit`tF9", "RunScript", IconLib, 12)
;AddMenu("AutoRunMenu", "AutoHotkey 64-&bit`tShift+F9", "RunScript", IconLib, 92)
AddMenu("AutoRunMenu", "Run &Selected Text`tCtrl+F9", "RunSelectedText", IconLib, 95)
Menu AutoRunMenu, Add
AddMenu("AutoRunMenu", "Command Line &Parameters...", "ShowParamsDlg", IconLib, 91)
Menu AutoRunMenu, Add
AddMenu("AutoRunMenu", "Run &External Application...", "RunFileDlg", "shell32.dll", 25)

; Debug Menu
;AddMenu("AutoDebugMenu", "Start Debugging`tF5", "DebugRun", IconLib, 104)
AddMenu("AutoDebugMenu", "Break`tBreak", "DebugBreak", IconLib, 105)
AddMenu("AutoDebugMenu", "Stop Debugging`tF8", "DebugStop", IconLib, 106)
Menu AutoDebugMenu, Add
AddMenu("AutoDebugMenu", "Attach Debugger...", "ShowAttachDialog", IconLib, 107)
Menu AutoDebugMenu, Add
AddMenu("AutoDebugMenu", "Step Into`tF6", "StepInto", IconLib, 109)
AddMenu("AutoDebugMenu", "Step Over`tF7", "StepOver", IconLib, 110)
AddMenu("AutoDebugMenu", "Step Out`tShift+F6", "StepOut", IconLib, 111)
;Menu AutoDebugMenu, Add
;AddMenu("AutoDebugMenu", "Run to &Cursor`tCtrl+F5", "DebugRunToCursor", IconLib, 96)
Menu AutoDebugMenu, Add
AddMenu("AutoDebugMenu", "Toggle Breakpoint`tF4", "ToggleBreakpoint", IconLib, 112)
AddMenu("AutoDebugMenu", "Delete All Breakpoints", "DeleteBreakpoints", IconLib, 113)
Menu AutoDebugMenu, Add
AddMenu("AutoDebugMenu", "Variables", "ShowVarList", IconLib, 115)
AddMenu("AutoDebugMenu", "Call Stack", "ShowCallStack", IconLib, 123)
AddMenu("AutoDebugMenu", "Error Stream", "ShowStderr", IconLib, 124)

; Tools Menu
;AddMenu("AutoToolsMenu", "&Window Cloning Tool", "ShowCloneDialog")
Menu AutoToolsMenu, Add

; Help Menu
;AddMenu("AutoHelpMenu", "AutoHotkey &Help File`tF1", "HelpMenuHandler", IconLib, 78)
AddMenu("AutoHelpMenu", "Keyboard Shortcuts", "ShowKeyboardShortcuts", A_ScriptDir . "\Icons\Keyboard.ico")
Menu AutoHelpMenu, Add
AddMenu("AutoHelpMenu", "&About", "ShowAbout", IconLib, 80)

; Preview Window Context Menu: Insert
AddMenu("InsertMenu", "Button", "InsertControl", IconLib, 47)
AddMenu("InsertMenu", "CheckBox", "InsertControl", IconLib, 48)
AddMenu("InsertMenu", "ComboBox", "InsertControl", IconLib, 49)
AddMenu("InsertMenu", "Date Time Picker", "InsertControl", IconLib, 51)
AddMenu("InsertMenu", "DropDownList", "InsertControl", IconLib, 50)
AddMenu("InsertMenu", "Edit Box", "InsertControl", IconLib, 52)
AddMenu("InsertMenu", "GroupBox", "InsertControl", IconLib, 53)
AddMenu("InsertMenu", "Hotkey Box", "InsertControl", IconLib, 54)
AddMenu("InsertMenu", "Link", "InsertControl", IconLib, 55)
AddMenu("InsertMenu", "ListBox", "InsertControl", IconLib, 56)
AddMenu("InsertMenu", "ListView", "InsertControl", IconLib, 57)
AddMenu("InsertMenu", "Month Calendar", "InsertControl", IconLib, 59)
AddMenu("InsertMenu", "Picture", "InsertControl", IconLib, 60)
AddMenu("InsertMenu", "Progress Bar", "InsertControl", IconLib, 61)
AddMenu("InsertMenu", "Radio Button", "InsertControl", IconLib, 62)
AddMenu("InsertMenu", "Separator", "InsertControl", IconLib, 63)
AddMenu("InsertMenu", "Slider", "InsertControl", IconLib, 64)
AddMenu("InsertMenu", "Tab", "InsertControl", IconLib, 66)
AddMenu("InsertMenu", "Text", "InsertControl", IconLib, 67)
AddMenu("InsertMenu", "TreeView", "InsertControl", IconLib, 68)
AddMenu("InsertMenu", "UpDown", "InsertControl", IconLib, 70)

; Preview Window: Context Menu
AddMenu("WindowContextMenu", "Add Control", ":InsertMenu", IconLib, 44)
AddMenu("WindowContextMenu", "Paste", "PasteControl", IconLib, 17)
AddMenu("WindowContextMenu")
AddMenu("WindowContextMenu", "Change Title...", "ChangeTitle", IconLib, 37)
AddMenu("WindowContextMenu")
AddMenu("WindowContextMenu", "Fit to Contents", "AutoSizeWindow", IconLib, 99)
AddMenu("WindowContextMenu", "Font...", "ShowFontDialog", IconLib, 20)
AddMenu("WindowContextMenu", "Options...", "ShowWindowOptions", IconLib, 91)
AddMenu("WindowContextMenu")
AddMenu("WindowContextMenu", "Toggle Grid", "ToggleGrid", IconLib, 72)
AddMenu("WindowContextMenu", "Repaint", "RedrawWindow", IconLib, 39)
AddMenu("WindowContextMenu")
AddMenu("WindowContextMenu", "Properties", "ShowProperties", IconLib, 25)
Menu WindowContextMenu, Color, 0xFAFAFA

; Control Context Menu
AddMenu("ControlContextMenu", "Change &Text...", "ChangeText", IconLib, 14)
Menu ControlContextMenu, Add
AddMenu("ControlContextMenu", "C&ut", "CutControl", IconLib, 15)
AddMenu("ControlContextMenu", "&Copy", "CopyControl", IconLib, 16)
AddMenu("ControlContextMenu", "&Paste", "PasteControl", IconLib, 17)
AddMenu("ControlContextMenu", "&Delete", "DeleteSelectedControls", IconLib, 18)
Menu ControlContextMenu, Add
AddMenu("ControlContextMenu", "Position a&nd Size...", "ShowAdjustPositionDialog", IconLib, 75)
AddMenu("ControlContextMenu", "&Font...", "ShowFontDialog", IconLib, 20)
;AddMenu("ControlContextMenu", "&Styles...", "ShowStylesDialog", IconLib, 19)
AddMenu("ControlOptionsMenu", "None", "MenuHandler")
AddMenu("ControlContextMenu", "&Options", ":ControlOptionsMenu", IconLib, 91)
Menu ControlContextMenu, Add
AddMenu("ControlContextMenu", "Prop&erties", "ShowProperties", IconLib, 25)

; Tab Context Menu
AddMenu("TabContextMenu", "Close Tab", "CloseTabN", IconLib, 8)
Menu TabContextMenu, Add
AddMenu("TabContextMenu", "Duplicate Tab Contents", "DuplicateTab", IconLib, 7)
AddMenu("TabContextMenu", "Open Folder in Explorer", "OpenFolder", IconLib, 9)
AddMenu("TabContextMenu", "Copy Path to Clipboard", "CopyFilePath", IconLib, 11)
AddMenu("TabContextMenu", "Open in a New Window", "OpenNewInstance", IconLib, 1)
Menu TabContextMenu, Add
AddMenu("TabContextMenu", "File Properties", "ShowFileProperties", IconLib, 25)

LoadHelpMenu() {
    g_HelpMenuXMLObj := LoadXML(A_ScriptDir . "\Include\HelpMenu.xml")
    Nodes := g_HelpMenuXMLObj.selectSingleNode("HelpMenu").childNodes

    StartPos := 3
    For Node in Nodes {
        Index := StartPos + A_Index

        If (Node.hasChildNodes()) {
            SubMenu := True
            MenuName := "AutoHelpMenu" . Index

            ChildNodes := Node.childNodes
            For ChildNode in ChildNodes {
                MenuItemText := ChildNode.getAttribute("name")
                Icon := GetHelpMenuItemIcon(ChildNode)
                AddMenu(MenuName, MenuItemText, "HelpMenuHandler", Icon[1], Icon[2])
            }
        } Else {
            SubMenu := False
        }

        MenuItemText := Node.getAttribute("name")
        Menu AutoHelpMenu, Insert, %Index%&, %MenuItemText%, % (SubMenu) ? ":" . MenuName : "HelpMenuHandler"

        If (SubMenu) {
            Menu AutoHelpMenu, Icon, %MenuItemText%, %IconLib%, 9
        } Else {
            Icon := GetHelpMenuItemIcon(Node)
            Menu AutoHelpMenu, Icon, %MenuItemText%, % Icon[1], % Icon[2]
        }
    }

    Index++
    Menu AutoHelpMenu, Insert, %Index%&
}

GetHelpMenuItemIcon(Node) {
    URL := Node.getAttribute("url")

    If (SubStr(URL, 1, 1) == "/") {
        Icon := IconLib
        IconIndex := 79
    } Else {
        Icon := IconLib
        IconIndex := 133
    }

    Return [Icon, IconIndex]
}

ShowKeyboardShortcuts() {
    Run %A_ScriptDir%\Include\Keyboard.ahk    
}
