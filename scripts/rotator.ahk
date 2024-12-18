#Persistent
; #Warn
#SingleInstance, force
#MaxHotkeysPerInterval, 250
SetBatchLines, -1
Process, Priority,, Low
SetWorkingDir, % A_ScriptDir
CoordMode, Mouse, Screen

global enabled := false
global speed := 50

return

ScrollLock::
    enabled := !enabled
    if (enabled) {
        SetTimer, RotateScreen, 10
    } else {
        SetTimer, RotateScreen, Off
    }
    SetScrollLockState % !GetKeyState("ScrollLock", "T")
    return

MButton::
    speed := 0
    return
WheelUp::
    speed := speed + 5
    return
WheelDown::
    speed := speed - 5
    return

RotateScreen:
    MouseGetPos, x, y
    MouseMove, % x - speed, y, 0
    return

F1::
    ExitApp
    return
