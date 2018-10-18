; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-unlocker-ahk
#SingleInstance, Force
#NoTrayIcon
#NoEnv
RETURN ; end of auto-execute section.

; Prohibit applications from disabling windows or controls, by simply clicking
; on them.  This is especially useful when you wish to access a parent window
; while a settings or dialog window is visible, ie; a Save/Open dialog.
; 
; Example:  Winamp's main window becomes disabled when selecting an Equalizer
; setting from the list of presets.  This script makes Winamp always accessible,
; so you can always keep the preset list open if you desire. -- Raccoon 2010

#If Enable_Window_Under_Cursor() || True
~LButton::Return
#If ; End If

;~LButton::
;  Enable_Window_Under_Cursor()
;  Return

Enable_Window_Under_Cursor() ; By Raccoon 31-Aug-2010
{
  MouseGetPos,,, WinHndl, CtlHndl, 2
  WinGet, Style, Style, ahk_id %WinHndl%
  if (Style & 0x8000000) { ; WS_DISABLED.
    WinSet, Enable,, ahk_id %WinHndl%
  }
  WinGet, Style, Style, ahk_id %CtlHndl%
  if (Style & 0x8000000) { ; WS_DISABLED.
    WinSet, Enable,, ahk_id %CtlHndl%
  }
}