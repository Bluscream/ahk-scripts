; SetKeyDelay, -1 ; Sets the delay to the smallest possible value}
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include <bluscream>
global no_ui := false
scriptlog("Starting " . A_ScriptName . "...")

global buttons := ReadButtons()

global grids := {}

for n, param in A_Args {
    StringLower, param, % param
    for cat, buttons in buttons {
        if (param == cat) {
            grids.push(new ButtonGrid(cat, buttons))
            return
        }
    }
}
for cat, buttons in buttons {
    grids.push(new ButtonGrid(cat, buttons))
}

AlignGUIsSort(grids)

return

ReadButtons() {
    btns := {}
    ; Get a list of all config files in the buttons/ subfolder
    Loop, buttons/*.cfg
    {
        ; The A_LoopFileName variable contains the name of the current file
        category := StrReplace(A_LoopFileName, ".cfg", "")
        btns[category] := []
        scriptlog("[" . category . "] Loading from file " . A_LoopFileName)
        
        ; Open the config file for reading
        FileRead, config, buttons/%category%.cfg
        
        ; Split the config into lines
        lines := StrSplit(config, "`n", "`r")

        btnCount := 0
        skipped := 0
        
        ; Loop over each line in the config
        for index, line in lines
        {
            line := Trim(line)
            if (line == "" || SubStr(line, 1, 1) == ";" || SubStr(line, 1, 1) == "#" || SubStr(line, 1, 1) == "/") {
                ; scriptlog("Skipping line: " . line)
                skipped++
                continue
            }
            ; Split the line into components
            components := StrSplit(line, ",")
            
            ; Create a new button
            button := new CommandButton(components[1], components[2], components[3])
            
            ; Add the button to the category
            btns[category].push(button)
            btnCount++
        }
        scriptlog("[" . category . "] Added " . btnCount . " buttons (skipped: " . skipped . ")")
    }
    return btns
}

ButtonHandler() {
    ControlGetText, buttonText, %A_GuiControl%
    button := GetButtonByText(buttonText)
    cmd := button.command
    Gui, Submit, NoHide

    ; VConsole2 (64-bit)
    ; ahk_class QWidget
    ; ahk_exe vconsole2.exe

    ; Screen:	109, 877
    ; Window:	96, 787
    ; Client:	88, 756 (default)
    ; Color:	414141 (Red=41 Green=41 Blue=41)

    IfWinNotExist, VConsole2 ahk_class QWidget ahk_exe vconsole2.exe
    {
        Run, "G:\SteamLibrary\steamapps\common\Half-Life Alyx\game\bin\win64\vconsole2.exe"
        Sleep, 1000 ; Wait for the window to open
    }
    ; Tooltip, % button.command
    
    ; bring window to front
    WinActivate, VConsole2 ahk_class QWidget ahk_exe vconsole2.exe
    WinWaitActive, VConsole2 ahk_class QWidget ahk_exe vconsole2.exe
    ControlFocus, QWidget26, ahk_class QWidget
    Sleep, 50

    oldClip := clipboard
    Sleep, 50
    clipboard := button.command
    Sleep, 50
    Send, ^v{Enter}
    Sleep, 50
    clipboard := oldClip
    Sleep, 50

    ; ControlSetText, QWidget26, Your Text, ahk_class QWidget
    ; ControlSend, QWidget26, {Enter}, ahk_class QWidget

    ; ControlSend, QWidget26, , ahk_class QWidget

    ; SendInput, %cmd%{Enter}

    ; SendPlay, %buttonText%{Enter}
}

AlignGUIs(grids) {
    ; Assuming you have a list of GUIs stored in the variable `grids`
    ; and each GUI has a `width` and `height` property
    
    screenWidth := A_ScreenWidth
    screenHeight := A_ScreenHeight
    
    currentX := 0
    currentY := 0
    maxHeightInRow := 0
    
    for index, grid in grids {
        ahk_id := "ahk_id " . grid.id
        

        ; If the GUI would go off the right edge of the screen, move it to the next row
        if (currentX + Width > screenWidth) {
            currentX := 0
            currentY += maxHeightInRow
            maxHeightInRow := 0
        }

        ; If the GUI would go off the bottom edge of the screen, we've run out of space
        if (currentY + Height > screenHeight) {
            break
        }

        scriptlog("Moving grid " . ahk_id . " to X: " . currentX . ", Y: " . currentY . ", Width: " . grid.width . ", Height: " . grid.height . ", Size: " . grid.size)
        WinMove, % ahk_id, , %currentX%, %currentY%

        currentX += Width
        maxHeightInRow := max(maxHeightInRow, Height)
    }
}

AlignGUIsSort(grids) {    
    screenWidth := A_ScreenWidth
    screenHeight := A_ScreenHeight
    Sort, grids, F CompareSizes D
    currentX := 0
    currentY := 0
    maxHeightInRow := 0
    for index, grid in grids {
        ahk_id := "ahk_id " . grid.id
        if (currentX + grid.width > screenWidth) {
            currentX := 0
            currentY += maxHeightInRow
            maxHeightInRow := 0
        }
        if (currentY + grid.height > screenHeight) {
            break
        }
        scriptlog("Moving grid " . ahk_id . " to X: " . currentX . ", Y: " . currentY . ", Width: " . grid.width . ", Height: " . grid.height)
        WinMove, % ahk_id, , %currentX%, %currentY%
        currentX += grid.width
        maxHeightInRow := max(maxHeightInRow, grid.height)
    }
}
CompareSizes(grid1, grid2) {
    return grid2.size - grid1.size  ; Sort in descending order
}

GetButtonByText(text) {
    for _i, grid in grids {
        button := grid.getButtonByText(text)
        if (button) {
            return button
        }
    }
    return false
}

class CommandButton {
    text := "Button"
    description := ""
    command := ""

    __New(text, command, description := "") { 
        this.text := text
        this.command := command
        this.description := description
    }
}

class ButtonGrid {
    name := ""
    row := 0
    col := 0
    buttons := []
    id := 0x0
    width := 0
    height := 0
    size := 0

    __New(name, buttons) {
        this.name := name
        this.buttons := buttons
        Gui, New
        Gui, Font, s13  ; Change the font size to 18
        for i, button in buttons {
            this.addButton(button)
        }
        Gui, +AlwaysOnTop  ; Set the GUI to always stay on top
        Gui, Show,, % name
        this.id := WinExist("A")
        WinGetPos, , , width, height, % "ahk_id " . this.id
        this.width := width
        this.height := height
        this.size := this.width * this.height
    }

    addButton(button) {
        row := this.row
        col := this.col
        Gui, Add, Button, x%col% y%row% w200 h50 gButtonHandler, % button.text
        col += 200
        if (col >= 600) {
            col := 0
            row += 50
        }
        this.row := row
        this.col := col
    }

    getButtonByText(text) {
        for _i, button in this.buttons {
            if (button.text == text) {
                return button
            }
        }
        return false
    }
}

GuiClose() {
    ExitApp
}
