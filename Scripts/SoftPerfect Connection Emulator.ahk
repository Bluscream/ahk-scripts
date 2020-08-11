 #SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
#Include <bluscream>
EnforceAdmin()

global window := new Window("SoftPerfect Connection Emulator", "TSimulatorForm", "consim.exe")
global winstr := window.str()
global button_startstop := "TButton1"
global txt_ping := "TlabeledEdit1"
global chk_ping := "TCheckBox1"
global grp_ping_random := "TGroupButton1"
global grp_ping_fixed := "TGroupButton2"
 
return

F1::
    setPing()
    return
    
F2::
    setPing(123-8)
    return
    
F3::
    setPing(420-8)
    return
    
F4::
    setPing(888-8)
    return
    
F5::
    setPing(999-8)
    return
    
F6::
    setPing(1500-8)
    return
    
F10::
    setPing(-1)
    return
    
isRunning() {
    ControlGetText, btnText, % button_startstop, % winstr
    if (btnText == "&Start") {
        return false
    } else if (btnText == "&Stop") {
        return true
    }
}

switch(on := true) {
    if (isRunning() && on) {
        ControlClick, % button_startstop, % winstr,,, 2
    } else {
        ControlClick, % button_startstop, % winstr
    }
    sleep, 250
    if (isRunning()) {
        ControlGetText, pingText, % txt_ping, % winstr
        SplashScreen("Throttling with " . pingText . "ms!")
    } else  {
        SplashScreen("No longer throttling")
    }
}

setPing(ping_ms := 0) {
    if (ping_ms == 0) {
        ControlSetText, % txt_ping, % ping_ms, % winstr
        Control, Uncheck,, % chk_ping, % winstr
    } else if (ping_ms == -1) {
        Control, Check,, % grp_ping_random, % winstr
    } else {
        Control, Check,, % chk_ping, % winstr
        Sleep, 5
        Control, Uncheck,, % grp_ping_random, % winstr
        Sleep, 5
        Control, Check,, % grp_ping_fixed, % winstr
        Sleep, 5
        ControlSetText, % txt_ping, % ping_ms, % winstr
    }
    Sleep, 10
    switch()
}