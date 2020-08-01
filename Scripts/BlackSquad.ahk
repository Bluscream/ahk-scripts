#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
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


global log_pattern :=    "^\[(\d{4}\.\d{2}\.\d{2}\-\d{2}\.\d{2}\.\d{2})\] (.*)$"
global msg_pattern :=    "^Log: (.*)$"
global beguid_pattern := "^BattlEyeLog: Server computed GUID: ([a-z0-9]{32})$"
global error_pattern :=  "^Disconnet Client: (\d+)$"
global close_pattern :=  "^Closing by request$"

; lt_log := new LogTailer(path . "CombatGame\Logs\Launch.log", Func("OnNewLogLine"), true, "", "")
global max_chat_chars := 100
global had_error := false


I_Icon := path . "binaries\win64\" . game.exe
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%
Menu, tray, add, ---BlackSquad---, void
Menu, tray, add, Kill Game, killGameFunc
Menu, tray, add, Restart Game, restartGameFunc

killGame()
; startLauncher()

restartGameFunc:
    killGame()
    ; clearLogs()
    startLauncher()
    
killGameFunc:
    killGame()
    
void:
    return

OnNewLogLine(FileLine) {
    validLine := RegExMatch(FileLine, log_pattern, log)
    if (!validLine) {
        scriptlog("INVALID: " . FileLine)
        Return
    }  else if (RegExMatch(log2, msg_pattern, msg)) {
        if (RegExMatch(msg2, beguid_pattern, beguid)) {
            scriptlog("BEGUID: """ . beguid2)
        } else if (RegExMatch(log2, error_pattern, msg)) {
            had_error := true
            gosub restartGameFunc
        } else if (RegExMatch(log2, close_pattern, msg)) {
            ExitApp
        }
    }
}

startLauncher() {
    winstr := launcher.str()
    ; MsgBox,,, % winstr
    Run, % "steam://rungameid/550650" ;path . "binaries\" . launcher.exe
    WinWait, % winstr
    WinActivate, % winstr
    WinWaitActive, % winstr
    ; sleep, 2500
    SetControlDelay -1
    while (true) {
        ControlGet, isPlayButtonEnabled, Enabled,, % "MFCButton1", % winstr
        if (isPlayButtonEnabled) {
            WinActivate, % winstr
            WinWaitActive, % winstr
            ; ControlClick, x702 y558, % winstr
            ControlClick, % "MFCButton1", % winstr,,,, NA
            return
        }
        sleep, 250
    }
}
    
clearLogs() {
    logs := path . "CombatGame\Logs\*.log"
    FileDelete, % logs
    ; Loop, % dir . "\*.*", 2
    ;     FileRemoveDir, %A_LoopFileLongPath%,1
}

killGame() {
    ; ToolTip, % "Killing Processes"
    killProcess(awesomium.exe)
    killProcess(launcher.exe)
    killProcess(game.exe)
    killProcess(belauncher.exe)
    ; killProcess(beservice.exe)
    ; ToolTip, % ""
}

killProcess(name) {
    Process, Exist, % name
    if(!ErrorLevel) {
        ErrorLevel := 0
        Process, Close, % name
    }
}