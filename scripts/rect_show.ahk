#SingleInstance, force

GetRect()

ESC::
    Gui, Destroy
    GetRect()
return
GetRect() {
    c := ParseCoords(GetCoords())
    AddRect(c[1],c[2],c[3],c[4])
}
GetCoords() {
    InputBox, inputBox, Enter x y w h, , , , , , , , , 100 100 200 200
    return inputBox
}
ParseCoords(text) {
    StringSplit, i, text, ` `
    return [i1,i2,i3,i4]
}
AddRect(x,y,w,h) {
    global MyText
    Gui, -Caption +AlwaysOnTop +E0x20
    ; Gui, Color, 60FFFFFF
    Gui, Margin, 0, 0
    Gui, Add, Text, vMyText x%x% y%y% w%w% h%h%,
    Gui, Show, x%x% y%y% w%w% h%h%, Rect %x%,%y%,%w%,%h%
}