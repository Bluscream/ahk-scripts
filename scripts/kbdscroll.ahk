; kbdscroll.ahk - Keyboard scroll emulation
; Maps Ctrl+PgUp to mouse wheel up and Ctrl+PgDn to mouse wheel down

#NoEnv
#SingleInstance Force
#Persistent
SendMode InputThenPlay

^PgUp::
!PgUp::
    Click, WheelUp
    return

^PgDn::
!PgDn::
    Click, WheelDown
    return