#Include <bluscream>
#Include <JSON>

FileRead, steam_logins, % "C:\Users\blusc\Desktop\steam.json"
global steam_logins := JSON.Load(steam_logins)

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
    for i, k in keys {
        request["GamesToRedeemInBackground"][k] := k
    }
    return PostJson(steam_logins.asf.url . "/Api/Bot/asf/GamesToRedeemInBackground?password=" . steam_logins.asf.token, request)
}

Get2FACode(name) {
    return GetJson(steam_logins.asf.url . "/Api/Bot/" . name . "/TwoFactorAuthentication/Token?password=" . steam_logins.asf.token).result[name].result
}