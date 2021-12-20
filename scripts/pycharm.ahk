#SingleInstance, Force
#NoTrayIcon
#Persistent
#NoEnv
SetTitleMatchMode, 2
CoordMode, Mouse, Client

path := "%userprofile%\PATH\PhpStorm.cmd"
title := "Evaluation License Expired ahk_class SunAwtDialog ahk_exe phpstorm64.exe"

Loop{
    Sleep, 500
    WinWait, %title%
    if !WinActive(title){
        WinActivate, %title%
        Sleep, 50
    }
	Click(523, 75)
    Sleep, 200
    if WinExist(title) {
        Click(267, 67)
        Sleep, 1000
        Run, %path%
    }     
}

Click(x,y){
    MouseGetPos, oldX, oldY
    Click, %x%, %y%
    MouseMove, oldX, oldY
}

; Screen:	555, 640 (less often used)
; Window:	526, 97 (default)
; Client:	523, 75 (recommended)
; Color:	FFE9E1 (Red=FF Green=E9 Blue=E1)


; Screen:	2766, 747 (less often used)
; Window:	270, 89 (default)
; Client:	267, 67 (recommended)
; Color:	4C5052 (Red=4C Green=50 Blue=52)