/*
MousePrecise.ahk from Jack's AutoHotkey Blog 
https://jacksautohotkeyblog.wordpress.com/2016/05/05/autohotkey-script-for-precision-hotkey-mouse-movement-in-windows-graphics-programs-beginning-hotkeys-part-15/ and 
https://jacksautohotkeyblog.wordpress.com/2016/05/13/autohotkey-script-for-precision-hotkey-mouse-movement-in-windows-graphics-programs-continued-beginning-hotkeys-part-16/)
is an AutoHotkey script which converts the nummeric pad key into a mouse cursor repositioning
tool which moves the cursor one pixels at a time in eight possible directions with or
without the left mouse button held down.

This AutoHotkey script creates a graphics tool for precisely positioning the mouse cursor.
GroupAdd command is used to add graphics programs to the group of windows where Hotkeys are active.
Snipping Tool requires three different windows in the group.

ALT+arrow key moves mouse one pixel in the direction of the arrow key for precise alignment.

Scan Codes for numeric pad are used to map mouse cursor movement in eight directions
bypassing the NumLock key.

Numpad0 toggles left mouse button up and down.

Since the left mouse is disabled while LButton is toggled down, NumpadEnter is an escape
key for those times when a graphic window accidentally goes inactive while the LButton
is toggled down.

To temporarily activate the Hotkey group for any window to use CTRL+NumpadDel key.
This Hotkey adds the current active window's class to the Graphics group. To permanently
add the programs class, insert the GroupAdd command below.

If for some reason the hotkeys stop working, right-click on the system tray icon and select Reload.

To temporarily add a window to the group right-click on the system tray icon and select Add Window Class.

*/

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
; FileInstall, Mouse2.ico, Mouse2.ico

; add to auto-execute section of script
GroupAdd, Graphics, ahk_class Microsoft-Windows-Tablet-SnipperToolbar
GroupAdd, Graphics, ahk_class Microsoft-Windows-Tablet-SnipperCaptureForm
GroupAdd, Graphics, ahk_class Microsoft-Windows-Tablet-SnipperEditor
GroupAdd, Graphics, ahk_class IrfanView
GroupAdd, Graphics, ahk_class MSPaintApp


Hotkey, NumpadEnter, off
Menu, tray, add, Add Window Class (CTRL+NumpadDel), AddClass
Menu, tray, add, Reload, Reload
; Menu, tray, Icon, Mouse2.ico
		
; Add the following directives and Hotkeys toward the end of the script

#IfWinActive ahk_group Graphics  
    
!up::MouseMove, 0, -1, 0, R  ; Win+UpArrow hotkey => Move cursor upward
!Down::MouseMove, 0, 1, 0, R  ; Win+DownArrow => Move cursor downward
!Left::MouseMove, -1, 0, 0, R  ; Win+LeftArrow => Move cursor to the left
!Right::MouseMove, 1, 0, 0, R  ; Win+RightArrow => Move cursor to the right
;Numpad0::Send % (toggle := !toggle) ? "{LButton Down}" : "{LButton Up}"  ; Replaced with Scan Code

;SC052::Send % (toggle := !toggle) ? "{LButton Down}" : "{LButton Up}"    ; Replaced with "If" conditional to add more features

; There are two forms of the SC052 Hotkey. The first uses If conditional statements to embedded additional commands.
; The second form (currently active) uses functions to embed the on and off command, plus the ternary operator in the Hotkey.
; The second form makes the script more modular (one Hotkey and two functions) while making the function available
; elsewhere in the script—if needed.


/*         
SC052::                ; This is the If conditional form of the Hotkey
   if  (toggle := !toggle)
    {
	  Hotkey, NumpadEnter, on
	  Send {LButton Down}
	  Tooltip, Left Button Down`rNumpadEnter to cancel, 20,20
	}
    else
	{	   
	  Hotkey, NumpadEnter, off
	  Send {LButton Up}
	  Tooltip
	}
Return
*/

SC052::% (toggle := !toggle) ? toggleon() : toggleoff()  ; This form of the Hotkey using functions and the ternary
toggleon()
    {
	  Hotkey, NumpadEnter, on
	  Send {LButton Down}
	  Tooltip, Left Button Down`rNumpadEnter to cancel, 20,20
	}

toggleoff()
	{	   
	  Hotkey, NumpadEnter, off
	  Send {LButton Up}
	  Tooltip
	}
	
; Hardwire mouse cursor movement in eight directions one pixel at a times

SC04F::MouseMove, -1, 1, 0, R  ; Numpad1 key down left
SC050::MouseMove, 0, 1, 0, R   ; Numpad2 key down
SC051::MouseMove, 1, 1, 0, R   ; Numpad3 key down right
SC04B::MouseMove, -1, 0, 0, R  ; Numpad4 key left
SC04C::Return                  ; Numpad5 key does nothing
SC04D::MouseMove, 1, 0, 0, R   ; Numpad6 key right
SC047::MouseMove, -1, -1, 0, R ; Numpad7 key up left
SC048::MouseMove, 0, -1, 0, R  ; Numpad8 key up
SC049::MouseMove, 1, -1, 0, R  ; Numpad9 key up right

^SC050::MouseMove, -1, 2, 0, R ; Sample code for adding another angle  206.6°
^SC048::MouseMove, 1, -2, 0, R ; Sample code for adding another angle   26.6°
^SC04D::MouseMove, 7, -4, 0, R ; Sample code for adding another angle   ~60 °

#IfWinActive

#If toggle and WinActive("ahk_group Graphics") ;disable the left mouse button
 
LButton::Return

#If



NumpadEnter::   ; Escape Hotkey
  Tooltip              ; turn Tooltip off
  toggle = 0           ; set toogle to off
  Send {LButton Up}    ; release LButton
Return


^SC053::   ;Hotkey CTRL+NumpadDel to add window class to group
  WinGetTitle, title , A
  WinGetClass, class, A
  ; Ignore certain classes of windows — This portion stolen from Jim S.
  ; Progman = Desktop; DV2ControlHost = Start Menu; Shell_TrayWnd = Taskbar
If class in Progman,DV2ControlHost,Shell_TrayWnd,Windows.UI.Core.CoreWindow,WorkerW,MultitaskingViewFrame
  Return
Else
  {
  GroupAdd, Graphics, ahk_class %class%
  RegExMatch(title,"-\s(.*)",ProgName)
  MsgBox, % ProgName1 . " temporarily`radded to MousePrecise group."
  }
Return

Reload:
  Reload
Return

AddClass:
  SendInput, !{Esc}
  GoSub, ^SC053
Return

