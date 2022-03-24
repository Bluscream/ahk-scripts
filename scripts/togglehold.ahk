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
repeatkey := ""
repeattimer := 500
kb := new AllKeyBinder(Func("OnKeyPressed"))
return

OnKeyPressed(type, code, name, state) {
    global repeatkey
    global repeattimer
    if (name != "PgUp" && name != "PgDn" && state == 1) {
        is_repeatkey_held := GetKeyState("PGUP", "P")
        is_togglekey_held := GetKeyState("PGDN", "P")
        ; Tooltip % "Type: " type ", Code: " code ", Name: " name ", State: " state ", Toggle: " is_togglekey_held ", Repeat: " is_repeatkey_held
        if (is_repeatkey_held) {
            if (type == "Mouse") {
                if (code == 6) { ; WheelUp
                    repeattimer := repeattimer + 500
                    ToolTip, % "Repeat TIMER is " . repeattimer . "MS"
                    Sleep, 500
                    ToolTip, % ""
                } else if (code == 7) { ; WheelDown
                    if (repeattimer > 0)
                        repeattimer := repeattimer - 500
                    ToolTip, % "Repeat TIMER is " . repeattimer . "MS"
                    Sleep, 500
                    ToolTip, % ""
                } else {
                    if (repeatkey) {
                        ToolTip, % "Repeat OFF for " . repeatkey
                        repeatkey := ""
                        SetTimer, RepeatKey, Off
                        Sleep, 500
                        ToolTip, % ""
                    } else {
                        repeatkey := name
                        ToolTip, % "Repeat ON for " . repeatkey
                        SetTimer, RepeatKey, % repeattimer
                        Sleep, 500
                        ToolTip, % ""
                    }
                }
            } else if (repeatkey) {
                ToolTip, % "Repeat OFF for " . repeatkey
                repeatkey := ""
                SetTimer, RepeatKey, Off
                Sleep, 500
                ToolTip, % ""
            } else {
                repeatkey := name
                ToolTip, % "Repeat ON for " . repeatkey
                SetTimer, RepeatKey, % repeattimer
                Sleep, 500
                ToolTip, % ""
            }
        } else if (is_togglekey_held) {
            ToolTip, % "Toggle ON for " . togglekey
            Sleep, 500
            ToolTip, % ""
            Sleep, 500
            Send % "{" . togglekey . " down}"
        }
    }
}

RepeatKey:
    Send % "{" . repeatkey . "}"
    return