#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
#Include <bluscream>
global noui := false

global bloat := { services: ["ALDITALKVerbindungsassistent_Service","DSAUpdateService","DSAService","wercplsupport","PcaSvc","wscsvc","SstpSvc","WSearch","EventLog","Schedule","OneSyncSvc_57c4d","Everything","EFS","LGHUBUpdaterService","Wallpaper Engine Service","GlassWire","MBAMService","FoxitReaderUpdateService","WinHttpAutoProxySvc","EABackgroundService"]
    ,processes: ["browser_assistant.exe","Overwolf","OverwolfBrowser","OverwolfBrowser","OverwolfBrowser","OverwolfHelper","OverwolfHelper64","OverwolfTSHelper","MEGAsync","ALDITALKVerbindungsassistent_Launcher","ALDITALKVerbindungsassistent_Service","Playnite.DesktopApp","OpenRGB","DSATray", "CefSharp.BrowserSubprocess", "SearchIndexer","lghub_updater","wallpaper64","GlassWire","Everything","MoUsoCoreWorker","SettingSyncHost","StartMenuExperienceHost","SettingSyncHost","vsls-agent","TextInputHost","mbamtray","mmc","msiexec","FileCoAuth","webhelper","vrwebhelper","OneDrive","dasHost","dllhost","GameBarPresenceWriter","IpOverUsbSvc","winginx","memcached","mongod","mysqld","redis-server","updatechecker","WindowMenuPlus","WindowMenuPlus64","conhost","cmd"]
    ,tasks: ["AuroraStartup","GoogleUpdateTaskMachineCore","GoogleUpdateTaskMachineUA","MicrosoftEdgeUpdateTaskMachineCore","MicrosoftEdgeUpdateTaskMachineUA","OneDrive Per-Machine Standalone Update Task","Onward Custom Map Sync","Paranoid-SafetyNet","\Microsoft\VisualStudio\VSIX Auto Update"]
    ,custom: [] }

global semibloat := { services: ["Parsec","AnyDeskMSI","TeamViewer","ZeroTierOneService","Adguard Home","aghome","BEService","EasyAntiCheat","fpsVR Service - CPU Temperature Counter","OpenRGB"] ; "OVRLibraryService","OVRService","Steam Client Service","VirtualDesktop.Service.exe", "Adguard Service"
    ,processes: [ "parsecd","zerotier_desktop_ui","zerotier-one_x64","AnyDeskMSI","BoxToGoRC","nginx","php-cgi","OpenRGB","Playnite.DesktopApp","VirtualDesktop.Service","VirtualDesktop.Streamer.exe"] ; "Adguard"
    ,tasks: []
    ,custom: [] }

global vrbloat := { services: ["vorpX Service","OVRLibraryService","OVRService","Steam Client Service","VirtualDesktop.Service.exe"] 
    ,processes: [ "vorpService","vrwebhelper","vrdashboard","vrmonitor","vrcompositor","vrserver","OVRRedir","OVRServer_x64","OVRServiceLauncher","VirtualDesktop.Streamer","VirtualDesktop.Server"]
    ,tasks: []
    ,custom: [] }

for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/doublecheck") {
        scriptlog("Double checking enabled (" . param . ")")
        vd.safe_mode := true
    } else if (param == "/min" || param == "/perf") {
        scriptlog("Performance mode enabled (" . param . ")")
        perf_mode := truex
        steam.uri := steam.uri_minicon
    } else if (param == "/bloat") {
        KillBloat()
        ExitApp
    } else if (param == "/semibloat") {
        KillSemiBloat()
        ExitApp
    } else if (param == "/semibloat") {
        KillExplorer()
        ExitApp
    }
}

return

KillBloat() {
    scriptlog("[UNBLOAT] Stopping " . bloat.services.Count() . " services")
    StopServices(bloat.services, True)
    scriptlog("[UNBLOAT] Ending " . bloat.tasks.Count() . " tasks")
    EndTasks(bloat.tasks, True)
    scriptlog("[UNBLOAT] Killing " . bloat.processes.Count() . " processes")
    ; RunWaitLast(bloat.processes, "taskkill /f /im """, """")
    KillProcesses(bloat.processes, True)
    scriptlog("[UNBLOAT] Running " . bloat.custom.Count() . " commands")
    RunWaitLast(bloat.custom, True)
}

KillSemiBloat() {
    scriptlog("[UNBLOAT] Stopping " . semibloat.services.Count() . " services")
    StopServices(semibloat.services, True)
    scriptlog("[UNBLOAT] Ending " . semibloat.tasks.Count() . " tasks")
    EndTasks(semibloat.tasks, True)
    scriptlog("[UNBLOAT] Killing " . semibloat.processes.Count() . " processes")
    KillProcesses(semibloat.processes, True)
    scriptlog("[UNBLOAT] Running " . semibloat.custom.Count() . " commands")
    RunWaitLast(semibloat.custom, True)
    Msgbox 4, KILL VR STUFF, Are you sure?
    IfMsgBox No
        Return
    scriptlog("[UNBLOAT] Stopping " . vrbloat.services.Count() . " services")
    StopServices(vrbloat.services, True)
    scriptlog("[UNBLOAT] Ending " . vrbloat.tasks.Count() . " tasks")
    EndTasks(vrbloat.tasks, True)
    scriptlog("[UNBLOAT] Killing " . vrbloat.processes.Count() . " processes")
    KillProcesses(vrbloat.processes, True)
    scriptlog("[UNBLOAT] Running " . vrbloat.custom.Count() . " commands")
    RunWaitLast(vrbloat.custom, True)
}

KillExplorer() {
    KillProcesses(["retrobar","explorer","StartMenu"])
}