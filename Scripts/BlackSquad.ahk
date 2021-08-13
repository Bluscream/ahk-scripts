#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
#Include <blacksquad>
EnforceAdmin()
global noui := false
global game := new Game("G:\Steam\steamapps\common\Black Squad\")
; pasteToNotepad(toJson(game, true))
if (false && game.logfile.exists() && game.patterns && game.patterns.Count() > 0) {
    ; log := new LogTailer(game.logfile.path, Func("OnNewLogLine"), true, "CP28591", "`n")
    result := StdOutStream("tail " . Quote(game.logfile.path), "OnNewLogLine" ) 
    scriptlog("subscribed to log file " . Quote(game.logfile.path) . " (" . result . ")")
}
Menu, Tray, Icon, % game.exe.path
Menu, tray, add, ---Black Squad---, lbl
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc
OnNewLogLine(FileLine, n) {
    scriptlog("OnNewLogLine")
    if (!FileLine)
        return
    ; Func("OnLogLine").call(FileLine)
    if (RegExMatch(FileLine, game.patterns["log"], log)) {
        if (RegExMatch(log2, game.patterns["msg"], msg)) {
            if (RegExMatch(msg1, game.patterns["beguid"], beguid)) {
                OnBattleyeGuid(beguid1)
            } else if (RegExMatch(msg1, game.patterns["error"], error)) {
                MsgBox % "error" . error1
                OnError(error1)
                game.had_error := true
            } else if (RegExMatch(msg1, game.patterns["close"], close)) {
                OnExit(!game.had_error)
                game.had_error := false
            } else if (RegExMatch(msg1, game.patterns["ping"], ping)) {
                OnPing(ping1, ping2)
                game.updateData("ping", ping1)
            } else if (RegExMatch(msg1, game.patterns["mapload"], map_load)) {
                OnMapLoaded(map_load3)
                game.updateData("server.ip", map_load1)
                game.updateData("server.port", map_load2)
                game.updateData("map", Format("{:L}", map_load3))
                game.updateData("player.security_code", map_load4)
                game.updateData("player.userid", map_load5)
            } else if (RegExMatch(msg1, game.patterns["mapload2"], map_load)) {
                OnMapLoaded(map_load1)
                game.updateData("map", Format("{:L}", map_load1))
            } else if (RegExMatch(msg1, game.patterns["mapload3"], map_load)) {
                game.updateData("map", Format("{:L}", map_load1))
            } else if (RegExMatch(msg1, game.patterns["mapload4"], map_load)) {
                game.updateData("map", Format("{:L}", map_load1))
            } else if (RegExMatch(msg1, game.patterns["server_browse"], server_browse)) {
                game.updateData("server.ip", server_browse1)
                game.updateData("server.port", server_browse2)
            } else if (RegExMatch(msg1, game.patterns["gameresult"], gameresult)) {
                OnGameResult()
            } else if (RegExMatch(msg1, game.patterns["level_load_completed"], level_load_completed)) {
                OnPendingLevelCompleted(level_load_completed1)
            } else if (RegExMatch(msg1, game.patterns["failed_connect"], failed_connect)) {
                MsgBox % "failed_connect"
                OnError(failed_connect1, failed_connect2, failed_connect3)
                game.had_error := true
            }
        }
    } else {
        scriptlog("INVALID: " . FileLine)
    }
}
OnBattleyeGuid(guid) {
    scriptlog("OnBattleyeGuid: " . guid)
}
OnGameResult() {
    scriptlog("OnGameResult")
}
OnPendingLevelCompleted(error) {
    scriptlog("OnPendingLevelCompleted: " . error)
}
OnPing(ping, result) {
    ; scriptlog(Format("OnPing: {}ms. Result: {}", ping, result))
    ; ToolTip, % ping, 0, 0
}
global oldmap := ""
OnMapLoaded(name) {
    scriptlog(Format("OnMapLoaded: {} (Old: {})", name, oldmap))
    oldmap := name
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

global bs_lastkeys := []
#IfWinActive, ahk_class LaunchCombatUWindowsClient ahk_exe BlackSquadGame.exe
#Include <keylogger>
OnKeyStroke(key) {
    if (!key)
        return
    count := bs_lastkeys.Count()
    if (key == "{Enter}" || count > game.max_chat_chars) {
        bs_lastkeys := []
    } else if (key == "{BackSpace}") {
        if (count > 0)
            bs_lastkeys.Pop()
    } else {
        bs_lastkeys.Push(key)
        SetTimer, clearStrokes, 60000
    }
    ; scriptlog("bs_lastkeys: " . toJson(bs_lastkeys))
}

return

Hotkey, IfWinActive, % game.windows.game.str()
^Backspace::
    lk := "".join(bs_lastkeys) ; Format("{:T}", )
    Send {Raw}%lk%
    return
Hotkey, IfWinActive

F3::
    SetTimer, Trololol, % (Toggle:=!Toggle) ? 1000 : "Off"
    return
F1::
    ; game.coords.menu.main.buttons.shop.click()
    game.coords.menu.shop.filters.item.click()
    Sleep, 500
    game.coords.menu.shop.sub_filters.item.click()
    SetTimer, BuyOldBox2Loop, 500
    return
F2::
    ; game.coords.menu.main.buttons.inbox.click()
    SetTimer, UnboxLoop, 500
    return

BuyOldBox2Loop:
    if (GetKeyState("END", "P"))
        ExitApp
    game.coords.menu.shop.item.item.oldbox2.click()
    Sleep, 250
    game.coords.menu.shop.item.item.oldbox2.click()
    Sleep, 250
    game.coords.menu.shop.confirm_purchase.purchase_inbox.click()
    Sleep, 950
    return

UnboxLoop:
    if (GetKeyState("END", "P"))
        ExitApp
    game.coords.menu.inbox.recieve_all.click()
    Sleep, 500
    game.coords.menu.inbox.confirm.click()
    Sleep, 500
    game.coords.menu.inbox.open.click()
    Sleep, 500
    game.coords.menu.inbox.yes.click()
    Sleep, 7400
    game.coords.menu.crate.swipe_left.swipeToCoord(game.coords.menu.crate.swipe_right)
    Sleep, 150
    game.coords.menu.crate.close.click()
    Sleep, 500
    return


Trololol:
    Send, {F5}
    Sleep, 500
    Send, {F6}
    return

clearStrokes:
    SetTimer, clearStrokes, Off
    bs_lastkeys := []
    return

restartGameFunc:
    game.kill()
    game.clearLogs()
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