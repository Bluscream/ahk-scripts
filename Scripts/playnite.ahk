#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
; DetectHiddenWindows On
#Include <bluscream>
; CoordMode, mouse, Client
dir := new Paths().programfiles.Combine("Playnite")

global playnite_desktop := new Window("Playnite", "HwndWrapper[Playnite.DesktopApp.exe;;9a3aa77c-ad3c-4276-a6c2-a8ec7d09fb2f]", dir.CombineFile("Playnite.DesktopApp.exe"))
global playnite_popup := new Window("", "", "Playnite.DesktopApp.exe")
playnite_fullscreen := new Window("Playnite", "HwndWrapper[Playnite.FullscreenApp.exe;;d8020682-45c9-4d48-8f1c-1650e966f068]", dir.CombineFile("Playnite.FullscreenApp.exe"))
playnite_fullscreen.exe.run()
WinWaitActive ahk_exe Playnite.FullscreenApp.exe
new Window("", "", playnite_fullscreen.exe.name).minimize()
ExitApp
return

SetTimer, ClickMiddle, 2500
return
ClickMiddle:
    if (playnite_desktop.exists()){
        playnite_popup.activate()
        if (!playnite_desktop.isActive() && playnite_popup.isActive()) {
            Send, "{Enter}"
        }
    } else ExitApp