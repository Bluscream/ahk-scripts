#Include <bluscream>
#Include <logtail>
class TrayLib {   
    logdir := new Directory("C:\Users\blusc\AppData\Local\RetroBar\Logs\")
    tailer := ""
    callback := ""
    __New(callback := "", logdir := "") {
        if (logdir!="") {
            this.logdir := new Directory(logdir)
        }
        if (!this.logdir.exists() || this.logdir.path == "\") {
            MsgBox % "Directory " . this.dir.Quote() . " does not exist!"
        }
        
        ; latest := this.getLog().path
        ; scriptlog("Starting Tailer for " . latest)
        ; this.tailer := new LogTailer(latest, callback, true) ; This is where i want to pass my own class method as callback for Logtailer [ Func("this.onNewLine")]
        
        this.callback := callback ; This is where i save the original callback [ Func("OnTrayChanged") ]
    }

    start(callback := "") {
        latest := this.getLog().path
        scriptlog("Starting Tailer for " . latest)
        this.tailer := new LogTailer(latest, callback, true) ; This is where i want to pass my own class method as callback for Logtailer [ Func("this.onNewLine")]
    }

    stop() {
        this.tailer.Delete()
    }

    parseLine(line) {
        validLine := RegExMatch(line, "^\[(.*)\] (\w+): (\w+): (\w+): (.*)$", icon)
        if (!validLine) {
            validLine := RegExMatch(line, "^\[(.*)\] (\w+): (\w+): Received notification ""(.*)"" for (.*)$", notification)
            line := {_line: line
            ,timestamp: notification1
            ,severity: notification2
            ,type: notification3
            ,event: "Notification"
            ,notification: notification4
            ,msg: notification5}
        return line
        }
        ; [7/9/2022 2:55:56 PM] Debug: NotificationArea: Modified: Virtual Desktop Streamer is connected
        ; [7/9/2022 2:55:56 PM] Debug: NotificationArea: Received notification "Error streaming Desktop" for Virtual Desktop Streamer is connected
        line := {_line: line
            ,timestamp: icon1
            ,severity: icon2
            ,type: icon3
            ,event: icon4
            ,msg: icon5}
        return line
    }

    onNewLine(line) { 
        line := this.parseLine(line)
        this.callback.call(line.event, line.msg) ; This is where i want to call the initial callback with my modified values
    }

    getLog() {
        return this.logdir.getNewestFile("*.log")
    }

}