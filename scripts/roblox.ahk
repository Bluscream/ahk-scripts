#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#Include <bluscream>
EnforceAdmin()

title := "Roblox ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe"

LoopActive := false ; initialize loop state to false
LoopInterval := 19 * 60 * 1000 - 250 ; 1139700
LoopToggleHotkey := F1 ; set hotkey to toggle loop state
LoopNotification := "Roblox loop is " ; set notification text

LoopNotify(state) { ; function to display loop state notification
    global LoopNotification
    global LoopWindow
    TrayTip, %LoopNotification%, %state%, 1
    ; scriptlog(%LoopNotification%%state%)
    SplashScreen("AntiAFK ".state,"".LoopWindow) ; ToJson(LoopWindow)
    ; ShowToolTip(%LoopNotification%%state%)
}

LoopToggle() { ; function to toggle loop state
    global LoopActive
    global LoopInterval
    ; LoopActive := !LoopActive ; toggle loop state
    if (!LoopActive) {
        LoopActive := true
        LoopNotify("ON") ; display loop activated notification
        SetTimer, Loop, % LoopInterval
    } else {
        LoopActive := false
        LoopNotify("OFF") ; display loop deactivated notification
        SetTimer, Loop, Off
    }
}

Loop() {
    global LoopActive
    ; WinGet, OldWin, ID, A
    WinActivate, Roblox ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    WinWaitActive, Roblox ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
    ; Sleep, 250
    ; MouseClick, left, A_ScreenWidth/2, A_ScreenHeight/2
    Sleep, 250
    PressKeyScript("Space")
    ; Sleep, 250
    ; WinActivate, OldWin
}

; set hotkey to toggle loop state
F1::LoopToggle()

; display initial loop state notification
LoopNotify("OFF")

PressKeyScript(key, down := true, up := true, delay := 50) {
    global winid
    ; log("PressKeyScript: " . key . " " . (down ? "down" : "") . " " . (up ? "up" : "") . " " . (winid ? winid : "global") . " " . delay . "MS")
    if (winid) {
        if (down) {
            ControlSend,, % "{" . key . " down}", % winid
        }
        Sleep, % delay
        if (up) {
            ControlSend,, % "{" . key . " up}", % winid
        }
    } else {
        if (down) {
            Send % "{" . key . " down}"
        }
        Sleep, % delay
        if (up) {
            Send % "{" . key . " up}"
        }
    }
}
