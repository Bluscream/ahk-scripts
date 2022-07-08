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

global perf_mode := false

#include <virtual_desktop>
global vd := new VirtualDesktop()
global traylib := new TrayLib()
traylib.start(Func("OnTrayChanged"))
vd.last_event := ""
vd.state := "Unknown"
vd.failcounter := 0

#Include <steam>
global steam := new Steam()
global steamvr := new SteamVR()

; global game := { name: "vrc_mods"
;     ,uri : "steam://rungameid/10282156117588967424" ; --quitfix --enable-sdk-log-levels
;     ,windows: { game: new Window("VRChat", "UnityWndClass", "VRChat")
;         ,console: new Window("MelonLoader", "ConsoleWindowClass", vrchat.game)
;         ,vrcx: new Window("VRCX", "WindowsForms10.Window.8.app.0.370a08c_r6_ad1", "VRCX") }
;     ,processes: { }
;     ,files: { game: new Directory("S:\Steam\steamapps\common\VRChat").CombineFile(vrchat.windows.game)
;         ,vrcx: new File("C:\Users\Shadow\OneDrive\Games\VRChat\_TOOLS\VRCX\VRCX") } }

for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/doublecheck") {
        scriptlog("Double checking enabled (" . param . ")")
        vd.safe_mode := true
    } else if (param == "/min" || param == "/perf") {
        scriptlog("Performance mode enabled (" . param . ")")
        perf_mode := true
    } else if (param == "/bloat") {
        KillBloat()
        ExitApp
    } else if (param == "/semibloat") {
        KillSemiBloat()
        ExitApp
    }
}
scriptlog(toJson(A_Args))

global steamvr_vrmonitor_str := steamvr.windows.vrmonitor.str()
scriptlog("steamvr_vrmonitor_str: " . steamvr_vrmonitor_str)

; SetTimer, CheckForSteamVR, % 1000*15
SetTimer, CheckForVirtualDesktop, % 1000
scriptlog("CheckForVirtualDesktop timer running...")
; SetTimer, Debug, 500

Menu, tray, add, Start VD, startVirtualDesktop
Menu, tray, add, Stop VD, stopVirtualDesktop

return
Debug:
    ToolTip, % vd.state " . fails: " . vd.failcounter
    return
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
    if (steamvr.hasFailed())
        killAll(steamvr)
    return

DoubleCheckForConnection:
    vd.doublechecking := false
    SetTimer, DoubleCheckForConnection, Off
    if (vd.connected and vd.windows.server.process.exists())
        OnVirtualDesktopFullyConnected()
    return

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

OnTrayChanged(line) {
    line := traylib.parseLine(line)
    if (startsWith(line.msg, "Virtual Desktop Streamer")) {
        if (line.event == "Added") {
            vd.state := "Started"
            vd.failcounter := 0
            OnVirtualDesktopStarted()
        } else if (line.event == "Modified") {
            if (line.msg == vd.last_event) {
                return
            }
            vd.last_event := line.msg
            if (line.msg == "Virtual Desktop Streamer is connecting...") {
                vd.state := "Connecting"
                OnVirtualDesktopConnecting()
            } else if (line.msg == "Virtual Desktop Streamer is ready") {
                if (vd.wasconnected) {
                    vd.wasconnected := false
                    if (vd.state == "Connecting") {
                        vd.state := "ConnectionLost"
                        OnVirtualDesktopConnectionLost(vd.failcounter)
                        vd.failcounter := vd.failcounter+1
                    } else {
                        vd.state := "Disconnected"
                        vd.failcounter := 0
                        OnVirtualDesktopDisconnected()
                    }
                } else {
                    vd.state := "Ready"
                    vd.wasconnected := true
                    OnVirtualDesktopReady()
                }
            } else if (line.msg == "Virtual Desktop Streamer is establishing connection...") {
                vd.state := "EstablishingConnection"
                OnVirtualDesktopEstablishingConnection()
            } else if (line.msg == "Virtual Desktop Streamer is connected") {
                vd.state := "Connected"
                OnVirtualDesktopConnected()
            } else if (line.msg == "Virtual Desktop Streamer") {
                vd.state := "NoInternet"
                OnVirtualDesktopInternetLost()
            }
        } else if (line.event == "Removed") {
            vd.state := "Stopped"
            OnVirtualDesktopStopped()
        }
    }
}

OnVirtualDesktopStarted() {
    scriptlog("OnVirtualDesktopStarted")
}
OnVirtualDesktopReady() {
    scriptlog("OnVirtualDesktopReady")
}
OnVirtualDesktopConnecting() {
    scriptlog("OnVirtualDesktopConnecting")
}
OnVirtualDesktopEstablishingConnection() {
    scriptlog("OnVirtualDesktopEstablishingConnection")
}
OnVirtualDesktopConnected() {
    scriptlog("OnVirtualDesktopConnected")
    vd.doublechecking := true
    SetTimer, DoubleCheckForConnection, % 25000
}
OnVirtualDesktopFullyConnected() {
    scriptlog("OnVirtualDesktopFullyConnected")
}
OnConnected() {
    no_steamvr := CheckSteamVR()

    ; if (!new Process(vrcx.fullname).exists()) {
    ;     scriptlog("Starting " . vrcx.path)
    ;     vrcx.run()
    ; }

    ; CheckGame(no_steamvr)

    if (perf_mode)
        KillBloat()
}
OnVirtualDesktopDisconnected() {
    scriptlog("OnVirtualDesktopDisconnected")
}
OnVirtualDesktopConnectionLost(fails) {
    scriptlog("OnVirtualDesktopConnectionLost (" . fails . ")")
    if (fails > 1) {
        vd.failcounter := 0
        scriptlog("Too many VD fails (" . fails . "), restarting...")
        vd.restart()
    }
}
OnVirtualDesktopInternetLost() {
    scriptlog("OnVirtualDesktopInternetLost, restarting every 10 seconds...")
    SetTimer, InternetLostCheck, 10000
}
InternetLostCheck:
    if (vd.state == "NoInternet" or vd.state == "ConnectionLost") {
        vd.restart()
    } else {
        SetTimer, InternetLostCheck, Off
    }
    Return
OnVirtualDesktopStopped() {
    scriptlog("OnVirtualDesktopStopped")
    vd.restart()
}

startVirtualDesktop() {
    vd.restart()
}
stopVirtualDesktop() {
    vd.kill()
}

CheckSteamVR() {
    if (!steam.exists()) {
        steam.start((perf_mode ? True : False), perf_mode ? True : False)
        SleepS(5)
        steam.windows.steam.activate()
        SleepS(1)
        scriptlog("Waiting for " . steam.windows.steam.title . " ...")
        steam.windows.steam.activate(true)
    }
    no_steamvr := (!steamvr.windows.vrmonitor.exists() or steamvr.hasFailed())
    if (no_steamvr) {
        scriptlog("Killing SteamVR")
        steamvr.kill(true)
        SleepS(1)
        steamvr.start()
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

KillBloat() {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(true, "", "/bloat")
}
KillSemiBloat() {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(true, "", "/semibloat")
}

; fail
; [05:42:33] 1 | name: System | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:42:33] 1.1 | name: System | role: menu item | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:42:33] 1.1.1 | name: Context | role: popup menu | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:42:44] 3 | name: Application | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:42:49] 4 | name: SteamVR Status | role: border | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:42:51] 4.1 | name:   | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:42:52] 4.2 | name:   | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:01] 4.7.1.3 | name: Dashboard Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:01] 4.7.1.4 | name: Chaperone Bounds Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:01] 4.7.1.5 | name: Reprojection Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:01] 4.7.1.6 | name: Motion Smoothing On | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:02] 4.7.1.8 | name: 0.0 of 11.1 ms (90 Hz) | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:03] 4.8.1 | name: Headset | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:03] 4.8.2 | name: Controller | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:04] 4.8.3 | name: Controller | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:04] 4.8.4 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:04] 4.8.5 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:05] 4.9 | name: STEAMVR 1.19.7 | role: menu button | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:07] 5 | name: Vertical | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:43:12] 6 | name: Horizontal | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor

; connected
; [05:50:38] 1 | name: System | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:50:39] 1.1 | name: System | role: menu item | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:50:39] 1.1.1 | name: Context | role: popup menu | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:50:51] 3 | name: Application | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:50:56] 4 | name: SteamVR Status | role: border | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:13] 4.7.1.3 | name: Dashboard Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:13] 4.7.1.4 | name: Chaperone Bounds Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:13] 4.7.1.5 | name: Reprojection Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:13] 4.7.1.6 | name: Motion Smoothing Unavailable | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:13] 4.7.1.8 | name: 2.9 of 11.1 ms (90 Hz) | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:17] 4.8.4 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:17] 4.8.5 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:19] 4.9 | name: STEAMVR 1.19.7 | role: menu button | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [05:51:21] 5 | name: Vertical | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor

;searching
; [06:06:00] SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:06:16] 1 | name: System | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:06:18] 1.1 | name: System | role: menu item | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:06:18] 1.1.1 | name: Context | role: popup menu | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:06:52] 3 | name: Application | role: menu bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:07:10] 4 | name: SteamVR Status | role: border | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:07:16] 4.1 | name: Searching... | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:07:23] 4.2 | name: Make sure headset can see the play area | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:07:55] 4.7.1.3 | name: Dashboard Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:07:55] 4.7.1.4 | name: Chaperone Bounds Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:07:55] 4.7.1.5 | name: Reprojection Off | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:07:55] 4.7.1.6 | name: Motion Smoothing Unavailable | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:07:56] 4.7.1.8 | name: 1.0 of 11.1 ms (90 Hz) | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:08:04] 4.8.4 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:08:05] 4.8.5 | name: Base Station | role: text | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:08:09] 4.9 | name: STEAMVR 1.19.7 | role: menu button | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:08:15] 5 | name: Vertical | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
; [06:08:34] 6 | name: Horizontal | role: scroll bar | error: 0 | title: SteamVR Status ahk_class Qt5QWindowIcon ahk_exe vrmonitor
