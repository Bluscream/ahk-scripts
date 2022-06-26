; u8Mi8noIixnWdvgjn0kP7fmG6TZ8gwJ
; ahk_class u8Mi8noIixnWdvgjn0kP7fmG6TZ8gwJ
; ahk_exe Launcher.exe

global noui := false
class ModMenu {
    dir := new Directory()
    exe := new File()
    name := "2Take1Menu"
    version := ""
    page := ""
    row := 0
    rows := 0
    window := new Window()
    dsleep := 25
    game_window := new Window("Grand Theft Auto V", "grcWindow", "GTA5.exe").str()
    __New(path) {
        this.window :=  new Window("", "", "Launcher.exe")
        this.dir := new Directory(path)
        if (!this.dir.exists()) {
            MsgBox % this.name . " directory " . this.dir.Quote() . " does not exist!"
        }
        this.exe := this.dir.combineFile(this.window.exe)
    }
    start(wait := false) {
        this.kill()
        this.exe.run(wait)
    }
    kill() {
        window_closed := this.window.close()
        process_closed := this.window.process.close()
        process_killed := this.window.process.kill(true, true)
    }
    navigate(key, amount := 1) {
        Loop % amount {
            ; ControlSend,, key, % "Default IME ahk_exe modest-menu.exe"
            ; ControlSend,, key, % "ahk_id " . this.window.id
            ; ControlSend,, key, % "ahk_exe modest-menu.exe"
            ; ControlSend,, key, % "Grand Theft Auto V"
            Send, % key
            if (amount > 1)
                Sleep, dsleep
        }
    }
    waitForEnum(row, text, key := "{Right}") {
    }
    waitForRow(targetRow) {
    }
    waitForPage(targetPage, isSubPage := false) {
    }
    resetPage() {
        this.waitForPage("Main Menu")
    }
    resetPosition() {
        this.waitForRow(1)
    }
    getControls() {
    }

    getWindow(force := false) {
        if (!force && this.window.exists())
            return this.window
        WinGet, WinList, List
        Loop % WinList
        {   
            ID := "ahk_id " WinList%A_Index%
            WinGet, ProcessName, ProcessName, % ID
            If !ItemInList(ProcessName, [this.window.exe])
                Continue
            WinGetTitle, WinTitle, % ID
            If ItemInList(WinTitle, ["Default IME"])
                Continue
            wnd := new Window(WinTitle,, ProcessName)
            wnd.id := WinList%A_Index%
            this.window := wnd
            scriptlog("Found ModMenu Window: " . wnd.str())
            return wnd
        }
    }

}