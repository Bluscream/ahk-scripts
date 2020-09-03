#SingleInstance Force
#NoEnv
; #NoTrayIcon
#Persistent
SetWorkingDir %A_ScriptDir%
; SetBatchLines -1
SetKeyDelay, 10
DetectHiddenWindows On
CoordMode Mouse, Client
#Include <bluscream>
#Include <asf>

global steam_login := new Window("Steam Login", "vguiPopupWindow", "steam.exe")
steam_login["controls"] := { "username": { "x": 269, "y": 100 }, "password": { "x": 260, "y": 133 }, "save": { "x": 123, "y": 163 } }
global steam_login_refresh := new Window("Steam - Refresh Login", "vguiPopupWindow", "Steam.exe")
steam_login_refresh["controls"] := { "password": { "x": 231, "y": 147 }, "2fa": { "x": 230, "y": 183 } }
global steam_login_refresh_2fa := new Window("Steam - Authenticator Code", "vguiPopupWindow", "Steam.exe")
global steam_2fa := new Window("Steam Guard - Computer Authorization Required", "vguiPopupWindow", "Steam.exe")
global steam_login_error := new Window("Steam - Error", "vguiPopupWindow", "steam.exe")

global logged_in := false
global asf := new ASF()
global main := asf.getBotByNickname("blu")
global alt := asf.getBotByNickname("red")

I_Icon := A_ProgramFiles . " (x86)\Steam\Steam.exe"  
IfExist, %I_Icon%
  Menu, Tray, Icon, %I_Icon%
; Menu, Tray, NoStandard
Menu, tray, add, % "--- Steam ---", StartSteam
for i, bot in asf.bots {
    if (bot.data.HasMobileAuthenticator)
        Menu, tray, add, % "2FA Code (" . bot.data.nickname . ")", Get2FACode
}
Menu, tray, add, % "Redeem Keys", RedeemKeys
Menu, tray, add, % "Free Games", FreeGames
Menu, tray, add, % "Debug", Debug ; Todo: comment


; SetTimer, CheckForWindow, % 1000*5
; CheckForWindow:
while(true) {
    if (steam_login_error.exists()) {
        steam_login_error.activate()
        Send, % "{Enter}"
    } else if (steam_login_refresh.exists()) {
        steam_login_refresh.activate()
        SendString(steam_login_refresh, steam_login_refresh.controls.password, main.cfg.password)
        Send, % "{Enter}" 
        WinWait, % steam_login_refresh_2fa.str(),, 10
        if !(ErrorLevel) {
            steam_login_refresh_2fa.activate()
            Send, % "{Enter}"
            SendString(steam_login_refresh, steam_login_refresh.controls.2fa, main.Get2FACode())
        }
        Send, % "{Enter}" 
        WinWaitDisappear(steam_login_refresh)
    } else if (steam_login.exists()) {
        steam_login.activate()
        SendString(steam_login, steam_login.controls.username, main.cfg.username)
        SendString(steam_login, steam_login.controls.password, main.cfg.password)
        ClickControl(steam_login, steam_login.controls.save)
        if !(logged_in) {
            ; Send, % "{Enter}"
            logged_in := true
        }
        WinWait, % steam_2fa.str(),, 10
        if !(ErrorLevel) {
            steam_2fa.activate()
            paste(main.Get2FACode())
            Send, % "{Enter}"
        }
        WinWaitDisappear(steam_login)
    } 
    Sleep, % 1000*5
}
return

Debug:
    txt := toJson(asf.config, true)
    for i, bot in asf.bots {
        txt .= toJson(bot.cfg, true)
        txt .= toJson(bot.data, true)
    }
    PasteToNotepad(txt)
    return

Get2FACode:
    txt := StrReplace(A_ThisMenuItem, "2FA Code (", "")
    txt := StrReplace(txt, ")", "")
    code := asf.getBotByNickname(txt).Get2FACode()
    Clipboard := code
    SplashScreen(txt, code, 2500)
    return

FreeGames:
    if !(WinExist("Free Packages · SteamDB")) {
        Run % "chrome.exe ""https://steamdb.info/freepackages"""
    }
    
    result := asf.botInput("Add licenses")
    if !(result[2]) {
        return
    }
    ; for i, m in RxMatches(txt, "O)" . "^\t\t(\d+)\, \/\/  (.*)$") { ; \t\t(\d+)\, \/\/\s+(.*)") {
        ; MsgBox % "m1: " . m[1] . "`nm2: " . m[2] . "`nm3: " . m[3] . "`n"
        ; name := m[2]
        ; ids[name] := m[1]
    ; }
    ids := asf.parseLicenses(result[2])
    if (ids.Count() < 1) {
        MsgBox % "Could not find any valid license IDs :("
        return
    }
    PasteToNotepad(toJson(asf.addLicenses(ids, result[1]), true))
    return


RedeemKeys:
    #InstallKeybdHook
    if (GetKeyState("Ctrl", "P")) {
        PasteToNotepad(toJson(asf.GetRedeemedKeys(), true))
    } else if (GetKeyState("Shift", "P")) {
        PasteToNotepad(toJson(asf.GetAllRedeemedKeys(), true))
    } else {
        result := asf.botInput("Redeem Steam Keys")
        redeem_now := GetKeyState("Shift", "P")
        if !(result[2]) {
            return
        }
        keys := asf.ParseSteamKeys(result[2], true)
        if (keys.Count() < 1) {
            MsgBox % "Could not find any valid Steam keys :("
            return
        }
        MsgBox % toJson(redeem_now ? asf.RedeemKeysNow(keys, result[1]) : asf.RedeemKeys(keys, result[1]), true) ; "`n".Join(keys)
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