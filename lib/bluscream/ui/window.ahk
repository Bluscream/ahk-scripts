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

    fromTop() {
        static
        WinGet, hwnd, ID, A
        return Window.fromId(hwnd)
    }

    fromId(id) {
        static
        idstr := "ahk_id " . id
        WinGetTitle, title, % idstr
        WinGetClass, class, % idstr
        WinGet, exe, ProcessName, % idstr
        return new Window(title, class, exe, "", id)
    }

    fromString(str) {
        static
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
    isAlwaysOnTop() {
		WinGet, windowStyle, ExStyle, % this.str()
        WS_EX_TOPMOST := 0x8
		return if (windowStyle & WS_EX_TOPMOST) ? false : true
	}
    isActive() {
        return WinActive(this.str())
    }
    isMinimized() {
        WinGet MMX, MinMax, % this.str()
        return (MMX == -1)
    }
    isFullscreen(bRefreshRes = False) {
        Local iWinX, iWinY, iWinW, iWinH, iCltX, iCltY, iCltW, iCltH, iMidX, iMidY, iMonitor, c, D, iBestD
        
        ErrorLevel := False
        
        If bRefreshRes Or Not Mon0 {
            SysGet, Mon0, MonitorCount
            SysGet, iPrimaryMon, MonitorPrimary
            Loop %Mon0% { ;Loop through each monitor
                SysGet, Mon%A_Index%, Monitor, %A_Index%
                Mon%A_Index%MidX := Mon%A_Index%Left + Ceil((Mon%A_Index%Right - Mon%A_Index%Left) / 2)
                Mon%A_Index%MidY := Mon%A_Index%Top + Ceil((Mon%A_Index%Top - Mon%A_Index%Bottom) / 2)
            }
        }
        
        ;Get the active window's dimension
        hWin := WinExist(this.str())
        If Not hWin {
            ErrorLevel := True
            Return False
        }
        
        ;Make sure it's not desktop
        WinGetClass, c, ahk_id %hWin%
        If (hWin = DllCall("GetDesktopWindow") Or (c = "Progman") Or (c = "WorkerW"))
            Return False
        
        ;Get the window and client area, and style
        VarSetCapacity(iWinRect, 16), VarSetCapacity(iCltRect, 16)
        DllCall("GetWindowRect", UInt, hWin, UInt, &iWinRect)
        DllCall("GetClientRect", UInt, hWin, UInt, &iCltRect)
        WinGet, iStyle, Style, ahk_id %hWin%
        
        ;Extract coords and sizes
        iWinX := NumGet(iWinRect, 0), iWinY := NumGet(iWinRect, 4)
        iWinW := NumGet(iWinRect, 8) - NumGet(iWinRect, 0) ;Bottom-right coordinates are exclusive
        iWinH := NumGet(iWinRect, 12) - NumGet(iWinRect, 4) ;Bottom-right coordinates are exclusive
        iCltX := 0, iCltY := 0 ;Client upper-left always (0,0)
        iCltW := NumGet(iCltRect, 8), iCltH := NumGet(iCltRect, 12)
        
        ;Check in which monitor it lies
        iMidX := iWinX + Ceil(iWinW / 2)
        iMidY := iWinY + Ceil(iWinH / 2)
        
        ;Loop through every monitor and calculate the distance to each monitor
        iBestD := 0xFFFFFFFF
        Loop % Mon0 {
            D := Sqrt((iMidX - Mon%A_Index%MidX)**2 + (iMidY - Mon%A_Index%MidY)**2)
            If (D < iBestD) {
                iBestD := D
                iMonitor := A_Index
            }
        }
        
        ;Check if the client area covers the whole screen
        bCovers := (iCltX <= Mon%iMonitor%Left) And (iCltY <= Mon%iMonitor%Top) And (iCltW >= Mon%iMonitor%Right - Mon%iMonitor%Left) And (iCltH >= Mon%iMonitor%Bottom - Mon%iMonitor%Top)
        If bCovers
            Return True
        
        ;Check if the window area covers the whole screen and styles
        bCovers := (iWinX <= Mon%iMonitor%Left) And (iWinY <= Mon%iMonitor%Top) And (iWinW >= Mon%iMonitor%Right - Mon%iMonitor%Left) And (iWinH >= Mon%iMonitor%Bottom - Mon%iMonitor%Top)
        If bCovers { ;WS_THICKFRAME or WS_CAPTION
            bCovers := bCovers And (Not (iStyle & 0x00040000) Or Not (iStyle & 0x00C00000))
            Return bCovers ? iMonitor : False
        } Else Return False
    }
    deactivate(wait := false) {
        this.alwaysOnTop(false)
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
    hide(force:=false) {
        winStr := this.str()
        WinHide, % winStr
        if (force) {
            WinSet, Style, -0x80000, % winStr ; Remove WS_VISIBLE style
            WinSet, ExStyle, -0x80, % winStr ; Remove WS_EX_APPWINDOW style
            WinSet, ExStyle, -0x20, % winStr ; Remove WS_EX_TOPMOST style
            WinSet, Transparent, 255, % winStr ; Set transparency level (0-255)
            WinSet, ExStyle, +0x00000020, % winStr ; Add WS_EX_TRANSPARENT style ; Make the window click-through
            this.alwaysOnTop(false)
        }
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