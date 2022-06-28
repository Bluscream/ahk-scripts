#SingleInstance, force
#Include <bluscream>
; #Include <logtail>
class Steam {
    dir := new Directory("C:\Program Files (x86)\Steam")
    exe := new File("C:\Program Files (x86)\Steam\Steam.exe")
    logdir := ""
    logfiles := []
    ; log := new LogTailer()
    windows := { main: new Window("Steam", "vguiPopupWindow", "Steam.exe")
    ,login: new Window("Steam Login", "vguiPopupWindow", "Steam.exe")
    ,login_refresh: new Window("Steam - Refresh Login", "vguiPopupWindow", "Steam.exe")
    ,login_refresh_2fa: new Window("Steam - Authenticator Code", "vguiPopupWindow", "Steam.exe")
    ,2fa: new Window("Steam Guard - Computer Authorization Required", "vguiPopupWindow", "Steam.exe")
    ,login_error: new Window("Steam - Error", "vguiPopupWindow", "Steam.exe")}
    patterns := {}
    args := ""
    eventcallback := ""
    __New(exe := "", eventcallback := "") {
        ; if (exe!="") {
        ;     this.exe := new File(exe) 
        ;     this.dir := this.exe.directory
        ; }
        if (!this.dir.exists() || this.dir.path == "\") {
            MsgBox % this.name . " directory " . this.dir.Quote() . " does not exist!"
        }
        this.windows["login"]["controls"] := { "username": { "x": 269, "y": 100 }, "password": { "x": 260, "y": 133 }, "save": { "x": 123, "y": 163 } }
        this.windows["login_refresh"]["controls"] := { "password": { "x": 231, "y": 147 }, "2fa": { "x": 230, "y": 183 } }
        this.eventcallback := eventcallback
    }

    kill(wait := false) {
        for i, window in this.windows {
            window_closed := window.close()
            process_closed := window.process.close()
            process_killed := window.process.kill(true, true)
        }
    }

    restart() {
        this.kill(True)
        this.start()
    }

    restartMini() {
        this.kill(True)
        this.start(True, True)
    }

    restartBigPicture() {
        this.kill(True)
        this.bigpicture()
    }

    startArgs(_args) {
        this.exe.run(false,this.dir,Join(" ", _args))
    }

    startURI(uri) {
        this.startArgs([uri])
    }
    
    start(no_browser:=False,mini:=False,appid:=0,uris:="") {
        _args := []
        if (no_browser) {
            _args.Push("-no-browser")
        }
        if (mini) {
            _args.Push("+open steam://open/minigameslist")
        }
        if (appid > 0) {
            _args.Push("+open steam://rungameid/" . appid)
        }
        if (uris) {
            for i, uri in uris {
                _args.Push("+open " . uri)
            }
        }
        this.startArgs(_args)
    }

    run(appid, args) {
        this.startURI("steam://run/" . appid . (args ? ("// " . Join(" ", args)) : ""))
    }

    bigpicture() {
        this.startURI("steam://open/bigpicture")
    }

    console() {
        this.startURI("steam://open/console")
    }

    key() {
        this.startURI("steam://open/activateproduct")
    }

    connect(ip, port, password) {
        this.startURI("steam://connect/" . ip . ":" . port . "/" . password . "")
    }

    install(appid) {
        this.startURI("steam://install/" . appid)
    }

    verify(appid) {
        this.startURI("steam://validate/" . appid)
    }
}