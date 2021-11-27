#SingleInstance, force
#Include <bluscream>
; global script_debug := new Window("BlackSquad (64-bit, DX9)", "LaunchCombatUWindowsClient", "BlackSquadGame.exe")

CoordMode, Mouse, Screen
Menu, tray, add, Debug, debugFunc

if (script_debug) {
	global file := new Paths.User().desktop.CombineFile("coords", script_debug.title . ".txt")
	file.appendLine("[" . A_Now . "] " . script_debug.str())
	global lastX := 0
	global lastY := 0
	global lastChangeX := ""
	global lastChangeY := ""
} else {
	Gui, +AlwaysOnTop -Caption -Border +E0x20 
	Gui, Color, Yellow
	Gui, Show, NoActivate w51 h51, MouseSpot

	WinSet, Trans, 100, MouseSpot
	WinSet, Region, 0-0 W51 H51 E, MouseSpot
}

loop ;  . (WinActive(script_debug) ? " (Active)" : " (Inactive)" ) ; . "`n" . script_debug
{
	MouseGetPos, MX, MY
	if (script_debug) {
		if (WinActive(script_debug.str())) {
			ToolTip, % "x" . MX . " " . lastChangeX . " y" . MY . " " . lastChangeY
		}
	} else {
		WinMove, MouseSpot,, MX - 25, MY - 25
	}
	Sleep, 25
}
return

~LButton::
	Gui, Color, Lime
	if (WinActive(script_debug.str())) {
		lastChangeX := MX - lastX
		lastChangeX := (lastChangeX >= 0) ? "+" . lastChangeX : lastChangeX
		lastChangeY := MY - lastY
		lastChangeY := (lastChangeY >= 0) ? "+" . lastChangeY : lastChangeY
		lastX := MX
		lastY := MY
		file.appendLine("x" . MX . " " . lastChangeX . " y" . MY . " " . lastChangeY)
	}
	KeyWait, LButton
	Gui, Color, Yellow
return

~RButton::
	Gui, Color, Red
	KeyWait, RButton
	Gui, Color, Yellow
return

DebugFunc:
    PasteToNotepad(toJson(file, true))
	return