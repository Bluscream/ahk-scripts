; #InstallKeybdHook
; #UseHook On
#Include <bluscream>
#SingleInstance Force
#Persistent
DetectHiddenWindows Off
FileEncoding UTF-8
Process Priority,, Below Normal
SetWorkingDir %A_ScriptDir%
; SetKeyDelay, 100
SendMode Input
/*CommandLine := DllCall("GetCommandLine", "Str")
If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
    Try {
        If (A_IsCompiled) {
            Run *RunAs "%A_ScriptFullPath%" /restart
        } Else {
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
    }
    ExitApp
}
*/
; #Include <LEGO/JurassicPark>
#Include <LEGO/CityUndercover>
Menu, tray, add
Menu, tray, add, Start %game_name%, StartGame

global noui := false
global key_special_inuse := false
scriptlog("Started logging here. Using SendMode " . A_SendMode)
scriptlog("game_name " . game_name)
scriptlog("game_title " . game_title)
scriptlog("game_class " . game_class)
scriptlog("game_window " . game_window)
scriptlog("game_dir  " . game_dir)
scriptlog("game_exe  " . game_exe)
scriptlog("game_id  " . game_id)
scriptlog("game_extras  " . game_extras)
scriptlog("key_special  " . key_special)
; #IfWinActive, game_window
global wasactive := false
SetTimer CheckActive, 1000

CheckActive() {
    active := WinActive(game_window)
    if (active != wasactive) {
        wasactive := active
        activestr := active ? "now active" : "no longer active"
        scriptlog(game_window . " is " . activestr . " (" . active . ")")
        ; if (active) {
            ; Hotkey, ^k, On
            ; Hotkey, space, On
            ; Hotkey, ~+ä, On
            ; Hotkey, ^ä, On
        ; } else {
            ; Hotkey, ^k, Off
            ; Hotkey, space, Off
            ; Hotkey, ~+ä, Off
            ; Hotkey, ^ä, Off
        ; }
    }
}

; region Keybinds
#if WinActive(game_window)
^k::
    ToEscMenu(true)
    ToMainMenu()
    CloseGame()
    StartGame()
    LoadGame()
 
/*NumpadAdd::
    EnterCodes()

NumpadSub::
    ActivateAllExtras()
*/

space::ö ; space => ö
~+ä::ToggleSpecial("hold") ; Shift + Ä
^ä::ToggleSpecial("repeat") ; Control + Ä
#if
; endregion Keybinds

ToggleSpecial(mode) {
    key_special_inuse := !key_special_inuse
    if (!key_special_inuse) {
        SetTimer RepeatSpecial, Off
        Send, % "{" key_special " Up}"
    } else if (mode == "repeat") {
        SetTimer RepeatSpecial, 500
    } else if (mode == "hold") {
        Send, % "{" key_special " Down}"
    }
    scriptlog(((!key_special_inuse) ? "No longer " : "") . mode . " special key (" . key_special . ") ")
}

RepeatSpecial:
    PressKey("ä",1,50)
    Return

StartGame:
    CloseGame()
    StartGame()
    LoadGame()
    Return

ActivateAllExtras() {
    ToExtrasMenu()
    scriptlog("Activating " . game_extras . " extras...")
    Loop, % game_extras {
        PressKey("Down",1)
        scriptlog("Activating extra " . A_Index . " ...")
        PressKey("Enter",1)
    }
    PressKey("Esc")
    scriptlog("Activated " . game_extras . " extras...")
}

EnterCodes() {
    file := "codes.txt"
    file_done := "codes_done.txt"
    FileRead, LoadedText, %file%
    codes := StrSplit(LoadedText, "`n", "`r")
    codes_length := codes.MaxIndex()
    ; codes := FileOpen(file, "r `n")
    scriptlog("Loaded " . codes_length . " codes from " . file . ": " . Join(", ", codes*))

    Loop, % codes_length
    {
        /*if !(WinActive(game_title)) {
            TrayTip, AutoHotKey, Waiting for %game_name% to be active...
            WinWaitActive, %game_title%
        }
        */
        ; WaitForKey("Ready to process next code. ")
        Sleep, 1000
        code := codes[A_Index]
        code := StrStrip(code)
        code_length := StrLen(code)
        code_count := "(" . A_Index . "/" . codes_length . ")"
        if (A_Index > 1) {
            ToExtrasMenu(true)
            ; WaitForKey("NumpadAdd", "Please reset the cursor to the leftmost position. ") 
        }
        if (code_length < 1) {
            Continue
        }
        scriptlog(code_count . " Now processing code: " . code . " [" . code_length . "]")   
        ; FormatTime, timestamp, A_Now, hh:mm:ss
        ; scriptlog("[" . timestamp . "] " . code_count . " Now processing code: " . code . " [" . code_length . "] {`r`n", "", true)   
        
        for k, letter in StrSplit(code) {
            if (k - 1) {
                PressKey("Right")
            }
            SendCount := (letter ~= "[A-R]"
                        ? Ord(letter) - 65 
                        : (letter ~= "[S-Z]"
                            ? -36 + (Ord(letter) - 65) 
                            : -10 + (Ord(letter) - 48)))
            ; scriptlog("`tk:" . k . " letter:" . letter . " SendCount:" . SendCount . "`r`n", "", true)
            SendUpDown(SendCount)
            /*if (k = code_length) {
                loop, % k {
                    PressKey("Left")
                }
            }
            */
        }
        ; scriptlog("}`r`n","",true)
        PressKey("Enter") ; Redeem Code
        scriptlog(code_count . " Finished processing Code: " . code)
        FileAppend, %code%`n, %file_done%
        ; WaitForKey()
        ToEscMenu(true)
        ToMainMenu()
        CloseGame()
        StartGame()
        LoadGame()
    }
    ; codes.Close()
}

SendUpDown(SendCount) {
	if (SendCount = Abs(SendCount)) {
        PressKey("Up",SendCount)
	}
	else {
        PressKey("Down",Abs(SendCount))
	}
}