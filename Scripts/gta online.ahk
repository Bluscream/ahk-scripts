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
; EnforceAdmin()

global game := new Game("S:\Steam\steamapps\common\Grand Theft Auto V\")
global modmenu := new ModMenu("C:\Users\Shadow\Desktop\modest-menu\")
global dslep := 150

Menu, Tray, Icon, % game.exe.path
Menu, tray, add, ---GTA Online---, lbl
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc
Menu, tray, add, Restart ModMenu, restartMenuFunc
Menu, tray, add, Test, testFunc

SetTimer, CheckWindows, 1000
modmenu.getWindow(true)
modmenu.getControls()
global logfile := new File("gta modmenu texts.txt")
return

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

CheckWindows() {
    if (game.windows.game.exists()) {
        if (!modmenu.window.process.exists()) {
            new File("C:\Users\Shadow\Desktop\modest-menu\modest-menu.exe").run()
            WinWait, % modmenu.window.str()
            modmenu.window := modmenu.getWindow(true)
            SplashScreen("Started " . modmenu.name)
        } else {
            c := modmenu.getControls()
            ; SplashScreen(game.modmenu.name . " detected")
        }
    }
}

restartMenuFunc() {
    modmenu.window.Close()
    modmenu.window.Kill()
    new File("C:\Users\Shadow\Desktop\modest-menu\modest-menu.exe").run()
}

restartGameFunc() {
    game.kill()
    game.start()
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