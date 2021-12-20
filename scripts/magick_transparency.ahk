#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1
DetectHiddenWindows On
global noui := false
#Include <bluscream>
scriptlog(A_ScriptFullPath . " " .  Join(" ", A_Args))

magick := new File("C:\Program Files\ImageMagick-7.1.0-Q16-HDRI\magick.exe")

for n, param in A_Args
{
    _file := 
}

Return



convert %FILEPATHS% -alpha set -background none -channel A -evaluate multiply @Transparency@ +channel "%PARENTPATH%\transparent\<*%FILENAMES%;^";>