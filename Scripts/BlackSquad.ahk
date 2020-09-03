; #Warn
#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
; SetBatchLines -1
#Include <bluscream>
; EnforceAdmin()
; DetectHiddenWindows On
CoordMode, Mouse, Client

class Game {
    dir := new Directory()
    logdir := new Directory()
    __New(path) {
        this.dir := new Directory("S:\Steam\steamapps\common\Black Squad\")
}

global w := {}
w["launcher"] := new Window("", "#32770", "BSLauncher.exe")
w["game"] := new Window( "BlackSquad (64-bit, DX9)", "LaunchCombatUWindowsClient", "BlackSquadGame.exe")
w["belauncher"] := new Window("", "", "BlackSquadGame_BELauncher.exe")
w["beservice"] := new Window("", "", "BEService_x64.exe")
w["awesomium"] := new Window("", "", "awesomium_process.exe")


global p := {}
p["log"] := "\[(\d{4}\.\d{2}\.\d{2}\-\d{2}\.\d{2}\.\d{2})\] (.*)"
p["msg"] := "Log: (.*)"
p["beguid"] := "BattlEyeLog: Server computed GUID: ([a-z0-9]{32})"
p["error"] := "Disconnet Client: (\d+)"
p["close"] := "Closing by request"
p["ping"] := "GetPing return time:(\d+) result:(\w+)"
p["startup"] := ">>>>>>>>>>>>>> Initial startup: ([0-9]+\.[0-9]+)s <<<<<<<<<<<<<<<"
p["map_load"] := "UGameEngine\:\:LoadMap entered - (\w+)"
p["matchstate_changed"] := "ScriptLog: GameLOG >> BeginState >> ChangedState\( (\w+) \)"

global log_dir := game_dir.combine("CombatGame", "Logs")
global log_file := log_dir.combineFile("Launch.log")
if (log_file.exists()) {
    #Include <logtail>
    global lt_log := new LogTailer(log_file.path, Func("OnNewLogLine"), false)
    ; lt := new LogTailer("test.log", Func("OnNewLine"))
    global had_error := false
}
global max_chat_chars := 100

global game_exe := game_dir.combineFile("binaries", "win64", w["game"].exe)
if (game_exe.exists())
    Menu, Tray, Icon, % game_exe.path
Menu, tray, add, ---BlackSquad---, void
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc
if (log_file.exists())
    Menu, tray, add, View Log, showLogFunc

; killGame()
; startLauncher()
return

restartGameFunc:
    killGame()
    ; clearLogs()
    startLauncher()
    return
    
killGameFunc:
    killGame()
    return

showLogFunc:
    Run, % "notepad " . log_file.path
    return
    
void:
    return

OnNewLogLine(FileLine) {
    if (!p)
        return
    if (RegExMatch(FileLine, p["log"], log)) {
        if (RegExMatch(log2, p["msg"], msg)) {
            if (RegExMatch(msg2, p["beguid"], beguid)) {
                scriptlog("BEGUID: " . beguid2, log1)
            } else if (RegExMatch(msg2, p["error"], error)) {
                OnError(error1)
            } else if (RegExMatch(log2, p["close"], close)) {
                OnExit(!had_error)
            } else if (RegExMatch(log2, p["ping"], ping)) {
                ; scriptlog(ping1 . " : " . ping2)
            } else if (RegExMatch(log2, p["map_load"], map_load)) {
                OnMapLoaded(map_load1)
                ; scriptlog("map_load " . map_load1, log1)
            }
        }
    } else {
        ; scriptlog("INVALID: " . FileLine)
    }
}

OnError(code) {
    had_error := true
    ; gosub restartGameFunc
}
OnExit(byUser) {
    SplashScreen("Initiated by User: " . toYesNo(byUser), ("Quit " . w.game.title), 5000)
}

OnMapLoaded(name) {
    SplashScreen(name, "New Map")
}

LineMatch(line, pattern, outVar) {
    if (!pattern) {
        MsgBox % "Missing Pattern " . pattern.name
        return false
    }
    return RegExMatch(line, pattern, outVar)
}

startLauncher() {
    winstr := w["launcher"].str()
    Run, % "steam://rungameid/550650" ;path . "binaries\" . launcher.exe
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
            ; ControlClick, x702 y558, % winstr
            ControlClick, % "MFCButton1", % winstr,,,, NA
            winstr := w["game"].str()
            WinWait, % winstr
            WinActivate, % winstr
            WinWaitActive, % winstr
            SplashScreen(w["game"].process.commandLine(), "Game started")
            return
        }
        sleep, 250
    }
}
    
clearLogs() {
    logs := log_dir.combineFile("*.log").path
    FileDelete, % logs
    ; Loop, % dir . "\*.*", 2
    ;     FileRemoveDir, %A_LoopFileLongPath%,1
}

killGame() {
    SplashScreen("", "Killing Processes", 500)
    for i, window in w {
        ; SplashScreen(window.process.name, "Killing Process")
        window.process.kill(true, true)
    }
}