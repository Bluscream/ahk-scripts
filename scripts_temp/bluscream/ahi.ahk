#Include <AutoHotInterception>
global AHI := false
PressKeyAHI(key, presses=1, keyms=100){
    if (!AHI) {
        AHI := new AutoHotInterception()
    }
    loop, % presses {
        AHI.SendKeyEvent(1, GetKeySC(key), 1)
        Sleep, %keyms%
        AHI.SendKeyEvent(1, GetKeySC(key), 0)
    }
}
DownKeyAHI(key){
    if (!AHI) {
        AHI := new AutoHotInterception()
    }
    AHI.SendKeyEvent(1, GetKeySC(key), 1)
}
UpKeyAHI(key){
    if (!AHI) {
        AHI := new AutoHotInterception()
    }
    AHI.SendKeyEvent(1, GetKeySC(key), 0)
}