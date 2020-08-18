#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance, Force
SetBatchLines, -1
#Include <bluscream>
#Include <asf>

global asf := new ASF()
global already_used := asf.getAllRedeemedKeys()

OnClipboardChange("ClipChanged")

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
    } else if (RegExMatch(clipboard, asf.steam_key_pattern)) {
        keys := []
        _keys := asf.parseSteamKeys(clipboard)
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
        use_main := GetKeyState("Shift", "P")
        IfMsgBox, Yes, {
            MsgBox, % toJson((use_main ? asf.getbot("bluscream").redeemKeysNow(keys) : asf.redeemKeys(keys)), true)
        }
    }
}