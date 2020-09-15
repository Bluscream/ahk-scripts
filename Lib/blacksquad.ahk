#Include <bluscream>
#Include <logtail>
class Game {
    name := "Black Squad"
    appid := 550650
    dir := new Directory()
    exe := new File()
    logdir := new Directory()
    logfile := new File()
    ; log := new LogTailer()
    windows := { "launcher": new Window("", "#32770", "BSLauncher.exe"), "game": new Window("BlackSquad (64-bit, DX9)", "LaunchCombatUWindowsClient", "BlackSquadGame.exe"), "belauncher": new Window("", "", "BlackSquadGame_BELauncher.exe"), "beservice": new Window("", "", "BEService_x64.exe"), "awesomium": new Window("", "", "awesomium_process.exe") }
    patterns := {}
    had_error := false
    max_chat_chars := 100
    datafile := new File()
    data := {"starttime":0,"ping":0,"map":"","maps":{},"server":{"ip":"","port":0},"player":{"name":"","userid":"","security_code":"","steam":{"id":0,"name":""}}}

    __New(path, eventcallback := "") {
        this.dir := new Directory(path)
        if (!this.dir.exists()) {
            MsgBox % this.name . " directory " . this.dir.Quote() . " does not exist!"
        }
        this.exe := this.dir.combineFile("binaries", "win64", this.windows["game"].exe)
        this.datafile := this.dir.combineFile("data.json")
        if (this.datafile.exists() && this.datafile.size() > 0)
            this.data := fromJson(this.datafile.read())
        this.logdir := this.dir.combine("CombatGame", "Logs")
        this.logfile := this.logdir.combineFile("Launch.log")
        if (!this.logfile.exists()) {
            MsgBox % this.name . " logfile " . this.logfile.Quote() . " does not exist!"
        }
        this.patterns["log"] :=                  "^\[(\d{4}\.\d{2}\.\d{2}\-\d{2}\.\d{2}\.\d{2})\] (.*)"
        this.patterns["msg"] :=                  "^Log: (.*)"
        this.patterns["beguid"] :=               "^BattlEyeLog: Server computed GUID: ([a-z0-9]{32})"
        this.patterns["error"] :=                "^Disconnet Client: (\d+)"
        this.patterns["failed_connect"] :=       "^(\w+) wParam:\[(9)\] lParam\[(3)\]"
        this.patterns["close"] :=                "^Closing by request"
        this.patterns["ping"] :=                 "^GetPing return time:(\d+) result:(\w+)"
        this.patterns["mapload"] :=              "^UGameEngine\:\:LoadMap entered - ([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})\:?([0-9]{1,5})?\/(\w+).*SecurityCode=(\d+).*UserID=(\d+)"
        this.patterns["mapload2"] :=             "^UGameEngine\:\:LoadMap entered - (\w+)"
        this.patterns["mapload3"] :=             "^Bringing World (\w+)\.TheWorld up for play \((\d+)\) at"
        this.patterns["mapload4"] :=             "^Welcomed by server \(Level: (\w+),"
        this.patterns["matchstate_changed"] :=   "^ScriptLog: GameLOG >> BeginState >> ChangedState\( (\w+) \)"
        this.patterns["level_load_completed"] := "^ScriptLog: OnPendingLevelCompleted - ErrorCode:(\d+)"
        this.patterns["server_browse"] :=        "^0\(\)=pEngine->IPPortBrowse\(([0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3})\:?([0-9]{1,5})?"
        this.patterns["gameresult"] :=           "^Go to GameResult"
        this.patterns["startup"] :=              "^>>>>>>>>>>>>>> Initial startup: ([0-9]+\.[0-9]+)s <<<<<<<<<<<<<<<"
    }

    updateData(key, value) {
        ; keys := StrSplit(key, ".")
        ; for _i, key in keys {
        ; }
        this.data[key] := value
        this.datafile.write(toJson({"data":this.data}, true))
    }

    start(steam := true) {
        running := this.windows["game"].exists()
        if (running)
            this.kill()
        winstr := this.windows["launcher"].str()
        Run, % steam ? ("steam://rungameid/" . this.appid) : this.dir.combineFile("binaries", this.windows["launcher"].exe).path
        WinWait, % winstr
        ; WinActivate, % winstr
        ; WinWaitActive, % winstr
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
                this.updateData("starttime", A_NowUTC)
                return
            }
            sleep, 250
        }
    }
    clearLogs() {
        logs := this.logdir.combineFile("*.log").path
        FileDelete, % logs
        ; this.logfile.create()
    }

    kill() {
        for i, window in this.windows {
            ; scriptlog("Killing " . window.str())
            window_closed := window.close()
            process_closed := window.process.close()
            process_killed := window.process.kill(true, true)
            ; scriptlog("window_closed: " . toYesNo(window_closed))
            ; scriptlog("process_closed: " . toYesNo(window_closed))
            ; scriptlog("process_killed: " . toYesNo(window_closed))
        }
    }
}