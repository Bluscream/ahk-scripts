#Requires AutoHotkey v1.1
#NoEnv
#SingleInstance Force
#Persistent
SetWorkingDir %A_ScriptDir%

; Mouse Switcher Script
; Creates a tray menu to switch between mice by disabling all others when one is selected

global Mice := {}  ; Object to store mouse information
global CurrentMouse := ""  ; Currently active mouse

; Create tray menu
; Menu, Tray, NoStandard
Menu, Tray, Add, &Refresh Mice, RefreshMice
Menu, Tray, Add
Menu, Tray, Add, &Debug Info, ShowDebugInfo
Menu, Tray, Add
Menu, Tray, Add, E&xit, ExitScript
Menu, Tray, Default, &Refresh Mice
Menu, Tray, Icon, shell32.dll, 44  ; Mouse icon

; Initialize
gosub, RefreshMice
return

; Refresh the list of mice
RefreshMice:
    Mice := {}
    CurrentMouse := ""
    
    ; Clear existing mouse menu items
    Menu, Tray, Delete, &Refresh Mice
    Menu, Tray, Delete, E&xit
    
    ; Get all mice using helper function
    AllMice := GetAllMice()
    
    MouseCount := 0
    for MouseName, MouseInfo in AllMice {
        MouseCount++
        
        ; Store mouse information
        Mice[MouseName] := MouseInfo
        
        ; Add to tray menu
        Menu, Tray, Add, %MouseName%, MouseSelected
    }
    
    ; Add separator and exit option back
    Menu, Tray, Add
    Menu, Tray, Add, &Refresh Mice, RefreshMice
    Menu, Tray, Add, E&xit, ExitScript
    
    if (MouseCount = 0) {
        Menu, Tray, Add, No mice found, NoAction
    }
    
    ; Update tray tip
    Menu, Tray, Tip, Mouse Switcher`n%MouseCount% mice detected
return

; Show debug information
ShowDebugInfo:
    DebugText := "=== Mouse Switcher Debug Info ===`n`n"
    
    ; Get all mice using helper function
    AllMice := GetAllMice()
    
    DebugText .= "Detected Mice:`n"
    DebugText .= "---------------`n"
    
    MouseCount := 0
    for MouseName, MouseInfo in AllMice {
        MouseCount++
        DebugText .= "Mouse " MouseCount ":`n"
        DebugText .= "  Name: " MouseName "`n"
        DebugText .= "  Path: " MouseInfo.Path "`n"
        DebugText .= "  Status: " MouseInfo.Status "`n"
        DebugText .= "  Enabled: " (MouseInfo.Enabled ? "Yes" : "No") "`n"
        DebugText .= "`n"
    }
    
    if (MouseCount = 0) {
        DebugText .= "No mice detected.`n"
    }
    
    DebugText .= "=== End Debug Info ==="
    
    ; Show in a messagebox with copyable text
    MsgBox, 64, Mouse Switcher Debug Info, %DebugText%
return

; Get all mice from multiple sources
GetAllMice() {
    AllMice := {}
    DetectedPaths := {}  ; Track detected paths to avoid duplicates
    
    ComObjError(false)
    try {
        wmi := ComObjGet("winmgmts:")
        
        ; Method 1: Get pointing devices
        miceQuery := wmi.ExecQuery("SELECT * FROM Win32_PointingDevice")
        
        for mouse in miceQuery {
            DeviceID := Trim(mouse.DeviceID)
            DetectedPaths[DeviceID] := true
            
            ; Get real mouse name
            MouseName := GetRealMouseNameFromPnP(DeviceID)
            
            ; Check if enabled
            IsEnabled := IsDeviceEnabled(DeviceID)
            
            AllMice[MouseName] := {Path: DeviceID, Status: mouse.Status, Enabled: IsEnabled}
        }
        
        ; Method 2: Get ALL PnP devices with mouse VID/PID (including disabled ones)
        pnpQuery := wmi.ExecQuery("SELECT * FROM Win32_PnPEntity WHERE DeviceID LIKE '%VID_%' AND DeviceID LIKE '%&PID_%'")
        
        for pnp in pnpQuery {
            DeviceName := Trim(pnp.Name)
            PnpDeviceID := Trim(pnp.DeviceID)
            
            ; Skip if already detected
            if (DetectedPaths.HasKey(PnpDeviceID)) {
                continue
            }
            
            ; Check if this is a mouse device
            if (InStr(PnpDeviceID, "VID_") && InStr(PnpDeviceID, "&PID_")) {
                if (RegExMatch(PnpDeviceID, "VID_([0-9A-Fa-f]{4})&PID_([0-9A-Fa-f]{4})", match)) {
                    VID := match1
                    PID := match2
                    
                    if (IsMouseDevice(VID, PID, DeviceName)) {
                        DetectedPaths[PnpDeviceID] := true
                        
                        ; Get proper mouse name (don't just use DeviceName)
                        MouseName := GetRealMouseNameFromPnP(PnpDeviceID)
                        if (MouseName = "") {
                            MouseName := DeviceName  ; Fallback to original name
                        }
                        
                        ; Check if enabled (disabled devices will show as false)
                        IsEnabled := IsDeviceEnabled(PnpDeviceID)
                        
                        AllMice[MouseName] := {Path: PnpDeviceID, Status: "OK", Enabled: IsEnabled}
                    }
                }
            }
        }
        
    } catch e {
        ; Return empty if error occurs
    }
    ComObjError(true)
    
    return AllMice
}

; Check if a device is enabled
IsDeviceEnabled(DeviceID) {
    ; Try to get device status - for now assume enabled
    ; TODO: Implement proper device status checking
    return true
}

; Get real mouse name from PnP entities (simplified)
GetRealMouseNameFromPnP(PointingDeviceID) {
    ; Extract VID and PID from PointingDeviceID
    if (RegExMatch(PointingDeviceID, "VID_([0-9A-Fa-f]{4})&PID_([0-9A-Fa-f]{4})", match)) {
        VID := match1
        PID := match2
        
        ; Search for matching PnP entity with the same VID/PID
        ComObjError(false)
        try {
            wmi := ComObjGet("winmgmts:")
            pnpQuery := wmi.ExecQuery("SELECT * FROM Win32_PnPEntity WHERE DeviceID LIKE '%" VID "%' AND DeviceID LIKE '%" PID "%'")
            
            ; Find the best match with priority system
            BestName := ""
            BestPriority := 0
            
            for pnp in pnpQuery {
                DeviceName := Trim(pnp.Name)
                DeviceDesc := Trim(pnp.Description)
                PnpDeviceID := Trim(pnp.DeviceID)
                
                ; Skip generic HID names and keyboard functions
                if (DeviceName = "HID-compliant mouse" || DeviceName = "USB Input Device" || DeviceName = "HID-compliant device" 
                    || DeviceName = "HID-compliant vendor-defined device" || DeviceName = "HID-compliant system controller"
                    || DeviceName = "HID-compliant consumer control device" || DeviceName = "HID Keyboard Device"
                    || InStr(DeviceName, "Keyboard Functions") || InStr(DeviceName, "Media Keys")) {
                    continue
                }
                
                ; Priority system:
                ; Priority 3: Base USB device (no HID, no MI_ in DeviceID)
                ; Priority 2: Specific product names (like "G203 Prodigy")
                ; Priority 1: Other non-generic names
                
                CurrentPriority := 1
                if (InStr(PnpDeviceID, "USB\" VID "&PID_" PID "\") && !InStr(PnpDeviceID, "HID\") && !InStr(PnpDeviceID, "&MI_")) {
                    CurrentPriority := 3  ; Base USB device - highest priority
                } else if (DeviceName != "USB Composite Device" && DeviceName != "USB Input Device") {
                    CurrentPriority := 2  ; Specific product name
                }
                
                if (CurrentPriority > BestPriority) {
                    BestName := DeviceName
                    BestPriority := CurrentPriority
                }
            }
            
            ; If we found a good name, return it
            if (BestName != "") {
                ComObjError(true)
                return BestName
            }
        } catch e {
            ; Fallback to manufacturer lookup if PnP query fails
        }
        ComObjError(true)
        
        ; Fallback to manufacturer lookup
        return GetManufacturerName(VID, PID)
    }
    
    ; Fallback to generic name
    return "Generic Mouse"
}

; Get device name from registry (our custom names)
GetDeviceNameFromRegistry(VID, PID) {
    ; Try USB device first
    RegRead, USBName, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Enum\USB\VID_%VID%&PID_%PID%, FriendlyName
    if (!ErrorLevel && USBName != "") {
        return USBName
    }
    
    ; Try specific USB device instances
    Loop, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Enum\USB\VID_%VID%&PID_%PID%, 0, 0
    {
        if (A_LoopRegName != "") {
            RegRead, USBInstanceName, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Enum\USB\VID_%VID%&PID_%PID%\%A_LoopRegName%, FriendlyName
            if (!ErrorLevel && USBInstanceName != "") {
                return USBInstanceName
            }
        }
    }
    
    ; Try HID devices
    Loop, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Enum\HID\VID_%VID%&PID_%PID%, 0, 0
    {
        if (A_LoopRegName != "") {
            RegRead, HIDName, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Enum\HID\VID_%VID%&PID_%PID%\%A_LoopRegName%, FriendlyName
            if (!ErrorLevel && HIDName != "" && HIDName != "HID-compliant mouse") {
                return HIDName
            }
        }
    }
    
    return "Fallback to PnP"
}

; Check if a device is a mouse based on VID/PID and name
IsMouseDevice(VID, PID, DeviceName) {
    ; Skip keyboard functions and media keys
    if (InStr(DeviceName, "Keyboard Functions") || InStr(DeviceName, "Media Keys") || InStr(DeviceName, "Keyboard") || InStr(DeviceName, "Virtual Keyboard")) {
        return false
    }
    
    ; Skip generic input devices
    if (DeviceName = "USB Input Device" || DeviceName = "HID-compliant device" || DeviceName = "HID-compliant vendor-defined device") {
        return false
    }
    
    ; Skip specific keyboards
    if (InStr(DeviceName, "G213") || InStr(DeviceName, "Standard Keyboard")) {
        return false
    }
    
    ; Skip devices that are already detected as pointing devices (by checking if they contain mouse-specific keywords)
    if (InStr(DeviceName, "G203 Prodigy Gaming Mouse") || InStr(DeviceName, "SteelSeries Rival 3")) {
        return false  ; These are already detected as pointing devices
    }
    
    ; Known mouse manufacturers - be more specific
    if (VID = "046D") {
        ; Logitech - only specific mouse PIDs
        if (PID = "C084" || PID = "C336") return true  ; G203, G305
        return false
    }
    if (VID = "1038") return true  ; SteelSeries - all are mice
    if (VID = "30FA") return true  ; Zowie - all are mice
    if (VID = "320F") {
        ; Razer - only specific mouse PIDs
        if (PID = "505B") return true  ; Virtual Mouse
        return false
    }
    if (VID = "1532") return true  ; Razer
    if (VID = "045E") return true  ; Microsoft
    if (VID = "093A") return true  ; A4Tech
    if (VID = "04B3") return true  ; IBM
    if (VID = "06CB") return true  ; Synaptics
    if (VID = "0951") return true  ; Kingston
    
    ; Check device name for mouse indicators (but exclude already detected ones)
    if ((InStr(DeviceName, "Mouse") || InStr(DeviceName, "Heated Gaming RGB") || InStr(DeviceName, "G203 Prodigy Gaming Mouse")) && !InStr(DeviceName, "SteelSeries Rival 3")) {
        return true
    }
    
    return false
}

; Get manufacturer name based on VID/PID (fallback)
GetManufacturerName(VID, PID) {
    ; Manufacturer lookup based on VID
    if (VID = "046D") {
        return "Logitech Mouse (" PID ")"
    } else if (VID = "1038") {
        return "SteelSeries Mouse (" PID ")"
    } else if (VID = "30FA") {
        return "Zowie Mouse (" PID ")"
    } else if (VID = "320F") {
        return "Razer Mouse (" PID ")"
    } else if (VID = "1532") {
        return "Razer Mouse (" PID ")"
    } else if (VID = "045E") {
        return "Microsoft Mouse (" PID ")"
    } else if (VID = "093A") {
        return "A4Tech Mouse (" PID ")"
    } else if (VID = "04B3") {
        return "IBM Mouse (" PID ")"
    } else if (VID = "06CB") {
        return "Synaptics Mouse (" PID ")"
    } else if (VID = "0951") {
        return "Kingston Mouse (" PID ")"
    } else {
        return "Unknown Mouse (" VID ":" PID ")"
    }
}

; Handle mouse selection from tray menu
MouseSelected:
    SelectedMouse := A_ThisMenuItem
    
    ; If clicking the currently active mouse, do nothing
    if (SelectedMouse = CurrentMouse) {
        return
    }
    
    ; Disable all mice first
    for MouseName, MouseInfo in Mice {
        if (MouseName != SelectedMouse) {
            DisableMouse(MouseInfo.ID)
            MouseInfo.Enabled := false
            ; Update menu to show disabled state
            Menu, Tray, Uncheck, %MouseName%
        }
    }
    
    ; Enable the selected mouse
    if (Mice.HasKey(SelectedMouse)) {
        EnableMouse(Mice[SelectedMouse].ID)
        Mice[SelectedMouse].Enabled := true
        CurrentMouse := SelectedMouse
        ; Update menu to show enabled state
        Menu, Tray, Check, %SelectedMouse%
        
        ; Update tray tip
        Menu, Tray, Tip, Mouse Switcher`nActive: %SelectedMouse%
    }
return

; Disable a mouse device
DisableMouse(DeviceID) {
    ; Use devcon.exe or PowerShell to disable the device
    ; Try PowerShell first (more likely to be available)
    try {
        RunWait, powershell.exe -Command "Disable-PnpDevice -InstanceId '%DeviceID%' -ErrorAction SilentlyContinue", , Hide
    } catch {
        ; Fallback to devcon if available
        if (FileExist("devcon.exe")) {
            RunWait, devcon.exe disable "%DeviceID%", , Hide
        }
    }
}

; Enable a mouse device
EnableMouse(DeviceID) {
    ; Use devcon.exe or PowerShell to enable the device
    ; Try PowerShell first (more likely to be available)
    try {
        RunWait, powershell.exe -Command "Enable-PnpDevice -InstanceId '%DeviceID%' -ErrorAction SilentlyContinue", , Hide
    } catch {
        ; Fallback to devcon if available
        if (FileExist("devcon.exe")) {
            RunWait, devcon.exe enable "%DeviceID%", , Hide
        }
    }
}

; No action handler for menu items that don't do anything
NoAction:
return

; Exit the script
ExitScript:
    ExitApp
return

; ; Hotkey to refresh mice (Ctrl+Alt+M)
; ^!m::RefreshMice()

; ; Hotkey to exit (Ctrl+Alt+X)
; ^!x::ExitScript()
