#SingleInstance, force
#Persistent
#Include <bluscream>
#include <utilities>
global no_ui := False
global traylib := new TrayLib(Func("OnTrayChanged"))
traylib.start(Func("OnTrayChanged"))

global last_vd_event := ""

OnTrayChanged(line) {
    line := traylib.parseLine(line)
    if (IsEmptyString(line.event)) {
        return
    }
    if (startsWith(line.msg, "Virtual Desktop")) {
        scriptlog(line.msg)
    }
    if (line.event == "Modified") {
        if (line.msg == last_vd_event) {
            return
        }
        last_vd_event := line.msg
        if (line.msg == "Virtual Desktop Streamer is connecting...") {
            vd.state = "Connecting"
            OnVirtualDesktopConnecting()
        } else if (line.msg == "Virtual Desktop Streamer is ready") {
            vd.state = "Ready"
            OnVirtualDesktopReady()
        } else if (line.msg == "Virtual Desktop Streamer is establishing connection...") {
            vd.state = "EstablishingConnection"
            OnVirtualDesktopEstablishingConnection()
        } else if (line.msg == "Virtual Desktop Streamer is connected") {
            vd.state = "Connected"
            OnVirtualDesktopConnected()
        }
    }
}

OnVirtualDesktopReady() {
    scriptlog("OnVirtualDesktopReady")
}
OnVirtualDesktopConnecting() {
    scriptlog("OnVirtualDesktopConnecting")
}
OnVirtualDesktopEstablishingConnection() {
    scriptlog("OnVirtualDesktopEstablishingConnection")
}
OnVirtualDesktopConnected() {
    scriptlog("OnVirtualDesktopConnected")
}

scriptlog("end")