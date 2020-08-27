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
if (channels[1].exists()) {
    Menu, Tray, Icon, % channels[1].path
}
for i, channel in channels {
    Menu, tray, add, % "Start " . channel.name, StartShadow
}

; #Warn

toggle := 0
fixedY := A_ScreenHeight/2

global shadow_launcher := new Window("Shadow", "Chrome_WidgetWin_1")
global shadow := new Window("Shadow", "Shadow-Window-Class", channels[1].fullname)

global min_time_minutes := 20
global max_time_minutes := 29
global interval_seconds := 300
global interval

; CreateInterval()

SetTimer, CheckForShadow, % 1000*interval_seconds
; AntiAFK()
return

StartShadow:
    txt := StrReplace(A_ThisMenuItem, "Start ", "")
    for i, channel in channels {
        if (channel.name != txt)
            continue
        Run % channel.path
    }
    return

CheckForShadow:
    if (shadow.exists()) {
        ; if (A_TimeIdle > interval) {
            scriptlog(A_Now . " > " . toJson(GetIdleTimes()))
            AntiAFK()
        ; }
    } else {
        ; Run % "AppData\Local\Programs\shadow-preprod\resources\app.asar.unpacked\release\native\Shadow.exe"
    }
    return

AntiAFK() {
    if !(shadow.exists()) {
        Return
    }
    was_minimized := false
    if !(shadow.isActive()) {
        ; SplashScreen("ShadowInFocus()", "", 1000)
        was_minimized := shadow.isMinimized()
        shadow.activate()
        Sleep, 1000
    }
    ; Random, rand, 0, 1
    ; if (rand)
        ; MoveMouse()
    Send {AppsKey}
    Random, rand, 0, 1
    if (rand)
        Send % "{Alt}"
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