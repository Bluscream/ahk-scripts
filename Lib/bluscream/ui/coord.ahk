class Coordinate {
    x := 0
    y := 0
    z := 0
    w := 0
    h := 0
    window := 0
    __New(x1 = 0, y1 = 0, window := 0) {
        this.x := x1
        this.y := y1
        this.window := window
    }
    str() {
        return "X: " . this.x . " Y: " . this.y
    }
    getBounds() {
        return [this.x,this.y]
    }
    click(ClickCount=1, sleep_ms = 100) {
        if (!this.window.isActive())
            return
        MouseMove, this.x, this.y
        scriptlog("Clicking " . this.str() . " " . ClickCount . " times.")
        Loop % ClickCount {
            dllcall("mouse_event", Uint, 0x02, Uint, 0, Uint, 0, Uint, 0, UPtr, 0) ; Down
            sleep, 100
            dllcall("mouse_event", Uint, 0x04, Uint, 0, Uint, 0, Uint, 0, UPtr, 0) ; UP
            sleep, % sleep_ms
        }
    }
    swipeToCoord(coord) {
        if (!this.window.isActive())
            return
        MouseMove, this.x, this.y
        scriptlog("Swiping from " . this.str() . " to " . coord.str())
        dllcall("mouse_event", Uint, 0x02, Uint, 0, Uint, 0, Uint, 0, UPtr, 0) ; Down
        sleep, 50
        MouseMove, coord.x, coord.y, 5
        sleep, 50
        dllcall("mouse_event", Uint, 0x04, Uint, 0, Uint, 0, Uint, 0, UPtr, 0) ; UP
    }

}