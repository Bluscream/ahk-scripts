class Control {
    id := ""
    type := ""
    index := 0
    text := ""
    bounds := [0,0,0,0]
    window := 0
    __New(id, window := 0) {
        this.id := id
        RegExMatch(this.id, "^([^0-9]*)(.*)$", type)
        this.type := type1
        this.index := type2
        this.window := window
        ; this.bounds := this.getBounds()
        ; this.text := this.getText()
    }
    getBounds() {
        ControlGetPos, X, Y, W, H, % this.id, % this.window.str()
        return [X,Y,W,H]
    }
    getText() {
        ControlGetText, ControlText, % this.id, % this.window.str()
        return ControlText
    }
    click(ClickCount, Options) {
        ControlClick, % this.id, % this.window.str(),, left
    }
    focus() {
        ControlFocus, % this.id, % this.window.str()
    }
    send(msg, raw := false) {
        if (raw)
            ControlSendRaw, % this.id, % msg, % this.window.str()
        else
            ControlSend, % this.id, % msg, % this.window.str()
    }
    move(x,y,w,h) {
        ControlMove, % this.id, x ?? this.bounds[1], y ?? this.bounds[2], w ?? this.bounds[3], h ?? this.bounds[4], % this.window.str()
    }

}