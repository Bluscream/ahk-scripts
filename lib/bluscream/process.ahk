class Process {
    name := ""
    file := new File()

    __New(name := "") {
        this.name := name
        winmgmts := this.winmgmts()
        if (winmgmts && winmgmts.ExecutablePath)
            this.file := new File(winmgmts.ExecutablePath)
    }
    wait() {
        Process, Wait, % this.name
    }
    fromPid(pid := 0) {
        return new Process(this.winmgmts(pid).Name)
    }
    fromFile(file) {
        proc := new Process()
        proc.file := file
        proc.name := file.fullname
        return proc
    }
    exists() {
        Process, Exist, % this.name
        return ErrorLevel
    }
    getPid() {
        WinGet, pid, PID, % "ahk_exe " . this.name
        return pid
    }
    winmgmts(pid := 0) {
        cmd := "Select * from Win32_Process where ProcessId=" . (pid ? pid : this.getPid())
        for item in ComObjGet("winmgmts:").ExecQuery(cmd) {
            this.winmgmts := item
            return item
        }
        return 0
    }
    commandLine() {
        if (!this.exists())
            return ""
        StringReplace Parameters, % winmgmts.CommandLine, % winmgmts.ExecutablePath
        StringReplace Parameters, Parameters, ""
        return Trim(Parameters)
    }
    close() {
        if (this.exists()) {
            Process, Close, % this.name
            return !this.exists()
        }
    }
    kill(force := true, wait := false) {
        ; if (this.exists()) {
            cmd := """" . A_ComSpec . """ /c taskkill " . (force ? "/f" : "") . " /im " . this.name
            OutputDebug, % cmd
            if (wait) {
                RunWait % cmd,,Hide, vPid
                return !this.exists()
            }
            Run % cmd,,Hide
        ; }
    }
    str() {
        return this.name
    }
}