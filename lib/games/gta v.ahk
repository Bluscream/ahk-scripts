#Include <game>
class GTAVGame extends Game {
    name := "Grand Theft Auto V"
    shortname := "GTA V"
    appid := 271590
    __New(path, eventcallback := "") {
        base.__New(path, eventcallback)
        this.windows["launcher"] :=              new Window("Rockstar Games Launcher", "Rockstar Games Launcher", "SocialClubHelper.exe")
        this.windows["game"] :=                  new Window("", "grcWindow", "GTA5.exe") ; "Grand Theft Auto V"
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
        this.exe := this.dir.combineFile(this.windows["PlayGTAV"].exe)
        this.launcher := this.dir.combineFile(this.windows["game"].exe)
        this.datafile := this.dir.combineFile("data.json")
        if (this.datafile.exists() && this.datafile.size() > 0)
            this.data := fromJson(this.datafile.read())
    }

    start(online:=False,verify:=False,offline:=False,windowed:=False,fullscreen:=False,density:=-1) {
        args := []
        if (online) {
            args.Push("-StraightIntoFreemode")
        }
        if (verify) {
            args.Push("-verify")
        }
        if (offline) {
            args.Push("-scofflineonly")
        }
        if (windowed) {
            args.Push("-windowed")
        }
        if (fullscreen) {
            args.Push("-fullscreen")
        }
        if (density > -1) {
            args.Push("-cityDensity " . density)
        }
        base.start(steam, args, wait)
    }

    minimize(wait := true) {
        ; for i, window in this.windows {
        this.windows.game.deactivate(wait, True)
        ; } 
    }

    activate(wait := true) {
        this.windows.game.activate(wait, true)
    }

    kill() {
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
        return
    }
}