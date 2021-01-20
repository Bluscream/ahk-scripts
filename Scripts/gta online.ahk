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
global modmenu := new ModMenu("C:\Users\Shadow\Desktop\modest-menu_v0.8.10\")
global dslep := 150

Menu, Tray, Icon, % game.exe.path
Menu, tray, add, ---GTA Online---, lbl
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc
Menu, tray, add, Test, testFunc

SetTimer, CheckWindows, 1000
modmenu.getWindow(true)
modmenu.getControls()
global logfile := new File("gta modmenu texts.txt")
return

F5:: ; Save Menu to file
    return
    c := modmenu.getControls()
    for i,e in c {
        logfile.appendLine(e.id . " > " . e.text)
    }
    logfile.appendLine("")
    return
F6:: ; Join Public Lobby
    modmenu.resetPage()
    modmenu.resetPosition()
    modmenu.waitForPage("Game", true)
    modmenu.waitForRow(4)
    while(!InStr(modmenu.getControls()[6].text, "Join Public", true)) {
        modmenu.navigate("{Right}")
        Sleep, % dslep
        modmenu.getControls()
    }
    modmenu.navigate("{Enter}")
    return
F7:: ; Rig Slot Machines
    modmenu.resetPage()
    modmenu.waitForRow(9)
    modmenu.waitForPage("Online Services", true)
    modmenu.waitForRow(2)
    while(!InStr(modmenu.getControls()[4].text, "Rig Slot Machines", true)) {
        modmenu.navigate("{Enter}")
        Sleep, % dslep
        modmenu.getControls()
    }
    modmenu.waitForRow(2)
    modmenu.navigate("{Enter}")
    modmenu.waitForRow(3)
    modmenu.navigate("{Enter}")
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
F11:: ; Pause Script
    pause
    return

CheckWindows:
    if (game.windows.game.exists()) {
        if (!modmenu.window.process.exists()) {
            new File("C:\Users\Shadow\Desktop\modest-menu_v0.8.10\modest-menu.exe").run()
            WinWait, % modmenu.window.str()
            modmenu.window := modmenu.getWindow(true)
            SplashScreen("Started " . modmenu.name)
        } else {
            c := modmenu.getControls()
            ; SplashScreen(game.modmenu.name . " detected")
        }
    }
    return

restartGameFunc:
    game.kill()
    game.start()
    return
    
killGameFunc:
    game.kill()
    return

lbl:
    pasteToNotepad(toJson(game, true))
    return

testFunc:
    pasteToNotepad(toJson(modmenu, true))
    return

testFunc2:
    c := modmenu.getControls()
    for i,e in c {
        scriptlog(e.id . " > " . e.text)
    }
    return