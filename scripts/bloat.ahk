#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
#Include <bluscream>
global noui := true



global bloat := { services: ["battlenet_helpersvc","AcrSch2Svc","mmsminisrv","aakore","AcronisActiveProtectionService","MSI_Case_Service","MSI_VoiceControl_Service","MSI_Central_Service","ALDITALKVerbindungsassistent_Service","DSAUpdateService","DSAService","LGHUBUpdaterService","GlassWire","MBAMService","FoxitReaderUpdateService","EABackgroundService"]
    ,processes: ["Agent","Battle.net","CCleaner64","adp-agent","aakore","anti_ransomware_service","bt","ShareX","tomcat8","TecnoManager","PowerToys.PowerOCR","msiexec","msedge","GalaxyClient Helper","GalaxyClient","MSI_Central_Service","MSI_Case_Service","MSI.TerminalServer","MSI.CentralServer","CC_Engine_x64","DCv2","DCv2_Startup","MSI Center","browser_assistant","Overwolf","OverwolfBrowser","OverwolfBrowser","OverwolfBrowser","OverwolfHelper","OverwolfHelper64","OverwolfTSHelper","MEGAsync","ALDITALKVerbindungsassistent_Launcher","ALDITALKVerbindungsassistent_Service","DSATray", "CefSharp.BrowserSubprocess","lghub_updater","GlassWire","vsls-agent","webhelper","vrwebhelper","winginx","memcached","mongod","mysqld","redis-server","updatechecker","WindowMenuPlus","WindowMenuPlus64","gamesense-discord-x64","SteelSeriesEngine","SteelSeriesGGClient","SteelSeriesGG","SteelSeriesPrismSync","TECKNET wireless gaming mouse","RaiDrive","CompactGUI","DiskDefrag","TabReports","TabMakePortable","TabCareCenter","Integrator","ActionCenter","AnyDeskMSI","DiscordCanary","GoogleDriveFS","PowerToys.AlwaysOnTop","fdm"]
    ,tasks: ["AuroraStartup","GoogleUpdateTaskMachineCore","GoogleUpdateTaskMachineUA","MicrosoftEdgeUpdateTaskMachineCore","MicrosoftEdgeUpdateTaskMachineUA","OneDrive Per-Machine Standalone Update Task","Onward Custom Map Sync","Paranoid-SafetyNet","\Microsoft\VisualStudio\VSIX Auto Update"]
    ,custom: [] }    

global semibloat := { services: ["AnyDesk","DisplayFusionService","CloudflareWARP","RaiDrive.Service","TeraCopyService","Parsec","AnyDeskMSI","TeamViewer","ZeroTierOneService","Adguard Home","aghome","fpsVR Service - CPU Temperature Counter"] ;
    ,processes: ["AnyDeskMSI","PAD.Console.Host","fritzbox-usb-fernanschluss","displayfusionhookapp64","displayfusionhookapp32","displayfusion","DisplayFusionService","PowerToys.PowerOCR","PowerToys.Peek.UI","PowerToys.KeyboardManagerEngine","PowerToys.CropAndLock","PowerToys.AlwaysOnTop","PAD.Console.Host","Cloudflare WARP","warp-svc","RaiDrive.Service.x64","TeraCopyService","VRCX","parsecd","zerotier_desktop_ui","zerotier-one_x64","AnyDeskMSI","nginx","php-cgi","EarTrumpet","mbamtray","Telegram","TrafficMonitor","WhatsApp","wingetui"] ; "Playnite.DesktopApp",
    ,tasks: []
    ,custom: [] }

global winbloat := { services: ["LmsaWindowsService","wuauserv","TapiSrv","Spooler","WSearch","EventLog","Schedule","WinHttpAutoProxySvc","wercplsupport","PcaSvc","wscsvc","SstpSvc","OneSyncSvc_57c4d"]
    ,processes: ["SearchIndexer","MoUsoCoreWorker","SettingSyncHost","StartMenuExperienceHost","SettingSyncHost","TextInputHost","mbamtray","mmc","msiexec","FileCoAuth","dasHost","dllhost","GameBarPresenceWriter","IpOverUsbSvc","EoAExperiences","conhost","cmd"] ; "OneDrive"
    ,tasks: []
    ,custom: [] }

global vrbloat := { services: ["vorpX Service","OVRLibraryService","OVRService","Steam Client Service"]
    ,processes: ["vorpService","vrwebhelper","vrdashboard","vrmonitor","vrcompositor","vrserver","OVRRedir","OVRServer_x64","OVRServiceLauncher"]
    ,tasks: []
    ,custom: [] }

global vd := { services: ["VirtualDesktop.Service.exe"]
    ,processes: ["VirtualDesktop.Server","VirtualDesktop.Streamer"]
    ,tasks: []
    ,custom: [] }

global cmd := { services: []
    ,processes: ["WindowsTerminal","powershell","powershell_ise","conhost","cmd"]
    ,tasks: []
    ,custom: [] }

global explorer := { services: []
    ,processes: ["retrobar","explorer","StartMenu"]
    ,tasks: []
    ,custom: [] }

global ahk := { services: []
    ,processes: ["AutoHotkeyV2x64","AutoHotkeyV2x86","AutoHotkeyA32","AutoHotkeyU32","AutoHotkey","AutoHotkeyUX","AutoHotkeyU64"]
    ,tasks: []
    ,custom: [] }

global anticheat := { services: ["PnkBstrA","BEService","EasyAntiCheat_EOS","EasyAntiCheat"]
    ,processes: ["PnkBstrA","BEService_bsquad","BEService","EasyAntiCheat","EasyAntiCheat_launc"]
    ,tasks: []
    ,custom: [] }

global important := { services: ["DisplayFusionService","cbdhsvc_14aa56","Adguard Service","BoxToGoRC","DiagTrack","OpenRGB","Everything","EFS","Wallpaper Engine Service"]
    ,processes: ["DisplayFusionService","DisplayFusion","DisplayFusionHookApp64","DisplayFusionHookApp32","Everything","java","javaw","NVIDIA RTX Voice","CCUpdate","AdguardSvc","Adguard","EpicWebHelper","EpicGamesLauncher","Twinkle Tray","SuperF4","BoxToGoRCService","RetroBar","OpenRGB","RestartOnCrash","usbdeview","wallpaper64","wallpaper32","webwallpaper32"]
    ,tasks: []
    ,custom: [] }

global whitelist := { services: []
    ,processes: ["Adguard","AdguardSvc","AltDrag","ApplicationFrameHost","audiodg","AutoHotkey","backgroundTaskHost","BattleBit","bitsumsessionagent","BoxToGoRC","csrss","ctfmon","dasHost","Discord","dwm","EOSOverlayRenderer-Win64-Shipping","Everything","explorer","FanControl","fontdrvhost","GameOverlayUI","HASS.Agent","HASS.Agent.Satellite.Service","helperservice","jhi_service","LsaIso","lsass","mDNSResponder","Memory Compression","msedgewebview2","MsMpEng","nssm","OpenRGB","PhonerLite","PnkBstrA","PowerToys","PowerToys.KeyboardManagerEngine","PowerToys.Peek.UI","PowerToys.PowerLauncher","ProcessGovernor","ProcessLasso","RaiDrive.Service.x64","Registry","RestartOnCrash","RetroBar","Ripcord","RstMwService","RtkAudUService64","rundll32","RuntimeBroker","SearchHost","Secure System","SecurityHealthService","services","SgrmBroker","ShellExperienceHost","sihost","smss","SoundSwitch","srvstub","StartMenu","StartMenuExperienceHost","steam","steamwebhelper","SuperF4","svchost","System","SystemSettings","taskhostw","TextInputHost","Twinkle Tray","uhssvc","usbdeview","UserOOBEBroker","wallpaper32","wallpaperservice32_c","webwallpaper32","Widgets","WidgetService","wininit","winlogon","WmiPrvSE","WMIRegistrationService","WUDFHost"]
    ,tasks: []
    ,custom: [] }

; Process name,User,PID,Status,Rules,Priority class,CPU groups,CPU affinity,CPU sets,CPU (%),CPU avg,Threads,ProBalance time,CPU time,I/O delta,I/O priority,Memory priority,Memory (commit size),Memory (private working set),Memory (private bytes),Memory (working set),Handles,Page faults per interval,Page Faults (PF),Creation time,Parent,Application name [claimed],Publisher [claimed],Description [claimed],Filename,Command line


for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/doublecheck") {
        scriptlog("Double checking enabled (" . param . ")")
        vd.safe_mode := true
    } else if (param == "/min" || param == "/perf") {
        scriptlog("Performance mode enabled (" . param . ")")
        perf_mode := true
        steam.uri := steam.uri_minicon
    } else if (param == "/bloat") {
        KillBloat()
    } else if (param == "/semibloat") {
        KillSemiBloat()
    } else if (param == "/explorer") {
        KillExplorer()
    } else if (param == "/ahk") {
        KillScripts()
    } else if (param == "/cmd") {
        KillCmd()
    } else if (param == "/all") {
        KillNotWhitelisted(whitelist.processes)
    } else if (param == "/mybloat") {
        KillBloat(true)
        KillSemiBloat(true)
        KillAntiCheat()
        KillCmd()
    } else if (param == "/kill") {
        CloseScript("bloat.ahk")
    }
}
ExitApp
return

RunBatch(batch, name:="UNBLOAT") {
    scriptlog("[" . name . "] Stopping " . batch.services.Count() . " services")
    StopServices(batch.services, True)
    scriptlog("[" . name . "] Ending " . batch.tasks.Count() . " tasks")
    EndTasks(batch.tasks, True)
    scriptlog("[" . name . "] Killing " . batch.processes.Count() . " processes")
    KillProcesses(batch.processes, True)
    scriptlog("[" . name . "] Running " . batch.custom.Count() . " commands")
    RunWaitLast(batch.custom, True)
}

KillBloat(skip := false) {
    RunBatch(bloat, "BLOAT")
    if (!skip) {
        Msgbox 4, KILL WIN STUFF, Are you sure?
        IfMsgBox No
            Return
    }
    RunBatch(winbloat, "WINBLOAT")
}

KillSemiBloat(skip := false) {
    RunBatch(semibloat, "SEMIBLOAT")
    if (!skip) {
        Msgbox 4, KILL VR STUFF, Are you sure?
        IfMsgBox No
            Return
    }
    RunBatch(vrbloat, "VRBLOAT")
    if (skip)
        Return
    Msgbox 4, KILL Virtual Desktop, Are you sure?
    IfMsgBox No
        Return
    CloseScript("vr.ahk")
    RunBatch(vd, "VIRTUAL DESKTOP")
    Msgbox 4, KILL EVERYTHING, Are you sure?
    IfMsgBox No
        Return
    RunBatch(important, "IMPORTANT")
}

KillScripts() {
    RunBatch(ahk, "AHK")
}

KillAntiCheat() {
    RunBatch(anticheat, "AntiCheat")
}

KillCMD() {
    RunBatch(cmd, "CMD")
}

KillExplorer() {
    RunBatch(explorer, "EXPLORER")
}

KillNotWhitelisted(list) {
    ; Process, Exist
    ; pid := ErrorLevel
    ; WinGet, id, list, ahk_pid %pid%
    ; Loop, %id%
    ; {
    ;     StringSplit, word, id%A_Index%, `;
    ;     If Not InStr(list, word1)
    ;     {
    ;         Process, Close, %word1%
    ;     }
    ; }
}
