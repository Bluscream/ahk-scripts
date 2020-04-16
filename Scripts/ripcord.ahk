#Include <bluscream>
#Include <JSON>
#INCLUDE <Acc>
#Include <logtail>

#SingleInstance, Force
#NoEnv
#Persistent
global rc_dir := "C:\Users\blusc\AppData\Local\Ripcord\"
global rc_exe := "Ripcord.exe"
Menu, Tray, Icon, % rc_dir . rc_exe, 1
; #NoTrayIcon
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
;
global rc_title := "ahk_class Qt5QWindowIcon ahk_exe " . rc_exe
global vc_title := "Ripcord Voice Chat " . rc_title

global log_pattern := "^(\d{4}-\d{2}-\d{2})\s+(\d{2}:\d{2}:\d{2}\.\d{3})\s+(\w+)\s(.*)$"
global msg_pattern := "^(\w+):\s+(.*)$"
global error_pattern := "^(.*): (\{.*\}) --- Error transferring (.*) - server replied: (.*)$"

global texts := { "Waiting for server":0, "Opening WebSocket":0, "Connected":0, "Disconnected":0 }
global old_status := ""

global check_delay_s := 5000

lt_chat := new LogTailer(rc_dir . "ripcord.log", Func("OnNewLogLine"), true) ; , "CP1200")

hook()
OnExit, ExitSub
return

ExitSub:
    unhook()
    ahk_exe := StrSplit(A_AhkPath, "\")
    for objItem in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process where Name = '" . ahk_exe[ahk_exe.MaxIndex()] . "'")
    {
        if (InStr(objItem.CommandLine, """" . A_ScriptFullPath . """")) {
            Process, Close, % objItem.ProcessId
        }
    }


OnNewLogLine(FileLine) {
    validLine := RegExMatch(FileLine, log_pattern, msg)
    if (!validLine){
        scriptlog("INVALID: " . FileLine)
        Return
    } else if (RegExMatch(msg4, msg_pattern, message)){
        ; lower := Format("{:L}", message2)
        if (RegExMatch(message2,error_pattern, error)){
            MsgBox % error2
            json := JSON.Load(error2)
            MsgBox, 0x10, % "Ripcord - " . error1 , % error4 . " (" . json.message . ")`r`n`r`n" . error3
        } else {
            ; scriptlog("msg4 " . msg4)
            ; scriptlog("lower " . lower)
        }
        Return
    } else {
        scriptlog("INVALID msg: " . msg)
    }
    Return
}


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
        ScriptLog("Call was disconnected, checking again in " . check_delay_s / 1000 . " seconds...")
        SetTimer, ReCheckCallStatus, % check_delay_s
    }
    old_status := new_status
}

ReCheckCallStatus:
    SetTimer, ReCheckCallStatus, Off
    if (getCallStatus() == "Disconnected") {
        text := "Call is still disconnected after " . check_delay_s / 1000 . " seconds, recalling..."
        ScriptLog(text)
        MsgBox,, "Ripcord Voice Call", % text
        WinClose, % vc_title
    }

hook() {
    pCallback := RegisterCallback("onTextChanged")
    Acc_SetWinEventHook(0x800C, 0x800C, pCallback)
    ; ScriptLog("Hooked onTextChanged to " . pCallback)
}
unhook() {
    Acc_UnhookWinEvent(pCallback)
}

; ^q::hook()
; ^w::unhook()
; ^e::checkCallStatus()