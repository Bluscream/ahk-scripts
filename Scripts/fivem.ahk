#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
SendMode, InputThenPlay ; Event|Play|Input|InputThenPlay

#Include <bluscream>
EnforceAdmin()
global noui := false
scriptlog("start")
global enabled := false
global interval := 1000
return

F6::toggle()
return

toggle() {
    if (!enabled) {
        enabled := true
        CreateInterval()
        SetTimer, runChecks, % interval
        scriptlog("enabled")
    } else {
        enabled := false
        SetTimer, runChecks, Off
        scriptlog("disabled")
    }
    return
}
runChecks() {
    scriptlog("pressing with sendmode " . A_SendMode)
    ;PressKey(key, presses=1, sleepms=80, keyms=20, verbose=false, msg="", raw=false) {
    ; PressKey("E", 1, 80, 20, false, "", true)
    Send {Raw}e
    ; PressKeyDLL("e", 1, 60)
    interval = CreateInterval()
    return
}

CreateInterval() {
    Random, interval, 500, 1500
    scriptlog("New interval: " . interval)
    return interval
}