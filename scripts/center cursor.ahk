#Persistent ;//keeps script running
CoordMode, Mouse, Screen
Return ;//stops auto execution

F4:: ;//your code
    x := (A_ScreenWidth / 2)
    y := (A_ScreenHeight / 2)
    mousemove, x, y
    Return