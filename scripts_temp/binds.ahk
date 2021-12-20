#Include <bluscream>
#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
Process Priority,, Low

games := []

games.push( new Game(new Window("", "Blitz Runtime Class", "", "{F3}")
title := games["scpcb"]["window"].title()
#IfWinActive % title
:*:v::{F3}noclip{Enter} ; k5 SE



class Game
{
	window := ""
	console_key := ""
	
	__New(window, console_key)
	{
		this.window := window
		this.console_key := console_key
	}
}