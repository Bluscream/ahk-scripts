#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
#Include <bluscream>
#Include <Environment>

ips := []
macs := []
for objItem in ComObjGet("winmgmts:").ExecQuery("SELECT * FROM Win32_NetworkAdapterConfiguration WHERE IPEnabled = TRUE") {
    for ip in objItem.IPAddress {
        if (ip)
            ips.Push(ip)
    }
    if (objItem.MACAddress) {
        if (objItem.MACAddress)
            macs.Push(objItem.MACAddress)
    }
}
url := "http://192.168.2.38/api/ip.php?name=Timo-PC?domains=bluscream.pc,timo.pc,gaming.pc"
if (ips.MaxIndex() > 0) {
    url .= ("&ips=" . Join(",", ips))
}
if (macs.MaxIndex() > 0)  {
    url .= ("&macs=" . join(",", macs))
}
scriptlog(url)
devices := GetJson(url)

for i, dev in devices {
    Try
    {
        
        Env_UserNew("IP_" . dev.name, dev.ip)
    }
}

ExitApp
