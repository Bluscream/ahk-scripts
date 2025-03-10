#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir

; #Include <bluscream>

global title_error := "Attention! ahk_class ThunderRT6FormDC ahk_exe MyPhoneExplorer.exe"
global title_new_device := "New user ahk_class ThunderRT6FormDC ahk_exe MyPhoneExplorer.exe"

Loop
{
    WinWait % title_new_device
    WinGetText, winText
    ControlSetText, TextBoxU1, %winText%
    ControlClick, ThunderRT6CommandButton1, % title_new_device
    SleepS(2)
}

; Loop
; {
;     WinWait % title_error
;     ControlClick ThunderRT6CommandButton4, % title_error
;     Sleep 3000
;     ControlClick ThunderRT6CommandButton1, % title_error
; }