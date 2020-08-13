#Include <bluscream>
#Include <JSON>

FileRead, steam_logins, % A_Desktop . "\steam.json"
global steam_logins := JSON.Load(steam_logins)
global steam_key_pattern := "((?![^0-9\?]{12,}|[^A-z\?]{12,})([A-z0-9\?]{4,5}-?[A-z0-9\?]{4,5}-?[A-z0-9\?]{4,5}(-?[A-z0-9\?]{4,5}(-?[A-z0-9\?]{4,5})?)?))"

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
RedeemKeys(keys, guess := false) {
    guess_dict := "abcdefghijklmnopqrstuvwxyz0123456789"
    request := { "GamesToRedeemInBackground": { } }
    for i, key in keys {
        if (guess && InStr(key, "?")) {
            Loop, parse, guess_dict
                key := StrReplace(key, "?", A_LoopField)
                request["GamesToRedeemInBackground"][key] := key
        } else {
            request["GamesToRedeemInBackground"][key] := key
        }
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

ParseSteamKeys(text) {
    keys := []
    for i, m in RxMatches(text, "O)" . steam_key_pattern) {
       if (keys.indexOf(m.Value) = -1) {
            keys.Push(m.Value)
       }
    }
    return keys
}