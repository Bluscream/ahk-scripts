#Persistent
#NoEnv
#SingleInstance, force
; #NoTrayIcon
SetBatchLines, -1
#Include <bluscream>
#Include <monitors>

; A_Args := [ "/toggle" ]
for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/toggle") {
        SendIRCommand("medion%20tv", "on_off", 10)
    } 
}
global no_ui := True
global runs := 0

I_Icon := "C:\Windows\System32\shell32.dll"
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%, 16
Menu, Tray, NoStandard
Menu, tray, add
Menu, tray, add, % "Toggle", ToggleScreen
Menu, tray, add, % "Mute", MuteScreen
Menu, tray, add, % "Source", ChangeScreenSource
Menu, tray, add, % "OK", ScreenOK
Menu, tray, add, % "Debug", Debug ; Todo: comment

SetTimer, CheckMonitorCount, 30000
OnExit, ExitSub

Return


CheckMonitorCount:
    SysGet, MonitorCount, MonitorCount
    ; scriptlog("MonitorCount: " + MonitorCount)
    if (MonitorCount == 1 or runs == 2) {
        scriptlog("Second screen not found")
        goto ToggleScreen
	  runs := runs + 1
    }
    Return

ToggleScreen:
    SendIRCommand("medion%20tv", "on_off", 10)
    Return

MuteScreen:
    SendIRCommand("medion%20tv", "mute", 1)
    Return

ChangeScreenSource:
    SendIRCommand("medion%20tv", "source", 3)
    Return

ScreenOK:
    SendIRCommand("medion%20tv", "ok", 3)
    Return

Debug:
    PasteToNotepad(text . toJson(GetMonitors(), True) . "`n`nA_ScreenWidth:" . A_ScreenWidth . " A_ScreenHeight:" . A_ScreenHeight " A_ScreenDPI:" . A_ScreenDPI)
    Return

ExitSub:
    If A_ExitReason in Shutdown
        goto ToggleScreen
        ExitApp
        Return
