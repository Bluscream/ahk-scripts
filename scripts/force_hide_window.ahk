; Function to hide, make transparent, and make click-through the current topmost window
HideAndModifyTopmostWindow() {
    ; Get the handle of the topmost window
    WinGet, hwnd, ID, A
    
    ; Attempt to hide the window using different methods
    WinHide, ahk_id %hwnd%
    WinSet, Style, -0x80000, ahk_id %hwnd% ; Remove WS_VISIBLE style
    WinSet, ExStyle, -0x80, ahk_id %hwnd% ; Remove WS_EX_APPWINDOW style
    WinSet, ExStyle, -0x20, ahk_id %hwnd% ; Remove WS_EX_TOPMOST style
    
    ; Make the window transparent
    WinSet, Transparent, 200, ahk_id %hwnd% ; Set transparency level (0-255)
    
    ; Make the window click-through
    WinSet, ExStyle, +0x00000020, ahk_id %hwnd% ; Add WS_EX_TRANSPARENT style
    
    ; Optionally, set the window to be always on top to ensure it remains hidden
    WinSet, AlwaysOnTop, Off, ahk_id %hwnd%
}

; Hotkey to trigger the function
^SPACE::HideAndModifyTopmostWindow()
