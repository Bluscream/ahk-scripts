#Include <bluscream>
#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

; MsgBox,,, powershell "%A_ScriptDir%\release.ps1"
; Return

Scripts := Array()
Loop, Scripts\*.ahk
{
      Scripts.Push(A_LoopFileLongPath)
}
Binaries := ""
Loop % Scripts.Length() {
    script := Scripts[A_Index]
    scriptlog("Compiling " . script)
    SplitPath, script, binary
    binary := StrReplace(binary, ".ahk" , ".exe")
    binary := "C:\Program Files\AutoHotkey\Scripts\bin\" . binary
    scriptlog("Into " . binary)
    RunWait, C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe /in "%script%" /out "%binary%" /mpress 0
    Binaries .= binary . "|"
}

RunWaitOne("git add .")
FormatTime, commit,, MM/dd/yy hh:mm:ss
RunWaitOne("git commit -m ""UPDATE " . commit . "")
RunWaitOne("git push")
gitlog := RunWaitOne("git log", false)
; MsgBox % gitlog

StringTrimRight, Binaries, Binaries, 1
EnvGet, GitHubToken, GitHubToken
FormatTime, tag,, MM\dd\yyyy
cmd := "Powershell.exe -NoExit -Command &{" . A_ScriptDir . "\release.ps1}"
params := "-token " . GitHubToken . " -tag '" . tag . "' -name '" . tag . "' -descr 'Release created with AutoHotKey and Powershell' -user 'Bluscream' -project 'ahk-scripts' -file '" . Binaries . "'"
scriptlog("trying " . cmd)
Run %cmd% %params%

Return

RunWaitOne(command, print := true) {
    shell := ComObjCreate("WScript.Shell")
    exec := shell.Exec(ComSpec " /C " command)
    result := exec.StdOut.ReadAll()
    if (print)
        scriptlog(command . ": " . result)
    return result
}