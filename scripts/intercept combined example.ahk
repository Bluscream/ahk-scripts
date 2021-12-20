#SingleInstance force
#Persistent
#include Lib\AutoHotInterception.ahk

global AHI := new AutoHotInterception()

keyboardId := AHI.GetKeyboardId(0x04D9, 0x1702)

AHI.SubscribeKey(keyboardId, GetKeySC("2"), true, Func("KeyEvent"))

cm1 := AHI.CreateContextManager(keyboardId)
return

KeyEvent(state){
	static ctrlCode := GetKeySC("Ctrl")
	global keyboardId
	;~ AHI.SendKeyEvent(keyboardId, ctrlCode, state)
	ToolTip % "State: " state
}

#if cm1.IsActive
::aaa::JACKPOT
1:: 
	ToolTip % "KEY DOWN EVENT @ " A_TickCount
	return
	
1 up::
	ToolTip % "KEY UP EVENT @ " A_TickCount
	return
#if

^Esc::
	ExitApp