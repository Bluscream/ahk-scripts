#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
#Include <bluscream>
global noui := false

global bloat := { services: [ "EasyAntiCheat_EOS","MSI_Case_Service","MSI_VoiceControl_Service","MSI_Central_Service","ALDITALKVerbindungsassistent_Service","DSAUpdateService","DSAService","LGHUBUpdaterService","Wallpaper Engine Service","GlassWire","MBAMService","FoxitReaderUpdateService","EABackgroundService"]
    ,processes: ["bt","ShareX","tomcat8","TecnoManager","PowerToys.PowerOCR","msiexec","msedge","GalaxyClient Helper","GalaxyClient","MSI_Central_Service","MSI_Case_Service","MSI.TerminalServer","MSI.CentralServer","CC_Engine_x64","DCv2","DCv2_Startup","MSI Center","browser_assistant","Overwolf","OverwolfBrowser","OverwolfBrowser","OverwolfBrowser","OverwolfHelper","OverwolfHelper64","OverwolfTSHelper","MEGAsync","ALDITALKVerbindungsassistent_Launcher","ALDITALKVerbindungsassistent_Service","Playnite.DesktopApp","DSATray", "CefSharp.BrowserSubprocess","lghub_updater","wallpaper64","GlassWire","vsls-agent","webhelper","vrwebhelper","winginx","memcached","mongod","mysqld","redis-server","updatechecker","WindowMenuPlus","WindowMenuPlus64","wingetui","gamesense-discord-x64","SteelSeriesEngine","SteelSeriesGGClient","SteelSeriesGG","SteelSeriesPrismSync","TECKNET wireless gaming mouse","RaiDrive","CompactGUI","DiskDefrag","TabReports","TabMakePortable","TabCareCenter","Integrator","ActionCenter","AnyDeskMSI"]
    ,tasks: ["AuroraStartup","GoogleUpdateTaskMachineCore","GoogleUpdateTaskMachineUA","MicrosoftEdgeUpdateTaskMachineCore","MicrosoftEdgeUpdateTaskMachineUA","OneDrive Per-Machine Standalone Update Task","Onward Custom Map Sync","Paranoid-SafetyNet","\Microsoft\VisualStudio\VSIX Auto Update"]
    ,custom: [] }

global winbloat := { services: ["LmsaWindowsService","wuauserv","TapiSrv","Spooler","WSearch","EventLog","Schedule","WinHttpAutoProxySvc","wercplsupport","PcaSvc","wscsvc","SstpSvc","OneSyncSvc_57c4d"]
    ,processes: ["SearchIndexer","MoUsoCoreWorker","SettingSyncHost","StartMenuExperienceHost","SettingSyncHost","TextInputHost","mbamtray","mmc","msiexec","FileCoAuth","OneDrive","dasHost","dllhost","GameBarPresenceWriter","IpOverUsbSvc","conhost","cmd"]
    ,tasks: []
    ,custom: [] }

global semibloat := { services: ["TeraCopyService.exe","Parsec","AnyDeskMSI","TeamViewer","ZeroTierOneService","Adguard Home","aghome","BEService","EasyAntiCheat","fpsVR Service - CPU Temperature Counter"] ; "OVRLibraryService","OVRService","Steam Client Service","VirtualDesktop.Service.exe", "Adguard Service"
    ,processes: [ "TeraCopyService.exe","VRCX","parsecd","zerotier_desktop_ui","zerotier-one_x64","AnyDeskMSI","nginx","php-cgi","Playnite.DesktopApp"] ; "Adguard", "VirtualDesktop.Service","VirtualDesktop.Streamer.exe"
    ,tasks: []
    ,custom: [] }


global vrbloat := { services: ["vorpX Service","OVRLibraryService","OVRService","Steam Client Service"]
    ,processes: [ "vorpService","vrwebhelper","vrdashboard","vrmonitor","vrcompositor","vrserver","OVRRedir","OVRServer_x64","OVRServiceLauncher"]
    ,tasks: []
    ,custom: [] }

global vd := { services: ["VirtualDesktop.Service.exe"]
    ,processes: [ "VirtualDesktop.Server","VirtualDesktop.Streamer"]
    ,tasks: []
    ,custom: [] }

global cmd: { services: []
    ,processes: ["conhost","cmd"]
    ,tasks: []
    ,custom: [] }

global ahk: { services: []
    ,processes: ["AutoHotkeyV2x64","AutoHotkeyV2x86","AutoHotkeyA32","AutoHotkeyU32","AutoHotkey","AutoHotkeyUX","AutoHotkeyU64"]
    ,tasks: []
    ,custom: [] }

global important := { services: ["RaiDrive.Service","cbdhsvc_14aa56","Adguard Service","BoxToGoRC","DiagTrack","OpenRGB","Everything","EFS"]
,processes: [ "RaiDrive.Service.x64","Everything","java","javaw","NVIDIA RTX Voice","CCUpdate","AdguardSvc","Adguard","EpicWebHelper","EpicGamesLauncher","Twinkle Tray","SuperF4","BoxToGoRCService","RetroBar","OpenRGB" ]
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
    } else if (param == "/explorer") {
        KillExplorer()
        ExitApp
    } else if (param == "/ahk") {
        KillScripts()
        ExitApp
    } else if (param == "/cmd") {
        KillCmd()
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
    Msgbox 4, KILL WIN STUFF, Are you sure?
    IfMsgBox No
        Return
    scriptlog("[UNBLOAT] Stopping " . winbloat.services.Count() . " services")
    StopServices(winbloat.services, True)
    scriptlog("[UNBLOAT] Ending " . winbloat.tasks.Count() . " tasks")
    EndTasks(winbloat.tasks, True)
    scriptlog("[UNBLOAT] Killing " . winbloat.processes.Count() . " processes")
    KillProcesses(winbloat.processes, True)
    scriptlog("[UNBLOAT] Running " . winbloat.custom.Count() . " commands")
    RunWaitLast(winbloat.custom, True)
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
    Msgbox 4, KILL Virtual Desktop, Are you sure?
    IfMsgBox No
        Return
    CloseScript("vr.ahk")
    scriptlog("[UNBLOAT] Stopping " . vd.services.Count() . " services")
    StopServices(vd.services, True)
    scriptlog("[UNBLOAT] Ending " . vd.tasks.Count() . " tasks")
    EndTasks(vd.tasks, True)
    scriptlog("[UNBLOAT] Killing " . vd.processes.Count() . " processes")
    KillProcesses(vd.processes, True)
    scriptlog("[UNBLOAT] Running " . vd.custom.Count() . " commands")
    RunWaitLast(vd.custom, True)
    Msgbox 4, KILL EVERYTHING, Are you sure?
    IfMsgBox No
        Return
    scriptlog("[UNBLOAT] Stopping " . important.services.Count() . " services")
    StopServices(important.services, True)
    scriptlog("[UNBLOAT] Ending " . important.tasks.Count() . " tasks")
    EndTasks(important.tasks, True)
    scriptlog("[UNBLOAT] Killing " . important.processes.Count() . " processes")
    KillProcesses(important.processes, True)
    scriptlog("[UNBLOAT] Running " . important.custom.Count() . " commands")
    RunWaitLast(important.custom, True)
}

KillScripts() {
    scriptlog("[UNBLOAT] Stopping " . ahk.services.Count() . " services")
    StopServices(ahk.services, True)
    scriptlog("[UNBLOAT] Ending " . ahk.tasks.Count() . " tasks")
    EndTasks(ahk.tasks, True)
    scriptlog("[UNBLOAT] Killing " . ahk.processes.Count() . " processes")
    ; RunWaitLast(ahk.processes, "taskkill /f /im """, """")
    KillProcesses(ahk.processes, True)
    scriptlog("[UNBLOAT] Running " . ahk.custom.Count() . " commands")
    RunWaitLast(ahk.custom, True)
}

KillCMD() {
    scriptlog("[UNBLOAT] Stopping " . cmd.services.Count() . " services")
    StopServices(cmd.services, True)
    scriptlog("[UNBLOAT] Ending " . cmd.tasks.Count() . " tasks")
    EndTasks(cmd.tasks, True)
    scriptlog("[UNBLOAT] Killing " . cmd.processes.Count() . " processes")
    ; RunWaitLast(ahk.processes, "taskkill /f /im """, """")
    KillProcesses(cmd.processes, True)
    scriptlog("[UNBLOAT] Running " . cmd.custom.Count() . " commands")
    RunWaitLast(cmd.custom, True)
}

KillExplorer() {
    KillProcesses(["retrobar","explorer","StartMenu"])
}