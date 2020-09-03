#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
#Include <blacksquad>
EnforceAdmin()
global game := new Game("S:\Steam\steamapps\common\Black Squad\")
Menu, Tray, Icon, % game.exe.path
Menu, tray, add, ---BlackSquad---, lbl
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc

OnPing(ping1, ping2) {
    MsgBox % ping1
}

OnLogLine(msg) {
    MsgBox % msg
}

OnLogEvent(event, params*) {
    if (event == "map_loaded") {
        SplashScreen(params[1], "New Map")
    } else if (event == "exit") {
        SplashScreen("Initiated by User: " . toYesNo(byUser), ("Quit " . game.windows["game"].title), 5000)
    }
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