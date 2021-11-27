; #SingleInstance, Force
#Include <bluscream>
#Include <JSON>

class AutoMagic {
    config := Object()
    url := ""

    __New(config := "") {
        config := A_Desktop . "\automagic.json"
        FileRead, config, % config
        config := JSON.Load(config)
        this.config := config
        if (startsWith(A_IPAddress1, "192.168.2.")) { ; TODO: DO BETTER
            this.url := config.urls[1]
        } else {
            this.url := config.urls[2]
        }
        scriptlog("New AutoMagic " . this.url)
    }

    getAPIUrl(endpoint := "") {
        endpoint := (endpoint ? "/" . endpoint : "")
        return this.url . endpoint . "?password=" . this.config.password
    }
    http(method, endpoint, payload) {
        url := this.getAPIUrl(endpoint)
        _json := ""
        try {
            if (method == "POST") {
                _json := PostJson(url, payload)
            } else {
                if IsObject(payload) {
                    _obj := payload
                    payload := ""
                    for k, v in _obj {
                        item := "&" . k . "=" . v
                        payload .= item
                    }
                } else {
                    payload := (payload != "" ? "&" . payload : "")
                }
                scriptlog(method . " " . url . payload)
                _json := GetJson(url . payload)
            }
        }
        if (!_json) {
            err := "AutoMagic server not found, exiting...`n`n" . StrSplit(url, "?")[1]
            scriptlog(err)
            ; MsgBox 0x10, % "AutoHotKey - Error", % err
            return {}
        }
        scriptlog(toJson(_json))
        return _json
    }
    get(endpoint := "", query_string := "") {
        return this.http("GET", endpoint, query_string)
    }
    post(endpoint := "", payload := "") {
        return this.http("POST", endpoint, payload)
    }
    put(endpoint := "", payload := "") {
        return this.http("PUT", endpoint, payload)
    }
    delete(endpoint := "", payload := "") {
        return this.http("DELETE", endpoint, payload)
    }
    
    ping() {
        return this.get("ping")
    }

    createNotification(message := "", bigmessage := "", title := "") {
        title := (title == "") ? "AutoHotKey - " . A_UserName . "@" . A_ComputerName : title
        if (bigmessage != "")
            bigmessage := message . "`n`n" . bigmessage
        return this.get("notification/create", { "title": URIEncode(title), "message": URIEncode(message), "bigmessage": URIEncode(bigmessage)})
    }

    deleteNotification(id) {
        this.delete("notification", { "id": id })

    createToast(msg := "AutoHotKey", isLong := 0) { ; , gravity := "", x := 0, y := 0
        this.get("toast/create", { "msg": URIEncode(msg), "long": isLong })
    }

    shutdown(delay := 0) {
        this.get("shutdown", { "sleep": delay })
    }

    reboot(delay := 0) {
        return this.get("reboot", { "sleep": delay})
    }

    setClipboard(text) { ; TODO: FIX
        request := { "text": text }
        this.post("clipboard", request)
    }

    getClipboard() {
        this.get("clipboard")
    }

    openUrl(url, package := "", class := "") {
        params := { "url": URIEncode(url) }
        if (package != "")
            params["package"] := package
        if (class != "")
            params["class"] := class
        this.get("url/open", params)
    }

    openApp(package, class := "") {
        this.get("app/open", { "package": package, "class": class })
    }
    closeApp(package) {
        this.get("app/close", { "package": package })
    }
    killApp(package) {
        this.get("app/kill", { "package": package })
    }
    installApp(package) {
        this.put("app", { "package": package })
    }
    uninstallApp(package) {
        this.delete("app", { "package": package })
    }

    lock() {
        this.get("screen/lock")
    }
    unlock() {
        this.get("screen/unlock")
    }
    on() {
        this.get("screen/on")
    }
    recordScreen(save_as := "/storage/emulated/0/recording.mp4", send_to_url := "") {
        this.get("screen/record", { "file": save_as, "send_to_url": send_to_url})
    }
    stopRecordScreen() {
        this.delete("screen/record")
    }
    recordAudio(save_as := "/storage/emulated/0/recording.mp3", send_to_url := "") {
        this.get("audio/record", { "file": save_as, "send_to_url": send_to_url})
    }
    stopRecordAudio() {
        this.delete("audio/record")
    }
}