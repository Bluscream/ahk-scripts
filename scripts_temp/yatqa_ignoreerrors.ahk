#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
; SetTitleMatchMode, 2
title := "Fehler ahk_class TMessageForm ahk_exe yatqa.exe" ; Error
button := "&Ignorieren" ; TButton1 ; Ignore
while(true) {
    WinWait, %title%
    Sleep 10
    ControlClick, %button%, %title%
}
;ClassNN:	 Text:	