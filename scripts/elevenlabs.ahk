#NoEnv
#SingleInstance, Force
#Persistent
#Include <bluscream>
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

global no_ui := false
global isConverting := false ; Initialize the global flag as false

scriptlog("start")
SetTimer, CheckFiles, 5000 ; Check every 5 seconds
return

CheckFiles:
    global isConverting
    if (isConverting)
        return
    FilePattern := "D:\\Downloads\\ElevenLabs_*.mp3"
    Loop, %FilePattern%
    {
        if (A_LoopFileAttrib ~= "A") ; Check if not converting and the file is ready
        {
            mp3FilePath := A_LoopFileLongPath
            scriptlog("Found File: " . mp3FilePath)
            wavFilePath := "C:\\Users\\blusc\\Desktop\\femboy sounds\\" . A_LoopFileName . ".wav"
            scriptlog("Converting to: " . wavFilePath)
            
            isConverting := true ; Set the flag to true indicating a conversion is in progress
            ; Convert MP3 to WAV using FFmpeg
            RunWait, % ComSpec . " /c ffmpeg -i """ mp3FilePath """ """ wavFilePath """", , Hide
            scriptlog("Converted to: " . wavFilePath)
            
            ; Delete the original MP3 file
            FileDelete, % mp3FilePath
            scriptlog("Deleted: " . mp3FilePath)
        }
    }
    isConverting := false ; Reset the flag after conversion is done
    return

scriptlog("end")