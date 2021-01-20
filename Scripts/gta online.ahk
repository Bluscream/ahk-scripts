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
global dslep := 100

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

F5::
    return
    c := modmenu.getControls()
    for i,e in c {
        logfile.appendLine(e.id . " > " . e.text)
    }
    logfile.appendLine("")
    return
F7::
    modmenu.getControls()
    if (game.modmenu.page != "Main Menu") {
        modmenu.resetPage()
    }
    while(game.modmenu.row != 9) {
        modmenu.navigate("{Up}")
        Sleep, % dslep
        modmenu.getControls()
    }
    while(game.modmenu.page != "Online Services") {
        modmenu.navigate("{Enter}")
        Sleep, % dslep
        modmenu.getControls()
    }
    while(game.modmenu.row != 2) {
        modmenu.navigate("{Down}")
        Sleep, % dslep
        modmenu.getControls()
    }
    while(!InStr(modmenu.getControls()[4].text, "Rig Slot Machines", true)) {
        modmenu.navigate("{Enter}")
        Sleep, % dslep
        modmenu.getControls()
    }
    while(game.modmenu.row != 2) {
        modmenu.navigate("{Down}")
        Sleep, % dslep
        modmenu.getControls()
    }
    modmenu.navigate("{Enter}")
    while(game.modmenu.row != 3) {
        modmenu.navigate("{Down}")
        Sleep, % dslep
        modmenu.getControls()
    }
    modmenu.navigate("{Enter}")
    return
F8::
    SplashScreen("", "Spawning Police Maverick")
    modmenu.getControls()
    if(game.modmenu.page != "Online Vehicle Spawn") {
        if (game.modmenu.page != "Main Menu") {
            modmenu.resetPage()
        }
        while(game.modmenu.row != 10) {
            modmenu.navigate("{Up}")
            Sleep, % dslep
            modmenu.getControls()
        }
        while(game.modmenu.page != "Online Vehicle Spawn") {
            modmenu.navigate("{Enter}")
            Sleep, % dslep
            modmenu.getControls()
        }
    }
    if (!InStr(modmenu.getControls()[6].text, "Helicopter", true)) {
        while(game.modmenu.row != 4) {
            ; scriptlog("waiting for row 4. current: " . game.modmenu.row)
            modmenu.navigate("{Down}")
            Sleep, % dslep
            modmenu.getControls()
        }
        while(!InStr(modmenu.getControls()[6].text, "Helicopter", true)) {
            ; scriptlog("waiting for class Helicopter. current: " . modmenu.getControls()[6].text)
            modmenu.navigate("{Left}")
            Sleep, % dslep
        }
    }
    if (!InStr(modmenu.getControls()[7].text, "Police Maverick", true)) {
        while(game.modmenu.row != 5) {
            ; scriptlog("waiting for row 5. current: " . game.modmenu.row)
            modmenu.navigate("{Down}")
            Sleep, % dslep
            modmenu.getControls()
        }
        while(!InStr(modmenu.getControls()[7].text, "Police Maverick", true)) {
            ; scriptlog("waiting for model Police Maverick. current: " . modmenu.getControls()[7].text)
            modmenu.navigate("{Right}")
            Sleep, % dslep
        }
    }
    while(game.modmenu.row != 30) {
        ; scriptlog("waiting for row 30. current: " . game.modmenu.row)
        modmenu.navigate("{Up}")
        Sleep, % dslep
        modmenu.getControls()
    }
    modmenu.navigate("{Enter}")
    SplashScreen("Press F10 to give it godmode", "Spawned Police Maverick")
    modmenu.resetPage()
    modmenu.resetPosition()
    modmenu.navigate("{Backspace}", 4)
    ; scriptlog(c.id . " " . c.text)
    ; ControlSend, % c.id, "{Enter}", % modmenu.window.str()
    return
F10::
    modmenu.getControls()
    modmenu.resetPage()
    modmenu.resetPosition()
    while(game.modmenu.row != 3) {
        modmenu.navigate("{Down}")
        Sleep, % dslep
        modmenu.getControls()
    }
    while(game.modmenu.page != "Vehicle") {
        modmenu.navigate("{Enter}")
        Sleep, % dslep
        modmenu.getControls()
    }
    while(game.modmenu.row != 5) {
        modmenu.navigate("{Down}")
        Sleep, % dslep
        modmenu.getControls()
    }
    modmenu.navigate("{Enter}")
    SplashScreen("", "Gave current vehicle Godmode")
    modmenu.resetPage()
    modmenu.resetPosition()
    modmenu.navigate("{Backspace}", 4)
    return

CheckWindows:
    if (game.windows.game.exists()) {
        if (!modmenu.window.process.exists()) {
            new File("C:\Users\Shadow\Desktop\modest-menu_v0.8.10\modest-menu.exe").run()
            WinWait, % modmenu.window.str()
            modmenu.window := modmenu.getWindow(true)
            SplashScreen("Started Mod Menu")
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