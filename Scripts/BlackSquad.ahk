#SingleInstance Force
#NoEnv
; #NoTrayIcon
; #Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#Include <bluscream>
EnforceAdmin()
#Include <logtail>
; DetectHiddenWindows On
CoordMode, Mouse, Client

global path := "S:\Steam\steamapps\common\Black Squad\"
global launcher := new Window(  "",                         "#32770",                       "BSLauncher.exe")
global belauncher := new Window("",                         "",                             "BlackSquadGame_BELauncher.exe")
global beservice := new Window( "",                         "",                             "BEService_x64.exe")
global game := new Window(      "BlackSquad (64-bit, DX9)", "LaunchCombatUWindowsClient",   "BlackSquadGame.exe")
global awesomium := new Window( "",                         "",                             "awesomium_process.exe")

; lt_log := new LogTailer(path . "CombatGame\Logs\Launch.log", Func("OnNewLogLine"), true, "CP1200")
; steam://rungameid/550650

killGame()
startLauncher()

OnNewLogLine(FileLine) {
    scriptlog("[CLIENT] " . FileLine)
}

startLauncher() {
    Run, % "steam://rungameid/550650" ;path . "binaries\" . launcher.exe
    winstr := launcher.str()
    WinWait, % winstr
    WinActivate, % winstr
    WinWaitActive, % winstr
    ; sleep, 2500
    SetControlDelay -1
    ; ControlClick, WiMFCButton1, % winstr,,,, NA
    while (true) {
        if (launcherPlayButtonEnabled(winstr)) {
            WinActivate, % winstr
            WinWaitActive, % winstr
            ControlClick, x702 y558, % winstr
            return
        }
        sleep, 250
    }
}

launcherPlayButtonEnabled(winstr) {
    ControlGet, isButtonEnabled, Enabled,, WiMFCButton1, % winstr
    if (isButtonEnabled) {
        SplashScreen("Button is enabled!", "", 1000)
        return true
    }
}

killGame() {
    ToolTip, % "Killing Processes"
    killProcess(awesomium.exe)
    killProcess(launcher.exe)
    killProcess(game.exe)
    killProcess(belauncher.exe)
    ; killProcess(beservice.exe)
    ToolTip, % ""
}

killProcess(name) {
    Process, Exist, % name
    if(!ErrorLevel) {
        ErrorLevel := 0
        Process, Close, % name
    }
}