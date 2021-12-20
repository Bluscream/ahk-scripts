#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;[!! IMPORTANT !!]
;$OBFUSCATOR: $STRAIGHT_MODE:

testfunction()

return
;[!! IMPORTANT !!] put after the end of the autoexecute section
;$OBFUSCATOR: $END_AUTOEXECUTE: 

testfunction() {
global
;[!! MISTAKE !!] DO NOT USE SUBSTRINGS OF FUNCTION OR LABEL NAMES THAT ARE OBFUSCATED
;Because the new obfuscated name will not match
if (SubStr(A_ThisFunc,1,4)="test")
	msgbox % this will not work once obfuscated
else if (A_ThisFunc="testfunction")
	msgbox % this will still work
}