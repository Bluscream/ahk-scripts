#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

globalvar1:="The value of global is:"
globalvar2:="This is a test"

;test obfuscation of function call
testfunction()

return


testfunction(paramvar="params are automatically obfuscated") {
global
local localvar1,localvar2

localvar1:="The value of local is:"
localvar2:="This is a test"
msgbox % localvar1 "`n" localvar2 "`n" globalvar1 "`n" globalvar2 "`n" paramvar

}