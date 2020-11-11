#SingleInstance Force
#Persistent
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()

; Microsoft Flight Simulator - 1.8.3.0 ahk_class AceApp ahk_exe FlightSimulator.exe

#IfWinActive ahk_class AceApp ahk_exe FlightSimulator.exe
o::Click Down Right
p::Click Up Right
