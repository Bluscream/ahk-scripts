class Channel {
    name := ""
    file := new File()
    window := new Window()
    process := new process()
    setup_filename := ""
    installed := false
    urls := {}

    __New(name, folder, file, setup_filename) {
        this.name := name
        EnvGet, locappdata, LOCALAPPDATA
        locappdata := new Directory(locappdata)
        this.file := locappdata.combineFile("Programs", folder, file)
        this.window := new Window("Shadow", "Shadow-Window-Class", file.fullname)
        this.process := this.file.fullname
        this.setup_filename := setup_filename
        this.installed := FileExist(this.file.path) ? true : false
        this.urls["x64"] := this.url("x64")
        this.urls["x86"] := this.url("x86")
        scriptlog("New Channel: " . ToJson(this, false))
    }
    url(arch) {
        return "https://update.shadow.tech/launcher/" . this.name . "/win/" . arch . "/" . this.setup_filename
    }
    install(arch) {
        scriptlog("Installing " . this.setup_filename . " " . arch)
        new Url(this.url(arch)).download().run(true)
        scriptlog("Installed " . this.setup_filename . " " . arch)
    }
}