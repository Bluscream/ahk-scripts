class File {
    name := ""
    fullname := ""
    extension := ""
    drive := ""
    path := ""
    directory := new Directory()
    __New(parts*) {
        path := "\".join(parts)
        SplitPath, % path, fullname, dir, extension, name, drive
        this.path := path
        this.fullname := fullname
        this.extension := extension
        this.name := name
        this.drive := drive
        this.directory := new Directory(dir)
    }
    Quote() {
        return """" . this.path . """"
    }
    SplitPath() {
        SplitPath, % this.path, name, dir, ext, name_no_ext, drive
        return { "FullFileName": this.path, "name": name, "dir": dir, "ext": ext, "name_no_ext": name_no_ext, "drive": drive }
    }
    exists() {
        return FileExist(this.path)
    }
    size(units := "B") {
        FileGetSize, size, % this.path, % units
        return size 
    }
    open(flags := "r", encoding := "UTF-8") {
        return FileOpen(this.path, flags, encoding)
    }
    play(wait := 0) {
        SoundPlay, % this.path, % wait
    }
    read() {
        FileRead, ret, % this.path
        return ret
    }
    readlines() {
        lines := ()
        Loop, Read, % this.path
            lines.push(A_LoopReadLine)
        return lines
    }
    create(encoding := "UTF-8") {
        this.append("", encoding)
    }
    append(txt, encoding := "UTF-8") {
        FileAppend, % txt, % this.path, % encoding
    }
    write(txt) {
        this.delete()
        this.append(txt)
    }
    copy(destination, overwrite := false) {
        FileCopy, % this.path , % destination, % overwrite
    }
    move(destination, overwrite := false) {
        FileMove, % this.path , % destination, % overwrite
    }
    delete() {
        FileDelete, % this.path
    }
    setAttributes(attributes) {
        FileSetAttrib, % attributes, % this.path
    }
    setEncoding(encoding:="UTF-8") {
        hINI := this.open("r", "")
        Data := this.Read()
        hINI.Close()
        this.delete()
        hINI2 := this.open("w", encoding)
        hINI2.Write(Data)
        hINI2.Close()
    }
}