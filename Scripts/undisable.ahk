#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
;#NoTrayIcon

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
tooltips := true

; Prohibit applications from disabling windows or controls, by simply clicking
; on them.  This is especially useful when you wish to access a parent window
; while a settings or dialog window is visible, ie; a Save/Open dialog.
; 
; Example:  Winamp's main window becomes disabled when selecting an Equalizer
; setting from the list of presets.  This script makes Winamp always accessible,
; so you can always keep the preset list open if you desire. -- Raccoon 2010

;~LButton:: ;	Changed due to LButton firing this causing some pages in Chrome to stop reacting to input
~LButton & Shift::
  Enable_Window_Under_Cursor()
  Return

Enable_Window_Under_Cursor() ; By Raccoon 31-Aug-2010
{
  MouseGetPos,,, WinHndl, CtlHndl, 2
  WinGet, Style, Style, ahk_id %WinHndl%
  if (Style & 0x8000000) { ; WS_DISABLED.
    if (tooltips)
      ToolTip, "Enabling window..."
    WinSet, Enable,, ahk_id %WinHndl%
    if (tooltips)
      ToolTip, "Window Undisabled!"
    Sleep, 50
  }
  if !(Style & 0x40000){ ; WS_SIZEBOX
    if (tooltips)
      ToolTip, "Forcing window resizable..."
    WinSet, Style, +0x40000, ahk_id %WinHndl%
    if (tooltips)
      ToolTip, "Forced window resizable!"
    Sleep, 50
  }
  if !(Style & 0x80000){ ; WS_SYSMENU
    if (tooltips)
      ToolTip, "Enabling title bar..."
    WinSet, Style, +0x80000, ahk_id %WinHndl%
    if (tooltips)
      ToolTip, "Enabled title bar!"
    Sleep, 50
  }
  if !(Style & 0x20000){ ; WS_MINIMIZEBOX
    if (tooltips)
      ToolTip, "Enabling minimze button..."
    WinSet, Style, +0x20000, ahk_id %WinHndl%
    if (tooltips)
      ToolTip, "Enabled minimize button!"
    Sleep, 50
  }
  if !(Style & 0x10000){ ; WS_MAXIMIZEBOX
    if (tooltips)
      ToolTip, "Enabling maximize button..."
    WinSet, Style, +0x10000, ahk_id %WinHndl%
    if (tooltips)
      ToolTip, "Enabled maximize button!"
    Sleep, 50
  }
  if !(Style & 0x00000400L){ ; WS_EX_CONTEXTHELP
    if (tooltips)
      ToolTip, "Enabling help button..."
    WinSet, Style, +0x00000400L, ahk_id %WinHndl%
    if (tooltips)
      ToolTip, "Enabled help button!"
    Sleep, 50
  }
  if !(Style & 0x00000010L){ ; WS_EX_ACCEPTFILES
    if (tooltips)
      ToolTip, "Enabling drag n drop..."
    WinSet, Style, +0x00000010L, ahk_id %WinHndl%
    if (tooltips)
      ToolTip, "Enabled drag n drop!"
    Sleep, 50
  }
  WinGet, Style, Style, ahk_id %CtlHndl%
  if (Style & 0x8000000) { ; WS_DISABLED.
    if (tooltips)
      ToolTip, "Enabling control..."
    WinSet, Enable,, ahk_id %CtlHndl%
    if (tooltips)
      ToolTip, "Control Undisabled!"
    Sleep, 100
  }
  Sleep, 250
  if (tooltips)
    ToolTip, ""
}
