#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
return

<#c::
    Run cmd
    return
<#p::
    Run powershell
    return
<#e::
    if (!explorer())
        Run explorer
    return
^+Esc::
    if (!explorer())
        Run taskmgr
    return
<#x::
    IfWinExist, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    {
        WinActivate, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    }
    IfWinNotExist, Quick Start Panel ahk_class AutoHotkeyGUI ahk_exe AutoHotkey.exe
    {
        Run % "D:\OneDrive\AutoHotKey\Scripts\button_panel.ahk"
    }
    return
; <#y::
;     ShellRun("C:\Program Files\Open-Shell\StartMenu.exe", "-togglenew")
F1::
    Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Cam""",, Hide
    return
F2::
    Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Screen""",, Hide
    return
F3::
    Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Microscope""",, Hide
    return
F4::
    Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab All""",, Hide
    return
explorer() {
    return Process.Exist("explorer.exe")
}