#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
Process Priority,, Below Normal

SetTimer, DoMax, 100
return

DoMax:
    if (A_ScreenHeight > 600) {
        return
    }
    DetectHiddenWindows, Off
    WinGet, l, List
    if (priorList)
    {
        Loop, % l
        {
            if !InStr(priorList, l%A_Index%)
            {
                WinGetTitle, wt, % "ahk_id" l%A_Index%
                WinGet, mm, MinMax, % "ahk_id" l%A_Index%
                WinGet, s, Style, % "ahk_id" l%A_Index%
                
                if (s & 0x10000) and (mm = 0) and (wt) and (wt != "Task Switching")
                    WinMaximize, % "ahk_id" l%A_Index%
            }
        }
    }

    priorlist := ""
    WinGet, priorL, List
    Loop, % priorL
        priorlist .= priorL%A_Index% "`n"
    return