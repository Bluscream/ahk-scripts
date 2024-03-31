; #include <consoleapps> ; https://github.com/Bluscream/ahk-scripts/blob/master/lib/consoleapps.ahk

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
MakeAdbCommand(command) {
    global adb_path
    return adb_path . " shell cmd media_session dispatch " . command
}
SendADBCommand(command) {
    cmd := MakeAdbCommand(command)
    RunWait % cmd, , Min UseErrorLevel
    if (ErrorLevel = "ERROR") {
        MsgBox, % "ADB command failed with exitcode " . ExitCode
    }
}
; SendADBCommand(command) {
;     cmd := MakeAdbCommand(command)
;     ComOBJ := ComObjCreate("WScript.Shell").Exec(cmd)
;     Response := ComOBJ.StdOut.ReadAll()
;     if (ComOBJ.ExitCode != 0) {
;         MsgBox, % "ADB command failed: " . Response
;     }
; }
; SendADBCommand(command) { ; Requires http://www.autohotkey.com/board/topic/96903-simplified-versions-of-seans-stdouttovar/?p=610306
;     cmd := MakeAdbCommand(command)
;     result := StdOutToVar(MakeAdbCommand(cmd))
;     if (InStr(result, "err") || InStr(result, "fail")) {
;         MsgBox, % "ADB command failed:`n`n" . result
;     }
; }

; Hotkeys for media keys
#InstallKeybdHook
#InstallMouseHook
#NoEnv
#SingleInstance force

; If you want to disable media controls controlling PC media at the same time,
; just remove the ~ infront of each hotkey
; This will make it so the PC media keys no longer control the PC media, only android

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
