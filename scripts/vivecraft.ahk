#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#include <bluscream>

while True {
    WinWait, Vivecraft Installer ahk_class SunAwtDialog ahk_exe java.exe
    WinWait, Open ahk_class SunAwtDialog ahk_exe java.exe
    SendInput, C:\tools\MultiMC
    WinWaitClose, Vivecraft Installer ahk_class SunAwtDialog ahk_exe java.exe
    SleepS(1)
}