#SingleInstance Force
; #Persistent
#Include <bluscream>
#include <AutoHotInterception>

scriptlog("Initializing AutoHotInterception for mouse emulation")

global Interception := new AutoHotInterception()
global Monitor := Interception.Instance

global Keyboard := 1
global Mouse := 11
global key_up := GetKeySC("Up")
global key_down := GetKeySC("Down")
global key_left := GetKeySC("Left")
global key_right := GetKeySC("Right")
global min_movement := 2
; GetKeyboardAndMouse()
SubscribeHID(){
    ; SetTimer, StopCursor, 500
    ; Monitor.Subscribe(Func("KeyboardEvent"), Func("MouseEvent"))
    Monitor.SubscribeMouseMoveRelative(Mouse, false, Func("MouseMoveEvent"))
}
UnsubscribeHID(){
    ; SetTimer, StopCursor, Off
    Monitor.UnsubscribeMouseMoveRelative(Mouse)
}
; Monitor.SetDeviceFilterState(Mouse, 1)

StopCursor:
    StopMovement()

GetKeyboardAndMouse(){
    DeviceList := Monitor.GetDeviceList()
    scriptlog("Found " . ObjectCount(DeviceList) . " Input Devices:")
    dev := DeviceList[0]
    keyboard := dev.id
    scriptlog("Keyboard > " . "ID: " . dev.id . ", VID: 0x" . FormatHex(dev.VID) . ", PID: 0x" . FormatHex(dev.PID) . " Handle: " . StrReplace(dev.Handle, "&", "&&"))
    dev := DeviceList[1]
    mouse := dev.id
    scriptlog("Mouse > " . "ID: " . dev.id . ", VID: 0x" . FormatHex(dev.VID) . ", PID: 0x" . FormatHex(dev.PID) . " Handle: " . StrReplace(dev.Handle, "&", "&&"))
    scriptlog("Keys > Up: " . key_up . " Down: " . key_down . " Left: " . key_left . " Right: " . key_right)
}
FormatHex(num){
	return Format("{:04X}", num)
}

ResetCursor(){
    Monitor.SendMouseMoveAbsolute(Mouse, winMiddleX, winMiddleY)
}
; global eventcnt := 0
global stopped := false
global same := 0
global lastX := 0
global lastY := 0
MouseMoveEvent(x, y){
    if (x == lastX && y == lastY) {
        same += 1
        if (same > 10){
            StopMovement()
            return
        }
    }
    ; eventcnt += 1
    ; if (eventcnt < 10) {
        ; return
    ; }
    eventcnt := 0
    lastX := x
    lastY := y
    ; ttext := "X:" . x . " Y:" . y . "`n"
    ; . "LastX:" . lastX . " LastY:" . lastY . " Same:" . same
    x := (x < min_movement && x > -min_movement) ? 0 : x
    y := (y < min_movement && y > -min_movement) ? 0 : y
    if (x == 0 && y == 0 &&){
        if (!stopped) {
            StopMovement()
        }
        return
    }
    stopped := false
    if (x < 0 && y < 0){ ; upleft (-X,-Y);
        Monitor.SendKeyEvent(Keyboard, key_up, 1) ; GetKeySC("Up")
        Monitor.SendKeyEvent(Keyboard, key_left, 1) ; GetKeySC("Left")
        
        Monitor.SendKeyEvent(Keyboard, key_down, 0) ; GetKeySC("Down")
        Monitor.SendKeyEvent(Keyboard, key_right, 0) ; GetKeySC("Right")
        ; text := "upleft"
    } else if (x > 0 && y < 0){ ; upright (+X,-Y)
        Monitor.SendKeyEvent(Keyboard, key_up, 1) ; GetKeySC("Up")
        Monitor.SendKeyEvent(Keyboard, key_right, 1) ; GetKeySC("Right")
        
        Monitor.SendKeyEvent(Keyboard, key_down, 0) ; GetKeySC("Down")
        Monitor.SendKeyEvent(Keyboard, key_left, 0) ; GetKeySC("Left")
        ; text := "upright"
    } else if (x > 0 && y > 0){ ; downright (+X,+Y)
        Monitor.SendKeyEvent(Keyboard, key_down, 1) ; GetKeySC("Down")
        Monitor.SendKeyEvent(Keyboard, key_right, 1) ; GetKeySC("Right")
        
        Monitor.SendKeyEvent(Keyboard, key_up, 0) ; GetKeySC("Up")
        Monitor.SendKeyEvent(Keyboard, key_left, 0) ; GetKeySC("Left")
        ; text := "downright"
    } else if (x < 0 && y > 0){ ; downleft (-X,+Y)
        Monitor.SendKeyEvent(Keyboard, key_down, 1) ; GetKeySC("Down")
        Monitor.SendKeyEvent(Keyboard, key_left, 1) ; GetKeySC("Left")
        
        Monitor.SendKeyEvent(Keyboard, key_up, 0) ; GetKeySC("Up")
        Monitor.SendKeyEvent(Keyboard, key_right, 0) ; GetKeySC("Right")
        ; text := "downleft"
    } else if (y < 0){ ; up (-Y)
        Monitor.SendKeyEvent(Keyboard, key_up, 1) ; GetKeySC("Up")
        
        Monitor.SendKeyEvent(Keyboard, key_down, 0) ; GetKeySC("Down")
        Monitor.SendKeyEvent(Keyboard, key_left, 0) ; GetKeySC("Left")
        Monitor.SendKeyEvent(Keyboard, key_right, 0) ; GetKeySC("Right")
        ; text := "up"
    } else if (y > 0){ ; down (Y)
        Monitor.SendKeyEvent(Keyboard, key_down, 1) ; GetKeySC("Down")
        
        Monitor.SendKeyEvent(Keyboard, key_up, 0) ; GetKeySC("Up")
        Monitor.SendKeyEvent(Keyboard, key_left, 0) ; GetKeySC("Left")
        Monitor.SendKeyEvent(Keyboard, key_right, 0) ; GetKeySC("Right")
        ; text := "down"
    } else if (x < 0){ ; left (-X)
        Monitor.SendKeyEvent(Keyboard, key_left, 1) ; GetKeySC("Left")
        
        Monitor.SendKeyEvent(Keyboard, key_up, 0) ; GetKeySC("Up")
        Monitor.SendKeyEvent(Keyboard, key_down, 0) ; GetKeySC("Down")
        Monitor.SendKeyEvent(Keyboard, key_right, 0) ; GetKeySC("Right")
        ; text := "left"
    } else if (x > 0){ ; right (+X)
        Monitor.SendKeyEvent(Keyboard, key_right, 1) ; GetKeySC("Right")
        
        Monitor.SendKeyEvent(Keyboard, key_up, 0) ; GetKeySC("Up")
        Monitor.SendKeyEvent(Keyboard, key_down, 0) ; GetKeySC("Down")
        Monitor.SendKeyEvent(Keyboard, key_left, 0) ; GetKeySC("Left")
        ; text := "Right"
    }
    ; ShowToolTip(ttext)
}
StopMovement(){
        Interception.SendKeyEvent(Keyboard, key_up, 0) ; GetKeySC("Up")
        Interception.SendKeyEvent(Keyboard, key_down, 0) ; GetKeySC("Down")
        Interception.SendKeyEvent(Keyboard, key_left, 0) ; GetKeySC("Left")
        Interception.SendKeyEvent(Keyboard, key_right, 0) ; GetKeySC("Right")
}