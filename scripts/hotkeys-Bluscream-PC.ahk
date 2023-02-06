#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
#Include <steam>
global steam := new Steam()
global bspid := 0
SetTimer, CheckVivecraftInstaller, 1000
SetTimer, CheckEasyFileLocker, 2500
global no_ui := true
global debug := false
return

<#c::Run cmd
+#c::Run runas /trustlevel:0x20000 "cmd"
<#p::Run powershell
+#p:Run runas /trustlevel:0x20000 "powershell"
<#e::Run explorer Shell:::{20d04fe0-3aea-1069-a2d8-08002b30309d}
+#e::Run runas /trustlevel:0x20000 "explorer" ; ShellRun("explorer")
; <#r::Run explorer.exe Shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}
^+Esc::Run taskmgr
+#t:: HideTaskbar(hide := !hide)
<#x::
    ; IfWinExist, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    ; {
    ;     WinActivate, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    ; }
    IfWinNotExist, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    {
        Run % "C:\Program Files\AutoHotKey\Scripts\button_panel.ahk"
    }
    return
<#g::
    new Process("fivem_b2545_dumpserver").kill()
    new Process("fivem_steamchild").kill()
    new Process("fivem_chromebrowser").kill()
    new Process("fivem_b2545_gtaprocess").kill()
    new Process("FiveM.exe").kill()
    Run % "fivem://connect/kzyerv"
    ShellRun("C:\Users\blusc\AppData\Local\FiveM\FiveM.exe", "fivem://connect/kzyerv")
    return
+<#n::
    Run "C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" "C:\Program Files\AutoHotkey\Scripts\numpad.ahk"
    Return

3Joy12::
    if GetKeyState("3Joy11") {
        steam.bigpicture()
    }
    return

3Joy15::
    if GetKeyState("3Joy11") {
        if (bspid != 0 and ProcessExists(bspid)) {
            Process, Close, % bspid
        } else {
            Run "C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" "C:\Program Files\AutoHotkey\Scripts\JoystickMouse.ahk",,, bspid
            log("bspid: " . bspid)
        }
    } else if GetKeyState("3Joy10") {
        Run "C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" "C:\Program Files\AutoHotkey\Scripts\numpad.ahk"
    }
    return
3Joy1::
    if GetKeyState("3Joy4") and GetKeyState("3Joy11") {
        KillProcesses(["VirtualDesktop.Streamer", "VirtualDesktop.Service"])
        StopServices(["VirtualDesktop.Service.exe"])
        StartServices(["VirtualDesktop.Service.exe"])
    }
    return
; <#y::
;     ShellRun("C:\Program Files\Open-Shell\StartMenu.exe", "-togglenew")
; F1::
;     if (isOBSRunning())
;         Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Cam""",, Hide
;     else
;         Send {Media_Play_Pause}
;     return
; F2::
;     if (isOBSRunning())
;         Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Screen""",, Hide
;     else
;         Send {Volume_Mute}
;     return
; F3::
;     if (isOBSRunning())
;         Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Microscope""",, Hide
;     else
;         Send {Media_Prev}
;     return
; F4::
;     if (isOBSRunning())
;         Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab All""",, Hide
;     else
;         Send {Media_Next}
;     return
; isExplorerRunning() {
;     return new Process("explorer.exe").exists()
; }
; isOBSRunning() {
;     return new Process("obs64.exe").exists()
; }

CheckVivecraftInstaller:
    SetTimer, CheckVivecraftInstaller, Off
    win := new Window("Vivecraft Installer","SunAwtDialog","java.exe")
    if (win.exists()) {
        win2 := new Window("Open","SunAwtDialog","java.exe")
        win2.waitActive()
        Send ^a
        SendInput, C:\tools\MultiMC
        WinWaitClose, % win2.str()
        WinWaitClose, % win.str()
    }
    SetTimer, CheckVivecraftInstaller, 1000
    return

CheckEasyFileLocker:
    SetTimer, CheckEasyFileLocker, Off
    ; win := new Window("Files & Folders Setting","#32770","FileLocker.exe")
    win2 := new Window("Browse for Folder","#32770","FileLocker.exe")
    ; Run % "C:\Program Files\Easy File Locker\FileLocker.exe"
    if (win2.exists()) {
        win2.close()
        FileSelectFolder, dir, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 7
        ControlSetText, Edit1, % dir, % winstr2
    }
    SetTimer, CheckEasyFileLocker, 2500
    return