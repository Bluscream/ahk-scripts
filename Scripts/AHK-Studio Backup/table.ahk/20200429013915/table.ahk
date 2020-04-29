;if not A_IsAdmin
;{
;   Run *RunAs "%A_ScriptFullPath%"
;   ExitApp
;}
#NoEnv
;#Warn
SendMode Input
SetWorkingDir %A_ScriptDir%
;#SingleInstance, Force
;#NoTrayIcon
;SetBatchLines, -1
;Process, Priority,, High
;RETURN