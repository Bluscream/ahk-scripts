#Include <scs>
#Persistent
#SingleInstance Force
Process Priority,, Below Normal
min_detections := 3
SetTimer, Loop, 100
detections := 0
TrayTip, AutoHotKey, "Started " . game_shortname . " Auto Parking Brake Disengage",
Return
Loop:
    WinWaitActive, %game_title%
    data := requestTelemetry()
    if (data.game.paused || !data.truck.engineOn)
        return
	if (data.truck.parkBrakeOn && data.truck.userThrottle) {
		detections += 1
		if(detections >= min_detections)
			Send, {Space}
	} else if (detections > 0){
		detections := 0
	}	
    Return