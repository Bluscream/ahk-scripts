#Include <bluscream>
class ModMenu {
    name := "Mod Menu"
    exe := new File()
    version := ""
    window := new Window()
    enabled := False
    game := ""
    __New(path, window:="", game:="") { ; , name:=""
        this.exe := new File(path)
        if (!this.exe.exists()) {
            MsgBox % this.name . " file " . this.exe.Quote() . " does not exist!"
        }
        FileGetVersion, version, % this.exe.path
        this.version := version
        ; this.name := name ? name : "Mod Menu"
        this.window := window ? window : this.getWindow(True)
        this.game := game
        scriptlog("Created ModMenu instance " . this.name . " (" . toJson(this.window.exists()) . ") for Game " . this.game.name)
    }
    str() {
        return this.name . (this.running() ? "*" : "") . (this.version ? " v" . this.version : "") . " (""" . this.exe.path . """)"
    }
    running() {
        this.window := this.getWindow()
        return this.window.exists()
    }
    autoStart(process:=False,key:="game") {
        win := process ? this.game.windows[key].process : this.game.windows[key]
        scriptlog("Waiting for " . (process ? "process " : "window ") . win.str())
        while(this.enabled) {
            win.wait()
            if (not this.running()) {
                scriptlog("Launching " . this.str())
                this.start()
            }
            SleepS(1)
        }
        scriptlog(this.name . "no longer enabled")
    }
    start(wait := false) {
        this.kill()
        ; this.exe.run(wait)
        Run, % this.exe.path, % this.exe.directory.path, Min, menuPID
        this.pid := menuPID
    }
    kill() {
        window_closed := this.window.close()
        process_closed := this.window.process.close()
        process_killed := this.window.process.kill(true, true)
    }
    getWindow(force := false) {
        if (!force && this.window.exists())
            return this.window
        WinGet, WinList, List
        Loop % WinList
        {   
            ID := "ahk_id " WinList%A_Index%
            WinGet, ProcessName, ProcessName, % ID
            If !ItemInList(ProcessName, [this.exe.fullname])
                Continue
            WinGetTitle, WinTitle, % ID
            If ItemInList(WinTitle, ["Default IME", "GDI+ Window (Launcher.exe)","MSCTFIME UI","Rockstar Games Launcher"])
                Continue
            wnd := new Window(WinTitle,, ProcessName)
            wnd.id := WinList%A_Index%
            this.window := wnd
            return wnd
        }
    }
}