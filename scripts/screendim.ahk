#SingleInstance, force
#NoEnv
#NoTrayIcon
#Persistent
#Include <bluscream>
EnforceAdmin()
global no_ui := True

twinkle_tray := new Paths.User().localappdata.CombineFile("Programs","twinkle-tray","Twinkle Tray.exe")
SetTimer, CheckIdleTime, 5000
; A_Args := [ "/menu" ]
for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/notimer") {
        SetTimer, CheckIdleTime, Off
    } else if (param == "/menu") {
        I_Icon := "C:\Windows\System32\shell32.dll"
        IfExist, %I_Icon%
            Menu, Tray, Icon, %I_Icon%, 26
        Menu, Tray, NoStandard
        Menu, tray, add
        Menu, tray, add, % "100 %", ScreenFullBright
        Menu, tray, add, % "50 %", ScreenHalfBright
        Menu, tray, add, % "1%", ScreenAlmostOff
        Menu, tray, add, % "0%", ScreenOff
        Menu, tray, add, % "Debug", Debug
    } else if (param == "/set") {
        SetBrightness()
    }
}

return

CheckIdleTime:
    ; log("A_TimeIdlePhysical: " + A_TimeIdlePhysical)
    if (A_TimeIdlePhysical > 1800000) {
        SetTimer, CheckIdleTime, Off
        log("Longer then 30 minutes idle")
        SetBrightness(0)
        KeyWaitAny("V")
        SetBrightness()
        SetTimer, CheckIdleTime, 5000
    }
    return

ScreenFullBright:
    SetBrightness(100)
    return

ScreenHalfBright:
    SetBrightness()
    return

ScreenAlmostOff:
    SetBrightness(1)
    return

ScreenOff:
    SetBrightness(0)
    return

Debug:
    return

log(txt) {
    ; scriptlog(StrReplace(txt, "\", "/"))
}

SetBrightness(value := 50) {
    global twinkle_tray
    log("Setting brightness to " . value)
    arguments := "--All --Overlay --Set=" . value
    twinkle_tray.run(false, "", arguments)
    cmd := """" . twinkle_tray.path . """ " . arguments
    log("Running: " . cmd)
    Run, % cmd, % twinkle_tray.directory.path
}

KeyWaitAny(Options:="")
{
    ih := InputHook(Options)
    if !InStr(Options, "V")
        ih.VisibleNonText := false
    ih.KeyOpt("{All}", "E")  ; End
    ih.Start()
    ErrorLevel := ih.Wait()  ; Store EndReason in ErrorLevel
    return ih.EndKey  ; Return the key name
}