#include <bluscream>
global no_ui := false
scriptlog("Starting...")

ArrayOfMP3:=Object()
Loop, 5                                            ;Create fake array
     ArrayOfMP3.Insert("D:\" . A_Index . ".mp3")
Gui, Default
Gui, Add, ListView, W600 H500 Checked Grid -Sort vMylistview gListLabel -Multi, Title|Artist
Loop, % ArrayOfMP3.MAxIndex()
	LV_Add("Check","Title " . A_Index,"Artist " . A_Index)        ;Fake listview items
LV_ModifyCol()
Gui, show
GuiControl, +AltSubmit, Mylistview
return

ListLabel:
if (A_GuiEvent = "I")
{
    if InStr(ErrorLevel, "c", true)
    {
        LV_GetText(Title, A_EventInfo, 1)
        LV_GetText(Artist, A_EventInfo, 2)
        msgbox % "Remove:`nTitle = " . Title "`nArtist = " . Artist
    }
    if InStr(ErrorLevel, "C", true)
    {
        LV_GetText(Title, A_EventInfo, 1)
        LV_GetText(Artist, A_EventInfo, 2)
        msgbox % "Insert:`nTitle = " . Title "`nArtist = " . Artist
    }
}
return

ListGUIClose:
ListGUIEscape:
ExitApp