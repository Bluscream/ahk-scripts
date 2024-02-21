#SingleInstance, force
#Include <bluscream>

class VirtualDesktop {
    dir := new Directory("C:\Program Files\Virtual Desktop Streamer")
    exe := dir.CombineFile(vd.windows.streamer.exe)
    connected := vd.windows.server.process.exists()
    windows := { server: new Window("", "", "VirtualDesktop.Server.exe")
        ,streamer: new Window("Virtual Desktop Streamer", "HwndWrapper[VirtualDesktop.Streamer;UI Thread;", "VirtualDesktop.Streamer.exe")
        ,service: new Window("","","VirtualDesktop.Service.exe")}
    service_name := "VirtualDesktop.Service"
    streamer_path := new Paths.Public().programs.CombineFile("Virtual Desktop Streamer.lnk")
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

    ensure() {
        service := this.windows.service.Process
        if (!service.exists()) {
            scriptlog(service.name . " not running, starting " . this.service_name)
            StartServices([this.service_name])
        }
        streamer := this.windows.streamer.Process
        if (!streamer.exists()) {
            scriptlog(streamer.name . " not running, starting " . vd.streamer_path.Quote())
            vd.streamer_path.run()
        }
        server := this.windows.server.Process
        if (!server.exists()) {
            scriptlog(server.name . " not running!")
        }
    
    }

    start() {
        scriptlog("Starting Virtual Desktop")
        this.StartService()
        this.startStreamer()
    }

    startService() {
        EnforceAdmin()
        scriptlog("Starting " . this.service_name)
        StartServices([this.service_name])
    }

    startStreamer() {
        EnforceAdmin()
        scriptlog("Starting Virtual Desktop Streamer")
        this.streamer_path.run()
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
        StopServices([this.service_name])
    }
}