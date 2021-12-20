#Persistent
#SingleInstance
SetTimer, WatchCursor, 20
return

ESC::
    SetTimer, WatchCursor, Off
    ToolTip,
    ExitApp

global lastPosX := 0
global lastPosY := 0

WatchCursor:
    MouseGetPos, curPosX, curPosY
    Xchanged := curPosX != lastPosX
    Ychanged := curPosY != lastPosY
    if (!Xchanged && !Ychanged) {
        return
    }
    changestr := "Moved "
    if (Xchanged) {
        if (curPosX > lastPosX) {
            changestr .= "right (" . (curPosX - lastPosX) . "), "
            lastPosX := curPosX
        }
        else if (curPosX < lastPosX) {
            changestr .= "left (" . (lastPosX - curPosX) . "), "
            lastPosX := curPosX
        }
    }
    if (Ychanged) {
        if (curPosY > lastPosY) {
            changestr .= "down (" . (curPosY - lastPosY) . "), "
            lastPosY := curPosY
        }
        else if (curPosY < lastPosY) {
            changestr .= "up (" . (lastPosY - curPosY) . "), "
            lastPosY := curPosY
        }
    }
    ToolTip, %changestr%
    
    return