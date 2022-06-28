#Include <bluscream>

#SingleInstance Force
; #Persistent

global game_name := "LEGO"
global game_class := "TTalesWindow"
global game_window := "ahk_class " . game_class

StartGame(WaitForMenu=true){
    StartGameSteam()
    WinWait, %game_window%
    scriptlog(game_window . " window exists")
    WinActivate, %game_window%
    WinWaitActive, %game_window%
    scriptlog(game_window . " window active")
    if (WaitForMenu)
        Sleep, 60 * 1000
}
StartGameLocal() {
    path := game_dir . game_exe
    Run, %path%, %game_dir%
    scriptlog("Started " . path)
}
StartGameSteam() {
    url := "steam://rungameid/" . game_id
    Run, %url%
    scriptlog("Started " . url)
}
CloseGame(){
    scriptlog("Closing " . game_window " ...")
    WinClose, %game_window%
    Sleep, 3 * 1000
    if (WinExist(game_window)) {
        scriptlog("Killing " . game_window " ...")
        WinKill, %game_window%
    }
    scriptlog("Waiting for " . game_window " to vanish ...")
    WinWaitClose, %game_window%,, 3
    if (ErrorLevel) {
        CommandLine := DllCall("GetCommandLine", "Str")
        If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
            WaitForKey("Could not close " . game_window . ". Restart as admin? ", "any key")
            Try {
                If (A_IsCompiled) {
                    Run *RunAs "%A_ScriptFullPath%" /restart
                } Else {
                    Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
                }
            }
            ExitApp
        } else {
            scriptlog("Unable to close " . game_window . " even as admin. Please open task manager manually and kill it.")
            WinWaitClose, %game_window%
        }
    }
    scriptlog("Closed " . game_window " ...")
}