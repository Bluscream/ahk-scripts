; Generated by AutoGUI 2.6.2
#SingleInstance Force
#Persistent
#NoEnv
; #NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
; #Include <bluscream>
; global no_ui := false

; Set the audio input device name here
InputDevice := "Audio Mixer [IN]"

; Set the audio output device name here
; OutputDevice := "Bluetooth Headset [OUT]"

global LastState := 0

return

RemoveToolTip:
    ToolTip
    return

; Toggle the "Listen to this device" option for the input device
ToggleListenToDevice(InputDevice) {
    global LastState
    LastState := !LastState
    ; Run the PowerShell script passing input and output device names
    cmd = SoundVolumeView /SetListenToThisDevice "%InputDevice%" %LastState%
    ; scriptlog(cmd)
    RunWait, % cmd
    ToolTip % "Listening " . (LastState ? "enabled" : "disabled") . " on " . InputDevice
    SetTimer, RemoveToolTip, -1000
    return
}



; Get the audio device ID based on the device name and type
; GetAudioDeviceID(DeviceName, DeviceType) {
;     ; Get the audio devices using PowerShell
;     RunWait, powershell.exe -Command "$devices = Get-WmiObject -Namespace 'Root\CIMv2\Audio' -Class 'Win32_SoundDevice'; $devices | Where-Object { $_.Name -like '*{DeviceName}*' -and $_.Direction -eq '{DeviceType}' } | ForEach-Object { $_.DeviceID } | ForEach-Object { Write-Host $_ }"

;     ; Read the output from PowerShell
;     RunWait, clip | powershell.exe -Command "Get-Clipboard" ; Copy PowerShell output to clipboard
;     ClipWait, 1
;     DeviceID := Clipboard

;     ; Return the audio device ID
;     return DeviceID
; }

; Define a hotkey to toggle the "Listen to this device" option
; ^!l::
; #q::
!q::
    ToggleListenToDevice(InputDevice)
    return