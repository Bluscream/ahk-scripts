; Version 10/18/2018
#Include <bluscream>
#Include <JSON>

global game_name := "Euro Truck Simulator 2"
global game_name_mp := "Euro Truck Simulator 2 Multiplayer"
global game_shortname := "ETS 2"
global game_shortname_mp := game_shortname . " MP"
global game_title := "ahk_class prism3d ahk_exe eurotrucks2.exe"
global game_title_sp := game_name . " " . game_title
global game_title_mp := game_name_mp . " " . game_title
global launcher_title_mp := "TruckersMP Launcher ahk_exe Launcher.exe"
global launcher_path_mp := "G:\Steam\steamapps\common\Euro Truck Simulator 2\_TOOLS\TruckersMP\Launcher.exe"
global mpfolder := A_MyDocuments . "`\ETS2MP`\"
global logfolder := mpfolder . "logs`\"
global gamefolder := "G:`\Steam`\steamapps`\common`\Euro Truck Simulator 2`\"

global noui := true

requestTelemetry() {
    URL := "http://127.0.0.1:25555/api/ets2/telemetry"
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpObj.Open("GET", URL, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    Wait := HttpObj.Send()
    Result := HttpObj.ResponseText
    Result := StrReplace(Result, "E-" , "")
    return JSON.Load(Result)
}
getLatestLog(type := "chat") {
    Loop, %logfolder%%type%_*
    {
         FileGetTime, Time, %A_LoopFileFullPath%, C
         If (Time > Time_Orig) {
              Time_Orig := Time
              logfile := A_LoopFileFullPath
         }
    }
    scriptlog("Newest " . type . " log file is " . logfile)
    return logfile
}
startMP(servertojoin := 0) {
    scriptlog("Starting " . launcher_path_mp)
    Run, %launcher_path_mp%
    WinWait, %launcher_title_mp%
    WinActivate, %launcher_title_mp%
    WinWaitActive, %launcher_title_mp%
    Sleep, 50
    CoordMode, Mouse, Screen
    Click, 1365, 662
    Sleep, 10
    Click, 1338, 692
    CoordMode, Mouse, Relative
    WinWait, %game_title_mp%
    WinActivate, %game_title_mp%
    WinWaitActive, %game_title_mp%
    Sleep, 1000
    SendInput, {Esc}
    Sleep, 1000
    SendInput, {Esc}
    Return
}
GetChatKey() {
    WinGet, WinID,, A
    ThreadID:=DllCall("GetWindowThreadProcessId", "UInt", WinID, "UInt", 0)
    InputLocaleID:=DllCall("GetKeyboardLayout", "UInt", ThreadID, "UInt")
    if (InputLocaleID == 0x4070409) { ;(de-DE)
        return "{SC02C}" ;(QUERTZ)
    } else { ;0x4090409 (en-US)
        return "{SC15}" ;(QUERTY)
    }
}
setLights(enabled, is_park, is_low) {
    already_on := enabled && is_low
    already_off := !enabled && (!is_park && !is_low)
    if (already_on or already_off)
        return
    if (enabled) {
        if (!is_park) {
            sends := 2
        } else if (is_park) {
            sends := 1
        }
    }
    else {
        if (is_low) {
        sends := 1
        } else if (is_park) {
            sends := 2 
        }
    }
    Loop, %sends% {
        SendInput, {L}
        Sleep, 50
    }
}
setGear(gear, data) {
    ; if (data.truck.displayedGear == gear)
    ;    return
    while (data.truck.displayedGear != gear) {
        scriptlog("displayedGear " . data.truck.displayedGear . " | gear " . gear)
        if (data.truck.displayedGear > gear)
            Send, {LControl}
        else
            Send, {LShift}
        Sleep, 50
    }
    data := requestTelemetry()
}
setBeacon(enabled, lightsBeaconOn) {
    if ((enabled && lightsBeaconOn) ||(!enabled && lightsBeaconOn))
        Return
    Send, O
}
setHighBeams(enabled) {
    data := requestTelemetry()
    if (data.game.paused || !data.truck.electricOn || !data.truck.lightsBeaconOn)
        Return
    if (enabled && !data.truck.lightsBeamHighOn) {
        Send, K
    }
    else if (!enabled && !data.truck.lightsBeamHighOn) {
        Send, K
    }
}
setEngine(on, electricOn, engineOn) {
    
}