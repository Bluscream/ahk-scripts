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

    redeemKeys(keys) {
        return this._asf.redeemKeys(keys, this.data.botname)
    }

    redeemKeysNow(keys) {
        return this._asf.redeemKeysNow(keys, this.data.botname)
    }

    addLicenses(ids) {
        return this._asf.addLicenses(ids, this.data.botname)
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
            logins := A_Desktop . "\steam.json"
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

    getBotsDropDown(default := "asf") {
        _lst := "All (asf)" . ("asf" == default ? "|" : "")
        for i, bot in this.bots {
            _lst .= "|" . (bot.data.nickname ? bot.data.nickname . " " : "") . "(" . bot.data.botname . ")" . (bot.data.botname == default ? "|" : "")
            ; MsgBox % toJson(_lst)
        }
        return _lst ; .join("|")
    }

    getBotByNickName(nickname) {
        for _i, _bot in this.bots {
            if (_bot.data.nickname = nickname) {
                return _bot
            }
        }
    }
    getBotByUserName(username) {
        for _i, _bot in this.bots {
            if (_bot.cfg.username = username) {
                return _bot
            }
        }
    }
    getBotBySteamId64(steamid64) {
        for _i, _bot in this.bots {
            if (_bot.data.SteamID == steamid64) {
                return _bot
            }
        }
    }
    getBotBySteamId(steamid64) {
        return this.getBotBySteamId64(steamid64)
    }
    getBotById(steamid64) {
        return this.getBotBySteamId(steamid64)
    }
    getBotByBotName(botname) {
        for _i, _bot in this.bots {
            if (_bot.data.botName = botname) {
                return _bot
            }
        }
    }
    getBot(botname) {
        return this.getBotByBotName(botname)
    }

    getAPIUrl(endpoint := "", bot := "asf") {
        bot := (bot == "_" ? "" : "/Bot/" . bot)
        endpoint := (endpoint ? "/" . endpoint : "")
        return this.config.url . "/Api" . bot . endpoint . "?password=" . this.config.token
    }
    http(method, endpoint, payload, bot := "asf") {
        if (bot == "") {
            bot := "asf"
        }
        url := this.getAPIUrl(endpoint, bot)
        ; MsgBox % "asf.http(" . method . " " . url
        _json := ""
        if (method == "POST") {
            _json := PostJson(url, payload).result
        } else {
            _json := GetJson(url).result
        }
        if (bot != "asf" && bot != "_") {
            if (endpoint = "redeem")
                return _json[bot]
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
        _keys := Array()
        response := this.getRedeemedKeys()
        for account, data in response {
            ; MsgBox, % toJson(account) . " : " . toJson(v)
            for key, name in data.usedkeys {
                ; MsgBox % key
                if (_keys.indexOf(key) = -1) {
                    _keys.Push(key)
                }
            }
        }
        return _keys
    }
    redeemKeys(_keys, bot := "asf") {
        request := { "GamesToRedeemInBackground": { } }
        for _i, key in _keys {
            request["GamesToRedeemInBackground"][key] := key
        }
        return this.post("GamesToRedeemInBackground", request, bot)
    }
    redeemKeysNow(_keys, bot := "asf") {
        request := { "KeysToRedeem": [] }
        for _i, key in _keys {
            request["KeysToRedeem"].push(key)
        }
        return this.post("Redeem", request, bot)
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
        response := this.post("Command", { "Command": command }, "_")
        _res := {}
        Loop, Parse, response, `n, `r
        {
            line := Trim(A_LoopField)
            if !(line)
                continue
            ismatch := RegExMatch(A_LoopField, "^<(.*)> (.*)$", m)
            if !(ismatch)
                return response
            if _res.HasKey(m1) {
                _res[m1].push(m2)
            } else {
                _res[m1] := [m2]
            }
        }
        return _res
    }

    guessSteamKey(key) {
        _keys := []
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
                if (_keys.indexOf(_key) = -1) {
                    _keys.Push(_key)
                }
            }
        }
        return _keys
    }
    steam_key_pattern := "((?![^0-9]{12,}|[^A-z]{12,})([A-z0-9]{4,5}-?[A-z0-9]{4,5}-?[A-z0-9]{4,5}(-?[A-z0-9]{4,5}(-?[A-z0-9]{4,5})?)?))"
    parseSteamKeys(text, guess := false) {
        _keys := []
        asked := false
        key_pattern_guess := "((?![^0-9\?]{12,}|[^A-z\?]{12,})([A-z0-9\?]{4,5}-?[A-z0-9\?]{4,5}-?[A-z0-9\?]{4,5}(-?[A-z0-9\?]{4,5}(-?[A-z0-9\?]{4,5})?)?))"
        pattern := (guess ? key_pattern_guess : this.steam_key_pattern)
        for _i, m in RxMatches(text, "O)" . pattern) {
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
            } else if (_keys.indexOf(m.Value) = -1) {
                _keys.Push(m.Value)
            }
        }
        return _keys
    }
    addLicenses(_ids, bot := "asf") {
        if (IsObject(_ids))
            if (_ids.Count() < 1)
                return
            _ids := ",".join(_ids)
        return this.customCommand("addlicense " . bot . " " . _ids)
    }
    addLicensesOld(_ids) { ; Deprecated
        ret := ""
        cnt := _ids.Count()
        for id, name in _ids {
            SplashImage, , b FM14 fs10, % name . " (" . id . ") ", % "Processing " . A_Index . " / " . cnt
            resp := this.addLicense(id)
            ret .= "`nActivating """ . name . """ (" . id . "): " . toJson(resp)
        }
        SplashImage, Off
        return ret
    }
    parseLicenses(text) {
        _ids := []
        for _i, m in RxMatches(text, "O)" . "(\d{5,7})") {
            _ids.push(m.Value)
        }
        return _ids
    }
    parseLicensesOld(text) {
        
        _ids := {}
        Loop, Parse, text, `n, `r
        {
            ismatch := RegExMatch(A_LoopField, "(\d+),\s*\/\/\s*(.+)", m)
            if !(ismatch)
                continue
            _ids[m1] := m2
        }
        return _ids
    }
    botInput(title:="", default := "asf", text := "", readonly := false) {
        Global BotInput_Edit
        Global BotInput_Bot
        Global BotInput_Bot
        Gui New, +LabelBotInput +hWndhBotInputWnd -MinimizeBox -MaximizeBox +AlwaysOnTop, FreeLicenses
        Gui Color, 0x808080
        if (readonly)
            Gui Add, Edit, vBotInput_Edit x16 y40 w331 h216 +Multi +ReadOnly, % text
        else
            Gui Add, Edit, vBotInput_Edit x16 y40 w331 h216 +Multi, % text
        Gui Add, DropDownList, vBotInput_Bot x48 y8 w205, % this.getBotsDropDown(default)
        Gui Add, Text, x16 y8 w26 h23 +0x200, Bot:
        Gui Add, Button, gBtnSubmit x264 y8 w80 h23 +Default, &Submit
        Gui Show, w355 h265, % title
        Goto, BotInput_Wait
        BtnSubmit:
            GuiControlGet, BotInput_Bot
            GuiControlGet, BotInput_Edit
        BotInputEscape:
        BotInputClose:
            ReturnNow := True
        BotInput_Wait:
            While (!ReturnNow)
                Sleep, 100
        Gui, Destroy
        Return % [MatchBetween(BotInput_Bot,"(",")").last(), BotInput_Edit]
    }
}