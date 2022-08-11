; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-copywrite-ahk
#Persistent
; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
; EnforceAdmin()
global noui = false
SendMode, Event ; |Play|Input|InputThenPlay
; SetKeyDelay, 50, 50
OnClipboardChange("ClipChanged", -1)
global ClipAlt := ""
; global ModURLRegex := "(?<url>(?:http(?:s)?:\/\/)?api\.vrcmg\.com\/v0\/(?<type>\w+)\/(?<id>\d+)\/(?<file>(?<filename>.+)\.dll))"
; global ModURLRegex := "((?:http(?:s)?:\/\/)?api\.vrcmg\.com\/v0\/(\w+)\/(\d+)\/((.+)\.dll))"
global ModURLRegex := "((?:http(?:s)?:\/\/).*\/(.+)\.dll)"
global URLRegex := "((?:http(?:s)?:\/\/).*\/(.+))"
return
; https://api.vrcmg.com/v0/PRE_mods/246/ReModCE.Loader.dll
; 0-58	https://api.vrcmg.com/v0/PRE_mods/231/VRChatUtilityKit.dll
; 25-33	PRE_mods
; 34-37	231
; 38-58	VRChatUtilityKit.dll
; 38-54	VRChatUtilityKit

DownloadMod(folder, _url) {
   dl := new Url(_url)
   scriptlog(toJson(dl, true))
   response := dl.get()
   scriptlog(toJson(response, true))
   scriptlog(toJson(response.Status, true))
   scriptlog(toJson(response.StatusText, true))
   scriptlog(toJson(response.GetResponseHeader("date"), true))
   ; scriptlog(toJson(response.GetResponseHeader("location"), true))
   headers := getResponseHeaders(response)
   scriptlog(toJson(headers, true))
   ; dl.download(folder, )
}

ClipChanged(Type) {
   ; scriptlog("ClipChanged?type=" . Type . "&hastext=" . Clipboard_HasText())
   If !(Type = 1) and !Clipboard_HasText() {
      Return
   }
   Clip := Clipboard
   if (if Clip is space) {
      Clip := Trim(Clipboard_GetText())
   }
   ; scriptlog("ClipAlt: " + ClipAlt)
   Match := RegExMatch(Clip, ModURLRegex, Groups)
   if Match {
       if (InStr(Clip, "vrcmg")) {
        out := "G:\Steam\steamapps\common\VRChat\Mods\" . Groups2 . ".dll"
       } else if (InStr(Clip, "cvrmg")) {
        out := "S:\Steam\steamapps\common\ChilloutVR\Mods\" . Groups2 . ".dll"
       }
        scriptlog("Downloading " . Groups1 . ": " . Groups2 . " to " . out)
        Msgbox 4, % "VRCMG Mod Downloader", % "Are you sure you want to download " . Groups2 . "?"
        IfMsgBox No
            Return
        UrlDownloadToFile, % Groups1, % out
        scriptlog("Finished downloading " . Groups1)
   } else if (startsWith(Clip, "https://api.cvrmg.com/v1/mods/download/")) {
      Match := RegExMatch(Clip, URLRegex, Groups)
      DownloadMod("S:\Steam\steamapps\common\ChilloutVR\Mods", Groups1)
   }
}
; -------------------------------------------
Clipboard_HasText() {
   Static CF_NATIVETEXT := A_IsUnicode ? 13 : 1 ; CF_UNICODETEXT = 13, CF_TEXT = 1
   Return DllCall("IsClipboardFormatAvailable", "UInt", CF_NATIVETEXT, "UInt")
}
; -------------------------------------------
Clipboard_GetText() {
   Static CF_NATIVETEXT := A_IsUnicode ? 13 : 1 ; CF_UNICODETEXT = 13, CF_TEXT = 1
   ClipText := ""
   If DllCall("OpenClipboard", "Ptr", 0, "UInt") {
      If (HMEM := DllCall("GetClipboardData", "UInt", CF_NATIVETEXT, "UPtr")) {
         Chrs := DllCall("GlobalSize", "Ptr", HMEM, "Ptr") >> !!A_IsUnicode
         If (PMEM := DllCall("GlobalLock", "Ptr", HMEM, "UPtr")) {
            ClipText := StrGet(PMEM, Chrs)
            DllCall("GlobalUnlock", "Ptr", HMEM)
         }
      }
      DllCall("CloseClipboard")
   }
   Return ClipText
}