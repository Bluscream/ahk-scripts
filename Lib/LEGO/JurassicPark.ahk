#Include <bluscream>

#SingleInstance Force
; #Persistent

global game_name := "LEGO Jurassic World"
global game_title := "LEGO Jurassic World ahk_class TTalesWindow"
global game_dir := "G:\Steam\steamapps\common\LEGO Jurassic World\"
global game_exe := "LEGOJurassicWorld_DX11.EXE"
global game_id := "352400"
global game_extras := 20

/*
if !(WinActive(game_title)) {
    StartGame() ; remove
}
*/

/*NumpadAdd::
    CloseGame()
*/

StartGame(){
    StartGameSteam()
    WinWait, %game_title%
    WinActivate, %game_title%
    WinWaitActive, %game_title%
    Sleep, 45000
}
StartGameLocal() {
    path := game_dir . game_exe
    Run, %path%, %game_dir%
}
StartGameSteam() {
    Run, steam://rungameid/%game_id%
}
LoadGame() {
    PressKey("Enter",1,15000) ; Press any button to Start
    PressKey("Enter",1,7000) ; Press Load Game
    PressKey("Enter",1,7000) ; Select upper left save
    PressKey("Enter",1,9000) ; Confirm Load
    PressKey("Enter",1,15000) ; Confirm autosave
}
ToEscMenu(FromMenu=false) {
    if (FromMenu) {
        PressKey("Esc",2,300) ; Go to Pause Menu
    } else {
        PressKey("Esc",1,300) ; Go to Pause Menu
    }
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
    WinClose, %game_title%
    Sleep, 1000
    if (WinActive(game_title)) {
        WinKill, %game_title%
    }
    WinWaitClose, %game_title%
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