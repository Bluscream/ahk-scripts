; UrlEscape( url, flags )
; UrlUnEscape( url, flags )
; URIEncode(str, encoding := "UTF-8")
; URI_Encode(sURI, sExcepts = "!#$&'()*+,-./:;=?@_~")
; URI_EncodeComponent(sURI, sExcepts = "!'()*-._~")
setHeader(request, header, value) {
    scriptlog("Setting header """ . header . """ to """ . value . """")
    request.setRequestHeader(header, value)
}
getResponseHeaders(response) {
    headers := response.GetAllResponseHeaders()
    headers := StrSplit(StrReplace(headers, "`r", ""), "`n")
    for header in headers {
        scriptlog("Response header " . toJson(header) . ": " . toJson(header))
    }
    return headers
}
class Url {
    url := ""
    protocol := "" ; contains: "ftp"
    ftpUser := "" ; contains: "testuser"
    ftpPass := "" ; contains: "testpass"
    domainName := "" ; contains: "example"
    domainExt := "" ; contains: "com"
    port := "" ; contains: "21"
    subDomainDir := [] ; contains: "subdomain"
    subDir := "" ; contains: "home"
    domain := "" ; contains: "subdomain.example.com"
    filename := ""

    __New(url) {
        url := Trim(url)
        this.url := url
        If (p := InStr(url,"://")) {
            this.protocol := SubStr(url, 1, p-1)
            url := SubStr(url, p+3)
        }
        If (p := InStr(url,"/")) {
            url2 := SubStr(url, p+1)
            url := SubStr(url, 1, p-1)
            Loop, parse, url2, % "/"
            { 
                If (A_LoopField != "")
                    this.subDir[A_Index] := A_LoopField
            }
            lst := StrSplit(this.url, "/")
            this.filename := lst[lst.MaxIndex()]
        }
        If (p := InStr(url,"@")) {
            url2 := SubStr(url, 1, p-1)
            url := SubStr(url, p+1)
            p := InStr(url2,":")
            this.ftpUser := SubStr(url2, 1, p-1)
            this.ftpPass := SubStr(url2, p+1)
        }
        If (p := InStr(url,":")) {
            this.port := SubStr(url, p+1)
            url := SubStr(url, 1, p-1)
        }
        Loop, parse, url, .
        {
            url3 := A_LoopField . "." . url3
            count := A_Index
        }
        url3 := SubStr(url3, 1, StrLen(url3)-1)
        p := InStr(url3,".")
        this.domainExt := SubStr(url3, 1, p-1)
        url3 := SubStr(url3, p+1)
        p := InStr(url3,".")
        this.domainName := SubStr(url3, 1, p-1)
        url := SubStr(url3, StrLen(this.domainExt)+StrLen(this.domainName)-1)
        If (count > 1) {
            Loop, parse, % url, % "."
                this.subDomainDir[A_Index] := A_LoopField
        }
        this.domain := ""
        if this.subDomainDir.MaxIndex() {
            this.domain .= this.subDomainDir[this.subDomainDir.MaxIndex()] . "."
        }
        if this.domainName {
            this.domain .= this.domainName
        }
        if this.domainExt {
            this.domain .= "." this.domainExt
        }
        ; scriptlog("New Url: " . ToJson(this, false))
    }

    visit(method := "GET", data := "", auth := "", retry := false) {
        try{
            HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
            HttpObj.Open(method, this.url, 0)
            ; HttpObj.SetRequestHeader("Content-Type", "application/json")
            if (auth != "") {
                HttpObj.SetRequestHeader("Authorization", "Basic " . auth)
            }
            HttpObj.SetTimeouts(0,5000,5000,10000)
            HttpObj.Send(data)
            scriptlog("Visited " . this.url)
        } catch e {
            scriptlog("Error: " . e.Message)
            if (retry) {
                scriptlog("Retrying...")
                this.visit(method, data, auth, false)
            }
        }
    }

; domainName := "" ; contains: "example"
;     domainExt := "" ; contains: "com"
;     subDomainDir

    get(headers := "") {
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("GET", this.url, true)
        setHeader(whr, "Host", this.domain)
        headers := headers or []
        for header, value in headers {
            setHeader(whr, header, value)
        }
        scriptlog("Sending GET request to """ . this.url . """")
        whr.Send()
        whr.WaitForResponse()
        return whr
    }

    post(contentType := "application/x-www-form-urlencoded", data := "") {
        whr := ComObjCreate("WinHttp.WinHttpRequest.5.1")
        whr.Open("POST", this.url, true)
        whr.SetRequestHeader("Content-Type", contentType)
        whr.Send(data)
        whr.WaitForResponse()
        return whr
    }

    download(outDir := "", outFile := "", force := false) {
        if (outDir == "") {
            outDir := new Paths.User().temp
        }
        if (outFile == "") {
            outFile := this.filename
        }
        out := outDir.combineFile(outFile)
        if (!FileExist(out.path) or force) {
            scriptlog("Downloading " . this.url . " to " . out.Quote())
            UrlDownloadToFile, % this.url, % out.path
            scriptlog("Finished downloading " . this.url)
        } else {
            scriptlog("Skipping download of " . this.url . " to " . out.Quote() . ": Already exists!")
        }
        return out
    }
}