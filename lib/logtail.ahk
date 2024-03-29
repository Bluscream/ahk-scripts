﻿; LOG TAILER CLASS BY EVILC (Modified by Bluscream)
; Pass it the filename, and a function object that gets fired when a new line is added
class LogTailer {
    seekPos := 0
    fileHandle := 0
    fileSize := 0
    opened := false
    
    __New(FileName, callback, StartWithLastLine := false, Encoding := "UTF-8", LineEndings := "`n"){
        this.fileName := FileName
        scriptlog("callback: " . toJson(callback))
        if (callback == "" or callback == 0) {
            MsgBox % "Callback " . callback.Name . " is not a function!"
            ExitApp
        }
        this.callback := callback
        fileHandle := FileOpen(FileName, "r-d " . LineEndings, Encoding)
        if (!IsObject(fileHandle)){
            MsgBox % "Unable to load file " . FileName
            ExitApp
        }
        this.fileHandle := fileHandle
        this.fileSize := fileHandle.Length
        this.StartWithLastLine := StartWithLastLine
        fn := this.Read.Bind(this)
        this.ReadFn := fn
        this.Start()
    }

    /*
"%A_ProgramFiles%\Unlocker\Unlocker.exe" "%listfile%" /L /S
*/
    
    Read(){
        len := this.fileHandle.Lengths
        size := this.fileSize
        got_smaller := this.fileHandle.Length < this.fileSize
        ; MsgBox, , , %len% < %size% = %got_smaller%
        if (this.fileHandle.Length < this.fileSize){
            ; File got smaller. Log rolled over. Reset to start
            this.seekPos := 0
        }
        if (this.StartWithLastLine && !this.opened) {
            this.opened := true
            this.seekPos := this.fileHandle.Length
        }
        ; Move to where we left off
        this.fileHandle.Seek(this.seekPos, 0)

        ; Read all new lines
        while (!this.fileHandle.AtEOF){
            line := this.fileHandle.ReadLine()
            ; MsgBox % "new line: " . line
            if (line == "`r`n" || line == "`n" || line == ""){
                continue
            }
            ; Fire the callback function and pass it the new line
            line := Trim(line)
            line := RegExReplace(line, "`n", "")
            line := RegExReplace(line, "`r", "")
            ; MsgBox % line
            this.callback.call(line)
        }
        ; Store position we last processed
        this.seekPos := this.fileHandle.Pos
        ; Store length so we can detect roll over
        this.fileSize := this.fileHandle.Length
    }
    
    ; Starts tailing
    Start(){
        fn := this.ReadFn
        SetTimer, % fn, 10
    }
    
    ; Stops tailing
    Stop(){
        fn := this.ReadFn
        SetTimer, % fn, Off
    }
    
    ; Stop tailing and close file handle
    Delete(){
        this.Stop()
        this.fileHandle.Close()
    }
}