; Hotkeys for media keys
#InstallKeybdHook
#InstallMouseHook
#NoEnv
#SingleInstance force
#Include <bluscream>
#include <consoleapps> ; https://github.com/Bluscream/ahk-scripts/blob/master/lib/consoleapps.ahk

; Define the ADB path. Adjust the path according to your ADB installation.
adb_path := "adb"
; Default behavior for volume keys
HandleVolumeKeys := false
device_id := "7bb16eeeb8e9c86c7578552408caede5"
global no_ui := false

; Check for command line switches
Loop, %0%
{
    Parameter := %A_Index%
    StringLower, LowerParam, Parameter
    if (LowerParam = "--no-volume")
    {
        HandleVolumeKeys := false
        Break
    }
}
adb_devices := Trim(ComCommand(adb_path . " devices"))
adb_devices := StrReplace(adb_devices, "`r" , "")
adb_devices := StrReplace(adb_devices, "`n" , "")
if (adb_devices == "List of devices attached") { ; \r\n\r\n
    result = ConnectAdb()
    if (result != "")
        scriptlog(result)
}

; If you want to disable media controls controlling PC media at the same time,
; just remove the ~ infront of each hotkey
; This will make it so the PC media keys no longer control the PC media, only android

~Media_Play_Pause::SendCommand("play-pause") ; Play/Pause
~Media_Stop::SendCommand("stop") ; Stop
~Media_Prev::SendCommand("previous") ; Previous
~Media_Next::SendCommand("next") ; Next
~Volume_Up:: ; Volume Up
    if (HandleVolumeKeys)
        SendCommand("volume_up")
    else
        Send, {Volume_Up}
    return
~Volume_Down:: ; Volume Down
    if (HandleVolumeKeys)
        SendCommand("volume_down")
    else
        Send, {Volume_Down}
    return
~Volume_Mute:: ; Mute
    if (HandleVolumeKeys)
        SendCommand("mute")
    else
        Send, {Volume_Mute}
    return

return ; Ensure the script keeps running

SendCommand(command) {
    SendADBCommand(MakeAdbCommand(command))
    ; SendHASSCommand(MakeHASSCommand(command))
    return command
}
RunCommand(cmd) {
    RunWait % cmd, , Min UseErrorLevel
    if (ErrorLevel = "ERROR") {
        MsgBox, % "ADB command failed with exitcode " . ExitCode
    }
}
ComCommand(cmd) {
    ComOBJ := ComObjCreate("WScript.Shell").Exec(cmd)
    Response := ComOBJ.StdOut.ReadAll()
    if (ComOBJ.ExitCode != 0) {
        MsgBox, % "ADB command failed: " . Response
    }
    return response
}
; region ADB
ConnectAdb() {
    global adb_path
    InputBox, host , % "ADB", % "Enter ADB ip:port",,,,,,,, % "192.168.2.28:"
    cmd := adb_path . " connect " . host
    result := ComCommand(cmd)
    return result
}
; Function to send ADB command
MakeAdbCommand(command) {
    global adb_path
    ; scriptlog("got command: " . command)
    if (command == "play-pause") {
        return adb_path . " shell cmd media_session dispatch play-pause"
    } else if (command == "stop") {
        return adb_path . " shell cmd media_session dispatch stop"
    } else if (command == "previous") {
        return adb_path . " shell cmd media_session dispatch previous"
    } else if (command == "next") {
        return adb_path . " shell cmd media_session dispatch next"
    } else if (command == "volume_up") {
        return adb_path . " shell cmd media_session volume --show --adj raise"
    } else if (command == "volume_down") {
        return adb_path . " shell cmd media_session volume --show --adj lower"
    }else if (command == "mute") {
        return adb_path . " shell cmd media_session dispatch mute"
    }
}
SendADBCommand(cmd) { ; Requires http://www.autohotkey.com/board/topic/96903-simplified-versions-of-seans-stdouttovar/?p=610306
    ; cmd := MakeAdbCommand(cmd)
    ; scriptlog("Sending adb command: " . cmd)
    result := StdOutToVar(cmd)
    ; scriptlog("Got adb response: " . result)
    if (InStr(result, "err") || InStr(result, "fail")) {
        MsgBox, % "ADB command failed:`n`n" . result
    }
}
; endregion ADB
; region HASS
MakeHASSCommand(command) {
    if (command == "play-pause") {
        return "media_player/media_play_pause"
    } else if (command == "stop") {
        return "media_player/media_stop"
    } else if (command == "previous") {
        return "media_player/media_previous_track"
    } else if (command == "next") {
        return "media_player/media_next_track"
    } else if (command == "volume_up") {
        return "media_player/volume_up"
    } else if (command == "volume_down") {
        return "media_player/volume_down"
    }else if (command == "mute") {
        return "media_player/volume_mute"
    }
}
SendHASSCommand(action) {
    global device_id
    EnvGet, HASS_SERVER, HASS_SERVER
    EnvGet, HASS_TOKEN, HASS_TOKEN
    HASS_TOKEN := "Bearer " . HASS_TOKEN

    url := HASS_SERVER . "/api/services/" . action
    ; scriptlog(url)
    payload := { "device_id": device_id }
    jsonPayload := toJson(payload, false) ; "{""target"": {""device_id"": """ device_id """}}"
    ; scriptlog(jsonPayload)

    ; scriptlog("Sending hass command: " . jsonPayload)
    if (startsWith(url, "https:")) {
        ; Set up the HTTP request headers
        http := ComObjCreate("MSXML2.XMLHTTP")
        http.Open("POST", url, true)
        http.setRequestHeader("Authorization", HASS_TOKEN)
        http.setRequestHeader("Content-Type", "application/json")

        ; Bypass SSL certificate validation (use with caution)
        ; sslSettings := ComObjectCreate("wininet.SecuritySupportFlags")
        ; sslSettings.Add(0x00000001) ; SECURITY_FLAG_IGNORE_UNKNOWN_CA
        ; sslSettings.Add(0x00000002) ; SECURITY_FLAG_IGNORE_CERT_DATE_INVALID
        ; sslSettings.Add(0x00000004) ; SECURITY_FLAG_IGNORE_CERT_CN_OR_SUBJECT_ALT_NAME_MISMATCH
        ; sslSettings.Add(0x00000008) ; SECURITY_FLAG_IGNORE_CERT_STATUS_PROBLEM
        ; sslSettings.Add(0x00000010) ; SECURITY_FLAG_IGNORE_CERT_WRONG_USAGE
        ; DllCall("WinInet.dll", "int", "InternetSetOption", "ptr", headers, "int", 0x0000000C, "uint", 0x00000200, "ptr", sslSettings)

        DllCall("WinInet.dll", "int", "InternetSetOption", "ptr", http, "int", 0x0000000C, "uint", 0x00000200, "ptr", &sslSettings)

        ; Send the request
        http.send(jsonPayload)

        ; ; Wait for the response
        ; while !headers.readyState || headers.readyState != 4 {
        ;     Sleep, 100
        ; }

        ; ; Check the response status
        ; if (headers.status == 200) {
        ;     MsgBox, Notification sent successfully!
        ; } else {
        ;     MsgBox, % "Failed to send notification. Status Code:" . headers.status
        ; }
    } else {
        ; Create a WinHttp.WinHttpRequest.5.1 object
        http := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        ; Set up the HTTP request
        http.Open("POST", url, false)
        http.SetRequestHeader("Authorization", HASS_TOKEN)
        http.SetRequestHeader("Content-Type", "application/json")
        ; Send the request
        http.Send(jsonPayload)
        ; scriptlog(toJson(http, true))
        ; Wait for the response
        ; scriptlog(toJson(http.StatusText(), true))
        ; scriptlog(toJson(http.ResponseText(), true))
        ; While (!http.ResponseText) {
        ;     Sleep, 100
        ; }
    }
    ; scriptlog("Got hass response: " . http.StatusText())
}
; endregion HASS