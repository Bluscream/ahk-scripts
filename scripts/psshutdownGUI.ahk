; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()

; Define default values for the dropdown
defaultAction := "Shutdown"
defaultTimeUnit := "Seconds"

; Create the GUI
Gui, Add, Text, , Select Action:
Gui, Add, DropDownList, vActionChoice Choose1, Shutdown||Restart|Hibernate|Suspend|Lock|Logoff|Poweroff|Abort
Gui, Add, Checkbox, vForceClose, Force applications to close
Gui, Add, Text, , Delay or Time (HH:MM):
Gui, Add, Edit, vDelayOrTime
Gui, Add, DropDownList, vTimeUnit Choose1, Seconds||Minutes|Hours|Time
Gui, Add, Text, , Message to display:
Gui, Add, Edit, vDisplayMessage
Gui, Add, Button, default gRunPsshutdown, Execute
Gui, Add, Button, gGuiClose, Cancel

; Set defaults
GuiControl,, ActionChoice, %defaultAction%
GuiControl,, TimeUnit, %defaultTimeUnit%

Gui, Show, , PsShutdown GUI Wrapper
return

; Function to run psshutdown with the chosen options
RunPsshutdown:
Gui, Submit  ; Save the input from the user to each control's associated variable.
actionMap := {"Shutdown":"-s", "Restart":"-r", "Hibernate":"-h", "Suspend":"-d", "Lock":"-l", "Logoff":"-o", "Poweroff":"-k", "Abort":"-a"}
actionParam := actionMap[ActionChoice]
forceParam := ForceClose ? "-f" : ""

; Determine the type of input and construct the parameter
if (TimeUnit = "Time") {
    ; Expecting time in HH:MM format, convert to "hh:mm"
    countdownParam := "-t " . DelayOrTime
} else {
    ; Expecting a delay, convert accordingly
    multiplier := TimeUnit = "Minutes" ? 60 : (TimeUnit = "Hours" ? 3600 : 1)
    delayInSeconds := (TimeUnit = "Seconds" ? DelayOrTime : DelayOrTime * multiplier)
    countdownParam := "-t " . delayInSeconds
}

messageParam := DisplayMessage ? ("-m """ . DisplayMessage . """") : ""

fullCommand := "psshutdown " . actionParam . " " . forceParam . " " . countdownParam . " " . messageParam
cmd := ComSpec " /c " fullCommand
; Show user command and ask for confirmation
MsgBox, 4, Confirm, % "Command to be executed:`n`n" . cmd . "`n`nContinue?", 10
IfMsgBox, No
    return
Run, % cmd, , Hide
return

; Function to close the GUI
GuiClose:
ButtonCancel:
ExitApp
return
