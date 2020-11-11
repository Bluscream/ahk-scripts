CoordMode, Mouse, Screen

Gui, +AlwaysOnTop -Caption -Border +E0x20 
Gui, Color, Yellow
Gui, Show, NoActivate w51 h51, MouseSpot

WinSet, Trans, 100, MouseSpot
WinSet, Region, 0-0 W51 H51 E, MouseSpot

loop
{
	MouseGetPos, MX, MY
	WinMove, MouseSpot,, MX - 25, MY - 25
}
return

~LButton::
	Gui, Color, Lime
	KeyWait, LButton
	Gui, Color, Yellow
return

~RButton::
	Gui, Color, Red
	KeyWait, RButton
	Gui, Color, Yellow
return