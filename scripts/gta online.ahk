#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir % A_ScriptDir
#Include <bluscream>
EnforceAdmin(A_Args)
global no_ui := false
log(A_ScriptFullPath . " " .  Join(" ", A_Args))

SendMode, Input ; Event|Play|Input|InputThenPlay
DetectHiddenWindows, On
CoordMode, Mouse, Client

#Include <games/gta v>
global game := new GTAVGame("S:\Steam\steamapps\common\Grand Theft Auto V")
global modmenus := []
#Include <gta/modmenus>
init()
for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/2t1m") {
        toggleMenu("2Take1Menu", 0, "")
    } else if (param == "/modest") {
        toggleMenu("Modest Menu", 0, "")
    }
}
log("> " . CloseScript("togglehold.ahk"))

; SetTimer, CheckWindows, 20000

toggleMenu("2Take1Menu", 0, "")

; SplashScreen("","Press F5 to start " . modmenu.name, 3000)
; log("Waiting for F5")
; KeyWait, F5, D
; Menu, tray, Check, Auto Mod Menu

; while (True) {
;     WinWaitActive, Grand Theft Auto V ahk_class grcWindow ahk_exe GTA5.exe
;     if (modmenu.getWindow()) {
;         log("is running as " . modmenu.getWindow())
;     } else {
;         log("not running")
;     }
;     SleepS(5)
; }

return

; TIMERS START
CheckWindows:
    if (!game.windows.game.exists()){
        log("Game window not found, starting")
        getActiveModMenu().restart()
        game.start()
    }
    return
; TIMERS END

; HOTKEYS START
; #IfWinActive, ahk_exe GTA5.exe
F5::injectMenuFunc()
3Joy14:: ; LB
    if GetKeyState("3Joy15") and GetKeyState("3Joy7") { ; RB LS RS
        injectMenuFunc()
    }
    Return
; #IfWinNotActive, ahk_exe GTA5.exe
; F5::showGameFunc()
; #IfWinNotExist, ahk_exe GTA5.exe
; F5::startGameFunc()
; HOTKEYS END

getActiveModMenu() {
    for i, menu in modmenus {
        if menu.enabled {
            return menu
        }
    }
}

init() {
    ; Menu, Tray, NoStandard
    Menu, GameMenu, add, Kill , killGameFunc
    Menu, GameMenu, add, Restart, restartGameFunc
    Menu, GameMenu, add, Start, startGameFunc
    Menu, GameMenu, add, Hide, hideGameFunc
    Menu, GameMenu, add, Show, showGameFunc
    Menu, tray, add,
    Menu, tray, add, ---GTA Online---, lbl
    Menu, tray, add,
    Menu, tray, add, Restart Steam, restartSteamFunc
    Menu, Tray, Add, % game.name, :GameMenu

    Menu, tray, add, Restart ModMenu, restartMenuFunc
    Menu, tray, add,

    for i, menu in modmenus {
        log(menu.str())
        Menu, tray, add, % menu.name, toggleMenu
    }
    Menu, Tray, Icon, % game.exe.path

    global logfile := new File("gta modmenu texts.txt")
}

toggleMenu(ItemName, ItemPos, MenuName) {
    for i, menu in modmenus {
        if (menu.name == ItemName) {
            if (menu.enabled) {
                Menu, tray, Uncheck, % menu.name
                menu.enabled := False
            } else {
                Menu, tray, Check, % menu.name
                menu.enabled := True
                menu.autoStart()
            }
        } else {
            Menu, tray, Uncheck, % menu.name
            menu.enabled := False
        }
    }
}

log(msg) {
    scriptlog(msg)
}

restartSteamFunc() {
    game.steam.restart()
}

killMenuFunc() {
    getActiveModMenu().kill()
}

restartMenuFunc() {
    getActiveModMenu().restart()
}

injectMenuFunc() {
    activeMenu := getActiveModMenu()
    ; scriptlog(activeMenu.name . "injected: " . toJson(activeMenu.injected))
    game_running := game.windows.game.exists()
    menu_running := activeMenu.window.exists()
    if (game_running and menu_running and !activeMenu.injected) {
        txt := "Injecting " . activeMenu.name
        log(txt)
        SplashScreen("", txt, 500)
        activeMenu.inject()
    } else if (game_running and menu_running) {
        game.maximize()
    } else if (game_running) {
        showGameFunc()
    } else {
        startGameFunc()
    }
}

hideGameFunc() {
    game.minimize()
}

showGameFunc() {
    game.activate(False)
}

startGameFunc() {
    game.start()
}

restartGameFunc() {
    game.restart()
    ; SleepS(5)
    ; getActiveModMenu().autoStart()
}
    
killGameFunc() {
    game.kill()
}

lbl() {
    pasteToNotepad(toJson([game,modmenus], true))
}


/*
F4:: ; Startup Stuffs
    return
    SplashScreen("", "Startup stuff")
    modmenu.resetPage()
    modmenu.resetPosition()
    return
F5:: ; Save Menu to file
    return
    SplashScreen("", "Saving menu text to " . logfile.fullname)
    c := modmenu.getControls()
    for i,e in c {
        logfile.appendLine(e.id . " > " . e.text)
    }
    logfile.appendLine("")
    return
F6:: ; Join Public Lobby
    SplashScreen("", "Joining public lobby")
    modmenu.resetPage()
    modmenu.resetPosition()
    modmenu.waitForPage("Game", true)
    modmenu.waitForRow(4)
    modmenu.waitForEnum(4, "Join Public")
    modmenu.navigate("{Enter}")
    SplashScreen("", "Joined public lobby")
    return
F7:: ; Rig Slot Machines
    SplashScreen("", "Rigging Slot Machines")
    modmenu.resetPage()
    modmenu.waitForRow(9)
    modmenu.waitForPage("Online Services", true)
    modmenu.waitForRow(2)
    modmenu.waitForEnum(2, "Rig Slot Machines", "{Enter}")
    while(!InStr(modmenu.getControls()[4].text, "", true)) {
        modmenu.navigate()
        Sleep, % dslep
        modmenu.getControls()
    }
    modmenu.waitForRow(2)
    modmenu.navigate("{Enter}")
    modmenu.waitForRow(3)
    modmenu.navigate("{Enter}")
    SplashScreen("", "Rigged Slot Machines")
    return
F8:: ; Spawn Polmav
    SplashScreen("", "Spawning Police Maverick")
    if(game.modmenu.page != "Online Vehicle Spawn") {
        log("before reset")
        modmenu.resetPage()
        log("after reset, before row")
        modmenu.waitForRow(10)
        log("after row, before page")
        modmenu.waitForPage("Online Vehicle Spawn", true)
        log("after page")
    }
    if (!InStr(modmenu.getControls()[6].text, "Helicopter", true)) {
        modmenu.waitForRow(4)
        while(!InStr(modmenu.getControls()[6].text, "Helicopter", true)) {
            ; log("waiting for class Helicopter. current: " . modmenu.getControls()[6].text)
            modmenu.navigate("{Left}")
            Sleep, % dslep
        }
    }
    if (!InStr(modmenu.getControls()[7].text, "Police Maverick", true)) {
        modmenu.waitForRow(5)
        while(!InStr(modmenu.getControls()[7].text, "Police Maverick", true)) {
            ; log("waiting for model Police Maverick. current: " . modmenu.getControls()[7].text)
            modmenu.navigate("{Right}")
            Sleep, % dslep
        }
    }
    modmenu.waitForRow(30)
    modmenu.navigate("{Enter}")
    SplashScreen("Press F10 to give it godmode", "Spawned Police Maverick")
    return
F10:: ; Vehicle Godmode
    if(game.modmenu.page != "Vehicle") {
        modmenu.resetPage()
        modmenu.waitForRow(3)
        modmenu.waitForPage("Vehicle", true)
    }
    modmenu.waitForRow(5)
    modmenu.navigate("{Enter}")
    SplashScreen("", "Gave current vehicle Godmode")
    return
F11:: ; Restart Script
    RestartScript()
    return
*/