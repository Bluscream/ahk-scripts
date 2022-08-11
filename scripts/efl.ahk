
#SingleInstance force
; win := new Window()
winstr2 := "Files & Folders Setting ahk_class #32770 ahk_exe FileLocker.exe"
winstr := "Browse for Folder ahk_class #32770 ahk_exe FileLocker.exe"
Run % "C:\Program Files\Easy File Locker\FileLocker.exe"
while (True) {
    Sleep, 500
    WinWait, % winstr
    WinClose, % winstr
    FileSelectFolder, dir, ::{20d04fe0-3aea-1069-a2d8-08002b30309d}, 7
    ControlSetText, Edit1, % dir, % winstr2
    Sleep, 500
}

; ControlClick, Edit1, % winstr, WinText, WhichButton, ClickCount, Options, ExcludeTitle, ExcludeText]
; ControlSend, Edit1, Keys, WinTitle, WinText, ExcludeTitle, ExcludeText]

return

; OK
; Cancel
; &Path:
; This file or folder will be:
; &Accessible
; &Writable
; &Deletable
; &Visible