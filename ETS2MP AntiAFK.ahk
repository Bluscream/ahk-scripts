
If (A_PtrSize == 4) {
    SplitPath A_AhkPath,, AhkDir
    AhkPath := AhkDir . "\AutoHotkeyU64.exe"
    Run "%AhkPath%" "%A_ScriptFullPath%"
    ExitApp
}

If !(A_IsUnicode) {
    SplitPath A_AhkPath,, AhkDir
    AhkPath := AhkDir . "\AutoHotkey" . (A_Is64bitOS ? "U64" : "U32") . ".exe"
    Run "%AhkPath%" "%A_ScriptFullPath%"
    ExitApp
}
#Include <bluscream>
#Include <logtail>
#NoEnv
#Persistent
#InstallKeybdHook
#SingleInstance Force
#UseHook On
SendMode Input
Process Priority,, Below Normal
SetWorkingDir %A_ScriptDir%
; SetFormat, Integer, H

global ui := false
global noui := true
scriptlog("Started logging here...")
global game_name := "ETS 2 MP"
global game_title := "Euro Truck Simulator 2 Multiplayer ahk_class prism3d ahk_exe eurotrucks2.exe"
global antiafk_msg := "{Space}"
global player_name := "Bluscream"

global launcher_title := "TruckersMP Launcher ahk_exe Launcher.exe"
global launcher_path := "G:\Steam\steamapps\common\Euro Truck Simulator 2\_TOOLS\TruckersMP\Launcher.exe"

global log_pattern := "^\[(\d{2}:\d{2}:\d{2})\] (.*)$"
; global msg_pattern := "^(.*) \((\d+)\): (.*)$"
global kick_pattern := "^You have been kicked from the server\. Reason: (.*)$"
; global queue_pattern := "^Connection established \(position in queue: (\d+)\)\.$"
; global system_pattern := "^\[(.*)\] (.*)$"
; global others_kick_pattern := "^Player (.*)\((\d+)\) has been kicked\.$"
global afk_warning := "Please move! If you will not move within next minute you will be automatically kicked!"
global logfolder := A_MyDocuments . "`\ETS2MP`\logs`\"

global chat_key := GetChatKey()

lt := new LogTailer(getLatestChatLog(), Func("OnNewLine"), true, "CP1200")
TrayTip, AutoHotKey, Started %game_name% Anti-AFK,
return

OnNewLine(FileLine){
    validLine := RegExMatch(FileLine, log_pattern, msg)
    if (!validLine){
        scriptlog(fileline . " is not a valid line!")
        return
    }
    if (InStr(msg2,player_name))
        TrayTip, Mentioned in %game_name%, %msg2%
    if (RegExMatch(msg2, kick_pattern, reason)){
        scriptlog("We got kicked for """ . reason1 . """")
        WinClose, %game_title%
        WinWaitClose, %game_title%
        startMP()
        Return
    }
    if (msg2 == afk_warning) {
        scriptlog("We were warned for being AFK, let's pretend we're not `;)")
        if !(WinActive(game_title)) {
            minimized := true
            TrayTip, AutoHotKey, "Bringing %game_name% to front for AntiAFK..."
            Sleep, 1000
            WinActivate, %game_title%
            Sleep, 500
        } else if (A_TimeIdle < interval){
            Return
        }
        data := requestTelemetry()
        if (data.game.paused) {
            paused := true
            Sleep, 500
            SendInput, {Esc} ; F1
            Sleep, 500
        }
        SendInput, %chat_key%
        Sleep, 50
        SendInput, %antiafk_msg%
        Sleep, 50
        SendInput, {Enter}
        if (paused)
            SendInput, {Esc}
        if (minimized)
            WinMinimize, %game_title%
        Return
    }
    scriptlog(msg2, msg1)
    Return
}

startMP(server := 0) {
    scriptlog("Starting " . launcher_path)
    Run, %launcher_path%
    WinWait, %launcher_title%
    WinActivate, %launcher_title%
    WinWaitActive, %launcher_title%
    CoordMode, Mouse, Screen
    Click, 1338, 692
    WinWait, %game_title%
    WinActivate, %game_title%
    WinWaitActive, %game_title%
    Sleep, 1000
    SendInput, {Esc}
    Sleep, 1000
    SendInput, {Esc}
    Return ; todo fix
    Sleep, 10000
    scriptlog("click")
    ControlGet, hwnd, Hwnd,,, %game_title%
    PostClick(hwnd, 1965, 859)
    CoordMode, Mouse, Relative
    ; MsgBox,,, Done
}

getLatestChatLog() {
    Loop, %logfolder%chat_*
    {
         FileGetTime, Time, %A_LoopFileFullPath%, C
         If (Time > Time_Orig) {
              Time_Orig := Time
              logfile := A_LoopFileFullPath
         }
    }
    scriptlog("Newest chat log file is `n`n" . logfile)
    return logfile
}
    
requestTelemetry() {
    URL := "http://localhost:25555/api/ets2/telemetry"
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpObj.Open("GET", URL, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    HttpObj.Send()
    Result := HttpObj.ResponseText
    return JSON.Load(Result)
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