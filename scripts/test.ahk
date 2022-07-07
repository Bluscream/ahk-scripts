#SingleInstance, force
#Include <bluscream>
#Include <logtail>
global no_ui := False
scriptlog("init")
global logdir := new Directory("C:\Users\blusc\AppData\Local\RetroBar\Logs\")
scriptlog("logdir: " . toJson(logdir))
global latestlog := logdir.getNewestFile("*.log")
scriptlog("latestlog: " . toJson(latestlog))

lt_chat := new LogTailer(latestlog, Func("OnNewChatLine"), true, "CP1200")

OnNewChatLine(line) {
    if (line == "") {
        return
    }
    validLine := RegExMatch(line, log_pattern, msg)
    if (!validLine){
        scriptlog("INVALID: " . line)
        Return
    }
    scriptlog("VALID: " . line)
}

scriptlog("end")