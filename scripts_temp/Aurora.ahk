#Include <bluscream>
#SingleInstance, Force
#NoTrayIcon
#Persistent
#NoEnv

global ghub := new Window("Logitech G HUB", "Chrome_WidgetWin_1", "lghub.exe")
global aurora := new Window("Aurora", "HwndWrapper[Aurora.exe;;9846a0d7-58e7-4561-8a43-ba42ed696eba]", "Aurora.exe")
global cpu_percent_max := 80

global aurora_suspended := false

; SetTimer, runChecks, 1000

; Return

; while(true) {
runChecks() {
  pid_ghub := ProcessExists(ghub.exe)
  pid_aurora := ProcessExists(aurora.exe)
  if (pid_ghub && pid_aurora) {
    cpu_percent := CPULoad()
    if (!aurora_suspended) {
        if (cpu_percent > cpu_percent_max) {
            Sleep 5000
            if (CPULoad() > cpu_percent_max) {
                SuspendAurora(pid_aurora)
            }
        }
        ; scriptlog("CPU: " . cpu_percent . "%")    
    } else if (aurora_suspended) {
        if (cpu_percent < cpu_percent_max) {
            Sleep 5000
            if (CPULoad() < cpu_percent_max) {
                SuspendAurora(pid_aurora, true)
            }
        }
    }
  } else if (pid_ghub) {
      Sleep 15000
      Run, "C:\Program Files\Aurora\Aurora.exe" -silent
  }
  Sleep 1000
}
SuspendAurora(pid, resume = false) {
    ; scriptlog(aurora_suspended)
    ; scriptlog(!resume)
    aurora_suspended := !resume
    ; scriptlog(aurora_suspended)
    ret := Process_Suspend(pid, resume)
    SplashScreen((ret ? "Failed to " : "") . (resume ? "Resume" : "Suspend") . (ret ? "" : "ed") . " " . aurora.title, "", 5000)
}

<^>!a::
    pid := ProcessExists(aurora.exe)
    if (aurora_suspended) {
        SetTimer, runChecks, 1000
        SuspendAurora(pid, true)
    } else {
        SetTimer, runChecks, Off
        SuspendAurora(pid)
        
    }