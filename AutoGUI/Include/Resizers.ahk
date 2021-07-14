; Contribution made by MJs
CreateResizers() {
    If (NoResizers) {
        Return
    }

    ResizerColor := DllCall("User32.dll\GetSysColor", "Int", 13, "UInt")
    ResizerBrush := DllCall("Gdi32.dll\CreateSolidBrush", "UInt", ResizerColor, "UPtr")

    Gui %Child%: Default
    Resizers := []
    Loop 8 {
        Gui Add, Text, x0 y0 w%ResizerSize% h%ResizerSize% hWndhResizer%A_Index% +0x100 Hidden
        Resizers.Push(hResizer%A_Index%)
    }

    Cursors := {(hResizer1): 32642, (hResizer2): 32645, (hResizer3): 32643, (hResizer4): 32643, (hResizer5): 32645, (hResizer6): 32642, (hResizer7): 32644, (hResizer8): 32644}
}

ShowResizers() {
    If (NoResizers) {
        Return
    }

    Gui %Child%: Default
    GuiControlGet p, Pos, %g_Control%

    GuiControl Movedraw, %hResizer1%, % "x" . (px - ResizerSize) . "y" . (py - ResizerSize)
    GuiControl MoveDraw, %hResizer2%, % "x" . (px + ((pw - ResizerSize) / 2)) . "y" . (py - ResizerSize)
    GuiControl MoveDraw, %hResizer3%, % "x" . (px + pw) . "y" . (py - ResizerSize)
     
    GuiControl MoveDraw, %hResizer4%, % "x" . (px - ResizerSize) . "y" . (py + ph)
    GuiControl MoveDraw, %hResizer5%, % "x" . (px + ((pw - ResizerSize) / 2)) . "y" . (py + ph)
    GuiControl MoveDraw, %hResizer6%, % "x" . (px + pw) . "y" . (py + ph)
     
    GuiControl MoveDraw, %hResizer7%, % "x" . (px - ResizerSize) . "y" . (py + ((ph - ResizerSize) / 2))
    GuiControl MoveDraw, %hResizer8%, % "x" . (px + pw) . "y" . (py + ((ph - ResizerSize) / 2))

    For Each, Item in Resizers {
        GuiControl Show, %Item%
    }

    Global hGrippedWnd := g_Control
}

HideResizers() {
    If (NoResizers) {
        Return
    }

    Gui %Child%: Default
    For Each, Item in Resizers {
        GuiControl Hide, %Item%
    }
}

IsResizer(hWnd) {
    Loop 8 {
        If (hWnd == Resizers[A_Index]) {
            Return True
        }
    }
    Return False
}

OnResize(hWnd) {
    Gui %Child%: Default
    CoordMode Mouse, Client
    MouseGetPos omx, omy
    GuiControlGet oc, %Child%: Pos, %hGrippedWnd%
    ncx := ncy := ncw := nch := 0

    hDC := DllCall("User32.dll\GetDC", "Ptr", hChildWnd, "UPtr")
    VarSetCapacity(RECT, 16, 0)

    If (hWnd == hResizer1) { ; x+y+w+h (NW)
        While (GetKeyState("LButton", "P")) {
            MouseGetPos mx, my
            nch := och - (my - ocy)
            ncw := ocw - (mx - ocx)
            If (mx = omx) ; Prevent flicker while redrawing the focus rect
                Continue
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            SetRect(RECT, mx, my, ncw + mx, nch + my)
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            omx := mx
        }
        ncx := mx, ncy := my
    } Else If (hWnd == hResizer2) { ; y+h (N)
        While (GetKeyState("LButton", "P")) {
            MouseGetPos mx, my
            nch := och - (my - ocy)
            If (oldmy = my)
                Continue
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            SetRect(RECT, ocx - 1, my, ocw + ocx + 1, my + nch + 1)
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            oldmy := my
        }
        ncx := ocx, ncy := my, ncw := ocw
    } Else If (hWnd == hResizer3) { ; y+w+h (NE)
        While (GetKeyState("LButton", "P")) {
            MouseGetPos mx, my
            nch := och - (my - ocy)
            ncw := mx - ocx + ResizerSize
            If (mx = omx)
                Continue
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            SetRect(RECT, ocx - 1, my - 1, ncw + ocx + 1, nch + my + 1)
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            omx := mx
        }
        ncx := ocx, ncy := my
    } Else If (hWnd == hResizer4) { ; x+w+h (SW)
        While (GetKeyState("LButton", "P")) {
            MouseGetPos mx, my
            nch := ocy + (my - ocy)
            ncw := ocw - (mx - ocx)
            If (mx = omx)
                Continue
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            SetRect(RECT, mx, ocy, ncw + mx, nch)
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            omx := mx
        }
        ncx := mx, ncy := ocy, nch := nch - ocy
    } Else If (hWnd == hResizer5) { ; h (S)
        While (GetKeyState("LButton", "P")) {
            MouseGetPos mx, my
            nch := ocy + (my - ocy)
            If (oldmy = my)
                Continue
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            SetRect(RECT, ocx, ocy, ocw + ocx - 2, nch)
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            oldmy := my
        }
        ncx := ocx, ncy := ocy,  ncw := ocw, nch := nch - ocy
    } Else If (hWnd == hResizer6) { ; w+h (SE)
        While (GetKeyState("LButton", "P")) {
            MouseGetPos mx, my
            nch := ocy + (my - ocy)
            ncw := ocx + (mx - ocx)
            If ((nch = och) && (ncw = ocw))
                Continue
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            SetRect(RECT, ocx, ocy, ncw, nch)
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            och := nch, ocw := ncw
        }
        ncx := ocx, ncy := ocy, nch := nch - ocy, ncw := ncw - ocx
    } Else If (hWnd == hResizer7) { ; x+w (W)
        While (GetKeyState("LButton", "P")) {
            MouseGetPos mx
            ncw := ocw - (mx - ocx)
            If (mx = oldmx)
                Continue
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            SetRect(RECT, mx, ocy, ncw + mx, och + ocy)
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            oldmx := mx
        }
        ncx := mx, ncy := ocy, nch := och
    } Else If (hWnd == hResizer8) { ; w (E)
        While (GetKeyState("LButton", "P")) {
            MouseGetPos mx
            ncw := ocw - (omx - mx)
            If (ncw = oldncw)
                Continue
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            SetRect(RECT, ocx, ocy, ncw + ocx, och + ocy)
            DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT)
            oldncw := ncw
        }
       ncx := ocx, ncy := ocy, nch := och
    }

    DllCall("User32.dll\DrawFocusRect", "Ptr", hDC, "Ptr", &RECT) ; Remove the focus rect
    DllCall("User32.dll\ReleaseDC", "Ptr", hChildWin, "Ptr", hDC)

    MouseGetPos mx, my
    If ((mx != omx) || (my != omy)) {
        NewPos := "x" . ncx . "y" . ncy . "w" . ncw . "h" . nch
        GuiControl MoveDraw, %hGrippedWnd%, % NewPos
        g_Control := hGrippedWnd
        g[g_Control].x := ncx
        g[g_Control].y := ncy
        g[g_Control].w := ncw
        g[g_Control].h := nch
        GenerateCode()
        ShowResizers()
        GoSub LoadProperties
    }
}

SetRect(ByRef RECT, x, y, w, h) {
    DllCall("SetRect", "Ptr", &RECT, "UInt", x, "UInt", y, "UInt", w, "UInt", h)
}
