#Include <scs>
#Persistent
#SingleInstance Force
; Process Priority,, Below Normal
SetTimer, Loop, 1000
TrayTip, AutoHotKey, "Started " . game_shortname . " Flashing High Beams",
Return
Loop:
    if (!WinActive(game_title))
        Return
    data := requestTelemetry()
    if (data.game.paused || !data.truck.electricOn || !data.truck.lightsBeaconOn)
        Return
	wait := flashHighBeams(data.truck.lightsBeamHighOn)
    Sleep, 150
    if (!WinActive(game_title))
        Return
    wait := flashHighBeams()
    dings()
    Return
Return

dings(){
    Sleep, 100
    data := requestTelemetry()
    if (data.truck.lightsBeamHighOn)
        Send, K
}

flashHighBeams(lightsBeamHighOn := false) {
    if (!lightsBeamHighOn){
        Send, K
        Sleep, 20
    }
	Send, K
}