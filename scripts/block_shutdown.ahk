; AHK v1
#SingleInstance Force
; #NoTrayIcon
#Persistent
SetKeyDelay, -1
SetMouseDelay, -1
Process, Priority, , Realtime
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#Include <bluscream>
global noui := false
EnforceAdmin()

global block := false

; The following DllCall is optional: it tells the OS to shut down this script first (prior to all other applications).
DllCall("kernel32.dll\SetProcessShutdownParameters", "UInt", 0x4FF, "UInt", 0)
OnMessage(0x11, "WM_QUERYENDSESSION")
OnExit, ExitSub
; AbortShutdownLoop()
return

AbortShutdownLoop(interval := 1000) {
    Loop {
        RunWait, shutdown /a,, Hide
        Sleep, % interval
    }
}

WM_QUERYENDSESSION(wParam, lParam)
{
    global ENDSESSION_LOGOFF := 0x80000000
    if (lParam & ENDSESSION_LOGOFF) ; User is logging off.
        EventType := "Logoff"
    else ; System is either shutting down or restarting.
        EventType := "Shutdown"
    try
    {
        ; Set a prompt for the OS shutdown UI to display. We do not display
        ; our own confirmation prompt because we have only 5 seconds before
        ; the OS displays the shutdown UI anyway. Also, a program without
        ; a visible window cannot block shutdown without providing a reason.
        BlockShutdown("Example script attempting to prevent " . EventType . ".")
        return false
    }
    catch
    {
        ; ShutdownBlockReasonCreate is not available, so this is probably
        ; Windows XP, 2003 or 2000, where we can actually prevent shutdown.
        MsgBox 0x4, Confirm %EventType%, %EventType% in Progress. Allow it?

        IfMsgBox Yes, {
            return true ; Tell the OS to allow the shutdown/logoff to continue.
        } Else IfMsgBox No, {
            return false ; Tell the OS to abort the shutdown/logoff.
        }
    }
}

BlockShutdown(Reason)
{
    ; If your script has a visible GUI, use it instead of A_ScriptHwnd.
    DllCall("ShutdownBlockReasonCreate", "ptr", A_ScriptHwnd, "wstr", Reason)
    OnExit("StopBlockingShutdown")
}

StopBlockingShutdown()
{
    OnExit(A_ThisFunc, 0)
    DllCall("ShutdownBlockReasonDestroy", "ptr", A_ScriptHwnd)
}

ExitSub:
    RunWait, shutdown /a,, Hide
    MsgBox 0x4, Confirm exit?, Something tried to stop %A_ScriptName% (Reason: %A_ExitReason%). Allow it?
    IfMsgBox Yes, {
        ExitApp
    }
    Return
