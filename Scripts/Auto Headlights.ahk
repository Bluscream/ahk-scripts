; Version 10/18/2018
#Include <scs>
#Include <region>
#Include <JSON>
#NoEnv
#Persistent
#InstallKeybdHook
#UseHook On
SendMode Input
#SingleInstance Force
#InputLevel 1
SetBatchLines -1
SetWorkingDir %A_ScriptDir%
Process Priority,, Below Normal

; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-ets2-autoheadlights-ahk
; Requirements:
; - https://autohotkey.com/v2/
; - https://github.com/cocobelgica/AutoHotkey-JSON/blob/master/JSON.ahk
; - https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-region-ahk
; - https://github.com/Funbit/ets2-telemetry-server

; global ui := false
; scriptlog("Started logging here...")

; SETTINGS START
interval := 3000 ; Region will be scanned each "interval" millseconds
regionX := [100,750] ;[820,302] ; The region to scan (left number is the horizontal start and right number the width)
regionY := [100,500] ;[341,315] ; The region to scan (left number is the horizontal start and right number the length)
threshold := 50 ; How low the avarage detected color must be to assume it's dark
min_detections := 5 ; How often the threshold must be reached before assuming it's dark
force_on := [19,07] ; Time in 24hours from when to when to force the headlights to be on (19h-07h)
min_speed := 1 ; Minimal speed for the detection to start
gosub ^L ; Add a ; infront of this line if you want to press CTRL+L manually to enable the script
; SETTINGS END

^L::
    active:=!active
    if (active) {
        WinWaitActive, %game_title%
    }
    SetTimer, Loop, % active ? interval : "Delete"
    TrayTip, AutoHotKey, % (active ? "Enabled" : "Disabled") . " " . game_shortname . " Auto Headlights",
    Return

Loop:
    WinWaitActive, %game_title%
    data := requestTelemetry()
    if (data.game.paused || !data.truck.engineOn)
        return
    park := data.truck.lightsParkingOn
    low := data.truck.lightsBeamLowOn
    gametime := data.game.time
    RegexMatch(gametime, "T[0-9]{2}", time)
    gamehours := SubStr(time, 2, 4)
    if (gamehours >= force_on[1] || gamehours < force_on[2] ) {
        if (!low) {
            setLights(true, park, low)
        }
        return
    }
    if (data.truck.speed < min_speed)
        return
    AverageColor := regionGetColor(regionX[1],regionY[1], regionX[2],regionY[2])
    Red := (AverageColor & 0xFF)
    Green := ((AverageColor & 0xFF00) >> 8)
    Blue := ((AverageColor & 0xFF0000) >> 16)
    isDark := Red < threshold && Green < threshold && Blue < threshold
    if !(red and green and blue) {
        return
    }
    if (isDark && !low) {
        if(detections >= min_detections) {
            setLights(true, park, low)
            detections := 0
        } else {
            detections += 1
        }
    } else if (!isDark && park) {
        if(detections >= min_detections) {
            setLights(false, park, low)
            detections := 0
        } else {
            detections += 1
        }
    } else {
        detections := 0
    }
    Return