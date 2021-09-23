#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
global noui := false
#Include <bluscream>
#INCLUDE <Acc>

global vd := {}
vd.server := new Window("", "", "VirtualDesktop.Server.exe")
vd.streamer := new Window("Virtual Desktop Streamer", "HwndWrapper[VirtualDesktop.Streamer.exe;UI Thread;117aaec4-0fa3-4fdc-b637-eb3c7fd4dc5b]", "VirtualDesktop.Streamer.exe")
global vd_file := new Directory("C:\Program Files\Virtual Desktop Streamer").CombineFile(vd.streamer.exe)
global vd_connected := vd.server.process.exists()
global vd_doublechecking := false

global steam := new Window("Steam", "vguiPopupWindow", "steam.exe")

global steamvr_uri := "steam://rungameid/250820"
global steamvr := {}
steamvr.vrwebhelper := new Window("", "", "vrwebhelper.exe")
steamvr.vrdashboard := new Window("", "", "vrdashboard.exe")
steamvr.vrmonitor := new Window("SteamVR Status", "Qt5QWindowIcon", "vrmonitor.exe")
steamvr.vrmonitor_extra := new Window("vrmonitor", "Qt5QWindowToolSaveBits", steamvr.vrmonitor.exe)
steamvr.vrcompositor := new Window("", "", "vrcompositor.exe")
steamvr.vrserver := new Window("", "", "vrserver.exe")

global vrchat_uri := "steam://rungameid/10282156117588967424"
global vrchat := {}
vrchat.game := new Window("VRChat", "UnityWndClass", "VRChat.exe")
vrchat.console := new Window("MelonLoader", "ConsoleWindowClass", vrchat.game.exe)
global vrchat_file := new Directory("S:\Steam\steamapps\common\VRChat").CombineFile(vrchat.game.exe)
; --quitfix --enable-sdk-log-levels
; VRCX ahk_class WindowsForms10.Window.8.app.0.370a08c_r6_ad1 ahk_exe VRCX.exe
global vrcx := new File("C:\Users\Shadow\OneDrive\Games\VRChat\_TOOLS\VRCX\VRCX.exe")

for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/start") {
    }
}
Acc_Init()
global steamvr_vrmonitor_str := steamvr.vrmonitor.str()

; SetTimer, CheckForSteamVR, % 1000*15
SetTimer, CheckForVirtualDesktop, % 1000
return
; Esc::ExitApp
CheckForVirtualDesktop:
    connected := vd.server.process.exists()
    if (vd_doublechecking and !connected) {
        vd_doublechecking := false
        SetTimer, DoubleCheckForConnection, Off
    }
    if (!vd_connected and connected)
        OnVirtualDesktopConnected()
    else if (vd_connected and !connected)
        OnVirtualDesktopDisconnected()
    vd_connected := connected
    return

CheckForSteamVR:
    if (isSteamVRFail())
        killAll(steamvr)
    return

DoubleCheckForConnection:
    vd_doublechecking := false
    SetTimer, DoubleCheckForConnection, Off
    if (vd_connected and vd.server.process.exists())
        OnVirtualDesktopFullyConnected()
    return

isSteamVRFail() {
    if (!steamvr.vrmonitor_extra.exists()) return false

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

killAll(windows) {
    for i, window in windows {
        window_closed := window.close()
        process_closed := window.process.close()
        process_killed := window.process.kill(true, true)
    }
}


OnVirtualDesktopConnected() {
    scriptlog("OnVirtualDesktopConnected")
    vd_doublechecking := true
    SetTimer, DoubleCheckForConnection, % 25000
}

OnVirtualDesktopFullyConnected() {
    scriptlog("OnVirtualDesktopFullyConnected")
    if (!steam.exists()) {
        scriptlog("Starting Steam")
        Run % "steam://open/console"
        steam.activate(true)
    }
    no_steamvr := (!steamvr.vrmonitor.exists() or isSteamVRFail())
    game_was_running_fine := (!no_steamvr and vrchat.game.exists())
    if (no_steamvr) {
        scriptlog("Killing SteamVR")
        killAll(steamvr)
        ; Run % steamvr_uri
        ; steamvr.vrmonitor.activate(true)
    }
    if (!new Process(vrcx.fullname).exists()) {
        scriptlog("Starting " . vrcx.path)
        vrcx.run()
    }
    if (!game_was_running_fine) {
        scriptlog("Starting " . vrchat_file.path)
        killAll(vrchat)
        Run % vrchat_uri
        ; vrchat_file.run(false, "", "--quitfix --enable-sdk-log-levels")
    }
}

OnVirtualDesktopDisconnected() {
    scriptlog("OnVirtualDesktopDisconnected")
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
