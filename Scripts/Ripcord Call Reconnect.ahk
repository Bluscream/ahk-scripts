#Warn,, StdOut

#Include <bluscream>
#INCLUDE <Acc>

#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
;
global rc_title := "ahk_class Qt5QWindowIcon ahk_exe Ripcord.exe"
global vc_title := "Ripcord Voice Chat " . rc_title

global texts := { "Waiting for server":0, "Opening WebSocket":0, "Connected":0, "Disconnected":0 }
global old_status := ""



checkCallStatus() {
    MsgBox % getCallStatus()
}

getCallStatus() {
    return Acc_Get("Name", "4.1.10", 0, vc_title)
}

onTextChanged(hHook, event, hWnd, idObject, idChild, eventThread, eventTime) {
    acc := Acc_ObjectFromEvent(_idChild_, hWnd, idObject, idChild)
    try {
        if (acc.accRole(0) == 41) {
            call_status := acc.accName(0)
            if (texts.HasKey(call_status) == 1) {
                onCallStatusChanged(call_status)
            }
        }
    } catch e {
        ScriptLog("Failed onTextChanged: " . e)
    }
}

onCallStatusChanged(new_status) {
    if (new_status == old_status) {
        return
    }
    ScriptLog("Call Status Changed | Old: " . old_status . "`t`tNew: " . new_status)
    if (new_status == "Disconnected") {
        ScriptLog("Call was disconnected, checking again in 5 seconds...")
        SetTimer, ReCheckCallStatus, 5000
    }
    old_status := new_status
}

ReCheckCallStatus:
    SetTimer, ReCheckCallStatus, Off
    if (getCallStatus() == "Disconnected") {
        ScriptLog("Call is still disconnected, recalling...")
        WinClose, % vc_title
    }

hook() {
    pCallback := RegisterCallback("onTextChanged")
    Acc_SetWinEventHook(0x800C, 0x800C, pCallback)
    ScriptLog("Hooked onTextChanged to " . pCallback)
}
unhook() {
    Acc_UnhookWinEvent(pCallback)
}

^q::hook()
^w::unhook()
^e::checkCallStatus()