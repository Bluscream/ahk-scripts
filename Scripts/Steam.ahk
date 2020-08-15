#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
SetKeyDelay, 10
DetectHiddenWindows On
CoordMode Mouse, Client
#Include <bluscream>
#Include <asf>
#Include <JSON_Beautify>

global steam_login := new Window("Steam Login", "vguiPopupWindow", "steam.exe")
steam_login["controls"] := { "username": { "x": 269, "y": 100 }, "password": { "x": 260, "y": 133 }, "save": { "x": 123, "y": 163 } }
global steam_login_refresh := new Window("Steam - Refresh Login", "vguiPopupWindow", "Steam.exe")
steam_login_refresh["controls"] := { "password": { "x": 231, "y": 147 }, "2fa": { "x": 230, "y": 183 } }
global steam_login_refresh_2fa := new Window("Steam - Authenticator Code", "vguiPopupWindow", "Steam.exe")
global steam_2fa := new Window("Steam Guard - Computer Authorization Required", "vguiPopupWindow", "Steam.exe")
global steam_login_error := new Window("Steam - Error", "vguiPopupWindow", "steam.exe")

global logged_in := false
global asf := new ASF()
global main := asf.logins.accounts[1]

I_Icon := A_ProgramFiles . " (x86)\Steam\Steam.exe"  
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%
Menu, tray, add, % "--- Steam ---", StartSteam
for i, bot in asf.bots {
    if (bot.data.HasMobileAuthenticator)
        Menu, tray, add, % "2FA Code (" . bot.data.nickname . ")", Get2FACode
}
Menu, tray, add, % "Redeem Keys", RedeemKeys


; SetTimer, CheckForWindow, % 1000*5
; CheckForWindow:
while(true) {
    if (steam_login_error.exists()) {
        steam_login_error.activate()
        Send, % "{Enter}"
    } else if (steam_login_refresh.exists()) {
        steam_login_refresh.activate()
        SendString(steam_login_refresh, steam_login_refresh.controls.password, main.password)
        Send, % "{Enter}" 
        WinWait, % steam_login_refresh_2fa.str(),, 10
        if !(ErrorLevel) {
            steam_login_refresh_2fa.activate()
            Send, % "{Enter}"
            SendString(steam_login_refresh, steam_login_refresh.controls.2fa, asf.Get2FACode(main.botname))
        }
        Send, % "{Enter}" 
        WinWaitDisappear(steam_login_refresh)
    } else if (steam_login.exists()) {
        steam_login.activate()
        SendString(steam_login, steam_login.controls.username, main.username)
        SendString(steam_login, steam_login.controls.password, main.password)
        ClickControl(steam_login, steam_login.controls.save)
        if !(logged_in) {
            Send, % "{Enter}"
            logged_in := true
        }
        WinWait, % steam_2fa.str(),, 10
        if !(ErrorLevel) {
            steam_2fa.activate()
            paste(asf.Get2FACode(main.botname))
            Send, % "{Enter}"
        }
        WinWaitDisappear(steam_login)
    } 
    Sleep, % 1000*5
}
return

Get2FACode:
    txt := StrReplace(A_ThisMenuItem, "2FA Code (", "")
    txt := StrReplace(txt, ")", "")
    code := asf.getBotByNickname(txt).Get2FACode()
    Clipboard := code
    SplashScreen(txt, code, 2500)
    return

RedeemKeys:
    #InstallKeybdHook
    if (GetKeyState("Ctrl", "P")) {
        PasteToNotepad(JSON_Beautify(asf.GetRedeemedKeys()))
    } else if (GetKeyState("Shift", "P")) {
        PasteToNotepad(JSON_Beautify(toJson(asf.GetAllRedeemedKeys())))
    } else {
        text := MultiLineInput("Redeem Steam Keys")
        if !(text) {
            return
        }
        keys := asf.ParseSteamKeys(text, true)
        if (keys.Count() < 1) {
            MsgBox % "Could not find any valid Steam keys :("
            return
        } 
        MsgBox % toJson(asf.RedeemKeys(keys)) ; "`n".Join(keys)
    }
    return

StartSteam:
    Run % "steam://open/console"
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