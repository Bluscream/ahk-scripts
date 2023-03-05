#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

title := "Roblox ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe"

LoopActive := false ; initialize loop state to false

LoopToggleHotkey := F1 ; set hotkey to toggle loop state
LoopNotification := "AutoHotkey Script: Roblox loop is " ; set notification text

LoopNotify(state) { ; function to display loop state notification
    TrayTip, %LoopNotification%%state%, , 1
}

LoopToggle() { ; function to toggle loop state
    LoopActive := !LoopActive ; toggle loop state
    if (LoopActive) {
        LoopNotify("ON") ; display loop activated notification
        Loop()
    } else {
        LoopNotify("OFF") ; display loop deactivated notification
    }
}

Loop() {
    while (LoopActive) {
        WinActivate, ahk_class WINDOWSCLIENT ahk_exe RobloxPlayerBeta.exe
        SendInput, {Space}
        WinActivate, A
        Sleep, 1140000 ; wait 19 minutes (19 * 60 * 1000)
    }
}

; set hotkey to toggle loop state
Hotkey, %LoopToggleHotkey%, LoopToggle

; display initial loop state notification
LoopNotify("OFF")
