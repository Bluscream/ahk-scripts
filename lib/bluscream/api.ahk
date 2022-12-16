#Include <bluscream/uri>
SendIRCommand(device, action , repeat := 5) {
    if (!InStr(device, "%")) {
        _device := URIEncode(device)
        ; scriptlog("URIEncode device: " . device . " => " . _device)
        device := _device
    }
    if (!InStr(action, "%")) {
        _action := URIEncode(action)
        ; scriptlog("URIEncode action: " . action . " => " . _action)
        action := _action
    }
    uri := new Url("http://minopia.de/api/ir.php?device=" . device . "&action=" . action . "&repeat=" . repeat)
    if (!no_ui) {
        scriptlog(uri.str())
    }
    uri.visit("GET", "", "", true)
}