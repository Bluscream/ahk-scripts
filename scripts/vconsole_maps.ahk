; SetKeyDelay, -1 ; Sets the delay to the smallest possible value

Gui, New
createButton("startup")
createButton("a1_intro_world")
createButton("a1_intro_world_2")

createButton("a2_drainage")
createButton("a2_headcrabs_tunnel")
createButton("a2_hideout")

createButton("a2_pistol")
createButton("a2_quarantine_entrance")
createButton("a2_train_yard")

createButton("a3_c17_processing_plant")
createButton("a3_distillery")
createButton("a3_hotel_interior_rooftop")

createButton("a3_hotel_lobby_basement")
createButton("a3_hotel_street")
createButton("a3_hotel_underground_pit")

createButton("a3_station_street")
createButton("a4_c17_parking_garage")
createButton("a4_c17_tanker_yard")

createButton("a4_c17_water_tower")
createButton("a4_c17_zoo")
createButton("a5_ending")

createButton("a5_vault")

Gui, +AlwaysOnTop  ; Set the GUI to always stay on top
Gui, Show,, Half-Life: Alyx Maps

ButtonHandler:
    ControlGetText, buttonText, %A_GuiControl%
    if (buttonText == "")
        return
    buttonText := "map " . buttonText
    Gui, Submit, NoHide
    IfWinNotExist, ahk_class QWidget
    {
        Run, "G:\SteamLibrary\steamapps\common\Half-Life Alyx\game\bin\win64\vconsole2.exe"
        Sleep, 1000 ; Wait for the window to open
    }
    Tooltip, %buttonText%
    
    ControlFocus, QWidget26, ahk_class QWidget

    ; clipboard := buttonText
    ; Send, ^v{Enter}

    ; ControlSetText, QWidget26, Your Text, ahk_class QWidget
    ; ControlSend, QWidget26, {Enter}, ahk_class QWidget

    ; ControlSend, QWidget26, , ahk_class QWidget

    SendInput, %buttonText%{Enter}

    ; SendPlay, %buttonText%{Enter}
return

createButton(text)
{
    static row := 0
    static col := 0
    Gui, Add, Button, x%col% y%row% w200 h50 gButtonHandler, % text
    col += 200
    if (col >= 600) {
        col := 0
        row += 50
    }
}

GuiClose:
    ExitApp
