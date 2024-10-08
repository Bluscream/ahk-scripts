#Persistent
; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, Low
#Include <bluscream>
EnforceAdmin()
; #InstallKeybdHook
; #InstallMouseHook
#MaxHotkeysPerInterval, 250
global no_ui := true
#Include <AllKeyBinder>
repeatkey := ""
repeattimer := 500
repeatincrements := 50
winid := 0
kb := new AllKeyBinder(Func("OnKeyPressed"))
; log("ToggleHold Script Loaded")
return

OnKeyPressed(type, code, name, state) {
    global repeatkey
    global repeattimer
    global repeatincrements
    if (name != "PgUp" && name != "PgDn" && state == 1) {
        is_repeatkey_held := GetKeyState("PGUP", "P")
        is_togglekey_held := GetKeyState("PGDN", "P")
        ; log("Type: " type ", Code: " code ", Name: " name ", State: " state ", Toggle: " is_togglekey_held ", Repeat: " is_repeatkey_held)
        WinGet, winid, ID, A
        if (is_repeatkey_held) {
            if (type == "Mouse") {
                if (code == 6) { ; WheelUp
                    ChangeRepeatTimer(repeattimer + repeatincrements)
                    return
                } else if (code == 7) { ; WheelDown
                    ChangeRepeatTimer(repeattimer - repeatincrements)
                    return
                } else {
                    ToggleRepeatTimer(!repeatkey, name)
                }
            } else {
                ToggleRepeatTimer(!repeatkey, name)
            }
        } else if (is_togglekey_held) {
            ToggleHoldKey(name)
        }
    }
}
SetWindowId() {
    global winid
    if (!GetKeyState("NumLock", "T")) {
        WinGet, winid, ID, A
        ; scriptlog("NumLock enaged > set new window ID: " . winid)
    } else {
        winid := 0
    }
    
}
ToggleHoldKey(key) {
    Sleep, 500
    SetWindowId()
    PressKeyScript(key, true, false)
    log("Holding " . key . " down [WinID: " . winid . "]")
}
ToggleRepeatTimer(state, key) {
    global repeatkey
    global repeattimer
    if (state) {
        repeatkey := key
    }
    log("Repeat " . (state ? "ON" : "OFF") . " for " . repeatkey . " (" . repeattimer . "MS)")
    if (state) {
        SetWindowId()
        SetTimer, RepeatKey, % repeattimer
    } else {
        repeatkey := ""
        winid := 0
        SetTimer, RepeatKey, Off
    }
}

ChangeRepeatTimer(newtime) {
    global repeatkey
    global repeattimer
    if (newtime < 100) {
        newtime := 100
    }
    log("Repeat TIMER changed: " . repeattimer . "MS > " . newtime . "MS")
    repeattimer := newtime
    if (repeatkey) {
        SetTimer, RepeatKey, % repeattimer
    }
}

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

log(msg, showtime := 500) {
    ; scriptlog(msg)
    ToolTip, % msg
    Sleep, % showtime
    ToolTip, % ""
}

RepeatKey:
    PressKeyScript(repeatkey, true, true)
    return