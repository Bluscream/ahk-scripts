; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-copywrite-ahk
#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
SendMode, InputThenPlay ; |Play|Input|Event
SetKeyDelay, 50, 50
return

^b::
	Send {Raw}%Clipboard%
	return