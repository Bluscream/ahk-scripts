; #SingleInstance, Force
#Include <bluscream>
#Include <JSON>

class Bot {
    _asf := Object()
    data := Object()
    cfg := Object()

    __New(asf, data := "", config := "") {
        VarSetCapacity(asf.bots,0)
        this._asf := asf
        this.data := data
        this.cfg := config
        
    }

    getAPIUrl(endpoint) {
        return this._asf.config.url . "/Api/Bot/" . this.name . "/" . endpoint . "?password=" . this._asf.config.token
    }

    getRedeemedKeys() {
        return this._asf.getRedeemedKeys(this.data.botname)
    }

    get2FACode() {
        return this._asf.get2FACode(this.data.botname)
    }
}

; global _asf := new ASF()
; for i, bot in _asf.bots {
    ; resp := _asf.bots
    ; MsgBox % resp . " <> " . JSON_Beautify(resp)
; }

class ASF {
    config := Object()
    bots := []
    logins := Object()

    __New(logins := "") {
        if (logins == "") {
            logins := A_Desktop . "\steam.json"
        }
        FileRead, logins, % logins
        logins := JSON.Load(logins)
        this.logins := logins
        this.config := logins.asf
        for botname, data in this.getBots() {
            _bot := new Bot()
            if (logins.accounts[botname]) {
                _bot := new Bot(this, data, logins.accounts[botname])
            } else {
                _bot := new Bot(this, data)
            }
            this.bots.Push(_bot)
        }
    }

    getBots() {
        return this.get()
    }

    getBotByNickName(nickname) {
        for i, _bot in this.bots {
            if (_bot.data.nickname == nickname) {
                return _bot
            }
        }
    }
    getBotByUserName(username) {
        for i, _bot in this.bots {
            if (_bot.cfg.username == username) {
                return _bot
            }
        }
    }
    getBotBySteamId(steamid64) {
        for i, _bot in this.bots {
            if (_bot.data.SteamID == steamid64) {
                return _bot
            }
        }
    }
    getBotById(steamid64) {
        return this.getBotBySteamId(steamid64)
    }
    getBotByBotName(botname) {
        for i, _bot in this.bots {
            if (_bot.data.botName == botname) {
                return _bot
            }
        }
    }
    getBot(botname) {
        return this.getBotByBotName(botname)
    }

    getAPIUrl(endpoint := "", bot := "asf") {
        return this.config.url . "/Api/" . ((bot == "_" ? "" : "Bot/" . bot)) . (endpoint ? "/" . endpoint : "" ) . "?password=" . this.config.token
    }
    test() {
        MsgBox % "test"
    }
    http(method, endpoint, payload, bot := "asf") {
        if (bot == "") {
            bot := "asf"
        }
        url := this.getAPIUrl(endpoint, bot)
        ; MsgBox % url
        _json := ""
        if (method == "POST") {
            _json := PostJson(url, payload).result
        } else {
            _json := GetJson(url).result
        }
        if (bot != "asf" && bot != "_") {
            return _json[bot].result
        }
        return _json
    }
    get(endpoint := "", bot := "asf") {
        return this.http("GET", endpoint, "", bot)
    }
    post(endpoint := "", payload := "", bot := "asf") {
        return this.http("POST", endpoint, payload, bot)
    }
    
    getRedeemedKeys(bot := "asf") {
        return this.get("GamesToRedeemInBackground", bot)
    }
    getAllRedeemedKeys() {
        keys := Array()
        response := this.getRedeemedKeys()
        for account, data in response {
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
    redeemKeys(keys, bot := "asf") {
        request := { "GamesToRedeemInBackground": { } }
        for i, key in keys {
            request["GamesToRedeemInBackground"][key] := key
        }
        return this.post("GamesToRedeemInBackground", request, bot)
    }

    get2FACode(bot := "asf") {
        result := this.get("TwoFactorAuthentication/Token", bot)
        if (bot == "asf") {
            codes := {}
            for account, data in result {
                codes[account] := data.result
            }
            return codes
        }
        return result
    }
    
    customCommand(command) {
        return this.post("Command", { "Command": command }, "_")
    }

    guessSteamKey(key) {
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
                    _key := this.GuessSteamKey(_key)
                }
                ; scriptlog("3 > key: " . key . " A_Index: " . A_Index . " A_LoopField: " . A_LoopField)
                if (keys.indexOf(_key) = -1) {
                    keys.Push(_key)
                }
            }
        }
        return keys
    }
    steam_key_pattern := "((?![^0-9]{12,}|[^A-z]{12,})([A-z0-9]{4,5}-?[A-z0-9]{4,5}-?[A-z0-9]{4,5}(-?[A-z0-9]{4,5}(-?[A-z0-9]{4,5})?)?))"
    parseSteamKeys(text, guess := false) {
        keys := []
        asked := false
        key_pattern_guess := "((?![^0-9\?]{12,}|[^A-z\?]{12,})([A-z0-9\?]{4,5}-?[A-z0-9\?]{4,5}-?[A-z0-9\?]{4,5}(-?[A-z0-9\?]{4,5}(-?[A-z0-9\?]{4,5})?)?))"
        pattern := (guess ? key_pattern_guess : this.steam_key_pattern)
        for i, m in RxMatches(text, "O)" . pattern) {
            key := m.Value
            if (guess && InStr(key, "?")) {
                if !(asked) {
                    asked := true
                    MsgBox 0x34, % "Guess Keys?", % "We found a key containing a ?`nYou can try to guess the missing character but this will try an insane amount of keys and can take days depending on the amount of known chars`, are you sure?"
                    IfMsgBox No, {
                        guess := false
                    } else {
                        this.GuessSteamKey(key)
                    }
                } else {
                    this.GuessSteamKey(key)
                }
            } else if (keys.indexOf(m.Value) = -1) {
                keys.Push(m.Value)
            }
        }
        return keys
    }
}