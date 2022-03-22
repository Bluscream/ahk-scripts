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
    if (!isExplorerRunning())
        Run explorer
    return
^+Esc::
    if (!isExplorerRunning())
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
; <#y::
;     ShellRun("C:\Program Files\Open-Shell\StartMenu.exe", "-togglenew")
F1::
    if (isOBSRunning())
        Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Cam""",, Hide
    else
        Send {Media_Play_Pause}
    return
F2::
    if (isOBSRunning())
        Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Screen""",, Hide
    else
        Send {Volume_Mute}
    return
F3::
    if (isOBSRunning())
        Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab Microscope""",, Hide
    else
        Send {Media_Prev}
    return
F4::
    if (isOBSRunning())
        Run, % "OBSCommand.exe /server=127.0.0.1:4444 /scene=""Lab All""",, Hide
    else
        Send {Media_Next}
    return
isExplorerRunning() {
    return new Process("explorer.exe").exists()
}
isOBSRunning() {
    return new Process("obs64.exe").exists()
}