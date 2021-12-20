scriptlog("Initializing Lib\Phasmophobia\item.ahk...")
class Item {
    name := ""
    column := 0
    row := 0
    max := 0
    price := 0
    addx := 0
    remx := 0
    allx := 0
    y := 0
    __New(name := "", column := 1, row := 1, max := 0, price := 0) {
        this.name := name
        this.column := column
        this.row := row
        this.max := max
        this.price := price
        this.addx := [805, 1340][this.column] ; CHANGEME
        this.remx := this.addx + 40
        this.allx := this.remx + 55
        this.y := 355 + ((this.row - 1) * 30) ; CHANGEME
        scriptlog("Registered item: " . toJson(this))
    }

    add(amount := 1) {
        if (amount < 0 || amount >= this.max) {
            this.addAll()
        } else {
            MouseClick(this.addx, this.y, amount)
            scriptlog("Added: " . this.name . " " . amount . " times.")
        }
    }
    addAll() {
        MouseClick(this.allx, this.y)
        scriptlog("Added all: " . this.name . " " . this.max . " times.")
    }
    remove(amount := 1) {
        amount := (amount < 0) ? this.max : amount
        MouseClick(this.remx, this.y, amount, 50)
        scriptlog("Removed: " . this.name . " " . amount . " times.")
    }
}
scriptlog("Initialized Lib\Phasmophobia\item.ahk...")