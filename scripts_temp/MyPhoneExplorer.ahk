#Include <bluscream>

#SingleInstance, Force
#NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
;
global title := "Attention! ahk_class ThunderRT6FormDC ahk_exe MyPhoneExplorer.exe"

Loop
{
    WinWait % title
    ControlClick ThunderRT6CommandButton4, % title
    Sleep 3000
    ControlClick ThunderRT6CommandButton1, % title
}