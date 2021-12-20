#SingleInstance, force
#Persistent
#Include <bluscream>

; Space Engineers ahk_class WindowsForms10.Window.8.app.0.2804c64_r10_ad1 ahk_exe SpaceEngineers.exe ahk_pid 24352

Loop {
    WinWaitNotActive ahk_exe SpaceEngineers.exe
    Send {LAlt up}
    SleepS(1)
}
Return

#IfWinActive ahk_exe SpaceEngineers.exe
F::
    Send {LAlt down}
