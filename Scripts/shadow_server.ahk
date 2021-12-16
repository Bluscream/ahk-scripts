#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
#Include <bluscream>
global noui := false
EnforceAdmin()
#INCLUDE <Acc>

ShadowProcessator := new File("C:\Program Files\Blade Group\ShadowProcessator\ShadowProcessator.exe")
if (FileExist(ShadowProcessator.path)) {
    Menu, Tray, Icon, % ShadowProcessator.path
    scriptlog("Icon set: " . Quote(ShadowProcessator.path))
}

global perf_mode := false

global vd := { windows: { server: new Window("", "", "VirtualDesktop.Server.exe")
        ,streamer: new Window("Virtual Desktop Streamer", "HwndWrapper[VirtualDesktop.Streamer.exe;UI Thread;117aaec4-0fa3-4fdc-b637-eb3c7fd4dc5b]", "VirtualDesktop.Streamer.exe") }
    ,files: { streamer: new Directory("C:\Program Files\Virtual Desktop Streamer").CombineFile(vd.windows.streamer.exe) }
    ,connected: vd.windows.server.process.exists()
    ,doublechecking: false
    ,safe_mode: false }


global steam := { uri: ["steam://open/console", ""]
    ,uri_minicon: [ """C:\Program Files (x86)\Steam\Steam.exe""", "-no-browser +open steam://open/minigameslist" ]
    ,windows: { steam: new Window("Steam", "vguiPopupWindow", "steam.exe") } }

global steamvr := { uri: ["steam://rungameid/250820", ""]
    ,windows: { vrwebhelper: new Window("", "", "vrwebhelper.exe")
        ,vrdashboard: new Window("", "", "vrdashboard.exe")
        ,vrmonitor: new Window("SteamVR Status", "Qt5QWindowIcon", "vrmonitor.exe")
        ,vrmonitor_extra: new Window("vrmonitor", "Qt5QWindowToolSaveBits", "vrmonitor.exe")
        ,vrcompositor: new Window("", "", "vrcompositor.exe")
        ,vrserver: new Window("", "", "vrserver.exe") } }



global game := { name: "ets2"
    ,uri : ["steam://rungameid/227300", ""]
    ,windows: { game: new Window("Euro Truck Simulator 2", "prism3d", "eurotrucks2.exe") }
    ,processes: { }
    ,files: { game: new Directory("S:\Steam\steamapps\common\Euro Truck Simulator 2").CombineFile("bin", "win_x64", "eurotrucks2.exe") } }


; global game := { name: "vrc_mods"
;     ,uri : "steam://rungameid/10282156117588967424" ; --quitfix --enable-sdk-log-levels
;     ,windows: { game: new Window("VRChat", "UnityWndClass", "VRChat.exe")
;         ,console: new Window("MelonLoader", "ConsoleWindowClass", vrchat.game.exe)
;         ,vrcx: new Window("VRCX", "WindowsForms10.Window.8.app.0.370a08c_r6_ad1", "VRCX.exe") }
;     ,processes: { }
;     ,files: { game: new Directory("S:\Steam\steamapps\common\VRChat").CombineFile(vrchat.windows.game.exe)
;         ,vrcx: new File("C:\Users\Shadow\OneDrive\Games\VRChat\_TOOLS\VRCX\VRCX.exe") } }

global bloat := { services: [ "wercplsupport","PcaSvc","wscsvc","SstpSvc","WSearch","EventLog","Schedule","OneSyncSvc_57c4d","Everything","EFS","LGHUBUpdaterService","ZeroTierOneService","""Wallpaper Engine Service""","GlassWire","""Adguard Service""","AnyDeskMSI","TeamViewer","Parsec","MBAMService" ]
    ,processes: [ "SearchIndexer","lghub_updater","wallpaper64","GlassWire","Adguard","parsecd","Everything","MoUsoCoreWorker","SettingSyncHost","StartMenuExperienceHost","SettingSyncHost","vsls-agent","zerotier-one_x64","TextInputHost","mbamtray","mmc","msiexec","FileCoAuth","webhelper","vrwebhelper","conhost","cmd","explorer" ]
    ,custom: [] }


A_Args := [ "/min" ]
for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/doublecheck") {
        scriptlog("Double checking enabled (" . param . ")")
        vd.safe_mode := true
    } else if (param == "/min" || param == "/perf") {
        scriptlog("Performance mode enabled (" . param . ")")
        perf_mode := true
        steam.uri := steam.uri_minicon
    }
}
Acc_Init()
global steamvr_vrmonitor_str := steamvr.windows.vrmonitor.str()
scriptlog("steamvr_vrmonitor_str: " . steamvr_vrmonitor_str)

; SetTimer, CheckForSteamVR, % 1000*15
SetTimer, CheckForVirtualDesktop, % 1000
scriptlog("CheckForVirtualDesktop timer running...")
return
; <#e::Run explorer
; Esc::ExitApp
CheckForVirtualDesktop:
    connected := vd.windows.server.process.exists()
    if (vd.doublechecking and !connected) {
        vd.doublechecking := false
        SetTimer, DoubleCheckForConnection, Off
    }
    if (!vd.connected and connected) {
        if (vd.safe_mode)
            OnVirtualDesktopConnected()
        else
            OnVirtualDesktopFullyConnected()
    }
    else if (vd.connected and !connected)
        OnVirtualDesktopDisconnected()
    vd.connected := connected
    return

CheckForSteamVR:
    if (isSteamVRFail())
        killAll(steamvr)
    return

DoubleCheckForConnection:
    vd.doublechecking := false
    SetTimer, DoubleCheckForConnection, Off
    if (vd.connected and vd.windows.server.process.exists())
        OnVirtualDesktopFullyConnected()
    return

isSteamVRFail() {
    if (!steamvr.windows.vrmonitor_extra.exists()) return false

    text := Acc_Get("Name", "4.7.1.8", 0, steamvr_vrmonitor_str)
    StringSplit, text, text, " "
    has_latency := (text1 > 0)
    ; scriptlog("text " . text . " has_latency " . has_latency)

    text := Acc_Get("Name", "4.8.1", 0, steamvr_vrmonitor_str)
    has_headset := (text != "Headset")
    ; scriptlog("text " . text . " has_headset " . has_headset)

    text := Acc_Get("Name", "4.1", 0, steamvr_vrmonitor_str)
    text2 := Acc_Get("Name", "4.2", 0, steamvr_vrmonitor_str)
    is_searching := (text == "Searching..." or text2 == "Make sure headset can see the play area")
    
    is_fail := !has_headset and !has_latency and !is_searching

    ; scriptlog("isSteamVRFail: " . toYesNo(is_fail) . " | has_latency " . toYesNo(has_latency) . " | has_headset " . toYesNo(has_headset) . " | is_searching " . toYesNo(is_searching))

    return is_fail
}

killAll(item) {
    for i, window in item.windows {
        window_closed := window.close()
        process_closed := window.process.close()
        process_killed := window.process.kill(true, true)
    }
    for i, process in item.processes {
        process_closed := process.close()
        process_killed := process.kill(true, true)
    }
}


OnVirtualDesktopConnected() {
    scriptlog("OnVirtualDesktopConnected")
    vd.doublechecking := true
    SetTimer, DoubleCheckForConnection, % 25000
}

OnVirtualDesktopFullyConnected() {
    scriptlog("OnVirtualDesktopFullyConnected")

    no_steamvr := CheckSteamVR()

    ; if (!new Process(vrcx.fullname).exists()) {
    ;     scriptlog("Starting " . vrcx.path)
    ;     vrcx.run()
    ; }

    CheckGame(no_steamvr)

    if (perf_mode)
        KillBloat()
}

OnVirtualDesktopDisconnected() {
    scriptlog("OnVirtualDesktopDisconnected")
}

KillBloat() {
    ; scriptlog("KillBloat")
    scriptlog("[UNBLOAT] Stopping " . bloat.services.Count() . " services")
    for i, service in bloat.services {
        ; scriptlog("[UNBLOAT] Stopping service " . service)
        Run % "sc stop " . service
    }
    scriptlog("[UNBLOAT] Killing " . bloat.processes.Count() . " processes")
    for i, process in bloat.processes {
        ; scriptlog("[UNBLOAT] Killing process " . process . ".exe")
        Run % "taskkill /f /im " . process . ".exe"
    }
    scriptlog("[UNBLOAT] Running " . bloat.custom.Count() . " commands")
    for i, command in bloat.custom {
        ; scriptlog("[UNBLOAT] Running " . command)
        Run % command
    }
}

CheckSteamVR() {
    if (!steam.exists()) {
        scriptlog("Starting " . steam.uri[1] . " " . steam.uri[2])
        ShellRun(steam.uri[1], steam.uri[2])
        SleepS(5)
        steam.windows.steam.activate()
        SleepS(1)
        scriptlog("Waiting for " . steam.windows.steam.title . " ...")
        steam.windows.steam.activate(true)
    }
    no_steamvr := (!steamvr.windows.vrmonitor.exists() or isSteamVRFail())
    if (no_steamvr) {
        scriptlog("Killing SteamVR")
        killAll(steamvr)
        SleepS(1)
        scriptlog("Starting " . steamvr.uri[1] . " " . steamvr.uri[2])
        ShellRun(steamvr.uri[1], steamvr.uri[2])
        SleepS(15)
        steamvr.windows.vrmonitor.activate()
        SleepS(1)
        scriptlog("Waiting for " . steamvr.windows.vrmonitor.title . " ...")
        steamvr.windows.vrmonitor.activate(true)
    }
    return no_steamvr
}

CheckGame(no_steamvr) {
    game_was_running_fine := (!no_steamvr and game.window.exists())
    if (!game_was_running_fine) {
        scriptlog("Starting " . game.uri[1] . " " . game.uri[2])
        killAll(game)
        ShellRun(game.uri[1], game.uri[2])
        SleepS(1)
        scriptlog("Waiting for " . game.windows.game.title . " ...")
        game.windows.game.activate(true)
    }
}
; fail
; [05:42:33] 1 | name: System | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:42:33] 1.1 | name: System | role: menu item | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:42:33] 1.1.1 | name: Context | role: popup menu | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:42:44] 3 | name: Application | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:42:49] 4 | name: SteamVR Status | role: border | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:42:51] 4.1 | name:   | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:42:52] 4.2 | name:   | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:01] 4.7.1.3 | name: Dashboard Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:01] 4.7.1.4 | name: Chaperone Bounds Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:01] 4.7.1.5 | name: Reprojection Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:01] 4.7.1.6 | name: Motion Smoothing On | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:02] 4.7.1.8 | name: 0.0 of 11.1 ms (90 Hz) | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:03] 4.8.1 | name: Headset | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:03] 4.8.2 | name: Controller | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:04] 4.8.3 | name: Controller | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:04] 4.8.4 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:04] 4.8.5 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:05] 4.9 | name: STEAMVR 1.19.7 | role: menu button | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:07] 5 | name: Vertical | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:43:12] 6 | name: Horizontal | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe

; connected
; [05:50:38] 1 | name: System | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:50:39] 1.1 | name: System | role: menu item | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:50:39] 1.1.1 | name: Context | role: popup menu | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:50:51] 3 | name: Application | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:50:56] 4 | name: SteamVR Status | role: border | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:13] 4.7.1.3 | name: Dashboard Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:13] 4.7.1.4 | name: Chaperone Bounds Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:13] 4.7.1.5 | name: Reprojection Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:13] 4.7.1.6 | name: Motion Smoothing Unavailable | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:13] 4.7.1.8 | name: 2.9 of 11.1 ms (90 Hz) | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:17] 4.8.4 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:17] 4.8.5 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:19] 4.9 | name: STEAMVR 1.19.7 | role: menu button | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [05:51:21] 5 | name: Vertical | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe

;searching
; [06:06:00] SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:06:16] 1 | name: System | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:06:18] 1.1 | name: System | role: menu item | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:06:18] 1.1.1 | name: Context | role: popup menu | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:06:52] 3 | name: Application | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:07:10] 4 | name: SteamVR Status | role: border | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:07:16] 4.1 | name: Searching... | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:07:23] 4.2 | name: Make sure headset can see the play area | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:07:55] 4.7.1.3 | name: Dashboard Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:07:55] 4.7.1.4 | name: Chaperone Bounds Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:07:55] 4.7.1.5 | name: Reprojection Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:07:55] 4.7.1.6 | name: Motion Smoothing Unavailable | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:07:56] 4.7.1.8 | name: 1.0 of 11.1 ms (90 Hz) | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:08:04] 4.8.4 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:08:05] 4.8.5 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:08:09] 4.9 | name: STEAMVR 1.19.7 | role: menu button | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:08:15] 5 | name: Vertical | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
; [06:08:34] 6 | name: Horizontal | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor.exe
