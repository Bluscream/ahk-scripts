﻿; Generated by AutoGUI 2.5.3
; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-syskey-ahk
#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
Menu,TRAY,NoIcon
; Menu Tray, Icon, C:\Users\blusc\Downloads\IconGroup32512.ico
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
;$OBFUSCATOR: $DEFGUILAB: MainGUI,UpdateGUI,KeyConfirmed,Password_startup_clicked,System_generated_password_clicked,Secret,GuiEscape,GuiClose
gosub MainGUI
MainGUI:
    Gui, Destroy
    Gui -MinimizeBox -MaximizeBox
    Gui Add, Picture, x12 y16 w64 h64 gSecret, C:\Users\blusc\Downloads\IconGroup32512.ico
    Gui Add, Text, x74 y16 w236 h39, This tool will allow you to configure the Accounts Database to enable additional encryption. further protecting the database from compromise.
    Gui Add, Text, x74 y72 w199 h26, Once enabled, this encryption cannot be disabled.
    Gui Add, Radio, x74 y133 w200 h13 +Checked, Encryption Enabled
    Gui Add, Radio, x74 y112 w200 h13 +Disabled, Encryption Disabled
    Gui Add, Button, x48 y160 w72 h23 gGuiClose, &OK
    Gui Add, Button, x125 y160 w71 h23 gGuiClose, &Cancel
    Gui Add, Button, x203 y160 w70 h23 gUpdateGUI, &Update

    Gui Show, w325 h193, Securing the Windows Account Database
    Return

UpdateGUI:
    Gui, Destroy
    Gui -MinimizeBox -MaximizeBox
    Gui Add, GroupBox, x10 y136 w280 h148
    Gui Add, GroupBox, x11 y10 w280 h111
    Gui Add, Radio, vPasswordStartup gPassword_startup_clicked x19 y9 w107 h17, "Password Startup"
    
    Gui Add, Radio, gSystem_generated_password_clicked x18 y135 w160 h17 +Checked, "System Generated Password"
    
    Gui Add, Text, x35 y29 w239 h26, "Requires a password to be entered during system start."
    
    Gui Add, Text, x35 y65 w56 h13, "Password:"
    Gui Add, Edit, vEditPassword x102 y62 w174 h20 +Disabled +Password
    Gui Add, Text, x36 y91 w45 h13, "Confirm:"
    Gui Add, Edit, vEditConfirm x102 y88 w174 h20 +Disabled +Password
    
    
    Gui Add, Text, x53 y176 w210 h26, Requires a floppy disk to be inserted during system start.
    Gui Add, Radio, x36 y160 w179 h17 vStoreFloppy, Store Startup key on Floppy Disk
    
    Gui Add, Radio, x36 y215 w143 h17 vStoreLocal +Checked, Store Startup Key Locally
    Gui Add, Text, x53 y234 w216 h39, Stores a key as part of the operating system, and no interaction is required during system start.
    
    Gui Add, Button, x80 y288 w72 h23 gKeyConfirmed, &OK
    Gui Add, Button, x157 y288 w71 h23 gMainGUI, &Cancel

    Gui Show, w304 h322, Startup Key
    Return
    
KeyConfirmed:
    GuiControlGet, PasswordStartup
    If (PasswordStartup = 1)
    {
        MsgBox 0x10, Error, The passwords do not match!
    }
    else
    {
        MsgBox 0x40, Success, The Account Database Startup Key was changed.
        gosub MainGUI
    }
    Return
    
    
Password_startup_clicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    GuiControl, Enable, EditPassword
    GuiControl, Enable, EditConfirm
    GuiControl, Disable, StoreFloppy
    GuiControl, Disable, StoreLocal
}
    
System_generated_password_clicked(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    GuiControl, Disable, EditPassword
    GuiControl, Disable, EditConfirm
    GuiControl, Enable, StoreFloppy
    GuiControl, Enable, StoreLocal
}

Secret:
    Gui, Show, , Created by Bluscream
    Sleep, 1000
    Gui, Show, , Securing the Windows Account Database
    Return

GuiEscape:
GuiClose:
    ExitApp
;$OBFUSCATOR: $END_AUTOEXECUTE:
