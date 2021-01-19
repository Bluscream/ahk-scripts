class LoadoutItem {
    item := ""
    count := 0
    __New(name := "", count := 1) {
        this.item := GetItemByName(name)
        this.count := count
    }
    add() {
        this.item.add(this.count)
    }
}
class Loadout {
    name := ""
    items := []
    __New(name, items) {
        this.name := name
        this.items := items
    }
    apply() {
        sum := 0
        count := 0 
        for i, el in this.items {
            el.add()
            sum := sum + el.item.price
            count++
        }
        scriptlog("Applied loadout " . this.name " (" count . " Items | $" . sum . ")")
        SplashScreen("Applied loadout " . this.name, count . " Items | $" . sum)
    }
}