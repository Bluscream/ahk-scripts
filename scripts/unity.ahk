#Persistent
#include <bluscream>
SetBatchLines, -1
Process, Priority,, High

global show_ui := true

Gui +LastFound
hWnd := WinExist()

DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage( MsgNum, "ShellMessage" )
global HSHELL_WINDOWCREATED := 1
Return

ShellMessage( wParam,lParam )
{
    If ( wParam == HSHELL_WINDOWCREATED ) ;  
    {
        WinGetTitle, Title, ahk_id %lParam%
        scriptlog(Title)
        If  ( Title = "WorkRest" )
            WinClose, ahk_id %lParam% ; close it immideately
    }
}