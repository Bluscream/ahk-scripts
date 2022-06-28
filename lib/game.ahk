#Include <bluscream>
#Include <steam>
; #Include <logtail>
class Game {
    name := "Game"
    appid := 0
    dir := new Directory()
    exe := new File()
    logdir := new Directory()
    logfiles := [ new File() ]
    ; log := new LogTailer()
    windows := { "launcher": new Window("","",""), "game": new Window("","","") }
    patterns := {}
    crashed := false
    datafile := new File()
    data := {"starttime":0}
    coords := {}
    args := ""
    eventcallback := ""
    steam := new Steam()
    __New(path := "", eventcallback := "") {
        this.dir := new Directory(path)
        if (!this.dir.exists() || this.dir.path == "\") {
            MsgBox % this.name . " directory " . this.dir.Quote() . " does not exist!"
        } else {
            ; this.exe := this.dir.combineFile("binaries", "win64", this.windows["game"].exe)
            this.datafile := this.dir.combineFile("data.json")
            if (this.datafile.exists() && this.datafile.size() > 0) {
                this.data := fromJson(this.datafile.read())["data"]
            } else {
                this.datafile.write(toJson({"data":this.data}, true))
            }
        }
        this.eventcallback := this.eventcallback
        scriptlog("Created new Game Instance for " . this.name)
    }

    updateData(key, value) {
        this.data[key] := value
        this.datafile.write(toJson(this.data), true)
    }

    restart() {
        this.kill()
        this.start()
    }

    start(steam := true, args := "", wait := false) {
        ; running := this.windows["game"].exists()
        ; if (running)
        ;     this.kill()
        if (steam and this.appid > 0) {
            this.steam.run(this.appid, args)
        } else {
            this.dir.combineFile(this.windows["launcher"].exe).runArgs(wait, args)
        }
        winstr := this.windows["launcher"].str()
        WinWait, % winstr
        this.updateData("starttime", A_Now)
    }
    clearLogs() {
        logs := this.logdir.combineFile("*.log").path
        FileDelete, % logs
        ; this.logfile.create()
    }

    kill() {
        count := 0
        for i, window in this.windows {
            count++
            ; scriptlog("Killing " . window.str())
            SplashScreen("Killing " . window.str(), "Killing process " . count . " / " . this.windows.Count(), 250)
            window_closed := window.close()
            process_closed := window.process.close()
            process_killed := window.process.kill(true, true)
        }
    }
}