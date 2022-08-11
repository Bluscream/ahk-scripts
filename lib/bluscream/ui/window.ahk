WinStr(id) {
    WinGetClass, class, ahk_id %id%
    WinGetTitle, title, ahk_id %id%
    WinGet, exe, ProcessName, ahk_id %id%
    return (title ? title : "") . (class ? (" ahk_class " . class) : "") . (exe ? (" ahk_exe " . exe) : "") . (id ? (" ahk_id " . id) : "")
}

class Window {
    title := ""
    class := ""
    exe := ""
    process := new Process()
    file := new File()
    id := ""
    text := ""

    __New(title := "", class := "", exe :="", path := "", id := 0) {
        this.title := title
        this.class := class
        this.exe := exe
        this.process := new Process(exe)
        ; this.file := this.process.file
        this.id := id
        this.file := (path ? new File(path) : new File(exe))
        WinGetText, text, % "ahk_id " . id
        this.text := text
    }

    fromId(id) {
        idstr := "ahk_id " . id
        WinGetTitle, title, % idstr
        WinGetClass, class, % idstr
        WinGet, exe, ProcessName, % idstr
        return new Window(title, class, exe, "", id)
    }

    fromString(str) {
        splt := StrSplit(str, " ahk_")
        for i, part in split {
            if (startsWith(part, "class"))
                class := StrReplace(part, "class ", "", 0, 1)
            else if (startsWith(part, "exe"))
                exe := StrReplace(part, "exe ", "", 0, 1)
            else if (startsWith(part, "id"))
                id := StrReplace(part, "id ", "", 0, 1)
            else title := part
        }
        return new Window(title, class, exe, "", id)
    }

    str() {
        return (this.title ? this.title : "") . (this.class ? (" ahk_class " . this.class) : "") . (this.exe ? (" ahk_exe " . this.exe) : "") . (this.id ? (" ahk_id " . this.id) : "")
    }
    
    exists() {
        return WinExist(this.str())
    }
    wait(active := False) {
        if (!no_ui) {
            scriptlog("Waiting for window " . this.str() . " to " . (active ? "become active" : "exist") . "...")
        }
        if (active) {
            WinWaitActive, % this.str()
        } else {
            WinWait, % this.str()
        }
        if (!no_ui) {
            scriptlog("Window " . this.str() . " " . (active ? "active" : "found") . "!")
        }
    }
    waitActive() {
        this.wait(True)
    }
    waitInactive() {
        
        if (!no_ui) {
            scriptlog("Waiting for window " . this.str() . " to become inactive...")
        }
        WinWaitNotActive, % this.str()
        if (!no_ui) {
            scriptlog("Window " . this.str() . " inactive!")
        }
    }
    pid() {
        WinGet, pid, PID, % this.str()
        return pid
    }
    bottom() {
        WinSet, Bottom ,, % this.str()
    }
    alwaysOnTop(toggle := true) {
        WinSet, AlwaysOnTop , % toggle, % this.str()
    }
    isActive() {
        return WinActive(this.str())
    }
    isMinimized() {
        WinGet MMX, MinMax, % this.str()
        return (MMX == -1)
    }
    deactivate(wait := false) {
        this.alwaysOnTfop(false)
        ; WinSet, Style, 0x10000000, % this.str() ; WS_VISIBLE
        ; WinSet, Style, -0x1000000, % this.str() ; WS_MAXIMIZE
        ; WinSet, Style, 0x20000000, % this.str() ; WS_MINIMIZE
        ; WinSet, Style, +0x20000, % this.str() ; WS_MINIMIZEBOX
        this.minimize()
        this.bottom()
        if (wait) {
            this.waitInactive()
        }
    }
    minimize() {
        WinMinimize, % this.str()
    }
    maximize() {
        WinMaximize, % this.str()
    }
    restore() {
        WinRestore, % this.str()
    }
    hide() {
        WinHide, % this.str()
    }
    show() {
        WinShow, % this.str()
    }
    activate(wait := false, full := false) {
        WinActivate, % this.str()
        if (full && !this.isActive()) {
            scriptlog("WinActivate was not enough to get " . this.str() . " to focus!")
            this.show()
            this.restore()
            if (!this.isActive()) {
                scriptlog("this.show() & this.restore() was not enough to get " . this.str() . " to focus!")
                PostMessage, 0x112, 0xF030
            }
            if (!this.isActive()) {
                scriptlog("PostMessage, 0x112, 0xF030 was not enough to get " . this.str() . " to focus!")
                ControlSend,, ! x, % this.str()
            }
            if (!this.isActive()) {
                scriptlog("ControlSend,, ! x was not enough to get " . this.str() . " to focus!")
                Send ! x
            }
            if (!this.isActive()) {
                scriptlog("Send ! x was not enough to get " . this.str() . " to focus!")
                this.maximize()
            }
        }
        WinActivate, % this.str()
        if (wait) {
            this.wait(True)
        }
    }
    close() {
        WinClose, % this.str()
        return !this.exists()
    }
    pos() {
       ;WinGetPos, X, Y, Width, Height, WinTitle, WinText, ExcludeTitle, ExcludeText]
        WinGetPos,x,y,w,h, % this.str()
        cw := w
        ch := h
        ch /= 2 
        cw -= 1
        cw /= 2
        return { "x": x, "y": y, "w": w, "h": h, "center": { "w": cw, "h": ch } }
    }
    controls() {
        WinGet, ControlList, ControlList, % this.str()
        lst := []
        Loop, Parse, ControlList, `n
        {
            cntrl := new Control(A_LoopField)
            ControlGetPos, X, Y, W, H, % A_LoopField, % this.str()
            cntrl.bounds := [X,Y,W,H]
            ControlGetText, ControlText, % A_LoopField, % this.str()
            cntrl.text := ControlText
            lst.push(cntrl)
        }
        return lst
    }
    enableAllControls() {
        WinGet, ControlList, ControlList, % this.str()
        Loop, Parse, ControlList, `n
        {
            Control, Enable,, % A_LoopField, % this.str()
        }
    }
    showAllControls() {
        WinGet, ControlList, ControlList, % this.str()
        Loop, Parse, ControlList, `n
        {
            Control, Show,, % A_LoopField, % this.str()
        }
    }
}