; Configuration - adjust these values to change the movement area
baseX := 562    ; Starting baseX coordinate
baseY := 309    ; Starting baseY coordinate
baseW := 600    ; Width of the area
baseH := 400    ; Height of the area

baseA := baseX + baseW
baseB := baseY + baseH

ToolTip, baseAB %baseA%, %baseB%
SetTimer, RemoveToolTip, -1000

; CoordMode, Mouse, Screen



; Create a transparent window to visualize the movement area
; Gui, +AlwaysOnTop -Caption +ToolWindow +E0x20
; Gui, Color, BBBBBB
; Gui, Show, x%baseX% y%baseY% w%baseW% h%baseH% NoActivate
; WinSet, TransColor, BBBBBB 200



; Hotkeys to control the script
F12::        ; Press F12 to toggle the movement
Toggle := !Toggle
if (Toggle) {
    SetTimer, MoveMouse, 1    ; Move every second
    TrayTip, Mouse Movement, Started moving mouse randomly
} else {
    SetTimer, MoveMouse, Off
    TrayTip , Mouse Movement, Stopped moving mouse
}
return

MoveMouse:
    Random, newX, %baseX%, % baseA
    Random, newY, %baseY%, % baseB
    MouseMove, newX, newY, 3
    return

RemoveToolTip:
    ToolTip
    return


; Exit script with ESC key
Esc::
ExitApp