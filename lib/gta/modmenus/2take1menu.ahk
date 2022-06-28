#Include <modmenu>
class TwoTakeOneModMenu extends ModMenu {
    name := "2Take1Menu"
    autoStart() {
        window := new Window("GDI+ Window (Launcher.exe)", "GDI+ Hook Window Class", "Launcher.exe").str()
        DetectHiddenWindows, On
        scriptlog("Waiting for window " . window)
        while(this.enabled) {
            WinWait, % window
            if (not this.running()) {
                this.start()
            }
            SleepS(1)
        }
    }
}
; u8Mi8noIixnWdvgjn0kP7fmG6TZ8gwJ
; ahk_class u8Mi8noIixnWdvgjn0kP7fmG6TZ8gwJ
; ahk_exe Launcher.exe

