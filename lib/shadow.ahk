class Channel {
    name := ""
    file := new File()
    window := new Window()
    process := new process()
    setup_filename := ""
    installed := false

    __New(name, folder, file, setup_filename) {
        this.name := name
        EnvGet, locappdata, LOCALAPPDATA
        locappdata := new Directory(locappdata)
        this.file := locappdata.combineFile("Programs", folder, file)
        this.window := new Window("Shadow", "Shadow-Window-Class", file.fullname)
        this.process := this.file.fullname
        this.setup_filename := setup_filename
        this.installed := FileExist(this.file.path)
        ; scriptlog("New Channel: " . ToJson(this, false))
    }
    install(arch) {
        scriptlog("Installing " . this.setup_filename . " " . arch)
        new Url("https://update.shadow.tech/launcher/" . this.name . "/win/" . arch . "/" . this.setup_filename).download().run(true)
        scriptlog("Installed " . this.setup_filename . " " . arch)
    }
}