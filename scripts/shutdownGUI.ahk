#Persistent
#SingleInstance Force
#NoTrayIcon
WinMinimizeAll
Period=60

Gui, +AlwaysOnTop -Disabled -SysMenu +Owner -Caption -ToolWindow
Gui, Font, s27 cFFFFFF, Ariel
pos_x := (A_ScreenWidth/2)-100
pos_y := (A_ScreenHeight/2)-40
pos_x2 := (A_ScreenWidth-45)
Gui, Add, Button, x%pos_x% y%pos_y% h80 w200 gHibernate, Hibernate 
Gui, Add, Button, xs-250  y%pos_y% h80 w200 gLockPC, Lock PC
Gui, Add, Button, xs-500  y%pos_y% h80 w200 gSwitchUser, Switch user
Gui, Add, Button, xs+500  y%pos_y% h80 w200 gShutdown, Shutdown
Gui, Add, Button, xs+250  y%pos_y% h80 w200 gRestart, Restart
Gui, Add, Button, x%pos_x% ys+130 h80 w200 gCancel, Cancel
Gui, Add, Button, x%pos_x2% y10 h30 w30 gCancel, X
Gui, Font, s55 cFFFFFF, Ariel
Gui, Add, Text, xs-500 ys-200 w1400 vPeriod, Full System Shutdown in %Period%` seconds
Gui, Font, s35 cFFFFFF, Ariel
Gui, Color, 000000                                    
Gui, Show, x0 y0 h%A_ScreenHeight% w%A_ScreenWidth%, ScreenMask
WinSet, Transparent, 200, ScreenMask
SetTimer, ShutDownTimer, 1000
Return

ShutDownTimer:
Period -= 1
GuiControl,,Period,Full System Shutdown in %Period%` seconds
If ( Period=0 ) {
ShutDown, 4+1+8
BlockInput, On
DllCall("ShowCursor", "Int", 0)
Gui, Destroy
   }
Return

Shutdown:
ShutDown, 4+1+8
BlockInput, On
DllCall("ShowCursor", "Int", 0)
Gui, Destroy
Return

LockPC:
WinMinimizeAllUndo
Gui, Destroy
DllCall("LockWorkStation")
ExitApp
Return

SwitchUser:
Run %SystemRoot%\System32\Tsdiscon.exe
Process, priority, Tsdiscon.exe, High
WinMinimizeAllUndo
Gui, Destroy
ExitApp

Restart:
Shutdown, 4+2
BlockInput, On
DllCall("ShowCursor", "Int", 0)
Gui, Destroy
Return

Hibernate:
WinMinimizeAllUndo
Gui, Destroy
DllCall("PowrProf\SetSuspendState", "int", 1, "int", 1, "int", 0)
ExitApp
Return

Cancel:
WinMinimizeAllUndo
Gui, Destroy
sleep 500
exitapp
return

Esc::
WinMinimizeAllUndo
Gui, Destroy
sleep 500
ExitApp