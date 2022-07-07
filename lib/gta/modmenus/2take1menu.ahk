#Include <modmenu>
class TwoTakeOneModMenu extends ModMenu {
    name := "2Take1Menu"
    buttons := {}
    __New(path, window:="", game:="") {
        base.__New(path, window, game)
        this.buttons.inject := new Coordinate(321, 244, this.window)
    }
    autoStart() {
        base.autoStart(True, "PlayGTAV")
    }
    inject() {
        this.window.wait()
        CoordMode, Mouse, Client
        ; PostClick(this.window.exists(), this.buttons.inject.x, this.buttons.inject.y)
        this.window.activate(false, true)
        Sleep, 500
        this.buttons.inject.click(1, 100, "left", "", "")
        SleepS(1)
    }
}
; u8Mi8noIixnWdvgjn0kP7fmG6TZ8gwJ
; ahk_class u8Mi8noIixnWdvgjn0kP7fmG6TZ8gwJ
; ahk_exe Launcher.exe

; Screen:	1275, 790 (less often used)
; Window:	321, 244 (default)
; Client:	321, 244 (recommended)
; Color:	EEEBEE (Red=EE Green=EB Blue=EE)
