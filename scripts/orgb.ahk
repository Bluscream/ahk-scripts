#SingleInstance Force
#NoEnv
; #Persistent
SetWorkingDir %A_ScriptDir%
#Include <bluscream>
; SleepS(15)
global noui := true
scriptlog(A_ScriptFullPath . " " .  Join(" ", A_Args))
#Include <openrgb>

server := new OpenRGB()

profiles := ["backlight"]

for i, profile in profiles {
    Loop, 25 {
        server.load_profile(profile)
        Sleep, 25
    }
    Sleep, 1500
}
ExitApp