#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
#Include <gta>
DetectHiddenWindows, On

#Include %A_AhkPath%\..\Lib\gta\modmenu-modest.ahk
SendMode, Input
;SendMode, Event|Play|Input|InputThenPlay
EnforceAdmin()

Menu, tray, add,
Menu, tray, add, ---GTA Online---, lbl
Menu, tray, add,
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Steam, restartSteamFunc
Menu, tray, add, Restart Game, restartGameFunc
Menu, tray, add, Kill ModMenu, killMenuFunc
Menu, tray, add, Restart ModMenu, restartMenuFunc
Menu, tray, add, 2 Take 1 Menu, takeMenuFunc
Menu, tray, add,
Menu, tray, add, Auto Mod Menu, toggleMenuTimer
; Menu, tray, add, Test, testFunc

global game := new Game("S:\Steam\steamapps\common\Grand Theft Auto V\")
global modmenu := new ModMenu("D:\Desktop\modest-menu\")
global modmenubin := new File("D:\Desktop\modest-menu\modest-menu.exe")
global dslep := 150

Menu, Tray, Icon, % game.exe.path

modmenu.getWindow(true)
modmenu.getControls()
global logfile := new File("gta modmenu texts.txt")
global steam := new Window("Steam", "vguiPopupWindow", "steam")


; SplashScreen("","Press F5 to start " . modmenu.name, 3000)
; log("Waiting for F5")
; KeyWait, F5, D
; Menu, tray, Check, Auto Mod Menu
; SetTimer, CheckWindows, 1000
return

log(msg) {
    ; scriptlog(msg)
}

CheckWindows() {
    global modmenubin
    log(game.windows.game.str() . " exists: " . game.windows.game.exists())
    if (game.windows.game.exists()) {
        log(modmenu.window.process.str() . " exists: " . modmenu.window.process.exists())
        if (!modmenu.window.process.exists()) {
            SetTimer, CheckWindows, Off
            modmenubin.run()
            WinWait, % modmenu.window.str()
            modmenu.window := modmenu.getWindow(true)
            SplashScreen("Started " . modmenu.name)
            SetTimer, CheckWindows, 5000
        } else {
            c := modmenu.getControls()
            ; SplashScreen(game.modmenu.name . " detected")
        }
    }
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
        scriptlog("before reset")
        modmenu.resetPage()
        scriptlog("after reset, before row")
        modmenu.waitForRow(10)
        scriptlog("after row, before page")
        modmenu.waitForPage("Online Vehicle Spawn", true)
        scriptlog("after page")
    }
    if (!InStr(modmenu.getControls()[6].text, "Helicopter", true)) {
        modmenu.waitForRow(4)
        while(!InStr(modmenu.getControls()[6].text, "Helicopter", true)) {
            ; scriptlog("waiting for class Helicopter. current: " . modmenu.getControls()[6].text)
            modmenu.navigate("{Left}")
            Sleep, % dslep
        }
    }
    if (!InStr(modmenu.getControls()[7].text, "Police Maverick", true)) {
        modmenu.waitForRow(5)
        while(!InStr(modmenu.getControls()[7].text, "Police Maverick", true)) {
            ; scriptlog("waiting for model Police Maverick. current: " . modmenu.getControls()[7].text)
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
global timer := true
toggleMenuTimer() {
    if (timer) {
        SetTimer, CheckWindows, 2500
        Menu, tray, Uncheck, Auto Mod Menu
    } else {
        SetTimer, CheckWindows, Off
        Menu, tray, Check, Auto Mod Menu
    }
    timer := !timer
}

restartSteamFunc() {
    game.kill()
    KillProcesses(["steam"])
    ShellRun("""C:\Program Files (x86)\Steam\Steam.exe""", "-no-browser +open steam://rungameid/" . game.appid)
    ; WinWait, % steam.str()
}

killMenuFunc() {
    modmenu.kill()
}

restartMenuFunc() {
    killMenuFunc()
    modmenubin.run()
}

takeMenuFunc() {
    game.kill()
    ; Run, Target , WorkingDir, Options, OutputVarPID
    Run, D:\Desktop\2Take1Menu\Launcher.exe, D:\Desktop\2Take1Menu, Min, takeMenuPID
    game.start("-StraightIntoFreemode")
}

restartGameFunc() {
    game.kill()
    game.start("-StraightIntoFreemode")
}
    
killGameFunc() {
    game.kill()
}

lbl() {
    pasteToNotepad(toJson(game, true))
}

testFunc() {
    pasteToNotepad(toJson(modmenu, true))
}