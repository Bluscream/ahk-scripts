#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SendMode Input
SetBatchLines -1
Process Priority,, High
#InputLevel 1
#InstallKeybdHook
#InstallMouseHook
#UseHook, On

CommandLine := DllCall("GetCommandLine", "Str")

If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
    Try {
        If (A_IsCompiled) {
            Run *RunAs "%A_ScriptFullPath%" /restart
        } Else {
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
    }
    ExitApp
}
Numpad6::Media_Prev
Numpad7::Media_Play_Pause
Numpad8::Media_Next

; Volume Up/Down
Numpad3::Spotify_HotkeySend("{LControl down}{LShift down}{Down down}")
Numpad4::Spotify_HotkeySend("{LControl down}{Down down}")
Numpad5::Spotify_HotkeySend("{LControl down}{Up down}")

; Shuffle
Numpad2::Spotify_HotkeySend("{LControl down}{s down}")

Numpad1::Run spotify://




; Global variable to cache the Spotify Window ID once it's been found
global cached_spotify_window := 0

; FUNCTION: Send a hotkey string to Spotify 
Spotify_HotkeySend(hotkeyString) {
    DetectHiddenWindows, On
    DetectHiddenText, On
    winId := Get_Spotify_Id()
    ControlFocus, , ahk_id %winId%
    ControlSend, , %hotkeyString%, ahk_id %winId%
    DetectHiddenWindows, Off
    DetectHiddenText, Off
    return
}

; FUNCTION: Get the ID of the Spotify window (using cache)
Get_Spotify_Id() {
    if (Is_Spotify(cached_spotify_window)) {
        return cached_spotify_window
    }

    WinGet, windows, List, ahk_exe Spotify.exe
    Loop, %windows% {
        winId := windows%A_Index%
        if (Is_Spotify(winId)) {
            cached_spotify_window = %winId%
            return winId
        }
    }
}

; FUNCTION: Check if the given ID is a Spotify window
Is_Spotify(winId) {
    WinGetClass, class, ahk_id %winId%
    if (class == "Chrome_WidgetWin_0") {
        WinGetTitle, title, ahk_id %winId%
        return (title != "")
    }
    return false
}
