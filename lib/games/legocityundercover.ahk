#SingleInstance Force
; #Persistent

#Include <LEGO\COMMON>
#Include <bluscream>

global game_title := "LEGO City Undercover"
global game_class := "TTalesWindow"
global game_exe := "LEGOLCUR_DX11.exe"
global game_window := game_title . " ahk_class " . game_class . " ahk_exe " . game_exe
global game_name := "LEGO City Undercover"
global game_dir := "S:\Steam\steamapps\common\LEGO City Undercover\"
global game_config := A_AppData . "\Warner Bros. Interactive Entertainment\LEGO City Undercover\pcconfig.txt"
global game_id := "578330"
global game_extras := 20 ; ???
global key_special := "ä"


LoadGame(SaveState=1) {
    /*
    PressKey("Enter",1,20000,,true,"Press any button to Start")
    PressKey("Enter",1,4000,,true,"Press Load Game -> Savelist loaded")
    ; if (SaveState == 2)
    PressKey("Enter",1,3000,,true,"Select upper left save") ; 
    PressKey("Enter",1,6000,,true,"Confirm Load -> Savestate Loaded")
    PressKey("Enter",1,16000,,true,"Confirm autosave -> Game Loaded")
    scriptlog("Game Loaded (" . SaveState . ")")
    */
}
ToEscMenu(FromMenu=false) {
    /*
    if (FromMenu)
        PressKey("Esc",1,300) ; Close Menu
    PressKey("Esc",1,300) ; Go to Pause Menu
    */
}
ToExtrasMenu(EnterCode=False) {
    /*
    PressKey("Enter",1,200) ; Open Menu
    PressKey("Down",2) ; Navigate to "Extras"
    if (EnterCode) {
        PressKey("Enter",2,200) ; Extras+Enter Code
    } else {
        PressKey("Enter",1,200) ; Extras
    }
    */
}
ToMainMenu() {
    /*
    PressKey("Down",3,100) ; Navigate to Quit Game
    PressKey("Enter",1,300) ; Quit Game
    PressKey("Up",1,100) ; Navigate to Save and Exit
    PressKey("Enter",1,13000) ; Save and Exit
    */
}