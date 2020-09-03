#Include <bluscream>
#Include <logtail>
class Game {
    name := "Black Squad"
    appid := 550650
    dir := new Directory()
    exe := new File()
    logdir := new Directory()
    logfile := new File()
    log := new LogTailer()
    windows := { "launcher": new Window("", "#32770", "BSLauncher.exe"), "game": new Window("BlackSquad (64-bit, DX9)", "LaunchCombatUWindowsClient", "BlackSquadGame.exe"), "belauncher": new Window("", "", "BlackSquadGame_BELauncher.exe"), "beservice": new Window("", "", "BEService_x64.exe"), "awesomium": new Window("", "", "awesomium_process.exe") }
    patterns := {}
    had_error := false
    max_chat_chars := 100
    callback := "Func()"
    lastmap := ""
    lastping := ""

    __New(path, eventcallback := "") {
        this.dir := new Directory(path)
        if (!this.dir.exists()) {
            MsgBox % this.name . " directory " . this.dir.Quote() . " does not exist!"
        }
        this.exe := this.dir.combineFile("binaries", "win64", this.windows["game"].exe)
        this.callback := eventcallback
        this.logdir := this.dir.combine("CombatGame", "Logs")
        this.logfile := this.logdir.combineFile("Launch.log")
        if (this.logfile.exists()) {
            this.patterns["log"] := "\[(\d{4}\.\d{2}\.\d{2}\-\d{2}\.\d{2}\.\d{2})\] (.*)"
            this.patterns["msg"] := "Log: (.*)"
            this.patterns["beguid"] := "BattlEyeLog: Server computed GUID: ([a-z0-9]{32})"
            this.patterns["error"] := "Disconnet Client: (\d+)"
            this.patterns["failed_connect"] := "(\w+) wParam:\[(9)\] lParam\[(3)\]"
            this.patterns["close"] := "Closing by request"
            this.patterns["ping"] := "GetPing return time:(\d+) result:(\w+)"
            this.patterns["startup"] := ">>>>>>>>>>>>>> Initial startup: ([0-9]+\.[0-9]+)s <<<<<<<<<<<<<<<"
            this.patterns["map_load"] := "UGameEngine\:\:LoadMap entered - (\w+)"
            this.patterns["matchstate_changed"] := "ScriptLog: GameLOG >> BeginState >> ChangedState\( (\w+) \)"
            this.log := new LogTailer(this.logfile.path, Func("game.OnNewLogLine"), false)
        } else {
            MsgBox % this.name . " logfile " . this.logfile.Quote() . " does not exist!"
        }
    }

    OnNewLogLine(FileLine) {
        scriptlog(FileLine)
        if (!this.patterns)
            return
        Func("OnLogLine").call(FileLine)
        if (RegExMatch(FileLine, this.patterns["log"], log)) {
            if (RegExMatch(log2, this.patterns["msg"], msg)) {
                if (RegExMatch(msg2, this.patterns["beguid"], beguid)) {
                    Func("OnBattleyeGuid").call(beguid1)
                    scriptlog("BEGUID: " . beguid2, log1)
                } else if (RegExMatch(msg2, this.patterns["error"], error)) {
                    Func("OnError").call(error1)
                    this.had_error := true
                } else if (RegExMatch(log2, this.patterns["close"], close)) {
                    Func("OnExit").call(!this.had_error)
                    this.had_error := false
                } else if (RegExMatch(log2, this.patterns["ping"], ping)) {
                    Func("OnPing").call(ping1, ping2)
                    this.lastping := ping
                } else if (RegExMatch(log2, this.patterns["map_load"], map_load)) {
                    Func("OnMapLoaded").call(map_load1)
                    this.lastmap := name
                } else if (RegExMatch(log2, this.patterns["failed_connect"], failed_connect)) {
                    Func("OnError").call(failed_connect1, failed_connect2, failed_connect3)
                    this.had_error := true
                }
            }
        } else {
            scriptlog("INVALID: " . FileLine)
        }
    }
    start(steam := true) {
        winstr := this.windows["launcher"].str()
        MsgBox % winstr
        Run, % steam ? ("steam://rungameid/" . this.appid) : this.dir.combineFile("binaries", this.windows["launcher"].exe).path
        WinWait, % winstr
        WinActivate, % winstr
        WinWaitActive, % winstr
        ; sleep, 2500
        ; SetControlDelay -1
        while (true) {
            ControlGet, isPlayButtonEnabled, Enabled,, % "MFCButton1", % winstr
            if (isPlayButtonEnabled) {
                WinActivate, % winstr
                WinWaitActive, % winstr
                CoordMode, Mouse, Client
                ; ControlClick, x702 y558, % winstr
                ControlClick, % "MFCButton1", % winstr,,,, NA
                winstr := this.windows["game"].str()
                WinWait, % winstr
                WinActivate, % winstr
                WinWaitActive, % winstr
                SplashScreen(this.windows["game"].process.commandLine(), "Game started")
                return
            }
            sleep, 250
        }
    }
    clearLogs() {
        logs := this.logdir.combineFile("*.log").path
        FileDelete, % logs
        this.logfile.create()
    }

    kill() {
        for i, window in this.windows {
            window.process.close()
            window.process.kill(true, true)
        }
    }
}