; Requires VA.ahk library
#NoEnv
#Include <VA>

class MicVolumeController {
    static deviceName := "renkforce CU-4"
    
    ; Initialize VA library
    Init() {
        if !VA_Init()
            MsgBox % "Error: Unable to initialize VA library!"
    }
    
    ; Get the device ID for our microphone
    GetDeviceID() {
        devices := VA_GetDevices("capture")
        for device in devices {
            if (device.Name = this.deviceName)
                return device.ID
        }
        MsgBox % "Error: Could not find microphone " . this.deviceName
        ExitApp
    }
    
    ; Set the volume to 100%
    SetVolume(volumePercent = 100) {
        deviceId := this.GetDeviceID()
        
        ; Convert percentage to float value (0.0 to 1.0)
        volumeFloat := volumePercent / 100
        
        ; Set the master volume
        VA_SetMasterVolume(deviceId, volumeFloat)
        
        ; Also set the microphone boost if available
        VA_SetMasterVolume(deviceId, volumeFloat, "MICBOOST")
        
        MsgBox % "Volume set to " .volumePercent . " for device: " . this.deviceName
    }
}

; Main script
micController := new MicVolumeController()
micController.Init()
micController.SetVolume()


; #NoEnv
; #SingleInstance force

; Loop 20 {
;     SoundGet, vol,,, %A_Index%
;     MsgBox , Device %A_Index% Volume: %vol%
; }

; ExitApp


; #include <bluscream>
; global no_ui := false
; scriptlog("Starting...")

; ArrayOfMP3:=Object()
; Loop, 5                                            ;Create fake array
;      ArrayOfMP3.Insert("D:\" . A_Index . ".mp3")
; Gui, Default
; Gui, Add, ListView, W600 H500 Checked Grid -Sort vMylistview gListLabel -Multi, Title|Artist
; Loop, % ArrayOfMP3.MAxIndex()
; 	LV_Add("Check","Title " . A_Index,"Artist " . A_Index)        ;Fake listview items
; LV_ModifyCol()
; Gui, show
; GuiControl, +AltSubmit, Mylistview
; return

; ListLabel:
; if (A_GuiEvent = "I")
; {
;     if InStr(ErrorLevel, "c", true)
;     {
;         LV_GetText(Title, A_EventInfo, 1)
;         LV_GetText(Artist, A_EventInfo, 2)
;         msgbox % "Remove:`nTitle = " . Title "`nArtist = " . Artist
;     }
;     if InStr(ErrorLevel, "C", true)
;     {
;         LV_GetText(Title, A_EventInfo, 1)
;         LV_GetText(Artist, A_EventInfo, 2)
;         msgbox % "Insert:`nTitle = " . Title "`nArtist = " . Artist
;     }
; }
; return

; ListGUIClose:
; ListGUIEscape:
; ExitApp