#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
SendMode, InputThenPlay ; Event|Play|Input|InputThenPlay
OnExit("ExitFunc")
#Include <bluscream>
; EnforceAdmin()
#Include <logtail>
global noui := false
scriptlog("init start")
global enabled := false
global interval := 1000

global fivemdir := new Paths.User().localappdata.Combine("FiveM")
global windows := {}
windows["game"] := new Window("FiveM", "grcWindow", "FiveM_b2189_GTAProcess.exe", fivemdir.CombineFile("\data\cache\subprocess\FiveM_b2189_GTAProcess.exe").path)
windows["loading"] := new Window("FiveM", "NotSteamAtAll", "FiveM.exe", fivemdir.CombineFile("FiveM.exe").path)

global servers := {}
servers["truelife"] := {}
servers["truelife"]["title"] := "FiveM - [GERMAN] 🌪️ TRUELIFE Roleplay | ✅ One-Click Allowlist | 👮 Cops 😎 Gangs & 👩‍⚕️ Medics gesucht! | 💣 AntiCheat | 🔊 SaltyChat | 🎉 Events | 💊 Illegale/Legale Routen | 🚗 Modded Cars | 🔥 Performance"
servers["truelife"]["code"] := "9o3ray"
scriptlog(toJson(servers, true))
global log := 0
initLog()

Menu, tray, add,

for k, server in servers {
    if (server.code)
        Menu, tray, add, % "Connect to " . k, Connect
}

if windows.loading.file.exists() {
    Menu, Tray, Icon, % windows.loading.file.path
}

scriptlog("init end")
return

; F6::toggle()
return


ExitFunc(reason, code) {
    scriptlog("OnExit")
    log.Delete()
    return
}

initLog() {
    log.Delete()
    logfile := fivemdir.Combine("FiveM.app\logs").getNewestFile("*.log")
    if (logfile.exists()) {
        log := new LogTailer(logfile.path, Func("OnNewLogLine"), false, "UTF-8", "`r`n") ; , "CP28591", "`n")
        log.Stop()
        log.Start()
        ; log := StdOutStream("tail " . Quote(logfile.path), "OnNewLogLine" ) 
        scriptlog("subscribed to log file " . logfile.Quote() . " (" . log . ")")
    }
    return
}
OnNewLogLine(FileLine, n) {
    scriptlog("OnNewLogLine")
    if (!FileLine)
        return
    scriptlog(FileLine)
}

Connect() {
    txt := StrReplace(A_ThisMenuItem, "Connect to ", "")
    server := servers[txt]
    _SplashScreen(server.title, A_ThisMenuItem, 2500)
    windows.loading.file.run(false, "", "fivem://connect/cfx.re/join/" . server.code)
}

toggle() {
    if (!enabled) {
        enabled := true
        CreateInterval()
        SetTimer, runChecks, % interval
        scriptlog("enabled")
    } else {
        enabled := false
        SetTimer, runChecks, Off
        scriptlog("disabled")
    }
    return
}
runChecks() {
    scriptlog("pressing with sendmode " . A_SendMode)
    ;PressKey(key, presses=1, sleepms=80, keyms=20, verbose=false, msg="", raw=false) {
    ; PressKey("E", 1, 80, 20, false, "", true)
    Send {Raw}e
    ; PressKeyDLL("e", 1, 60)
    interval = CreateInterval()
    return
}
CreateInterval() {
    Random, interval, 500, 1500
    scriptlog("New interval: " . interval)
    return interval
}