#Include <bluscream>
class Game {
    name := "Grand Theft Auto"
    appid := 271590
    dir := new Directory()
    exe := new File()
    windows := {}
    datafile := new File()
    data := {"starttime":0}
    __New(path, eventcallback := "") {
        this.windows["launcher"] :=              new Window("Rockstar Games Launcher", "Rockstar Games Launcher", "SocialClubHelper.exe")
        this.windows["game"] :=                  new Window("Grand Theft Auto V", "grcWindow", "GTA5.exe")
        this.windows["GTAVLauncher"] :=          new Window("", "", "GTAVLauncher.exe")
        this.windows["PlayGTAV"] :=              new Window("", "", "PlayGTAV.exe")
        this.windows["GTAVLanguageSelect"] :=    new Window("", "", "GTAVLanguageSelect.exe")

        this.windows["Launcher"] :=              new Window("", "", "Launcher.exe")
        this.windows["RockstarSteamHelper"] :=   new Window("", "", "RockstarSteamHelper.exe")
        this.windows["RockstarService"] :=       new Window("", "", "RockstarService")
        this.windows["LauncherPatcher"] :=       new Window("", "", "LauncherPatcher.exe")
        this.windows["SocialClubHelper"] :=      new Window("", "", "SocialClubHelper.exe")

        this.dir := new Directory(path)
        if (!this.dir.exists()) {
            MsgBox % this.name . " directory " . this.dir.Quote() . " does not exist!"
        }
        this.exe := this.dir.combineFile(this.windows["game"].exe)
        this.datafile := this.dir.combineFile("data.json")
        if (this.datafile.exists() && this.datafile.size() > 0)
            this.data := fromJson(this.datafile.read())
    }

    updateData(key, value) {
        this.data[key] := value
        this.datafile.write(toJson({"data":this.data}, true))
    }

    start() {
        this.kill()
        winstr := this.windows["launcher"].str()
        Run, % "steam://rungameid/" . this.appid
        WinWait, % winstr
        this.updateData("starttime", A_Now)
        ; WinActivate, % winstr
        ; WinWaitActive, % winstr
        ; sleep, 2500
        ; SetControlDelay -1
    }

    kill() {
        MsgBox 0x34, Kill , Do you really want to kill the game?, 15
        IfMsgBox Yes, {
            count := 0
            for i, window in this.windows {
                count++
                SplashScreen("Killing " . window.str(), "Killing process " . count . " / " . this.windows.Count(), 250)
                window_closed := window.close()
                process_closed := window.process.close()
                process_killed := window.process.kill(true, true)
                ; scriptlog("window_closed: " . toYesNo(window_closed))
                ; scriptlog("process_closed: " . toYesNo(window_closed))
                ; scriptlog("process_killed: " . toYesNo(window_closed))
            }
        }
        return
    }
}