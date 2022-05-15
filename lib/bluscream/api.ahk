#Include <bluscream/uri>
SendIRCommand(device, action , repeat := 5) {
    if (!InStr(device, "%")) {
        _device := URIEncode(device)
        scriptlog("device: " . device . " => " . _device)
        device := _device
    }
    if (!InStr(action, "%")) {
        _action := URIEncode(action)
        scriptlog("action: " . action . " => " . _action)
        action := _action
    }
    new Url("https://minopia.de/api/ir.php?device=" . device . "&action=" . action . "&repeat=" . repeat).visit("GET", "", "", true)
}