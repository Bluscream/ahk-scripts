; This script was created using Pulover's Macro Creator
; www.macrocreator.com

#NoEnv
SetWorkingDir %A_ScriptDir%
CoordMode, Mouse, Window
SendMode Input
#SingleInstance Force
SetTitleMatchMode 2
#WinActivateForce
SetControlDelay 1
SetWinDelay 0
SetKeyDelay -1
SetMouseDelay -1
SetBatchLines -1


F3::
BasicDemo:
SendMode, Event
SetKeyDelay, 10
Run, Notepad, , , Npid
WinWait, ahk_pid %Npid%
Sleep, 333
WinMove, ahk_pid %Npid%,, 400, 400, 800, 600
Sleep, 333
SendRaw, 
(LTrim
Hello,

This is the demonstration macro for Pulover's Macro Creator.


)
Run, Notepad, , , Npid2
WinWait, ahk_pid %Npid2%
Sleep, 333
WinActivate, ahk_pid %Npid%
Sleep, 333
WinMove, ahk_pid %Npid2%,, 0, 0, 800, 600
Sleep, 333
SendRaw, 
(LTrim
Here we're using commonly used commands, such as [Run], [WinActivate], [Send] and [Click].

This text was sent directly to the active window using [Send] from the [Text] command window.


)
Sleep, 2000
ControlSendRaw, Edit1, 
(LTrim
While this one was sent directly to the target control of a background window.
Check [Control] in the command window and use the [...] button to copy the information
from a window to send commands directly to it.


), ahk_pid %Npid2%
Sleep, 2000
ControlSendRaw, Edit1, You can also set the text of the entire control..., ahk_pid %Npid2%
Sleep, 2000
ControlSetText, Edit1, ...LIKE THIS!!!, ahk_pid %Npid2%
Sleep, 2000
ControlSend, Edit1, {Control Down}{End}{Control UP}{Enter 2}Move the mouse cursor and click with any button{!}, ahk_pid %Npid2%
Click, -6, -122 Left, 1
Sleep, 10
Sleep, 2000
Click, 693, 293 Left, Down
Sleep, 10
Sleep, 300
Click, 12, 62 Left, Up
Sleep, 10
Sleep, 2000
SendRaw, 
(LTrim
You can use [ControlClick] by checking the [Control] option
in the [Mouse] command window to click on windows on the background...
)
Sleep, 2000
Run, charmap
WinWait, ahk_exe charmap.exe
Sleep, 333
WinMove, ahk_exe charmap.exe,, 800, 0
Sleep, 333
WinActivate, ahk_pid %Npid2%
Sleep, 333
ControlClick, CharGridWClass1, ahk_exe charmap.exe,, Left, 1,  x175 y63 NA
Sleep, 1000
ControlClick, CharGridWClass1, ahk_exe charmap.exe,, Left, 1,  x106 y61 NA
Sleep, 1000
ControlClick, CharGridWClass1, ahk_exe charmap.exe,, Left, 1,  x335 y36 NA
Sleep, 1000
Sleep, 2000
SendRaw, 
(LTrim


...and the [Control] command window can be used to change
different things in a control or get informations from it...
)
Sleep, 2000
Control, ChooseString`, Arial, ComboBox3, ahk_exe charmap.exe
Sleep, 2000
Control, ChooseString`, Verdana, ComboBox3, ahk_exe charmap.exe
Sleep, 2000
Control, Disable`,, RICHEDIT50W1, ahk_exe charmap.exe
Sleep, 2000
ControlGetText, StaticText, Static1, ahk_exe charmap.exe
MsgBox, 0, , 
(LTrim
Text from charmap static control:

%StaticText%
)
MsgBox, 36, , 
(LTrim
Too fast? Play it again!

You can choose what commands you want to execute by unchecking the ones you don't want in the macro list.

You can also select to run only selected rows in [Macro > Playback options] and set a hotkey to play this macro step-by-step.

This was just a small demonstration, PMC can do a lot more! Take some time to study the commands in this macro and learn what each one does.

Download more examples from the Help file in the [Tutorial] section and check out the video tutorials at http://macrocreator.com/help.

Would like to see the videos now?

)
IfMsgBox, Yes
{
    Run, http://macrocreator.com/help
}
Return

