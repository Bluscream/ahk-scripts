#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetKeyDelay, 10
DetectHiddenWindows On
CoordMode Mouse, Client
; SendMode, Input
#Include <bluscream>
; #Include <JSON>
#Warn

global steam_login := new Window("Steam Login", "vguiPopupWindow", "steam.exe")
steam_login["controls"] := { "username": { "x": 269, "y": 100 }, "password": { "x": 260, "y": 133 }, "save": { "x": 123, "y": 163 } }
global steam_login_refresh := new Window("Steam - Refresh Login", "vguiPopupWindow", "Steam.exe")
steam_login_refresh["controls"] := { "password": { "x": 231, "y": 147 }, "2fa": { "x": 230, "y": 183 } }
global steam_login_refresh_2fa := new Window("Steam - Authenticator Code", "vguiPopupWindow", "Steam.exe")
global steam_2fa := new Window("Steam Guard - Computer Authorization Required", "vguiPopupWindow", "Steam.exe")
FileRead, logins, % "C:\Users\blusc\Desktop\steam.json"
global logins := JSON.Load(logins)

; SetTimer, CheckForWindow, % 1000*5


; CheckForWindow:
while(true) {
    if (steam_login_refresh.exists()) {
        steam_login_refresh.activate()
        SendString(steam_login_refresh, steam_login_refresh.controls.password, logins[1].password)
        Send, % "{Enter}" 
        WinWait, % steam_login_refresh_2fa.str(),, 10
        if !(ErrorLevel) {
            steam_login_refresh_2fa.activate()
            Send, % "{Enter}"
            SendString(steam_login_refresh, steam_login_refresh.controls.2fa, Get2FACode(logins[1].botname))
        }
        Send, % "{Enter}" 
        WinWaitDisappear(steam_login_refresh)
    } else if (steam_login.exists()) {
        steam_login.activate()
        SendString(steam_login, steam_login.controls.username, logins[1].username)
        SendString(steam_login, steam_login.controls.password, logins[1].password)
        ClickControl(steam_login, steam_login.controls.save)
        ; Send, % "{Enter}"
        WinWait, % steam_2fa.str(),, 10
        if !(ErrorLevel) {
            steam_2fa.activate()
            paste(Get2FACode(logins[1].botname))
            Send, % "{Enter}"
        }
        WinWaitDisappear(steam_login)
    } 
    ; RunWait, "D:\Downloads\WinAuth.exe"
    Sleep, % 1000*5
}
return

WinWaitDisappear(window) {
    while (window.exists()) {
        Sleep, 1000
    }
}

SendString(win, control, value) {
    if !(win.exists())
        Return
    if !(win.isActive())
        win.activate()
    ClickControl(win, control)
    Sleep, 10
    Send ^a
    Sleep, 10
    ; Send, % value
    paste(value)
}

ClickControl(win, control) {
    if !(win.exists())
        Return
    if !(win.isActive())
        win.activate()
    MouseClick,,% control.x, % control.y
}

Get2FACode(name) {
    return GetJson("http://192.168.2.38:1242/Api/Bot/" . name . "/TwoFactorAuthentication/Token").result[name].result
}