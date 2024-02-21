#SingleInstance, force
#Include <bluscream>
#Include <steam>
#INCLUDE <Acc>
Acc_Init()
class SteamVR {
    appid := 250820
    windows := { vrwebhelper: new Window("", "", "vrwebhelper.exe")
        ,vrdashboard: new Window("", "", "vrdashboard.exe")
        ,vrmonitor: new Window("SteamVR Status", "Qt5QWindowIcon", "vrmonitor.exe")
        ,vrmonitor_extra: new Window("vrmonitor", "Qt5QWindowToolSaveBits", "vrmonitor.exe")
        ,vrcompositor: new Window("", "", "vrcompositor.exe")
        ,vrserver: new Window("", "", "vrserver.exe") }
    __New(exe := "", eventcallback := "") {
        if (exe!="") {
            this.exe := new File(exe) 
            this.dir := this.exe.directory
        }
        this.eventcallback := eventcallback
    }

    kill(wait := false) {
        for i, window in this.windows {
            window_closed := window.close()
            process_closed := window.process.close()
            process_killed := window.process.kill(true, true)
        }
    }

    restart() {
        this.kill(True)
        this.start()
    }

    start() {
        new Steam().run(this.appid)
    }

    hasFailed() {
        if (!this.windows.vrmonitor_extra.exists()) return false

        text := Acc_Get("Name", "4.7.1.8", 0, steamvr_vrmonitor_str)
        StringSplit, text, text, " "
        has_latency := (text1 > 0)
        scriptlog("text " . text . " has_latency " . has_latency)

        text := Acc_Get("Name", "4.8.1", 0, steamvr_vrmonitor_str)
        has_headset := (text != "Headset")
        scriptlog("text " . text . " has_headset " . has_headset)

        text := Acc_Get("Name", "4.1", 0, steamvr_vrmonitor_str)
        text2 := Acc_Get("Name", "4.2", 0, steamvr_vrmonitor_str)
        is_searching := (text == "Searching..." or text2 == "Make sure headset can see the play area")
        
        is_fail := !has_headset and !has_latency and !is_searching
        scriptlog("isSteamVRFail: " . toYesNo(is_fail) . " | has_latency " . toYesNo(has_latency) . " | has_headset " . toYesNo(has_headset) . " | is_searching " . toYesNo(is_searching))
        return is_fail
    }
}