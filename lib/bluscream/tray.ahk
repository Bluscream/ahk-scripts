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
        validLine := RegExMatch(line, "^\[(.*)\] (\w+): (\w+): (\w+): (.*)$", msg)
        if (!validLine) {
            return
        }
        if (msg3 != "NotificationArea") {
            return
        }
        line := {_line: line
            ,timestamp: msg1
            ,severity: msg2
            ,type: msg3
            ,event: msg4
            ,msg: msg5}
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