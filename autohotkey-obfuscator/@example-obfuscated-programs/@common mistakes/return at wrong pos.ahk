#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;[!! IMPORTANT !!]
;$OBFUSCATOR: $STRAIGHT_MODE:

Gosub testlabel

return
;[!! IMPORTANT !!] put after the end of the autoexecute section
;$OBFUSCATOR: $END_AUTOEXECUTE: 


;[!! IMPORTANT !!] RESPECT THE LABEL CONVENTIONS
;only the End return MUST BE at character 1 of the line
testlabel:
;$OBFUSCATOR: $DEFGLOBVARS: globalvar1,globalvar2

globalvar1:="The value of global is:"
globalvar2:="This is a test"

if (something) 
	{
	msgbox THE RETURN IS AT AN OK POSITION.
	return
	}
if (something) 
	{
	msgbox THE RETURN IS AT THE WRONG POSITION. 
;[!! MISTAKE !!] RETURN First position MUST be used only for the final closing return 
return
	}
;[!! WARNING !!] THE REST THEN WONT BE OBFUSCATED AND CAN EVEN BE MISSING FROM FINAL FILE (if scrambling)
msgbox % globalvar1 "`n" globalvar2

return