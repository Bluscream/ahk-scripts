GetPowerProfileName() {
    if (DllCall("powrprof\PowerGetActiveScheme", "Ptr", 0, "Ptr*", pguid) == 0) {
        VarSetCapacity(desc, (szdesc := 256) + 2)
        if (DllCall("powrprof\PowerReadFriendlyName", "Ptr", 0, "Ptr", pguid, "Ptr", 0, "Ptr", 0, "Ptr", &desc, "UInt*", szdesc) == 0, DllCall("LocalFree", "Ptr", pguid, "Ptr")) {
            activeProfileName := StrGet(&desc, "UTF-16")
            return activeProfileName
        }
    }
}
RunAsUser(Command, WorkingDirectory)
{
	static STARTUPINFO := "DWORD cb,LPTSTR lpReserved,LPTSTR lpDesktop,LPTSTR lpTitle,DWORD dwX,DWORD dwY,DWORD dwXSize,DWORD dwYSize,DWORD dwXCountChars,DWORD dwYCountChars,DWORD dwFillAttribute,DWORD dwFlags,WORD wShowWindow,WORD cbReserved2,LPBYTE lpReserved2,HANDLE hStdInput,HANDLE hStdOutput,HANDLE hStdError"
	static PROCESS_INFORMATION := "HANDLE hProcess, HANDLE hThread, DWORD dwProcessId, DWORD dwThreadId"
	hModule := DllCall("LoadLibrary", Str, "Advapi32.dll") 
	
	; OpenProcess - http://msdn.microsoft.com/en-us/library/windows/desktop/ms684320(v=vs.85).aspx 
	; PROCESS_QUERY_INFORMATION = 0x0400 
	hProcess := DllCall(   "Kernel32.dll\OpenProcess", UInt, 0x0400, Int, 0, UInt, DllCall("Kernel32.dll\GetCurrentProcessId"), "Ptr") 
	
	; OpenProcessToken - http://msdn.microsoft.com/en-us/library/windows/desktop/aa379295(v=vs.85).aspx 
	; TOKEN_ASSIGN_PRIMARY = 0x0001 
	; TOKEN_DUPLICATE = 0x0002 
	; TOKEN_QUERY = 0x0008 
	DllCall(   "Advapi32.dll\OpenProcessToken", Ptr, hProcess, UInt, 0x0001 | 0x0002 | 0x0008, PtrP, hToken) 
	
	; CreateRestrictedToken - http://msdn.microsoft.com/en-us/library/Aa446583 
	; LUA_TOKEN = 0x4 
	DllCall(   "Advapi32.dll\CreateRestrictedToken", Ptr, hToken, UInt, 0x4, UInt, 0, Ptr, 0, UInt, 0, Ptr, 0, UInt, 0, Ptr, 0, PtrP, hResToken) 
	
	
	; Assuming 32bit pointer size 
	;~ VarSetCapacity(sInfo, 68, 0) 
	;~ VarSetCapacity(pInfo, 16, 0) 
	
	sInfo := new _Struct(STARTUPINFO)
	sInfo.cb := sizeof(STARTUPINFO)
	sInfo.lpDesktop := "winsta0\default"
	pInfo := new _Struct(PROCESS_INFORMATION)
	;~ NumPut(68, sInfo, 0, "UInt") 
	;~ NumPut("winsta0\\default", sInfo, 8, "Str") 
	
	; CreateProcessAsUser - http://msdn.microsoft.com/en-us/library/ms682429 
	; NORMAL_PRIORITY_CLASS = 0x00000020 
	result := DllCall(   "Advapi32.dll\CreateProcessAsUser" , Ptr, hResToken, PtrP, 0, Str, Command, Ptr, 0, Ptr, 0, Int, 0, UInt, 0x00000020, Ptr, 0, Str, WorkingDirectory ? WorkingDirectory : A_ScriptDir, PtrP, sInfo, PtrP, pInfo)
	MsgBox % "result: " result "`nLast error:" A_LastError "`nCommand: " Command "`nWorking directory: " WorkingDirectory
	DllCall("CloseHandle", PTR, hProcess)
	DllCall("CloseHandle", PTR, hToken)
	DllCall("CloseHandle", PTR, sInfo.hStdInput)
	DllCall("CloseHandle", PTR, sInfo.hStdOutput)
	DllCall("CloseHandle", PTR, sInfo.hStdError)
	DllCall("CloseHandle", PTR, pInfo.hProcess)
	DllCall("CloseHandle", PTR, pInfo.hThread)
	return pInfo.dwProcessId
}
RunAsUserTask(Target, Arguments, WorkingDirectory)
{
	static TASK_TRIGGER_REGISTRATION := 7   ; trigger on registration. 
	static TASK_ACTION_EXEC := 0  ; specifies an executable action. 
	static TASK_CREATE := 2
	static TASK_RUNLEVEL_LUA := 0
	static TASK_LOGON_INTERACTIVE_TOKEN := 3
	objService := ComObjCreate("Schedule.Service") 
	objService.Connect() 

	objFolder := objService.GetFolder("\") 
	objTaskDefinition := objService.NewTask(0) 

	principal := objTaskDefinition.Principal 
	principal.LogonType := TASK_LOGON_INTERACTIVE_TOKEN    ; Set the logon type to TASK_LOGON_PASSWORD 
	principal.RunLevel := TASK_RUNLEVEL_LUA  ; Tasks will be run with the least privileges. 

	colTasks := objTaskDefinition.Triggers
	objTrigger := colTasks.Create(TASK_TRIGGER_REGISTRATION) 
	endTime += 1, Minutes  ;end time = 1 minutes from now 
	FormatTime,endTime,%endTime%,yyyy-MM-ddTHH`:mm`:ss
	objTrigger.EndBoundary := endTime
	colActions := objTaskDefinition.Actions 
	objAction := colActions.Create(TASK_ACTION_EXEC) 
	objAction.ID := "7plus run" 
	objAction.Path := Target
	objAction.Arguments := Arguments
	objAction.WorkingDirectory := WorkingDirectory ? WorkingDirectory : A_WorkingDir
	objInfo := objTaskDefinition.RegistrationInfo
	objInfo.Author := "7plus" 
	objInfo.Description := "Runs a program as non-elevated user" 
	objSettings := objTaskDefinition.Settings 
	objSettings.Enabled := True 
	objSettings.Hidden := False 
	objSettings.DeleteExpiredTaskAfter := "PT0S"
	objSettings.StartWhenAvailable := True 
	objSettings.ExecutionTimeLimit := "PT0S"
	objSettings.DisallowStartIfOnBatteries := False
	objSettings.StopIfGoingOnBatteries := False
	objFolder.RegisterTaskDefinition("", objTaskDefinition, TASK_CREATE , "", "", TASK_LOGON_INTERACTIVE_TOKEN ) 
}
ShellRun2(prms*)
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