﻿; Generated by AutoGUI 2.6.2
#SingleInstance Force
#Persistent
#NoEnv
#NoTrayIcon
SetTitleMatchMode, 2
; SetWorkingDir %A_ScriptDir%
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

    Gui Add, Button, hWndhBtnStartSteam vBtnStartSteam gOnBtnStartSteamClicked x16 y16 w216 h84 +Default, % "Steam"
    Gui Add, Button, hWndhBtnStartSteamMini vBtnStartSteamMini gOnBtnStartSteamMiniClicked x16 y104 w106 h84, % "Mini"
    ; Gui Add, Button, hWndhBtnStartSteamMini vBtnStartSteamMini gOnBtnStartSteamMiniClicked x248 y16 w216 h172, % "Steam (Mini)"
    Gui Add, Button, hWndhBtnStartSteamBigPicture vBtnStartSteamBigPicture gOnBtnStartSteamBigPictureClicked x126 y104 w106 h84, % "BigPic"

    Gui Add, Button, hWndhBtnReboot vBtnReboot gOnBtnRebootClicked x248 y16 w216 h84, % "REBOOT"
    Gui Font, s15
    Gui Add, Button, hWndhBtnShutdown vBtnShutdown gOnBtnShutdownClicked x248 y104 w105 h84, % "SHUT`nDOWN"
    Gui Add, Button, hWndhBtnHibernate vBtnHibernate gOnBtnHibernateClicked x359 y104 w105 h84, % "HIBER`nNATE"
    Gui Font, s20

    Gui Add, Button, hWndhBtnStartSteamvr3 vBtnStartSteamvr3 gOnBtnStartSteamVRClicked x16 y208 w216 h172, % "SteamVR"

    Gui Add, Button, hWndhBtn4 vBtn4 gOnBtnStartVDClicked x480 y16 w216 h172, % "Virtual`n`nDesktop"

    Gui Add, Button, hWndhBtnStartnnparsec5 vBtnStartnnparsec5 gOnBtnStartParsecClicked x712 y16 w216 h172, % "Parsec"

    Gui Add, Button, hWndhBtnSoundDevices6 vBtnSoundnndevices6 gOnBtnSoundDevicesClicked x16 y400 w216 h172, % "Sound`n`nDevices"

    Gui Add, Button, hWndhBtnSoundnnmixer7 vBtnSoundnnmixer7 gOnBtnSoundMixerClicked x248 y400 w216 h172, % " Sound`n`nMixer"

    Gui Font, s18
    Gui Add, Button, hWndhBtnStartExplorer8 vBtnStartExplorer8 gOnBtnStartExplorerClicked x480 y400 w106 h84, % "Explorer"
    Gui Add, Button, hWndhBtnStartRetrobar8 vBtnStartRetrobar8 gOnBtnStartRetrobarClicked x590 y400 w106 h84, % " Retrobar"
    Gui Font, s20
    Gui Add, Button, hWndhBtnKillScripts vBtnKillScripts gOnBtnKillScriptsClicked x480 y488 w216 h84, % "Kill Scripts"

    Gui Add, Button, hWndhBtnStartnnxsoverlay9 vBtnStartnnxsoverlay9 gOnBtnStartXSOClicked x480 y208 w216 h172, % "XSOverlay"

    Gui Add, Button, hWndhBtn10 vBtn10 gOnBtn10Clicked x248 y208 w216 h84, % "ChilloutVR"
    Gui Add, Button, hWndhBtnStartVRChat vBtnStartVRChat gOnBtnStartVRChatClicked x248 y296 w216 h84, % "VRChat"

    Gui Add, Button, hWndhBtn11 vBtn11 gOnBtn11Clicked x712 y208 w216 h172, % "Youtube`n`nMusic"

    ; Gui Add, Button, hWndhBtnKillSemiBloat vBtnKillSemiBloat gOnBtnKillSemiBloatClicked x712 y400 w216 h84, % "Kill Services"
    Gui Add, Button, hWndhBtnKillCMD vBtnKillCMD gOnBtnKillCMDClicked x712 y400 w106 h84, % " Kill CMD"
    Gui Add, Button, hWndhBtnKillSemiBloat vBtnKillSemiBloat gOnBtnKillSemiBloatClicked x824 y400 w110 h84, % "Services"

    Gui Add, Button, hWndhBtnKillbloat vBtnKillbloat gOnBtnKillbloatClicked x712 y488 w216 h84, % "Kill Bloat"
    
    Gui Font

    if (A_Args[1] = "-show") {
        showUI()
    }

    return

showUI() {
    ; [96] Quick Panel (17.05. 14:01:34) ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe ahk_pid 8904
    IfWinNotExist, Quick Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    {
        runs := runs + 1
        FormatTime, timestamp, A_Now, dd.MM. HH:mm:ss
        Gui Show, w936 h580, % "[" . runs . "] Quick Panel (" . timestamp . ")"
    }
    WinActivate, Quick Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
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
    GuiClose(0)
    KillProcesses(["retrobar","explorer","StartMenu","ClassicIE_32","ClassicIE_64","ClassicExplorerSettings"])
    HideTaskbar(false)
    Run explorer
    ; Run % "C:\Program Files\Open-Shell\StartMenu.exe -togglenew"
    ; C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -command "&{$p='HKCU:SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\StuckRects3';$v=(Get-ItemProperty -Path $p).Settings;$v[8]=2;&Set-ItemProperty -Path $p -Name Settings -Value $v;&Stop-Process -f
}

OnBtnStartRetrobarClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("OnBtnStartExplorerClicked")
    GuiClose(0)
    KillProcesses(["retrobar"])
    SleepS(1)
    Run retrobar
    SleepS(1)
    ; Run % "C:\Program Files (x86)\Moo0\AlwaysOnTop\WindowMenuPlus.exe"
    ; Run % "C:\Program Files\Open-Shell\StartMenu.exe -settings"
    ; Run % "C:\Program Files\Open-Shell\StartMenu.exe -togglenew"
}

OnBtn10Clicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("ChilloutVR")
    KillProcesses(["VRCX","VRChat","ChilloutVR","conhost","cmd"])
    Run % """G:\Steam\steamapps\common\ChilloutVR\ChilloutVR.exe"" -vr -skipsteam --disable-videoplayers"
    GuiClose(0)
}

OnBtnStartVRChatClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("OnBtnStartVRChatClicked")
    KillProcesses(["VRCX","VRChat","ChilloutVR","conhost","cmd"])
    Run % "D:\OneDrive\Games\VRChat\_TOOLS\VRCX\VRCX.exe"
    Run % "G:\Steam\steamapps\common\VRChat\VRChat.exe"
    GuiClose(0)
}

OnBtn11Clicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    ; scriptlog("YouTube Music")
    KillProcesses(["YouTube Music"])
    SleepS(1)
    ShellRun("C:\Users\blusc\AppData\Local\Programs\youtube-music\YouTube Music.exe", "")
    GuiClose(0)
}

OnBtnKillbloatClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(false, "", "/mybloat")
    KillProcesses(["wallpaper32","everything64"])
    GuiClose(0)
}
OnBtnKillNonBloatClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(false, "", "/nonbloat")
}
OnBtnKillSemiBloatClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(false, "", "/semibloat")
}
OnBtnKillCMDClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(false, "", "/cmd")
    ExitApp
}
OnBtnKillScriptsClicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    new File("C:\Program Files\AutoHotKey\Scripts\bloat.ahk").run(false, "", "/ahk")
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