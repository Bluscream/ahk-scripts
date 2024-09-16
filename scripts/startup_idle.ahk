#Persistent
#SingleInstance Force
; #NoEnv

#Include <bluscream>
global no_ui := false

SetTimer, CheckCPUusage, 1000 ; Check every second

CheckCPUusage:
    ; GetCpuLoudClip := GetCpuLoudClip()
    ; scriptlog("GetCpuLoudClip: " . GetCpuLoudClip . "%")
    GetCpuLoad := GetCpuLoad()
    scriptlog("GetCpuLoad: " . GetCpuLoad . "%")
    GetCpuUsage := GetCpuUsage()
    scriptlog("GetCpuUsage: " . GetCpuUsage . "%")
    GetAccurateCpuUsage := GetAccurateCpuUsage()
    scriptlog("GetAccurateCpuUsage: " . GetAccurateCpuUsage . "%")
    ; if (cpuUsage < 40)
    ; {
    ;     Run, notepad
    ;     ExitApp
    ; }
    return
; GetCpuLoudClip() {
;     ClipAll = %ClipBoardAll%
;     runwait, cmd.exe /c wmic cpu get loadpercentage | clip,, hide
;     loop, parse, Clipboard, `n, `r
;         if (A_Index = 3)
;             cpuLoadPC := A_LoopField, break
;     ClipBoard := ClipAll
;     return cpuLoadPC
; }
GetCpuLoad(period := 500) {
    total := GetSystemTimes(idle)
    Sleep, % period
    total2 := GetSystemTimes(idle2)
    Return 100*(1 - (idle2 - idle)/(total2 - total))
 }
 
 GetSystemTimes(ByRef IdleTime) {
    DllCall("GetSystemTimes", "Int64P", IdleTime, "Int64P", KernelTime, "Int64P", UserTime)
    Return KernelTime + UserTime
 }
GetCpuUsage() {
    static idleTime := 0, kernelTime := 0, userTime := 0
    DllCall("GetSystemTimes", "Int64*", idleTime, "Int64*", kernelTime, "Int64*", userTime)

    ; Calculate CPU usage based on system times
    cpuUsage := ((kernelTime + userTime - idleTime) / (kernelTime + userTime)) * 100

    return cpuUsage
}
GetAccurateCpuUsage() {
    ; Define the structure for PROCESS_BASIC_INFORMATION
    VarSetCapacity(PBIIterationCount, 4), PBIIterationCount := 0
    VarSetCapacity(ProcessBasicInformation, 24, 0)
    
    ; Open the current process
    handle := DllCall("OpenProcess", "UInt", 0x001F0FFF, "Bool", false, "Ptr", DllCall("GetCurrentProcess", "Ptr"))
    if (handle != 0) {
        ; Prepare the parameters for NtQueryInformationProcess
        DllCall("Ntdll.dll\NtQueryInformationProcess", "Ptr", handle, "UInt", 0, "Ptr", &ProcessBasicInformation, "UInt", 24)
        
        ; Extract the CPU usage from ProcessBasicInformation
        cpuUsage := NumGet(&ProcessBasicInformation, 8, "UInt") ; Assuming the CPU usage is stored here
        
        ; Close the handle
        DllCall("CloseHandle", "Ptr", handle)
        
        return cpuUsage
    } else {
        MsgBox, Failed to open process
        return 0
    }
}