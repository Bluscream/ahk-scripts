#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
OnExit("ExitFunc")
#Include <bluscream>
; EnforceAdmin()
global noui := false
scriptlog("init start")
global subscribed_windows := []
#Include <automagic>
global am := new AutoMagic()

; am.openUrl("https://www.youtube.com/watch?v=dQw4w9WgXcQ", "com.vanced.android.youtube")
am.createToast("AutoHotKey Connected", 1)
scriptlog(toJson(am))


scriptlog("init end")
return

#Y::
    WinGet, winid ,, A
    win := Window.fromId(winid)
    if (subscribed_windows.contains(win)) {
        scriptlog("No Longer monitoring" . win.str())
        RemoveWindow(win)
    } else {
        subscribed_windows.Push(win)
        SetTimer, Checks, 2000
        scriptlog("Added " . win.str() . " to subscribed_windows")
    }
    return

Checks:
    for i, win in subscribed_windows {
        if (WinExist("ahk_id" . win.id) == 0x00) {
            scriptlog(win.id . ": " . win.title)
            am.createNotification("Window " . win.title . " no longer exists!", win.text)
            RemoveWindow(win)
            Break
        }
    }
    return



RemoveWindow(winid) {
    subscribed_windows := []
    ; if (subscribed_windows.Length() == 1) {
    ;     subscribed_windows := []
    ; } else {
    ;     subscribed_windows.removeByValue(win)
    ; }
    if (subscribed_windows.Length() < 1) {
        SetTimer, Checks, Off
    }
    scriptlog("Removed " . win.str() . " from subscribed_windows")
}

ExitFunc(reason, code) {
    scriptlog("OnExit")
    return
}