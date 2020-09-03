class Window {
    title := ""
    class := ""
    exe := ""
    process := new Process()
    ; file := new File()

    __New(title := "", class := "", exe :="") { ; , path := ""
        this.title := title
        this.class := class
        this.exe := exe
        this.process := new Process(exe, path)
        ; this.file := path ? new File(path) : new File(exe)
    }

    str() {
        return (this.title ? this.title : "") . (this.class ? (" ahk_class " . this.class) : "") . (this.exe ? (" ahk_exe " . this.exe) : "")
    }
    
    exists() {
        return WinExist(this.str())
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
    activate() {
        WinActivate, % this.str()
        WinWaitActive, % this.str()
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
}