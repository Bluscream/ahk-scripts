#SingleInstance, force
#Persistent
#Include <bluscream>

; toggle := GetKeyState("Shift")

Loop {
    WinWaitNotActive ahk_class UnityWndClass
    Send {shift up}
    SleepS(1)
}
Return

#IfWinActive ahk_class UnityWndClass
W::
A::
S::
D::
    Send {shift down}
