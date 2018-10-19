; Version 10/18/2018
global noui := False
global ui := False
startsWith(string, substring){
    return InStr(string, substring) == 1
}
endsWith(string, substring){
    return string ~= RegExEscape(substring) . "$"
}
RegExEscape(String)
{
	return "\Q" StrReplace(String, "\E", "\E\\E\Q") "\E"
}
scriptlog(msg, timestamp := "") {
    ; if(noui == true)
    ;     return
    if(ui == false){
        ListVars
        WinWait ahk_class AutoHotkey
        ControlSetText Edit1, , ahk_class AutoHotkey
        ui := true
    }
    ControlGetText, Edit1Text, Edit1, ahk_class AutoHotkey
    if (!timestamp)
        FormatTime, timestamp, A_Now, hh:mm:ss
    ControlSetText Edit1, %Edit1Text%[%timestamp%] %msg%`r`n, ahk_class AutoHotkey
    PostMessage, 0x115, 7, , Edit1, ahk_class AutoHotkey
}
PostClick(hwnd, X, Y, Count=1, Delay=50)
{ ; By Infogulch
	p := y << 16 | (x & 0xffff)
	Loop, %Count% {
		PostMessage, 0x201, 1, p, , ahk_id %hwnd%
		If (Delay)
			Sleep Delay
		PostMessage, 0x202, 0, p, , ahk_id %hwnd%
		If (Delay)
			Sleep Delay
	}
}