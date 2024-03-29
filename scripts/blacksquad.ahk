﻿#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
#Include <blacksquad>
EnforceAdmin()
global noui := false
gamepath := new Directory("G:\Steam\steamapps\common\Black Squad\")
if (!gamepath.exists()) {
    InputBox, UserInput, % "Black Squad not found", % "Enter black Squad Game Path", , 640, 480
    if ErrorLevel
        ExitApp
    else
        gamepath := new Directory(UserInput)
}
global game := new Game(gamepath.path)
; pasteToNotepad(toJson(game, true))
if (game.logfile.exists() && game.patterns && game.patterns.Count() > 0) {
    ; log := new LogTailer(game.logfile.path, Func("OnNewLogLine"), true, "CP28591", "`n")
    ; log := StdOutStream("tail " . Quote(game.logfile.path), "OnNewLogLine" ) 
    ; scriptlog("subscribed to log file " . Quote(game.logfile.path) . " (" . log . ")")
}
Menu, tray, add, Teamspeak, tsFunc
Menu, tray, add, ---Automation---, lbl
Menu, tray, add, Old Box 2, BuyOldBox2
Menu, tray, add, Medal Rotation Box, BuyMedalRotationBox
Menu, tray, add, Unbox Inventory, Unbox
Menu, tray, add, ---Black Squad---, lbl
Menu, tray, add, Kill, killGameFunc
Menu, tray, add, Restart, restartGameFunc
Menu, tray, add, Restart Loop, restartGameLoop
if game.dir.exists() {
    Menu, Tray, Icon, % game.exe.path
}
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
global loopcount := 0

for n, param in A_Args  ; For each parameter:
{
    StringLower, param, param
    if (param == "/start") {
        gosub restartGameFunc
    }
}

return

Hotkey, IfWinActive, % game.windows.game.str()
^Backspace::
    lk := "".join(bs_lastkeys) ; Format("{:T}", )
    Send {Raw}%lk%
    return

F3::
    SetTimer, Trololol, % (Toggle:=!Toggle) ? 1000 : "Off"
    return
Hotkey, IfWinActive


BuyOldBox2:
    MsgBox 0x23, % "BuyOldBox2", % "Are you already on the SHOP screen?"
    _no := false
    IfMsgBox Yes, {
    } Else IfMsgBox No, {
        _no := true
    } Else IfMsgBox Cancel, {
        return
    }
    MsgBox 0x30, % "WARNING", % "Remember that you need to press the [END] key on your keyboard to finish/cancel the loop!"
    game.windows["game"].activate(true)
    Sleep, 2500
    if (_no) {
        game.coords.menu.main.buttons.shop.click()
        Sleep, 500
    }
    game.coords.menu.shop.filters.item.click()
    Sleep, 500
    game.coords.menu.shop.sub_filters.item.click()
    loopcount := 0
    SetTimer, BuyOldBox2Loop, 500
    scriptlog("BuyOldBox2Loop started. Hold [END] key for 20 seconds to finish/abort!")
    return
BuyOldBox2Loop:
    if (loopcount > 5000 or GetKeyState("END", "P")) {
        SetTimer, BuyOldBox2Loop, Off
        scriptlog("Cancelled BuyOldBox2Loop after " . loopcount . " iterations")
        SoundBeep
    }
    game.coords.menu.shop.item.item.oldbox2.click()
    Sleep, 250
    game.coords.menu.shop.item.item.oldbox2.click()
    Sleep, 250
    game.coords.menu.shop.confirm_purchase.purchase_inbox.click()
    Sleep, 950
    loopcount := loopcount + 1
    return

BuyMedalRotationBox:
    return

Unbox:
    MsgBox 0x23, % "BuyOldBox2", % "Are you already on the INBOX screen?"
    _no := false
    IfMsgBox Yes, {
    } Else IfMsgBox No, {
        _no := true
    } Else IfMsgBox Cancel, {
        return
    }
    MsgBox 0x30, % "WARNING", % "Remember that you need to press the [END] key on your keyboard to finish/cancel the loop!"
    game.windows["game"].activate(true)
    Sleep, 2500
    if (_no) {
        scriptlog(game.coords.menu.main.buttons.inbox.str())
        game.coords.menu.main.buttons.inbox.click()
        Sleep, 500
    }
    loopcount := 0
    SetTimer, UnboxLoop, 500
    scriptlog("UnboxLoop started. Hold [END] key for 20 seconds to finish/abort!")
    return
UnboxLoop:
    if (loopcount > 5000 or GetKeyState("END", "P")) {
        SetTimer, UnboxLoop, Off
        scriptlog("Cancelled UnboxLoop after " . loopcount . " iterations")
        SoundBeep
    }
    game.coords.menu.inbox.recieve_all.click()
    Sleep, 500
    game.coords.menu.inbox.confirm.click()
    Sleep, 500
    game.coords.menu.inbox.open.click()
    Sleep, 500
    game.coords.menu.inbox.yes.click()
    Sleep, 7000
    game.coords.menu.crate.swipe_left.swipeToCoord(game.coords.menu.crate.swipe_right)
    Sleep, 150
    game.coords.menu.crate.close.click()
    Sleep, 500
    loopcount := loopcount + 1
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
    ; Run % """C:\Program Files (x86)\Overwolf\OverwolfLauncher.exe"" -launchapp dfkolmeleijfgnbeaodgfcmmhldddhahdcfmldcg" ; -from-desktop
    game.start(true) ; -USEBATTLEYE -GATEWAYIP=gateway.blacksquad.com -PUB=STEAM -LANGFORTEXT=INT 
    return

restartGameLoop:
    winstr := game.windows["game"].str()
    while(true) {
        if (GetKeyState("END", "P")) {
            return
        }
        ; WinWaitClose , WinTitle, WinText, Timeout, ExcludeTitle, ExcludeText
        gosub restartGameFunc
        game.windows["game"].activate(true)
        WinWaitActive , WinTitle, WinText, Timeout, ExcludeTitle, ExcludeText
        SleepS(5)
    }
    return
    
killGameFunc:
    SplashScreen("", "Killing " . this.windows.Count() . " Processes", 500)
    game.kill()
    return

tsFunc:
    window := new Window("TeamSpeak 3", "Qt5QWindowIcon", "ts3client_win64.exe")
    binary := new File("C:\Program Files\TeamSpeak 3 Client\ts3client_win64.exe")
    servers := []
    servers.Push("ts3server://Ufta-gaming.teamspeak.me?password=Baumhaus&channel=~%20AFK%20~")
    servers.Push("ts3server://wwb?password=1012&channel=Anderer%20Teamspeak")
    ; servers.Push("ts3server://pflegef%C3%A4lle?password=gold1234&channel=%5Bcspacer4%5D%20%E2%96%81%20%E2%96%82%20%E2%96%83%20AFK-Lounge%20%E2%96%83%20%E2%96%82%20_%2F%E2%95%A0%E2%95%90%E2%96%BA%20Lang%20%28%3E%2030%20Min%29")
    servers.Push("ts3server://tsw?password=tsw2018&channel=%5Bcspacer0%5D%E2%80%A2%E2%97%8F%E2%97%8F%20Away%20from%20Keybord%20%E2%97%8F%E2%97%8F%E2%80%A2%2FL%C3%A4nger%20AFK%20%28%3E%2010%20Min.%29")
    ; servers.Push("ts3server://ts3-voice.de?port=9048&password=gold1234&channel=%5Blspacer%5DAnderer%20Ts3")
    servers.Push("ts3server://173.212.248.123?channel=%5B%E2%99%A6cspacer%5D%E2%95%9A%E2%95%90%E2%95%90%E2%95%90%E2%AB%B8%20%20Lang%20Weg%20%E2%9C%88")
    ; servers.Push("ts3server://ts3.destroyerclangermany.de?port=9170&channel=%5BlspacerM3%5D%E2%95%94%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%96%8C%20%20%20AFK%20%20%E2%96%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%97")
    if (!window.exists()) {
        binary.run()
        WinWait, % window.str()
    }
    if (!window.isActive()) {
        window.activate(true)
    }
    sleep, 500
    for i, v in servers {
        sleep, 5000
        scriptlog(v)
        Run, % v
    }
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