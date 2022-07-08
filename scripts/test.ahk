#SingleInstance, force
#Persistent
#Include <bluscream>
#include <utilities>
global no_ui := False
global traylib := new TrayLib(Func("OnTrayChanged"))
traylib.start()

OnTrayChanged(event, msg) {
    if (IsEmptyString(event)) {
        return
    }
    if (event == "Added") {
        scriptlog("ADDED NEW TRAY ICON " . msg)
    } else if (event == "Modified") {
        scriptlog("MODIFIED TRAY ICON " . msg)
    } else if (event == "Removed") {
        scriptlog("REMOVED TRAY ICON " . msg)
    }
}

scriptlog("end")