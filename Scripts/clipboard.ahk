#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance, Force
SetBatchLines, -1
#Include <bluscream>
#Include <asf>

FileRead, logins, % "C:\Users\blusc\Desktop\steam.json"
global logins := JSON.Load(logins)

global already_used := GetRedeemedKeys()

OnClipboardChange("ClipChanged")

Return

ClipChanged(type) {
    if (type != 1) {
        return
    }
    if (RegExMatch(clipboard, "^StartFragment")) {
        tmp := RegExReplace(clipboard, "^StartFragment", "")
        tmp := RegExReplace(tmp, "EndFragment$", "")
        tmp := RegExReplace(tmp, "\\\-", "")
        clipboard := RegExReplace(tmp, "\\\_", "")
    } else if (RegExMatch(clipboard, "mi)\\gameinfo\.txt$")) {
        clipboard := StrReplace(clipboard, "`r")
        clipboard := StrReplace(clipboard, "\gameinfo.txt")
        txt := ""
        for i, clipline in StrSplit(clipboard, "`n") {
            split := StrSplit(clipline, "\")
            txt .= """" . split[split.MaxIndex()] . """" . A_Tab . """" . clipline . """`n"
        }
        clipboard := txt
    } else if (RegExMatch(clipboard, steam_key_pattern)) {
        keys := []
        _keys := ParseSteamKeys(clipboard)
        for i, key in _keys {
            if (already_used.indexOf(key) = -1) {
               already_used.Push(key)
               keys.Push(key)
            }
        }
        key_count := keys.Count()
        if (key_count < 1) {
            return
        }
        txt := "Found " . key_count . " steam keys in your clipboard, do you want to activate them?"
        txt_keys := "`n".Join(keys)
        if (key_count > 30) {
            PasteToNotepad(txt_keys)
        } else {
            txt .= "`n`n" . txt_keys
        }
        MsgBox 0x24, % "Steam keys found", % txt, 30
        IfMsgBox Yes, {
            MsgBox, % toJson(RedeemKeys(keys))
        }
    }
}