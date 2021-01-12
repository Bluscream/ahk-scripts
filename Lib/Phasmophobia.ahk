#Include %A_LineFile%\..\Phasmophobia\items.ahk
#Include %A_LineFile%\..\Phasmophobia\loadout.ahk

; x = links -> rechts
; y = oben -> unten

global rows := [ 805, 1355, 845, 1375 ] ; addX, addY, delX, delY

ApplyLoadout(loadout) {
    sum := 0
    count := 0 
    for i, el in loadout.items {
        AddItem(i, el)
        sum := sum + items[i].price
        count++
    }
    SplashScreen("Applied loadout " . loadout.name . " (" . count . " items)", "Total price: $" . sum)
}
AddItem(item, amount := 1) {
    amount := (amount < 0) ? items[item].max : amount
    ; scriptlog("ITEM: " . item . " COUNT: " . amount)
    MouseClick(items[item].x, items[item].y, amount)
}
; AddItemByIndex(index, amount := 1) {
;    x := (index > 15) ? items["thermometer"][1] : items["emf"][1]
;    y := items[item][2]+(30*index) ; FIX   
;    MouseClick(x, y, amount)
;}
MouseClick(x,y,amount) {
    ; ToolTip, % "clicking x" . x . " y" . y . " " . amount . " times", 0, 0
    Loop % amount {
        MouseClick, left         , x, y ;, 1         , 0
    ;   MouseClick, WhichButton [, X, Y, ClickCount, Speed, D|U, R]
        Sleep, 5
    }
}
AddAllItems() {
    for index, el in items {
        scriptlog("adding item " . index . " " . el.max . " times")
        ; ToolTip, % "adding item " . index . "", 0, 0
        AddItem(index, el.max)
    }
}  
RemoveAllItems() {
    for index, el in items {
        ; ToolTip, % "removing item " . index, 0, 0
        scriptlog("removing item " . index)
        x := (el.row == 1) ? rows[3] : rows[4]
        MouseClick(x,el.y,el.max)
    }
}