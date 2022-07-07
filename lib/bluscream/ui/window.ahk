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
    wait() {
        scriptlog("Waiting for window " . this.str())
        WinWait, % this.str()
        scriptlog("Window " . this.str() . " found!")
    }
    pid() {
        WinGet, pid, PID, % this.str()
        return pid
    }
    isActive() {
        return WinActive(this.str())
    }
    isMinimized() {
        WinGet MMX, MinMax, % this.str()
        return (MMX == -1)
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
    show() {
        WinShow, % this.str()
    }
    activate(wait := false, full := false) {
        if (full) {
            this.restore()
            this.show()
        }
        WinActivate, % this.str()
        if (wait)
            WinWaitActive, % this.str()
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