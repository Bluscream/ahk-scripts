#SingleInstance, force
#Persistent
#Include <bluscream>
#include <OrderedAssociativeArray>

global noui := false

; x = links -> rechts
; y = oben -> unten

global rows := [ 805, 1355, 845, 1375 ] ; addX, addY, delX, delY

global items := new OrderedAssociativeArray() ; x, y
items["EMF Reader"] := { row: 1, x: 805, y: 355, max: 1 }
items["Flashlight"] := { row: 1, x: 805, y: 385, max: 3 }
items["Photo Camera"] := { row: 1, x: 805, y: 415, max: 2 }
items["Lighter"] := { row: 1, x: 805, y: 445 , max: 2 }
items["Candle"] := { row: 1, x: 805, y: 475, max: 4 }
items["UV Light"] := { row: 1, x: 805, y: 505, max: 1 }
items["Crucifix"] := { row: 1, x: 805, y: 535, max: 2 }
items["Video Camera"] := { row: 1, x: 805, y: 565, max: 5 }
items["Spirit Box"] := { row: 1, x: 805, y: 595, max: 1 }
items["Salt"] := { row: 1, x: 805, y: 625, max: 2 }
items["Smudge Sticks"] := { row: 1, x: 805, y: 647, max: 4 }
items["Tripod"] := { row: 1, x: 805, y: 685, max: 5 }
items["Strong Flashlight"] := { row: 1, x: 805, y: 715, max: 4 }
items["Motion Sensor"] := { row: 1, x: 805, y: 745, max: 4 }
items["Audio Sensor"] := { row: 1, x: 805, y: 765, max: 4 }

items["Thermometer"] := { row: 2, x: 1355, y: 355, max: 3 }
items["Sanity Pills"] := { row: 2, x: 1355, y: 385, max: 4 }
items["Ghost Writing Book"] := { row: 2, x: 1355, y: 415, max: 1 }
items["Infrared Light Sensor"] := { row: 2, x: 1355, y: 445, max: 4 }
items["Parabolic Microphone"] := { row: 2, x: 1355, y: 475, max: 2 }
items["Glowstick"] := { row: 2, x: 1355, y: 505, max: 2 }
items["Head Mounted Camera"] := { row: 2, x: 1355, y: 530, max: 4 }

AddItem(item, amount := 1) {
    amount := amount < 0 ? items[item].max : amount
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
Return

#IfWinActive ahk_class UnityWndClass
F3::
    for index, el in items {
        scriptlog("adding item " . index . " " . el.max . " times")
        ; ToolTip, % "adding item " . index . "", 0, 0
        AddItem(index, el.max)
    }
    ; Tooltip,
    ; AddItem("EMF Reader", 2)
    return
    
F5::
    for index, el in items {
        ; ToolTip, % "removing item " . index, 0, 0
        scriptlog("removing item " . index . " " . el.max . " times")
        x := (el.row == 1) ? rows[3] : rows[4]
        MouseClick(x,el.y,el.max)
        MouseClick(x,el.y,el.max)
    }
    ; Tooltip,
    return

ESC::
    ExitApp