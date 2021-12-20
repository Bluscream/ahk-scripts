#Include <bluscream>

#SingleInstance, Force
#NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
;
global pattern := "((?![^0-9]{12,}|[^A-z]{12,})([A-z0-9]{4,5}-?[A-z0-9]{4,5}-?[A-z0-9]{4,5}(-?[A-z0-9]{4,5}(-?[A-z0-9]{4,5})?)?))"
global lastclip := ""
OnClipboardChange("ClipChanged")
return

ClipChanged(Type) {
    global lastclip
    global pattern
    if (clipboard == lastclip) Return
    lastclip := clipboard
    RegExMatch(clipboard, , key)
    While (Pos := RegExMatch(Str, pattern, M, Pos + StrLen(M))) ;
    ; if (key == "") Return
        MsgBox % M1
}