﻿#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
#Include <bluscream>
EnforceAdmin()

; min_idle_seconds := 30 * 1000
timer_interval_seconds := 9 ; 1140000 ; wait 19 minutes (19 * 60 * 1000)
; sleep_between_moves_ms := 0


; SetTimer, runChecks, % timer_interval_seconds

; runChecks() {
;     if (A_TimeIdle > min_idle_seconds) {
;         MouseGetPos, OldX, OldY
;         MouseMove, OldX+1, OldY
;         Sleep, % sleep_between_moves_ms
;         MouseMove, OldX, OldY
;     }
; }

LoopActive := false ; initialize loop state to false
LoopWindow := "" ; initialize loop window title to empty string
LoopToggleHotkey := F1 ; set hotkey to toggle loop state
LoopNotification := "AntiAFK loop is " ; set notification text

LoopNotify(state) { ; function to display loop state notification
    scriptlog(%LoopNotification%%state%)
    ; SplashScreen("AntiAFK ".state) ; ToJson(LoopWindow)
    ; ShowToolTip(%LoopNotification%%state%)
}

LoopToggle() { ; function to toggle loop state
    LoopActive := !LoopActive ; toggle loop state
    if (LoopActive) {
        WinGet, LoopWindow, ID, A ; set loop window to active window
        LoopNotify("ON") ; display loop activated notification
        Loop()
    } else {
        LoopWindow := "" ; reset loop window
        LoopNotify("OFF") ; display loop deactivated notification
    }
}

Loop() {
    while (LoopActive) {
        WinActivate, %LoopWindow%
        SendInput, {Space}
        WinActivate, A
        Sleep, % timer_interval_seconds
    }
}
 
; set hotkey to toggle loop state
F1::LoopToggle()

; display initial loop state notification
LoopNotify("OFF")
