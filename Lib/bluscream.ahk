; Date 10/18/2018
ObjectCount(object) {
    count := 0
    for index, value in object {
        count++
    }
    return count
}
InList(haystack, needles*)
{
    for i, needle in (needles.Count() = 1 ? StrSplit(needles[1], ",") : needles)
        if (haystack = needle)
            return true
}
NewLine(){
    return "`r`n"
}
startsWith(string, substring) {
    return InStr(string, substring) == 1
}
endsWith(string, substring) {
    return string ~= RegExEscape(substring) . "$"
}
RegExEscape(String) {
	return "\Q" StrReplace(String, "\E", "\E\\E\Q") "\E"
}
StrStrip(string) {
    return RegexReplace(string, "^\s+|\s+$")
}
Join(sep, params*) {
    str := ""
    for i,param in params
        str .= sep . param
    return SubStr(str, StrLen(sep)+1)
}
JoinArray(strArray)
{
  s := ""
  for i,v in strArray
    s .= ", " . v
  return substr(s, 3)
}

global ui := False
scriptlog(msg, timestamp := "", append := false) {
    if(noui == true)
        return
    if(ui == false){
        ListVars
        WinWait ahk_class AutoHotkey
        ControlSetText Edit1, , ahk_class AutoHotkey
        ui := true
    }
    ControlGetText, Edit1Text, Edit1, ahk_class AutoHotkey
    if (!timestamp) {
        FormatTime, timestamp, A_Now, hh:mm:ss
    }
    msg := StrReplace(msg, "\n" , "`r`n")
    msg := StrReplace(msg, "\t" , "`t")
    if (timestamp == "append") {
        ControlSetText Edit1, %Edit1Text%%msg%, ahk_class AutoHotkey
    } else if (timestamp == "inline") {
        FormatTime, timestamp, A_Now, hh:mm:ss
        ControlSetText Edit1, %Edit1Text%[%timestamp%] %msg%, ahk_class AutoHotkey
    } else {
        ControlSetText Edit1, %Edit1Text%[%timestamp%] %msg%`r`n, ahk_class AutoHotkey
    }
    PostMessage, 0x115, 7, , Edit1, ahk_class AutoHotkey
}
global lastToolTip := ""
ShowToolTip(msg){
    if (msg == lastToolTip) {
        return
    }
    lastToolTip := msg
    ToolTip, %msg%
}
WriteToFile(path, String) {
    if !String {
        return
    }
    file := FileOpen(path, "w", "UTF-8")
    if !IsObject(file)
    {
        MsgBox Can't open "%path%" for writing.
        return
    }
    file.Write(String)
    file.Close()
}
HexToString(String) { 
   local Length, CharStr, RetString 
   If !String 
      Return 0 
   Length := StrLen(String)//2 
   Loop, %Length%
   { 
      StringMid, CharStr, String, A_Index*2 - 1, 2 
      CharStr = 0x%CharStr%
      RetString .= Chr(CharStr) 
      
      } 
   Return RetString 
   }
StringToHex(String, spaces := true) {
	local Old_A_FormatInteger, CharHex, HexString
	If !String
		Return 0
	Old_A_FormatInteger := A_FormatInteger
	SetFormat, INTEGER, H
	Loop, Parse, String 
    {
		CharHex := Asc(A_LoopField)
		StringTrimLeft, CharHex, CharHex, 2
		HexString .= CharHex . (spaces ? " " : "") 
    }
	SetFormat, INTEGER, %Old_A_FormatInteger%
	Return HexString
}
PostClick(hwnd, X, Y, Count=1, Delay=50)
{ ; By Infogulch
	p := y << 16 | (x & 0xffff)
	Loop, %Count%
    {
		PostMessage, 0x201, 1, p, , ahk_id %hwnd%
		If (Delay)
			Sleep Delay
		PostMessage, 0x202, 0, p, , ahk_id %hwnd%
		If (Delay)
			Sleep Delay
	}
}
SleepS(seconds) {
    Sleep, seconds * 1000
}
WaitForKey(msg="", key="NumpadAdd"){
    scriptlog(msg . "Press " . key . " When ready!")
    if (key == "anything") {
        Input, L, L1   
    } else if (key == "any key") {
        Input, SingleKey, L1, {LControl}{RControl}{LAlt}{RAlt}{LShift}{RShift}{LWin}{RWin}{AppsKey}{F1}{F2}{F3}{F4}{F5}{F6}{F7}{F8}{F9}{F10}{F11}{F12}{Left}{Right}{Up}{Down}{Home}{End}{PgUp}{PgDn}{Del}{Ins}{BS}{Capslock}{Numlock}{PrintScreen}{Pause}
    } else {
        KeyWait, % key, D
    }
}
PressKey(key, presses=1, sleepms=80, keyms=20, verbose=false, msg="") {
    if (verbose) scriptlog("Pressing key " . key . " " . (presses > 1 ? presses . " times (interval: " . keyms . " " : "(") . "delay: " . sleepms . ")" . (msg ? ": " . msg : ""))
    loop, % presses {
        Send, % "{" key " down}"
        Sleep, %keyms%
        Send, % "{" key " up}"
        Sleep, %sleepms%
    }
}
PressKeyDLL(key, presses=1, keyms=20){
    key_vk := GetKeyVK(key)
    key_sc := GetKeySC(Key)
    loop, % presses {
        dllcall("keybd_event", "UChar", key_vk, "UChar", key_sc, "UInt", 0, "Ptr", 0)
        Sleep, %keyms%
        dllcall("keybd_event", "UChar", key_vk, "UChar", key_sc, "UInt", 0x2, "Ptr", 0)
    }
}

#Include <AutoHotInterception>
global AHI := false
PressKeyAHI(key, presses=1, keyms=100){
    if (!AHI) {
        AHI := new AutoHotInterception()
    }
    loop, % presses {
        AHI.SendKeyEvent(1, GetKeySC(key), 1)
        Sleep, %keyms%
        AHI.SendKeyEvent(1, GetKeySC(key), 0)
    }
}
DownKeyAHI(key){
    if (!AHI) {
        AHI := new AutoHotInterception()
    }
    AHI.SendKeyEvent(1, GetKeySC(key), 1)
}
UpKeyAHI(key){
    if (!AHI) {
        AHI := new AutoHotInterception()
    }
    AHI.SendKeyEvent(1, GetKeySC(key), 0)
}