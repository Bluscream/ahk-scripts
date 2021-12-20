if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}
#SingleInstance force
wt := "HSTART - UNREGISTERED VERSION ahk_class #32770 ahk_exe hstart64.exe"
Loop, 2
{
    WinWait, %wt%
    {
        WinActivate, %wt%
        WinWaitActive, %wt%
        ControlClick, Button1, %wt%, , , , NA
        WinWaitClose, %wt%
    }
}