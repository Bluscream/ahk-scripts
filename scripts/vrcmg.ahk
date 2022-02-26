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
global ModURLRegex := "((?:http(?:s)?:\/\/)?api\.vrcmg\.com\/v0\/(\w+)\/(\d+)\/((.+)\.dll))"
return
; 0-58	https://api.vrcmg.com/v0/PRE_mods/231/VRChatUtilityKit.dll
; 25-33	PRE_mods
; 34-37	231
; 38-58	VRChatUtilityKit.dll
; 38-54	VRChatUtilityKit

ClipChanged(Type) {
   If !(Type = 1) Or !Clipboard_HasText()
      Return
   ClipAlt := Trim(Clipboard_GetText())
   Match := RegExMatch(ClipAlt, ModURLRegex, Groups)
   if Match {
        out := "G:\Steam\steamapps\common\VRChat\Mods\" . Groups4
        scriptlog("Downloading " . Groups2 . ": " . Groups5 . " (#" . Groups3 . ") to " . out)
        Msgbox 4, % "VRCMG Mod Downloader", % "[" . Groups2 . "] Are you sure you want to download " . Groups5 . "?"
        IfMsgBox No
            Return
        UrlDownloadToFile, % Groups1, % out
        scriptlog("Finished downloading " . Groups1)
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