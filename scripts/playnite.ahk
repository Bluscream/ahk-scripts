#SingleInstance, force
#Persistent
#Include <bluscream>
global playnite := new Window("Playnite", "", "Playnite.DesktopApp.exe")
global playnite_popup := new Window("", "", "Playnite.DesktopApp.exe")
SetTimer, ClickMiddle, 2500
return
ClickMiddle:
    if (playnite.exists()){
        playnite_popup.activate()
        if (!playnite.isActive() && playnite_popup.isActive()) {
            Send, "{Enter}"
        }
    } else ExitApp