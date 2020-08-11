#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On

#Include <bluscream>

CoordMode, mouse, Client

toggle := 0
fixedY := A_ScreenHeight/2

global shadow_launcher := new Window("Shadow", "Chrome_WidgetWin_1")
global shadow := new Window("Shadow", "Shadow-Window-Class", "Shadow.exe")

global min_time_minutes := 20
global max_time_minutes := 29
global interval_seconds := 30

; Screen:	622, 643 (less often used)
; Window:	528, 616 (default)
; Client:	528, 616 (recommended)
; Color:	FD7643 (Red=FD Green=76 Blue=43)

CreateInterval()

SetTimer, CheckForShadow, % 1000*interval_seconds
AntiAFK()

CheckForShadow:
    if (ShadowExists()) {
        if (A_TimeIdle > interval) {
            SplashScreen("A_TimeIdle (" . ConvertTime(A_TimeIdle) . ") > interval (" . ConvertTime(interval) . ")", "", 1000)
            AntiAFK()
        }
    } else {
        ; RunWait 
    }

AntiAFK() {
    if !(ShadowInFocus()) {
        ; SplashScreen("ShadowInFocus()", "", 1000)
        was_minimized := ShadowMinimized()
        WinActivate, % shadow.str()
        WinWaitActive, % shadow.str()
        Sleep, 1000
    } 
    MoveMouse()
    CreateInterval()            
    if (was_minimized) {
        WinMinimize, % shadow.str()
    }
}
    
CreateInterval() {
    global interval
    Random, interval, 1000*60*min_time_minutes, 1000*60*max_time_minutes ; global interval := 10000
    SplashScreen("New Interval: " . ConvertTime(interval), "", 1000)
}
    
ConvertTime(time_ms) {
    return (time_ms / 1000 / 60) . " min"
}

ShadowExists() {
    return WinExist(shadow.str())
}
ShadowInFocus() {
    return WinActive(shadow.str())
}
ShadowMinimized() {
    WinGet MMX, MinMax, % shadow.str()
    return (MMX == -1)
}

MoveMouse() {
    CoordMode, Mouse, Screen
    MouseGetPos, MouseX, MouseY
   ;WinGetPos, X, Y, Width, Height, WinTitle, WinText, ExcludeTitle, ExcludeText]
    WinGetPos,  ,  , Width, Height, % shadow.str()
	Height /= 2 
	Width -= 1 ; The full value goes past the window
    Width /= 2 
    CoordMode, Mouse, Client
	MouseMove, Width + 3, Height - 2
    Sleep, 10
	MouseMove, Width + 2, Height - 3
    Sleep, 15
    CoordMode, Mouse, Screen
    MouseMove, MouseX, MouseY
}