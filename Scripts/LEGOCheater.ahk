#InstallKeybdHook
#UseHook On
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
#Include <bluscream>
; #Include <HotkeyHelp>
; #Include <LEGO/JurassicPark>
#Include <LEGO/CityUndercover>
#Include <LEGO/MouseEmulatorIntercept>
Menu, tray, add
Menu, tray, add, Start %game_name%, StartGame

global noui := false
global key_special_inuse := false
scriptlog("Started logging here. Using SendMode " . A_SendMode)
scriptlog("Name: " . game_name)
scriptlog("Window: " . game_window)
scriptlog("Path:  " . game_dir . "\\" . game_exe)
scriptlog("Steam AppID:  " . game_id)
scriptlog("Extras  " . game_extras)
scriptlog("Special Key  " . key_special)
scriptlog("Hotkeys: \n"
. "Ctrl+K\t\tRestart Game\n"                  
. "Ctrl+Esc\tDisable Hooks\n"              
. "Control + Ä\tRepeat Special\n"
. "Shift + Ä\tToggle Special\n"
. "Space => Ö\n")
GetKeyboardAndMouse()
; scriptlog(ScriptHotkeys(A_ScriptFullPath))
; #IfWinActive, game_window
global wasactive := false
global winMiddleX := 0
global winMiddleY := 0
SetTimer CheckActive, 1000

CheckActive() {
    active := WinActive(game_window)
    if (active != wasactive) {
        wasactive := active
        activestr := active ? "now active (Mouse emulation and hotkeys enabled)" : "no longer active (Mouse emulation and hotkeys disabled)"
        scriptlog(game_window . " is " . activestr . " (" . active . ")")
        if (active) {
            WinGetPos, X, Y, Width, Height, %game_window%
            winMiddleX := Round(Width / 2)
            winMiddleY := Round(Height / 2)
            scriptlog("Saved Window center for mouse emulation: X " . winMiddleX . " Y " . winMiddleY)
            ; SubscribeHID() ; TODO: FIX
            ; SetTimer, StopCursor, 100
            ; SetTimer, WatchCursor, 20
            ; SetTimer, ResetCursor, 20
        } else {
            ; UnsubscribeHID() ; TODO: FIX
            ; SetTimer, StopCursor, Off
            ; SetTimer, WatchCursor, Off
            ; SetTimer, ResetCursor, Off
        }
    }
}

WatchCursor:
    ; WatchCursor()
ResetCursor:
    ResetCursor()

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
~^#::ToggleSpecial("repeat") ; Control + #

^ESC::
    SetTimer, WatchCursor, Off
    SetTimer, ResetCursor, Off
    ToolTip,
    Return
#if
; endregion Keybinds

ToggleSpecial(mode) {
    key_special_inuse := !key_special_inuse
    if (!key_special_inuse) {
        SetTimer RepeatSpecial, Off
        ; Send, % "{" key_special " Up}"
        UpKeyAHI(key_special)
    } else if (mode == "repeat") {
        Sleep, 250
        SetTimer RepeatSpecial, 25
    } else if (mode == "hold") {
        ; Send, % "{" key_special " Down}"
        DownKeyAHI(key_special)
    }
    scriptlog(((!key_special_inuse) ? "No longer " : "") . mode . " special key (" . key_special . ") ")
}

RepeatSpecial:
    ; PressKey(key_special,1,50)
    PressKeyAHI(key_special, 1, 75)
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