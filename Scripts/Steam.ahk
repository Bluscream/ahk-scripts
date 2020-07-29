#SingleInstance Force
#NoEnv
#NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
#Include <bluscream>

global steam := new Window("Steam - Refresh Login", "vguiPopupWindow", "Steam.exe")
FileRead, pw, % "..\..\steam.txt"

while (true) {
    winstr := steam.str()
    WinWait, % winstr
    WinActivate, % winstr
    WinWaitActive, % winstr
    Send, % pw . "{Enter}"
    RunWait, "D:\Downloads\WinAuth.exe"
    Sleep, 1000
}