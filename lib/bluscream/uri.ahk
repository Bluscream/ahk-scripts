
class Url {
    url := ""
    protocol := "" ; contains: "ftp"
    ftpUser := "" ; contains: "testuser"
    ftpPass := "" ; contains: "testpass"
    domainName := "" ; contains: "example"
    domainExt := "" ; contains: "com"
    port := "" ; contains: "21"
    subDomainDir := "" ; contains: "subdomain"
    subDir := "" ; contains: "home"
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
            Loop, parse, url, % "."
                this.subDomainDir[A_Index] := A_LoopField
        }
        ; scriptlog("New Url: " . ToJson(this, false))
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