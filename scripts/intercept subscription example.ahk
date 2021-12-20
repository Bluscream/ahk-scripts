#SingleInstance force
#Persistent
#include Lib\AutoHotInterception.ahk

AHI := new AutoHotInterception()

keyboardId := AHI.GetKeyboardId(0x04D9, 0x1702)
AHI.SubscribeKey(keyboardId, GetKeySC("1"), true, Func("KeyEvent"))
return

KeyEvent(state){
	ToolTip % "State: " state
}

^Esc::
	ExitApp