; #IfWinActive ESPHome ahk_class MozillaWindowClass ahk_exe librewolf.exe
^#::
    Send, ^c
    Sleep, 100
    ; ClipSaved := ClipboardAll
    cb := "" ; `n
    if (SubStr(Trim(Clipboard), 1, 1) = "#") {
        ToolTip, % "Uncommenting lines"
        Loop, Parse, Clipboard, `n, `r
        {
            cb .= SubStr(Trim(A_LoopField), 2) . "`n"
        }
    } else {
        ToolTip, % "Commenting lines"
        Loop, Parse, Clipboard, `n, `r
        {
            cb .= "# " . A_LoopField . "`n"
        }
    }
    Clipboard := cb
    ; Send, ^v
    Sleep, 100
    ; Clipboard := ClipSaved
    SetTimer, RemoveToolTip, -1000
return

RemoveToolTip:
    ToolTip
    return


#IfWinActive