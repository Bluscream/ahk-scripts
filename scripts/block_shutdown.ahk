; AHK v1
#SingleInstance Force
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
global ask := false

; Check for /block command line argument
Loop, %A_Args%
    {
        StringLower, lowerarg, A_LoopField
        scriptlog("Checking argument: " . lowerarg)
        if (lowerarg = "/block") {
            block := true
        } else if (lowerarg = "/loop") {
            SetTimer, AbortShutdownTimer, 1000
            ; AbortShutdownLoop()
        } else if (lowerarg = "/ask") {
            ask := true
        }
    }

; Initialize Tray Menu
Menu, Tray, Add, Ask For Confirmation, ToggleAsk
Menu, Tray, Add, Block Shutdown, ToggleBlock
Menu, Tray, Default, Block Shutdown
Menu, Tray, Tip, Block Shutdown Control
if (block)
    Menu, Tray, Check, Block Shutdown
if (ask)
    Menu, Tray, Check, Ask For Confirmation

DllCall("kernel32.dll\SetProcessShutdownParameters", "UInt", 0x4FF, "UInt", 0) ; DllCall is optional: it tells the OS to shut down this script first (prior to all other applications).
OnMessage(0x11, "WM_QUERYENDSESSION") ; Catch OS shutdown requests
OnExit, ExitSub ; Catch script shutdown requests
return

ToggleBlock:
    block := !block
    Menu, Tray, ToggleCheck, Block Shutdown
    return

ToggleAsk:
    ask := !ask
    Menu, Tray, ToggleCheck, Ask For Confirmation
    return

AbortShutdownTimer:
    RunWait, shutdown /a,, Hide
    return
; AbortShutdownLoop(interval := 1000) {
;     Loop {
;         RunWait, shutdown /a,, Hide
;         Sleep, % interval
;     }
; }

ExecuteEventDir(event) {
    event_dir := new Paths.User().programs.Combine(event)
    if (!event_dir.exists()) {
        event_dir.create()
        scriptlog("Created event_dir: " . event_dir.Quote())
    } else {
        for i, file in event_dir.getFiles() {
            scriptlog("Executing " . file.Quote() )
            file.run()
        }
    }
}

WM_QUERYENDSESSION(wParam, lParam)
{
    global ENDSESSION_LOGOFF := 0x80000000
    EventType := "Unknown"
    if (lParam & ENDSESSION_LOGOFF) ; User is logging off.
        EventType := "Logoff"
    else ; System is either shutting down or restarting.
        EventType := "Shutdown"
    ExecuteEventDir(EventType . "Request")
    if (!block) ; Only block if block variable is true
        ExecuteEventDir(EventType)
        return true
    try {
        BlockShutdown(%A_ScriptName% . " is blocking " . EventType)
    } catch {
        MsgBox, 0x10, Error, % "Error: " . A_LastError
    }
    if (ask) {
        MsgBox 0x4, Confirm %EventType%, %EventType% in Progress.`nAllow it?
        IfMsgBox Yes, {
            try {
                StopBlockingShutdown()
            } catch {
                MsgBox, 0x10, Error, % "Error: " . A_LastError
            }
            ExecuteEventDir(EventType)
            return true ; Tell the OS to allow the shutdown/logoff to continue.
        } Else IfMsgBox No, {
            ExecuteEventDir(EventType . "Block")
            return false ; Tell the OS to abort the shutdown/logoff.
        }
    }
    ExecuteEventDir(EventType . "Block")
    return false
}

BlockShutdown(Reason)
{
    DllCall("ShutdownBlockReasonCreate", "ptr", A_ScriptHwnd, "wstr", Reason)
    OnExit("StopBlockingShutdown")
}

StopBlockingShutdown()
{
    OnExit(A_ThisFunc, 0)
    DllCall("ShutdownBlockReasonDestroy", "ptr", A_ScriptHwnd)
}

ExitSub:
    if (block) {
        RunWait, shutdown /a,, Hide
    }
    if (ask) {
        MsgBox 0x4, Confirm exit?, Something tried to stop %A_ScriptName% (Reason: %A_ExitReason%).`nAllow it?
        IfMsgBox Yes, {
            ExitApp
        }
        return
    }
    ExitApp
