; Date 10/18/2018
#Include <JSON>
GetJson(url, auth := "") {
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpObj.Open("GET", url, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    if (auth != "") {
        HttpObj.SetRequestHeader("Authorization", "Basic " . auth)
    }
    Wait := HttpObj.Send()
    return JSON.Load(HttpObj.ResponseText)
}
GetString(url) {
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpObj.Open("GET", url, 0)
    Wait := HttpObj.Send()
    return HttpObj.ResponseText
}
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
Join(s,p*){
  static _:="".base.Join:=Func("Join")
  for k,v in p
  {
    if isobject(v)
      for k2, v2 in v
        o.=s v2
    else
      o.=s v
  }
  return SubStr(o,StrLen(s)+1)
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
Paste(text) {
    clipboard_backup := clipboard
    Sleep, 10
    clipboard := text
    Sleep, 10
    Send, ^v
    Sleep, 10
    clipboard := clipboard_backup
}
EscapeCurly(text) {
    ; str := StrReplace(str, "{", "{{}" ; Sends {
    ; str := StrReplace(str, "}", "{}}" ; Sends }
    ; return StrReplace(str, "{}", "{{}{}}" ; Sends {}
    Loop, Parse, text              ; retrieves each character from the variable, one at a time
    {
        if (A_LoopField == "{") {
            str .= "{{}"
        } else if (A_LoopField == "}") {
            str .= "{}}"
        } else {
            str .= A_LoopField
        }
    }
    return str
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
Process_Suspend(PID_or_Name, resume=false){
    PrID := (InStr(PID_or_Name,".")) ? ProcessExists(PID_or_Name) : PID_or_Name
    h := DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", PrID)
    if (!h) {
       Return 1
    }
    tmp_ := "ntdll.dll\Nt" . (resume ? "Resume" : "Suspend") . "Process"
    ret := DllCall(tmp_, "Int", h)
    MsgBox, % tmp_ . " | " . h
    DllCall("CloseHandle", "Int", h)
    return ret
}
SplashScreen(title, text="", time=1000) {
    SplashImage, , b FM18 fs12, % title, % text
    Sleep, % time
    SplashImage, Off
}
ProcessExists(PID_or_Name){
   Process, Exist, % PID_or_Name
   Return Errorlevel
}
EnforceAdmin() {
    CommandLine := DllCall("GetCommandLine", "Str")
    If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
        Try {
            If (A_IsCompiled) {
                Run *RunAs "%A_ScriptFullPath%" /restart
            } Else {
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
            }
        }
        ExitApp
    }
}
RestartScript(asAdmin := true) {
    CommandLine := DllCall("GetCommandLine", "Str")
    if (RegExMatch(CommandLine, " /restart(?!\S)")) {
        return
    }
    Try {
        If (A_IsCompiled) {
            if (asAdmin) {
                Run *RunAs "%A_ScriptFullPath%" /restart
            } else {
                Run "%A_ScriptFullPath%" /restart
            }
        } Else {
            if (asAdmin) {
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
            } else {
                Run "%A_AhkPath%" /restart "%A_ScriptFullPath%"
            }
            
        }
    }
    ExitApp
}
ProcessCPULoad(PID_or_Name) {
    PID := (InStr(PID_or_Name,".")) ? ProcessExists(PID_or_Name) : PID_or_Name
    Static oldKrnlTime, oldUserTime
    Static newKrnlTime, newUserTime

    oldKrnlTime := newKrnlTime
    oldUserTime := newUserTime

    hProc := DllCall("OpenProcess", "Uint", 0x400, "int", 0, "Uint", PID)
    DllCall("GetProcessTimes", "Uint", hProc, "int64P", CreationTime, "int64P"
           , ExitTime, "int64P", newKrnlTime, "int64P", newUserTime)

    DllCall("CloseHandle", "Uint", hProc)
Return (newKrnlTime-oldKrnlTime + newUserTime-oldUserTime)/10000000 * 100   
}
CPULoad() { ; By SKAN, CD:22-Apr-2014 / MD:05-May-2014. Thanks to ejor, Codeproject: http://goo.gl/epYnkO
Static PIT, PKT, PUT                           ; http://ahkscript.org/boards/viewtopic.php?p=17166#p17166
  IfEqual, PIT,, Return 0, DllCall( "GetSystemTimes", "Int64P",PIT, "Int64P",PKT, "Int64P",PUT )

  DllCall( "GetSystemTimes", "Int64P",CIT, "Int64P",CKT, "Int64P",CUT )
, IdleTime := PIT - CIT,    KernelTime := PKT - CKT,    UserTime := PUT - CUT
, SystemTime := KernelTime + UserTime 

Return ( ( SystemTime - IdleTime ) * 100 ) // SystemTime,    PIT := CIT,    PKT := CKT,    PUT := CUT 
}
class Window {
    title := ""
    class := ""
    exe := ""
    
    __New(title, class, exe) {
        this.title := title
        this.class := class
        this.exe := exe
    }


    str() {
        return (this.title ? this.title : "") . (this.class ? (" ahk_class " . this.class) : "") . (this.exe ? (" ahk_exe " . this.exe) : "")
    }
    
    exists() {
        return WinExist(this.str())
    }
    isActive() {
        return WinActive(this.str())
    }
    isMinimized() {
        WinGet MMX, MinMax, % this.str()
        return (MMX == -1)
    }
    activate() {
        WinActivate, % this.str()
        WinWaitActive, % this.str()
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