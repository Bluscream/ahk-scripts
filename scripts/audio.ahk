#Include <VA>
#Include <bluscream>
#SingleInstance, force
global no_ui = false
scriptlog("start")
OnExit("ExitFunc")
bool := false
; devices := VA_GetDevices(100)
; scriptlog(devices)
; for name, device in devices {
;     scriptlog(name . " | " . device)
; }
processes = [ new Process("voicemeeter8.exe")]
vm_devices := [ VA_GetDevice("VoiceMeeter Input"), VA_GetDevice("VoiceMeeter Aux Input"), VA_GetDevice("VoiceMeeter VAIO3 Input"), VA_GetDevice("VoiceMeeter Output"), VA_GetDevice("VoiceMeeter Aux Output"), VA_GetDevice("VoiceMeeter VAIO3 Output") ]
for i, device in vm_devices {
scriptlog(device . ": " . VA_GetDeviceName(device))
}

 
SetTimer, runChecks, 1000
Return
^s::VA_PlaybackDeviceState(device, bool := !bool)

runChecks:
    for i, process in processes {
        exists := process.exists()
        if (exists and !bool) {
            bool := true
            toggleAll(devices, true)
            return
        } else if (!exists and bool) {
            bool := false
            toggleAll(devices, false)
            return
        }
    }
    return

toggleAll(devices, state) {
    for i, device in devices {
        VA_PlaybackDeviceState(device, state)
    }
}

ExitFunc(ExitReason, ExitCode){
	Global device
	ObjRelease(device)
}