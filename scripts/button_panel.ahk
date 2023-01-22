﻿; Generated by AutoGUI 2.6.2
#SingleInstance Force
#Persistent
#NoEnv
#NoTrayIcon
SetTitleMatchMode, 2
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

#Include %A_ScriptDir%\AutoXYWH.ahk
#Include <bluscream>
global no_ui := true
global debug := false
global runs := 0

#Include <steam>
global steam := new Steam()

; I_Icon := "C:\Windows\System32\shell32.dll"
; IfExist, %I_Icon%
;   Menu, Tray, Icon, %I_Icon%, 16
; ; Menu, Tray, NoStandard
; Menu, tray, add

goto initUI

return

<#x::
    showUI()
    return

initUI:
    Gui +Resize -MinimizeBox +E0x400
    Gui Color, 0x000000
    Gui Font, s20

    Gui Add, Button, hWndhBtnStartSteam vBtnStartSteam gOnBtnStartSteamClicked x16 y16 w216 h84 +Default, Steam
    Gui Add, Button, hWndhBtnStartSteamMini vBtnStartSteamMini gOnBtnStartSteamMiniClicked x16 y104 w106 h84, Mini
    Gui Add, Button, hWndhBtnStartSteamBigPicture vBtnStartSteamBigPicture gOnBtnStartSteamBigPictureClicked x126 y104 w106 h84, BigPic

    ; Gui Add, Button, hWndhBtnStartSteamMini vBtnStartSteamMini gOnBtnStartSteamMiniClicked x248 y16 w216 h172, Start`n`nSteam (Mini)
    Gui Add, Button, hWndhBtnReboot vBtnReboot gOnBtnRebootClicked x248 y16 w216 h84, REBOOT
    Gui Font, s15
    Gui Add, Button, hWndhBtnShutdown vBtnShutdown gOnBtnShutdownClicked x248 y104 w105 h84, % "SHUT`nDOWN"
    Gui Add, Button, hWndhBtnHibernate vBtnHibernate gOnBtnHibernateClicked x359 y104 w105 h84, % "HIBER`nNATE"
    Gui Font, s20

    Gui Add, Button, hWndhBtnStartSteamvr3 vBtnStartSteamvr3 gOnBtnStartSteamVRClicked x16 y208 w216 h172, Start`n`nSteamVR

    Gui Add, Button, hWndhBtn4 vBtn4 gOnBtnStartVDClicked x480 y16 w216 h172, Start`n`nVirtual Desktop

    Gui Add, Button, hWndhBtnStartnnparsec5 vBtnStartnnparsec5 gOnBtnStartParsecClicked x712 y16 w216 h172, Start`n`nParsec

    Gui Add, Button, hWndhBtnSoundDevices6 vBtnSoundnndevices6 gOnBtnSoundDevicesClicked x16 y400 w216 h172, Sound`n`nDevices

    Gui Add, Button, hWndhBtnSoundnnmixer7 vBtnSoundnnmixer7 gOnBtnSoundMixerClicked x248 y400 w216 h172, Sound`n`nMixer

    Gui Add, Button, hWndhBtnStartExplorer8 vBtnStartExplorer8 gOnBtnStartExplorerClicked x480 y400 w216 h84, Start Explorer
    Gui Add, Button, hWndhBtnKillScripts vBtnKillScripts gOnBtnKillScriptsClicked x480 y488 w216 h84, Kill Scripts

    Gui Add, Button, hWndhBtnStartnnxsoverlay9 vBtnStartnnxsoverlay9 gOnBtnStartXSOClicked x480 y208 w216 h172, Start`n`nXSOverlay

    Gui Add, Button, hWndhBtn10 vBtn10 gOnBtn10Clicked x248 y208 w216 h172, Start`n`nCVR

    Gui Add, Button, hWndhBtn11 vBtn11 gOnBtn11Clicked x712 y208 w216 h172, Start`n`nYoutube`nMusic

    Gui Add, Button, hWndhBtnKillSemiBloat vBtnKillSemiBloat gOnBtnKillSemiBloatClicked x712 y400 w216 h84, Kill Services
    Gui Add, Button, hWndhBtnKillbloat vBtnKillbloat gOnBtnKillbloatClicked x712 y488 w216 h84, Kill Bloat
    
    Gui Font
    return

showUI() {
    ; [96] Quick Start Panel (17.05. 14:01:34) ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe ahk_pid 8904
    IfWinNotExist, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    {
        runs := runs + 1
        FormatTime, timestamp, A_Now, dd.MM. HH:mm:ss
        Gui Show, w936 h580, % "[" . runs . "] Quick Start Panel (" . timestamp . ")"
    }
    WinActivate, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
}

OnBtnStartSteamClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("onBtnStartSteamClicked")
    KillProcesses(["steam"])
    ; ShellRun("""C:\Program Files (x86)\Steam\Steam.exe""", "steam://open/console")
    steam.console()
    GuiClose(0)
}
OnBtnStartSteamMiniClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("onBtnStartSteamMiniClicked")
    KillProcesses(["steam"])
    ; ShellRun("""C:\Program Files (x86)\Steam\Steam.exe""", "-no-browser +open steam://open/minigameslist")
    steam.start(True, True)
    GuiClose(0)
}
OnBtnStartSteamBigPictureClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("onBtnStartSteamMiniClicked")
    KillProcesses(["steam"])
    ; ShellRun("""C:\Program Files (x86)\Steam\Steam.exe""", "-no-browser +open steam://open/minigameslist")
    steam.start(True, True, 0, ["steam://open/bigpicture"])
    GuiClose(0)
}

OnBtnRebootClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Msgbox 4, Confirm Reboot, Are you sure you want to reboot?
    IfMsgBox No
        Return
    SendIRCommand("medion%20tv", "on_off", 10)
    Run % "psshutdown -r -f -t 1"
}
OnBtnHibernateClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Msgbox 4, Confirm Hibernation, Are you sure you want to hibernate?
    IfMsgBox No
        Return
    SendIRCommand("medion%20tv", "on_off", 10)
    ; ShellRun("powercfg.exe","/hibernate","on")
    Run % "psshutdown -h -f -t 1"
    ;      shutdown.exe [/i | /l | /s | /sg | /r | /g | /a | /p | /h | /e | /o] [/hybrid] [/soft] [/fw] [/f] [/m \\computer][/t xxx][/d [p|u:]xx:yy [/c "comment"]]
}
OnBtnShutdownClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    Msgbox 4, Confirm Shutdown, Are you sure you want to shut down?
    IfMsgBox No
        Return
    ; SendIRCommand("medion%20tv", "on_off", 10)
    Run % "psshutdown -s -f -t 1"
}

OnBtnStartSteamVRClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("onBtnStartSteamVRClicked")
    KillProcesses(["vrwebhelper","vrdashboard","vrmonitor","vrcompositor","vrserver"])
    ShellRun("steam://rungameid/250820", "")
    GuiClose(0)
}

OnBtnStartXSOClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("OnBtnStartXSOClicked")
    KillProcesses(["XSOverlay Media Manager","XSOverlay Process Manager","XSOverlay"])
    ShellRun("steam://rungameid/1173510", "")
    GuiClose(0)
}

OnBtnStartVDClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("onBtnStartVDClicked")
    KillProcesses(["VirtualDesktop.Server", "VirtualDesktop.Streamer", "VirtualDesktop.Service"])
    StopServices(["VirtualDesktop.Service.exe"])
    StartServices(["VirtualDesktop.Service.exe"])
    GuiClose(0)
}

OnBtnStartParsecClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("OnBtnStartParsecClicked")
    KillProcesses(["parsecd", "teams", "pservice"])
    StopServices(["Parsec"])
    StartServices(["Parsec"])
    SleepS(1)
    Run % "C:\Program Files\Parsec\parsecd.exe", , Min
    GuiClose(0)
}

OnBtnSoundDevicesClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("OnBtnSoundDevicesClicked")
    Run % "control mmsys.cpl,,0"
    GuiClose(0)
}

OnBtnSoundMixerClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("OnBtnSoundMixerClicked")
    Run SndVol
    GuiClose(0)
}

OnBtnStartExplorerClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("OnBtnStartExplorerClicked")
    KillProcesses(["retrobar","explorer","StartMenu","ClassicIE_32","ClassicIE_64","ClassicExplorerSettings"])
    Run explorer
    SleepS(3)
    Run retrobar
    GuiClose(0)
    SleepS(1)
    Run % "C:\Program Files (x86)\Moo0\AlwaysOnTop\WindowMenuPlus.exe"
    Run % "C:\Program Files\Open-Shell\StartMenu.exe -settings"
    ; Run % "C:\Program Files\Open-Shell\StartMenu.exe -togglenew"
}

OnBtn10Clicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("onBtn10Clicked")<
    KillProcesses(["VRCX","VRChat","ChilloutVR","conhost","cmd"])
    ; Run % "D:\OneDrive\Games\VRChat\_TOOLS\VRCX\VRCX.exe"
    ; Run % "G:\Steam\steamapps\common\VRChat\VRChat.exe"
    Run % """G:\Steam\steamapps\common\ChilloutVR\ChilloutVR.exe"" -vr -skipsteam --disable-videoplayers"
    GuiClose(0)
}

OnBtn11Clicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("onBtn11Clicked")
    KillProcesses(["YouTube Music"])
    SleepS(1)
    ShellRun("C:\Users\blusc\AppData\Local\Programs\youtube-music\YouTube Music.exe", "")
    GuiClose(0)
}

OnBtnKillbloatClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(false, "", "/bloat")
}
OnBtnKillSemiBloatClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(false, "", "/semibloat")
}

OnBtnKillScriptsClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    KillProcesses(["AutoHotkeyV2x64","AutoHotkeyV2x86","AutoHotkeyA32","AutoHotkeyU32","AutoHotkey","AutoHotkeyUX","AutoHotkeyU64"])
}

GuiSize(GuiHwnd, EventInfo, Width, Height) {
    If (A_EventInfo == 1) {
        Return
    }
    AutoXYWH("xywh", hBtnStartSteam)
    AutoXYWH("xywh", hBtnStartSteamMini)
    AutoXYWH("xywh", hBtnStartSteamvr3)
    AutoXYWH("xywh", hBtn4)
    AutoXYWH("xywh", hBtnStartnnparsec5)
    AutoXYWH("xywh", hBtnSoundDevices6)
    AutoXYWH("xywh", hBtnSoundnnmixer7)
    AutoXYWH("xywh", hBtnStartExplorer8)
    AutoXYWH("xywh", hBtnStartnnxsoverlay9)
    AutoXYWH("xywh", hBtn10)
    AutoXYWH("xywh", hBtn11)
    AutoXYWH("xywh", hBtnKillbloat)
    AutoXYWH("xywh", hBtnKillSemiBloat)
}

; GuiEscape(GuiHwnd) {
;     GuiClose(GuiHwnd)
; }

GuiClose(GuiHwnd) {
    Gui, 1:-Disabled
    Gui, hide
    ; Gui Destroy
    ; ExitApp
}