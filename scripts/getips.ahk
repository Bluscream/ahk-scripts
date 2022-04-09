#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
#Include <bluscream>
#Include <Environment>

url := "http://192.168.2.38/api/ip.php?device="
devices := [ "Timo-Tablet","Timo-Handy" ]

for i, dev in devices {
    url_ := url . dev
    Try
    {
        res := GetString(url_)
        ; dev := StrReplace(dev, "-" , "_")
        Env_UserNew("IP_" . dev, res)
    }
}

ExitApp
