#NoEnv
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
#Include <bluscream>
EnforceAdmin() 
global noui := false
#INCLUDE <Acc>

; Direct SIM unlock ; TsBitBtn6 ; 4 ; Press ; push button

c::
WinGet, hWnd, ID, A
    oAcc := Acc_Get("Object", "4", 0, "ahk_id " hWnd)
	oAcc.accDoDefaultAction(0) 
 Return