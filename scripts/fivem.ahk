; FiveM - [GER] SuspectLifeRP | Open-Beta | Eigene Häuser | Polizei/Medics | Discord Whitelist | Modded Autos | TS SaltyChat ahk_class grcWindow ahk_exe FiveM_GTAProcess.exe ahk_pid 48 
; Error GTA5.exe!sub_1407509EC (0x137) ahk_class #32770 ahk_exe FiveM_DumpServer ahk_pid 9124

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
; #Include <logtail>
CoordMode, Tooltip, Screen
global noui := true
global enabled := false
global interval := 1000

global fivemdir := new Paths.User().localappdata.Combine("FiveM")
global windows := {}
windows["game"] := new Window("FiveM", "grcWindow", "FiveM_b2189_GTAProcess.exe", fivemdir.CombineFile("\data\cache\subprocess\FiveM_b2189_GTAProcess.exe").path)
windows["loading"] := new Window("FiveM", "NotSteamAtAll", "FiveM.exe", fivemdir.CombineFile("FiveM.exe").path)

global eat_time_ms := 30 * 60000 ; 30 minutes
global drink_time_ms := 30 * 60000 ; 30 minutes
global bt_controller_idle_timer_ms := 4.5 * 60000 ; 5 minutes
global now_eat := A_TickCount
global now_drink := A_TickCount
global now_move := A_TickCount

; SetTimer, RemainingTimer, 1000
; SetTimer, MustEat, % eat_time_ms
; SplashScreen("Eat Timer Set", "Next eat time is in " . FormatMilliSeconds(eat_time_ms))
SetTimer, MustDrink, % drink_time_ms
SplashScreen("Eat & Drink Timer Set", "Next eat & drink time is in " . FormatMilliSeconds(drink_time_ms))
SetTimer, MustMove, % bt_controller_idle_timer_ms
SplashScreen("Move Timer Set", "Next move time is in " . FormatMilliSeconds(bt_controller_idle_timer_ms))
SetTimer, RemainingTimer, 1000
return

RemainingTimer:
    ToolTip, % "Eat: " . FormatSeconds((now_eat + eat_time_ms - A_TickCount)/1000) . "`nDrink: " . FormatSeconds((now_drink + eat_time_ms - A_TickCount)/1000) . "`nController: " . FormatSeconds((now_move + bt_controller_idle_timer_ms - A_TickCount)/1000), % 45, 40 ; % A_ScreenWidth/5.5, % A_ScreenHeight-40
    return

MustEat:
    ; SetTimer, MustEat, Off
    now_eat := A_TickCount
    SplashScreen("EAT", "MUST EAT NOW", 3000)
    Send {Raw}F2
    return
MustDrink:
    ; SetTimer, MustDrink, Off
    now_drink := A_TickCount
    SplashScreen("DRINK", "MUST DRINK NOW", 3000)
    Send {Raw}F2
    return
MustMove:
    ; SetTimer, MustDrink, Off
    now_move := A_TickCount
    SplashScreen("MOVE", "MUST MOVE CONTROLLER")
    Send {Raw}F2

; global servers := {}
; servers["truelife"] := {}
; servers["truelife"]["title"] := "FiveM - [GERMAN] 🌪️ TRUELIFE Roleplay | ✅ One-Click Allowlist | 👮 Cops 😎 Gangs & 👩‍⚕️ Medics gesucht! | 💣 AntiCheat | 🔊 SaltyChat | 🎉 Events | 💊 Illegale/Legale Routen | 🚗 Modded Cars | 🔥 Performance"
; servers["truelife"]["code"] := "9o3ray"
; scriptlog(toJson(servers, true))
; global log := 0
; initLog()

; Menu, tray, add,

; for k, server in servers {
;     if (server.code)
;         Menu, tray, add, % "Connect to " . k, Connect
; }

; if windows.loading.file.exists() {
;     Menu, Tray, Icon, % windows.loading.file.path
; }

; scriptlog("init end")
; return

; ; F6::toggle()
; return


ExitFunc(reason, code) {
    scriptlog("OnExit")
    log.Delete()
    return
}
FormatSeconds(NumberOfSeconds)  ; Convert the specified number of seconds to hh:mm:ss format.
{
    NumberOfSeconds := Round(NumberOfSeconds)
    time := 19990101  ; *Midnight* of an arbitrary date.
    time += NumberOfSeconds, seconds
    FormatTime, mmss, %time%, mm:ss
    return NumberOfSeconds//3600 ":" mmss
    /*
    ; Unlike the method used above, this would not support more than 24 hours worth of seconds:
    FormatTime, hmmss, %time%, h:mm:ss
    return hmmss
    */
}
FormatMilliSeconds(NumberOfMilliSeconds)  ; Convert the specified number of seconds to hh:mm:ss format.
{
    return FormatSeconds(NumberOfMilliSeconds / 1000)
}

; initLog() {
;     log.Delete()
;     logfile := fivemdir.Combine("FiveM.app\logs").getNewestFile("*.log")
;     if (logfile.exists()) {
;         log := new LogTailer(logfile.path, Func("OnNewLogLine"), false, "UTF-8", "`r`n") ; , "CP28591", "`n")
;         log.Stop()
;         log.Start()
;         ; log := StdOutStream("tail " . Quote(logfile.path), "OnNewLogLine" ) 
;         scriptlog("subscribed to log file " . logfile.Quote() . " (" . log . ")")
;     }
;     return
; }
; OnNewLogLine(FileLine, n) {
;     scriptlog("OnNewLogLine")
;     if (!FileLine)
;         return
;     scriptlog(FileLine)
; }

; Connect() {
;     txt := StrReplace(A_ThisMenuItem, "Connect to ", "")
;     server := servers[txt]
;     _SplashScreen(server.title, A_ThisMenuItem, 2500)
;     windows.loading.file.run(false, "", "fivem://connect/cfx.re/join/" . server.code)
; }

; toggle() {
;     if (!enabled) {
;         enabled := true
;         CreateInterval()
;         SetTimer, runChecks, % interval
;         scriptlog("enabled")
;     } else {
;         enabled := false
;         SetTimer, runChecks, Off
;         scriptlog("disabled")
;     }
;     return
; }
; runChecks() {
;     scriptlog("pressing with sendmode " . A_SendMode)
;     ;PressKey(key, presses=1, sleepms=80, keyms=20, verbose=false, msg="", raw=false) {
;     ; PressKey("E", 1, 80, 20, false, "", true)
;     Send {Raw}e
;     ; PressKeyDLL("e", 1, 60)
;     interval = CreateInterval()
;     return
; }
; CreateInterval() {
;     Random, interval, 500, 1500
;     scriptlog("New interval: " . interval)
;     return interval
; }