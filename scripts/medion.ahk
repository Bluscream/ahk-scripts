#Persistent
#NoEnv
#SingleInstance, force
; #NoTrayIcon
SetBatchLines, -1
#Include <bluscream>
#Include <monitors>
global no_ui := False

I_Icon := "C:\Windows\System32\shell32.dll"
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%, 16
; Menu, Tray, NoStandard
Menu, tray, add
Menu, tray, add, % "Toggle", ToggleScreen
Menu, tray, add, % "Mute", MuteScreen
Menu, tray, add, % "Source", ChangeScreenSource
Menu, tray, add, % "Debug", Debug ; Todo: comment

SetTimer, CheckMonitorCount, 30000

Return


CheckMonitorCount:
    SysGet, MonitorCount, MonitorCount
    ; scriptlog("MonitorCount: " + MonitorCount)
    if (MonitorCount == 1) {
        scriptlog("Second screen not found")
        goto ToggleScreen
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

Debug:
    PasteToNotepad(text . toJson(GetMonitors(), True) . "`n`nA_ScreenWidth:" . A_ScreenWidth . " A_ScreenHeight:" . A_ScreenHeight " A_ScreenDPI:" . A_ScreenDPI)
    Return