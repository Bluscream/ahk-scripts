#Include <scs>
#Persistent
#SingleInstance Force
Process Priority,, Below Normal
SetTimer, Loop, 1000
TrayTip, AutoHotKey, Started %game_shortname% Auto Parking Brake Disengage,
Return
Loop:
    WinWaitActive, %game_title%
    data := requestTelemetry()
    if (data.game.paused || !data.truck.engineOn)
        return
	if (data.truck.parkBrakeOn && data.truck.userThrottle)
        Send, {Space}
    Return