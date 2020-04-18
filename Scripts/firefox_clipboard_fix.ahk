#Persistent
OnClipboardChange("ClipChanged")
return

ClipChanged(Type) {
    clipboard := RegExReplace(clipboard, "^StartFragment", "")
    clipboard := RegExReplace(clipboard, "EndFragment$", "")
    clipboard := RegExReplace(clipboard, "\\\-", "")
    clipboard := RegExReplace(clipboard, "\\\_", "")
}