#include Lib\AHK-ViGEm-Bus.ahk
#include Lib\auto_oculus_touch.ahk

; Show a GUI for debugging
ShowGui := 0

; Start the Oculus sdk.
InitOculus()

; Create the controller
controller := new ViGEmXb360()

; Reset the facing position
Poll()
ResetFacing(0)
ResetFacing(1)

if (ShowGui > 0) {
    Gui, Color, White
    Gui, Font, s16, Arial
    Gui, Add, Text,, Left Thumbstick
    Gui, Add, Slider, vguiLeftX
    Gui, Add, Slider, vguiLeftY
    Gui, Add, Text,, Right Thumbstick:
    Gui, Add, Slider, vguiRightX
    Gui, Add, Slider, vguiRightY
    Gui, Add, Text, vdpad, Buttons:
    Gui, Add, Text, vbuttons, Buttons: 
    Gui, Add, Text,, Triggers
    Gui, Add, Text, vguiTriggers, Triggers: 
    Gui, Add, Button, x10 w50 vguiLTrigger, LT
    Gui, Add, Button, x+5 w50 vguiRTrigger, RT
    Gui, Add, Slider, x10 vguiLTriggerS
    Gui, Add, Slider, vguiLGripS
    Gui, Add, Slider, vguiRTriggerS
    Gui, Add, Slider, vguiRGripS
    Gui, Add, Text, w300 vguiPitch, P:
    Gui, Add, Slider, vguiPitchS
    Gui, Add, Text, w300 vguiYaw, Y:
    Gui, Add, Text, w300 vguiRoll, R:
    Gui, +Resize
}

; Number of degrees of motion being full throttle
motionDegreeRange := 50.0
; Number of degrees of motion before motion is detected
motionDeadZone := 3
; Movement from 0 before thumbstick is seen as dpad
thumbDeadZone := 0.6
gripDeadZone := 0.4
triggerDeadZone := 0.4

oldLGrip := 0

Loop {
    ; Grab the Oculus Touch input state.
    Poll()

    triggertext := "Triggers: "
    buttontext := "Buttons: "

    ; Motion controls are only active when holding the grip.
    leftGrip  := GetTrigger(LeftHand,  Grip)
    rightGrip := GetTrigger(RightHand, Grip)
    if (ShowGui > 0) {
        lg := leftGrip * 100
        rg := rightGrip * 100
        GuiControl,, guiLGripS, %lg%
        GuiControl,, guiRGripS, %rg%
    }
    if (leftGrip >= gripDeadZone) {
        leftGrip := 1
        if (ShowGui > 0)
            triggertext := triggertext . "LG "
    } else {
        leftGrip := 0
        if (ShowGui > 0) 
            triggertext := triggertext . "-- "
    }
    if (rightGrip >= gripDeadZone) {
        rightGrip := 1
        if (ShowGui > 0) 
            triggertext := triggertext . "RG "
    } else {
        rightGrip := 0
        if (ShowGui > 0) 
            triggertext := triggertext . "-- "
    }    

    ; The triggers are on or off.
    ; Triggers are a range from 0.0 to 1.0
    leftTrigger  := GetTrigger(LeftHand,  Trigger) * 100
    rightTrigger := GetTrigger(RightHand, Trigger) * 100
    if (leftTrigger >= triggerDeadZone) {
        if (rightGrip > 0)
            controller.Buttons.LB.SetState(true)
        else
            controller.Axes.LT.SetState(leftTrigger)
        if (ShowGui > 0) 
            triggertext := triggertext . "LT "
    } else {
        controller.Axes.LT.SetState(0)
        controller.Buttons.LB.SetState(false)
        if (ShowGui > 0) 
            triggertext := triggertext . "-- "
    }
    if (rightTrigger >= triggerDeadZone) {
        if (rightGrip > 0)
            controller.Buttons.RB.SetState(true)
        else
            controller.Axes.RT.SetState(rightTrigger)
        if (ShowGui > 0) 
            triggertext := triggertext . "RT "
    } else {
        controller.Axes.RT.SetState(0)
        controller.Buttons.RB.SetState(false)
        if (ShowGui > 0) 
            triggertext := triggertext . "-- "
    }
    if (ShowGui > 0) {    
        GuiControl,, guiLTriggerS, %leftTrigger%
        GuiControl,, guiRTriggerS, %rightTrigger%
        GuiControl,, guiTriggers, %triggertext%
    }
    
    ; Get button states. 
    ; Down is the current state. If you test with this, you get a key every poll it is down. Repeating.
    ; Pressed is set if transitioned to down in the last poll. Non repeating.
    ; Released is set if transitioned to up in the last poll. Non repeating.
    down     := GetButtonsDown()
    pressed  := GetButtonsPressed()
    released := GetButtonsReleased()

    if (down & ovrA) {
        if (rightGrip > 0)
            controller.Buttons.Back.SetState(true)
        else
	    controller.Buttons.A.SetState(true)
        if (ShowGui > 0) 
            buttontext := buttontext . "A "
    } else {
        controller.Buttons.Back.SetState(false)
        controller.Buttons.A.SetState(false)
        if (ShowGui > 0) 
            buttontext := buttontext . "- "
    }
    if down & ovrB {
        controller.Buttons.B.SetState(true)
        if (ShowGui > 0) 
            buttontext := buttontext . "B "
    } else {
	controller.Buttons.B.SetState(false)
        if (ShowGui > 0) 
            buttontext := buttontext . "- "
    }
    if (down & ovrX) {
        if (rightGrip > 0)
            controller.Buttons.Start.SetState(true)
        else
	    controller.Buttons.X.SetState(true)
        if (ShowGui > 0) 
            buttontext := buttontext . "X "
    } else {
	controller.Buttons.Start.SetState(false)
        controller.Buttons.X.SetState(false)
        if (ShowGui > 0) 
            buttontext := buttontext . "- "
    }
    if (down & ovrY) {
        if (rightGrip > 0)
            Send {Esc}
        else
            controller.Buttons.Y.SetState(true)
        if (ShowGui > 0) 
            buttontext := buttontext . "Y "
    } else {
	controller.Buttons.Y.SetState(false)
        if (ShowGui > 0) 
            buttontext := buttontext . "- "
    }

    if (down & ovrLThumb) {
	controller.Buttons.LS.SetState(true)
        if (ShowGui > 0) 
            buttontext := buttontext . "L "
    } else {
	controller.Buttons.LS.SetState(false)
        if (ShowGui > 0) 
            buttontext := buttontext . "- "
    }
    if (down & ovrRThumb) {
	controller.Buttons.RS.SetState(true)
        if (ShowGui > 0) 
            buttontext := buttontext . "R "
    } else {
	controller.Buttons.RS.SetState(false)
        if (ShowGui > 0) 
            buttontext := buttontext . "- "
    }

    ; Left Thumb stick is mapped to the dpad
    ; Thumbsticks are -1.0 to 1.0
    leftX  := GetThumbStick(LeftHand, XAxis)
    leftY  := GetThumbStick(LeftHand, YAxis)
    if (leftX <= -thumbDeadZone) and (leftY <= -thumbDeadZone) {
        controller.Dpad.SetState("DownLeft")
        if (ShowGui > 0) 
            dpadtext := "- D L -"
    } else if (leftX <= -thumbDeadZone) and (leftY >= thumbDeadZone) {
        controller.Dpad.SetState("UpLeft")
        if (ShowGui > 0) 
            dpadtext := "U - L -"
    } else if (leftX >= thumbDeadZone) and (leftY >= thumbDeadZone) {
        controller.Dpad.SetState("UpRight")
        if (ShowGui > 0) 
            dpadtext := "U - - R"
    } else if (leftX >= thumbDeadZone) and (leftY <= -thumbDeadZone) {
        controller.Dpad.SetState("DownRight")
        if (ShowGui > 0) 
            dpadtext := "- D - R"
    } else if (leftX >= thumbDeadZone) {
        controller.Dpad.SetState("Right")
        if (ShowGui > 0) 
            dpadtext := "- - - R"
    } else if (leftX <= -thumbDeadZone) {
        controller.Dpad.SetState("Left")
        if (ShowGui > 0) 
            dpadtext := "- - L -"
    } else if (leftY >= thumbDeadZone) {
        controller.Dpad.SetState("Up")
        if (ShowGui > 0) 
            dpadtext := "U - - -"
    } else if (leftY <= -thumbDeadZone) {
        controller.Dpad.SetState("Down")
        if (ShowGui > 0) 
            dpadtext := "- D - -"
    } else {
        controller.Dpad.SetState("None")
        if (ShowGui > 0) 
            dpadtext := "- - - -"
    }
    if (ShowGui > 0) {
        GuiControl,, dpad, Dpad: %dpadtext%
        lx := leftX*50+50
        ly := leftY*50+50
        GuiControl,, guiLeftX, %lx%
        GuiControl,, guiLeftY, %ly%
    }

    ; Right Thumbstick
    ; Map to the right thumbstick on the controller
    ; The controller is 0 to 100 with 50 being neutral, middle.
    ; Oculus is -1.0 to 1.0.
    rightX := (GetThumbStick(RightHand, XAxis) * 50) + 50
    rightY := (GetThumbStick(RightHand, YAxis) * 50) + 50
    controller.Axes.RX.SetState(rightX)
    controller.Axes.RY.SetState(rightY)
    if (ShowGui > 0) {
        GuiControl,, guiRightX, %rightX%
        GuiControl,, guiRightY, %rightY%
    }
  
    ; Motion controllers only work while holding the grip.
    ; Map left controller pitch/yaw to mouse y/x
    if (leftGrip >= gripDeadZone) {
        if (oldLGrip = 0) {
            ResetFacing(0)
            ResetFacing(1)
            Poll()
	} 
        oldLGrip := 1
        ; This comes out as degrees.
        ; We might limit it to 45 being max
        leftYaw   := GetYaw(LeftHand)
        leftPitch := GetPitch(LeftHand)
        leftRoll  := GetRoll(LeftHand)
;        if (ShowGui > 0) {
;            GuiControl,, guiPitch, P: %leftPitch%
;            GuiControl,, guiYaw, Y: %leftYaw%
;            GuiControl,, guiRoll, R: %leftRoll%
;        }

        if (leftYaw > motionDegreeRange)
            leftYaw := motionDegreeRange
        else if (leftYaw < -motionDegreeRange)
            leftYaw := -motionDegreeRange
;        else if (leftYaw > -motionDeadZone) and (leftYaw < motionDeadZone)
;            leftYaw := 0
        leftYaw := leftYaw + 50
        controller.Axes.LX.SetState(leftYaw)

        if (leftPitch > motionDegreeRange)
            leftPitch := motionDegreeRange
        else if (leftPitch < -motionDegreeRange)
            leftPitch := -motionDegreeRange
;        else if (leftPitch >= -motionDeadZone) and (leftPitch <= motionDeadZone)
;            leftPitch := 0
        lp := leftPitch + 50
        controller.Axes.LY.SetState(lp)
        if (ShowGui > 0) {
            GuiControl,, guiPitch, UpDn: %lp%
            GuiControl,, guiPitchS, %lp%
            GuiControl,, guiYaw, LtRt: %leftYaw%
            GuiControl,, guiRoll, R: %leftRoll%
        }

;        Mouse movement didn't seem to work in game although works on the menu
;        and on the desktop.
;	 dx := 0
;        dy := 0
;        if (leftPitch > motionDeadZone)
;            dy := leftPitch - motionDeadZone
;        if (leftPitch < -motionDeadZone )
;            dy := leftPitch + motionDeadZone
;        if (leftYaw > motionDeadZone)
;            dx := leftYaw - motionDeadZone
;        if (leftYaw < -motionDeadZone)
;            dx := leftYaw + motionDeadZone
;        MouseMove, dx, -dy, 0, R
    } else {
        oldLGrip := 0
        controller.Axes.LX.SetState(50)
        controller.Axes.LY.SetState(50)
    }

    if (ShowGui > 0) {
        GuiControl,, buttons, %buttontext%
        lg := leftGrip * 100
        GuiControl,, guiLGripS, %lg%
        rg := rightGrip * 100
        GuiControl,, guiRGripS, %rg%
        Gui, Show
    }
    Sleep 20
}

GuiClose:
    ExitApp
