#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
global noui := false
#Include <bluscream>
scriptlog(A_ScriptFullPath . " " .  Join(" ", A_Args))
CoordMode, mouse, Client
_channels := {}
_channels["stable"] := new Process().fromFile(new Paths.User().localappdata.combineFile("Programs", "shadow", "Shadow.exe"))
_channels["beta"] := new Process().fromFile(new Paths.User().localappdata.combineFile("Programs", "shadow-preprod", "Shadow Beta.exe"))
_channels["alpha"] := new Process().fromFile(new Paths.User().localappdata.combineFile("Programs", "shadow-testing", "Shadow Alpha.exe"))
global channels := {}
Menu, tray, add
for name, channel in _channels {
    exists := FileExist(channel.file.path)
    ; scriptlog("_channel: " . name . " path: " . channel.file.path . " exists: " . exists)
    if (exists) {
        channels[name] := channel
        Menu, tray, add, % "Start " . channel.file.name, StartShadow
        if (!hasIcon) {
            Menu, Tray, Icon, % channel.file.path
            hasIcon := true
        }
        ; scriptlog("channel: " . name . " path: " . channels[name].file.path . " exists: " . FileExist(channels[name].file.path))
    }
}
; PasteToNotepad((ToJson(channels, true)))
; fixedY := A_ScreenHeight/2

global shadow_launcher := new Window("Shadow", "Chrome_WidgetWin_1")
global shadow := new Window("Shadow", "Shadow-Window-Class") ; , channels[1].fullname


global button := new Coordinate(202, 518, shadow_launcher, 0, 596, 60)
; global button_enabled := [ 0x4478FD, 0x467DFD ]
; global button_disabled := [ 0x252220, 0x757371 ]
; global button_busy := [ 0x737371 ]


; global min_time_minutes := 20
; global max_time_minutes := 29
global interval_seconds := 15
; global interval
global force_connect := false
global start_channel := ""

; CreateInterval()
; AntiAFK()
for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/start") {
        start_channel := Trim(A_Args[n+1])
        StringLower, start_channel, % start_channel
        ; scriptlog("/start was set. Starting " . start_channel . " (" . channels[start_channel].file.path . ")")
        ; channels[start_channel].file.run()
        ; shadow_launcher.activate(true)
    }
    else if (param == "/force") {
        force_connect := true
        scriptlog("/force was set. Forcing connect")
    }
}
SetTimer, CheckForShadow, % 1000*interval_seconds
gosub CheckForShadow
return
; F1::PasteToNotepad(ToJson(channels, true))
; Esc::ExitApp
; F5::
    ; SearchPixel()
    ; return

StartShadow:
    killShadow()
    txt := StrReplace(A_ThisMenuItem, "Start ", "")
    for i, channel in channels {
        if (channel.file.name != txt)
            continue
        channel.file.run()
    }
    return

CheckForShadow:
    SetTimer, CheckForShadow, Off
    if (shadow.exists()) {
        ; if (A_TimeIdle > 600) {
            ; scriptlog(A_Now . " > " . toJson(GetIdleTimes()))
            ; AntiAFK()
        ; }
    } else if (shadow_launcher.exists()) {
        if (force_connect) {
            ; scriptlog("clicking button " . button.str())
            shadow_launcher.activate(true)
            Sleep, 250
            button.click()
            ; SetTimer, CheckForShadow, Off
            ; ControlClick, x595 y827, % shadow_launcher.str(),, left, 1, Pos
            ; MouseClick, left, 552, 575
        }
    } else {
        if (start_channel != "") {
            scriptlog("Couldn't find shadow " . start_channel . " launcher. Starting ...")
            channels[start_channel].file.run()
        }
        ; scriptlog("Starting " . channels[3].file.path)
        ; channels[3].file.run() ; Run % channel.path
    }
    SetTimer, CheckForShadow, % 1000*interval_seconds
    return

killShadow() {
    count := 0
    for i, p in processes {
        count++
        SplashScreen(p.name, "Killing process " . count . " / " . processes.Count(), 250)
        process_closed := p.close()
        process_killed := p.kill(true, true)
    }
}

getChannelByName(name := "") {
    for _name, channel in channels {
        if (_name == name) {
            return channel
        }
    }
}

SearchPixel() {
  ; PixelSearch, OX, OY, X1,   Y1,  X2,  Y2, ColorID       , Variation, Mode
    CoordMode, Pixel, Relative
    PixelSearch, Px, Py, button.y+10, button.y+10, button.x+button.w-10, button.y+button.h-10, button_disabled[1], 50, Fast
    if not ErrorLevel
        ; MsgBox, A color within 50 shades of variation was found at X%Px% Y%Py%.
        MouseMove, Px, Py
}

SearchImage() {
    CoordMode Pixel  ; Interprets the coordinates below as relative to the screen rather than the active window.
    ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *Icon3 %A_ProgramFiles%\SomeApp\SomeApp.exe
    if (ErrorLevel = 2)
        MsgBox Could not conduct the search.
    else if (ErrorLevel = 1)
        MsgBox Icon could not be found on the screen.
    else
        MsgBox The icon was found at %FoundX%x%FoundY%.
}

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
