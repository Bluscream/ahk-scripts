
GetString(url, auth := "") {
    HttpObj := ComObjCreate("WinHttp.WinHttpRequest.5.1")
    HttpObj.Open("GET", url, 0)
    HttpObj.SetRequestHeader("Content-Type", "application/json")
    if (auth != "") {
        HttpObj.SetRequestHeader("Authorization", "Basic " . auth)
    }
    HttpObj.SetTimeouts(0,30000,30000,120000)
    HttpObj.Send()
    HttpObj.WaitForResponse()
    return HttpObj.ResponseText
}
mid$(input, startPos, replacement) {
 Return, SubStr(input,1,startPos-1) . replacement . SubStr(input,startPos+StrLen(replacement))
}
ReplaceAtPos(String, pos, Replacement) {
    IfGreater, Pos, % StrLen(String), Return, String
    Return, SubStr(String, 1, pos - 1) Replacement SubStr(String, pos + 1)
}
EscapeCurly(text) {
    ; str := StrReplace(str, "{", "{{}" ; Sends {
    ; str := StrReplace(str, "}", "{}}" ; Sends }
    ; return StrReplace(str, "{}", "{{}{}}" ; Sends {}
    Loop, Parse, text              ; retrieves each character from the variable, one at a time
    {
        if (A_LoopField == "{") {
            str .= "{{}"
        } else if (A_LoopField == "}") {
            str .= "{}}"
        } else {
            str .= A_LoopField
        }
    }
    return str
}
NewLine(){
    return "`r`n"
}
startsWith(string, substring) {
    return InStr(string, substring) == 1
}
endsWith(string, substring) {
    return string ~= RegExEscape(substring) . "$"
}
StrStrip(string) {
    return RegexReplace(string, "^\s+|\s+$")
}
Quote(string) {
    return """" . string . """"
}
toYesNo(bool) {
    return bool ? "Yes" : "No"
}
toTrueFalse(bool) {
    return bool ? "True": "False"
}
toEnabledDisabled(bool) {
    return bool ? "Enabled": "Disabled"
}
HexToString(String) { 
   local Length, CharStr, RetString 
   If !String 
      Return 0 
   Length := StrLen(String)//2 
   Loop, %Length%
   { 
      StringMid, CharStr, String, A_Index*2 - 1, 2 
      CharStr = 0x%CharStr%
      RetString .= Chr(CharStr) 
      
      } 
   Return RetString 
   }
StringToHex(String, spaces := true) {
	local Old_A_FormatInteger, CharHex, HexString
	If !String
		Return 0
	Old_A_FormatInteger := A_FormatInteger
	SetFormat, INTEGER, H
	Loop, Parse, String 
    {
		CharHex := Asc(A_LoopField)
		StringTrimLeft, CharHex, CharHex, 2
		HexString .= CharHex . (spaces ? " " : "") 
    }
	SetFormat, INTEGER, %Old_A_FormatInteger%
	Return HexString
}

UrlEncodeTest(string) {
    scriptlog("UrlEscape: " . UrlEscape(string))
    scriptlog("UrlUnEscape: " . UrlUnEscape(string))
    scriptlog("URIEncode: " . URIEncode(string))
    scriptlog("URI_Encode: " . URI_Encode(string))
    scriptlog("URI_EncodeComponent: " . URI_EncodeComponent(string))
}

UrlEscape( url, flags := 0 ) {      ; www.msdn.microsoft.com/en-us/library/bb773774(VS.85).aspx
    VarSetCapacity( newUrl,500,0 ), pcche := 500
    DllCall( "shlwapi\UrlEscapeA", Str,url, Str,newUrl, UIntP,pcche, UInt,flags )
    Return newUrl
}
UrlUnEscape( url, flags := 0 ) {    ; www.msdn.microsoft.com/en-us/library/bb773791(VS.85).aspx
    VarSetCapacity( newUrl,500,0 ), pcche := 500
    DllCall( "shlwapi\UrlUnescapeA", Str,url, Str,newUrl, UIntP,pcche, UInt,flags )
    Return 
}

URIEncode(str, encoding := "UTF-8") {
    VarSetCapacity(var, StrPut(str, encoding))
    StrPut(str, &var, encoding)
    urlstr:=""
    While code := NumGet(Var, A_Index - 1, "UChar")  {
        bool := (code > 0x7F || code < 0x30 || code = 0x3D)
        UrlStr .= bool ? "%" . Format("{:02X}", code) : Chr(code)
    }
    Return UrlStr
}

URI_Encode(sURI, sExcepts = "!#$&'()*+,-./:;=?@_~")
{
	if (A_PtrSize != 8) {
        ; Transform sUTF8, Unicode, %sURI%
    }
	origFmt := A_FormatInteger
	SetFormat IntegerFast, hex

	sResult := ""
	Loop
	{
		if (!(b := NumGet(sUTF8, A_Index - 1, "UChar")))
			break
		ch := Chr(b)
		if (b >= 0x41 && b <= 0x5A ; A-Z
			|| b >= 0x61 && b <= 0x7A ; a-z
			|| b >= 0x30 && b <= 0x39 ; 0-9
			|| InStr(sExcepts, Chr(b), true))
			sResult .= Chr(b)
		else
		{
			ch := SubStr(b, 3)
			if (StrLen(ch) < 2)
				ch = "0" ch
			sResult .= "%" ch
		}
	}
	SetFormat IntegerFast, %origFmt%
	return sResult
}
URI_EncodeComponent(sURI, sExcepts = "!'()*-._~")
{
	return URI_Encode(sURI, sExcepts)
}
b64Encode(string)
{
    VarSetCapacity(bin, StrPut(string, "UTF-8")) && len := StrPut(string, &bin, "UTF-8") - 1 
    if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", 0, "uint*", size))
        throw Exception("CryptBinaryToString failed", -1)
    VarSetCapacity(buf, size << 1, 0)
    if !(DllCall("crypt32\CryptBinaryToString", "ptr", &bin, "uint", len, "uint", 0x1, "ptr", &buf, "uint*", size))
        throw Exception("CryptBinaryToString failed", -1)
    return StrGet(&buf)
}

b64Decode(string)
{
    if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x1, "ptr", 0, "uint*", size, "ptr", 0, "ptr", 0))
        throw Exception("CryptStringToBinary failed", -1)
    VarSetCapacity(buf, size, 0)
    if !(DllCall("crypt32\CryptStringToBinary", "ptr", &string, "uint", 0, "uint", 0x1, "ptr", &buf, "uint*", size, "ptr", 0, "ptr", 0))
        throw Exception("CryptStringToBinary failed", -1)
    return StrGet(&buf, size, "UTF-8")
}