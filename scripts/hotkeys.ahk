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
; SetTimer, CheckVivecraftInstaller, 1000
; SetTimer, CheckEasyFileLocker, 2500
global no_ui := true
global debug := false

global available_hotkeys := { "Win + H": "List Available Hotkeys"
, "(Shift) + Win + C": "Run cmd (as admin)"
, "(Shift) + Win + P": "Run powershell (as admin)"
, "(Shift) + Win + T": "Run Windows Terminal (as admin)"
, "(Shift) + Win + E": "Run explorer (as admin)"
, "Ctrl + Shift + Esc": "Run taskmgr"
, "Alt + Control + Shift + T": "Toggle Taskbar"
, "Win + X": "Run Quick Start Panel"
, "Shift + Win + N": "Run Numpad"
, "Ctrl + B": "Run copywrite.py"
, "Ctrl + Shift + V": "Run copywrite.py"
, "Ctrl + Alt + V": "Run split_clipboard.py"
, "Steam Button": "Run Steam Big Picture"
, "Steam Button + LB": "Restart Virtual Desktop"
, "Steam Button + RB": "Run Virtual Desktop"}

return

showHotKeys() {
    global available_hotkeys
    msg := ""
    for key, value in available_hotkeys {
        msg .= key . " = " . value . "`n"
    }
    MsgBox, % msg, Available Hotkeys
    return
}

; AHK Hotkey Modifier Symbols
; # = Win (Windows logo key)
; ! = Alt
; ^ = Control
; + = Shift
; & = When used between two keys, the hotkey will only fire if both keys are pressed together.
; ~ = When used between two keys, the hotkey will fire if the user presses the first key and then holds down the second key, but will not fire if the user presses the first key and then releases the second key. The & prefix is equivalent to specifying {Blind} for this hotkey.
; * = This prefix character allows the Send command to send {Blind} keystrokes, meaning that it will not wait for the target window to become active before sending. For example: Send *abcdef is equivalent to Send {Blind}abcdef. The * prefix is equivalent to specifying {Blind} for all Send commands in a particular thread.
; $ = This prefix character forces the keyboard hook to be used to implement this hotkey, which as a side-effect prevents the Send command from sending its keys to the keyboard hook (however, they might still end up in the hook's queue). This prefix character is equivalent to specifying {Hook} for this hotkey.
; > = This prefix character causes the hotkey to be triggered even if the user is holding down one or more modifier keys (Ctrl, Alt, Shift, and Win) at the time the hotkey is pressed. This prefix character is equivalent to specifying {Blind} for this hotkey.
; < = This prefix character causes the hotkey to be triggered by the left-hand version of the key only. This is usually only necessary for keys whose right-hand version might have a different effect such as the NumPad keys. This prefix character is equivalent to specifying {LAlt} for this hotkey.

<#h::showHotKeys() ; Win + H
<#c::Run cmd ; Win + C
+#c::ShellRun("cmd") ; Shift + Win + C
<#p::Run powershell ; Win + P
+#p::ShellRun("powershell") ; Shift + Win + P
<#t::Run shell:AppsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App ; Win + T
+#t::ShellRun("shell:AppsFolder\Microsoft.WindowsTerminal_8wekyb3d8bbwe!App") ; Shift + Win + T
<#e::Run explorer Shell:::{20d04fe0-3aea-1069-a2d8-08002b30309d} ; Win + E
+#e::ShellRun("explorer") ; Shift + Win + E
; <#r::Run explorer.exe Shell:::{2559a1f3-21d7-11d4-bdaf-00c04f60b9f0}
^+Esc::Run taskmgr ; Ctrl + Shift + Esc
!^+t:: HideTaskbar(hide := !hide) ; Alt + Control + Shift + T
<#x:: ; Win + X
    ; IfWinExist, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    ; {
    ;     WinActivate, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    ; }
    IfWinNotExist, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    {
        Run % "C:\Program Files\AutoHotKey\Scripts\button_panel.ahk"
    }
    return
; <#g:: ; Win + G
;     new Process("fivem_b2545_dumpserver").kill()
;     new Process("fivem_steamchild").kill()
;     new Process("fivem_chromebrowser").kill()
;     new Process("fivem_b2545_gtaprocess").kill()
;     new Process("FiveM.exe").kill()
;     Run % "fivem://connect/kzyerv"
;     ShellRun("C:\Users\blusc\AppData\Local\FiveM\FiveM.exe", "fivem://connect/kzyerv")
;     return
+<#n:: ; Shift + Win + N
    Run "C:\Program Files\AutoHotkey\AutoHotkeyU64.exe" "C:\Program Files\AutoHotkey\Scripts\numpad.ahk"
    Return

; ^b:: ; Ctrl + B
^+v:: ; Ctrl + Shift + V
    Run % "C:\Scripts\copywrite.py",, Min
    Return
^!v:: ; Ctrl + Alt + V
    Run % "C:\Scripts\split_clipboard.py",, Min
    Return

3Joy12:: ; Steam Button
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
3Joy1:: ; A
    if GetKeyState("3Joy4") and GetKeyState("3Joy11") { ; A + LB
        KillProcesses(["VirtualDesktop.Streamer", "VirtualDesktop.Service"])
        StopServices(["VirtualDesktop.Service.exe"])
        StartServices(["VirtualDesktop.Service.exe"])
    }
    return
; <#y:: ; Win + Y
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

; CheckVivecraftInstaller:
;     SetTimer, CheckVivecraftInstaller, Off
;     win := new Window("Vivecraft Installer","SunAwtDialog","java.exe")
;     if (win.exists()) {
;         win2 := new Window("Open","SunAwtDialog","java.exe")
;         win2.waitActive()
;         Send ^a
;         SendInput, C:\tools\MultiMC
;         WinWaitClose, % win2.str()
;         WinWaitClose, % win.str()
;     }
;     SetTimer, CheckVivecraftInstaller, 1000
;     return

; CheckEasyFileLocker:
    ; SetTimer, CheckEasyFileLocker, Off
    ; ; win := new Window("Files & Folders Setting","#32770","FileLocker.exe")
    ; win2 := new Window("Browse for Folder","#32770","FileLocker.exe")
    ; ; Run % "C:\Program Files\Easy File Locker\FileLocker.exe"
    ; if (win2.exists()) {
    ;     win2.close()
    ;     FileSelectFolder, dir, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 7
    ;     ControlSetText, Edit1, % dir, % winstr2
    ; }
    ; SetTimer, CheckEasyFileLocker, 2500
    ; return