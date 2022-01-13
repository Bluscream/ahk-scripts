#SingleInstance Force
SetWorkingDir %A_ScriptDir%
#Include <bluscream>
; EnforceAdmin()
global noui := false
scriptlog("init start")
global subscribed_windows := []
#Include <automagic>
global am := new AutoMagic("Timo-Tablet")

am.createToast("Test")
am.lock()
am.off()

SleepS(2)
am.on()
am.unlock()