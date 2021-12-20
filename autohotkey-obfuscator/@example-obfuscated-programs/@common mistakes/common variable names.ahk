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
local test
;$OBFUSCATOR: $DEFLOSVARS: test
;[!! MISTAKE !!] DO NOT OBFUSCATE VARIABLES THAT HAVE TOO COMMON NAMES
;as invalid replacements will occur
;Either do not obfuscate the variable, OR give it a less common name
;THIS IS THE SAME FOR LABEL NAMES
test:="The test word will be obfuscated as it will be interpreted as possible obfuscated variable"
msgbox % test

}