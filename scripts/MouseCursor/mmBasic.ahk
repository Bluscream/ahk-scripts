#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance Force

; Create an invisible GUI that the picture is placed on:      
	Gui, -Caption +AlwaysOnTop +ToolWindow	;----
	Gui, Margin , 0, 0						;   |  Main Gui settings
	Gui, Color, 2B2B2C     					;----
					; 
	Gui +LastFound 					; ----
	WinSet, TransColor, 2B2B2C		; ---|  Make this color (and the GUI, for being this color) transparent

	Gui, Add, Picture, x0 y0 vBG, annoM2.png    ;----  Add a picture control
	Gui, Show, Hide Center 					    ;----  Build/Show the Gui, center it on screen but hide it

SetTimer, mouseTrack, 20  			; ----  Set a Timer to run itself every 20 miliseconds

Return  ;  End Auto-Execute

; The timer being called above
mouseTrack:
	CoordMode, Mouse, Screen      					    ;----
	global vCurX, vCurY, hWnd, vCtlClassNN              ;   |  Track the mouse position
	MouseGetPos, vCurX, vCurY, hWnd, vCtlClassNN        ;----
Return

~*RButton::
	mouseX := vCurX-60, mouseY := vCurY-80	  ;----  Offset from initial mouse position, origin is top left corner of picture
	Gui, Show, x%mouseX% y%mouseY%	          ;----  Show the gui (unhide) at the newly offset position
Return

~*RButton Up::
	Gui, Show, Hide      ;-----  Hide the gui when the button goes up
Return