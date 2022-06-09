; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-copywrite-ahk
#Persistent
; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, Low
#Include <bluscream>
; EnforceAdmin()
global noui = false
; SendMode, Event ; |Play|Input|InputThenPlay
; SetKeyDelay, 50, 50
OnClipboardChange("ClipChanged", -1)
global ClipAlt := ""
return

ClipChanged(Type) {
   ; scriptlog("ClipChanged?type=" . Type . "&hastext=" . Clipboard_HasText())
   If (!(Type = 1) and !Clipboard_HasText()) {
      Return
   }
   Clip := Trim(Clipboard)
   if (if Clip is space) {
      Clip := Trim(Clipboard_GetText())
   }
   if (ClipAlt == Clip) {
      Return
   }
   ; scriptlog("ClipAlt: " + ClipAlt)
   Clip := StrReplace(Clip, "apt-get", "aptitude")
   if (startsWith(Clip, "aptitude")) {
      if (!startsWith(Clip, "sudo ")) {
         Clip := "sudo " . Clip
      }
      if ("-y" not in Clip) {
         Clip := Clip . " -y"
      }
      Clip := Trim(Clip)
   }
   if (Clipboard != Clip) {
      Clipboard := Clip
   }
   ClipAlt := Clipboard
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