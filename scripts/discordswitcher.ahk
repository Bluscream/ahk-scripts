#Include <bluscream>
; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-winclose-ahk
; Big thanks to Dinenon#8239
#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir

Loop {
    Process, wait, Discord.exe
    
    
}