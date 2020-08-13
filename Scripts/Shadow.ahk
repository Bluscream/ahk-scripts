﻿#SingleInstance Force
#NoEnv
#NoTrayIcon
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
global interval_seconds := 300
global interval

; CreateInterval()

SetTimer, CheckForShadow, % 1000*interval_seconds
; AntiAFK()

CheckForShadow:
    if (shadow.exists()) {
        ; if (A_TimeIdle > interval) {
            scriptlog(A_Now . " > " . toJson(GetIdleTimes()))
            AntiAFK()
        ; }
    } else {
        ; Run % "AppData\Local\Programs\shadow-preprod\resources\app.asar.unpacked\release\native\Shadow.exe"
    }

AntiAFK() {
    if !(shadow.exists()) {
        Return
    }
    if !(shadow.isActive()) {
        ; SplashScreen("ShadowInFocus()", "", 1000)
        was_minimized := shadow.isMinimized()
        shadow.activate()
        Sleep, 1000
    } 
    MoveMouse()
    ; CreateInterval()            
    if (was_minimized) {
        shadow.minimize()
    }
}
    
CreateInterval() {
    Random, interval, 1000*60*min_time_minutes, 1000*60*max_time_minutes ; global interval := 10000
    txt := "New Interval: " . ConvertTime(interval)
    SplashScreen(txt, "", 1000)
    scriptlog(txt . " (" . interval . ")")
}
    
ConvertTime(time_ms) {
    return Round(time_ms / 1000 / 60) . " min"
}

MoveMouse() {
    CoordMode, Mouse, Screen
    MouseGetPos, MouseX, MouseY
    pos := shadow.pos()
    scriptlog(toJson(pos))
    center := pos.center
    CoordMode, Mouse, Client
	MouseMove, center.w, center.h
    MouseClick
    MouseClickDrag, Right, center.w, center.h, 5,5,, R
    ;Sleep, 10
	;MouseMove, center.w + 2, center.h - 3
    ;Sleep, 15
    CoordMode, Mouse, Screen
    MouseMove, MouseX, MouseY
}