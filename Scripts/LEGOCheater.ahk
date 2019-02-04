#Include <bluscream>
#SingleInstance Force
Process Priority,, Below Normal
SetWorkingDir %A_ScriptDir%
#Warn
#Persistent
SetKeyDelay, 150

game_name := "LEGO"
game_title := "ahk_class TTalesWindow"
file := "codes.txt"

global noui := false
scriptlog("Started logging here...")

codes := FileOpen(file, "r `n")
scriptlog("Codes: " . codes)

While !(codes.AtEOF)
{
    if !(WinActive(game_title)) {
        TrayTip, AutoHotKey, Bringing %game_name% to front to enter code...
        ; WinWaitActive, %game_title%
    }
    Sleep, 1000
    code := codes.ReadLine()
    code := StrStrip(code)
    length := StrLen(code)
    if (length < 1) {
        Continue
    }
    FormatTime, timestamp, A_Now, hh:mm:ss
    
    scriptlog("[" . timestamp . "] Now processing code: " . code . " [" . length . "] (`r`n", "", true)   
    
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
        if (k = length) {
            loop, % k {
                Send, {Left}
            }
        }
    }
    scriptlog(")`r`n","",true)
    SendInput, {Enter}
    scriptlog("Finished processing ")
    KeyWait, NumpadAdd, D
    /*SetKeyDelay, 125
    SendEvent, {Esc 2}
    SendEvent, {Down 2}
    SendEvent, {Enter 2}
    */
}

codes.Close()

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