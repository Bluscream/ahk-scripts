; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-copywrite-ahk
#Persistent
; #NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
SendMode, Event ; |Play|Input|InputThenPlay
; SetKeyDelay, 50, 50
OnClipboardChange("ClipChanged", -1)
global ClipAlt := ""
return

ClipChanged(Type) {
   If !(Type = 1) Or !Clipboard_HasText()
      Return
   ClipAlt := Trim(Clipboard_GetText())
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

^b::
	SendRaw % ClipAlt
	Return