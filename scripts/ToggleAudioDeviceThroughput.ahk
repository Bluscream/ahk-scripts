; Generated by AutoGUI 2.6.2
#SingleInstance Force
#Persistent
#NoEnv
; #NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#Include <bluscream>
; #Include <VA>
global no_ui := false

global menu_items := SetupMenu()
return

RemoveToolTip2:
    ToolTip
    Return

; Toggle the "Listen to this device" option for the input device
ToggleListenToDevice(InputDevice) {
    ; scriptlog("ToggleListenToDevice(" . InputDevice)
    InputDeviceName := StrSplit(InputDevice," (")[1]
    NewState := !IsMenuChecked("Tray", menu_items[InputDevice])
    scriptlog("""" . InputDevice . """ NewState: " . NewState)
    ; Run the PowerShell script passing input and output device names
    cmd = SoundVolumeView /SetListenToThisDevice "%InputDeviceName%" %NewState%
    ; scriptlog(cmd)
    RunWait % cmd
    Menu, Tray, ToggleCheck, % InputDevice
    ToolTip % "Listening " . (NewState ? "enabled" : "disabled") . " on " . InputDevice
    SetTimer, RemoveToolTip2, -1000
    return
}

SetupMenu() {
    ret := {}
    Menu, Tray, DeleteAll
    devices := GetAudioDevices()
    for device, name in devices {
        lbl := name . " (" . device . ")"
        Menu, Tray, Add, % lbl, ToggleListenToDevice
        ret[lbl] := A_Index
    }
    Menu, Tray, NoStandard
    return ret
}

IsMenuChecked(menuName, itemNumber)  {
    static MIIM_STATE := 1, MFS_CHECKED := 0x8
    hMenu := MenuGetHandle(menuName)
    ; SendMessage, 0x211
    ; SendMessage, 0x212
    VarSetCapacity(MENUITEMINFO, size := 4*4 + A_PtrSize*8, 0)
    NumPut(size, MENUITEMINFO)
    NumPut(MIIM_STATE, MENUITEMINFO, 4, "UInt")
    DllCall("GetMenuItemInfo", Ptr, hMenu, UInt, itemNumber - 1, UInt, true, Ptr, &MENUITEMINFO)
    Return !!(NumGet(MENUITEMINFO, 4*3, "UInt") & MFS_CHECKED)
 }

GetAudioDevices(output := false) {
    ret := {}
    search := "Capture"
    if (output == true) {
        search := "Render"
    }
    EnvGet, temp, temp
    path := temp . "\dump.csv"
    cmd = SoundVolumeView /scomma "%path%"
    ; scriptlog(cmd)
    RunWait % cmd
    ; ret := ReadDevicesFromCSV(path)
    CSV_Load(path,"data")
    Rows:=CSV_TotalRows("data")
    Loop, % Rows {
        is_device := (CSV_ReadCell("data",A_Index,2) == "Device")
        if (is_device != 0) { ; found:=CSV_Search("data","Device",A_Index)
            direction := CSV_ReadCell("data",A_Index,3)
            if (direction == search) {
                name := CSV_ReadCell("data",A_Index,1)
                device := CSV_ReadCell("data",A_Index,4)
                ; Results .= A_Index . ": " . device . "=" . name . "=" . direction . "`n"
                ret[device] := name
            }
        }
    }
    return ret
}

; ReadDevicesFromCSV(path) {
;     ret := []
;     Loop, read, % path
;     {
;         columns := StrSplit(A_LoopReadLine , ",")
;         is_device := columns [2]
;     }
; }

uniqueArray(arr) {
    hash := {}, newArr := []
    for e, v in arr
        if (!hash[v])
            hash[(v)] := 1, newArr.push(v)
    return newArr
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
    ToggleListenToDevice("Audio Mixer [IN] (F998)")
    return