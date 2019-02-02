#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

yatqa := "ahk_class TMainForm ahk_exe yatqa.exe"
suffix := " [Modded]"

; Control, Hide,,Button37, %yatqa%
WinGetTitle, window_title, %yatqa%
window_title := StrReplace(window_title, suffix, "")
WinSetTitle, %yatqa%,, %window_title%%suffix%
ControlSetText, TButton5, YANNI, %yatqa%
Control, Add, Penis, TListView1
; ControlMove, TButton5, 100, 100, 50,50,%yatqa%
MButton::
    
    if (!active) {
        InputBox, interval, Serverlist Auto Refresh Interval, Please enter a interval in seconds, 
        if ErrorLevel
            Return
    }
    active:=!active
    SetTimer, AutoRefresh, % active ? interval : "Delete"
    
AutoRefresh:
    ControlGetText, btn_text , TButton5, %yatqa%
    if (btn_text != "Aktualisieren" || btn_text != "Refresh") {
        gosub MButton
        Return
    }
    ControlClick , TButton5, %yatqa%
    return