#Persistent
#NoEnv
#SingleInstance, force
SetBatchLines, -1

SetWallpaper("D:\Pictures\bliss.png")

return
SetTimer, CheckWallpaperEngine, 1000 ; Check every second
return

CheckWallpaperEngine:
if !ProcessExist("WallpaperEngine.exe") ; If Wallpaper Engine is not running
{
    
    SetDesktopColor(0, 0, 0) ; Set the desktop background to black
    ExitApp ; Exit the script
}
return

ProcessExist(Name) {
    Process, Exist, %Name%
    return ErrorLevel
}

SetDesktopColor(R, G, B) {
    COLOR_DESKTOP := 1
    DllCall("SetSysColors", "Int", 1, "Int*", COLOR_DESKTOP, "UInt*", (R << 16) | (G << 8) | B)
}
SetWallpaper(WallpaperFile) {
    DllCall("SystemParametersInfo", "Uint", 20, "Uint", 0, "Str", WallpaperFile, "Uint", 2)
}