#Include <bluscream>
#Include <logtail>
MsgBox % "test1"
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
        MsgBox % "test"
        this.dir := new Directory(path)
        if (!this.dir.exists())
            MsgBox % this.name . " directory " . this.dir.Quote() . " does not exist!"
        this.exe := game_dir.combineFile("binaries", "win64", this.windows["game"].exe)
        this.callback := eventcallback
        this.logdir := this.dir.combine("CombatGame", "Logs")
        this.logfile := this.log_dir.combineFile("Launch.log")
        if (this.logfile.exists()) {
            this.patterns["log"] := "\[(\d{4}\.\d{2}\.\d{2}\-\d{2}\.\d{2}\.\d{2})\] (.*)"
            this.patterns["msg"] := "Log: (.*)"
            this.patterns["beguid"] := "BattlEyeLog: Server computed GUID: ([a-z0-9]{32})"
            this.patterns["error"] := "Disconnet Client: (\d+)"
            this.patterns["close"] := "Closing by request"
            this.patterns["ping"] := "GetPing return time:(\d+) result:(\w+)"
            this.patterns["startup"] := ">>>>>>>>>>>>>> Initial startup: ([0-9]+\.[0-9]+)s <<<<<<<<<<<<<<<"
            this.patterns["map_load"] := "UGameEngine\:\:LoadMap entered - (\w+)"
            this.patterns["matchstate_changed"] := "ScriptLog: GameLOG >> BeginState >> ChangedState\( (\w+) \)"
            this.log := new LogTailer(this.logfile.path, Func("this.OnNewLogLine"), false)
        }
    }

    OnNewLogLine(FileLine) {
        if (!p)
            return
        if (RegExMatch(FileLine, p["log"], log)) {
            if (RegExMatch(log2, p["msg"], msg)) {
                if (RegExMatch(msg2, p["beguid"], beguid)) {
                    this.OnBattleyeGuid(beguid1)
                    scriptlog("BEGUID: " . beguid2, log1)
                } else if (RegExMatch(msg2, p["error"], error)) {
                    this.OnError(error1)
                } else if (RegExMatch(log2, p["close"], close)) {
                    this.OnExit(!had_error)
                } else if (RegExMatch(log2, p["ping"], ping)) {
                    this.OnPing(ping1, ping2)
                } else if (RegExMatch(log2, p["map_load"], map_load)) {
                    this.OnMapLoaded(map_load1)
                }
            }
        } else {
            ; scriptlog("INVALID: " . FileLine)
        }
    }
    OnBattleyeGuid(guid) {
        self.callback.call("battleye_guid", guid)
    }
    OnError(code) {
        this.had_error := true
        self.callback.call("error", code)
    }
    OnExit(byUser) {
        this.had_error := false
        self.callback.call("exit", byUser)
    }
    OnPing(ping, result) {
        self.callback.call("ping", ping, result)
        this.lastping := ping
    }
    OnMapLoaded(name) {
        this.lastmap := name
        self.callback.call("map_loaded", name)
    }
}
MsgBox % "test2"