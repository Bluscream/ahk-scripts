#Include <bluscream>
#SingleInstance Force
#NoEnv
#Persistent
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

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
    RunWait, C:\Program Files\AutoHotkey\Compiler\Ahk2Exe.exe /in "%script%" /out "%binary%" /mpress 1
    Binaries .= binary . "|"
}

scriptlog("")
RunWait, git add .
FormatTime, commit,, MM\dd\yy hh:mm:ss
RunWait, git commit -m "UPDATE %commit%"
RunWait, git push
log := RunWaitOne("git log")
scriptlog(log)

StringTrimRight, Binaries, Binaries, 1
EnvGet, GitHubToken, GitHubToken
FormatTime, tag,, MM\dd\yyyy
RunWait, powershell release.ps1 -token %GitHubToken% -tag '%tag%' -name '%name%' -descr 'Release created with AutoHotKey and Powershell' -user 'Bluscream' -project 'ahk-scripts' -file '%Binaries%'

Return

RunWaitOne(command) {
    shell := ComObjCreate("WScript.Shell")
    exec := shell.Exec(ComSpec " /C " command)
    return exec.StdOut.ReadAll()
}