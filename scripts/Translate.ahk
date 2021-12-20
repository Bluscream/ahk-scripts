;;-------- https://www.autohotkey.com/boards/viewtopic.php?f=6&t=63835 ---
;- from user teadrinker
/*
modified=20190422  EDIT CreateScriptObj() ( teadrinker )
created =20190419
select language , copy marked text ctrl+c > see translation in selected language
*/
;-------------------------------------------------------------------------------

#Include <translate>

#SingleInstance, Force

setworkingdir,%a_scriptdir%
; SS_REALSIZECONTROL := 0x40
; Gui,1:Color,Black,Black
; Gui, Font,s12 cYellow ,Lucida Console 
cl=
ex:=""
transform,s,chr,32
global lang_list
gosub,language

global ui_from_lang := "auto_Automatic"
global ui_to_lang := "en_English"
global WinID
CreateUI()
;Gui, Show,x10 y10 w1150 h600 minimize,TRANSLATE
RefreshTitle()
RETURN

RefreshTitle() {
    langs := GetLanguages()
    ; MsgBox, % langs
    WinSetTitle, ahk_id %WinID%,, % "Translate from " . langs[2] . " to " . langs[4]
}

GetLanguages() {
    arr := StrSplit(ui_from_lang, "_")
    arr2 := StrSplit(ui_to_lang, "_")
    arr.push(arr2*)
    return arr
}

CreateUI() {
; Gui,1: +AlwaysOnTop  
Gui,1: -DPIScale

global ui_textbox
global OnFromLanguageChanged
global OnToLanguageChanged
global ui_text_url

Gui Add, Edit,          x0      y0  w647    h21 vui_text_url -vscroll +Border +ReadOnly
Gui Add, Text,          x8      y32 w30     h23 +0x200, From:
Gui Add, DropDownList,  x48     y32 w120        vui_from_lang gOnFromLanguageChanged,%lang_list%
Gui Add, Text,          x176    y32 w23     h23 +0x200, To:
Gui Add, DropDownList,  x208    y32 w120        vui_to_lang gOnToLanguageChanged,%lang_list%
Gui Add, Button,        x338    y32 w50     h20 gOnButtonTranslateClicked, Translate

Gui Add, Edit, x8 y72 w628 h419 vui_textbox +Border

Gui Show, x10 y10 w646 h502, Translate Text
GuiControl,ChooseString,ui_to_lang,%ui_to_lang%
GuiControl,ChooseString,ui_from_lang,%ui_from_lang%


ControlSetText, %ui_textbox%, "vui_textbox"

ControlSetText, %ui_text_url%, "vui_text_url"

GuiControl, Focus,ui_textbox

WinID := WinExist("A")
}
;--------------------------


OnButtonTranslateClicked:
 Gui, Show,
 guiControlGet, cl,, ui_textbox
 langs := GetLanguages()
 aa := GoogleTranslate(cl, langs[1], langs[3])
 ControlSetText,edit1, % aa[3], ahk_class AutoHotkeyGUI
 ControlSetText,edit2, % aa[1], ahk_class AutoHotkeyGUI
 aa=
 cl=
return
;--------------------------
OnToLanguageChanged:
Gui,1:submit,nohide
RefreshTitle()
return
;----------------------------------------
;--------------------------
OnFromLanguageChanged:
Gui,1:submit,nohide
RefreshTitle()
return
;----------------------------------------

language:
lang_list:=""
lang_list=
(Ltrim join|
auto_Automatic
nl_Nederlands
af_Suid-Afrika
fy_Fryslân
eu_Basque
ca_Catalan
de_Deutsch
da_Dansk
sv_Sverige
no_Norge
is_Iceland
fi_Suomen
en_English
pt_Portugues
es_Español
it_Italia
fr_Français
ru_Rossija
zh-CN_Chinese
ja_Nippon
ko_Korea
ro_Romania
bg_Bulgaria
mc_Macedonia
el_Greek
tr_Turkiye
sq_Albania
hr_Croatia
sr_Serbia
sl_Slovenia
hu_Hungary
cs_Czech
sk_Slovakia
pl_Poland
be_Belarus
uk_Ukraina
et_Estonia
lv_Latvija
lt_Lituania
az_Azerbaijan 
ka_Georgian
ar_Arabic
iw_Hebrew
hi_Hindi
id_Indonesia
ms_Malaysia
vi_Vietnam
th_Thai
ta_Tamil
ur_Urdu
sw_Swahili
%s%
)
return
;====================== END SCRIPT ==================================================