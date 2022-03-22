#Persistent
#NoEnv
#SingleInstance, force
SetBatchLines, -1
#Include <bluscream>
global no_ui := False
SysGet, MonitorCount, MonitorCount
scriptlog(MonitorCount)
lastscreens := MonitorCount
SetTimer, CheckMonitorCount, 15000

CheckMonitorCount:
    SysGet, MonitorCount, MonitorCount
    scriptlog("MonitorCount: " + MonitorCount)
    if (MonitorCount != lastscreens) {
        scriptlog("MonitorCount changed from " . lastscreens . " to " . MonitorCount)
        lastscreens := MonitorCount
        if (MonitorCount == 1) {
        new Url("https://minopia.de/api/ir.php?device=medion%20tv&action=on_off&repeat=10").visit()
        }
    }
    Return