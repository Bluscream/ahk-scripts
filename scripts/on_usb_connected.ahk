; #Include <bluscream>

;                      "disconnect",
; device_name:         "Port_#0001.Hub_#0006",
; device_desc:         "USB Composite Device",
; drive:               "",
; serial_number:       "1WMHH820XS0451",
; vid:                 "10291",
; pid:                 "390",
; vid_hex:             "2833",
; pid_hex:             "0186",
; device_type:         "Unknown",
; service_name:        "usbccgp",
; device_class:        "",
; device_mfg:          "(Standard USB Host Controller)",
; driver_file:         "\\SystemRoot\\System32\\drivers\\usbccgp.sys",
; driver_version:      "10.0.22621.1194",
; power:               "0",
; firmware_revision:   "4.19",
; product_name:        "",
; vendor_name:         "",
; usb_version:         "2.10"

if (A_Args[1] == "connect") {
    ; MsgBox % toJson(A_Args)
    if (A_Args[5] == "1WMHH820XS0451")
        runAdbCommand("shell am broadcast -a com.oculus.vrpowermanager.prox_close")
}

Return

runAdbCommand(cmd) {
    RunWait, % ComSpec " /c adb " . cmd, , Hide UseErrorLevel, AdbResult
    if ErrorLevel {
        MsgBox % A_Args[3] . " found, but adb command failed."
    } else {
        MsgBox % A_Args[3] . " found and adb command executed."
    }
}


; ; #warn
; global no_ui := false
; global aa
; searchfor:="1WMHH820XS0451"
; OnMessage(0x219, "notify_change")
; notify_change(wParam, lParam, msg, hwnd)
; {
; SetTimer,DV,1000 
; }
; return
; ;-----------------------------------
; DV:
; sleep,2000
; i=0
; e:=""
; for device in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_PnPEntity")
; {
;   scriptlog("name=" . device.name . " description=" . device.description)
;   If InStr(device.serial,searchfor)
;    {
;    settimer,DV,off
;    i++  
;    aa:=device.name
;    e .= i . "--" . aa . "`r`n"
;    }
; }
; settimer,DV,off
; aa:=""
; if e<>
;  msgbox, 262208,DEVICES ,%e%
; e:=""
; Return
; ;-----------
; esc::exitapp
; ;==========================================
; #Persistent
; SetTimer, CheckUSB, 1000

; CheckUSB:
; RunWait, % ComSpec " /c wmic path Win32_USBControllerDevice get DeviceName, DeviceID", , Hide UseErrorLevel, CheckUSBResult
; if ErrorLevel {
;     return
; }
; deviceName := CheckUSBResult1
; deviceID := CheckUSBResult2

; if (deviceName == "Quest 2" or deviceID == "USB\VID_2833&PID_0183&MI_00") {

; } else {
;     return
; }

