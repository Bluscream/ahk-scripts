#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
global noui := true
#Include <bluscream>
CoordMode, mouse, Client
dir := new Paths.User().localappdata.combine("Programs")
channels := [dir.combineFile("shadow", "Shadow.exe"), dir.combineFile("shadow-preprod", "Shadow Beta.exe"), dir.combineFile("shadow-testing", "Shadow Alpha.exe")]
for i, channel in channels {
    if (channel.exists) {
        Menu, Tray, Icon, % channel.path
        Menu, tray, add, % "Start " . channel.name, StartShadow
    }
}

; #Warn

toggle := 0
fixedY := A_ScreenHeight/2

global shadow_launcher := new Window("Shadow", "Chrome_WidgetWin_1")
global shadow := new Window("Shadow", "Shadow-Window-Class", channels[1].fullname)

global min_time_minutes := 20
global max_time_minutes := 29
global interval_seconds := 10
global interval

; CreateInterval()

SetTimer, CheckForShadow, % 1000*interval_seconds
; AntiAFK()
Esc::ExitApp
return

StartShadow:
    new Process("Shadow.exe").kill()
    txt := StrReplace(A_ThisMenuItem, "Start ", "")
    for i, channel in channels {
        if (channel.name != txt)
            continue
        Run % channel.path
    }
    return

CheckForShadow:
    if (shadow.exists()) {
        if (A_TimeIdle > interval) {
            scriptlog(A_Now . " > " . toJson(GetIdleTimes()))
            ; AntiAFK()
        }
    } else {
        if (shadow_launcher.exists()) {
            ; ControlClick, [Control-or-Pos, WinTitle, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]
            ControlClick, x552 y575, % shadow_launcher.str(),, left, 1, Pos
            ; MouseClick, left, 552, 575
        } else {
            channels[3].run()
        }
    }
    return

AntiAFK() {
    if !(shadow.exists()) {
        Return
    }
    was_minimized := shadow.isMinimized()
    if !(shadow.isActive()) {
        ; SplashScreen("ShadowInFocus()", "", 1000)
        shadow.activate()
        Sleep, 1000
    }
    ; 0Random, rand, 0, 1
    ; if (rand)
    MoveMouse()
    Send {Alt}
    Random, rand, 0, 1
    if (rand)
        Send {AppsKey}
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

MoveMouse(minpixels:=15,maxpixels:=30) {
    MouseGetPos, MouseOldX, MouseOldY
    center := shadow.pos().center
    MouseMove, % center.w, % center.h, 1
    CoordMode, Mouse, Screen
    MouseGetPos, CenterX, CenterY
    CoordMode, Mouse, Client
    Random, pixels, % minpixels, % maxpixels
    Random, mathX, % 0, % 1
    Random, mathY, % 0, % 1
    MouseMove, % mathX?pixels:pixels*-1, % mathY?pixels:pixels*-1, 100, R
    ; Loop, % pixels {
        ; moveX := mathX ? A_Index : A_Index*-1
        ; moveY := mathY ? A_Index : A_Index*-1
        ; DllCall("mouse_event", "UInt", 0x01, "UInt", CenterX+A_Index, "UInt", CenterY+A_Index)
        ; MouseMove, % moveX, % moveY, 50, R
        ; sleep, 200
    ; }
    MouseMove, % MouseOldX, % MouseOldY
}

MoveMouse1() {
    ; CoordMode, Mouse, Client ; Screen
    MouseGetPos, MouseX, MouseY
    ; CoordMode, Mouse, Client
	; MouseMove, center.w, center.h
    ; MouseClick
    ; MouseClickDrag, Right, center.w, center.h, 5,5,, R
    ;Sleep, 10
	;MouseMove, center.w + 2, center.h - 3
    ;Sleep, 15
    ; CoordMode, Mouse, Screen
    MouseMove, MouseX, MouseY
}