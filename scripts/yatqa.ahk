#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#include <bluscream>
global noui := false

; YaTQA › Yet another TeamSpeak³ Query App ‹ v3.9.9 [registered for Full Name]

yatqa := "ahk_class TMainForm ahk_exe yatqa.exe"
suffix := " [Modded]"


while (True) {
    WinWaitActive, % yatqa
    ; Control, Hide,,Button37, %yatqa%
    WinGetTitle, window_title, %yatqa%
    ; scriptlog(window_title)
    window_title := RegExReplace(window_title, " \[registered for .*\]" , " [registered for REDACTED]", "", 1)
    window_title := StrReplace(window_title, suffix, "")
    WinSetTitle, %yatqa%,, %window_title%%suffix%
    ControlSetText, TButton5, YANNI, %yatqa%
    Control, Add, Penis, TListView1
    ; ControlMove, TButton5, 100, 100, 50,50,%yatqa%
    WinWaitClose, % yatqa
}
return
#IfWinActive ahk_class TMainForm ahk_exe yatqa.exe
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