#Persistent
#NoEnv
#SingleInstance, force
SetBatchLines, -1
#Include <bluscream>
EnforceAdmin()
global no_ui := True
#Include <monitors>
global no_ui := True

global monitors := GetMonitors()
global runs := 0
global bspid := 0
; dimming
global idle_time_minutes := 1
global brightness_normal := 50
global brightness_idle := 0
global ignored_power_profiles := ["High performance","Ultimate Performance","Bitsum Highest Performance","Driver Booster Power Plan"]
global idle_time_ms := idle_time_minutes * 60000
global is_idle := 0
global twinkle_tray := new Paths.User().localappdata.CombineFile("Programs","twinkle-tray","Twinkle Tray.exe")

global led_strip := false

A_Args := [ "/menu" ]
; if "/menu" not in A_Args {
;     #NoTrayIcon
; }
for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/toggle") {
        SendIRCommand("medion%20tv", "on_off", 10)
    } else if (param == "/autodim") {
        SetTimer, CheckIdleTime, 5000
    } else if (param == "/antiafk") {
        SetTimer, CheckMonitorCount, 30000
    } else if (param == "/menu") {
        SetupMenu()
    } else if (param == "/set") {
        SetBrightness(brightness_normal)
    } else if (param == "/blockshutdown") {
        goto BlockShutdown
    }
}

OnExit, ExitSub

Return

CheckMonitorCount:
    SysGet, MonitorCount, MonitorCount
    ; scriptlog("MonitorCount: " + MonitorCount)
    if (MonitorCount == 1 or runs == 2) {
        scriptlog("Second screen not found")
        goto ToggleScreen
	  runs := runs + 1
    }
    Return

ToggleLEDs:
    led_strip := !led_strip
    SendIRCommand("led_strip", led_strip?"on":"off")
    Return

ToggleScreen:
    SendIRCommand("medion%20tv", "on_off", 10)
    Return

MuteScreen:
    SendIRCommand("medion%20tv", "mute", 1)
    Return

ChangeScreenSource:
    SendIRCommand("medion%20tv", "source", 3)
    Return

ScreenDismiss:
    SendIRCommand("medion%20tv", "right", 3)
    SleepS(1)
    SendIRCommand("medion%20tv", "ok", 3)
    Return

ScreenBlackWhite:
    SetColor(false)
    return

ScreenColor:
    SetColor(true)
    Return

ScreenBright:
    SetTVBrightness(true)
    Return

ScreenDark:
    SetTVBrightness(false)
    Return

BlockShutdown:
    if (bspid != 0 and ProcessExists(bspid)) {
        Process, Close, % bspid
        Menu, tray, Uncheck, Block Shutdown
    } else {
        Run "C:\Program Files\AutoHotkey\AutoHotkeyV2x64.exe" "C:\Program Files\AutoHotkey\Scripts\block_shutdown.ahk2",,, bspid
        Menu, tray, Check, Block Shutdown
        log("bspid: " . bspid)
    }
    Return

WindowSpy:
    Run C:\Program Files\AutoHotkey\WindowSpy.ahk
    Return

ReloadWinCloseFunc:
    wait := EndTasks(["AutoHotkey.exe_1018039001"], True)
    scriptlog(toJson(wait))
    wait := CloseScript("winclose.ahk")
    scriptlog(toJson(wait))
    wait := StartTasks(["AutoHotkey.exe_1018039001"], True)
    scriptlog(toJson(wait))
    return

Debug:
    log(text . toJson(monitors, True) . "`n`nA_ScreenWidth:" . A_ScreenWidth . " A_ScreenHeight:" . A_ScreenHeight " A_ScreenDPI:" . A_ScreenDPI, true)
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
    Return


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

ExitSub:
    MsgBox % A_ExitReason
    if (A_ExitReason == Shutdown) {
        goto ToggleScreen
    }
    ExitApp
    Return

SetupMenu() {
    I_Icon := "C:\Windows\System32\shell32.dll"
    IfExist, %I_Icon%
        Menu, Tray, Icon, %I_Icon%, 16
    Menu, Tray, NoStandard
    Menu, tray, add, Window Spy, WindowSpy
    Menu, tray, default, Window Spy
    Menu, tray, add, Reload WinClose, ReloadWinCloseFunc
    Menu, tray, add, Block Shutdown, BlockShutdown
    Menu, tray, Uncheck, Block Shutdown
    Menu, tray, add, Toggle LEDs, ToggleLEDs
    Menu, tray, add
    Menu, tray, add, % "Toggle TV", ToggleScreen
    Menu, tray, add, % "Mute TV", MuteScreen
    Menu, tray, add, % "Source", ChangeScreenSource
    Menu, tray, add, % "Black and White", ScreenBlackWhite
    Menu, tray, add, % "Colored", ScreenColor
    Menu, tray, add, % "Bright", ScreenBright
    Menu, tray, add, % "Dark", ScreenDark
    Menu, tray, add, % "Dismiss", ScreenDismiss
    Menu, tray, add
    Menu, tray, add, % "100 %", ScreenFullBright
    Menu, tray, add, % "50 %", ScreenHalfBright
    Menu, tray, add, % "1%", ScreenAlmostOff
    Menu, tray, add, % "0%", ScreenOff
    Menu, tray, add
    Menu, tray, add, % "Debug", Debug
}

log(txt, log_to_window := false) {
    ; if (log_to_window)
        ; scriptlog(StrReplace(txt, "\", "/"))
    ShowToolTip(txt)
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

SetBrightness(value := 50) {
    global twinkle_tray
    ; log("Setting brightness to " . value)
    arguments := "--All --Overlay --Set=" . value
    twinkle_tray.run(false, "", arguments)
    cmd := """" . twinkle_tray.path . """ " . arguments
    ; log("Running: " . cmd)
    Run, % cmd, % twinkle_tray.directory.path
}
SetSlider(direction := "left", amount := 20) {
    Sleep 50
    SendIRCommand("medion%20tv", direction, amount)
    Sleep 500
    SendIRCommand("medion%20tv", direction, amount)
    Sleep 500
    SendIRCommand("medion%20tv", direction, amount)
    Sleep 500
}
SetColor(enable := true) {
    direction := (enable ? "right" : "left")
    SendIRCommand("medion%20tv", "menu", 1)
    Sleep 250
    SendIRCommand("medion%20tv", "ok", 1)
    Sleep 50
    SendIRCommand("medion%20tv", "down", 1)
    Sleep 50
    SendIRCommand("medion%20tv", "down", 1)
    Sleep 50
    SendIRCommand("medion%20tv", "down", 1)
    Sleep 50
    SendIRCommand("medion%20tv", "down", 1)
    Sleep 50
    SetSlider(direction)
    Sleep 250
    SendIRCommand("medion%20tv", "return", 1)
    Sleep 500
    SendIRCommand("medion%20tv", "return", 1)
    TrayTip, AutoHotKey - Screen, % "SetColor Done", 5
}
SetTVBrightness(high := true) {
    direction := (high ? "right" : "left")
    SendIRCommand("medion%20tv", "menu", 1)
    Sleep 250
    SendIRCommand("medion%20tv", "ok", 1)
    Sleep 50
    SendIRCommand("medion%20tv", "down", 1)
    Sleep 50
    SetSlider(direction)
    Sleep 250
    SendIRCommand("medion%20tv", "return", 1)
    ; Sleep 500
    ; SendIRCommand("medion%20tv", "down", 1)
    ; Sleep 50
    ; SetSlider(direction)
    Sleep 250
    SendIRCommand("medion%20tv", "return", 1)
    Sleep 500
    SendIRCommand("medion%20tv", "return", 1)
    TrayTip, AutoHotKey - Screen, % "SetBrightness Done", 5
}