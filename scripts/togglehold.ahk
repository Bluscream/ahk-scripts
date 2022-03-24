#Persistent
; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
; #UseHook, On
#Include <AllKeyBinder>
togglekey := ""
repeatkey := ""
repeattimer := 500
kb := new AllKeyBinder(Func("OnKeyPressed"))
; SetTimer, Test, 5000
return

OnKeyPressed(type, code, name, state) {
    global togglekey
    global repeatkey
    global repeattimer
    if (name != "PgUp" && name != "PgDn" && state == 1) {
        is_repeatkey_held :=GetKeyState("PGUP", "P")
        is_togglekey_held := GetKeyState("PGDN", "P")
        ; if (is_repeatkey_held or is_togglekey_held) {
        ;     Tooltip % "Type: " type ", Code: " code ", Name: " name ", State: " state ", Toggle: " is_togglekey_held ", Repeat: " is_repeatkey_held
        ; }
        if (is_repeatkey_held) {
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
        } else if (is_togglekey_held) {
            if (togglekey) {
                ToolTip, % "Toggle OFF for " . togglekey
                togglekey := ""
                ; SetTimer, PressKey, Off
                Sleep, 500
                ToolTip, % ""
            } else {
                togglekey := name
                ToolTip, % "Toggle ON for " . togglekey
                ; SetTimer, PressKey, % repeattimer
                Sleep, 500
                ToolTip, % ""
                Sleep, 500
                Send % "{" . togglekey . " down}"
            }
        }
    }
}

RepeatKey:
    Send % "{" . repeatkey . "}"
    return

PressKey:
    Send % "{" . togglekey . " down}"
    return