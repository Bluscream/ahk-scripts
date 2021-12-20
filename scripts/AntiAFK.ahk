#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir

min_idle_seconds := 30 * 1000
timer_interval_seconds := 5 * 1000
sleep_between_moves_ms := 0


SetTimer, runChecks, % timer_interval_seconds

runChecks() {
    if (A_TimeIdle > min_idle_seconds) {
        MouseGetPos, OldX, OldY
        MouseMove, OldX+1, OldY
        Sleep, % sleep_between_moves_ms
        MouseMove, OldX, OldY
    }
}