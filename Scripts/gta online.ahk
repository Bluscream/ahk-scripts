#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Client
#Include <gta>
DetectHiddenWindows, On
SendMode, Input
;SendMode, Event|Play|Input|InputThenPlay
; EnforceAdmin()

global game := new Game("S:\Steam\steamapps\common\Grand Theft Auto V\")
global dslep := 100

Menu, Tray, Icon, % game.exe.path
Menu, tray, add, ---GTA Online---, lbl
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc
Menu, tray, add, Test, testFunc

SetTimer, CheckWindows, 1000
GetModMenuWindow(true)
GetModMenuControls()
; global logfile := new File("gta modmenu texts.txt")
return

F9::
    GetModMenuControls()
    if(game.modmenu.page != "Online Vehicle Spawn") {
        if (game.modmenu.page != "Main Menu") {
            ResetModMenuPage()
        }
        ResetModMenuPosition()
        while(game.modmenu.row != 10) {
            NavigateModMenu("{Up}")
            Sleep, % dslep
            GetModMenuControls()
        }
        while(game.modmenu.page != "Online Vehicle Spawn") {
            NavigateModMenu("{Enter}")
            Sleep, % dslep
            GetModMenuControls()
        }
    }
    if (!InStr(GetModMenuControls()[6].text, "Helicopter", true)) {
        while(game.modmenu.row != 4) {
            ; scriptlog("waiting for row 4. current: " . game.modmenu.row)
            NavigateModMenu("{Down}")
            Sleep, % dslep
            GetModMenuControls()
        }
        while(!InStr(GetModMenuControls()[6].text, "Helicopter", true)) {
            ; scriptlog("waiting for class Helicopter. current: " . GetModMenuControls()[6].text)
            NavigateModMenu("{Left}")
            Sleep, % dslep
        }
    }
    if (!InStr(GetModMenuControls()[7].text, "Police Maverick", true)) {
        while(game.modmenu.row != 5) {
            ; scriptlog("waiting for row 5. current: " . game.modmenu.row)
            NavigateModMenu("{Down}")
            Sleep, % dslep
            GetModMenuControls()
        }
        while(!InStr(GetModMenuControls()[7].text, "Police Maverick", true)) {
            ; scriptlog("waiting for model Police Maverick. current: " . GetModMenuControls()[7].text)
            NavigateModMenu("{Right}")
            Sleep, % dslep
        }
    }
    while(game.modmenu.row != 30) {
        ; scriptlog("waiting for row 30. current: " . game.modmenu.row)
        NavigateModMenu("{Up}")
        Sleep, % dslep
        GetModMenuControls()
    }
    NavigateModMenu("{Enter}")
    SplashScreen("", "Spawned Police Maverick")
    ResetModMenuPage()
    ResetModMenuPosition()
    NavigateModMenu("{Backspace}", 4)
    ; scriptlog(c.id . " " . c.text)
    ; ControlSend, % c.id, "{Enter}", % game.windows.modmenu.str()
    return
F10::
    GetModMenuControls()
    ResetModMenuPage()
    ResetModMenuPosition()
    while(game.modmenu.row != 3) {
        NavigateModMenu("{Down}")
        Sleep, % dslep
        GetModMenuControls()
    }
    while(game.modmenu.page != "Vehicle") {
        NavigateModMenu("{Enter}")
        Sleep, % dslep
        GetModMenuControls()
    }
    while(game.modmenu.row != 5) {
        NavigateModMenu("{Down}")
        Sleep, % dslep
        GetModMenuControls()
    }
    NavigateModMenu("{Enter}")
    SplashScreen("", "Gave current vehicle Godmode")
    ResetModMenuPage()
    ResetModMenuPosition()
    NavigateModMenu("{Backspace}", 4)
    return
F6::
    return
    c := GetModMenuWindow().controls()
    for i,e in c {
        logfile.appendLine(e.id . " > " . e.text)
    }
    logfile.appendLine("")
    return

CheckWindows:
    if (game.windows.game.exists()) {
        if (!game.windows.modmenu.process.exists()) {
            new File("C:\Users\Shadow\Desktop\modest-menu_v0.8.10\modest-menu.exe").run()
            WinWait, % game.windows.modmenu.str()
            game.windows.modmenu := GetModMenuWindow(true)
            SplashScreen("Started Mod Menu")
        } else {
            c := GetModMenuControls()
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
    scriptlog(game.windows.modmenu.isActive())
    
    scriptlog(game.windows.modmenu.isActive())
    ; pasteToNotepad(toJson(game.windows.modmenu, true))
    return

testFunc2:
    c := GetModMenuControls()
    for i,e in c {
        scriptlog(e.id . " > " . e.text)
    }
    return

NavigateModMenu(key, amount := 1) {
    Loop % amount {
        Sleep, 10
        Send, % key
    }
}
ResetModMenuPage() {
    fails := 0
    while(game.modmenu.page != "Main Menu") {
        ; scriptlog("waiting for page to reach main menu... (fails:" . fails . ")")
        NavigateModMenu("{Backspace}")
        fails++
        lastrow := game.modmenu.row
        GetModMenuControls()
        if (fails > 10 && lastrow == game.modmenu.row) {
            NavigateModMenu("{F4}")
            fails := 0
        }
        Sleep, % 100
    }
}
ResetModMenuPosition() {
    fails := 0
    while(game.modmenu.row > 1) {
        percent := (game.modmenu.row / game.modmenu.rows) * 20 
        ; scriptlog("pos: " . game.modmenu.row . " / " . game.modmenu.rows . " (" . percent . "%)... (fails:" . fails . ")")
        if (percent < 50)
            NavigateModMenu("{Up}")
        else
            NavigateModMenu("{Down}")
        fails++
        lastrow := game.modmenu.row
        GetModMenuControls()
        if (fails > 10 && lastrow == game.modmenu.row) {
            NavigateModMenu("{F4}")
            fails := 0
        }
        Sleep, % 100
    }
}

GetModMenuControls() {
    c := GetModMenuWindow().controls()
    fresh := game.modmenu.name == ""
    mnv := StrSplit(c[2].text, "v")
    game.modmenu.name := Trim(mnv[1])
    game.modmenu.version := Trim(mnv[2])
    rw := StrSplit(c[1].text, "/")
    game.modmenu.row := Trim(rw[1])
    game.modmenu.rows := Trim(rw[2])
    if (fresh)
        scriptlog("Found " . c[2].text)
    newpage := ""
    if (startsWith(c[3].text, "Game|"))
        newpage := "Main Menu"
    else if (c[3].text == "Leave Online")
        newpage := "Game"
    else if (startsWith(c[3].text, "God mode|")) 
        newpage := "Player"
    else if (startsWith(c[3].text, "Handling|")) 
        newpage := "Vehicle"
    else if (startsWith(c[3].text, "Weapons Loadout|")) 
        newpage := "Weapon"
    else if (startsWith(c[3].text, "Set Weather|")) 
        newpage := "World"
    else if (c[3].text == "Waypoint")
        newpage := "Teleport"
    else if (startsWith(c[3].text, "No Idle Kick|")) 
        newpage := "Tunables"
    else if (startsWith(c[3].text, "Independence Day|")) 
        newpage := "Unlocks"
    else if (startsWith(c[3].text, "Bunker Settings|")) 
        newpage := "Online Services"
    else if (startsWith(c[3].text, "Unlock all vehicles|")) 
        newpage := "Online Vehicle Spawn"
    else if (startsWith(c[3].text, "Disable Freeze|")) 
        newpage := "Online Protection"
    else if (startsWith(c[3].text, "Menu X position|")) 
        newpage := "Menu Settings"
    if (game.modmenu.page != newpage) {
        scriptlog("Modmenu page changed from " . game.modmenu.page . " to " . newpage . " (" . game.modmenu.row . "/" . game.modmenu.rows . ")" )
        game.modmenu.page := newpage
    }
    return c
}

GetModMenuWindow(force := false) {
    if (!force && game.windows.modmenu.exe == "modest-menu.exe" && game.windows.modmenu.exists())
        return game.windows.modmenu
    WinGet, WinList, List
    Loop % WinList
    {   
        ID := "ahk_id " WinList%A_Index%
        WinGet, ProcessName, ProcessName, % ID
        If !ItemInList(ProcessName, ["modest-menu.exe"])
            Continue
        WinGetTitle, WinTitle, % ID
        If ItemInList(WinTitle, ["Default IME"])
            Continue
        wnd := new Window(WinTitle,, ProcessName)
        wnd.id := WinList%A_Index%
        game.windows.modmenu := wnd
        scriptlog("Found ModMenu Window: " . toJson(wnd))
        return wnd
    }
}