JoystickNumber = 0
if JoystickNumber <= 0
{
    Loop 16
    {
        GetKeyState, JoyName, %A_Index%JoyName
        if JoyName <>
        {
            JoystickNumber = %A_Index%
			MsgBox, The system detected your joystick as connected to the %A_Index% port.
            break
        }
    }
    if JoystickNumber <= 0
    {
        MsgBox, The system does not appear to have any joysticks.
        ExitApp
    }
}
Hotkey, %JoystickNumber%Joy1, MyLabel, on
return

MyLabel:
	MsgBox, %A_ThisHotkey% pressed.
return