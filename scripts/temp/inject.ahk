#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
Control, Hide,,Button37, ahk_class CalcFrame
ControlSetText, Button38,:-), ahk_class CalcFrame

#IfWinActive, ahk_class CalcFrame
LButton::
WinGet, x, ID, ahk_class CalcFrame
MouseGetPos,,, xwin, xcontrol
if ( x == xwin AND xcontrol = "Button38")
ToolTip, hello world
else
 Click
return
#IfWinActive