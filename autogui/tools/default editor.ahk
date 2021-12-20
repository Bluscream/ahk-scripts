﻿; A script to set AutoGUI as default AHK editor.

#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

CommandLine := DllCall("GetCommandLine", "Str")

If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
    Try {
        If (A_IsCompiled) {
            Run *RunAs "%A_ScriptFullPath%" /restart
        } Else {
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
    }
    ExitApp
}

Menu Tray, Icon, %A_ScriptDir%\..\Icons\AutoGUI.icl, 1

Instruction := "Default AutoHotkey Script Editor"
Content := "Click OK to set AutoGUI as default editor for AutoHotkey scripts (.ahk files).`n"

AutoGUIDir := SubStr(A_ScriptDir, 1, InStr(SubStr(A_ScriptDir, 1, -1), "\", 0, 0) - 1)

If (FileExist(AutoGUIDir . "\AutoGUI.exe")) {
    Default := AutoGUIDir . "\AutoGUI.exe"

} Else If (FileExist(AutoGUIDir . "\AutoGUI64.exe") && A_Is64BitOS) {
    Default := AutoGUIDir . "\AutoGUI64.exe"

} Else If (FileExist(AutoGUIDir . "\AutoGUI.ahk")) {
    Default := """" . A_AhkPath . """ """ . AutoGUIDir . "\AutoGUI.ahk"""

} Else {
    MsgBox 0x10, Error, AutoGUI not found.
    ExitApp
}

Command := InputBoxEx(Instruction, Content, "Default Editor", Default, "", "", 0, 550, "", "", 1, "")
If (!ErrorLevel) {
    RegWrite REG_SZ, HKCR\AutoHotkeyScript\Shell\Edit\Command,, %Command% "`%1"
    If (ErrorLevel) {
        MsgBox 0x10, Error %A_LastError%, % GetErrorMessage(A_LastError + 0)
    }
}

ExitApp

#Include %A_ScriptDir%\MagicBox\Functions\InputBoxEx.ahk

GetErrorMessage(ErrorCode) {
    VarSetCapacity(ErrorMsg, 8192)
    DllCall("Kernel32.dll\FormatMessage"
        , "UInt", 0x1200 ; FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_IGNORE_INSERTS
        , "UInt", 0
        , "UInt", ErrorCode
        , "UInt", 0
        , "Str" , ErrorMsg
        , "UInt", 8192)
    Return StrGet(&ErrorMsg)
}
