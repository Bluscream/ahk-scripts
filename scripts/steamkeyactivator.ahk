#NoEnv
#Warn All, Off
#singleinstance force
SendMode Input
SetWorkingDir %A_ScriptDir%

steam_activate_key(key){
	if(key = ""){
		return
	}
	FormatTime, Time,, dd/MM/yyyy HH:mm:ss tt
	steam_close_all()
	steam_open_activation_window()
	steam_move_window()
	steam_click_next()
	steam_click_next()
	steam_activate_product_code_field()
	steam_send_input(key)
	steam_click_next()
	steam_wait_until_done()
	steam_click_cancel()
	return
}

steam_click_next(){
	steam_activate_window()
	MouseClick, left,  320,  375
	Sleep,100
	return
}
steam_click_cancel(){
	steam_activate_window()
	MouseClick, left,  422,  375
	Sleep,100
	return
}
steam_click_back(){
	steam_activate_window()
	MouseClick, left,  212,  375
	Sleep,100
	return
}
steam_click_print(){
	steam_activate_window()
	MouseClick, left,  221,  407
	Sleep,100
	return
}
steam_install_click_back(){
	steam_activate_install()
	MouseClick, left,  212,  375
	Sleep,100
	return

}
steam_install_click_cancel(){
	steam_activate_install()
	MouseClick, left,  422,  375
	Sleep,100
	return
}
steam_install_click_next(){
	steam_activate_install()
	MouseClick, left,  320,  375
	Sleep,100
	return
}
steam_activate_product_code_field(){
	steam_activate_window()
	MouseClick, left,  40,  190
	Sleep, 100
	return
}
steam_send_input(input){
	steam_activate_window()
	SendInput {Raw}%input%
	Sleep,100
	return
}

steam_activate_window(){
	WinWait, Product Activation,
	IfWinNotActive, Product Activation, , WinActivate, Product Activation,
	WinWaitActive, Product Activation,
	Sleep, 100 ;
}
steam_activate_install(){
	WinWait, Install -,
	IfWinNotActive, Install -, , WinActivate, Install -,
	WinWaitActive, Install -,
	Sleep,100
}
steam_wait_until_done(){
	Sleep,900
	WinWaitNotActive,Steam - Working
}
steam_move_window(){
	steam_activate_window()
	WinMove, 0, 0
	Sleep,100
	return
}
steam_open_activation_window(){
	Run steam://open/activateproduct
	Sleep,100
	return
}
steam_close_all(){
	IfWinExist,Product Activation,
	{
		steam_activate_window()
		steam_click_back()
		steam_click_back()
		steam_click_cancel()
		WinKill,Product Activation,
		Sleep,1000
	}
	IfWinExist,Install -,
	{
		steam_activate_install()
		steam_install_click_cancel()
		WinKill,Install -,
		Sleep,1000

	}
	IfWinExist,Print,
	{
		WinKill,Print,
		Sleep,1000
	}
	return
}
steam_check_if_key_worked(){
	if(steam_check_invalid_or_too_many_attempts()){
		steam_click_cancel()
		return false
	}else{
		steam_click_print()
		steam_click_next()
		steam_check_if_on_install_screen()
		steam_install_click_cancel()

	}
}
steam_check_invalid_or_too_many_attempts(){
	steam_activate_window()
	MouseMove, 61,  207
	Sleep,100
	If(A_Cursor = "Unknown"){
		return true
	}else{
		return false
	}
}
steam_check_if_on_install_screen(){
	steam_activate_install()
	WinMove, 100, 100
	Sleep,100
	WinGetTitle, WindowTitle,
	StringTrimLeft,gameTitle,WindowTitle,10
}
is_print_window(){
	WinWait, Print,,5 ;wait 5 seconds.
	if ErrorLevel
	{
		return false
	}else{
		IfWinNotActive, Print, WinActivate, Print,
		WinWaitActive, Print,
		WinKill,Print,
		Sleep,100
		return true
	}
}

Loop %0%
{
	steam_activate_key(%A_Index%)
	Sleep,1000
}
Return