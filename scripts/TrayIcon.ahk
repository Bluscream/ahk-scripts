#NoEnv							; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input					; Recommended for new scripts due to its superior speed and reliability.

; This script assumes that TrayIcon.ahk is in one of your library locations:
;    %A_ScriptDir%\Lib\                                  ; Local library - requires v1.0.90+.
;    %A_MyDocuments%\AutoHotkey\Lib\                     ; User library.
;    path-to-the-currently-running-AutoHotkey.exe\Lib\   ; Standard library.
; If not in any of those, then add an #Include at the top pointing to the file.
#Include <TrayIcon>

; Create a ListView to display the list of info gathered
Gui Add, ListView, Grid r30 w700 Sort, Process|Tooltip|Visible|Handle

; Get all of the icons in the system tray using Sean's TrayIcon library
oIcons := TrayIcon_GetInfo()

; Loop through the info we obtained and add it to the ListView
Loop, % oIcons.MaxIndex()
{
    proc := oIcons[A_Index].Process
    ttip := oIcons[A_Index].tooltip
	tray := oIcons[A_Index].Tray
    hWnd := oIcons[A_Index].hWnd
    
	vis := (tray == "Shell_TrayWnd") ? "Yes" : "No"
	
    LV_Add(, proc, ttip, vis, hWnd)
}

LV_ModifyCol()
LV_ModifyCol(3, "AutoHdr")          ; Auto-size the 3rd column, taking into account the header's text

Gui Show, Center, System Tray Icons
Return

GuiEscape:
GuiClose:
    ExitApp