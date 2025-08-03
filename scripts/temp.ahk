#NoEnv
#Persistent
OnClipboardChange("ClipChanged")
return

ClipChanged(Type) {
    if (Type = 1) {  ; Text was copied
        if InStr(Clipboard, "grayjay://plugin/") {
            Clipboard := StrReplace(Clipboard, "grayjay://plugin/", "")
        }
    }
}