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
        this.callback := callback
    }

    start() {
        latest := this.getLog().path
        scriptlog("Starting Tailer for " . latest)
        this.tailer := new LogTailer(latest, this.callback, true)
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
        this.callback.call(line)
    }

    getLog() {
        return this.logdir.getNewestFile("*.log")
    }

}