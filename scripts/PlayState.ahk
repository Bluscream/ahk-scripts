Home::
		Pause::
		if (toggle := !toggle) {
		Process_Suspend("Aurora.exe")
		Process_Suspend(PID_or_Name){
		   PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name
		   h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)
		   If !h
			   Return -1
		   DllCall("ntdll.dll\NtSuspendProcess", "Int", h)
		   DllCall("CloseHandle", "Int", h)
		SplashImage, , b FM18 fs12, Suspended, Doodle God: 8-bit Mania
		Sleep, 1000
		SplashImage, Off
		}
		} else {
		Process_Resume("Aurora.exe")
		Process_Resume(PID_or_Name){
		   PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name
		   h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)
		   If !h
			   Return -1
		   DllCall("ntdll.dll\NtResumeProcess", "Int", h)
		   DllCall("CloseHandle", "Int", h)
		SplashImage, , b FM18 fs12, Resumed, Doodle God: 8-bit Mania
		Sleep, 1000
		SplashImage, Off
		}
		ProcExist(PID_or_Name=""){
		   Process, Exist, % (PID_or_Name="") ? DllCall("GetCurrentProcessID") : PID_or_Name
		   Return Errorlevel
		}
		}
		return
