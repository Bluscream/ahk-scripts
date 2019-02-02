; Version 1
; Date 02/02/2019
#Include <bluscream>
#SingleInstance Force
Process Priority,, Below Normal
SetWorkingDir %A_ScriptDir%
#Warn
#Persistent
SetKeyDelay, 150
game_name := "LEGO" ; LEGO Jurassic World
game_title := "ahk_class TTalesWindow" ; ahk_exe LEGOJurassicWorld_DX11.EXE

; chars := "ABCDEFGHIJKLMNOPQR|STUVWXYZ0123456789"
chars := { "B" : "{Up}", "C" : "{Up 2}", "D" : "{Up 3}", "E" : "{Up 4}", "F" : "{Up 5}", "G" : "{Up 6}", "H" : "{Up 7}", "J" : "{Up 8}", "K" : "{Up 9}", "L" : "{Up 10}", "M" : "{Up 11}", "N" : "{Up 12}", "O" : "{Up 13}", "P" : "{Up 14}", "Q" : "{Up 15}", "R" : "{Up 16}", "S" : "{Down 18}", "T" : "{Down 17}", "U" : "{Down 16}", "V" : "{Down 15}", "W" : "{Down 14}", "X" : "{Down 13}", "Y" : "{Down 12}", "Z" : "{Down 11}", "0" : "{Down 10}", "1" : "{Down 9}", "2" : "{Down 8}", "3" : "{Down 7}", "4" : "{Down 6}", "5" : "{Down 5}", "6" : "{Down 4}", "7" : "{Down 3}", "8" : "{Down 2}", "9" : "{Down}" }

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
    for i, char in splitted_code {
        tosend := chars[char]
        scriptlog("i:" . i . " char:" . char . " tosend:" . tosend . "`r`n", "", true)
        if (tosend){
            ; scriptlog(tosend . ", ", "", true)
            SendEvent, % tosend
        }
        if (i < length)
            SendInput, {Right}
    }
    scriptlog(")`r`n","",true)
    SendInput, {Enter}
    /*SetKeyDelay, 125
    SendEvent, {Esc 2}
    SendEvent, {Down 2}
    SendEvent, {Enter 2}
    */
}