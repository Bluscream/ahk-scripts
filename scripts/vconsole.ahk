; SetKeyDelay, -1 ; Sets the delay to the smallest possible value}
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Include <bluscream>
; global no_ui := false
; scriptlog("Starting " . A_ScriptName . "...")

global buttons := {}
;region cheats
buttons["Half-Life: Alyx - Cheats"] := []
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Startup", "sv_cheats 1;vr_enable_volume_fog 0;hl_dissolve_all_dropped_weapons 0;hlvr_movetype_default 3;vr_movetype_set 3;hlvr_adjust_turn_option 2;vr_quick_turn_continuous_enable 1;vr_head_bubble_fade_enable 0"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Give all", "impulse 101")) ; hlvr_shotgun_give
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Give Flashlight", "hlvr_give_flashlight"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Upgrade all", "impulse 102"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("God Mode", "god 1"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("NO God Mode", "god 0"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("No Target", "notarget 1"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Target", "notarget 0"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Infinite Ammo", "sv_infinite_ammo 1"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("NO Infinite Ammo", "sv_infinite_ammo 0"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Weapons", "give item_hlvr_weapon_energygun;give item_hlvr_weapon_rapidfire;give item_hlvr_weapon_shotgun;give item_hlvr_multitool"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Ammo", "give item_hlvr_crafting_currency_small;give item_hlvr_crafting_currency_large;give item_hlvr_health_station_vial;give item_hlvr_prop_battery"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Items", "give item_hlvr_clip_energygun;give item_hlvr_clip_rapidfire;give item_hlvr_clip_shotgun_multiple;give item_hlvr_grenade_frag;give item_hlvr_grenade_xen;give item_healthvial"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Remove Target", "ent_fire !picker kill"))
;region props
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Bucket", "ent_create prop_physics {model models/props_junk/metalbucket01a.vmdl CanDepositInItemHolder 1}"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Beer Bottle", "ent_create prop_physics {model models/props_junk/beer_bottle_1.vmdl CanDepositInItemHolder 1}"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Gas mask", "ent_create prop_physics {model models/props/hazmat/respirator_01a.vmdl CanDepositInItemHolder 1}"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Hard hat", "ent_create prop_physics {model models/props/construction/hat_construction.vmdl CanDepositInItemHolder 1}"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Gnome", "ent_create prop_physics {model models\props\choreo_office\gnome.vmdl CanDepositInItemHolder 1}"))
buttons["Half-Life: Alyx - Cheats"].push(new CommandButton("Spawn Explosive canister", "ent_create prop_physics {model models/props/explosive_jerrican_1.vmdl CanDepositInItemHolder 1}"))

;endregion props
;endregion cheats
;region maps
buttons["Half-Life: Alyx - Maps"] := []
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Logo and Main Menu", "map startup"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Game Start", "map a1_intro_world"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Intro World 2", "map a1_intro_world_2"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Drainage", "map a2_drainage"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Headcrabs Tunnel", "map a2_headcrabs_tunnel"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Hideout", "map a2_hideout"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Pistol", "map a2_pistol"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Quarantine Entrance", "map a2_quarantine_entrance"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Train Yard", "map a2_train_yard"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Processing Plant", "map a3_c17_processing_plant"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Distillery", "map a3_distillery"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Hotel Interior Rooftop", "map a3_hotel_interior_rooftop"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Hotel Lobby Basement", "map a3_hotel_lobby_basement"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Hotel Street", "map a3_hotel_street"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Hotel Underground Pit", "map a3_hotel_underground_pit"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Station Street", "map a3_station_street"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Parking Garage", "map a4_c17_parking_garage"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Tanker Yard", "map a4_c17_tanker_yard"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Water Tower", "map a4_c17_water_tower"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Zoo", "map a4_c17_zoo"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Vault", "map a5_vault"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Jeff", "map a5_ending"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Endless Loading", "map error"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("TV Backdrop", "map a1_intro_world\\citadel_vista_screen"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("TV Backdrop 2", "map a1_intro_world\\citadel_vista"))
buttons["Half-Life: Alyx - Maps"].push(new CommandButton("Floating Zen Island", "map a5_ending\\void_space"))
;endregion
;region npcs
buttons["Half-Life: Alyx - NPCs"] := []
;region zombies
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Barnacle", "npc_create npc_barnacle"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Zombie", "npc_create npc_zombie"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Zombine (HL2)", "npc_create npc_zombine"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Blind Zombie", "npc_create npc_zombie_blind"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Normal headcrab", "npc_create npc_headcrab"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Fast headcrab", "npc_create npc_headcrab_fast"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Armored headcrab", "npc_create npc_headcrab_armored"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Toxic headcrab", "npc_create npc_headcrab_black"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Lightning dog", "npc_create npc_headcrab_runner"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Antlion", "npc_create npc_antlion"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Blue Antlion", "ent_create npc_antlion {spawnflags 262144}"))
;endregion zombies
;region combine
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Metropolice (HL2)", "ent_create npc_metropolice"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("White Combine with gas canister", "npc_create npc_combine_s"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Combine Suppressor", "ent_create npc_combine_s {model models/characters/combine_suppressor/combine_suppressor.vmdl}"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Combine Captain", "ent_create npc_combine_s {model models/characters/combine_soldier_captain/combine_captain.vmdl}"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Combine Heavy", "ent_create npc_combine_s {model models/characters/combine_soldier_heavy/combine_soldier_heavy.vmdl}"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Manhack", "npc_create npc_manhack"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Scanner camera", "npc_create npc_cscanner"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Clawscanner (HL2)", "npc_create npc_clawscanner"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Turret", "npc_create npc_turret_floor"))
;endregion combine
;region animals
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Crow", "npc_create npc_crow"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Seagull", "npc_create npc_seagull"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Pigeon", "npc_create npc_pigeon"))
;endregion animals
;region resistance
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Barney (HL2)", "ent_create npc_barney"))
;endregion resistance
;region citizens
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Female Citizen", "npc_create npc_vr_citizen_female"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Male Citizen", "npc_create npc_vr_citizen_male"))
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Male Citizen (HL2)", "ent_create npc_citizen"))
;endregion citizens
buttons["Half-Life: Alyx - NPCs"].push(new CommandButton("Bugbait Grenade", "npc_create npc_grenade_bugbait"))
;endregion
;region relationships
buttons["Half-Life: Alyx - Relationships"] := []
buttons["Half-Life: Alyx - Relationships"].push(new CommandButton("All hate player", "ent_fire npc_zombie setrelationship ""!player D_HT 99""; ent_fire npc_barnacle setrelationship ""!player D_HT 99""; ent_fire npc_antlion setrelationship ""!player D_HT 99""; ent_fire npc_zombie_blind setrelationship ""!player D_HT 99""; ent_fire npc_headcrab setrelationship ""!player D_HT 99""; ent_fire npc_headcrab_armored setrelationship ""!player D_HT 99""; ent_fire npc_headcrab_black setrelationship ""!player D_HT 99""; ent_fire npc_headcrab_fast setrelationship ""!player D_HT 99""; ent_fire npc_headcrab_runner setrelationship ""!player D_HT 99""; ent_fire npc_combine_s setrelationship ""!player D_HT 99""; ent_fire npc_manhack setrelationship ""!player D_HT 99""; ent_fire npc_cscanner setrelationship ""!player D_HT 99""; ent_fire npc_turret_floor setrelationship ""!player D_HT 99""; ent_fire npc_crow setrelationship ""!player D_HT 99""; ent_fire npc_seagull setrelationship ""!player D_HT 99""; ent_fire npc_pigeon setrelationship ""!player D_HT 99""; ent_fire npc_vr_citizen_female setrelationship ""!player D_HT 99""; ent_fire npc_vr_citizen_male setrelationship ""!player D_HT 99"""))
buttons["Half-Life: Alyx - Relationships"].push(new CommandButton("All fear player", "ent_fire npc_zombie setrelationship ""!player D_FR 99""; ent_fire npc_barnacle setrelationship ""!player D_FR 99""; ent_fire npc_antlion setrelationship ""!player D_FR 99""; ent_fire npc_zombie_blind setrelationship ""!player D_FR 99""; ent_fire npc_headcrab setrelationship ""!player D_FR 99""; ent_fire npc_headcrab_armored setrelationship ""!player D_FR 99""; ent_fire npc_headcrab_black setrelationship ""!player D_FR 99""; ent_fire npc_headcrab_fast setrelationship ""!player D_FR 99""; ent_fire npc_headcrab_runner setrelationship ""!player D_FR 99""; ent_fire npc_combine_s setrelationship ""!player D_FR 99""; ent_fire npc_manhack setrelationship ""!player D_FR 99""; ent_fire npc_cscanner setrelationship ""!player D_FR 99""; ent_fire npc_turret_floor setrelationship ""!player D_FR 99""; ent_fire npc_crow setrelationship ""!player D_FR 99""; ent_fire npc_seagull setrelationship ""!player D_FR 99""; ent_fire npc_pigeon setrelationship ""!player D_FR 99""; ent_fire npc_vr_citizen_female setrelationship ""!player D_FR 99""; ent_fire npc_vr_citizen_male setrelationship ""!player D_FR 99"""))
buttons["Half-Life: Alyx - Relationships"].push(new CommandButton("All ignore player", "ent_fire npc_zombie setrelationship ""!player D_NU 99""; ent_fire npc_barnacle setrelationship ""!player D_NU 99""; ent_fire npc_antlion setrelationship ""!player D_NU 99""; ent_fire npc_zombie_blind setrelationship ""!player D_NU 99""; ent_fire npc_headcrab setrelationship ""!player D_NU 99""; ent_fire npc_headcrab_armored setrelationship ""!player D_NU 99""; ent_fire npc_headcrab_black setrelationship ""!player D_NU 99""; ent_fire npc_headcrab_fast setrelationship ""!player D_NU 99""; ent_fire npc_headcrab_runner setrelationship ""!player D_NU 99""; ent_fire npc_combine_s setrelationship ""!player D_NU 99""; ent_fire npc_manhack setrelationship ""!player D_NU 99""; ent_fire npc_cscanner setrelationship ""!player D_NU 99""; ent_fire npc_turret_floor setrelationship ""!player D_NU 99""; ent_fire npc_crow setrelationship ""!player D_NU 99""; ent_fire npc_seagull setrelationship ""!player D_NU 99""; ent_fire npc_pigeon setrelationship ""!player D_NU 99""; ent_fire npc_vr_citizen_female setrelationship ""!player D_NU 99""; ent_fire npc_vr_citizen_male setrelationship ""!player D_NU 99"""))
buttons["Half-Life: Alyx - Relationships"].push(new CommandButton("All like player", "ent_fire npc_zombie setrelationship ""!player D_LI 99""; ent_fire npc_barnacle setrelationship ""!player D_LI 99""; ent_fire npc_antlion setrelationship ""!player D_LI 99""; ent_fire npc_zombie_blind setrelationship ""!player D_LI 99""; ent_fire npc_headcrab setrelationship ""!player D_LI 99""; ent_fire npc_headcrab_armored setrelationship ""!player D_LI 99""; ent_fire npc_headcrab_black setrelationship ""!player D_LI 99""; ent_fire npc_headcrab_fast setrelationship ""!player D_LI 99""; ent_fire npc_headcrab_runner setrelationship ""!player D_LI 99""; ent_fire npc_combine_s setrelationship ""!player D_LI 99""; ent_fire npc_manhack setrelationship ""!player D_LI 99""; ent_fire npc_cscanner setrelationship ""!player D_LI 99""; ent_fire npc_turret_floor setrelationship ""!player D_LI 99""; ent_fire npc_crow setrelationship ""!player D_LI 99""; ent_fire npc_seagull setrelationship ""!player D_LI 99""; ent_fire npc_pigeon setrelationship ""!player D_LI 99""; ent_fire npc_vr_citizen_female setrelationship ""!player D_LI 99""; ent_fire npc_vr_citizen_male setrelationship ""!player D_LI 99"""))
; endregion relationships
;region equipment
; buttons["Half-Life: Alyx - NPC Equipment"] := []
; buttons["Half-Life: Alyx - NPC Equipment"].push(new CommandButton("Stunstick", "{additionalequipment weapon_stunstick}"))
; buttons["Half-Life: Alyx - NPC Equipment"].push(new CommandButton("SMG1", "{additionalequipment weapon_smg1}"))
; buttons["Half-Life: Alyx - NPC Equipment"].push(new CommandButton("AR2", "{additionalequipment weapon_ar2}"))
;endregion equipment

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

return


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

    __New(name, buttons) {
        this.name := name
        this.buttons := buttons
        Gui, New
        Gui, Font, s13  ; Change the font size to 18
        for i, button in buttons {
            this.addButton(button)
        }
        Gui, +AlwaysOnTop  ; Set the GUI to always stay on top
        Gui, Show,, %name%
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
