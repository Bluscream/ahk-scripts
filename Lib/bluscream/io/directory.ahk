class Directory {
    drive := ""
    path := ""
    __New(path) {
        if (!endsWith(path, "\")) {
            path .= "\"
        }
        this.path := path
        SplitPath,path,,,,, drive
        this.drive := drive
    }
    Quote() {
        return """" . this.path . """"
    }
    Combine(dirs*) {
        return new Directory(this.path . ("\".join(dirs)))
    }
    CombineFile(paths*) {
        return new File(this.path . ("\".join(paths)))
    }
    exists() {
        return FileExist(this.path)
    }
    ShowInFileExplorer() {
        Run % "explorer.exe " . this.Quote()
    }
    getNewestFile(pattern := "*.*") {
        pattern := this.path . pattern
        Loop %pattern%
        If (A_LoopFileTimeModified >= _time)
            _time := A_LoopFileTimeModified, _file := A_LoopFileLongPath
        return new File(_file)
    }
}