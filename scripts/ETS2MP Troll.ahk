; Version 10/18/2018
#Include <scs>
#Include <JSON>
#Include <logtail>
#Include <bluscream>
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

global noui := false
global ui := false
scriptlog("Started logging here...")

; SETTINGS START
interval := 500 ; Region will be scanned each "interval" millseconds
; gosub ^T ; Add a ; infront of this line if you want to press CTRL+L manually to enable the script
; SETTINGS END

Return

^T::
    active:=!active
    troll(active)
    SetTimer, Loop, % active ? interval : "Delete"
    TrayTip, AutoHotKey, % (active ? "Enabled" : "Disabled") . " " . game_shortname_mp . " Trolling :D",
    Return

troll(enable) {
    data := requestTelemetry()
    ; global oldgear := data.truck.displayedGear
    if (enable) {
        ; setGear(-1, data)
    } else {
        ; setGear(1, data)
    }
    Return
}

Loop:
    WinWaitActive, %game_title%
    data := requestTelemetry()
    if (data.game.paused)
        return
    if (data.truck.lightsBeamLowOn && !data.truck.lightsBeamHighOn) {
        Send, K
    } else {
        Send, L
    }
    Send, O
    Return