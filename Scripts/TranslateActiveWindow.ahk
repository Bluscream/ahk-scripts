#SingleInstance Force

#Include <translate>
#Include <obj2str>
#Include <bluscream>

#t::
    translateActiveWindow()
    Return

translateActiveWindow(){
    WinGetActiveTitle, win_title
    ; WinGetClass, win_class, win_title
    WinGet, win_id, ID, A
    ; title := win_title . " ahk_class " . win_class . " ahk_id " . win_id
    title := "ahk_id " . win_id
    ; MsgBox, % title
    WinGet, win_cntrls, ControlList, A
    cntrl_texts := Object()
    msg := "Active Window: " . win_title . "`n" ; todo: remove
    Loop,Parse,win_cntrls,`n
    {
        txt := getText(title, A_LoopField)
        msg .= "Index: " . A_Index . " Field: " . A_LoopField . " Text: " . txt . "`n" ; todo: remove
        txt := Trim(txt)
        if (txt) {
            cntrl_texts[A_LoopField] := txt
        }
    }
    ; MsgBox % msg ; todo: remove
    cntrl_texts_len := cntrl_texts.GetCapacity()
    if (!cntrl_texts_len){
        MsgBox,, % win_title, % "Found nothing to translate"
        return
    }
    totranslate := ""
    trseperator := " ``´`` "
    For cntrl, value in cntrl_texts
        totranslate .= value . trseperator
    if (!totranslate){
        MsgBox,, % win_title, % "No Text to translate"
        return
    }
    MsgBox % totranslate
    trresult := GoogleTranslate(totranslate)
    if (!trresult){
        MsgBox,, % win_title, % "Error while translating!"
        return
    }
    ; MsgBox % trresult
    cntrl_translated := StrSplit(trresult[1], trseperator)
    cntrl_texts_translated := ObjFullyClone(cntrl_texts)
    For cntrl, value in cntrl_texts
        cntrl_texts_translated[cntrl] = cntrl_translated[A_Index]
    MsgBox % obj2str(cntrl_texts) . "`n`n" . obj2str(cntrl_texts_translated) . "`n`n" . trresult[4]
    For cntrl, value in cntrl_texts_translated
        setText(title, cntrl, value)
}

getText(window, cntrl) {
    static WM_GETTEXTLENGTH := 0xE , WM_GETTEXT := 0xD
    SendMessage, WM_GETTEXTLENGTH, 0, 0,, % window
    len := ErrorLevel
    VarSetCapacity(txt, len*(A_IsUnicode ? 2 : 1)+1, 0)
    SendMessage, WM_GETTEXT, len+1, &txt, % cntrl, % window
    return txt
}
setText(window, cntrl, txt) {
    ; static WM_SETTEXT := 0x0C 
    ; SendMessage, WM_SETTEXT, 0, % txt, % cntrl, % window
    ControlSetText, % cntrl, % txt, % window
    ; MsgBox, % "Set " . cntrl . " to " . txt
}

ObjFullyClone(obj) {
	nobj := obj.Clone()
	for k,v in nobj
		if IsObject(v)
			nobj[k] := A_ThisFunc.(v)
	return nobj
}