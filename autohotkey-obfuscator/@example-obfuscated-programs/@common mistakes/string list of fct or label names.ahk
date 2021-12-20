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
;[!! MISTAKE !!] DO NOT USE STRING LISTS OF FUNCTION OR LABEL NAMES THAT ARE OBFUSCATED
;Because the names won't be correctly detected and thus wont be obfuscated
CallFunctionsOrLabels("function1,Label1")
;MAKE SURE NAMES ARE SEPARATED PROPERLY LIKE THIS FOR EXAMPLE
CallFunctionsOrLabels("function1" . "," . "Label1")
}

function1() {
global
msgbox %A_ThisFunc%
}

Label1:
msgbox %A_ThisLabel%
return

CallFunctionsOrLabels(Fct_To_Call) {
Loop,parse,Fct_To_Call, `,
 {
	If IsFunc(A_Loopfield)
		%A_Loopfield%()
	else If IsLabel(A_Loopfield)
		Gosub %A_Loopfield%
	else
		msgbox the function was not recognized
	}
}