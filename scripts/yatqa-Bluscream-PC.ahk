#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#include <bluscream>

; Global Variables
global noui := false
global active := false
global interval := 0
global running := true
global yatqa := "ahk_class TMainForm ahk_exe yatqa.exe"
global suffix := " [Modded]"

; Tray Menu Setup
Menu, Tray, NoStandard
MenuItem, &Feature1, Feature1
MenuItem, &Feature2, Feature2
MenuItem, &Feature3, Feature3
Return

; Feature 1 Functionality
Feature1:
    global active := !active
    if (!active) {
        InputBox, interval, Serverlist Auto Refresh Interval, Please enter an interval in seconds, 
        if ErrorLevel
            Return
    }
    SetTimer, AutoRefresh, % active ? interval : "Delete"
Return

AutoRefresh:
    ; This function needs to be adapted to work within the combined script
    ; It was originally designed to interact with specific controls in the YaTQA application
    ; You might need to adjust the control identifiers or logic depending on the actual UI elements
    ControlGetText, btn_text , TButton5, %yatqa%
    if (btn_text != "Aktualisieren" || btn_text != "Refresh") {
        gosub Feature1
        Return
    }
    ControlClick , TButton5, %yatqa%
    return

; Feature 2 Functionality
Feature2:
    while (running) {
        WinWaitActive, ahk_class #32770 ahk_exe yatqa.exe
        if (ErrorLevel) {
            running := false
            continue
        }
        WinGetTitle, otherWindowTitle, YaTQA ›  ahk_class TMainForm ahk_exe yatqa.exe
        ControlSetText, Edit1, %otherWindowTitle%, ahk_class #32770 ahk_exe yatqa.exe
        WinWaitClose, ahk_class #32770 ahk_exe yatqa.exe
    }
Return

; Feature 3 Functionality
Feature3:
    global title := "Fehler ahk_class TMessageForm ahk_exe yatqa.exe" ; Error
    global button := "&Ignorieren" ; TButton1 ; Ignore
    while(true) {
        WinWait, %title%
        Sleep 10
        ControlClick, %button%, %title%
    }
Return

; Main Loop
while (true) {
    Sleep, 100
}
