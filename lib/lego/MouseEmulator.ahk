#Include <bluscream>

#SingleInstance Force
; #Persistent

global lastPosX := 0
global lastPosY := 0

ResetCursor() {
    MouseMove, winMiddleX, winMiddleY
}

WatchCursor() {
    MouseGetPos, curPosX, curPosY
    curPosX := Round(curPosX)
    curPosY := Round(curPosY)
    Xchanged := curPosX != lastPosX
    Ychanged := curPosY != lastPosY
    if (!Xchanged && !Ychanged) {
        ShowToolTip("No Change")
        return
    }
    Xcentered := curPosX == winMiddleX
    Ycentered := curPosY == winMiddleY
    if (Xcentered && Ycentered) {
        ShowToolTip("Centered")
        return
    }
    changestr := "Moved "
    if (Xchanged) {
        if (curPosX > lastPosX) {
            changeX := curPosX - lastPosX
            changestr .= "right"
            lastPosX := curPosX
            PressKeyAHI("Right", 1, 80)
        }
        else {
            changeX := lastPosX - curPosX
            changestr .= "left"
            lastPosX := curPosX
            PressKeyAHI("Left", 1, 80)
        }
        changestr .= " (" . changeX . "), "
    }
    if (Ychanged) {
        if (curPosY > lastPosY) {
            changeY := curPosY - lastPosY
            changestr .= "down"
            lastPosY := curPosY
            PressKeyAHI("Down", 1, 80)
        }
        else {
            changeY := lastPosY - curPosY
            changestr .= "up"
            lastPosY := curPosY
            PressKeyAHI("Up", 1, 80)
        }
        changestr .= " (" . changeY . "), "
    }
    ShowToolTip(changestr)
    return
}