#include <consoleapps>
; Define the ADB path. Adjust the path according to your ADB installation.
adb_path := "adb"

; Default behavior for volume keys
HandleVolumeKeys := true

; Check for command line switches
Loop, %0%
{
    Parameter := %A_Index%
    if (Parameter = "noVolume")
    {
        HandleVolumeKeys := false
    }
}

; Function to send ADB command
; SendADBCommand2(command) {
;     global adb_path
;     cmd := adb_path . " shell cmd media_session dispatch " . command
;     ComOBJ := ComObjCreate("WScript.Shell").Exec(cmd)
;     Response := ComOBJ.StdOut.ReadAll()
;     if (ComOBJ.ExitCode != 0) {
;         MsgBox, % "ADB command failed: " . Response
;     }
; }
SendADBCommand(command) {
    global adb_path
    cmd := adb_path . " shell cmd media_session dispatch " . command
    result := StdOutToVar(cmd)
    if (InStr(result, "err") || InStr(result, "fail")) {
        MsgBox, % "ADB command failed:`n`n" . result
    }
}

; Hotkeys for media keys
#InstallKeybdHook
#InstallMouseHook
#NoEnv
#SingleInstance force

; Play/Pause
~Media_Play_Pause::SendADBCommand("play-pause")

; Stop
~Media_Stop::SendADBCommand("stop")

; Previous
~Media_Prev::SendADBCommand("previous")

; Next
~Media_Next::SendADBCommand("next")

; Volume Up
~Volume_Up::
if (HandleVolumeKeys)
    SendADBCommand("volume --adj raise")
else
    Send, {Volume_Up}
return
; Volume Down
~Volume_Down::
if (HandleVolumeKeys)
    SendADBCommand("volume --adj lower")
else
    Send, {Volume_Down}
return
; Mute
~Volume_Mute::
if (HandleVolumeKeys)
    SendADBCommand("mute")
else
    Send, {Volume_Mute}
return

; Ensure the script keeps running
return
