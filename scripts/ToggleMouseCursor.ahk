#NoEnv
#Persistent
#SingleInstance, Force

cursorIsVisible := true

F1::
    cursorIsVisible := !cursorIsVisible
    if (cursorIsVisible)
        ShowCursor()
    else
        HideCursor()
    return

RemoveToolTip:
    SetTimer, RemoveToolTip, Off
    ToolTip
    return

ShowCursor()
{
    SystemCursor("On")
    SetTimer, RemoveToolTip, 2000
    ToolTip, Cursor is now visible
}

HideCursor()
{
    SystemCursor("Off")
    SetTimer, RemoveToolTip, 2000
    ToolTip, Cursor is now hidden
}

SystemCursor(OnOff := "On")
{
    static AndMask, XorMask, SC_OCR = [32650, 32649, 32651, 32652, 32648, 32646, 32643, 32642, 32644, 32645, 32647, 32641]
    ,c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13 ; system cursors
    , b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13 ; blank cursors
    , h1,h2,h3,h4,h5,h6,h7,h8,h9,h10,h11,h12,h13 ; handles of the system cursors
    if (OnOff = "Toggle")
        OnOff := (b1 ? "On" : "Off")
    if (OnOff = "Off" and !b1) ; create blank cursors
    {
        VarSetCapacity(AndMask, 32*4, 0xFF)
        VarSetCapacity(XorMask, 32*4, 0)
        system_cursors := DllCall("LoadLibrary", "Str", "user32.dll")
        Loop 13
        {
            h_cursor := DllCall("LoadCursor", "Ptr", system_cursors, "Ptr", SC_OCR[A_Index])
            hbmMask := DllCall("CreateBitmap", "Int", 32, "Int", 32, "UInt", 1, "UInt", 1, "Ptr", 0)
            hbmColor := DllCall("CreateBitmap", "Int", 32, "Int", 32, "UInt", 1, "UInt", 1, "Ptr", 0)
            b%A_Index% := DllCall("CreateIconIndirect", "Ptr", &AndMask, "Ptr", &XorMask, "UInt", hbmMask, "UInt", hbmColor)
            DllCall("DestroyIcon", "Ptr", h_cursor)
            DllCall("DeleteObject", "Ptr", hbmMask)
            DllCall("DeleteObject", "Ptr", hbmColor)
        }
        DllCall("FreeLibrary", "Ptr", system_cursors)
    }
    Loop 13
    {
        if !(c%A_Index% := DllCall("CopyImage", "Ptr", (h%A_Index% := DllCall("LoadCursor", "Ptr", 0, "Ptr", SC_OCR[A_Index])), "UInt", 2, "Int", 0, "Int", 0, "UInt", 0))
            return
        if (OnOff = "Off")
            DllCall("SetSystemCursor", "Ptr", b%A_Index%, "UInt", SC_OCR[A_Index])
        else
            DllCall("SetSystemCursor", "Ptr", c%A_Index%, "UInt", SC_OCR[A_Index])
    }
}
