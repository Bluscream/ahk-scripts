#Include <AnimatedGifControl>

Gui, yoda: +Toolwindow -Caption +Lastfound +AlwaysOnTop

; Gui, yoda: Font, s22 ; Change the s# value to adjust font size.
AnimatedGifControl("yoda", "C:\Users\blusc\Desktop\yoda.gif", "w200 h200 bgc000000")

; RGBA (Red, Green, Blue, Alpha) = 0, 0, 0, 0
; HSB (Hue, Saturation, Brightness) = 0.0°, 0.0%, 0.0%
; CMYK (Cyan, Magenta, Yellow, Key) = 0.0%, 0.0%, 0.0%, 1.0%
; Hex (RGB, RGBA, ARGB) = #000000, #00000000, #00000000
; Decimal (RGB, RGBA, ARGB) = 0, 0, 0
; Cursor position (X, Y) = 0, 0

; Gui, yoda: Font

; Gui, yoda: Color, Green ; Change overlay colour here.

Gui, yoda: Show, % "x" . 1720 . "y" . 880, Overlay ;  . "w" . 80 . "h" . 80

GUI_ID := WinExist()
; Set it transparent and make it click-through.
WinSet, Transparent, 90         , % "ahk_id " . GUI_ID ; Change the numerical value for opaqueness amount.
WinSet, ExStyle    , ^0x00000020, % "ahk_id " . GUI_ID ; Leave this value alone.

