; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-copywrite-ahk
#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance
SetBatchLines, -1
Process, Priority,, High
SendMode Input
#Include <bluscream>


return

^b::
	Send {Raw}%Clipboard%
	return