
CommandLine := DllCall("GetCommandLine", "Str")

If !(A_IsAdmin || RegExMatch(CommandLine, " /restart(?!\S)")) {
    Try {
        If (A_IsCompiled) {
            Run *RunAs "%A_ScriptFullPath%" /restart
        } Else {
            Run *RunAs "%A_AhkPath%" /restart "%A_ScriptFullPath%"
        }
    }
    ExitApp
}
#Include <bluscream>
#SingleInstance Force
; #NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

compile := false

; MsgBox,,, powershell "%A_ScriptDir%\release.ps1"
; Return
Scripts := Array()
Loop, Scripts\*.ahk
{
      Scripts.Push(A_LoopFileLongPath)
}
Loop, *.ahk
{
      Scripts.Push(A_LoopFileLongPath)
}
; Binaries := ""
scripts_count := Scripts.Length()
if (compile) {
    Loop % scripts_count {
        script := Scripts[A_Index]
        scriptlog("Compiling " . script)
        SplitPath, script, binary
        binary := StrReplace(binary, ".ahk" , ".exe")
        binary := "C:\Program Files\AutoHotkey\Scripts\bin\" . binary
        scriptlog("Into " . binary)
        RunWait, C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe /in "%script%" /out "%binary%" /mpress 1
        ; binary := StrReplace(binary, " " , "`` ")
        ; Binaries .= binary . "|"
    }
} else {
    scriptlog("Skipped compilation of " . scripts_count . " scripts!")
}

RunWaitOne("git add .")
FormatTime, commit,, MM/dd/yy hh:mm:ss
RunWaitOne("git commit -m ""UPDATE " . commit . "")
RunWaitOne("git push")
RunWaitOne("git remote -v")
scriptlog("Pushed to origin/master")
scriptlog("https://github.com/bluscream/commits/master")
WaitForKey("Finished, you can close this window now or ", "Enter")
RunWaitOne("git log") ; gitlog := 
; MsgBox % gitlog
WaitForKey("", "Enter")
ExitApp

StringTrimRight, Binaries, Binaries, 1
EnvGet, GitHubToken, GitHubToken
FormatTime, tag,, MM/dd/yyyy
dir := StrReplace(A_ScriptDir, " " , "`` ")
cmd := "Powershell.exe -NoExit -Command """ . dir . "\release.ps1"""
params := "-token " . GitHubToken . " -tag '" . tag . "' -name '" . tag . "' -descr 'Release created with AutoHotKey and Powershell' -user 'Bluscream' -project 'ahk-scripts'" ;  -file '" . Binaries . "'
command := cmd . " " . params
scriptlog(command)
Run %cmd%
scriptlog("Finished Releases")

RunWaitOne(command, print := true) {
    shell := ComObjCreate("WScript.Shell")
    if (print)
        scriptlog("Executing """ . command . """: ", "inline")
    exec := shell.Exec(ComSpec " /C " command)
    result := exec.StdOut.ReadAll()
    if (print)
        scriptlog(result . "`r`n", "append")
    return result
}