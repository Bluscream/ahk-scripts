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
        Run % "C:\Program Files\AutoHotKey\Scripts\button_panel.ahk"
    }
    return

explorer() {
    return Process.Exist("explorer.exe")
}