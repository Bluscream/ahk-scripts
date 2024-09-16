#SingleInstance Force
#NoEnv
#Persistent
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
; #include <bluscream>

global noui := false
global running := true
global yatqa_window_main_title := "ahk_class TMainForm ahk_exe yatqa.exe"
global yatqa_window_save_title := "Save As ahk_class #32770 ahk_exe yatqa.exe"

scriptlog(text) {
    OutputDebug, %text%
}
SanitizeFilename(inputString) {
    trimmed := Trim(inputString)
    sanitized := RegExReplace(trimmed, "[^\w]", " ")
    sanitized := RegExReplace(sanitized, "[^\w\s]", "_")
    sanitized := RegExReplace(sanitized, "\s+", " ")
    if (StrLen(sanitized) > 255)
        sanitized := SubStr(sanitized, 1, 255)
    return Trim(sanitized)
}

; Function to toggle the loop
toggleLoop() {
    global running
    running := !running
}

; Create the tray menu
CreateTrayMenu() {
    ; Menu, Tray, NoStandard
    Menu, Tray, Add, Toggle Loop, toggleLoop
    Menu, Tray, Check, Toggle Loop
    Menu, Tray, Default, Toggle Loop
}

; Call the function to create the tray menu
CreateTrayMenu()

while (running) {
    scriptlog("Waiting for Save As Window")
    ; Wait for the "Save As" window to become active
    WinWaitActive, % yatqa_window_save_title
    scriptlog("Found Save As Window")
    
    ; If the window is not found, break the loop
    if (ErrorLevel) {
        scriptlog("Failed to find Save As Window")
        running := false
        continue
    }
    
    ; Get the title of the other window
    WinGetTitle, main_window_title, % yatqa_window_main_title
    main_window_title := Trim(main_window_title)
    scriptlog("main_window_title: """ . main_window_title . """")
    fileName := ""
    matching := RegExMatch(main_window_title, "YaTQA › (?<ip>.+) › (?<name>.+)", match)
    scriptlog("match: " . match)
    if (matching) {
        name := SanitizeFilename(matchname)
        if (name)
            fileName .= name
        ip := Trim(matchip)
        if (ip)
            fileName .=  " (" . ip . ")"
    }

    fileName := fileName . ".ts3_channels"
    if (fileName) {
        scriptlog("Filename: " . fileName)
        ControlSetText, Edit1, % fileName, % yatqa_window_save_title
    }
    
    ; Wait for the "Save As" window to close
    WinWaitClose, % yatqa_window_save_title
}

exitapp
