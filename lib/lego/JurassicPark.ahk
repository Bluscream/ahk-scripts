#Include <bluscream>

#SingleInstance Force
; #Persistent

global game_name := "LEGO Jurassic World"
global game_title := "LEGO Jurassic World ahk_class TTalesWindow"
global game_dir := "G:\Steam\steamapps\common\LEGO Jurassic World\"
global game_exe := "LEGOJurassicWorld_DX11.EXE"
global game_id := "352400"
global game_extras := 20
global key_special := "ä"

/*
if !(WinActive(game_title)) {
    StartGame() ; remove
}
*/

/*NumpadAdd::
    CloseGame()
*/

StartGame(WaitForMenu=true){
    StartGameSteam()
    WinWait, %game_title%
    scriptlog(game_title . " window exists")
    WinActivate, %game_title%
    WinWaitActive, %game_title%
    scriptlog(game_title . " window active")
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
LoadGame(SaveState=1) {
    PressKey("Enter",1,20000,,true,"Press any button to Start")
    PressKey("Enter",1,4000,,true,"Press Load Game -> Savelist loaded")
    ; if (SaveState == 2)
    PressKey("Enter",1,3000,,true,"Select upper left save") ; 
    PressKey("Enter",1,6000,,true,"Confirm Load -> Savestate Loaded")
    PressKey("Enter",1,16000,,true,"Confirm autosave -> Game Loaded")
    scriptlog("Game Loaded (" . SaveState . ")")
}
ToEscMenu(FromMenu=false) {
    if (FromMenu)
        PressKey("Esc",1,300) ; Close Menu
    PressKey("Esc",1,300) ; Go to Pause Menu
}
ToExtrasMenu(EnterCode=False) {
    PressKey("Enter",1,200) ; Open Menu
    PressKey("Down",2) ; Navigate to "Extras"
    if (EnterCode) {
        PressKey("Enter",2,200) ; Extras+Enter Code
    } else {
        PressKey("Enter",1,200) ; Extras
    }
}
ToMainMenu() {
    PressKey("Down",3,100) ; Navigate to Quit Game
    PressKey("Enter",1,300) ; Quit Game
    PressKey("Up",1,100) ; Navigate to Save and Exit
    PressKey("Enter",1,13000) ; Save and Exit
}
CloseGame(){
    scriptlog("Closing " . game_title " ...")
    WinClose, %game_title%
    Sleep, 3 * 1000
    if (WinExist(game_title)) {
        scriptlog("Killing " . game_title " ...")
        WinKill, %game_title%
    }
    scriptlog("Waiting for " . game_title " to vanish ...")
    WinWaitClose, %game_title%,, 3
    if (ErrorLevel) {
        CommandLine := DllCall("GetCommandLine", "Str")
        If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
            WaitForKey("Could not close " . game_title . ". Restart as admin? ", "any key")
            Try {
                If (A_IsCompiled) {
                    Run *RunAs "%A_ScriptFullPath%" /restart
                } Else {
                    Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
                }
            }
            ExitApp
        } else {
            scriptlog("Unable to close " . game_title . " even as admin. Please open task manager manually and kill it.")
            WinWaitClose, %game_title%
        }
    }
    scriptlog("Closed " . game_title " ...")
}
/*
ResetCodeLEGOJurassicPark() {
    PressKey("Esc",2,300) ; Go to Pause Menu
    PressKey("Down",3,100) ; Navigate to Quit Game
    PressKey("Enter",1,300) ; Quit Game
    PressKey("Up",1,100) ; Navigate to Save and Exit
    PressKey("Enter",1,13000) ; Save and Exit
    PressKey("Enter",1,13000) ; Press any button to Start
    PressKey("Enter",1,5500) ; Press Load Game
    PressKey("Enter",1,5500) ; Select upper left save
    PressKey("Enter",1,8000) ; Confirm Load
    PressKey("Enter",1,15000) ; Confirm autosave
}
*/