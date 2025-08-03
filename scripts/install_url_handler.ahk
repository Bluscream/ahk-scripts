#NoEnv
#SingleInstance Force
SetWorkingDir %A_ScriptDir%

; Create main window
Gui, Add, Text, x10 y10 w300 h20, Protocol Handler Installer
Gui, Add, Edit, x10 y40 w300 h20 vProtocolName, Enter protocol name (e.g., 'myapp'):
Gui, Add, Edit, x10 y80 w300 h20 vExecutablePath, Path to executable:
Gui, Add, Button, x320 y75 w30 h25 gBrowseFile, ...
Gui, Add, Button, x10 y120 w100 h25 gInstallHandler, Install Handler
Gui, Add, Button, x120 y120 w100 h25 gUninstallHandler, Uninstall Handler
Gui, Add, Button, x230 y120 w100 h25 gCheckHandler, Check Handler
Gui, Show, w360 h160, URL Protocol Handler Manager

Return

BrowseFile:
    FileSelectFile, SelectedPath, 3, , Select Executable, Executables (*.exe)
    if (ErrorLevel = 0) {
        GuiControl,, ExecutablePath, %SelectedPath%
    }
    Return

InstallHandler:
    Gui, Submit, NoHide
    
    ; Validate inputs
    if (!ProtocolName || !ExecutablePath) {
        MsgBox, Please fill in both fields!
        Return
    }
    
    ; Verify executable exists
    if (!FileExist(ExecutablePath)) {
        MsgBox, Error: Executable file does not exist!
        Return
    }
    
    ; Construct registry paths
    regKey := "HKCR\" . ProtocolName . "\"
    commandKey := ProtocolName . "\shell\open\command"
    
    ; Write registry entries
    RegWrite, REG_SZ, HKCR, %regKey%, , %ProtocolName% Application
    RegWrite, REG_SZ, HKCR, %regKey%\, URL Protocol
    QuotedPath := """" . ExecutablePath . """ %%1"
    RegWrite, REG_SZ, HKCR, %commandKey%, , %QuotedPath%
    
    if (ErrorLevel = 0) {
        MsgBox , Registry keys written successfully!`nPlease restart your system for changes to take effect.
    } else {
        MsgBox , Error writing to registry! Please run as administrator.
    }
    Return

UninstallHandler:
    Gui, Submit, NoHide
    
    if (!ProtocolName) {
        MsgBox , Please enter the protocol name to uninstall!
        Return
    }
    
    regKey := "HKCR\" . ProtocolName . "\"
    ; Use RegRead to test if key exists
    RegRead, dummy, HKCR, %regKey%
    if (ErrorLevel = 0) {
        ; Delete the key
        RegDelete, HKCR, %regKey%
        if (ErrorLevel = 0) {
            MsgBox , Successfully uninstalled protocol handler.`nPlease restart your system for changes to take effect.
        } else {
            MsgBox , Error uninstalling protocol handler! Please run as administrator.
        }
    } else {
        MsgBox , Protocol handler does not exist!
    }
    Return

CheckHandler:
    Gui, Submit, NoHide
    
    if (!ProtocolName) {
        MsgBox , Please enter the protocol name to check!
        Return
    }
    
    regKey := "HKCR\" . ProtocolName . "\"
    ; Use RegRead to test if key exists
    RegRead, dummy, HKCR, %regKey%
    if (ErrorLevel = 0) {
        MsgBox , Protocol handler exists!
    } else {
        MsgBox , Protocol handler does not exist!
    }
    Return

GuiClose:
ExitApp