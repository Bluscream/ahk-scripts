#SingleInstance, force
#Include <bluscream>

class VirtualDesktop {
    windows := { server: new Window("", "", "VirtualDesktop.Server.exe")
        ,streamer: new Window("Virtual Desktop Streamer", "HwndWrapper[VirtualDesktop.Streamer;UI Thread;", "VirtualDesktop.Streamer.exe")
        ,service: new Window("","","VirtualDesktop.Service.exe")}
    dir := new Directory("C:\Program Files\Virtual Desktop Streamer")
    connected := false
    service_name := "VirtualDesktop.Service"
    ; streamer_path := new File("C:\Program Files\Virtual Desktop Streamer\VirtualDesktop.Streamer.exe") ; new Paths.Public().programs.CombineFile("Virtual Desktop Streamer", "Virtual Desktop Streamer.lnk")
    doublechecking := false
    safe_mode := false
    args := ""
    eventhandlers := {}
    state := "None"
    __New(streamer_path := "", eventcallback := "") {
        if (streamer_path!="") {
            this.streamer_path := new File(streamer_path) 
            this.dir := this.streamer_path.directory
        } else {
            this.streamer_path := this.dir.CombineFile(this.windows.streamer.exe)
        }
        this.connected := this.windows.server.process.exists()
    }

    init() {
    }

    ensure() {
        service := this.windows.service.Process
        if (!service.exists()) {
            scriptlog(service.name . " not running, starting " . this.service_name)
            StartServices([this.service_name])
        }
        streamer := this.windows.streamer.Process
        if (!streamer.exists()) {
            scriptlog(streamer.name . " not running, starting " . this.streamer_path.Quote())
            this.streamer_path.run()
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