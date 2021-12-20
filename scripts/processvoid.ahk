; Sending processes into oblivion!
#Include <bluscream>
#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
SetTitleMatchMode, 2
#Warn
global noui := false
scriptlog("Started logging here.")
Menu, tray, add
Menu, tray, add, List Disabled Processes, ShowGui
Gui Add, Button, x8 y344 w80 h23 gEnableProcess, &Undisable
Gui Add, Button, x224 y344 w80 h23 gHideGui, &Close
settings_file := "ProcessVoid.txt"
IfNotExist, % settings_file, FileAppend,, % settings_file
FileRead, LoadedText, %settings_file%
processes := StrSplit(LoadedText, "`n", "`r")global ProcessList =
For, k, v in processes {
    if (StrLen(processes) < 1) {
        ProcessList .= v
    } else {
        ProcessList .= v "|"
    }
}
Gui Add, ListBox, x8 y8 w299 h329 vProcessListBox, %ProcessList%
scriptlog("test")
running := false
while(running)
{
    For k, tokill in processes
    {
        scriptlog("k: " . k . " v: " . tokill)
        Process, Exist, % tokill
        If (ErrorLevel != 0)
        {
            Process, Close, % tokill
        }
    }
    Sleep, 1000
}
Return

ShowGui() {
    Gui Show, w315 h378, Disabled Processes
}
HideGui() {
    Gui Hide
}
DisableProcess(name) {
    ProcessList .= "|" name  ; add to the 
    GuiControl, , ProcessListBox, %ProcessList%
}
EnableProcess() {
    if ProcessListBox =
      return
    scriptlog(ProcessList)
    StringReplace, ProcessList, ProcessList, %ProcessListBox%|
    scriptlog(ProcessList)
    GuiControl, , ProcessListBox, |%ProcessList%
    scriptlog(ProcessList)
}