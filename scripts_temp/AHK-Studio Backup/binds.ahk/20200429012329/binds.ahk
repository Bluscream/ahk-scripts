#Include <bluscream>
#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
Process Priority,, Low

games := []

games.push( {
	"scpcb": {
		"window": new Window("", "Blitz Runtime Class", "") },
		"open_console_key": "{F3}"
}
)
title := games["scpcb"]["window"].title()
#IfWinActive % title
:*:v::{F3}noclip{Enter} ; k5 SE