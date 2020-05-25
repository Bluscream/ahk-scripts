; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-copywrite-ahk
#Persistent
#NoTrayIcon
#NoEnv
SetBatchLines, -1
Process, Priority,, High
SendMode Input

OnClipboardChange("ClipChanged")
return

ClipChanged(Type) {
    if (RegExMatch(clipboard, "^StartFragment")) {
        clipboard := RegExReplace(clipboard, "^StartFragment", "")
        clipboard := RegExReplace(clipboard, "EndFragment$", "")
        clipboard := RegExReplace(clipboard, "\\\-", "")
        clipboard := RegExReplace(clipboard, "\\\_", "")
    }
    else if (RegExMatch(clipboard, "mi)\\gameinfo\.txt$")) {
        clipboard := StrReplace(clipboard, "`r")
        clipboard := StrReplace(clipboard, "\gameinfo.txt")
        txt := ""
        for i, clipline in StrSplit(clipboard, "`n") {
            split := StrSplit(clipline, "\")
            txt .= """" . split[split.MaxIndex()] . """" . A_Tab . """" . clipline . """`n"
        }
        clipboard := txt
    }
}

^b::
	Send {Raw}%Clipboard%
	return