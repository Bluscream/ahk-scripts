; SetFormat, Integer, H
Hotkey, Space, OnKeyStroke
Loop, 0x7f
Hotkey, % ""*~"" . chr(A_Index), OnKeyStroke
Return