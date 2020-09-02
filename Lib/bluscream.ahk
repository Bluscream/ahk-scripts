; Date 10/18/2018
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
mid$(input, startPos, replacement) {
 Return, SubStr(input,1,startPos-1) . replacement . SubStr(input,startPos+StrLen(replacement))
}
ReplaceAtPos(String, pos, Replacement) {
    IfGreater, Pos, % StrLen(String), Return, String
    Return, SubStr(String, 1, pos - 1) Replacement SubStr(String, pos + 1)
}
InList(haystack, needles*)
{
    for _i, needle in (needles.Count() = 1 ? StrSplit(needles[1], ",") : needles)
        if (haystack = needle)
            return true
}
singlePush(array, item) {
    if (array.indexOf(item) = -1) {
       array.push(item)
    }
}
RemoveDup(obj) {
	for _i, value in obj
		str.=value "`n"
	nodupArray:={}
	nodup:= "`n" 									; Added delimiter
	loop parse, str, `n
		if !InStr(nodup,  "`n"  A_LoopField "`n" )	; Added delimiter
		{
			nodup.=A_LoopField "`n"
			nodupArray.Push(A_LoopField)
		}
	Return nodupArray
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
RxMatches(Haystack, Needle) { ;from https://autohotkey.com/board/topic/88466-regexmatch-how-to-get-all-matches/#entry610223
	Result := []
	start = 1
	loop
    {
		if(!RegexMatch(haystack, needle, M, start)) {
			break
        }
		Result.Insert(M)
		start := M.Pos + M.Len
	}
	return Result
}
MatchBetween(Haystack,char1,char2) {
    Matches := [] , pos := 1
    while (pos1 := InStr(Haystack, char1,, pos)) && (pos2 := InStr(Haystack, char2,, pos))
        Matches.push(SubStr(Haystack,pos1+1,pos2-pos1-1)) , pos := pos2 + 1
    return Matches
}
StrStrip(string) {
    return RegexReplace(string, "^\s+|\s+$")
}
Join(s,p*){
  static _:="".base.Join:=Func("Join")
  o:=""
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
  for _i,v in strArray
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
    if (msg == "") {
        msg := toJson(msg)
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
WriteToFile(path, String) {
    if !String {
        return
    }
    _file := FileOpen(path, "w", "UTF-8")
    if !IsObject(_file)
    {
        MsgBox Can't open "%path%" for writing.
        return
    }
    _file.Write(String)
    _file.Close()
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
PasteToNotepad(text, bin := "notepad", paste := true) {
    global notePadPID := 0
    run, % bin,,, notePadPID
    WinWait, ahk_pid %notepadPID%
    WinActivate, ahk_pid %notepadPID%
    WinWaitActive, ahk_pid %notepadPID%
    if !(paste) {
        SetKeyDelay -1
        SetBatchLines -1
        SendInput % text
        return
    }
    paste(text)
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
GetIdleTimes() {
    return { "all": A_TimeIdle, "physical": A_TimeIdlePhysical, "keyboard": A_TimeIdleKeyboard, "mouse": A_TimeIdleMouse }
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
global lastToolTip := ""
ShowToolTip(msg){
    if (msg == lastToolTip) {
        return
    }
    lastToolTip := msg
    ToolTip, %msg%
}
SplashScreen(title, text="", time=1000) {
    SplashImage, , b FM18 fs12, % title, % text
    Sleep, % time
    SplashImage, Off
}
MultiLineInputBox(Text:="", Default:="", Caption:="AutoHotKey"){
    static
    ButtonOK:=ButtonCancel:= false
    if !MultiLineInputBoxGui{
        Gui, MultiLineInputBox: add, Text, r1 w600  , % Text
        Gui, MultiLineInputBox: add, Edit, r10 w600 vMultiLineInputBox, % Default
        Gui, MultiLineInputBox: add, Button, w60 gMultiLineInputBoxOK , &OK
        Gui, MultiLineInputBox: add, Button, w60 x+10 gMultiLineInputBoxCancel, &Cancel
        MultiLineInputBoxGui := true
    }
    GuiControl,MultiLineInputBox:, MultiLineInputBox, % Default
    Gui, MultiLineInputBox: Show,, % Caption
    SendMessage, 0xB1, 0, -1, Edit1, A
    while !(ButtonOK||ButtonCancel)
        continue
    if ButtonCancel
        return
    Gui, MultiLineInputBox: Submit, NoHide
    Gui, MultiLineInputBox: Cancel
    return MultiLineInputBox
    ;----------------------
    MultiLineInputBoxOK:
    ButtonOK:= true
    return
    ;---------------------- 
    MultiLineInputBoxGuiEscape:
    MultiLineInputBoxCancel:
    ButtonCancel:= true
    Gui, MultiLineInputBox: Cancel
    return
}
MultiLineInput(Text:="Waiting for Input") {
    Global MLI_Edit
    Gui, Add, Edit, vMLI_Edit x2 y2 w396 r4
    Gui, Add, Button, gMLI_OK x1 y63 w199 h30, &OK
    Gui, Add, Button, gMLI_Cancel x200 y63 w199 h30, &Cancel
    Gui, Show, h94 w400, %Text%
    Goto, MLI_Wait
    MLI_OK:
        GuiControlGet, MLI_Edit
    MLI_Cancel:
    GuiEscape:
        ReturnNow := True
    MLI_Wait:
        While (!ReturnNow)
            Sleep, 100
    Gui, Destroy
    Return %MLI_Edit%
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
class Directory {
    drive := ""
    path := ""
    __New(path) {
        if (!endsWith(path, "\")) {
            path .= "\"
        }
        this.path := path
        SplitPath,path,,,,, drive
        this.drive := drive
    }
    Combine(dirs*) {
        return new Directory(this.path . ("\".join(dirs)))
    }
    CombineFile(paths*) {
        return new File(this.path . ("\".join(paths)))
    }
}
EnvGet, localappdata, % "LOCALAPPDATA"
class Paths {
    class User {
        name := A_UserName                   ; blusc
        appdata := new Directory(A_AppData)           ; C:\Users\blusc\AppData\Roaming
        localappdata := new Directory(localappdata)   ; C:\Users\blusc\AppData\Local
        ; locallowappdata := new Directory(localappdata)    ; C:\Users\blusc\AppData\LocalLow
        temp := new Directory(A_Temp)                 ; C:\Users\blusc\AppData\Local\Temp
        desktop := new Directory(A_Desktop)           ; C:\Users\blusc\Desktop
        startmenu := new Directory(A_StartMenu)       ; C:\Users\blusc\AppData\Roaming\Microsoft\Windows\Start Menu
        programs := new Directory(A_Programs)         ; C:\Users\blusc\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
        startup := new Directory(A_Startup)           ; C:\Users\blusc\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
        documents := new Directory(A_MyDocuments)     ; C:\Users\blusc\Documents
    }
    class Public {
        desktop := new Directory(A_DesktopCommon)     ; C:\Users\Public\Desktop
        startmenu := new Directory(A_StartMenuCommon) ; C:\ProgramData\Microsoft\Windows\Start Menu
        programs := new Directory(A_ProgramsCommon)   ; C:\ProgramData\Microsoft\Windows\Start Menu\Programs
        startup := new Directory(A_StartupCommon)     ; C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
    }
    ahk := new File(A_AhkPath)                         ; C:\Program Files\AutoHotkey\AutoHotkey.exe
    network := "\\" . A_ComputerName . "\"
    scriptdir := new Directory(A_ScriptDir)           ; C:\Program Files\AutoHotKey\AutoGUI\Tools
    scriptname := A_ScriptName         ; A_Variables.ahk
    scriptpath := new File(A_ScriptFullPath)     ; C:\Program Files\AutoHotKey\AutoGUI\Tools\A_Variables.ahk
    linefile := new File(A_LineFile)             ; C:\Program Files\AutoHotKey\AutoGUI\Tools\A_Variables.ahk
    windir := new Directory(A_WinDir)                 ; C:\WINDOWS
    programfiles := new Directory(A_ProgramFiles)     ; C:\Program Files
    programdata := new Directory(A_AppDataCommon)     ; C:\ProgramData
    cmd := new File(A_ComSpec)                   ; C:\WINDOWS\system32\cmd.exe
}
class File {
    name := ""
    fullname := ""
    extension := ""
    drive := ""
    path := ""
    directory := new Directory()
    __New(parts*) {
        path := "\".join(parts)
        SplitPath, % path, fullname, dir, extension, name, drive
        this.path := path
        this.fullname := fullname
        this.extension := extension
        this.name := name
        this.drive := drive
        this.directory := new Directory(dir)
    }
    SplitPath() {
        SplitPath, % this.path, name, dir, ext, name_no_ext, drive
        return { "FullFileName": this.path, "name": name, "dir": dir, "ext": ext, "name_no_ext": name_no_ext, "drive": drive }
    }
    exists() {
        return FileExist(this.path)
    }
    size(units := "B") {
        FileGetSize, size, % this.path, % units
        return size 
    }
    open(destination, flags := "r", encoding := "UTF-8") {
        return FileOpen(this.path, flags, encoding)
    }
    play(wait := 0) {
        SoundPlay, % this.path, % wait
    }
    read() {
        FileRead, ret, % this.path
        return ret
    }
    readlines() {
        lines := ()
        Loop, Read, % this.path
            lines.push(A_LoopReadLine)
        return lines
    }
    append(txt, encoding := "UTF-8") {
        FileAppend, % txt, % this.path, % encoding
    }
    copy(destination, overwrite := false) {
        FileCopy, % this.path , % destination, % overwrite
    }
    move(destination, overwrite := false) {
        FileMove, % this.path , % destination, % overwrite
    }
    setAttributes(attributes) {
        FileSetAttrib, % attributes, % this.path
    }
}
class Window {
    title := ""
    class := ""
    exe := ""
    file := new File()
    
    __New(title := "", class := "", exe :="", path := "") {
        this.title := title
        this.class := class
        this.exe := exe
        this.file := path ? new File(path) : new File(exe)
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
    minimize() {
        WinMinimize, % this.str()
    }
    activate() {
        WinActivate, % this.str()
        WinWaitActive, % this.str()
    }
    pos() {
       ;WinGetPos, X, Y, Width, Height, WinTitle, WinText, ExcludeTitle, ExcludeText]
        WinGetPos,x,y,w,h, % this.str()
        cw := w
        ch := h
        ch /= 2 
        cw -= 1
        cw /= 2
        return { "x": x, "y": y, "w": w, "h": h, "center": { "w": cw, "h": ch } }
    }
}
class Process {
    name := ""
    file := new File()
    __New(name := "") {
        this.name := name
    }
    exists() {
        Process, Exist, % this.name
        return ErrorLevel
    }
    close() {
        if (this.exists()) {
            Process, Close, % this.name
            return this.exists()
        }
    }
    kill(force := true, wait := false) {
        if (this.exists()) {
            cmd := "taskkill " . force ?? "/f" . " /im " . this.name
            if (wait) {
                RunWait % cmd
                return this.exists()
            }
            Run % cmd
        }
    }
}
Array(prms*) {
	prms.base := _Array
	return prms
}
class _Array {
    join(p*) {
        for k,v in p {
            s .= this v
        }
        return SubStr(s,StrLen(this)+1)
    }
    scramble() {
        s := this.insertDelims(this, "|")
        Sort, s, Random, D|
        return StrReplace(s, "|")
    }
    insertDelimiters(str, delim) {
            for k,v in StrSplit(str) {
                Result .= delim v
            }
            Return, Result
    }
	singlePush(param_value) {
		if (this.indexOf(param_value) = -1) {
			this.Push("" item)
		}
	}
	indexOf(searchElement, fromIndex:=0) {	
		len := this.Count()
		if (fromIndex > 0)
			start := fromIndex - 1    ; Include starting index going forward
		else if (fromIndex < 0)
			start := len + fromIndex  ; Count backwards from end
		else
			start := fromIndex
		loop, % len - start
			if (this[start + A_Index] = searchElement)
				return start + A_Index
		return -1
	}
    last() {
        return this[this.MaxIndex()]
    }
    chunks(max:=1) { ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=80157
        if (max > this.Count())
            return [this]
        l_array := Array()
        if (max < 1)
            return l_array
        param_array := this.Clone()
        while (param_array.Count() > 0) {
            l_InnerArr := []
            loop, % max {
                if (param_array.Count() == 0) {
                    break
                }
                l_InnerArr.push(param_array.RemoveAt(1))
            }
        l_array.push(l_InnerArr)
        }
        return l_array
    }
}
#Include <JSON>
#Include <JSON_Beautify>
toJson(object, beautify := false) {
    if (beautify)
        return JSON_Beautify(object)
    return JSON.Dump(object)
}
#Include <json_toobj>
GetJson(url, auth := "") {
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpObj.Open("GET", url, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    if (auth != "") {
        HttpObj.SetRequestHeader("Authorization", "Basic " . auth)
    }
    HttpObj.SetTimeouts(0,30000,30000,120000)
    HttpObj.Send()
    HttpObj.WaitForResponse()
    _json := JSON.Load(HttpObj.ResponseText)
    if !(_json) {
        ; MsgBox % "GetJson ResponseText:"
        _json := json_toobj(HttpObj.ResponseText)
    }
    return _json
}
PostJson(url, payload) {
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    ; MsgBox % "PostJson.url: " . url
    HttpObj.Open("POST", url, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    _json := JSON.Dump(payload)
    if !(_json) {
        ; MsgBox % "PostJson payload:"
        _json := json_fromobj(payload)
    }
    ; MsgBox % "PostJson._json: " . toJson(_json)
    HttpObj.SetTimeouts(0,999999,999999,999999)
    HttpObj.Send(_json)
    HttpObj.WaitForResponse()
    _json := JSON.Load(HttpObj.ResponseText)
    if !(_json) {
        ; MsgBox % "PostJson ResponseText:"
        _json := json_toobj(HttpObj.ResponseText)
    }
    return _json
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