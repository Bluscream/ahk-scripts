; https://autohotkey.com/boards/viewtopic.php?t=791
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
    ; CREATE_NO_WINDOW = 0x08000000
    If (!DllCall("CreateProcess", "Ptr", 0, "Ptr", &sCmd, "Ptr", 0, "Ptr", 0, "Int", True
      , "UInt", 0x08000000, "Ptr", 0, "Ptr", sDir ? &sDir : 0, "Ptr", &si, "Ptr", &pi))
        Return ""
      , DllCall("CloseHandle", "Ptr", hStdOutWr)
      , DllCall("CloseHandle", "Ptr", hStdOutRd)

    DllCall("CloseHandle", "Ptr", hStdOutWr) ; The write pipe must be closed before reading the stdout.
    VarSetCapacity(sTemp, 4095)
    While (DllCall("ReadFile", "Ptr", hStdOutRd, "Ptr", &sTemp, "UInt", 4095, "PtrP", nSize, "Ptr", 0))
        sOutput .= StrGet(&sTemp, nSize, sEncoding)

    DllCall("GetExitCodeProcess", "Ptr", NumGet(pi, 0), "UIntP", nExitCode)
    DllCall("CloseHandle", "Ptr", NumGet(pi, 0))
    DllCall("CloseHandle", "Ptr", NumGet(pi, A_PtrSize))
    DllCall("CloseHandle", "Ptr", hStdOutRd)
    Return sOutput
}
