﻿; Generated by AutoGUI 2.6.2
#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

#Include %A_ScriptDir%\AutoXYWH.ahk
#Include <bluscream>
global no_ui := false
global debug := true
scriptlog("init")

Gui +Resize -MinimizeBox +E0x400
Gui Color, 0x808080
Gui Font, s20
Gui Add, Button, hWndhBtnStartSteam vBtnStartSteam gonBtnStartSteamClicked x16 y16 w216 h172 +Default, Start`n`nSteam
Gui Add, Button, hWndhBtnStartSteamMini vBtnStartSteamMini gonBtnStartSteamMiniClicked x248 y16 w216 h172, Start`n`nSteam (Mini)
Gui Add, Button, hWndhBtnStartSteamvr3 vBtnStartSteamvr3 gonBtnStartSteamVRClicked x16 y208 w216 h172, Start`n`nSteamVR
Gui Add, Button, hWndhBtn4 vBtn4 gonBtnStartVDClicked x480 y16 w216 h172, Start`n`nVirtual Desktop
Gui Add, Button, hWndhBtnStartnnparsec5 vBtnStartnnparsec5 gOnBtnStartParsecClicked x712 y16 w216 h172, Start`n`nParsec
Gui Add, Button, hWndhBtnSoundDevices6 vBtnSoundnndevices6 gOnBtnSoundDevicesClicked x16 y400 w216 h172, Sound`n`nDevices
Gui Add, Button, hWndhBtnSoundnnmixer7 vBtnSoundnnmixer7 gOnBtnSoundMixerClicked x248 y400 w216 h172, Sound`n`nMixer
Gui Add, Button, hWndhBtnStartExplorer8 vBtnStartExplorer8 gOnBtnStartExplorerClicked x480 y400 w216 h172, Start`n`nExplorer
Gui Add, Button, hWndhBtnStartnnxsoverlay9 vBtnStartnnxsoverlay9 gOnBtnStartXSOClicked x480 y208 w216 h172, Start`n`nXSOverlay
Gui Add, Button, hWndhBtn10 vBtn10 gonBtn10Clicked x248 y208 w216 h172
Gui Add, Button, hWndhBtn11 vBtn11 gonBtn11Clicked x712 y208 w216 h172
Gui Add, Button, hWndhBtnKillbloat vBtnKillbloat gonBtnKillbloatClicked x712 y400 w216 h172, Kill`n`nBloat
Gui Font
FormatTime, timestamp, A_Now, dd.mm. HH:mm:ss
Gui Show, w936 h580, % "Quick Start Panel (" . timestamp . ")"
Return

onBtnStartSteamClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("onBtnStartSteamClicked")
    KillProcesses(["steam"])
    ShellRun("steam://open/console", "")
}

onBtnStartSteamMiniClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("onBtnStartSteamMiniClicked")
    KillProcesses(["steam"])
    ShellRun("""C:\Program Files (x86)\Steam\Steam.exe""", "-no-browser +open steam://open/minigameslist")
}

onBtnStartSteamVRClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("onBtnStartSteamVRClicked")
    KillProcesses(["vrwebhelper","vrdashboard","vrmonitor","vrcompositor","vrserver"])
    ShellRun("steam://rungameid/250820", "")
}

OnBtnStartXSOClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("OnBtnStartXSOClicked")
    KillProcesses(["XSOverlay Media Manager","XSOverlay Process Manager","XSOverlay"])
    ShellRun("steam://rungameid/1173510", "")
}

onBtnStartVDClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("onBtnStartVDClicked")
    KillProcesses(["VirtualDesktop.Streamer", "VirtualDesktop.Service"])
    StopServices(["VirtualDesktop.Service.exe"])
    StartServices(["VirtualDesktop.Service.exe"])
}

OnBtnStartParsecClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("OnBtnStartParsecClicked")
    KillProcesses(["parsecd", "teams", "pservice"])
    StopServices(["Parsec"])
    StartServices(["Parsec"])
}

OnBtnSoundDevicesClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("OnBtnSoundDevicesClicked")
    Run % "control mmsys.cpl,,0"
}

OnBtnSoundMixerClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("OnBtnSoundMixerClicked")
    Run SndVol
}

OnBtnStartExplorerClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("OnBtnStartExplorerClicked")
    KillProcesses(["explorer","retrobar"])
    Run explorer
    SleepS(2)
    Run retrobar
}

onBtn10Clicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("onBtn10Clicked")
}

onBtn11Clicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("onBtn11Clicked")
}

onBtnKillbloatClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    scriptlog("onBtnKillbloatClicked")
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
}

GuiEscape(GuiHwnd) {
    ExitApp
}

GuiClose(GuiHwnd) {
    ExitApp
}
