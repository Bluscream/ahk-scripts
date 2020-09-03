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
#Include <blacksquad>
global game := new Game("S:\Steam\steamapps\common\Black Squad\", Func("OnLogEvent"))
MsgBox % "test"

if (game.exe.exists())
    Menu, Tray, Icon, % game.exe.path
Menu, tray, add, ---BlackSquad---, void
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc
if (game.logfile.exists())
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
    Run, % "notepad " . game.logfile.path
    return
    
void:
    return

OnLogEvent(event, params*) {
    if (event == "map_loaded") {
        SplashScreen(params[1], "New Map")
    } else if (event == "exit") {
        SplashScreen("Initiated by User: " . toYesNo(byUser), ("Quit " . game.windows["game"].title), 5000)
    }
}

startLauncher() {
    winstr := game.windows["launcher"].str()
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
            winstr := game.windows["game"].str()
            WinWait, % winstr
            WinActivate, % winstr
            WinWaitActive, % winstr
            SplashScreen(game.windows["game"].process.commandLine(), "Game started")
            return
        }
        sleep, 250
    }
}
    
clearLogs() {
    logs := game.logdir.combineFile("*.log").path
    FileDelete, % logs
    ; Loop, % dir . "\*.*", 2
    ;     FileRemoveDir, %A_LoopFileLongPath%,1
}

killGame() {
    SplashScreen("", "Killing Processes", 500)
    for i, window in game.windows {
        ; SplashScreen(window.process.name, "Killing Process")
        window.process.kill(true, true)
    }
}