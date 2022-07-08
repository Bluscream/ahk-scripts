#SingleInstance, force
#Include <bluscream>

class VirtualDesktop {
    dir := new Directory("C:\Program Files\Virtual Desktop Streamer")
    exe := dir.CombineFile(vd.windows.streamer.exe)
    connected := vd.windows.server.process.exists()
    windows := { server: new Window("", "", "VirtualDesktop.Server")
        ,streamer: new Window("Virtual Desktop Streamer", "HwndWrapper[VirtualDesktop.Streamer;UI Thread;117aaec4-0fa3-4fdc-b637-eb3c7fd4dc5b]", "VirtualDesktop.Streamer")
        ,service: new Window("","","VirtualDesktop.Service")}
    doublechecking := false
    safe_mode := false
    args := ""
    eventhandlers := {}
    state := "None"
    __New(exe := "", eventcallback := "") {
        if (exe!="") {
            this.exe := new File(exe) 
            this.dir := this.exe.directory
        }
    }

    start() {
        EnforceAdmin()
        scriptlog("Starting Virtual Desktop")
        StartServices(["VirtualDesktop.Service.exe"], true)
    }

    restart() {
        this.kill(True)
        SleepS(1)
        this.start()
    }

    kill(wait := false) {
        EnforceAdmin()
        scriptlog("Stopping Virtual Desktop")
        for i, window in this.windows {
            window_closed := window.close()
            process_closed := window.process.close()
            process_killed := window.process.kill(true, true)
        }
        StopServices(["VirtualDesktop.Service.exe"], true)
    }
}