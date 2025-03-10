#NoEnv
#Persistent
#SingleInstance, Force
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

#Include <powerprofile>
profiles := new PowerProfiles()

Menu, Tray, NoStandard
icon_file := A_WinDir . "\system32\powrprof.dll"
if FileExist(icon_file) {
    Menu, Tray, Icon, % icon_file, 4
}

UpdateTrayMenu()
return

UpdateTrayMenu() {
    global profiles
    activeProfile := profiles.GetActive()
    
    Menu, Tray, DeleteAll

    for _, arg in A_Args {
        if (arg = "/extra") {
            Menu, Tray, Add, Reload, MenuHandler
            Menu, Tray, Add, Exit, MenuHandler
            Menu, Tray, Add
        }
    }

    OutputDebug, % "Found " . profiles.profiles.Count() . " power profiles"
    
    for id, profile in profiles.profiles {
        isActive := profile.IsActive()

        OutputDebug, % "Profile: " . id . "`tActive: " . isActive
            . "`n`tName: " . profile.name
            . "`n`tDescription: " . profile.description
            ; . "`n`tIcon: " . profile.icon

        Menu, Tray, Add, % profile.name, MenuHandler, ; +Radio +Right
        ; icon := profile.GetIcon()
        ; if FileExist(icon[1]) {
        ;     OutputDebug, % "Setting icon for " . profile.name . " from " . icon[1] . ", " . icon[2]
        ;     Menu, Tray, Icon, % profile.name, % icon[1], -512, 20 ; % icon[2] ; , 16
        ; }
        if (isActive)
            Menu, Tray, Check, % profile.name
    }
}

MenuHandler:
    if (A_ThisMenuItem = "Exit") {
        ExitApp
    } else if (A_ThisMenuItem = "Reload") {
        Reload
    } else {
        ; Find and activate the selected profile
        if (profile := profiles.GetByName(A_ThisMenuItem)) {
            profile.SetActive()
            UpdateTrayMenu()
        }
    }
    return