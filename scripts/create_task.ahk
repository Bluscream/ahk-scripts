; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()

global FilePath := ""
global Args := ""
global RunAsAdmin := false
global RunAsSystem := false
global StartAtStartup := false

; get args as array
args := StrSplit(A_Args, " ")

; check if array len > 0 
if (args.MaxIndex() > 0) {
    ; scriptlog("args: " . args)
    for n, param in args {
        ShowOptionsGui(param)
    }
} else {
    ; scriptlog("No args")
    ShowOptionsGui(A_AhkPath)
}



return

SanitizeString(str) {
    return RegExReplace(str, "[^A-Za-z0-9\.]", "")
}

ShowOptionsGui(InitialFilePath) {
    ; GUI definition
    Gui, Add, Text,, Enter the path to to the file to run:
    Gui, Add, Edit, vFilePath w300, %InitialFilePath% ; Fill the textbox with the file path if available
    Gui, Add, Text,, Enter additional arguments (if any):
    Gui, Add, Edit, vArgs
    Gui, Add, Checkbox, vRunAsAdmin, Run elevated?
    Gui, Add, Checkbox, vRunAsSystem, Run as SYSTEM User?
    Gui, Add, Checkbox, vStartAtStartup, Start at computer startup?
    Gui, Add, Button, Default gCreateTask, Create Task
    Gui, Show,, Create Scheduled Task
}

CreateTask() {
    Gui, Submit, NoHide

    TaskName := new File(FilePath).name
    if (Args != "")
        ; split str by anything that isnt [ascii or .] and get last element
        sanitizedArgs := SanitizeString(Args)
        ; get last 50 chars of sanitized args
        TaskName .= " - " . SubStr(sanitizedArgs, -50)
    TaskFolder := StartAtStartup ? "ahk\startup" : "ahk\elevated"
    ; RunLevel := RunAsAdmin ? "highest" : "limited"

    ; Create the batch file to run the scheduled task
    BatchFileName := A_Desktop . "\" . TaskName . ".bat"
    FileDelete, %BatchFileName% ; Remove existing batch file if any
    FileAppend, schtasks /run /tn "%TaskFolder%\%TaskName%", %BatchFileName%

    ; Construct the SCHTASKS command to create the scheduled task
    TaskCommand := "SCHTASKS /Create /TN """ . TaskFolder . "\" . TaskName . """ /TR ""'" . FilePath
    if (Args != "") {
        TaskCommand .= "' '" . Args . "'"
        ; for n, arg in StrSplit(Args, " ") {
        ;     TaskCommand .= " '" . arg . "'"
        ; }
    }
    TaskCommand .= """"
    if (RunAsAdmin)
        TaskCommand .= " /RL HIGHEST"
    if (StartAtStartup)
        TaskCommand .= " /SC ONSTART"
    else
        TaskCommand .= " /sc ONCE /st 00:00"
    if (RunAsSystem)
        TaskCommand .= " /RU SYSTEM"
    else
        TaskCommand .= " /RU %A_UserName%"

    ; Run the SCHTASKS command to create the scheduled task
    ; Show user command and ask for confirmation
    MsgBox, 4, Confirm, % "Command to be executed:`n`n" . TaskCommand . "`n`nContinue?", 10
    IfMsgBox, No
        return
    RunWait, %TaskCommand%, , Hide
    ; RunWait, %TaskCommand%, NoHide ; , UseErrorLevel, stdout
    ; MsgBox, % "ErrorLevel: " . ErrorLevel . "`n`nStdOut: " . stdout
    ; if (ErrorLevel != 0) {
    ;     return
    ; }
    
    ; Gui, Destroy ; Close the GUI
    ; ExitApp
}
    
GuiClose:
    ExitApp
    