#SingleInstance, force
#Persistent
#Include <bluscream>
#include <utilities>
global no_ui := False
global traylib := new TrayLib(Func("OnTrayChanged"))
traylib.start()

OnTrayChanged(line) {
    line := traylib.parseLine(line)
    scriptlog(toJson(line))
    if (IsEmptyString(line._line)) {
        return
    }
    if (line.event == "Added") {
        scriptlog("ADDED NEW TRAY ICON " . line.msg)
    } else if (event == "Modified") {
        scriptlog("MODIFIED TRAY ICON " . line.msg)
    } else if (event == "Removed") {
        scriptlog("REMOVED TRAY ICON " . line.msg)
    }
}

scriptlog("end")