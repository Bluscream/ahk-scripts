#singleinstance force 

Gui, Add, ListView, x2 y0 w400 h500, Name|PID|CPU
for process in ComObjGet("winmgmts:").ExecQuery("Select * from Win32_Process")
    LV_Add("", process.Name, process.processId,"...")
Gui, Show,, Process List

SetTimer, UpdateCpuUsage
Return

UpdateCpuUsage:
    Loop % LV_GetCount() {
        LV_GetText(pid, A_Index, 2)
        cpuUsage := Round(GetProcessTimes(pid)) "%"
        LV_Modify(A_Index, "Col3", cpuUsage)
    }
Return
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
; Return values
; -1 on first run 
; -2 if process doesn't exist or you don't have access to it
; Process cpu usage as percent of total CPU
GetProcessTimes(PID)    
{
    static aPIDs := []
    ; If called too frequently, will get mostly 0%, so it's better to just return the previous usage 
    if aPIDs.HasKey(PID) && A_TickCount - aPIDs[PID, "tickPrior"] < 250
        return aPIDs[PID, "usagePrior"] 

    DllCall("GetSystemTimes", "Int64*", lpIdleTimeSystem, "Int64*", lpKernelTimeSystem, "Int64*", lpUserTimeSystem)
    if !hProc := DllCall("OpenProcess", "UInt", 0x400, "Int", 0, "Ptr", pid)
        return -2, aPIDs.HasKey(PID) ? aPIDs.Remove(PID, "") : "" ; Process doesn't exist anymore or don't have access to it.
    DllCall("GetProcessTimes", "Ptr", hProc, "Int64*", lpCreationTime, "Int64*", lpExitTime, "Int64*", lpKernelTimeProcess, "Int64*", lpUserTimeProcess)
    DllCall("CloseHandle", "Ptr", hProc)
    
    if aPIDs.HasKey(PID) ; check if previously run
    {
        ; find the total system run time delta between the two calls
        systemKernelDelta := lpKernelTimeSystem - aPIDs[PID, "lpKernelTimeSystem"] ;lpKernelTimeSystemOld
        systemUserDelta := lpUserTimeSystem - aPIDs[PID, "lpUserTimeSystem"] ; lpUserTimeSystemOld
        ; get the total process run time delta between the two calls 
        procKernalDelta := lpKernelTimeProcess - aPIDs[PID, "lpKernelTimeProcess"] ; lpKernelTimeProcessOld
        procUserDelta := lpUserTimeProcess - aPIDs[PID, "lpUserTimeProcess"] ;lpUserTimeProcessOld
        ; sum the kernal + user time
        totalSystem :=  systemKernelDelta + systemUserDelta
        totalProcess := procKernalDelta + procUserDelta
        ; The result is simply the process delta run time as a percent of system delta run time
        result := 100 * totalProcess / totalSystem
    }
    else result := -1

    aPIDs[PID, "lpKernelTimeSystem"] := lpKernelTimeSystem
    aPIDs[PID, "lpUserTimeSystem"] := lpUserTimeSystem
    aPIDs[PID, "lpKernelTimeProcess"] := lpKernelTimeProcess
    aPIDs[PID, "lpUserTimeProcess"] := lpUserTimeProcess
    aPIDs[PID, "tickPrior"] := A_TickCount
    return aPIDs[PID, "usagePrior"] := result 
}