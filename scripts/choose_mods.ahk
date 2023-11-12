#include <bluscream>
global no_ui := false
; scriptlog("Starting...")

; Read the CSV file
FileRead, csvData, mods.csv

; Parse the CSV data
lines := StrSplit(csvData, "`n", "`r")
global addons := []
for index, line in lines {
    ; skip if empty or whitespace or starts with ; or #
    if (line == "" or line == " " or SubStr(line, 1, 1) == ";" or SubStr(line, 1, 1) == "#") {
        continue
    }    
    addon := StrSplit(line, ";")
    ; scriptlog("#" . index . " Found addon: " addon[2] . " (" addon[1] ")")
    addon := new GameAddon(addon[1], addon[2], false)
    ; scriptlog("#" . index . " Parsed addon: " addon.name . " (" addon.id ")")
    addons.Push(addon)
}

; Create the GUI
Gui, Default
Gui, Add, ListView, w600 h400 Checked Grid vMylistview gListLabel -Multi, Name|ID
for index, addon in addons {
    ; scriptlog("#" . index . " Adding addon: " addon.name . " (" addon.id ")")
    if (addon.id == "") {
        continue
    }
    LV_Add("", addon.name, addon.id) ; Check
    ; LV_SetCheckState("AddonList", index, addon.enabled)
}
; resize the columns to fit
LV_ModifyCol()
; add copy button for each of the textboxes
Gui, Add, Text, , Enable Text:
Gui, Add, Edit, w600 r3 vEnableText ReadOnly, 
Gui, Add, Button, w100 gCopyButtonEnable, Copy
Gui, Add, Text, , Disable Text:
Gui, Add, Edit, w600 r3 vDisableText ReadOnly,
Gui, Add, Button, w100 gCopyButtonDisable, Copy
Gui, Add, Text, , Enable Others Text:
Gui, Add, Edit, w600 r3 vEnableOthersText ReadOnly, 
Gui, Add, Button, w100 gCopyButtonEnableOthers, Copy
Gui, Add, Text, , Disable Others Text:
Gui, Add, Edit, w600 r3 vDisableOthersText ReadOnly,
Gui, Add, Button, w100 gCopyButtonDisableOthers, Copy
Gui, Add, Text, , Enable/Disable Text:
Gui, Add, Edit, w600 r3 vEnableDisableText ReadOnly,
Gui, Add, Button, w100 gCopyButtonEnableDisable, Copy
Gui, Add, Text, , Inverted Text:
Gui, Add, Edit, w600 r3 vInvertText ReadOnly,
Gui, Add, Button, w100 gCopyButtonInvert, Copy
Gui, Show, , Addon Manager
GuiControl, +AltSubmit, Mylistview

; scriptlog("Finished GUI")
return

CopyButtonEnable:
    GuiControlGet, txt,, EnableText
    clipboard := txt
    return
CopyButtonDisable:
    GuiControlGet, txt,, DisableText
    clipboard := txt
    return
CopyButtonEnableOthers:
    GuiControlGet, txt,, EnableOthersText
    clipboard := txt
    return
CopyButtonDisableOthers:
    GuiControlGet, txt,, DisableOthersText
    clipboard := txt
    return
CopyButtonEnableDisable:
    GuiControlGet, txt,, EnableText
    clipboard := txt
    return
CopyButtonInvert:
    GuiControlGet, txt,, InvertText
    clipboard := txt
    return

ListLabel:
    event := A_GuiEvent
    info := A_EventInfo
    ; scriptlog("ListLabel: " event)
    if (A_GuiEvent = "I")
    {
        ; scriptlog("ListLabel: " event " " info)
        LV_GetText(AddonId, info, 2)
        LV_GetText(AddonName, info, 1)
        if InStr(ErrorLevel, "c", true) ; Unchecked
        {
            ; scriptlog("Disabling addon: " AddonId)
            getAddonById(AddonId).enabled := false
            updateTextBoxes()
        }
        else if InStr(ErrorLevel, "C", true) ; Checked
        {
            ; scriptlog("Enabling addon: " AddonId)
            getAddonById(AddonId).enabled := true
            updateTextBoxes()
        }
    } ; else if (event = "C") {
    ;     LV_GetText(Addon0, info, 0)
    ;     LV_GetText(AddonId, info, 1)
    ;     LV_GetText(AddonName, info, 2)
    ;     LV_GetText(Addon3, info, 3)
    ;     scriptlog("ListLabel: " event " " info . " " AddonId . " " AddonName . " " Addon3 . " " Addon0)
    ; }
    return

getAddonById(id) {
    ; scriptlog("Getting addon by id: " id)
    for index, addon in addons {
        if (addon.id == id) {
            ; scriptlog("Found addon: " addon.name . " (" addon.id ")")
            return addon
        }
    }
    return false
}

enableAddonById(id) {
    ; scriptlog("Enabling addon: " id)
    addon := getAddonById(id)
    if (addon) {
        addon.enabled := true
    }
}

updateTextBoxes() {
    ; scriptlog("Updating textboxes...")
    global addons
    EnableText := ""
    InvertText := ""
    DisableText := ""
    EnableDisableText := ""
    for index, addon in addons {
        if (addon.enabled) {
            EnableText .= "addon_enable " addon.id ";"
            DisableText .= "addon_disable " addon.id ";"
            InvertText .= "addon_disable " addon.id ";"
            EnableDisableText .= "addon_enable " addon.id ";"
        } else {
            DisableOthersText .= "addon_disable " addon.id ";"
            EnableOthersText .= "addon_enable " addon.id ";"
            InvertText .= "addon_enable " addon.id ";"
            EnableDisableText .= "addon_disable " addon.id ";"
        }
    }
    EnableText := SubStr(EnableText, 1, StrLen(EnableText)-1)
    EnableOthersText := SubStr(EnableOthersText, 1, StrLen(EnableOthersText)-1)
    DisableText := SubStr(DisableText, 1, StrLen(DisableText)-1)
    DisableOthersText := SubStr(DisableOthersText, 1, StrLen(DisableOthersText)-1)
    EnableDisableText := SubStr(EnableDisableText, 1, StrLen(EnableDisableText)-1)
    InvertText := SubStr(InvertText, 1, StrLen(InvertText)-1)
    GuiControl,, EnableText, %EnableText%
    GuiControl,, EnableOthersText, %EnableOthersText%
    GuiControl,, DisableText, %DisableText%
    GuiControl,, DisableOthersText, %DisableOthersText%
    GuiControl,, EnableDisableText, %EnableDisableText%
    GuiControl,, InvertText, %InvertText%
}


ListGUIClose:
ListGUIEscape:
    ; scriptlog("Exiting...")
    ExitApp
    return