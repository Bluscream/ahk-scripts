#SingleInstance Force
; #NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#Include <bluscream>

; regex_profile := "i)profiles"

scriptlog("Started logging to console")
dirs := 0
profiles := 0
profiles_unique := {}
Loop, %A_WorkingDir%\*,2,0
{
    ; if !RegExMatch(A_LoopFileName, regex_profile) {
    if !InStr(A_LoopFileName, "profiles") {
        ; scriptlog(A_LoopFileName . " is not a profiles dir!")
        Continue
    }
    Result := "HEX;ASCII`r`n"
    profiles_in_dir := 0
    Loop, %A_LoopFileFullPath%\*,2,0
    {
        Decoded := HexToString(A_LoopFileName)
        Result .= A_LoopFileName . ";" . Decoded . "`r`n" ; . " = " . StringToHex(Decoded, false)
        profiles++
        profiles_in_dir++
        profiles_unique[A_LoopFileName] := Decoded
    }
    dirs++
    filepath := A_LoopFileFullPath . "\index.csv"
    scriptlog("Indexed " . profiles_in_dir . " profiles in """ . filepath . """")
    WriteToFile(filepath, Result)
}
if (!dirs) {
    MsgBox 0x10, No profiles found!, Make sure this script is executed from the same folder as your profile folders!`n`nUsually "%A_MyDocuments%\Euro Truck Simulator 2"
    Exit
}
profiles_unique_count := 0
scriptlog("Found profiles:")
Result := "HEX`ASCII`r`n"
for index, value in profiles_unique {
    profiles_unique_count++
    Result .= index . ";" . value . "`r`n"
    scriptlog(index . ": " . value)
}
WriteToFile(A_WorkingDir . "\profiles_index.csv", Result)
scriptlog("FINISHED: Processed " . profiles . " profiles (" . profiles_unique_count . " unique) in " . dirs . " folders`r`n")
WaitForKey("")
; Run, Notepad "%filepath%"