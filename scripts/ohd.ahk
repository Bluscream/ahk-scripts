#NoEnv
#SingleInstance, Force
#Persistent
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
; OutputDebug DBGVIEWCLEAR

#Include <logtail>
#Include <bluscream>

global no_ui := false
scriptlog("ohd.ahk::start")

global log_path :=  "C:\Users\blusc\AppData\Local\HarshDoorstop\Saved\Logs\HarshDoorstop.log" ; D:\Documents\My Mods\SpecialK\Profiles\Operation Harsh Doorstop\logs\game_output.log"
global log_path_dev := "G:\Steam\steamapps\common\Harsh Doorstop Developer Build\HarshDoorstop\Saved\Logs\HarshDoorstop.log"
global title := "Operation: Harsh Doorstop"
global icon := "G:\SteamLibrary\steamapps\common\Harsh Doorstop\HarshDoorstop\Binaries\Win64\IconGroup123.png"
Menu, Tray, Icon, % icon

global last_join_addr := ""

lt := new LogTailer(log_path, Func("OnNewLine"), true)
lt2 := new LogTailer(log_path_dev, Func("OnNewLine"), true)
ShowToast(title, "AutoHotkey", icon, "topleft", 5)
scriptlog("ohd.ahk::end")
return

Toast(message, _title := "Operation: Harsh Doorstop", time_seconds := 10) {
    global icon, title
    if (_title == "")
        _title := title
    ShowToast(message, _title, icon, "topleft", time_seconds)
  ; ShowToast(message, title := "AutoHotkey", icon_path := "toast.bmp", position := "topleft", time_seconds := 10, bg_color := "#222222")
}


OnNewLine(line){
    global last_join_addr
    ; scriptlog(line)
    res := CheckLine(line, "NetworkFailure: PendingConnectionFailure, Error: '(.*)'")
    if (res.Count() > 0) {
        Toast("Failed to connect to`n" . last_join_addr, res[1])
        return
    }

    res := CheckLine(line, "NetworkFailure: ConnectionLost, Error: '(.*)'")
    if (res.Count() > 0) {
        Toast(res[1], "Connection Lost") ;  (Maybe kicked?)
        return
    }

    res := CheckLine(line, "LogNet: UPendingNetGame::SendInitialJoin: Sending hello. \[UNetConnection\] RemoteAddr: (.*), Name: ")
    if (res.Count() > 0) {
        last_join_addr := res[1]
        return
    }

    ; res := CheckLine(line, "LogLoad: Took .* seconds to LoadMap\((.*)\)")
    ; if (res.Count() > 0) {
    ;     Toast(res[1], "Loaded Map")
    ;     return
    ; }

    res := CheckLine(line, "LogExit: Exiting.")
    if (res.Count() > 0) {
        Toast("Exiting")
        return
    }
    
}
CheckLine(inputStr, pattern) {
    result := []
    if RegExMatch(inputStr, "O)" . pattern, matches) {
        Loop, % matches.Count() {
            result.Push(matches.Value(A_Index))
        }
    }
    return result
}
