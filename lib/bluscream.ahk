; Date 09/03/2020
#Include %A_LineFile%\..\bluscream\json.ahk
#Include %A_LineFile%\..\bluscream\array.ahk
#Include %A_LineFile%\..\bluscream\io.ahk
#Include %A_LineFile%\..\bluscream\process.ahk
#Include %A_LineFile%\..\bluscream\ui.ahk
#Include %A_LineFile%\..\bluscream\string.ahk
#Include %A_LineFile%\..\bluscream\uri.ahk
#Include %A_LineFile%\..\bluscream\api.ahk
#Include %A_LineFile%\..\bluscream\utils.ahk
#Include %A_LineFile%\..\bluscream\tray.ahk

ObjectCount(object) {
    count := 0
    for index, value in object {
        count++
    }
    return count
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

    click(ClickCount=1, sleep_ms = 100) {
        if (!this.window.isActive())
            return
        x := (this.w > 0 ? this.x + this.w / 2 : this.x)
        y := (this.h > 0 ? this.y + this.h / 2 : this.y)
        MouseMove, x, y
        ; scriptlog("Clicking X: " . this.x . " Y: " . this.y . " " . ClickCount . " times.")
        Loop % ClickCount {
            dllcall("mouse_event", Uint, 0x02, Uint, 0, Uint, 0, Uint, 0, UPtr, 0) ; Down
            sleep, 100
            dllcall("mouse_event", Uint, 0x04, Uint, 0, Uint, 0, Uint, 0, UPtr, 0) ; UP
            sleep, % sleep_ms
        }
    }

MouseClick(x,y,amount := 1, delay := 5, button := "left", method := "", data := "") {
    scriptlog("clicking mouse button" . button .  " x" . x . " y" . y . " " . amount . " times using method " . method)
    if (method == "dllcall") {
        MouseMove, % x, % y
        Loop % amount {
            dllcall("mouse_event", Uint, 0x02, Uint, 0, Uint, 0, Uint, 0, UPtr, 0) ; Down
            sleep, 100
            dllcall("mouse_event", Uint, 0x04, Uint, 0, Uint, 0, Uint, 0, UPtr, 0) ; UP
            sleep, % delay
        }
    } else if (method == "postmessage") {
        p := y << 16 | (x & 0xffff)
        Loop, % amount
        {
            PostMessage, 0x201, 1, p, , % data
            sleep, % delay
            PostMessage, 0x202, 0, p, , % data
            sleep, % delay
        }
    } else {
        Loop % amount {
            MouseClick, % button     , x, y, 1         , 0
        ;   MouseClick, WhichButton [, X, Y, ClickCount, Speed, D|U, R]
            Sleep, % delay
        }
    }
}
PostClick(hwnd, X, Y, Count=1, Delay=50) {
    MouseClick(x,y,Count, Delay, "left", "postmessage", data := "ahk_id " . hwnd)
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
PressKey(key, presses=1, sleepms=80, keyms=20, verbose=false, msg="", raw=false) {
    if (verbose) scriptlog("Pressing key " . key . " " . (presses > 1 ? presses . " times (interval: " . keyms . " " : "(") . "delay: " . sleepms . ")" . (msg ? ": " . msg : ""))
    loop, % presses {
        Send, % (raw ? "{Raw}" : "") . "{" key " down}"
        Sleep, %keyms%
        Send, % (raw ? "{Raw}" : "") . "{" key " up}"
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
ProcessExists(PID_or_Name){
   Process, Exist, % PID_or_Name
   Return Errorlevel
}
StdOutToVar( sCmd ) { ;  GAHK32 ; Modified Version : SKAN 05-Jul-2013  http://goo.gl/j8XJXY                             
  Static StrGet := "StrGet"     ; Original Author  : Sean 20-Feb-2007  http://goo.gl/mxCdn  
   
  DllCall( "CreatePipe", UIntP,hPipeRead, UIntP,hPipeWrite, UInt,0, UInt,0 )
  DllCall( "SetHandleInformation", UInt,hPipeWrite, UInt,1, UInt,1 )

  VarSetCapacity( STARTUPINFO, 68, 0  )      ; STARTUPINFO          ;  http://goo.gl/fZf24
  NumPut( 68,         STARTUPINFO,  0 )      ; cbSize
  NumPut( 0x100,      STARTUPINFO, 44 )      ; dwFlags    =>  STARTF_USESTDHANDLES = 0x100 
  NumPut( hPipeWrite, STARTUPINFO, 60 )      ; hStdOutput
  NumPut( hPipeWrite, STARTUPINFO, 64 )      ; hStdError

  VarSetCapacity( PROCESS_INFORMATION, 16 )  ; PROCESS_INFORMATION  ;  http://goo.gl/b9BaI      
  
  If ! DllCall( "CreateProcess", UInt,0, UInt,&sCmd, UInt,0, UInt,0 ;  http://goo.gl/USC5a
              , UInt,1, UInt,0x08000000, UInt,0, UInt,0
              , UInt,&STARTUPINFO, UInt,&PROCESS_INFORMATION ) 
   Return "" 
   , DllCall( "CloseHandle", UInt,hPipeWrite ) 
   , DllCall( "CloseHandle", UInt,hPipeRead )
   , DllCall( "SetLastError", Int,-1 )     

  hProcess := NumGet( PROCESS_INFORMATION, 0 )                 
  hThread  := NumGet( PROCESS_INFORMATION, 4 )                      

  DllCall( "CloseHandle", UInt,hPipeWrite )

  AIC := ( SubStr( A_AhkVersion, 1, 3 ) = "1.0" )                   ;  A_IsClassic 
  VarSetCapacity( Buffer, 4096, 0 ), nSz := 0 
  
  While DllCall( "ReadFile", UInt,hPipeRead, UInt,&Buffer, UInt,4094, UIntP,nSz, UInt,0 )
   sOutput .= ( AIC && NumPut( 0, Buffer, nSz, "UChar" ) && VarSetCapacity( Buffer,-1 ) ) 
              ? Buffer : %StrGet%( &Buffer, nSz, "CP850" )
 
  DllCall( "GetExitCodeProcess", UInt,hProcess, UIntP,ExitCode )
  DllCall( "CloseHandle", UInt,hProcess  )
  DllCall( "CloseHandle", UInt,hThread   )
  DllCall( "CloseHandle", UInt,hPipeRead )

Return sOutput,  DllCall( "SetLastError", UInt,ExitCode )
}
StdOutStream( sCmd, Callback = "" ) { ; Modified  :  SKAN 31-Aug-2013 http://goo.gl/j8XJXY                             
  Static StrGet := "StrGet"           ; Thanks to :  HotKeyIt         http://goo.gl/IsH1zs                                   
                                      ; Original  :  Sean 20-Feb-2007 http://goo.gl/mxCdn
                                    
  DllCall( "CreatePipe", UIntP,hPipeRead, UIntP,hPipeWrite, UInt,0, UInt,0 )
  DllCall( "SetHandleInformation", UInt,hPipeWrite, UInt,1, UInt,1 )

  VarSetCapacity( STARTUPINFO, 104, 0  )      ; STARTUPINFO          ;  http://goo.gl/fZf24
  NumPut( 68,         STARTUPINFO,  0 )      ; cbSize
  NumPut( 0x100,      STARTUPINFO, 60 )      ; dwFlags    =>  STARTF_USESTDHANDLES = 0x100 
  NumPut( hPipeWrite, STARTUPINFO, 88 )      ; hStdOutput
  NumPut( hPipeWrite, STARTUPINFO, 96 )      ; hStdError

  VarSetCapacity( PROCESS_INFORMATION, 32 )  ; PROCESS_INFORMATION  ;  http://goo.gl/b9BaI      
  
  If ! DllCall( "CreateProcess", UInt,0, UInt,&sCmd, UInt,0, UInt,0 ;  http://goo.gl/USC5a
              , UInt,1, UInt,0x08000000, UInt,0, UInt,0
              , UInt,&STARTUPINFO, UInt,&PROCESS_INFORMATION ) 
   Return "" 
   , DllCall( "CloseHandle", UInt,hPipeWrite ) 
   , DllCall( "CloseHandle", UInt,hPipeRead )
   , DllCall( "SetLastError", Int,-1 )     

  hProcess := NumGet( PROCESS_INFORMATION, 0 )                 
  hThread  := NumGet( PROCESS_INFORMATION, 8 )                      

  DllCall( "CloseHandle", UInt,hPipeWrite )

  AIC := ( SubStr( A_AhkVersion, 1, 3 ) = "1.0" )                   ;  A_IsClassic 
  VarSetCapacity( Buffer, 4096, 0 ), nSz := 0 
  
  While DllCall( "ReadFile", UInt,hPipeRead, UInt,&Buffer, UInt,4094, UIntP,nSz, Int,0 ) {

   tOutput := ( AIC && NumPut( 0, Buffer, nSz, "Char" ) && VarSetCapacity( Buffer,-1 ) ) 
              ? Buffer : %StrGet%( &Buffer, nSz, "CP850" )

   Isfunc( Callback ) ? %Callback%( tOutput, A_Index ) : sOutput .= tOutput

  }                   
 
  DllCall( "GetExitCodeProcess", UInt,hProcess, UIntP,ExitCode )
  DllCall( "CloseHandle",  UInt,hProcess  )
  DllCall( "CloseHandle",  UInt,hThread   )
  DllCall( "CloseHandle",  UInt,hPipeRead )
  DllCall( "SetLastError", UInt,ExitCode  )

Return Isfunc( Callback ) ? %Callback%( "", 0 ) : sOutput      
}
/*
  ShellRun by Lexikos
    requires: AutoHotkey_L
    license: http://creativecommons.org/publicdomain/zero/1.0/

  Credit for explaining this method goes to BrandonLive:
  http://brandonlive.com/2008/04/27/getting-the-shell-to-run-an-application-for-you-part-2-how/
 
  Shell.ShellExecute(File [, Arguments, Directory, Operation, Show])
  http://msdn.microsoft.com/en-us/library/windows/desktop/gg537745
*/
ShellRun(prms*)
{
    shellWindows := ComObjCreate("{9BA05972-F6A8-11CF-A442-00A0C90A8F39}")
    
    desktop := shellWindows.Item(ComObj(19, 8)) ; VT_UI4, SCW_DESKTOP                
   
    ; Retrieve top-level browser object.
    if ptlb := ComObjQuery(desktop
        , "{4C96BE40-915C-11CF-99D3-00AA004AE837}"  ; SID_STopLevelBrowser
        , "{000214E2-0000-0000-C000-000000000046}") ; IID_IShellBrowser
    {
        ; IShellBrowser.QueryActiveShellView -> IShellView
        if DllCall(NumGet(NumGet(ptlb+0)+15*A_PtrSize), "ptr", ptlb, "ptr*", psv:=0) = 0
        {
            ; Define IID_IDispatch.
            VarSetCapacity(IID_IDispatch, 16)
            NumPut(0x46000000000000C0, NumPut(0x20400, IID_IDispatch, "int64"), "int64")
           
            ; IShellView.GetItemObject -> IDispatch (object which implements IShellFolderViewDual)
            DllCall(NumGet(NumGet(psv+0)+15*A_PtrSize), "ptr", psv
                , "uint", 0, "ptr", &IID_IDispatch, "ptr*", pdisp:=0)
           
            ; Get Shell object.
            shell := ComObj(9,pdisp,1).Application
           
            ; IShellDispatch2.ShellExecute
            shell.ShellExecute(prms*)
           
            ObjRelease(psv)
        }
        ObjRelease(ptlb)
    }
}
EnforceAdmin(args:="") {
    CommandLine := DllCall("GetCommandLine", "Str")
    If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
        Try {
            If (A_IsCompiled) {
                Run *RunAs "%A_ScriptFullPath%" /restart %args%
            } Else {
                Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%" %args%
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
    DllCall("GetProcessTimes", "Uint", hProc, "int64P", CreationTime, "int64P" , ExitTime, "int64P", newKrnlTime, "int64P", newUserTime)
    DllCall("CloseHandle", "Uint", hProc)
    Return (newKrnlTime-oldKrnlTime + newUserTime-oldUserTime)/10000000 * 100   
}
CPULoad() { ; By SKAN, CD:22-Apr-2014 / MD:05-May-2014. Thanks to ejor, Codeproject: http://goo.gl/epYnkO
    Static PIT, PKT, PUT                           ; http://ahkscript.org/boards/viewtopic.php?p=17166#p17166
    IfEqual, PIT,, Return 0, DllCall( "GetSystemTimes", "Int64P",PIT, "Int64P",PKT, "Int64P",PUT )
    DllCall("GetSystemTimes", "Int64P",CIT, "Int64P",CKT, "Int64P",CUT)
    IdleTime := PIT - CIT, KernelTime := PKT - CKT, UserTime := PUT - CUT, SystemTime := KernelTime + UserTime 
    Return ( ( SystemTime - IdleTime ) * 100 ) // SystemTime,    PIT := CIT,    PKT := CKT,    PUT := CUT 
}
RunWaitLast(commands, prefix:="", suffix:="", debug := False) {
    max := commands.MaxIndex()
    for i, command in commands {
        command := prefix . command
        if (!endsWith(command, suffix))
            command := command . suffix
        if (i < max) {
            if (debug) {
                scriptlog("Run " . command)
            }
            Run % command, , Min
        } else {
            if (debug) {
                scriptlog("RunWait " . command)
            }
            RunWait % command, , Min
            return
        }
    }
}
KillProcesses(processes, debug := False) {
    RunWaitLast(processes, "taskkill /f /im """, ".exe""", debug)
}
StartTasks(tasks, debug := False) {
    RunWaitLast(tasks, "schtasks /start /tn """, """", debug)
}
EndTasks(tasks, debug := False) {
    RunWaitLast(tasks, "schtasks /end /tn """, """", debug)
}
StartServices(services, debug := False) {
    RunWaitLast(services, "sc start """, """", debug)
}
StopServices(services, debug := False) {
    RunWaitLast(services, "sc stop """, """", debug)
}
CloseScript(Name) {
	DetectHiddenWindows On
	SetTitleMatchMode RegEx
	IfWinExist, i)%Name%.* ahk_class AutoHotkey
		{
		WinClose
		WinWaitClose, i)%Name%.* ahk_class AutoHotkey, , 2
		If ErrorLevel
			return "Unable to close " . Name
		else
			return "Closed " . Name
		}
	else
		return Name . " not found"
    SetTitleMatchMode, Fast
}