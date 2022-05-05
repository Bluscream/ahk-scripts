#Persistent
#NoEnv
#SingleInstance, force
; #NoTrayIcon
SetBatchLines, -1
#Include <bluscream>
#Include <monitors>

; A_Args := [ "/bloat" ]
for n, param in A_Args
{
    StringLower, param, % param
    if (param == "/toggle") {
        goto ToggleScreen
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
    new Url("https://minopia.de/api/ir.php?device=medion%20tv&action=on_off&repeat=10").visit("GET", "", "", true)
    Return

MuteScreen:
    new Url("https://minopia.de/api/ir.php?device=medion%20tv&action=mute&repeat=7").visit("GET", "", "", true)
    Return

ChangeScreenSource:
    new Url("https://minopia.de/api/ir.php?device=medion%20tv&action=source&repeat=7").visit("GET", "", "", true)
    Return

ScreenOK:
    new Url("https://minopia.de/api/ir.php?device=medion%20tv&action=ok&repeat=7").visit("GET", "", "", true)
    Return

Debug:
    PasteToNotepad(text . toJson(GetMonitors(), True) . "`n`nA_ScreenWidth:" . A_ScreenWidth . " A_ScreenHeight:" . A_ScreenHeight " A_ScreenDPI:" . A_ScreenDPI)
    Return

ExitSub:
    If A_ExitReason in Shutdown
        goto ToggleScreen
        ExitApp
        Return
