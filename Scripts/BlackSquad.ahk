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
Menu, tray, add, ---BlackSquad---, lbl
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
                MsgBox % "error"
                OnError(error1)
                game.had_error := true
            } else if (RegExMatch(log2, game.patterns["close"], close)) {
                OnExit(!game.had_error)
                game.had_error := false
            } else if (RegExMatch(log2, game.patterns["ping"], ping)) {
                OnPing(ping1, ping2)
                game.lastping := ping1
            } else if (RegExMatch(log2, game.patterns["map_load"], map_load)) {
                OnMapLoaded(map_load1)
                game.lastmap := name
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

OnPing(ping1, ping2) {
    MsgBox % ping1
}
OnMapLoaded(name) {
    SplashScreen(name, "New Map")
}
OnExit(byUser) {
    SplashScreen("Initiated by User: " . toYesNo(byUser), ("Quit " . game.name), 5000)
}
OnError(args*) {
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
    } else {
        Run, % "notepad " . game.logfile.quote()
    }
    return