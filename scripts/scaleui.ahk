#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#include <bluscream>
scriptlog("init")
; #Include <node_modules\regex.ahk\export>

scale := A_Args[2] ? A_Args[2] : 2
script := A_Args[1] ? A_Args[1] : "C:\Program Files\AutoHotkey\scripts\numpad.ahk"
newscript := StrReplace(script, ".ahk", ".scale" . scale . ".ahk")
FileDelete, % newscript
FileRead, scriptText, % script
scriptlog(StrReplace(script, "\n", "\.n"))

pattern := " (x|y|w|h)(\d+)\b"
newText := scriptText
SetFormat Float, 0.0 ; 0 means no leading 0, 2 means 2 decimals
X:=1
while (X := RegExMatch(scriptText, "U)" . pattern, M, X+StrLen(M))) {
    ; scriptlog(X . " >" . toJson(M) . " " . toJson(M1) . " " . toJson(M2))
    newNum := M2 / scale
    ; Percent := (M2 / 100) * 20 
	; nieuwvoorschot := (Bedrag - Percent) 
    scriptlog("Found number " . M2 . "... Scaling down by " . scale . " to " . newNum)
    newText := StrReplace(newText, M, " " . M1 . newNum)
}
FileAppend, % newText, % newscript

; re := new regexp(pattern)
; resultsArr := re.exec(scriptText)
; for i, result in resultsArr {
;     pos := RegExMatch(result, "O)" . pattern, split)
;     scriptlog(toJson(pos) . toJson(split) . toJson(split1) . toJson(split2))
;     ; StrReplace(scriptText, result, )
; }

; scriptlog("before")
; pos := grepcsv(scriptText, "O)" . pattern, v)
; scriptlog("after")
; scriptlog("pos > " . toJson(v))
; for i, match in v {
;     match_res := match
;     scriptlog("1")
;     ; scriptlog(i . " >" . toJson(match_res))
; }

; for i, match in GlobalMatches(scriptText, pattern) {
;     scriptlog(i . " >" . toJson(match))
; }

; TotalLength := StrLen(scriptText)
; Matchposition := 1
; Loop
; {
; 	Matchposition := RegExMatch(scriptText, pattern, CurrentMatch, Matchposition) ; Use last match position + 1 as starting position and put the next match in "CurrentMatch"
; 	If !Matchposition ; if no more matches are found, exit the loop
; 		Break
; 	AllMatches .= CurrentMatch ; concatenate matches
; 	Matchlength := StrLen(CurrentMatch)
; 	If !Matchlength
; 		Matchlength := 1	; prevent infinite loop due to zero-length matches.
; 	Matchposition += Matchlength
; 	If (Matchposition > TotalLength) ; prevent infinite loop if there is a zero-length match at the string end. This position is at length + 1 because the very first position (before the first character) is defined as 1.
; 		Break
; }

; While (Matchposition := RegExMatch(scriptText, pattern, CurrentMatch, ((Matchposition ? Matchposition : 0) + (StrLen(CurrentMatch) ? StrLen(CurrentMatch) : 1)))) && !(Matchposition > StrLen(Source))
; 	scriptlog(toJson(CurrentMatch))

; while (X := RegExMatch(scriptText, pattern, M, X+StrLen(M))) {
;     if !StrLen(M)
;         X++, continue
;     else
;         scriptlog(toJson(M))
; }

; obj := []
; while pos := RegExMatch(scriptText, "(x|y|w|h)(\d+)", matched, A_Index=1?1: pos+StrLen(matched))
; {
; 	if obj[matched]
; 		continue
; 	obj[matched] := true
; 	scriptlog(toJson(matched))
; }



; scriptlog("Found " . toJson(SubPat.Count()) . " matches at " . toJson(FoundPos))
; scriptlog(toJson(SubPat))

; Msgbox % SubPat.Count() ": " SubPat.Value(1) " " SubPat.Name(2) "=" SubPat["nr"]  ; Displays "2: Michiganroad nr=72"
; PasteToNotepad()
scriptlog("end")