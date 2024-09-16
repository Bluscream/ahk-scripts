#NoEnv
#SingleInstance, Force
#Persistent
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%
; OutputDebug DBGVIEWCLEAR

#Include <logtail>
#Include <bluscream>

global no_ui := false
scriptlog("bbr.ahk::start")

global net_log_path := "H:\WSCC\Apps\x64\cports.log"
; global net_ref_keys:=["prefix","Added_On","State","Protocol","Local_Address","Local_Port","Local_Port_Name","Remote_Address","Remote_Port","Remote_Port_Name","Remote_Host_Name","Remote_IPCountry","Process_Created_On","Process_ID","Process_Name","Process_Path","Process_Services","Process_Attributes","Window_Title","Product_Name","File_Description","File_Version","Company","Module_Filename","User_Name"]
;                                 ;"%Added_On%";"%State%";"%Protocol%";"%Local_Address%";"%Local_Port%";"%Local_Port_Name%";"%Remote_Address%";"%Remote_Port%";"%Remote_Port_Name%";"%Remote_Host_Name%";"%Remote_IP Country%";"%Process_Created_On%";"%Process_ID%";"%Process_Name%";"%Process_Path%";"%Process_Services%";"%Process_Attributes%";"%Window_Title%";"%Product_Name%";"%File_Description%";"%File_Version%";"%Company%";"%Module_Filename%";"%User_Name%";
global net_process_name := "BattleBit.exe"

global log_path := "C:\Users\blusc\AppData\LocalLow\BattleBitDevTeam\BattleBit\Player.log"
global title := "BattleBit Remastered"
global icon := "G:\SteamLibrary\steamapps\common\BattleBit Remastered\IconGroup103.ico"
Menu, Tray, Icon, % icon

; global last_join_addr := ""

lt := new LogTailer(log_path, Func("OnNewLine"), true)
lt := new LogTailer(net_log_path, Func("OnNewNetLine"), true)
ShowToast(title, "AutoHotkey", icon, "topleft", 5)
scriptlog("bbr.ahk::end")
return

Toast(message, _title := "BattleBit Remastered", time_seconds := 10) {
    global icon, title
    if (_title == "")
        _title := title
    ShowToast(message, _title, icon, "topleft", time_seconds)
  ; ShowToast(message, title := "AutoHotkey", icon_path := "toast.bmp", position := "topleft", time_seconds := 10, bg_color := "#222222")
}

OnNewNetLine(line) {
    global net_process_name
    ; Define the reference keys

    ; Split the input string
    splitInput := StrSplit(line, ";")
    
    ProcessName := splitInput[15]
    if (ProcessName != net_process_name)
        return

    ; AddedOn := splitInput[2]
    State := splitInput[3]
    if (State != "Established")
        return
    Protocol := splitInput[4]
    if (Protocol != "UDP")
        return
    ; LocalAddress := splitInput[5]
    ; LocalPort := splitInput[6]
    ; LocalPortName := splitInput[7]
    RemoteAddress := splitInput[8]
    RemotePort := splitInput[9]
    ; RemotePortName := splitInput[10]
    RemoteHostName := splitInput[11]
    RemoteIPCountry := splitInput[12]

    scriptlog("New connection to " . RemoteAddress . ":" . RemotePort . " (" . RemoteHostName . " / " . RemoteIPCountry . ")")
    Toast(RemoteAddress . ":" . RemotePort, RemoteIPCountry)

    ; ProcessCreated_On := splitInput[13]
    ; ProcessID := splitInput[14]
    ; ProcessPath := splitInput[16]
    ; ProcessServices := splitInput[17]
    ; ProcessAttributes := splitInput[18]
    ; WindowTitle := splitInput[19]
    ; ProductName := splitInput[20]
    ; FileDescription := splitInput[21]
    ; FileVersion := splitInput[22]
    ; Company := splitInput[23]
    ; ModuleFilename := splitInput[24]
    ; UserName := splitInput[25]
    ; prefix := splitInput[1]
    ; suffix := splitInput[26]

    ; scriptlog("Prefix: " . prefix)
    ; scriptlog("Added On: " . AddedOn)
    ; scriptlog("State: " . State)
    ; scriptlog("Protocol: " . Protocol)
    ; scriptlog("Local Address: " . LocalAddress)
    ; scriptlog("Local Port: " . LocalPort)
    ; scriptlog("Local Port Name: " . LocalPortName)
    ; scriptlog("Remote Address: " . RemoteAddress)
    ; scriptlog("Remote Port: " . RemotePort)
    ; scriptlog("Remote Port Name: " . RemotePortName)
    ; scriptlog("Remote Host Name: " . RemoteHostName)
    ; scriptlog("Remote IP Country: " . RemoteIPCountry)
    ; scriptlog("Process Created On: " . ProcessCreated_On)
    ; scriptlog("Process ID: " . ProcessID)
    ; scriptlog("Process Name: " . ProcessName)
    ; scriptlog("Process Path: " . ProcessPath)
    ; scriptlog("Process Services: " . ProcessServices)
    ; scriptlog("Process Attributes: " . ProcessAttributes)
    ; scriptlog("Window Title: " . WindowTitle)
    ; scriptlog("Product Name: " . ProductName)
    ; scriptlog("File Description: " . FileDescription)
    ; scriptlog("File Version: " . FileVersion)
    ; scriptlog("Company: " . Company)
    ; scriptlog("Module Filename: " . ModuleFilename)
    ; scriptlog("User Name: " . UserName)
    ; scriptlog("Suffix: " . suffix)
}

OnNewLine(line){
    ; global last_join_addr

    res := CheckLine(line, "Build: (.*)") ; Initialize engine version: (.*) \(.*\)")
    if (res.Count() > 0) {
        Toast("Started: " . res[1])
        return
    }

    res := CheckLine(line, "Received: SlotReserving_ServerFull")
    if (res.Count() > 0) {
        Toast("Failed to connect", "Server is full")
        return
    }

    res := CheckLine(line, "Received: SlotReserving_WrongPassword")
    if (res.Count() > 0) {
        Toast("Failed to connect", "Wrong Password")
        return
    }

    res := CheckLine(line, "Received: SlotReserving_SlotReserved")
    if (res.Count() > 0) {
        Toast("Joined Server")
        return
    }

    res := CheckLine(line, "UserInterface.PauseMenu.PauseMenu:DisconnectFull()")
    if (res.Count() > 0) {
        Toast("Disconnected")
        return
    }

    res := CheckLine(line, "Application is closing now !")
    if (res.Count() > 0) {
        Toast("Exiting")
        return
    }
    
}
CheckLine(inputStr, pattern) {
    result := []
    if RegExMatch(inputStr, "O)" . pattern, matches) {
        Loop, % matches.Count() {
            result.Push(matches.Value(A_Index))
        }
    }
    return result
}
