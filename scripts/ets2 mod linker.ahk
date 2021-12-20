#SingleInstance Force
; #NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#Include <bluscream>
EnforceAdmin()
global noui = false
Loop, read, % "S:\Steam\steamapps\common\Euro Truck Simulator 2\Documents\mod\promods.namemap"
{
    item := StrSplit(A_LoopReadLine, "=",, 2)
    scriptlog("Field number " . item[1] . " is " . item[2] . ".")
}

WaitForKey("")
Loop, %A_WorkingDir%\*,2,0
{
    ; if !RegExMatch(A_LoopFileName, regex_profile) {
    if !InStr(A_LoopFileName, "profiles") {
        ; scriptlog(A_LoopFileName . " is not a profiles dir!")
        Continue
    }
}