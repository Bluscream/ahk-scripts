#Persistent
#InstallKeybdHook
#UseHook 1
#SingleInstance force
#include <bluscream>
EnforceAdmin()

; Initialize variables to keep track of the current sound and its state
currentSound := ""
isPlaying := false

; Define hotkeys for the numpad keys 1-9
Numpad1::ToggleSound("innen/martinshorn-pressluft.wav")
Numpad2::ToggleSound("innen/martinshorn-pressluft2.wav")
Numpad3::ToggleSound("innen/rtw.wav")
Numpad4::ToggleSound("innen/polizei-land-alt.wav")
Numpad5::ToggleSound("innen/polizei.wav")
; Add more numpad keys as needed

; Add a hotkey for Numpad0 to stop all sounds
Numpad0::StopAllSounds()

ToggleSound(soundFile) {
    global currentSound, isPlaying
    soundPath := A_ScriptDir . "\sirens\" . soundFile
    scriptlog(soundPath)
    ; If the same sound is already playing, stop it
    if (currentSound = soundFile && isPlaying) {
        SoundPlay, %soundPath%, 1
        isPlaying := false
        currentSound := ""
    } else {
        ; Stop the current sound if any
        if (currentSound != "" && isPlaying) {
            SoundPlay, %currentSound%, 1
            isPlaying := false
        }
        ; Play the new sound in a loop
        isPlaying := true
        currentSound := soundFile
        while (isPlaying) {
            SoundPlay, %soundPath%, 1
            Sleep, 5000 ; Adjust the sleep duration to match the sound's length
        }
    }
}

StopAllSounds() {
    global currentSound, isPlaying
    ; Stop the current sound if any
    if (currentSound != "" && isPlaying) {
        SoundPlay, %A_ScriptDir%\nonexistant.mp3, 1
        isPlaying := false
        currentSound := ""
    }
}
