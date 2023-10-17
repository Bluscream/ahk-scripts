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
SetKeyDelay, 99, 87
return

^+b:: ExitApp
set_next_chunk = True

^b::
    WinGet, winid
    if (Window.fromId(winid).isFullscreen()) {
        MsgBox % "Is fullscreen!"
    }
    Send {Raw}%Clipboard%
    Return