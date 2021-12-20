mylist =
(
John,Lennon,1940,rythm guitar
Paul,McCartney,1942,bass guitar
George,Harrison,1943,solo guitar
Ringo,Star,1940,drums
)

Gui, Color, EEAA99
gui, font, s20, Verdana  
Gui, Add, ListView, Grid -ReadOnly, Name|Last Name|Year of birth|Instrument
Gui, Add, button, gexit,  Exit


loop, parse, mylist, `n
   {
   row := A_LoopField
   gosub, thinner
   }
gosub, show   
return

thinner:
loop, parse, row, `,
   {
   ;msgbox % A_LoopField
   box%A_Index% := A_LoopField
}
;msgbox % "boxes are:`n" . box1 . box2 . box3 . box4
LV_Add("", box1, box2, box3, box4)
return

show:
LV_ModifyCol(1,100)
LV_ModifyCol(2,100)
LV_ModifyCol(3,100)
LV_ModifyCol(4,100)
LV_ModifyCol(2, "AutoHdr")
LV_ModifyCol(3, "AutoHdr Center")
Gui, Show, , The Beatles
return

esc::
exitapp

GuiClose:
ExitApp

exit:
exitapp