; Version 10/18/2018
#Include <scs>
#Include <bluscream>
#Include <logtail>
; #NoEnv
#Persistent
; #InstallKeybdHook
#SingleInstance Force
; #UseHook On
; SendMode Input
Process Priority,, Below Normal
SetWorkingDir %A_ScriptDir%
; SetFormat, Integer, H

global noui := false
scriptlog("Started logging here...")
global antiafk_msg := "/p"
global player_name := "Bluscream"

global log_pattern := "^\[(\d{2}:\d{2}:\d{2})\] (.*)$"
global msg_pattern := "^(.*) \((\d+)\): (.*)$"
global server_pattern := "^Connecting to (.*) server\.\.\.$"
global queue_pattern := "^Connection established \(position in queue: (\d+)\)\.$"
global joined_msg := "Connection established!"
global system_pattern := "^\[(.*)\] (.*)$"
global others_kick_pattern := "^Player (.*)\((\d+)\) has been kicked\.$"
global afk_warning := "Please move! If you will not move within next minute you will be automatically kicked!"
global kick_pattern := "^You have been kicked from the server\. Reason: (.*)$"
global headlights_warning := "*** Turn on your headlights! If you will not enable them, you will be kicked within 15 seconds! ***"

;[07:57:37] You have been kicked from the server. Reason: Invalid accessory set detected. Sorry, you're not a Game Moderator! (NetTruck).
;[07:57:37] Server closed the connection. To connect again restart game.

global chat_key := GetChatKey()
global server := ""
global queue := 0

lt_chat := new LogTailer(getLatestLog("chat"), Func("OnNewLine"), true, "CP1200")
; lt_client := new LogTailer(getLatestLog("client"), Func("OnNewLine"), true, "CP1200")
; lt_spawn := new LogTailer(getLatestLog("log_spawning"), Func("OnNewLine"), true, "CP1200")
; lt_launcher := new LogTailer(mpfolder . "launcher.log", Func("OnNewLine"), true, "CP1200")
; lt_crash_mp := new LogTailer(mpfolder . "last_crash.log", Func("OnNewLine"), true, "CP1200")

; lt_game := new LogTailer(gamefolder . "game.log.txt", Func("OnNewLine"), true)
; lt_game_net := new LogTailer(gamefolder . "net.log", Func("OnNewLine"), true)
; lt_game_crash := new LogTailer(gamefolder . "net.log", Func("OnNewLine"), true)
; lt_game_bugs := new LogTailer(gamefolder . "bugs.txt", Func("OnNewLine"), true)
; lt_game_backups := new LogTailer(gamefolder . "backups.txt", Func("OnNewLine"), true)
; lt_game_history := new LogTailer(gamefolder . ".history.sii", Func("OnNewLine"), true)

; lt_telemetry := new LogTailer(gamefolder . "_TOOLS`\Telemetry`\Ets2Telemetry.log", Func("OnNewLine"), true)
; lt_vs := new LogTailer(gamefolder . "_TOOLS`\Virtual Speditor`\error.log", Func("OnNewLine"), true)
; lt_etcars := new LogTailer(gamefolder . "bin\win_x64`\ETCARS.log", Func("OnNewLine"), true)
; lt_fanaleds := new LogTailer(gamefolder . "bin\win_x64`\FanaLEDsPlugin.log", Func("OnNewLine"), true)

TrayTip, AutoHotKey, Started %game_shortname_mp% Anti-AFK,
return

OnNewLine(FileLine) {
    validLine := RegExMatch(FileLine, log_pattern, msg)
    if (!validLine){
        ; scriptlog("INVALID: " . fileline)
        return
    } else if (RegExMatch(msg2, msg_pattern, message)){
        if (InStr(message2,player_name)) {
            TrayTip, Mentioned in %game_shortname_mp%, %message3%
        } else {
            scriptlog("Message from " . message1 . " (ID: " . message2 . "): " . message3)
        }
    } else if (RegExMatch(msg2, kick_pattern, reason)){
        scriptlog("We got kicked for """ . reason1 . """")
        WinClose, %game_title_mp%
        WinWaitClose, %game_title_mp%
        startMP()
        Return
    }  else if (RegExMatch(msg2, system_pattern, system)) {
        if (RegExMatch(system2, others_kick_pattern, kicked_player)){
            scriptlog(kicked_player1 . " (ID: " . kicked_player2 . ") has been kicked from the server.")
        } else {
            scriptlog("System Message: " . system2)
        }
    }  else if (RegExMatch(msg2, server_pattern, result)) {
        server := result1
        scriptlog("Found server: " . server)
    }  else if (RegExMatch(msg2, queue_pattern, result)) {
        queue := result1
        if (queue > 5)
            WinMinimize, %game_title_mp%
        scriptlog("Found queue: " . queue)
    } else if (msg2 == joined_msg) {
        TrayTip, %game_shortname_mp%, You joined %server% (%queue%)
    } else if (msg2 == headlights_warning) {
        data := requestTelemetry()
        setLights(true, data.truck.lightsParkingOn, data.truck.lightsBeamLowOn)
        Sleep, 3000
        data := requestTelemetry()
        setLights(false, data.truck.lightsParkingOn, data.truck.lightsBeamLowOn)
    } else if (msg2 == afk_warning) {
        scriptlog("We were warned for being AFK, let's pretend we're not `;)")
        if !(WinActive(game_title_mp)) {
            minimized := true
            TrayTip, AutoHotKey, Bringing %game_shortname_mp% to front for AntiAFK...
            ToolTip, Sleep 1000, 0, 0
            SetTimer, RemoveToolTip, 1000
            Sleep, 1000
            WinActivate, %game_title_mp%
            WinWaitActive, %game_title_mp%
            ToolTip, Sleep 100, 0, 0
            SetTimer, RemoveToolTip, 100
            Sleep, 100
        } else if (A_TimeIdle < interval){
            Return
        } else {
            ToolTip %game_shortname_mp% AntiAFK..., 0, 0
            SetTimer, RemoveToolTip, 2500
        }
        paused := ""
        data := requestTelemetry()
        if (data.game.paused) {
            paused := "{F1}"
            Send, %paused%
            ToolTip, Sleep 100, 0, 0
            SetTimer, RemoveToolTip, 100
            Sleep, 100
            data := requestTelemetry()
            if (data.game.paused) {
                paused := "{Esc}"
                Send, %paused%
                ToolTip, Sleep 2000, 0, 0
                SetTimer, RemoveToolTip, 2000
                Sleep, 2000
                data := requestTelemetry()
                if (data.game.paused) {
                    Send, %paused%
                    ToolTip, Sleep 2000 2, 0, 0
                    SetTimer, RemoveToolTip, 2000
                    Sleep, 2000
                }
            }
        }
        SendInput, %chat_key%
        ToolTip, Sleep 50, 0, 0
        SetTimer, RemoveToolTip, 50
        Sleep, 50
        SendInput, %antiafk_msg%
        ToolTip, Sleep 50 2, 0, 0
        SetTimer, RemoveToolTip, 50
        Sleep, 50
        SendInput, {Enter}
        scriptlog("Was paused: " . paused . " minimized: " . minimized)
        if (paused)
            Send, %paused%
        if (minimized)
            WinMinimize, %game_title_mp%
        Return
    } else {
        scriptlog(msg2, msg1)
    }
    Return
}

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return