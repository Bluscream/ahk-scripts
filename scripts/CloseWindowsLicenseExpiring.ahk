#SingleInstance, Force
; #NoTrayIcon
#Persistent
#NoEnv
SetTitleMatchMode, 2
CoordMode, Mouse, Client

title := "Your Windows license will expire soon ahk_class Shell_SystemDialog ahk_exe LicensingUI.exe"

Loop{
    Sleep, 500
    WinWait, %title%
    if !WinActive(title){
        WinActivate, %title%
        Sleep, 50
    }
	Click(619, 128)
    Sleep, 200 
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