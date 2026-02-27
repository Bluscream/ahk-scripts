#NoEnv
#SingleInstance Force
#Persistent

#Include <bluscream>
EnforceAdmin()
SendMode, Event ; |Play|Input|InputThenPlay
SetKeyDelay, 39, 27

SetDefaultMouseSpeed, 50
SendMode InputThenPlay

gamewindow := get_game_window()
OutputDebug, % """" . gamewindow . """"

findmatchbuttonpos := [290, 859]
findmatchbuttoncolor := "0C1E23"

; Timer variables for middle mouse button automation
timerActive := false
timerInterval := 30000  ; 30 seconds in milliseconds

F8:: Click, findmatchbuttonpos[1], findmatchbuttonpos[2]

F12::
    timerActive := !timerActive
    if (timerActive) {
        SetTimer, MiddleMouseTimer, %timerInterval%
        OutputDebug, Middle mouse timer started - pressing every 30 seconds
    } else {
        SetTimer, MiddleMouseTimer, Off
        OutputDebug, Middle mouse timer stopped
    }
return

MiddleMouseTimer:
    Click, Middle
    OutputDebug, Middle mouse button pressed
return

return

get_game_window() {
    title := "Call of Duty"
    class := "COD"
    exe := "cod.exe"
    WinGet, id, List
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        WinGetClass, this_class, ahk_id %this_id%
        WinGet, this_exe, ProcessName, ahk_id %this_id%
        if (InStr(clean_str(this_title), clean_str(title)) & InStr(clean_str(this_class), clean_str(class))) {
            return this_id
        }
    }
}

clean_str(str) {
    return StrReplace(str, Chr(0x200B), "")
}