#Include <JSON>
#Include <JSON_Beautify>
toJson(object, beautify := false) {
    if (beautify)
        return JSON_Beautify(object)
    return JSON.Dump(object)
}
fromJson(txt) {
    return JSON.Load(txt)
}
#Include <json_toobj>
GetJson(url, auth := "") {
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpObj.Open("GET", url, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    if (auth != "") {
        HttpObj.SetRequestHeader("Authorization", "Basic " . auth)
    }
    HttpObj.SetTimeouts(0,30000,30000,120000)
    HttpObj.Send()
    HttpObj.WaitForResponse()
    ; scriptlog(HttpObj.ResponseText)
    try {
        _json := JSON.Load(HttpObj.ResponseText)
    }
    if !(_json) {
        ; MsgBox % "GetJson ResponseText:"
        _json := json_toobj(HttpObj.ResponseText)
    }
    return _json
}
PostJson(url, payload) {
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    scriptlog("PostJson.url: " . url)
    HttpObj.Open("POST", url, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    _json := JSON.Dump(payload)
    if !(_json) {
        scriptlog("PostJson payload:")
        _json := json_fromobj(payload)
    }
    scriptlog("PostJson._json: " . toJson(_json))
    HttpObj.SetTimeouts(0,999999,999999,999999)
    HttpObj.Send(_json)
    HttpObj.WaitForResponse()
    _json := JSON.Load(HttpObj.ResponseText)
    if !(_json) {
        scriptlog("PostJson ResponseText:")
        _json := json_toobj(HttpObj.ResponseText)
        scriptlog(_json)
    }
    return _json
}