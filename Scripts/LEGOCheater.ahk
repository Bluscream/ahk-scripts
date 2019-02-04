#Include <bluscream>
#SingleInstance Force
Process Priority,, Below Normal
SetWorkingDir %A_ScriptDir%
#Persistent
SetKeyDelay, 150

game_name := "LEGO"
game_title := "ahk_class TTalesWindow"
file := "codes.txt"
file_done := "codes_done.txt"
key_next := "{NumpadAdd}"

global noui := false
scriptlog("Started logging here...")

FileRead, LoadedText, %file%
codes := StrSplit(LoadedText, "`n", "`r")
codes_length := codes.MaxIndex()
; codes := FileOpen(file, "r `n")
scriptlog("Loaded " . codes_length . " codes from " . file . ": " . Join(", ", codes*))

Loop, % codes_length
{
    if !(WinActive(game_title)) {
        TrayTip, AutoHotKey, Bringing %game_name% to front to enter code...
        ; WinWaitActive, %game_title%
    }
    scriptlog("Ready to process next code, press " . key_next . " to start!")
    KeyWait, NumpadAdd, D
    Sleep, 1000
    code := codes[A_Index]
    code := StrStrip(code)
    code_length := StrLen(code)
    code_count := "(" . A_Index . "/" . codes_length . ")"
    if (code_length < 1) {
        Continue
 
 }
    FormatTime, timestamp, A_Now, hh:mm:ss
    
    scriptlog("[" . timestamp . "] " . code_count . " Now processing code: " . code . " [" . code_length . "] {`r`n", "", true)   
    
    for k, letter in StrSplit(code) {
        if (k - 1) {
            Send, {Right}
        }
        SendCount := (letter ~= "[A-R]"
                    ? Ord(letter) - 65 
                    : (letter ~= "[S-Z]"
                        ? -36 + (Ord(letter) - 65) 
                        : -10 + (Ord(letter) - 48)))
        scriptlog("`tk:" . k . " letter:" . letter . " SendCount:" . SendCount . "`r`n", "", true)
        SendUpDown(SendCount)
        if (k = code_length) {
            loop, % k {
                Send, {Left}
            }
        }
    }
    scriptlog("}`r`n","",true)
    SendInput, {Enter}
    scriptlog(code_count . " Finished processing Code: " . code)
    FileAppend, %code%`n, %file_done%
    /*SetKeyDelay, 125
    SendEvent, {Esc 2}
    SendEvent, {Down 2}
    SendEvent, {Enter 2}
    */
}

; codes.Close()

SendUpDown(SendCount) {
	if (SendCount = Abs(SendCount)) {
		loop, % SendCount {
			Send, {Up}
		}
	}
	else {
		loop, % Abs(SendCount) {
			Send, {Down}
		}
	}
}