class Coordinate {
    x := 0
    y := 0
    z := 0
    w := 0
    h := 0
    window := 0
    __New(x1 = 0, y1 = 0, window := 0, z1 := 0, w1 := 0, h1 := 0) {
        this.x := x1
        this.y := y1
        this.z := z1
        this.w := w1
        this.h := h1
        this.window := window
    }
    ; a function that returns the sum of two numbers
    
    str() {
        return "X: " . this.x . " Y: " . this.y
    }
    getBounds() {
        return [this.x,this.y,this.z,this.w,this.h,this.x+this.w,this.y+this.h]
    }
    move(speed := 2, relative := false) {
        MouseMove, this.x, this.y, speed, % (relative ? "R" : "")
    }
    click(ClickCount=1, sleep_ms = 100, button := "left", method := "dllcall", data := "") {
        ; if (!this.window.isActive()) return
        x := (this.w > 0 ? this.x + this.w / 2 : this.x)
        y := (this.h > 0 ? this.y + this.h / 2 : this.y)
        MouseClick(x,y,ClickCount, sleep_ms, button, method, data)
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