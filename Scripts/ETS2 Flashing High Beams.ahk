#Include <scs>
#Persistent
#SingleInstance Force
Process Priority,, Below Normal
min_detections := 3
SetTimer, Loop, 500
detections := 0
TrayTip, AutoHotKey, "Started " . game_shortname . " Flashing High Beams",
Return
Loop:
    WinWaitActive, %game_title%
    data := requestTelemetry()
    if (data.game.paused || !data.truck.electricOn || !data.truck.lightsBeaconOn)
        Return
    Sleep, 300
	wait := setHighBeams(true)
    Sleep, 10
	wait := setHighBeams(false)
    Sleep, 300
    wait := setHighBeams(true)
    Sleep, 10
	wait := setHighBeams(false)
    Return
Return
setHighBeams(enabled) {
    data := requestTelemetry()
    if (data.game.paused || !data.truck.electricOn || !data.truck.lightsBeaconOn)
        Return
    if (enabled && !data.truck.lightsBeamHighOn) {
        Send, K
    }
    else if (!enabled && !data.truck.lightsBeamHighOn) {
        Send, K
    }
}