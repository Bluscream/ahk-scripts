CoordMode, mouse, window

global interval_min := 29 ; seconds
global interval_max := 61 ; seconds
global tooltips := false

global toggle := 0

Menu, TRAY, add, Toggle Mouse Mover, ToggleMouseMover
Gui Add, CheckBox, vg_BackupOnSave x12 y93 w300 h23 +Checked%g_BackupOnSave%
; SetTimer, MoveTheMouse, -%time%

^ESC::ExitApp
F1::ToggleMouseMover()

return

ToggleMouseMover() {
    global interval_min, interval_max, toggle, tooltips
    ; MouseGetPos, MouseX, MouseY
    if (toggle == 1) {
        toggle := 0
        Menu, Tray, UnCheck, Toggle Mouse Mover
        SetTimer, MoveTheMouse, off
        if (tooltips) {
            ToolTip, % "Stopped Mouse mover"
            Sleep, 5000
            ToolTip
        }
    } else {
        toggle := 1
        Menu, Tray, Check, Toggle Mouse Mover
        Random, interval, % interval_min, % interval_max
        SetTimer, MoveTheMouse, % interval*1000 ; gosub, MoveTheMouse
        if (tooltips) {
            ToolTip, % "Started Mouse mover with " . interval . "s interval"
            Sleep, % interval*1000
            ToolTip     
        }  
    }
    return
}

MoveTheMouse:
    Random, x, 1, % A_ScreenWidth
    Random, y, 1, % A_ScreenHeight
    Random, speed, 1, 100
    MouseMove, % x, % y, % speed
    ; Random, Time, 1000*60, 1000*60*2
    return