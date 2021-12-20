#Include <scs>
#Include <bluscream>
#Persistent
#SingleInstance Force
; Process Priority,, Below Normal

global ui := false

SetTimer, Loop, 5000
scriptlog("Started logging here...")
Return

Loop:
    data := requestTelemetry()
    scriptlog("Paused: " . data.game.paused)