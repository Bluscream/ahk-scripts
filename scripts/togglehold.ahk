#Persistent
; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
#InstallKeybdHook
#InstallMouseHook
#Include <AllKeyBinder>
winid := 0
repeatkey := ""
repeattimer := 500
kb := new AllKeyBinder(Func("OnKeyPressed"))
return

OnKeyPressed(type, code, name, state) {
    global repeatkey
    global repeattimer
    global winid
    if (name != "PgUp" && name != "PgDn" && state == 1) {
        is_repeatkey_held := GetKeyState("PGUP", "P")
        is_togglekey_held := GetKeyState("PGDN", "P")
        ; Tooltip % "Type: " type ", Code: " code ", Name: " name ", State: " state ", Toggle: " is_togglekey_held ", Repeat: " is_repeatkey_held
        if (is_repeatkey_held) {
            if (type == "Mouse") {
                if (code == 6) { ; WheelUp
                    repeattimer := repeattimer + 100
                    ToolTip, % "Repeat TIMER is " . repeattimer . "MS"
                    Sleep, 250
                    ToolTip, % ""
                    if (repeatkey)
                        SetTimer, RepeatKey, % repeattimer
                } else if (code == 7) { ; WheelDown
                    if (repeattimer > 0)
                        repeattimer := repeattimer - 100
                    ToolTip, % "Repeat TIMER is " . repeattimer . "MS"
                    Sleep, 250
                    ToolTip, % ""
                    if (repeatkey)
                        SetTimer, RepeatKey, % repeattimer
                } else {
                    if (repeatkey) {
                        ToolTip, % "Repeat OFF for " . repeatkey . " (" . repeattimer . "MS)"
                        repeatkey := ""
                        SetTimer, RepeatKey, Off
                        Sleep, 500
                        ToolTip, % ""
                    } else {
                        repeatkey := name
                        WinGet, winid, ID, A
                        ToolTip, % "Repeat ON for " . repeatkey . " (" . repeattimer . "MS)"
                        SetTimer, RepeatKey, % repeattimer
                        Sleep, 500
                        ToolTip, % ""
                    }
                }
            } else if (repeatkey) {
                ToolTip, % "Repeat OFF for " . repeatkey . " (" . repeattimer . "MS)"
                repeatkey := ""
                SetTimer, RepeatKey, Off
                Sleep, 500
                ToolTip, % ""
            } else {
                repeatkey := name
                WinGet, winid, ID, A
                ToolTip, % "Repeat ON for " . repeatkey . " (" . repeattimer . "MS)"
                SetTimer, RepeatKey, % repeattimer
                Sleep, 500
                ToolTip, % ""
            }
        } else if (is_togglekey_held) {
            ToolTip, % "Holding " . name . " down"
            Sleep, 500
            ToolTip, % ""
            Sleep, 500
            WinGet, winid, ID, A
            ; Send % "{" . name . " down}"
            ControlSend,, % "{" . name . " down}", ahk_id %winid%
        }
    }
}

RepeatKey:
    ; Send % "{" . repeatkey . "}"
    ; Tooltip % "RepeatKey: " . repeatkey . " (" . winid . ")"
    ControlSend,, {%repeatkey%}, ahk_id %winid%
    ; Loop {
    ;     If ! GetKeyState( repeatkey, "P" )
    ;        Break
    ;        Sleep 1 
    ; }
    ; ControlSend,, % "{" . repeatkey . " up}", ahk_id %repeatpid%
    return