#Include <bluscream>
#Include <JSON>

FileRead, steam_logins, % A_Desktop . "\steam.json"
global steam_logins := JSON.Load(steam_logins)
global steam_key_pattern := "((?![^0-9]{12,}|[^A-z]{12,})([A-z0-9]{4,5}-?[A-z0-9]{4,5}-?[A-z0-9]{4,5}(-?[A-z0-9]{4,5}(-?[A-z0-9]{4,5})?)?))"
global steam_key_pattern_guess := "((?![^0-9\?]{12,}|[^A-z\?]{12,})([A-z0-9\?]{4,5}-?[A-z0-9\?]{4,5}-?[A-z0-9\?]{4,5}(-?[A-z0-9\?]{4,5}(-?[A-z0-9\?]{4,5})?)?))"

void=
(
run, Notepad.exe,,, notePadPID
WinWait, ahk_pid %notepadPID%
WinActivate, ahk_pid %notepadPID%
paste("`n".join(GuessSteamKey("1?B2C-D3FGH-456I?")))
ExitApp
)

GetRedeemedKeys() {
    keys := Array()
    response := GetJson(steam_logins.asf.url . "/Api/Bot/asf/GamesToRedeemInBackground?password=" . steam_logins.asf.token)
    for account, data in response.result {
        ; MsgBox, % toJson(account) . " : " . toJson(v)
        for key, name in data.usedkeys {
            ; MsgBox % key
            if (keys.indexOf(key) = -1) {
                keys.Push(key)
            }
        }
    }
    return keys
}
RedeemKeys(keys) {
    request := { "GamesToRedeemInBackground": { } }
    for i, key in keys {
        request["GamesToRedeemInBackground"][key] := key
    }
    return PostJson(steam_logins.asf.url . "/Api/Bot/asf/GamesToRedeemInBackground?password=" . steam_logins.asf.token, request)
}

Get2FACode(name := "") {
    return GetJson(steam_logins.asf.url . "/Api/Bot/" . name . "/TwoFactorAuthentication/Token?password=" . steam_logins.asf.token).result[name].result
}

Get2FACodes() {
    codes := {}
    for account, data in response.result {
        codes[account] := data.result
    }
    return codes
}

GuessSteamKey(key) {
    keys := []
    guess_dict := "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    index := 0
    Loop, parse, key
    {
        index += 1
        if (A_LoopField != "?") {
            continue
        }
        ; scriptlog("2 > index: " . index . " A_Index: " . A_Index . " A_LoopField: " . A_LoopField)
        ; part_of_key := A_LoopField
        Loop, parse, guess_dict
        {
            _key := ReplaceAtPos(key, index, A_LoopField) ; mid$(key, index, A_LoopField) ; StrReplace(key, "?", A_LoopField,, 1)
            while (InStr(_key, "?")) {
                _key := GuessSteamKey(_key)
            }
            ; scriptlog("3 > key: " . key . " A_Index: " . A_Index . " A_LoopField: " . A_LoopField)
            if (keys.indexOf(_key) = -1) {
                keys.Push(_key)
            }
       }
   }
   return keys
}

ParseSteamKeys(text, guess := false) {
    keys := []
    asked := false
    for i, m in RxMatches(text, "O)" . (guess ? steam_key_pattern_guess : steam_key_pattern)) {
        key := m.Value
        scriptlog("1 > key: " . key)
        if (guess && InStr(key, "?")) {
            if !(asked) {
                asked := true
                MsgBox 0x34, % "Guess Keys?", % "We found a key containing a ?`nYou can try to guess the missing character but this will try an insane amount of keys and can take days depending on the amount of known chars`, are you sure?"
                IfMsgBox No, {
                    guess := false
                } else {
                    GuessSteamKey(key)
                }
            } else {
                GuessSteamKey(key)
            }
        } else if (keys.indexOf(m.Value) = -1) {
            keys.Push(m.Value)
        }
    }
    return keys
}