
class CommandButton {
    text := "Button"
    command := ""
    callback := null

    __New(text, command, callback := null) { 
        this.text := text
        this.command := command
        this.callback := callback
    }
}

class ButtonGrid {
    name := ""
    row := 0
    col := 0

    __New(category, buttons) {
        this.name := category
        Gui, New
        Gui, Font, s13
        for i, button in buttons {
            this.addButton(button)
        }
        Gui, +AlwaysOnTop
        Gui, Show,, %category%
    }

    addButton(button) {
        row := this.row
        col := this.col
        ; create button and bind callback
        buttonHandler := Func("callback").Bind(this, button)
        Gui, Add, Button, hwnd hwndButton, % button.text
        ; Gui, Add, Button, x%col% y%row% w200 h50 gButtonHandler, % button.text
        col += 200
        if (col >= 600) {
            col := 0
            row += 50
        }
        this.row := row
        this.col := col
    }

    callback(button) {
        if (button.callback != null) {
                button.callback(button)
        } else {
            Tooltip, % "EXAMPLE CALLBACK > text: " . button.text . ", command: " . button.Command
        }
    }
}

; ButtonHandler() {
;     ControlGetText, buttonText, %A_GuiControl%
;     Gui, Submit, NoHide
;     ; get button by text
; }

GuiClose() {
    ExitApp
}
