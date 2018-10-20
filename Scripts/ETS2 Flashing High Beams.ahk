#Include <scs>
#Persistent
#SingleInstance Force
Process Priority,, Below Normal
min_detections := 3
SetTimer, Loop, 100
detections := 0
TrayTip, AutoHotKey, "Started " . game_shortname . " Flashing High Beams",
Return
while(active) {
    WinWaitActive, %game_title%
    data := requestTelemetry()
    if (data.game.paused || !data.truck.electricOn || !data.truck.lightsBeaconOn)
        Return
	
    Return
}