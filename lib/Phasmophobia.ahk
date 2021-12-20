scriptlog("Initializing Lib\Phasmophobia.ahk...")
#Include %A_LineFile%\..\Phasmophobia\item.ahk
#Include %A_LineFile%\..\Phasmophobia\items.ahk
#Include %A_LineFile%\..\Phasmophobia\loadout.ahk

GetItemByName(name := "") {
    for _i, _item in items {
        if (_item.name = name) {
            return _item
        }
    }
    return
}
MouseClick(x,y,amount := 1, delay := 5) {
    ; scriptlog("clicking x" . x . " y" . y . " " . amount . " times", 0, 0)
    Loop % amount {
        MouseClick, left         , x, y ;, 1         , 0
    ;   MouseClick, WhichButton [, X, Y, ClickCount, Speed, D|U, R]
        Sleep, % delay
    }
    return
}
AddAllItems() {
    sum := 0
    for index, el in items {
        sum := sum + (el.price * el.max)
        el.add(-1)
    }
    scriptlog("Added all " . items.Count() . " items for $" . sum)
    SplashScreen(items.Count() . " items for $" . sum, "Added All Items")
    return
}  
RemoveAllItems() {
    for index, el in items {
        el.remove(-1)
    }
    scriptlog("Removed all " . items.Count() . " items")
    SplashScreen(items.Count() . " items", "Removed All Items")
    return
}
scriptlog("Initialized Lib\Phasmophobia.ahk...")