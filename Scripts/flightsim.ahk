#SingleInstance Force
#Persistent
Process, Priority,, High
#Include <bluscream>
global noui := false
EnforceAdmin()
; Menu, Tray, Icon, % "shell:AppsFolder\Microsoft.FlightSimulator_8wekyb3d8bbwe!App"
Menu, tray, add, -Flight Simulator-, lbl
Menu, tray, add, Kill Game, killGame
Menu, tray, add, (Re)start Game, startGame
global game := new Window("Microsoft Flight Simulator", "AceApp", "FlightSimulator.exe", "C:\Users\Shadow\Destop\Microsoft Flight Simulator.lnk")
global windows := []
windows.push(new Window("", "ConsoleWindowClass", "vfrmap.exe", "C:\Users\Shadow\Desktop\vfrmap.exe"))
windows.push(new Window("", "AutoHotkeyGUI", "ujr.exe", "C:\Users\Shadow\Downloads\ujr.exe"))
SetTimer, CheckWindows, 10000
CheckWindows() {
    if (!game.isActive())
        Return
    for k, v in windows {
        if (!v.exists()) {
            v.file.run()
        }
    }
    return
}
lbl() {
    pasteToNotepad(toJson(windows, true))
}
startGame() {
    this.kill()
    game.file.run()
    return
}
killGame() {
    window_closed := game.close()
    process_closed := game.process.close()
    process_killed := game.process.kill(true, true)
    return
}
return
; #IfWinExist, ahk_class AceApp ahk_exe FlightSimulator.exe
; o::Click Down Right
; p::Click Up Right
^F1::
    WinGet, currWin
    WinGet, WinList, List
    Loop % WinList
    {
        winID := "ahk_id " WinList%A_Index%
        WinGet, ProcessName, ProcessName, % ID
        if (ProcessName == "FlightSimulator.exe") {
            Winset, AlwaysOnTop, Off, % winID
            continue
        }
        Winset, AlwaysOnTop, On, % winID
        WinActivate, % winID
        WinShow, % winID
    }
    return