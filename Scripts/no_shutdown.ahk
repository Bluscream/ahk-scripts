#SingleInstance Force
#NoEnv
#Persistent
#InstallKeybdHook
#InstallMouseHook
; SetBatchLines -1
CoordMode Mouse, Client
#Include <bluscream>

hwnd := MakeInvisbleWindow()
hwnd := hwnd ? hwnd : WinActive("ahk_exe explorer.exe")
if (hwnd)
    success := DllCall("ShutdownBlockReasonCreate", "Ptr", hwnd, "Str", "Shutdown blocked!", "Int")
if (!hwnd || !success)
    MsgBox % "Could not hook ShutdownBlockReasonCreate!`n`nhwnd:" . hwnd . " success:" . success

return
; SetTimer, AbortShutdown, 500
; AbortShutdown:
while (true) {
    ; if (A_TimeIdlePhysical > 60000)
        RunWait, "shutdown" /a,, Min
    Sleep 1000
}

MakeInvisbleWindow() {
    Gui New, +LabelMain +hWndhwnd -Caption +Owner -0x10000000 +0x30000000 +0x38000000 -E0x8, Main
    Gui Show, w0 h0
    ; hwnd := WinExist("Ahk_PID " DllCall("GetCurrentProcessId"))
    WinSet, Transparent, 0, ahk_id %hwnd%
    WinSet, Bottom,, ahk_id %hwnd%
    WinHide, ahk_id %hwnd%
    return hwnd
}