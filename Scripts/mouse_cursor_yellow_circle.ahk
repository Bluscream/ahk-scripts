#SingleInstance, force
#Include <bluscream>
global script_debug := true

CoordMode, Mouse, Screen

if (script_debug) {
	global file := new File("coords.txt")
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

loop
{
	MouseGetPos, MX, MY
	if (script_debug)
		ToolTip, % "x" . MX . " " . lastChangeX . " y" . MY . " " . lastChangeY
	else
		WinMove, MouseSpot,, MX - 25, MY - 25
}
return

~LButton::
	Gui, Color, Lime
	if (script_debug)
		lastChangeX := MX - lastX
		lastChangeX := (lastChangeX >= 0) ? "+" . lastChangeX : lastChangeX
		lastChangeY := MY - lastY
		lastChangeY := (lastChangeY >= 0) ? "+" . lastChangeY : lastChangeY
		lastX := MX
		lastY := MY
		if (WinActive("ahk_class UnityWndClass"))
			file.appendLine("x" . MX . " " . lastChangeX . " y" . MY . " " . lastChangeY)
	KeyWait, LButton
	Gui, Color, Yellow
return

~RButton::
	Gui, Color, Red
	KeyWait, RButton
	Gui, Color, Yellow
return