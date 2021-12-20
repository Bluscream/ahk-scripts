#Persistent
#NoTrayIcon
#NoEnv
#SingleInstance, force
SetBatchLines, -1
Process, Priority,, High
#Include <bluscream>
EnforceAdmin()
return

<#c::
    Run cmd
    return
<#p::
    Run powershell
    return
<#e::
    if (!explorer())
        Run explorer
    return
^+Esc::
    if (!explorer())
        Run taskmgr
    return


explorer() {
    return Process.Exist("explorer.exe")
}