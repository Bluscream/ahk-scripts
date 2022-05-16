#SingleInstance, force
#NoEnv
; #NoTrayIcon
#Persistent
#Include <bluscream>
EnforceAdmin()

global no_ui := False
global idle_time_minutes := 1
global brightness_normal := 50
global brightness_idle := 0
global ignored_power_profiles := ["High performance","Ultimate Performance","Bitsum Highest Performance","Driver Booster Power Plan"]


global idle_time_ms := idle_time_minutes * 60000
global is_idle := 0
twinkle_tray := new Paths.User().localappdata.CombineFile("Programs","twinkle-tray","Twinkle Tray.exe")
SetTimer, CheckIdleTime, 5000
A_Args := [ "/menu" ]
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
        SetBrightness(brightness_normal)
    }
}
return

CheckIdleTime:
    ; log("A_TimeIdlePhysical: " + A_TimeIdlePhysical)
    if (A_TimeIdlePhysical > idle_time_ms and GetPowerProfileName() not in ignored_power_profiles) {
        SetTimer, CheckIdleTime, Off
        log("Longer than " . idle_time_minutes . " minutes idle, waiting for key press to return to " . brightness_idle . "% brightness...")
        is_idle := 1
        SetBrightness(brightness_idle)
        KeyWaitAny("V")
        is_idle := 0
        SetBrightness(brightness_normal)
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
    log("is_idle: " . is_idle, true)
    log("A_TimeIdlePhysical: " . A_TimeIdlePhysical, true)
    log("idle_time_minutes: " . idle_time_minutes, true)
    log("idle_time_ms: " . idle_time_ms, true)
    log("brightness_normal: " . brightness_normal, true)
    log("brightness_idle: " . brightness_idle, true)
    log("GetPowerProfileName(): " . GetPowerProfileName(), true)
    log("ignored_power_profiles: " . toJson(ignored_power_profiles), true)
    log("A_Args: " . toJson(A_Args), true)
    log("twinkle_tray: " . toJson(twinkle_tray), true)
    return

log(txt, log_to_window := false) {
    if (log_to_window)
        scriptlog(StrReplace(txt, "\", "/"))
    ShowToolTip(txt)
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