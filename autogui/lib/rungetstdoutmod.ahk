RunGetStdout(sCmd, sEncoding := "CP0", sDir := "", ByRef nExitCode := 0) {
    DllCall("CreatePipe", "PtrP", hStdOutRd, "PtrP", hStdOutWr, "Ptr", 0, "UInt", 0)
    DllCall("SetHandleInformation", "Ptr", hStdOutWr, "UInt", 1, "UInt", 1)

    ; STARTUPINFO
    NumPut(VarSetCapacity(si, (A_PtrSize == 4) ? 68 : 104, 0), si, 0, "UInt")
    NumPut(0x100,     si, (A_PtrSize == 4) ? 44 : 60, "UInt") ; STARTF_USESTDHANDLES
    NumPut(hStdOutWr, si, (A_PtrSize == 4) ? 60 : 88, "Ptr" )
    NumPut(hStdOutWr, si, (A_PtrSize == 4) ? 64 : 96, "Ptr" )

    ; PROCESS_INFORMATION
    VarSetCapacity(pi, (A_PtrSize == 4) ? 16 : 24, 0)
    ; CREATE_NO_WINDOW = 0x08000000 | 0x10 = CREATE_NEW_CONSOLE 
    If (!DllCall("CreateProcess", "Ptr", 0, "Ptr", &sCmd, "Ptr", 0, "Ptr", 0, "Int", True
      , "UInt", 0x08000010, "Ptr", 0, "Ptr", sDir ? &sDir : 0, "Ptr", &si, "Ptr", &pi))
        Return ""
      , DllCall("CloseHandle", "Ptr", hStdOutWr)
      , DllCall("CloseHandle", "Ptr", hStdOutRd)

    DllCall("CloseHandle", "Ptr", hStdOutWr) ; The write pipe must be closed before reading the stdout.

    ; Adapted from Programmer's Notepad
    bCompleted := False
    While (!bCompleted) {
        Sleep 50
        If (!DllCall("PeekNamedPipe"
        , "Ptr", hStdOutRd, "Ptr", 0, "UInt", 0, "Ptr", 0, "UInt*", BytesAvail, "Ptr", 0)) {
            BytesAvail := 0
        }

        If (BytesAvail > 0) {
            VarSetCapacity(sTemp, 4095)
            bRead := DllCall("ReadFile", "Ptr", hStdOutRd, "Ptr", &sTemp, "UInt", 4095, "PtrP", nSize, "Ptr", 0)
            If (bRead && nSize) {
                sOutput .= StrGet(&sTemp, nSize, sEncoding)    
                bCompleted := True
            } Else {
                bCompleted := True
            }
        } Else {
            ExitCode := 0x103 ; STILL_ACTIVE
            DllCall("GetExitCodeProcess", "Ptr", NumGet(pi, 0), "UIntP", &ExitCode)
            If (ExitCode != 0x103) {
                bCompleted := True
            }
        }
    }

    DllCall("GetExitCodeProcess", "Ptr", NumGet(pi, 0), "UIntP", nExitCode)
    DllCall("CloseHandle", "Ptr", NumGet(pi, 0))
    DllCall("CloseHandle", "Ptr", NumGet(pi, A_PtrSize))
    DllCall("CloseHandle", "Ptr", hStdOutRd)
    Return sOutput
}
