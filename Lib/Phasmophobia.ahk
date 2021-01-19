#Include %A_LineFile%\..\Phasmophobia\item.ahk
#Include %A_LineFile%\..\Phasmophobia\items.ahk
#Include %A_LineFile%\..\Phasmophobia\loadout.ahk

GetItemByName(name := "") {
    for _i, _item in items {
        if (_item.name = name) {
            return _item
        }
    }
}

MouseClick(x,y,amount) {
    scriptlog("clicking x" . x . " y" . y . " " . amount . " times", 0, 0)
    Loop % amount {
        MouseClick, left         , x, y ;, 1         , 0
    ;   MouseClick, WhichButton [, X, Y, ClickCount, Speed, D|U, R]
        Sleep, 5
    }
}
AddAllItems() {
    sum := 0
    for index, el in items {
        sum := sum + el.price
        el.add(-1)
    }
    scriptlog("Added all " . items.Count() . " items for $" . sum)
}  
RemoveAllItems() {
    for index, el in items {
        el.remove(-1)
    }
    scriptlog("Removed all " . items.Count() . " items")
}