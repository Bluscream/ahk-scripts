#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
Menu, Tray, Icon, vCursor.ico
#SingleInstance Force

global 	xOffset 	   := 40
global 	yOffset 	   := 60
global  TotalTime      := 500

global  CurrentCursor   = N
global  CursorCount     = 1
global 	TypeCount		= 1
global 	KeyCount		:= ""
global 	ImageArray 		:= 		[{anno:["L", "M", "R"], mouse:["L", "M", "R"], button:["L", "M", "R"]}]
global  arrowArray  	:=   	["N", "E", "S", "W"]

; Create an invisible GUI that the picture is placed on:      
	Gui, -Caption +AlwaysOnTop +ToolWindow	;----
	Gui -DPIScale                         ;   |
	Gui, Margin , 0, 0						;   | Main Gui settings
	Gui, Color, 2B2B2C     					;----
					; 
	Gui +LastFound 					; ----
	WinSet, TransColor, 2B2B2C		; ---- Make this color (and the GUI, for being this color) transparent

	Gui, Add, Picture, x0 y0 vBG, annoM.png     ;    Add a picture control
	Gui, Show, Hide Center 					    ;    Build/Show the Gui, center it on screen but hide it

SetTimer, mouseTrack, 20  			; ---- Set a Timer to run itself every 20 miliseconds

Return  ;  End Auto-Execute

; F24::
; MsgBox % A_ScreenDPI "`r`n"
; Return

; The timer being called above
mouseTrack:
	CoordMode, Mouse, Screen      					    ;----
	global vCurX, vCurY, hWnd, vCtlClassNN              ;   | Track the mouse position
	MouseGetPos, vCurX, vCurY, hWnd, vCtlClassNN        ;----
	CoordMode, Pixel, Screen 							    ;----	
	PixelGetColor, Camouflage, %vCurX%, %vCurY%, RGB  		;----  Record the color of the pixel under mouse
Return


WhichKey(){
	If (A_ThisHotkey = "~*RButton")
		KeyCount = 3
	If (A_ThisHotkey = "~*MButton")
		KeyCount = 2
	If (A_ThisHotkey = "~*LButton")
		KeyCount = 1

	vOutput := ""
	for vKey, vValue in ImageArray {
		for vKey2, vValue2 in vValue {
			If (A_Index > TypeCount)
			Break
			for vKey3, vValue3 in vValue2{
				If (A_Index > KeyCount) 
				Break
				vOutput := vKey2 vValue3
			}	 
		}
		GuiControl, , BG, % vOutput ".png"
	}
	Return
}


#If GetKeyState("CapsLock","T") ; If CapsLock is on
~*LButton::
~*MButton::
~*RButton::
	WinGet, active_id, ID, A
	Gui, Color, %Camouflage%
	mouseX := vCurX-xOffset
	mouseY := vCurY-yOffset
	WinSet, Transparent, 255, ahk_class AutoHotkeyGUI
	WhichKey()
	Gui, Show, NoActivate x%mouseX% y%mouseY%
Return

~*LButton Up::
~*MButton Up::
~*RButton Up::
	FadeOut()
	WinSet, TransColor, 2B2B2C
Return

^#MButton::
	++TypeCount
	If (TypeCount > 3)
	TypeCount = 1
Return
#If                              ; No longer affected by CapsLock



; @tic
; //autohotkey.com/board/topic/56327-simple-fade-in-out/?p=355931
FadeOut(){
	Time1 := A_TickCount
	Loop
	{
		Trans := Round(((A_TickCount-Time1)/TotalTime)*255)
		Inv := ((Trans * (-1)) + 255)
		WinSet, Transparent, %Inv%, ahk_class AutoHotkeyGUI
		If (Trans >= 255)
			break
		Sleep, 10
	}
	; MsgBox % Trans
	Gui, Show, Hide
	Return
}


^#WheelUp::
If (A_PriorHotkey != A_ThisHotkey or A_TimeSincePriorHotkey > 60) {
	++CursorCount
	If (CursorCount > arrowArray.Length())
		{
			CursorCount := arrowArray.MinIndex()
		}
	arrowCheck()
}
Return

^#WheelDown::
If (A_PriorHotkey != A_ThisHotkey or A_TimeSincePriorHotkey > 60) {
	--CursorCount
	If (CursorCount < arrowArray.MinIndex())
		{
			CursorCount := arrowArray.Length()
		}
	arrowCheck()
}
Return


arrowCheck(){
	If (CursorCount = 1)
		SetSystemCursor(A_ScriptDir "\arrowN.cur")
	If (CursorCount = 2)
		SetSystemCursor(A_ScriptDir "\arrowE.cur")
	If (CursorCount = 3)
		SetSystemCursor(A_ScriptDir "\arrowS.cur")
	If (CursorCount = 4)
		SetSystemCursor(A_ScriptDir "\arrowW.cur")
	Return
}


CapsLock::
	; Uncomment these to see a tooltip during CapsLock
	If !GetKeyState("CapsLock","T") {
		SetCapsLockState, On
		; SetTimer, TooltipDebug, 20
	} Else {
		SetCapsLockState, Off
		; SetTimer, TooltipDebug, Off
		; Tooltip
	}
Return

TooltipDebug:
	; Place any variables in here to show a Tooltip and see their current values, infinitely useful for seeing results and testing.
	ToolTip % CursorCount "`r`n" CurrentCursor 
Return


; @anon
;//autohotkey.com/board/topic/81438-is-there-an-easy-way-to-hide-cursor/?p=517640
; @Serenity
;https://autohotkey.com/board/topic/32608-changing-the-system-cursor/
F24::(k := !k)? SetSystemCursor(A_ScriptDir "\Sword.cur"):RestoreSystemCursor()

SetSystemCursor(Cursor) {
	toggle = 1
    return DllCall("SetSystemCursor", "UInt", DllCall("LoadCursorFromFile", "Str", Cursor), "Int", "32512")
}

RestoreSystemCursor() {
	toggle = 0
    return DllCall("SystemParametersInfo", "UInt", 0x57, "UInt", 0, "UInt", 0, "UInt", 0)
}

RestoreAndExit:
    RestoreSystemCursor()
    ExitApp


OnExit, RestoreAndExit

Exit:
^Esc::
ExitApp