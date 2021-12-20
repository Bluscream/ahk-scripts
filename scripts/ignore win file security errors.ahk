#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
; SetTitleMatchMode, 2
title := "Error Applying Security ahk_class #32770 ahk_exe explorer.exe"
button := "&Continue" ; TButton1 ; Ignore
while(true) {
    WinWait, %title%
    Sleep 1
    ControlClick, %button%, %title%
}
;ClassNN:	 Text:	