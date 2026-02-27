#NoEnv
#SingleInstance Force
#Persistent
SetWorkingDir %A_ScriptDir%

; Mouse Switcher Script using USBDeview
; Creates a tray menu to switch between mice by disabling all others when one is selected

global Mice := {}  ; Object to store mouse information
global CurrentMouse := ""  ; Currently active mouse
global USBDeviewPath := "D:\WSCC\Apps\USBDeview.exe"  ; Path to USBDeview executable

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
    
    ; Get all mice using USBDeview
    AllMice := GetAllMiceFromUSBDeview()
    
    MouseCount := 0
    for MouseName, MouseInfo in AllMice {
        MouseCount++
        
        ; Store mouse information
        Mice[MouseName] := MouseInfo
        
        ; Add to tray menu with status indicator
        MenuText := MouseName
        if (!MouseInfo.Enabled) {
            MenuText .= " (Disabled)"
        }
        Menu, Tray, Add, %MenuText%, MouseSelected
    }
    
    ; Add separator and exit option back
    Menu, Tray, Add
    Menu, Tray, Add, &Refresh Mice, RefreshMice
    Menu, Tray, Add, E&xit, ExitScript
    
    if (MouseCount = 0) {
        Menu, Tray, Add, No mice found, NoAction
    }
    
    ; Update tray tip
    Menu, Tray, Tip, Mouse Switcher (USBDeview)`n%MouseCount% mice detected
return

; Show debug information
ShowDebugInfo:
    DebugText := "=== Mouse Switcher Debug Info (USBDeview) ===`n`n"
    
    ; Get all mice using USBDeview
    AllMice := GetAllMiceFromUSBDeview()
    
    DebugText .= "Detected Mice:`n"
    DebugText .= "---------------`n"
    
    MouseCount := 0
    for MouseName, MouseInfo in AllMice {
        MouseCount++
        DebugText .= "Mouse " MouseCount ":`n"
        DebugText .= "  Name: " MouseName "`n"
        DebugText .= "  Description: " MouseInfo.Description "`n"
        DebugText .= "  VID/PID: " MouseInfo.VID ":" MouseInfo.PID "`n"
        DebugText .= "  Status: " MouseInfo.Status "`n"
        DebugText .= "  Enabled: " (MouseInfo.Enabled ? "Yes" : "No") "`n"
        DebugText .= "  Connected: " (MouseInfo.Connected ? "Yes" : "No") "`n"
        DebugText .= "`n"
    }
    
    if (MouseCount = 0) {
        DebugText .= "No mice detected.`n"
    }
    
    DebugText .= "=== End Debug Info ==="
    
    ; Show in a messagebox with copyable text
    MsgBox, 64, Mouse Switcher Debug Info, %DebugText%
return

; Parse CSV line with quoted fields (AHK v1 compatible)
ParseCSVLine(Line, ByRef Fields) {
    Fields := {}
    Field := ""
    InQuotes := false
    i := 1
    
    while (i <= StrLen(Line)) {
        Char := SubStr(Line, i, 1)
        
        if (Char = """") {
            if (InQuotes && i < StrLen(Line) && SubStr(Line, i + 1, 1) = """") {
                ; Escaped quote
                Field .= """"
                i += 2
            } else {
                ; Toggle quote state
                InQuotes := !InQuotes
                i += 1
            }
        } else if (Char = "," && !InQuotes) {
            ; Field separator
            Fields.Insert(Field)
            Field := ""
            i += 1
        } else {
            Field .= Char
            i += 1
        }
    }
    
    ; Add last field
    Fields.Insert(Field)
}

; Get all mice from USBDeview
GetAllMiceFromUSBDeview() {
    AllMice := {}
    
    ; Check if USBDeview exists
    if (!FileExist(USBDeviewPath)) {
        MsgBox, 48, Error, USBDeview.exe not found!`n`nPath: %USBDeviewPath%`n`nPlease download USBDeview from:`nhttps://www.nirsoft.net/utils/usb_devices_view.html
        return AllMice
    }
    
    ; Run USBDeview and export to CSV
    TempFile := A_Temp . "\usbdeview_output.txt"
    
    try {
        ; Export all USB devices to tab-separated file (easier to parse)
        RunWait, %USBDeviewPath% /stab "%TempFile%", , Hide
        
        ; Debug: Check if file was created
        if (!FileExist(TempFile)) {
            MsgBox, 48, Error, USBDeview failed to create output file!`n`nTemp file: %TempFile%
            return AllMice
        }
        
        ; Parse the output file
        FileRead, FileContent, %TempFile%
        
        ; Debug: Show first few lines of output
        if (FileContent = "") {
            MsgBox, 48, Error, USBDeview output file is empty!
            return AllMice
        }
        
        ; Split into lines and parse
        StringSplit, Lines, FileContent, `n
        
        ; Debug: Show header line
        MsgBox, 64, Debug, USBDeview found %Lines0% lines`n`nHeader: %Lines1%
        
        ; Skip header line
        Loop, %Lines0% {
            if (A_Index = 1) continue  ; Skip header
            
            Line := Trim(Lines%A_Index%)
            if (Line = "") continue
            
            ; Parse tab-separated line (much simpler)
            StringSplit, Fields, Line, `t
            
            if (Fields0 >= 13) {
                PortHub := Trim(Fields1)
                Description := Trim(Fields2)
                DeviceType := Trim(Fields3)
                Connected := (Trim(Fields4) = "Yes")
                Disabled := (Trim(Fields5) = "Yes")
                VID := Trim(Fields12)
                PID := Trim(Fields13)
                FriendlyName := Trim(Fields29)
                
                ; Check if this is a mouse device
                IsMouse := IsMouseDeviceUSBDeview(VID, PID, Description, DeviceType)
                
                if (IsMouse) {
                    ; Use friendly name if available, otherwise description
                    MouseName := (FriendlyName != "" && FriendlyName != "(Standard system devices)") ? FriendlyName : Description
                    
                    AllMice[MouseName] := Object("Name", PortHub, "Description", Description, "VID", VID, "PID", PID, "Status", Connected ? "Connected" : "Disconnected", "Enabled", !Disabled, "Connected", Connected, "DeviceType", DeviceType, "FriendlyName", FriendlyName)
                }
            }
        }
        
        ; Clean up temp file
        FileDelete, %TempFile%
    } catch e {
        MsgBox, 48, Error, Failed to run USBDeview: %e%
    }
    
    return AllMice
}

; Check if a device is a mouse based on USBDeview data
IsMouseDeviceUSBDeview(VID, PID, Description, DeviceType) {
    ; Convert VID to uppercase for comparison
    VID := SubStr(VID, 1) . SubStr(VID, 2)
    StringUpper, VID, VID
    
    ; Debug: Show the function parameters
    MsgBox, 64, Debug, Mouse check:`nVID: "%VID%"`nPID: "%PID%"`nDesc: "%Description%"`nType: "%DeviceType%"
    
    ; Skip keyboard devices
    if (InStr(Description, "Keyboard") || InStr(Description, "Keypad")) {
        return false
    }
    
    ; Skip non-HID devices that aren't mice
    if (!InStr(DeviceType, "HID") && !InStr(Description, "Mouse") && !InStr(Description, "Gaming") && !InStr(Description, "Prodigy")) {
        return false
    }
    
    ; Known mouse manufacturers
    if (VID = "046D") return true  ; Logitech
    if (VID = "1038") return true  ; SteelSeries
    if (VID = "30FA") return true  ; Zowie
    if (VID = "320F") return true  ; Razer
    if (VID = "1532") return true  ; Razer
    if (VID = "045E") return true  ; Microsoft
    if (VID = "093A") return true  ; A4Tech
    
    ; Check description for mouse indicators
    if (InStr(Description, "Mouse") || InStr(Description, "G203") || InStr(Description, "G305") || InStr(Description, "Rival") || InStr(Description, "Heated Gaming RGB")) {
        return true
    }
    
    return false
}

; Get friendly name from registry
GetFriendlyNameFromRegistry(VID, PID, DeviceName) {
    ; Try USB device first
    RegRead, USBName, HKEY_LOCAL_MACHINE, SYSTEM\CurrentControlSet\Enum\USB\VID_%VID%&PID_%PID%, FriendlyName
    if (!ErrorLevel && USBName != "") {
        return USBName
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
    
    return ""
}

; Handle mouse selection from tray menu
MouseSelected:
    ; Extract actual mouse name from menu text (remove "(Disabled)" suffix)
    SelectedMouse := A_ThisMenuItem
    if (InStr(SelectedMouse, " (Disabled)")) {
        StringLeft, SelectedMouse, SelectedMouse, InStr(SelectedMouse, " (Disabled)") - 1
    }
    
    ; If clicking the currently active mouse, do nothing
    if (SelectedMouse = CurrentMouse) {
        return
    }
    
    ; Disable all mice first
    for MouseName, MouseInfo in Mice {
        if (MouseName != SelectedMouse && MouseInfo.Enabled) {
            DisableMouseUSBDeview(MouseInfo.Name)
            MouseInfo.Enabled := false
        }
    }
    
    ; Enable the selected mouse
    if (Mice.HasKey(SelectedMouse)) {
        if (!Mice[SelectedMouse].Enabled) {
            EnableMouseUSBDeview(Mice[SelectedMouse].Name)
            Mice[SelectedMouse].Enabled := true
        }
        CurrentMouse := SelectedMouse
        
        ; Update tray tip
        Menu, Tray, Tip, Mouse Switcher (USBDeview)`nActive: %SelectedMouse%
    }
    
    ; Refresh menu to update status indicators
    gosub, RefreshMice
return

; Disable a mouse device using USBDeview
DisableMouseUSBDeview(DeviceName) {
    if (FileExist(USBDeviewPath)) {
        RunWait, %USBDeviewPath% /disable "%DeviceName%", , Hide
    }
}

; Enable a mouse device using USBDeview
EnableMouseUSBDeview(DeviceName) {
    if (FileExist(USBDeviewPath)) {
        RunWait, %USBDeviewPath% /enable "%DeviceName%", , Hide
    }
}

; No action handler for menu items that don't do anything
NoAction:
return

; Exit the script
ExitScript:
    ExitApp
return
