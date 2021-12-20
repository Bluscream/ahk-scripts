#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;[!! IMPORTANT !!]
;$OBFUSCATOR: $STRAIGHT_MODE:

testfunction()

return
;[!! IMPORTANT !!]
;$OBFUSCATOR: $END_AUTOEXECUTE: 


;[!! IMPORTANT !!] RESPECT THE FUNCTION CONVENTIONS
;only the Opening bracket CAN BE at character 1 of the line
;only the End bracket MUST BE at character 1 of the line
testfunction() {
global
local localvar1,localvar2
;$OBFUSCATOR: $DEFLOSVARS: localvar1,localvar2

localvar1:="The value of local is:"
localvar2:="This is a test"
if (something) 
	{
	msgbox THE BRACKETS ARE AT AN OK POSITION.
	}
if (something) 
{
;[!! MISTAKE !!] First position and last should be used only for opening and closing brackets of the function
msgbox THE BRACKETS ARE AT THE WRONG POSITIONS. 
}

;[!! WARNING !!] THE REST THEN WONT BE OBFUSCATED AND CAN EVEN BE MISSING FROM FINAL FILE (if scrambling)
msgbox % localvar1 "`n" localvar2 "`n" globalvar1 "`n" globalvar2

}