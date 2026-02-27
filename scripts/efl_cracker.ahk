#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent

SetWorkingDir, % A_ScriptDir
SetTitleMatchMode, 2
DetectHiddenWindows, Off
CoordMode, Mouse, Client

; Configuration
FileLockerPath := "C:\Program Files\Easy File Locker\FileLocker.exe"
PasswordFile := A_ScriptDir . "\passwords.txt"
FileLockerModalWindow := "Easy File Locker ahk_class #32770 ahk_exe FileLocker.exe" ; Identified by text: "Please input the password:" or "Invalid Password!"

; Global variables
passwords := []
currentPasswordIndex := 1
debugWindowReady := false

; Timing delays (in milliseconds) - adjust these to speed up or slow down the script
delayAfterLoadPasswords := 250
delayProcessStart := 250
delayWindowRender := 30
delayAfterActivate := 1
delayPasswordClearText := 1
delayPasswordSetText := 1
delayPasswordAfterSetText := 2
delayPasswordPressEnter := 3
delayAfterEnter := 4
delayAfterErrorEnter := 1
delayCheckSuccess := 1
delayCheckSuccessRetry := 2
delayRestartChunk := 250
delayAfterCloseProcess := 250
delayAfterStartFileLocker := 250
delayAllPasswordsTried := 250
delaySuccessMessage := 250
delayInitialization := 250
delayEscKey := 250
delayLoopTimer := 25
delayInitialTimer := 250
timeoutWinWaitActive := 0.5
timeoutWaitPasswordWindow := 5000
timeoutWaitPasswordWindowAfterError := 250
timeoutDebugWindow := 2

; DebugLog function that uses OutputDebug, stdout, and AutoHotkey debug window
DebugLog(message) {
    global debugWindowReady

    FormatTime, timestamp, A_Now, hh:mm:ss
    formattedMessage := "[" . timestamp . "] " . message

    ; Use OutputDebug for external debug viewers
    OutputDebug, %formattedMessage%

    ; Write to stdout (visible in Cursor's debug console)
    FileAppend, %formattedMessage%`n, *

    ; Also write to AutoHotkey debug window
    if (!debugWindowReady) {
        global timeoutDebugWindow
        ListVars
        WinWait, ahk_class AutoHotkey, , %timeoutDebugWindow%
        if (!ErrorLevel) {
            ControlSetText, Edit1, , ahk_class AutoHotkey
            debugWindowReady := true
        }
    }

    if (debugWindowReady) {
        ControlGetText, Edit1Text, Edit1, ahk_class AutoHotkey
        ControlSetText, Edit1, %Edit1Text%%formattedMessage%`r`n, ahk_class AutoHotkey
        PostMessage, 0x115, 7, , Edit1, ahk_class AutoHotkey ; Scroll to bottom
    }
}

; Load passwords from file
LoadPasswords() {
    global passwords, PasswordFile

    DebugLog("Starting password file load...")
    passwords := []

    DebugLog("Checking if password file exists: " . PasswordFile)
    IfNotExist, %PasswordFile%
    {
        DebugLog("ERROR: Password file not found: " . PasswordFile)
        MsgBox, 48, Error, Password file not found: %PasswordFile%`n`nPlease create a passwords.txt file with one password per line.
        ExitApp
    }

    DebugLog("Reading password file...")
    FileRead, content, %PasswordFile%
    if (ErrorLevel) {
        DebugLog("ERROR: Failed to read password file: " . PasswordFile)
        MsgBox, 48, Error, Failed to read password file: %PasswordFile%
        ExitApp
    }

    ; Get file size for progress
    FileGetSize, fileSize, %PasswordFile%
    DebugLog("File read successfully. Size: " . fileSize . " bytes")
    DebugLog("Parsing passwords from file...")

    lineCount := 0
    validCount := 0
    emptyCount := 0

    Loop, Parse, content, `n, `r
    {
        lineCount++
        password := Trim(A_LoopField)

        ; Show progress every 100 lines
        if (Mod(lineCount, 500) == 0) {
            DebugLog("Parsing line " . lineCount . " (Found " . validCount . " valid passwords so far)...")
        }

        if (password != "") {
            passwords.Push(password)
            validCount++
        } else {
            emptyCount++
        }
    }

    DebugLog("Parsing complete. Total lines: " . lineCount . ", Valid passwords: " . validCount . ", Empty lines: " . emptyCount)

    passwordCount := passwords.MaxIndex()
    if (passwordCount == "") {
        DebugLog("ERROR: No passwords found in file: " . PasswordFile)
        MsgBox, 48, Error, No passwords found in file: %PasswordFile%
        ExitApp
    }

    global delayAfterLoadPasswords
    DebugLog("Successfully loaded " . passwordCount . " passwords")
    ToolTip, Loaded %passwordCount% passwords
    Sleep, %delayAfterLoadPasswords%
    ToolTip
}

; Start FileLocker.exe
StartFileLocker() {
    global FileLockerPath, delayProcessStart, delayAfterLoadPasswords
    Run, %FileLockerPath%, , , PID
    if (ErrorLevel) {
        ToolTip, Failed to start FileLocker.exe
        Sleep, %delayAfterLoadPasswords%
        ToolTip
        return false
    }
    Sleep, %delayProcessStart% ; Wait for process to start
    return true
}

; Wait for password input window
WaitForPasswordWindow(timeout := 10000) {
    global FileLockerModalWindow, timeoutWinWaitActive, delayWindowRender, timeoutWaitPasswordWindow
    if (timeout == 10000) {
        timeout := timeoutWaitPasswordWindow
    }
    WinWait, %FileLockerModalWindow%, Please input the password:, %timeout%
    if (ErrorLevel) {
        return false
    }
    WinActivate, %FileLockerModalWindow%
    WinWaitActive, %FileLockerModalWindow%, , %timeoutWinWaitActive%
    Sleep, 10 ; Give window minimal time to render (reduced from delayWindowRender)
    return true
}

; Check if error window is visible
IsErrorWindowVisible() {
    global FileLockerModalWindow
    return WinExist(FileLockerModalWindow, "Invalid Password!") != 0
}

; Check if password input window still exists
IsPasswordWindowVisible() {
    global FileLockerModalWindow
    return WinExist(FileLockerModalWindow, "Please input the password:") != 0
}

; Try a password
TryPassword(password) {
    global FileLockerModalWindow, timeoutWinWaitActive, delayAfterActivate, delayPasswordClearText, delayPasswordSetText, delayPasswordAfterSetText, delayPasswordPressEnter, delayAfterEnter, delayAfterErrorEnter, delayCheckSuccess, delayCheckSuccessRetry, timeoutWaitPasswordWindowAfterError

    ; Wait for password input window
    if (!WaitForPasswordWindow()) {
        return false
    }

    ; Ensure window is in foreground
    WinActivate, %FileLockerModalWindow%
    WinWaitActive, %FileLockerModalWindow%, , %timeoutWinWaitActive%
    Sleep, %delayAfterActivate%

    ; Clear password field
    ControlSetText, Edit1, , %FileLockerModalWindow%
    Sleep, %delayPasswordClearText%

    ; Enter password
    ControlSetText, Edit1, %password%, %FileLockerModalWindow%
    Sleep, %delayPasswordSetText%
    Sleep, %delayPasswordAfterSetText% ; Additional delay after setting password

    ; Press Enter key (window should be active)
    Sleep, %delayPasswordPressEnter% ; Delay before pressing Enter
    ControlSend, Edit1, {Enter}, %FileLockerModalWindow%
    Sleep, %delayAfterEnter% ; Wait for response

    ; Wait a bit for either error window or success
    Sleep, %delayCheckSuccess%

    ; Check if password window disappeared (success)
    if (!IsPasswordWindowVisible()) {
        return true
    }

    ; Check for error window (wait for it to appear)
    ; Wait up to 1 second for error window to appear
    errorWindowFound := false
    Loop, 10 {
        if (IsErrorWindowVisible()) {
            errorWindowFound := true
            break
        }
        Sleep, 100
    }

    if (errorWindowFound) {
        ; Error window appeared - close it by pressing Enter
        ControlSend, Button1, {Enter}, %FileLockerModalWindow%, Invalid Password!
        Sleep, %delayAfterErrorEnter%

        ; Check if password input window still exists (if not, app closed - need to restart)
        Sleep, 50 ; Give it a moment to close
        if (!IsPasswordWindowVisible()) {
            ; App closed after 3 attempts, need to restart
            return "restart"
        }

        ; Wait for password input window to reappear (should be quick since window already exists)
        if (!WaitForPasswordWindow(timeoutWaitPasswordWindowAfterError)) {
            return false
        }
        return false
    }

    ; Window still exists but no error - might be processing
    Sleep, %delayCheckSuccessRetry%
    if (!IsPasswordWindowVisible()) {
        return true
    }

    return false
}

; Main cracking loop
CrackLoop() {
    global passwords, currentPasswordIndex, FileLockerModalWindow, delayAllPasswordsTried, delaySuccessMessage, delayRestartChunk, delayAfterCloseProcess, delayAfterStartFileLocker, delayLoopTimer

    passwordCount := passwords.MaxIndex()
    if (currentPasswordIndex > passwordCount) {
        DebugLog("All passwords tried. Restarting from beginning...")
        ToolTip, All passwords tried. Restarting from beginning...
        Sleep, %delayAllPasswordsTried%
        currentPasswordIndex := 1
        ToolTip
    }

    password := passwords[currentPasswordIndex]

    DebugLog("Trying password " . currentPasswordIndex . "/" . passwordCount . ": " . password)
    ToolTip, Trying password %currentPasswordIndex%/%passwordCount%: %password%

    result := TryPassword(password)

    if (result == true) {
        ; Password found! Stop the script
        DebugLog("SUCCESS! Password found: " . password)
        ToolTip, SUCCESS! Password found: %password%
        Sleep, %delaySuccessMessage%
        ToolTip

        MsgBox, 64, Success, Password found: %password%
        ExitApp
    } else if (result == "restart") {
        ; App closed after error, need to restart
        DebugLog("App closed after error. Restarting FileLocker...")
        ToolTip, Restarting FileLocker...
        Sleep, %delayRestartChunk%
        ToolTip

        ; Close any existing FileLocker windows (if any)
        WinClose, %FileLockerModalWindow%
        Process, Close, FileLocker.exe
        Sleep, %delayAfterCloseProcess%

        ; Start FileLocker again
        StartFileLocker()
        Sleep, %delayAfterStartFileLocker%

        ; Move to next password
        currentPasswordIndex++
    } else {
        ; Password failed but app is still running, move to next password
        currentPasswordIndex++
    }

    ; Continue trying next password
    SetTimer, CrackLoop, -%delayLoopTimer%
}

; Initialize
LoadPasswords()
StartFileLocker()
global delayInitialization, delayInitialTimer
Sleep, %delayInitialization%
SetTimer, CrackLoop, -%delayInitialTimer%

; Hotkeys
Esc::
    global delayEscKey
    ToolTip, Stopping...
    Sleep, %delayEscKey%
    ToolTip
ExitApp
return
