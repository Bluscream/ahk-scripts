;Written By Joseph#0501

#NoEnv
SetBatchLines -1
SendMode Input 
SetWorkingDir %A_ScriptDir%
#SingleInstance Force

Menu Tray, Icon, pifmgr.DLL, 38

GetWindows()

GetWindows(){
    WinGet, WinList, List
    Loop % WinList
    {   
        ID := "ahk_id " WinList%A_Index%

        WinGet, ProcessName, ProcessName, % ID
        
        If ItemInList(ProcessName, ["chrome.exe", "explorer.exe", "AutoHotkey.exe", "scite.exe"])
            Continue
        
        WinGet, ControlList, ControlList, % ID

        ;Ignore windows without form controls
        ;If !ControlList
        ;    Continue

        WinGetTitle, WinTitle, % ID
        WinTitles .= WinTitle ? WinTitle "|" : ""
    }
    Return WinTitles
}

Gui, +AlwaysOnTop +HWNDGuiHWND
Gui, Add, DDL, Section w240 vWindowTitle Choose1, % GetWindows()
Gui, Add, Button, ys-1 gRun w80, Run
Gui, Add, Button, ys-1 gReload w80, Reload
Gui, Add, Checkbox, ys+5 vShowHidden, Show Hidden
Gui, Add, Checkbox, ys+5 vEnable, Enable All
Gui, Add, Progress, ys+4 vProgress BackgroundNavy HWNDProgress
Gui, Add, ListView, xm w800 h400, Control|Text

Gui, Show, ,Control Spy

Return

Run:
    Gui, Submit, Nohide

    WinActivate, % WindowTitle

    WinGet, ControlList, ControlList, % WindowTitle
    ControlCount := 0

    LV_Delete()
    GuiControl,, % Progress, 0

    Loop, Parse, ControlList, `n
        ControlCount++

    Loop, Parse, ControlList, `n
    {
        If ShowHidden
            Control, Show,, % A_LoopField, % WindowTitle

        If Enable
            Control, Enable,, % A_LoopField, % WindowTitle  

        ControlGetText, ControlText, % A_LoopField, % WindowTitle
        If !ControlText
            ControlText := "NULL"

        LV_Add( , A_LoopField, ControlText)
        GuiControl,, % Progress, % (A_Index / ControlCount) * 100
    }
    Loop 2
        LV_ModifyCol(A_Index, "AutoHdr")    
Return

Reload:
    ToolTip Reloading...
    LV_Delete()
    GuiControl,, WindowTitle, % "|" GetWindows()
    GuiControl, Choose, WindowTitle, 1
    ToolTip
Return

ItemInList(Item, List){    
    For Index, ListItem in List
        If (ListItem = Item)
            Return True
}

GuiClose:
GuiEscape:
    ExitApp
Return