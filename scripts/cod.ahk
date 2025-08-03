#NoEnv
#SingleInstance Force
#Persistent

#Include <bluscream>

SetDefaultMouseSpeed, 50
SendMode InputThenPlay

gamewindow := get_game_window()
OutputDebug, % """" . gamewindow . """"

findmatchbuttonpos := [290, 859]
findmatchbuttoncolor := "0C1E23"

F8:: Click, findmatchbuttonpos[1], findmatchbuttonpos[2]

return

get_game_window() {
    title := "Call of Duty"
    class := "COD"
    exe := "cod.exe"
    WinGet, id, List
    Loop, %id%
    {
        this_id := id%A_Index%
        WinGetTitle, this_title, ahk_id %this_id%
        WinGetClass, this_class, ahk_id %this_id%
        WinGet, this_exe, ProcessName, ahk_id %this_id%
        if (InStr(clean_str(this_title), clean_str(title)) & InStr(clean_str(this_class), clean_str(class))) {
            return this_id
        }
    }
}

clean_str(str) {
    return StrReplace(str, Chr(0x200B), "")
}