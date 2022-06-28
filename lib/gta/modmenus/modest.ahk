#Include <modmenu>

class ModestModMenu extends ModMenu {
    name := "Modest Menu"
    navigate(key, amount := 1) {
        Loop % amount {
            ; ControlSend,, key, % "Default IME ahk_exe modest-menu.exe"
            ; ControlSend,, key, % "ahk_id " . this.window.id
            ; ControlSend,, key, % "ahk_exe modest-menu.exe"
            ; ControlSend,, key, % "Grand Theft Auto V"
            Send, % key
            if (amount > 1) {
                Sleep, dsleep
            }
        }
    }
    waitForEnum(row, text, key := "{Right}") {
        c := this.getControls()
        scriptlog("Waiting to reach value: " . text . " (current: " . c[row+2].text . ")")
        fails := 0
        delay := this.dsleep
        while(!InStr(modmenu.getControls()[row+2].text, text, true)) {
            ; scriptlog("Waiting to reach pos: " . targetRow . " (row: " . this.row . ", percent: " . percent . "%, fails: " . fails . " delay: " . delay . " ms)")
            this.navigate(key)
            this.getControls()
            fails++
            if (fails > 10) {
                this.navigate("{F4}")
                fails := 0
                delay += this.dsleep
                if (delay > delay * 10)
                    delay := this.dsleep
            }
            Sleep, % delay
        }
        this.getControl
    }
    waitForRow(targetRow) {
        this.getControls()
        scriptlog("Waiting to reach pos: " . targetRow . " (row: " . this.row . ")")
        fails := 0
        delay := this.dsleep
        while(this.row != targetRow) {
            lastrow := this.row
            percent := (this.row / this.rows) * 20 
            ; scriptlog("Waiting to reach pos: " . targetRow . " (row: " . this.row . ", percent: " . percent . "%, fails: " . fails . " delay: " . delay . " ms)")
            if (percent < 50) {
                this.navigate("{Up}")
            } else {
                this.navigate("{Down}")
            }
            this.getControls()
            if (lastrow == this.row) {
                fails++
                if (fails > 10) {
                    this.navigate("{F4}")
                    fails := 0
                    delay += this.dsleep
                    if (delay > delay * 10)
                        delay := this.dsleep
                }
            }
            Sleep, % delay
        }
        this.getControl
    }
    waitForPage(targetPage, isSubPage := false) {
        this.getControls()
        scriptlog("Waiting to reach " . (isSubPage ? "next" : "prev") . " page " . targetPage . " (lastpage: " . this.page . ")")
        fails := 0
        delay := this.dsleep
        while(this.page != targetPage) {
            lastpage := this.page
            ; scriptlog("Waiting to reach " . (isSubPage ? "next" : "prev") . " page " . targetPage . " (lastpage: " . lastpage . ", fails:" . fails . ", delay:" . delay . "ms)")
            if (isSubPage) {
                this.navigate("{Enter}")
            } else {
                this.navigate("{Backspace}")
            }
            this.getControls()
            if (lastpage == this.page) {
                fails++
                if (fails > 10) {
                    this.navigate("{F4}")
                    fails := 0
                    delay += this.dsleep
                    if (delay > delay * 10)
                        delay := this.dsleep
                }
            }
            Sleep, % delay
        }
        this.getControls()
    }
    resetPage() {
        this.waitForPage("Main Menu")
    }
    resetPosition() {
        this.waitForRow(1)
    }
    getControls() {
        c := this.getWindow().controls()
        fresh := this.name == ""
        mnv := StrSplit(c[2].text, "v")
        this.name := Trim(mnv[1])
        this.version := Trim(mnv[2])
        rw := StrSplit(c[1].text, "/")
        this.row := Trim(rw[1])
        this.rows := Trim(rw[2])
        if (fresh) {
            scriptlog("Found " . c[2].text)
        }
        newpage := ""
        if (startsWith(c[3].text, "Game|")){
            newpage := "Main Menu"
        } else if (c[3].text == "Leave Online"){
            newpage := "Game"
        } else if (startsWith(c[3].text, "God mode|")) {
            newpage := "Player"
        } else if (startsWith(c[3].text, "Handling|")) {
            newpage := "Vehicle"
        } else if (startsWith(c[3].text, "Weapons Loadout|")) {
            newpage := "Weapon"
        } else if (startsWith(c[3].text, "Set Weather|")) {
            newpage := "World"
        } else if (c[3].text == "Waypoint") {
            newpage := "Teleport"
        } else if (startsWith(c[3].text, "No Idle Kick|")) {
            newpage := "Tunables"
        } else if (startsWith(c[3].text, "Independence Day|")) {
            newpage := "Unlocks"
        } else if (startsWith(c[3].text, "Bunker Settings|")) {
            newpage := "Online Services"
        } else if (startsWith(c[3].text, "Unlock all vehicles|")) {
            newpage := "Online Vehicle Spawn"
        } else if (startsWith(c[3].text, "Disable Freeze|")) {
            newpage := "Online Protection"
        } else if (startsWith(c[3].text, "Menu X position|")) {
            newpage := "Menu Settings"
        }
        if (this.page != newpage) {
            scriptlog("Modmenu page changed from " . this.page . " to " . newpage . " (" . this.row . "/" . this.rows . ")" )
            this.page := newpage
        }
        return c
    }
}



