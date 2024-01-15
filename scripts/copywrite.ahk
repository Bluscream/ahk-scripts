; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-copywrite-ahk
#Persistent
; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
SendMode, Event ; |Play|Input|InputThenPlay
set_next_chunk = True
SetKeyDelay, 39, 27
return

^+b:: ExitApp

^b::
    WinGet, winid
    if (Window.fromId(winid).isFullscreen()) {
        MsgBox % "Is fullscreen!"
        return
    }
    if (StrLen(Clipboard) > 10000) {
        MsgBox % "Clipboard is too long!"
        return
    }
    Send {Raw}%Clipboard%
    Return