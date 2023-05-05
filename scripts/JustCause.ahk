#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
#Include <bluscream>
global noui := false

F2::SendConsoleCommand("spawn v251_helicopter_rocketdrone_rebel")
F3::SendConsoleCommand("spawn v250_helicopter_mediumattackdrone_rebel")
F4::SendConsoleCommand("spawn v252_helicopter_suicidedrone_rebel")
F5::SendConsoleCommand("spawn v253_helicopter_decoydrone_rebel")
F6::SendConsoleCommand("spawn v254_helicopter_guarddrone_rebel")
F7::SendConsoleCommand("spawn v270_helicopter_agencydrone_rebel")

Numpad1::SendConsoleCommand("spawn v802_treaded_aatank_rebel")
Numpad2::SendConsoleCommand("spawn v012_car_apc_rebel_01")
Numpad3::SendConsoleCommand("spawn v013_car_armoredtransport_rebel_01")
Numpad6::SendConsoleCommand("spawn v027_car_hurricanetruck_civilian")

Numpad4::SendConsoleCommand("spawn v202_helicopter_heavytroop_rebel_01")
Numpad5::SendConsoleCommand("spawn v204_helicopter_heavyassault_rebel_01")

Numpad7::SendConsoleCommand("spawn gabriela")
Numpad8::SendConsoleCommand("spawn sniper_enemy_001")
Numpad9::SendConsoleCommand("spawn rpg_enemy_001")


; NumpadDot::SendConsoleCommand("spawn v259_helicopter_rescue_rebel")
; NumpadAdd::SendConsoleCommand("spawn v261_helicopter_lighttransport_rebel")
; NumpadSub::SendConsoleCommand("spawn v262_helicopter_lightsniper_rebel")
; NumpadMult::SendConsoleCommand("spawn v263_helicopter_lightheavy_rebel")
; NumpadDiv::SendConsoleCommand("spawn v264_helicopter_lighttransportvip_rebel")
; NumpadEnter::SendConsoleCommand("spawn v271_helicopter_agencyheavy_rebel")


SendConsoleCommand(message) {
  SendInput {F1}
  Sleep 10
  SendInput % message
  Sleep 10
  SendInput {Enter}
  Return
}
