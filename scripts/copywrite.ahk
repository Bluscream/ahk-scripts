; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-copywrite-ahk
#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
SendMode, Event ; |Play|Input|InputThenPlay
SetKeyDelay, 24, 26
return

^+b:: ExitApp

^b::
    WinGet, winid
    if (Window.fromId(winid).isFullscreen()) {
        MsgBox % "Is fullscreen!"
    }
    Send {Raw}%Clipboard%
    Return