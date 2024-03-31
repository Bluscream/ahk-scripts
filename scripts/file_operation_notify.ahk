#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, BelowNormal
; #Include <bluscream>
; EnforceAdmin()

global title := "ahk_class OperationStatusWindow ahk_exe explorer.exe"

Loop {
    WinWait, % title
    OperationStarted("File Operation") ; The window is open, so call the function
    startTime := A_TickCount ; Capture the start time
    WinWaitClose, % title
    duration := (A_TickCount - startTime) ; Calculate the duration in milliseconds
    OperationCompleted("File Operation", duration) ; Pass the duration to the function
    Sleep, 1000 ; Wait a second before checking again
}
return

; f1:: ; Test the functions
;     OperationStarted("Test Operation")
;     Sleep, 5 ; Simulate a 61-second operation
;     OperationCompleted("Test Operation", 61)

OperationStarted(title) {
    WinNotify(title . " started", title . " has started.") ; Show a Windows 11 notification
}

OperationCompleted(_title, duration) {
    duration := Round(duration / 1000) ; Convert milliseconds to seconds and round to the nearest whole number
    title := _title . " complete"
    msg := _title . " took " . duration . " seconds to complete."
    WinNotify(title, msg) ; Show a Windows 11 notification
    if (duration > 10) {
        ; Execute actions for short operations
        Sleep, 300
        SoundBeep ; Sound a beep
        Sleep, 250
        SoundBeep ; Sound a beep
        Sleep, 200
        SoundBeep ; Sound a beep
    }
    if (duration > 60) {
        HassNotify(msg, title) ; Show a Home Assistant notification
    }
}

WinNotify(title, text) {
    cmd := "toast """ . title . """ """ . text . """"
    Run, % cmd, , Hide
}
HassNotify(title, text) {
    cmd := "powershell -ExecutionPolicy Bypass -File C:\Scripts\hass-notify.ps1 """ . title . """ """ . text . """"
    ; MsgBox % cmd
    Run, % cmd, , Hide
}
Notify(title, text) {
    cmd := "C:\Scripts\notify.bat """ . title . """ """ . text . """"
    RunWait, % cmd, , Hide
}