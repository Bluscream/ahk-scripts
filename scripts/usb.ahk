; #SingleInstance, Force
; #Persistent
SetWorkingDir, %A_ScriptDir%

global noui := false
#Include <bluscream>
txt := A_ScriptFullPath . " " .  Join(" ", A_Args)
scriptlog(txt)
MsgBox % txt
SleepS(5)