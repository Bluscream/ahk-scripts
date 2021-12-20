#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;[!! IMPORTANT !!] use this statement to set obfuscation IF YOU WANT STRAIGHT OBFUSCATION (most basic). Otherwise you need to use dumps functions for dynamic obfuscation.
;$OBFUSCATOR: $STRAIGHT_MODE:


;[!! IMPORTANT !!] You CAN ask to obfuscate your global variables 
;You CAN also use this command for local variables if you wish to put them all on top, and do not want to specify them each time inside the function
;$OBFUSCATOR: $DEFGLOBVARS: globalvar1,globalvar2

globalvar1:="The value of global is:"
globalvar2:="This is a test"

;test obfuscation of function call
testfunction()

return
;[!! IMPORTANT !!] put after the end of the autoexecute section
;$OBFUSCATOR: $END_AUTOEXECUTE: 


;[!! IMPORTANT !!] RESPECT THE FUNCTION CONVENTIONS
;only the opening bracket CAN be at character 1 of the line
;only the end bracket MUST BE at character 1 of the line
testfunction(paramvar="params are automatically obfuscated") {
global
local localvar1,localvar2
;[!! IMPORTANT !!] You CAN ask to obfuscate the local variables by listing them INSIDE the function
;$OBFUSCATOR: $DEFLOSVARS: localvar1,localvar2

localvar1:="The value of local is:"
localvar2:="This is a test"
msgbox % localvar1 "`n" localvar2 "`n" globalvar1 "`n" globalvar2 "`n" paramvar

}