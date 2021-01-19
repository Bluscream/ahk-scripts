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
        this.addx := [ 1075, 1785 ][this.column]
        this.remx := this.addx + 50
        this.allx := this.remx + 75
        scriptlog(40 * this.row) 
        scriptlog((40 * this.row) - 1) 
        scriptlog(475 + ((40 * this.row) - 1)) 
        this.y := 475 + (40 * (this.row - 1))
        scriptlog("Registered item: " . toJson(this))
    }
    add(amount := 1) {
        if (amount < 0) {
            this.addAll()
        } else {
            MouseClick(this.x, this.y, amount)
            scriptlog("Added: " . this.name . " " . amount . " times.")
        }
    }
    addAll() {
        MouseClick(this.allx, this.y, 1)
        scriptlog("Added all: " . this.name . " " . this.max . " times.")
    }
    remove(amount := 1) {
        amount := (amount < 0) ? item.max : amount
        MouseClick(this.remx, this.y, amount)
        scriptlog("Removed: " . this.name . " " . amount . " times.")
    }
}