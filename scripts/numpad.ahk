#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

global active_id
WinGet, active_id, IDLast, A
#Include <bluscream>
global JoystickNumber = 3
global focused = 1
; Up::(1) Down::(2) Left::(3) Right::(4)
; [ "Button1" ,"Button2"  ,"Button3"  ,"Button4"  ]
; [ "Button5" ,"Button6"  ,"Button7"              ]
; [ "Button8" ,"Button9"  ,"Button10" ,"Button11" ]
; [ "Button12","Button13" ,"Button14" ,"Button15" ]
; [ "Button16",           ,"Button17"             ]
global buttons := []
buttons.Push([ 16,   5,      4,  2 ])    ; 1
buttons.Push([ 13,   6,      1,  3 ])    ; 2
buttons.Push([ 17,   7,      2,  4 ])    ; 3
buttons.Push([ 15,  11,      3,  1 ])    ; 4
buttons.Push([  1,   8,      7,  6 ])    ; 5
buttons.Push([  2,   9,      5,  8 ])    ; 6
buttons.Push([  3,  10,      6,  9 ])    ; 7
buttons.Push([  5,  12,     11, 10 ])    ; 8
buttons.Push([  6,  13,      8, 11 ])    ; 9
buttons.Push([  7,  14,      9, 12 ])    ; 10
buttons.Push([  4,  15,     10, 13 ])    ; 11
buttons.Push([  8,   5,     15, 14 ])    ; 12
buttons.Push([  9,   2,     12, 15 ])    ; 13
buttons.Push([ 10,  17,     13, 16 ])    ; 14
buttons.Push([ 11,   4,     14,  2 ])    ; 15
buttons.Push([ 12,   5,     17,  2 ])    ; 16
buttons.Push([ 14,   3,     16,  2 ])    ; 17

#Include %A_ScriptDir%\AutoXYWH.ahk
Gui Main: New, +LabelMain +hWndhMainWnd -Resize -MinimizeBox -MaximizeBox -SysMenu +AlwaysOnTop -Caption ; -DPIScale
Gui Font, s20
Gui Add, Button, hWndhBtnNum vBtnNum gnum x23 y17 w143 h129, &NUM
Gui Add, Button, hWndhBtnAnd vBtnAnd gand x183 y17 w143 h129, &/
Gui Add, Button, hWndhBtnstar vBtnstar gstar x343 y17 w143 h129, &*
Gui Add, Button, hWndhBtnminus vBtnminus gminus x503 y17 w143 h129, &-
Gui Add, Button, hWndhBtn7 vBtn7 g7 x23 y160 w143 h129, &7`nPOS1
Gui Add, Button, hWndhBtn8 vBtn8 g8 x183 y160 w143 h129, &8`n?
Gui Add, Button, hWndhBtn9 vBtn9 g9 x343 y160 w143 h129, 9`nPGUP
Gui Add, Button, hWndhBtn4 vBtn4 g4 x23 y303 w143 h129, &4`n?
Gui Add, Button, hWndhBtn5 vBtn5 g5 x183 y303 w143 h129, &5
Gui Add, Button, hWndhBtn6 vBtn6 g6 x343 y303 w143 h129, &6`n?
Gui Add, Button, hWndhBtnplus vBtnplus gplus x503 y160 w143 h266, &+
Gui Add, Button, hWndhBtnend vBtnend gend x23 y446 w143 h129, &1`nEND
Gui Add, Button, hWndhBtn2 vBtn2 g2 x183 y446 w143 h129, &2`n?
Gui Add, Button, hWndhBtn3 vBtn3 g3 x343 y446 w143 h129, &3`nPGDN
Gui Add, Button, hWndhBtnEnter vBtnEnter gEnter x503 y446 w143 h265, &ENTER
Gui Add, Button, hWndhBtn0 vBtn0 g0 x23 y589 w303 h129, &0
Gui Add, Button, hWndhBtnNdel vBtnNdel gdel x343 y589 w143 h129, &,`nDEL
Gui Show, w669 h732, Virtual Numpad

GetKeyState, JoyInfo, %JoystickNumber%JoyInfo
IfInString, JoyInfo, P  ; Joystick has POV control, so use it as a mouse wheel.
	SetTimer, JoyStickControl, 250
Return

#IfWinActive, Virtual Numpad
Up::navigateTo(1)
Down::navigateTo(2)
Left::navigateTo(3)
Right::navigateTo(4)
3Joy2::MainClose(0)
#IfWinActive

JoyStickControl:
    GetKeyState, JoyPOV, %JoystickNumber%JoyPOV
    if JoyPOV = 0 ; Forward
        navigateTo(1)
    else if JoyPOV = 9000 ; right
        navigateTo(4)
    else if JoyPOV = 18000 ; Back
        navigateTo(2)
    else if JoyPOV = 27000 ; left
        navigateTo(3)
    return

navigateTo(direction) {
    if (direction == 3) {
        Send +{Tab}
    } else if (direction == 4) {
        Send {Tab}
    }
    ; GuiControlGet, out, FocusV
    ; GuiControlGet, out2
    ; GuiControlGet, out3, Name
    ; GuiControlGet, out4, FocusV
    ; scriptlog(toJson([out, out2, out3, out4]))
    ; scriptlog("focused: " . focused)
    focused := buttons[focused][direction]
    ; scriptlog("next: " . focused)
    GuiControl, Focus, Button%focused%
}

SendKey(key){
    Gui, Destroy
    Send {%key%}
    MainClose(0)
}

num(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SetNumLockState % !GetKeyState("NumLock", "T")
    MainClose(0)
}

and(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("NumpadDiv")
}

star(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("NumpadMult")
}

minus(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("NumpadSub")
}

9(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad9")
}

8(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad8")
}

7(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad7")
}

6(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad6")
}

5(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad5")
}

4(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad4")
}

3(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad3")
}

2(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad2")
}

end(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad1")
}

0(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("Numpad0")
}

plus(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("NumpadAdd")
}

Enter(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("NumpadEnter")
}

del(CtrlHwnd, GuiEvent, EventInfo, ErrLevel := "") {
    SendKey("NumpadDot")
}

MainSize(GuiHwnd, EventInfo, Width, Height) {
    If (A_EventInfo == 1)
        Return
    AutoXYWH("xywh", hBtnNum)
    AutoXYWH("xywh", hBtnAnd)
    AutoXYWH("xywh", hBtnstar)
    AutoXYWH("xywh", hBtnminus)
    AutoXYWH("xywh", hBtnpos1)
    AutoXYWH("xywh", hBtn8)
    AutoXYWH("xywh", hBtn9)
    AutoXYWH("xywh", hBtn4)
    AutoXYWH("xywh", hBtn5)
    AutoXYWH("xywh", hBtn6)
    AutoXYWH("xywh", hBtnplus)
    AutoXYWH("xywh", hBtnend)
    AutoXYWH("xywh", hBtn2)
    AutoXYWH("xywh", hBtn3)
    AutoXYWH("xywh", hBtnEnter)
    AutoXYWH("xywh", hBtn0)
    AutoXYWH("xywh", hBtnNdel)
}

MainEscape(GuiHwnd) {
    MainClose(GuiHwnd)
}
MainClose(GuiHwnd) {
    ExitApp
}
