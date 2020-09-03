#Include %A_LineFile%\..\json.ahk
global ui := False
scriptlog(msg, timestamp := "", append := false) {
    if(noui == true)
        return
    if(ui == false){
        ListVars
        WinWait ahk_class AutoHotkey
        ControlSetText Edit1, , ahk_class AutoHotkey
        ui := true
    }
    ControlGetText, Edit1Text, Edit1, ahk_class AutoHotkey
    if (!timestamp) {
        FormatTime, timestamp, A_Now, hh:mm:ss
    }
    if (msg == "") {
        msg := toJson(msg)
    }
    msg := StrReplace(msg, "\n" , "`r`n")
    msg := StrReplace(msg, "\t" , "`t")
    if (timestamp == "append") {
        ControlSetText Edit1, %Edit1Text%%msg%, ahk_class AutoHotkey
    } else if (timestamp == "inline") {
        FormatTime, timestamp, A_Now, hh:mm:ss
        ControlSetText Edit1, %Edit1Text%[%timestamp%] %msg%, ahk_class AutoHotkey
    } else {
        ControlSetText Edit1, %Edit1Text%[%timestamp%] %msg%`r`n, ahk_class AutoHotkey
    }
    PostMessage, 0x115, 7, , Edit1, ahk_class AutoHotkey
}
global lastToolTip := ""
ShowToolTip(msg){
    if (msg == lastToolTip) {
        return
    }
    lastToolTip := msg
    ToolTip, %msg%
}
SplashScreen(title, text="", time=1000) {
    SetTimer, RemoveSplashScreen, % time
    SplashImage, , b FM18 fs12, % title, % text
}
RemoveSplashScreen:
    SetTimer, RemoveSplashScreen, Off
    SplashImage, Off
MultiLineInputBox(Text:="", Default:="", Caption:="AutoHotKey"){
    static
    ButtonOK:=ButtonCancel:= false
    if !MultiLineInputBoxGui{
        Gui, MultiLineInputBox: add, Text, r1 w600  , % Text
        Gui, MultiLineInputBox: add, Edit, r10 w600 vMultiLineInputBox, % Default
        Gui, MultiLineInputBox: add, Button, w60 gMultiLineInputBoxOK , &OK
        Gui, MultiLineInputBox: add, Button, w60 x+10 gMultiLineInputBoxCancel, &Cancel
        MultiLineInputBoxGui := true
    }
    GuiControl,MultiLineInputBox:, MultiLineInputBox, % Default
    Gui, MultiLineInputBox: Show,, % Caption
    SendMessage, 0xB1, 0, -1, Edit1, A
    while !(ButtonOK||ButtonCancel)
        continue
    if ButtonCancel
        return
    Gui, MultiLineInputBox: Submit, NoHide
    Gui, MultiLineInputBox: Cancel
    return MultiLineInputBox
    ;----------------------
    MultiLineInputBoxOK:
    ButtonOK:= true
    return
    ;---------------------- 
    MultiLineInputBoxGuiEscape:
    MultiLineInputBoxCancel:
    ButtonCancel:= true
    Gui, MultiLineInputBox: Cancel
    return
}
MultiLineInput(Text:="Waiting for Input") {
    Global MLI_Edit
    Gui, Add, Edit, vMLI_Edit x2 y2 w396 r4
    Gui, Add, Button, gMLI_OK x1 y63 w199 h30, &OK
    Gui, Add, Button, gMLI_Cancel x200 y63 w199 h30, &Cancel
    Gui, Show, h94 w400, %Text%
    Goto, MLI_Wait
    MLI_OK:
        GuiControlGet, MLI_Edit
    MLI_Cancel:
    GuiEscape:
        ReturnNow := True
    MLI_Wait:
        While (!ReturnNow)
            Sleep, 100
    Gui, Destroy
    Return %MLI_Edit%
}