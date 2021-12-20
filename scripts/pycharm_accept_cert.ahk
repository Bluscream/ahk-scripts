; Always run as admin
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}
#SingleInstance, Force
#Persistent
Start:
SetTimer, CloseDialogue
CloseDialogue:
    WinWaitActive, Untrusted Server's Certificate
	SendInput {enter}
	PostMessage, 0x112, 0xF060,,, Untrusted Server's Certificate
	Sleep 50
Return
Sleep 500
Goto, Start