#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance,Force ;limit to a single instance
#MaxThreadsPerHotkey 2
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; Define the window titles
windowTitle1 := "Minecraft 1.10.2 ahk_class LWJGL ahk_exe javaw.exe ahk_pid 27136 ahk_id 1640892"
windowTitle2 := "Minecraft 1.10.2 ahk_class LWJGL ahk_exe javaw.exe ahk_pid 6572 ahk_id 14422054"

^i:: ; Ctrl + i
 Loop{
     Sleep, 300
     ; Activate the first window
     WinActivate, %windowTitle1%
     Click, Right D
     Sleep, 300
     ; Activate the second window
     WinActivate, %windowTitle2%
     Click, Right D
     Sleep, 300
 }
 return
return
F1::Reload ; Pause 
F2::ExitApp
