#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;[!! IMPORTANT !!] use this statement to set dynamic obfuscation
;$OBFUSCATOR: $DYNAMIC_MODE:

;[!! IMPORTANT !!] DUMP CALLS : For dynamic obfuscation we need to call these functions before anything needs to be obfuscated
;**************************************
;DUMP FUNCTION CALLS (DUMP FUNCTIONS ARE INSERTED BELOW)
obf_dumpcommonobjfrags() 
obf_dumpunclassed() 
obf_dumpunsecclasses() 
obf_dumpall() 
;************************************* 


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

;[!! IMPORTANT !!] DUMP FUNCTIONS : JUST COPY PASTE THIS INTO YOUR SCRIPT
;*************************************************************
;         O B F   D U M P   F U C T I O N S 
;************************************************************* 
;$OBFUSCATOR: $FUNCS_CHANGE_DEFAULTS: ,, -1 
obf_dumpcommonobjfrags() 
{ 
global 
;$OBFUSCATOR: $DUMP_SECFRAGS_FORCLASSES: common 
;$OBFUSCATOR: $DUMP_TMESSFRAGS_FORCLASSES: common 
} 
;$OBFUSCATOR: $FUNCS_RESTORE_DEFAULTS: 

;$OBFUSCATOR: $FUNCS_CHANGE_DEFAULTS: ,, -1 
obf_dumpunclassed() 
{ 
global 
;$OBFUSCATOR: $FUNCFRAGS_DUMPCLASS: unclassed 
;$OBFUSCATOR: $LABELFRAGS_DUMPCLASS: unclassed 
} 

obf_dumpunsecclasses() 
{ 
global 
;$OBFUSCATOR: $FUNCFRAGS_DUMPCLASS: unsecclasses 
;$OBFUSCATOR: $LABELFRAGS_DUMPCLASS: unsecclasses 
} 
;$OBFUSCATOR: $FUNCS_RESTORE_DEFAULTS: 

obf_dumpall() 
{ 
global 
;$OBFUSCATOR: $ALLFRAGS_DUMPALL: 
}