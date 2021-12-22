#Persistent
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, Low
; while (True) {
;     WinWaitClose, ahk_exe javaw.exe
;     Run % "C:\tools\MultiMC\MultiMC.exe -a ""Bluscream"" -l ""Fabric 1.18.1"""
;     WinWait, ahk_exe javaw.exe
; }
; Minecraft* 1.18.1 ahk_class GLFW30

SetTimer, CheckMC, 2500

Run % "C:\Program Files\obs-studio\bin\64bit\obs64.exe --scene Minecraft --startstreaming" ; --minimize-to-tray

return

CheckMC:
    if (!ProcessExist("javaw.exe")) {
        Run % "C:\tools\MultiMC\MultiMC.exe -a ""Bluscream"" -l ""Fabric 1.18.1"""
        WinWait, ahk_exe MultiMC.exe
        Sleep, 10 * 1000
        WinActivate, ahk_exe javaw.exe
    }
    Return


ProcessExist(Name){
	Process,Exist,%Name%
	return Errorlevel
}