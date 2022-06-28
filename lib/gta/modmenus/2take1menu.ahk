#Include <modmenu>
class TwoTakeOneModMenu extends ModMenu {
    name := "2Take1Menu"
    autoStart() {
        process := this.game.windows["PlayGTAV"].process
        ; window := new Window("GDI+ Window (Launcher.exe)", "GDI+ Hook Window Class", "Launcher.exe").str()
        ; DetectHiddenWindows, On
        scriptlog("Waiting for process " . process.str())
        while(this.enabled) {
            process.wait()
            if (not this.running()) {
                scriptlog("Launching " . this.str())
                this.start()
            }
            SleepS(1)
        }
        scriptlog(this.name . "no longer enabled")
    }
}
; u8Mi8noIixnWdvgjn0kP7fmG6TZ8gwJ
; ahk_class u8Mi8noIixnWdvgjn0kP7fmG6TZ8gwJ
; ahk_exe Launcher.exe

