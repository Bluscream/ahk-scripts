#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SendMode Event

#Include <bluscream>


global dingsda := false

k::
    if (dingsda) {
        dingsda := false
        SetTimer RepeatSpecial, Off
    } else {
        dingsda := true
        SetTimer RepeatSpecial, 500
    }

RepeatSpecial:
    PressKeyAHI("T",1,500)
    Return