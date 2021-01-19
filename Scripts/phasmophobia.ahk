#SingleInstance, force
; #Persistent
#Include <bluscream>
global noui := false
scriptlog("Initializing " . A_ScriptName "...")
#Include <Phasmophobia>



loadout_solo := []
loadout_solo.push(new LoadoutItem("Photo Camera",       -1))
loadout_solo.push(new LoadoutItem("Lighter",             1))
loadout_solo.push(new LoadoutItem("Crucifix",           -1))
loadout_solo.push(new LoadoutItem("Salt",                1))
loadout_solo.push(new LoadoutItem("Smudge Sticks",      -1))
loadout_solo.push(new LoadoutItem("Tripod",              1))
loadout_solo.push(new LoadoutItem("Strong Flashlight",   1))
loadout_solo.push(new LoadoutItem("Motion Sensor",       1))
loadout_solo.push(new LoadoutItem("Thermometer",         1))
loadout_solo.push(new LoadoutItem("Sanity Pills",       -1))
loadout_solo.push(new LoadoutItem("Ghost Writing Book", -1))
loadout_solo.push(new LoadoutItem("Head Mounted Camera", 1))
loadout_solo := new Loadout("Solo", loadout_solo)

scriptlog("Initialized " . A_ScriptName "...")
Return


#IfWinActive ahk_class UnityWndClass
F3::
    loadout_solo.apply()
    return
F4::
    AddAllItems()
    return
F5::
    RemoveAllItems()
    return
ESC::
    ExitApp