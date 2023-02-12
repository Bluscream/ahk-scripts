#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
#Include <bluscream>
#Include <Environment>

urls := [ "http://192.168.2.38", "http://192.168.2.39", "http://home.server", "http://minopia.de", "https://minopia.de" ]

GetFromServer(endpoint) {
    response := False
    for url in urls {
        Try {
            response := GetJson(url . endpoint)
            if (response) {
                return response
            }
        }
        if (response) {
            return response
        }
    }
    if (response) {
        return response
    }
    ExitApp
}

ips := []
macs := []
for objItem in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = TRUE") {
    for ip in objItem.IPAddress {
        if (ip)
            ips.Push(ip)
    }
    if (objItem.MACAddress) {
        if (objItem.MACAddress) ; ?
            macs.Push(objItem.MACAddress)
    }
}
url := "/api/ip.php?name=Timo-PC&domains=bluscream.pc,timo.pc,gaming.pc"
if (ips.MaxIndex() > 0) {
    url .= ("&ips=" . Join(",", ips))
}
if (macs.MaxIndex() > 0)  {
    url .= ("&macs=" . join(",", macs))
}
devices := []
; ShowToolTip(url)
Try {
    GetFromServer(url)
    devices := GetFromServer("/api/devices.json")
}
; scriptlog(toJson(devices, True))

for i, dev in devices {
    Try
    {
        if (dev.name != "" and dev.ip != "") {
            Env_UserNew(Format("IP_{:U}", StrReplace(dev.name, "-", "_")), dev.ip)
        }
    }
}
ExitApp
