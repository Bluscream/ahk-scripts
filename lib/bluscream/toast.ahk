global toastQueue := []
global isShowingToast := false
global CloseToastFn := ""
; Function to add a toast to the queue
ShowToast(message, title := "AutoHotkey", icon_path := "toast.bmp", position := "topleft", time_seconds := 10, bg_color := "#222222") {
    toastQueue.Push({message: message, title: title, icon_path: icon_path, position: position, time_seconds: time_seconds, bg_color: bg_color})
    CheckAndShowNextToast()
}
; Function to check if there's a toast ready to be shown
CheckAndShowNextToast() {
    global toastQueue, isShowingToast
    if (!isShowingToast) {
        if (toastQueue.Length() > 0) {
            isShowingToast := true
            localToast := toastQueue.Pop()
            CreateToast(localToast.message, localToast.title, localToast.icon_path, localToast.position, localToast.time_seconds, localToast.bg_color)
            scriptlog(toJson(localToast))
            ; StartCheckTimer(-localToast.time_seconds * 1000)
        } else {
            SetTimer, % CloseToastFn, Off
        }
    }
}
StartCheckTimer(time) {
    ; random, rnd, 1, 100
    CheckToastQueueFn := Func("CheckAndShowNextToast").bind(0)
    SetTimer, % CheckToastQueueFn, % time
}
StartToastTimer(time) {
    global CloseToastFn
    ; random, rnd, 1, 100
    CloseToastFn := Func("CloseToast").bind(0)
    SetTimer, % CloseToastFn, % time
}
; Function to close the toast window
CloseToast() {
    global isShowingToast
    scriptlog("CloseToast()")
    Gui, Toast:Destroy
    ; if (isShowingToast)
    isShowingToast := False
    if (toastQueue.Length() < 1)
        SetTimer, % CloseToastFn, Off
    CheckAndShowNextToast()
}
; Define the CreateToast function
CreateToast(message, title := "AutoHotkey", icon_path := "toast.bmp", position := "topleft", time_seconds := 10, bg_color := "222222") {
    Gui, Toast:New
    width := 1440
    height := 744
    ; WinGetPos,,, width, height
    scriptlog("title " . toJson(title))
    scriptlog("message " . toJson(message))
    scriptlog("guiPosition " . toJson(guiPosition))
    scriptlog("width " . toJson(width))
    scriptlog("height " . toJson(height))
    if (width == "")
        return
    Gui, Toast:Font, s25 cFFFFFF
    Gui, Toast:Add, Text, x80, %title% 
    Gui, Toast:Font, s15
    Gui, Toast:Add, Text, x20 y80, %message%

    ; Determine the position based on the position parameter
    switch position
    {
        case "topleft":
            guiPosition := "x" . (A_ScreenWidth / 2 - width / 2) - 150 . " y" . (A_ScreenHeight / 2 - height / 2) - 100
        case "topright":
            guiPosition := "x" . (A_ScreenWidth - width - 20) . " y" . (A_ScreenHeight / 2 - height / 2)
        case "bottomleft":
            guiPosition := "x" . (A_ScreenWidth / 2 - width / 2) . " y" . (A_ScreenHeight - height - 20)
        case "bottomright":
            guiPosition := "x" . (A_ScreenWidth - width - 20) . " y" . (A_ScreenHeight - height - 20)
        default:
            guiPosition := "x" . (A_ScreenWidth / 2 - width / 2) . " y" . (A_ScreenHeight / 2 - height / 2) ; Default to top center
    }

    Gui, Toast:+AlwaysOnTop -Caption +E0x20 +LastFound
    
    Gui, Toast:Show, % guiPosition . " NoActivate AutoSize" ;  +E0x20  -Caption +AlwaysOnTop
    ; Gui, Toast:Show, % "x" . (A_ScreenWidth / 2 - width / 2) . " y" . (A_ScreenHeight / 2 - height / 2) . " w" . width . " h" . height . " NoActivate"
    
    ; Set the background color
    Gui, Toast:Color, %bg_color%
    
    ; Optionally set an icon
    if (icon_path != "") {
        Gui, Toast:Add, Picture, x10 y10 w64 h64, %icon_path%
    }
    
    ; Set the transparency
    Gui, Toast:+LastFound
    WinSet, TransColor, % "c" . bg_color . " 240"

    timer := time_seconds * 1000
    scriptlog(toJson(timer))
    
    ; Close the window after the specified time
    StartToastTimer(timer)
}