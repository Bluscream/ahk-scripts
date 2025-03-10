CoordMode, mouse, window

toggle := 0, fixedY := A_ScreenHeight/2 ; choose the y you like

SetTimer, MoveTheMouse, -%time%

F1::
MouseGetPos, MouseX, MouseY
if toggle := !toggle
 gosub, MoveTheMouse
else
 SetTimer, MoveTheMouse, off
return

MoveTheMouse:
Random, x, 1, % A_ScreenWidth
MouseMove, %x%, %fixedY%, 100
Random, Time, 1000*60, 1000*60*5
SetTimer, MoveTheMouse, -%time%  ; every 3 seconds 
return