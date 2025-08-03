EnvGet, localappdata, % "LOCALAPPDATA"
EnvGet, userprofile, % "USERPROFILE"

class Paths {
    class User {
        name := A_UserName                   ; blusc
        userprofile := new Directory(userprofile)
        appdata := new Directory(A_AppData)           ; C:\Users\blusc\AppData\Roaming
        localappdata := new Directory(localappdata)   ; C:\Users\blusc\AppData\Local
        locallowappdata := new Directory(StrReplace(localappdata, "\Local", "\LocalLow"))   ; C:\Users\blusc\AppData\LocalLow
        temp := new Directory(A_Temp)                 ; C:\Users\blusc\AppData\Local\Temp
        desktop := new Directory(A_Desktop)           ; C:\Users\blusc\Desktop
        startmenu := new Directory(A_StartMenu)       ; C:\Users\blusc\AppData\Roaming\Microsoft\Windows\Start Menu
        programs := new Directory(A_Programs)         ; C:\Users\blusc\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
        startup := new Directory(A_Startup)           ; C:\Users\blusc\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup
        documents := new Directory(A_MyDocuments)     ; C:\Users\blusc\Documents
    }
    class Public {
        desktop := new Directory(A_DesktopCommon)     ; C:\Users\Public\Desktop
        startmenu := new Directory(A_StartMenuCommon) ; C:\ProgramData\Microsoft\Windows\Start Menu
        programs := new Directory(A_ProgramsCommon)   ; C:\ProgramData\Microsoft\Windows\Start Menu\Programs
        startup := new Directory(A_StartupCommon)     ; C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Startup
    }
    ahk := new File(A_AhkPath)                         ; C:\Program Files\AutoHotkey\AutoHotkey.exe
    network := "\\" . A_ComputerName . "\"
    scriptdir := new Directory(A_ScriptDir)           ; C:\Program Files\AutoHotKey\AutoGUI\Tools
    scriptname := A_ScriptName         ; A_Variables.ahk
    scriptpath := new File(A_ScriptFullPath)     ; C:\Program Files\AutoHotKey\AutoGUI\Tools\A_Variables.ahk
    linefile := new File(A_LineFile)             ; C:\Program Files\AutoHotKey\AutoGUI\Tools\A_Variables.ahk
    windir := new Directory(A_WinDir)                 ; C:\WINDOWS
    programfiles := new Directory(A_ProgramFiles)     ; C:\Program Files
    programdata := new Directory(A_AppDataCommon)     ; C:\ProgramData
    cmd := new File(A_ComSpec)                   ; C:\WINDOWS\system32\cmd.exe
}