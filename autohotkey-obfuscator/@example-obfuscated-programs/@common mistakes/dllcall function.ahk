#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;[!! IMPORTANT !!]
;$OBFUSCATOR: $STRAIGHT_MODE:

msgbox this will NOT work if obfuscated
IsWindowVisible()
msgbox this will work in ANY cases
IsWindowVisibleFct()

return
;[!! IMPORTANT !!] put after the end of the autoexecute section
;$OBFUSCATOR: $END_AUTOEXECUTE: 

;[!! MISTAKE !!] DO NOT GIVE A FUNCTION THE SAME NAME AS A DLL CALL
; IsWindowVisible IN THE DLL CALL WILL BE REPLACED BY THE OBFUSCATED FUNCTION NAME
IsWindowVisible() {
Result:=DllCall("IsWindowVisible", "UInt", WinExist("Untitled - Notepad"))  
	if ErrorLevel
		msgbox error %ErrorLevel%
	else if !Result
		MsgBox, The notepad window IS NOT visible.
	else if Result
		MsgBox, The notepad window IS visible.
	
}

IsWindowVisibleFct() {
Result:=DllCall("IsWindowVisible", "UInt", WinExist("Untitled - Notepad"))  
	if ErrorLevel
		msgbox error %ErrorLevel%
	else if !Result
		MsgBox, The notepad window IS NOT visible.
	else if Result
		MsgBox, The notepad window IS visible.
	
}