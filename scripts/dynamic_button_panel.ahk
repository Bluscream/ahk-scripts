CreateDynamicGridGUI() {
    Gui, New, +AlwaysOnTop -DPIScale -Resize
    Gui, Add, Text, xm ym +Border +Center +0x200, Blah, Blah, Blah

    ; Define the grid
    grid := { 1: ["Button 1", "Button 2", "Button 3"], 2: ["Button 4", "Button 5", "Button 6"], 3: ["Button 7", "Button 8", "Button 9"] }

    ; Iterate over the rows and buttons
    for row, _buttons in grid {
        for _button in _buttons {
            Gui, Add, Button, x+15 w70, %_button%
        }
        ; Gui, Add, Text, `n  ; Add a newline after each row
    }

    Gui, Show, NA, Demo

    ; Get the initial size of the GUI window
    WinGetPos,,, w, h, % "ahk_id " GuiHwnd
    GuiDefaultW := w
    GuiDefaultH := h

    return

    GuiSize:
        ; Get the new size of the GUI window
        WinGetPos,,, w, h, % "ahk_id " GuiHwnd

        ; Calculate the ratio between the new size and the initial size
        WMulti := w / GuiDefaultW
        HMulti := h / GuiDefaultH

        ; Resize and move the buttons
        Loop, % GuiControls.Length() {
            ButtonX := GuiControls[A_Index].X * WMulti
            ButtonY := GuiControls[A_Index].Y * HMulti
            ButtonW := GuiControls[A_Index].W * WMulti
            ButtonH := GuiControls[A_Index].H * HMulti

            GuiControl, MoveDraw, % GuiControls[A_Index].Hwnd, % "x" ButtonX " y" ButtonY " w" ButtonW " h" ButtonH
        }

        return
}
CreateDynamicGridGUI()