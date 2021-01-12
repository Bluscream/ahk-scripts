#SingleInstance, force
#Persistent
#Include <bluscream>
#Include <Phasmophobia>

global noui := true
scriptlog("Initializing " . A_ScriptName "...")

scriptlog("Initialized " . A_ScriptName "...")
Return

#IfWinActive ahk_class UnityWndClass
F3::
    loadout_solo := new OrderedAssociativeArray()
    loadout_solo["Photo Camera"]        := -1
    loadout_solo["Lighter"]             := 1
    loadout_solo["Crucifix"]            := -1
    loadout_solo["Salt"]                := 1
    loadout_solo["Smudge Sticks"]       := -1
    loadout_solo["Tripod"]              := 1
    loadout_solo["Strong Flashlight"]   := 1
    loadout_solo["Motion Sensor"]       := 1
    loadout_solo["Thermometer"]         := 1
    loadout_solo["Sanity Pills"]        := -1
    loadout_solo["Ghost Writing Book"]  := -1
    loadout_solo["Head Mounted Camera"] := 1
    ApplyLoadout(new Loadout("Solo", loadout_solo))
    return
    
F5::
    RemoveAllItems()
    return

ESC::
    ExitApp