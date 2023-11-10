; SetKeyDelay, -1 ; Sets the delay to the smallest possible value}
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include <bluscream>
global no_ui := true
; _scriptlog("Starting " . A_ScriptName . "...")

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
; AlignGUIsSort(grids)
return

F2::AlignGUIsSort(grids)
F1::
    guisMinimized := !guisMinimized
    for index, grid in grids {
        ahk_id := "ahk_id " . grid.id
        if (guisMinimized) {
            WinMinimize, % ahk_id
        } else {
            WinRestore, % ahk_id
        }
    }
    return

_scriptlog(text) {
    ; _scriptlog(text)
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

ReadButtons() {
    btns := {}
    ; Get a list of all config files in the buttons/ subfolder
    Loop, buttons/*.csv
    {
        ; The A_LoopFileName variable contains the name of the current file
        category := StrReplace(A_LoopFileName, ".csv", "")
        btns[category] := []
        _scriptlog("[" . category . "] Loading from file " . A_LoopFileName)
        
        ; Open the config file for reading
        FileRead, config, buttons/%category%.csv
        
        ; Split the config into lines
        lines := StrSplit(config, "`n", "`r")

        btnCount := 0
        skipped := 0
        
        ; Loop over each line in the config
        for index, line in lines
        {
            line := Trim(line)
            if (line == "" || SubStr(line, 1, 1) == ";" || SubStr(line, 1, 1) == "#" || SubStr(line, 1, 1) == "/") {
                ; _scriptlog("Skipping line: " . line)
                skipped++
                continue
            }
            ; Split the line into components
            components := StrSplit(line, ",")
            
            ; Create a new button
            button := new CommandButton(StrReplace(components[1], "<br>", "`n"), components[2], StrReplace(components[3], "<br>", "`n"))
            
            ; Add the button to the category
            btns[category].push(button)
            btnCount++
        }
        _scriptlog("[" . category . "] Added " . btnCount . " buttons (skipped: " . skipped . ")")
    }
    return btns
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
        ; _scriptlog("Moving grid " . ahk_id . " to X: " . currentX . ", Y: " . currentY . ", Width: " . grid.width . ", Height: " . grid.height)
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
