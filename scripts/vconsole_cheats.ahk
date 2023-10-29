; SetKeyDelay, -1 ; Sets the delay to the smallest possible value
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Include <bluscream>
global no_ui := false
scriptlog("Starting " . A_ScriptName . "...")

buttons := {}
buttons["Cheats"] := []
buttons["Cheats"].push(new CommandButton("Startup", "sv_cheats 1;"))
buttons["Cheats"].push(new CommandButton("Give all", "impulse 101;impulse 102;hlvr_shotgun_give;hlvr_give_flashlight"))
buttons["Cheats"].push(new CommandButton("God Mode", "god 1;"))
buttons["Cheats"].push(new CommandButton("God Mode Off", "god 0;"))
buttons["Cheats"].push(new CommandButton("No Target", "notarget 1;"))
buttons["Cheats"].push(new CommandButton("No Target Off", "notarget 0;"))
buttons["Cheats"].push(new CommandButton("Infinite Ammo", "sv_infinite_ammo 1;"))
buttons["Cheats"].push(new CommandButton("Infinite Ammo Off", "sv_infinite_ammo 0;"))
buttons["Cheats"].push(new CommandButton("Spawn Weapons", "give item_hlvr_weapon_energygun;give item_hlvr_weapon_rapidfire;give item_hlvr_weapon_shotgun;give item_hlvr_multitool;give item_hlvr"))
buttons["Cheats"].push(new CommandButton("Spawn Ammo", "give item_hlvr_crafting_currency_small;give item_hlvr_crafting_currency_large;give item_hlvr_health_station_vial;give item_hlvr_prop_battery"))
buttons["Cheats"].push(new CommandButton("Spawn Items", "give item_hlvr_clip_energygun;give item_hlvr_clip_rapidfire;give item_hlvr_clip_shotgun_multiple;give item_hlvr_grenade_frag;give item_hlvr_grenade_xen"))

buttons["Maps"] := []
buttons["Maps"].push(new CommandButton("Alyx Logo and Main Menu", "map startup"))
buttons["Maps"].push(new CommandButton("Game Start", "map a1_intro_world"))
buttons["Maps"].push(new CommandButton("Intro World 2", "map a1_intro_world_2"))
buttons["Maps"].push(new CommandButton("Drainage", "map a2_drainage"))
buttons["Maps"].push(new CommandButton("Headcrabs Tunnel", "map a2_headcrabs_tunnel"))
buttons["Maps"].push(new CommandButton("Hideout", "map a2_hideout"))
buttons["Maps"].push(new CommandButton("Pistol", "map a2_pistol"))
buttons["Maps"].push(new CommandButton("Quarantine Entrance", "map a2_quarantine_entrance"))
buttons["Maps"].push(new CommandButton("Train Yard", "map a2_train_yard"))
buttons["Maps"].push(new CommandButton("Processing Plant", "map a3_c17_processing_plant"))
buttons["Maps"].push(new CommandButton("Distillery", "map a3_distillery"))
buttons["Maps"].push(new CommandButton("Hotel Interior Rooftop", "map a3_hotel_interior_rooftop"))
buttons["Maps"].push(new CommandButton("Hotel Lobby Basement", "map a3_hotel_lobby_basement"))
buttons["Maps"].push(new CommandButton("Hotel Street", "map a3_hotel_street"))
buttons["Maps"].push(new CommandButton("Hotel Underground Pit", "map a3_hotel_underground_pit"))
buttons["Maps"].push(new CommandButton("Station Street", "map a3_station_street"))
buttons["Maps"].push(new CommandButton("Parking Garage", "map a4_c17_parking_garage"))
buttons["Maps"].push(new CommandButton("Tanker Yard", "map a4_c17_tanker_yard"))
buttons["Maps"].push(new CommandButton("Water Tower", "map a4_c17_water_tower"))
buttons["Maps"].push(new CommandButton("Zoo", "map a4_c17_zoo"))
buttons["Maps"].push(new CommandButton("When You First Enter the Vault", "map a5_vault"))
buttons["Maps"].push(new CommandButton("Right Before", "map a5_ending"))
buttons["Maps"].push(new CommandButton("Endless Loading", "map error"))
buttons["Maps"].push(new CommandButton("TV Backdrop", "map a1_intro_world\\citadel_vista_screen"))
buttons["Maps"].push(new CommandButton("TV Backdrop 2", "map a1_intro_world\\citadel_vista"))
buttons["Maps"].push(new CommandButton("Floating Zen Island", "map a5_ending\\void_space"))

; for n, param in A_Args {
;     StringLower, param, % param
;     for cat, buttons in buttons {
;         if (param == cat) {
;             scriptlog("Found argument: " . param . " Creating category for it")
;             InitUI(param, buttons)
;             return
;         }
;     }
; }
for cat, buttons in buttons {
    new ButtonGrid(cat, buttons)
}

return

class CommandButton {
    __New(text, command) { ; callback
        this.text := text
        this.command := command
        ; this.callback := callback
    }
}

class ButtonGrid {
    __New(category, buttons) {
        scriptlog("InitUI(" . category . ")")
        Gui, New
        for i, button in buttons {
            scriptlog("button(" . button.text . ", " . button.command . ")")
            this.addButton(button)
        }
        Gui, +AlwaysOnTop  ; Set the GUI to always stay on top
        Gui, Show,, Half-Life: Alyx %category%
    }

    addButton(button) {
        scriptlog("addButton(" . button.text . ", " . button.command . ")")
        row := 0
        col := 0
        Gui, Add, Button, x%col% y%row% w200 h50 gButtonHandler, % button.text
        col += 200
        if (col >= 600) {
            col := 0
            row += 50
        }
        this.row := row
        this.col := col
    }
}

ButtonHandler() {
    ControlGetText, buttonText, %A_GuiControl%
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
}



GuiClose() {
    ExitApp
}
