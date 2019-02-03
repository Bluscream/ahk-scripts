; Version 1
; Date 02/02/2019
#Include <bluscream>
#SingleInstance Force
Process Priority,, Below Normal
SetWorkingDir %A_ScriptDir%
#Warn
#Persistent
SetKeyDelay, 150
; SetBatchLines, -1
game_name := "LEGO" ; LEGO Jurassic World
game_title := "ahk_class TTalesWindow" ; ahk_exe LEGOJurassicWorld_DX11.EXE

; chars := "ABCDEFGHIJKLMNOPQR|STUVWXYZ0123456789"
; chars := { "B" : "{Up}", "C" : "{Up 2}", "D" : "{Up 3}", "E" : "{Up 4}", "F" : "{Up 5}", "G" : "{Up 6}", "H" : "{Up 7}", "I" : "{Up 8}", "J" : "{Up 9}", "K" : "{Up 10}", "L" : "{Up 11}", "M" : "{Up 12}", "N" : "{Up 13}", "O" : "{Up 14}", "P" : "{Up 15}", "Q" : "{Up 16}", "R" : "{Up 17}", "S" : "{Down 18}", "T" : "{Down 17}", "U" : "{Down 16}", "V" : "{Down 15}", "W" : "{Down 14}", "X" : "{Down 13}", "Y" : "{Down 12}", "Z" : "{Down 11}", "0" : "{Down 10}", "1" : "{Down 9}", "2" : "{Down 8}", "3" : "{Down 7}", "4" : "{Down 6}", "5" : "{Down 5}", "6" : "{Down 4}", "7" : "{Down 3}", "8" : "{Down 2}", "9" : "{Down}" }

; code := "ABCDEF" ; 28SPSR
file := "codes.txt"

global noui := false
scriptlog("Started logging here...")

FileRead, LoadedText, %file%
codes := StrSplit(LoadedText, "`n", "`r")


Loop, % codes.MaxIndex()
{
    if !(WinActive(game_title)) {
        TrayTip, AutoHotKey, Bringing %game_name% to front to enter code...
        Sleep, 1000
        ; WinActivate, %game_title%
        WinWaitActive, %game_title%
    }
    
    code := StrStrip(codes[A_Index])
    length := StrLen(code)
    FormatTime, timestamp, A_Now, hh:mm:ss
    scriptlog("[" . timestamp . "] Now processing code: " . code . " [" . length . "] (`r`n", "", true)
    splitted_code := StrSplit(code)
    for k, letter in splitted_code {
        if (k - 1) {
            ; Move the letter we are changing one to the right (unless this is the first letter)
            Send, {Right}
        }
        SendCount := (letter ~= "[A-R]" ; If letter one we go up for, the number of times to send up is just what number that letter is in the alphabet
                    ? Ord(letter) - 65 
                    : (letter ~= "[S-Z]" ; Else if the letter is not 0-9 and one we go down for, the number of times to go up for is the number of the letter, added to -36 to create an offset
                        ? -36 + (Ord(letter) - 65) 
                        : -10 + (Ord(letter) - 48))) ; By here the letter can only be a number, but I don't know how I got this to work, if you want to know how just ask and I'll try to figure it out
        scriptlog("k:" . k . " letter:" . letter . " SendCount:" . SendCount . "`r`n", "", true)
        SendUpDown(SendCount)
        if (k = StrLen(code)) {
            loop, % k {
                ; Move the letter we are changing back to the leftmost if we are at the end of the code
                Send, {Left}
            }
        }
    }
    scriptlog(")`r`n","",true)
    SendInput, {Enter}
    /*SetKeyDelay, 125
    SendEvent, {Esc 2}
    SendEvent, {Down 2}
    SendEvent, {Enter 2}
    */
}

SendUpDown(SendCount) {
	if (SendCount = Abs(SendCount)) {
		; If number is positive
		loop, % SendCount {
			Send, {Up}
		}
	}
	else {
		; If number not positive, then it is negative
		loop, % Abs(SendCount) {
			Send, {Down}
		}
	}
}