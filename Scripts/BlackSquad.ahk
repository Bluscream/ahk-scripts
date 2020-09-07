#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
#Include <blacksquad>
EnforceAdmin()
global game := new Game("S:\Steam\steamapps\common\Black Squad\")
; pasteToNotepad(toJson(game, true))
log := new LogTailer(game.logfile.path, Func("OnNewLogLine"), true)
Menu, Tray, Icon, % game.exe.path
Menu, tray, add, ---Black Squad---, lbl
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc
OnNewLogLine(FileLine) {
    if (!game.patterns)
        return
    ; Func("OnLogLine").call(FileLine)
    if (RegExMatch(FileLine, game.patterns["log"], log)) {
        if (RegExMatch(log2, game.patterns["msg"], msg)) {
            if (RegExMatch(msg2, game.patterns["beguid"], beguid)) {
                Func("OnBattleyeGuid").call(beguid1)
                scriptlog("BEGUID: " . beguid2, log1)
            } else if (RegExMatch(msg2, game.patterns["error"], error)) {
                MsgBox % "error" . error1
                OnError(error1)
                game.had_error := true
            } else if (RegExMatch(log2, game.patterns["close"], close)) {
                OnExit(!game.had_error)
                game.had_error := false
            } else if (RegExMatch(log2, game.patterns["ping"], ping)) {
                OnPing(ping1, ping2)
                game.data.ping := ping1
            } else if (RegExMatch(log2, game.patterns["mapload"], map_load)) {
                OnMapLoaded(map_load3)
                scriptlog(FileLine)
                game.data.server.ip := map_load1
                game.data.server.port := map_load2
                game.data.map := Format("{:L}", map_load3)
                game.data.player.security_code := map_load4
                game.data.player.userid := map_load5
            } else if (RegExMatch(log2, game.patterns["mapload2"], map_load)) {
                OnMapLoaded(map_load1)
                game.data.map := Format("{:L}", map_load1)
            } else if (RegExMatch(log2, game.patterns["mapload3"], map_load)) {
                game.data.map := Format("{:L}", map_load1)
            } else if (RegExMatch(log2, game.patterns["mapload4"], map_load)) {
                game.data.map := Format("{:L}", map_load1)
            } else if (RegExMatch(log2, game.patterns["server_browse"], server_browse)) {
                game.data.server.ip := server_browse1
                game.data.server.port := server_browse2
            } else if (RegExMatch(log2, game.patterns["gameresult"], gameresult)) {
                OnGameResult()
            } else if (RegExMatch(log2, game.patterns["level_load_completed"], level_load_completed)) {
                OnPendingLevelCompleted(level_load_completed1)
            } else if (RegExMatch(log2, game.patterns["failed_connect"], failed_connect)) {
                MsgBox % "failed_connect"
                OnError(failed_connect1, failed_connect2, failed_connect3)
                game.had_error := true
            }
        }
    } else {
        ; scriptlog("INVALID: " . FileLine)
    }
}
OnGameResult() {
    scriptlog("OnGameResult")
}
OnPendingLevelCompleted(error) {
    scriptlog("OnPendingLevelCompleted: " . error)
}
OnPing(ping, result) {
    scriptlog(Format("OnPing: {}ms. Result: {}", ping, result))
    ; ToolTip, % ping, 0, 0
}
OnMapLoaded(name) {
    scriptlog(Format("OnMapLoaded: {} (Old: {})", name, game.data.map))
    SplashScreen(name, "New Map")
}
OnExit(byUser) {
    scriptlog(Format("OnExit: (By user: {})", toYesNo(byUser)))
    SplashScreen(Format("Initiated by User: {}", toYesNo(byUser)), ("Quit " . game.name), 5000)
}
OnError(args*) {
    scriptlog(format("ERROR: {}", " ".join(args)))
    SplashScreen("ERROR", " ".join(args), 15000)
    game.windows["game"].minimize()
}

return

restartGameFunc:
    game.kill()
    ; clearLogs()
    game.start()
    return
    
killGameFunc:
    SplashScreen("", "Killing " . this.windows.Count() . " Processes", 500)
    game.kill()
    return
    
lbl:
    if (GetKeyState("Shift", "P")) {
        game.logdir.ShowInFileExplorer()
    } else if (GetKeyState("Ctrl", "P")) {
        game.clearLogs()
    } else if (GetKeyState("I", "P")) {
        pasteToNotepad(toJson(game, true))
    } else {
        Run, % "notepad " . game.logfile.quote()
    }
    return