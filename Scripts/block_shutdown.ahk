#SingleInstance Force
#Persistent
#InstallKeybdHook
#InstallMouseHook
ProcessSetPriority("Realtime")

; The following DllCall is optional: it tells the OS to shut down this script first (prior to all other applications).
DllCall("kernel32.dll\SetProcessShutdownParameters", "UInt", 0x4FF, "UInt", 0)
OnMessage(0x11, "WM_QUERYENDSESSION")
while (true) {
        exitcode := RunWait("shutdown /a",,"Hide")
    Sleep 500
}
return

WM_QUERYENDSESSION(wParam, lParam, *)
{
    ENDSESSION_LOGOFF := 0x80000000
    if (lParam & ENDSESSION_LOGOFF)  ; User is logging off.
        EventType := "Logoff"
    else  ; System is either shutting down or restarting.
        EventType := "Shutdown"
    try
    {
        ; Set a prompt for the OS shutdown UI to display.  We do not display
        ; our own confirmation prompt because we have only 5 seconds before
        ; the OS displays the shutdown UI anyway.  Also, a program without
        ; a visible window cannot block shutdown without providing a reason.
        BlockShutdown("Example script attempting to prevent " EventType ".")
        return false
    }
    catch
    {
        ; ShutdownBlockReasonCreate is not available, so this is probably
        ; Windows XP, 2003 or 2000, where we can actually prevent shutdown.
        Result := MsgBox(EventType " in progress. Allow it?",, "YN")
        if (Result = "Yes")
            return true  ; Tell the OS to allow the shutdown/logoff to continue.
        else
            return false  ; Tell the OS to abort the shutdown/logoff.
    }
}

BlockShutdown(Reason)
{
    ; If your script has a visible GUI, use it instead of A_ScriptHwnd.
    DllCall("ShutdownBlockReasonCreate", "ptr", A_ScriptHwnd, "wstr", Reason)
    OnExit("StopBlockingShutdown")
}

StopBlockingShutdown(*)
{
    OnExit(A_ThisFunc, 0)
    DllCall("ShutdownBlockReasonDestroy", "ptr", A_ScriptHwnd)
}