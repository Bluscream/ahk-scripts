#Include <bluscream>
#Include <logtail>
global _game := new Game("S:\Steam\steamapps\common\Black Squad\")
class Game {
    name := "Black Squad"
    appid := 550650
    dir := new Directory()
    exe := new File()
    logdir := new Directory()
    logfile := new File()
    ; log := new LogTailer()
    windows := { "launcher": new Window("", "#32770", "BSLauncher.exe"), "game": new Window("BlackSquad (64-bit, DX9)", "LaunchCombatUWindowsClient", "BlackSquadGame.exe"), "belauncher": new Window("", "", "BlackSquadGame_BELauncher.exe"), "beservice": new Window("", "", "BEService_x64.exe"), "awesomium": new Window("", "", "awesomium_process.exe") }
    patterns := { "log": "\[(\d{4}\.\d{2}\.\d{2}\-\d{2}\.\d{2}\.\d{2})\] (.*)", "msg": "Log: (.*)", "beguid": "BattlEyeLog: Server computed GUID: ([a-z0-9]{32})", "error": "Disconnet Client: (\d+)", "failed_connect": "(\w+) wParam:\[(9)\] lParam\[(3)\]", "close": "Closing by request", "ping": "GetPing return time:(\d+) result:(\w+)",    "map_load": "UGameEngine\:\:LoadMap entered - (\w+)", "matchstate_changed": "ScriptLog: GameLOG >> BeginState >> ChangedState\( (\w+) \)" }
    ; patterns["startup"] := ">>>>>>>>>>>>>> Initial startup: ([0-9]+\.[0-9]+)s <<<<<<<<<<<<<<<"
    had_error := false
    max_chat_chars := 100
    lastmap := ""
    lastping := ""

    __New(path, eventcallback := "") {
        this.dir := new Directory(path)
        if (!this.dir.exists()) {
            MsgBox % this.name . " directory " . this.dir.Quote() . " does not exist!"
        }
        this.exe := this.dir.combineFile("binaries", "win64", this.windows["game"].exe)
        this.logdir := this.dir.combine("CombatGame", "Logs")
        this.logfile := this.logdir.combineFile("Launch.log")
        if (!this.logfile.exists()) {
            MsgBox % this.name . " logfile " . this.logfile.Quote() . " does not exist!"
        }
    }

    start(steam := true) {
        winstr := this.windows["launcher"].str()
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