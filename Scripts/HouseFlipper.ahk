#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%
SetKeyDelay, -1
game_title = House Flipper Game
game_class = UnityWndClass
game_exe = HouseFlipper.exe
game = %game_title%
IfWinExist %game%
	winactivate %game%
else
	MsgBox, 4, %game% not found, Would you like to start the game now?,
	IfMsgBox, Yes
		run, "steam://rungameid/613100" ; "G:\House Flipper\HouseFlipper.exe"
WinWait %game%
WinActivate %game%
WinWaitActive %game%
return
#IfWinActive, House Flipper Game
    $LCtrl::
        Send {C down}
        Return
	MButton::Send % "{Click " . ( GetKeyState("LButton") ? "Up}" : "Down}" )
#IfWinActive
timer:
    If (!GetKeyState("LControl", "P"))
    {
        If (GetKeyState("C", "P"))
        {
            Send, {C up}
        }
    }