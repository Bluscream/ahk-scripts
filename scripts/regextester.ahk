;
; Original Script can be found at:
; http://www.autohotkey.com/board/topic/81045-regular-expression-tester/
; this script can be found at:
; https://www.autohotkey.com/boards/viewtopic.php?f=6&t=77133#p334841
;

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

/*
    Regex Tester - A front end for testing Perl Compatible Regular Expressions.
                   The results update in realtime and any setting or expression
                   errors are highlighted in red.
                   
                   Alt+C will copy the currently displayed expression to the Clipboard.
    
    Version 1.0
    from 5-29-2012
    By Robert Ryan
    
    updated 6.10.2020
    by toralf
    - GUI resizable
    - Errorlevel text is show when needle is wrong
    - fixed: Match results were shown from previous correct needle when needle was wrong
    - RegEx Option `n, `r and `a are now handled via checkboxes, since edit control doesn't handle them well

    updated 15.6.2020
    by toralf
    - added ability to have Needles broken up in multiple lines with comments
    
*/

; AutoeExecute
    #NoEnv
    #SingleInstance force

    gosub MakeGui
    gosub UpdateMatch
    gosub UpdateReplace
    Gui Show, , RegEx Tester - v15.06.2020
return

#IfWinActive Regex Tester
!c::
    Gui Submit, NoHide
    ClipBoard := (TabSelection = "RegExMatch") ? mNeedle : rNeedle
    MsgBox, 64, RegEx Copied, %Clipboard% has been copied to the Clipboard, 3
return

GuiEscape:
GuiClose:
    ExitApp
return

RemoveComments(Line){
  If !(Pos := InStr(Trim(Line), ";"))
    Return Line             ; no quote character in this line

  If (Pos = 1)
    Return                  ; whole line is pure comment

  ;remove comments (first clean line of quotes strings)
  If (Pos := RegExMatch(RemoveQuotedStrings(Line), "\s+;.*$"))
    Line := SubStr(Line, 1, Pos - 1)

  Return Line
}

RemoveQuotedStrings(Line){
  ;the concept how to remove quoted strings was taken from CoCo's ListClasses script (line 77; http://ahkscript.org/boards/viewtopic.php?p=43349#p42793)
  ;replace quoted strings with dots and dashes to keep length of line constant, and that other character positions do not change
  static q := Chr(34)       ; quote character

  ;Replace quoted literal strings             1) replace two consecutive quotes with dots
  CleanLine := StrReplace(Line, q . q, "..")

  Pos := 1                                 ;  2) replace ungreedy strings in quotes with dashes
  Needle := q . ".*?" . q
  While Pos := RegExMatch(CleanLine, Needle, QuotedString, Pos){
    ReplaceString =
    Loop, % StrLen(QuotedString)
       ReplaceString .= "-"
    CleanLine := RegExReplace(CleanLine, Needle, ReplaceString, Count, 1, Pos)
  }
  Return CleanLine
}

; This is called any time any of the edit boxes on the RegExMatch tab are changed.
UpdateMatch:
    Gui Submit, NoHide
    
    if not IsInteger(mStartPos) {
        mStartPos := 1
        Gui Font, cRed 
        GuiControl Font, mStartPos
    }else {
        Gui Font, cDefault
        GuiControl Font, mStartPos
    }
    
    ;when needle is broken in several lines comments are stripped off every line and lines with text are concatenated
    LineArray := StrSplit(mNeedle, "`n", "`r")
    If (LineArray.MaxIndex() > 1) {
      tmp =
      For i, Line in LineArray
        If (CleanLine := RemoveComments(Trim(Line)))
          tmp .= CleanLine
      mNeedle := tmp
    }
    ; Set Needle to return an object ( O maybe set even twice)
    mNeedle := RegExReplace(mNeedle, "^(\w*)\)", "O$1)", cnt)
    if (! cnt) {
        mNeedle := "O)" mNeedle
    }

    If mLF
      mNeedle := "`n" mNeedle
    If mCR
      mNeedle := "`r" mNeedle
    If mAnyCRLF
      mNeedle := "`a" mNeedle    

    Match =
    FoundPos := RegExMatch(mHaystack, mNeedle, Match, mStartPos)
    if (ErrLvl := ErrorLevel) {
        Gui Font, cRed 
        GuiControl Font, mNeedle
        ResultText := "FoundPos: " FoundPos "`n" 
                    . "ErrorLevel: `n" ErrLvl "`n`n"
                    . "Needle: `n""" mNeedle """`n`n"
    }else {
        Gui Font, cDefault
        GuiControl Font, mNeedle
        ResultText := "FoundPos: " FoundPos "`n"
        ResultText .= "Match: " Match.Value() "`n"
                   . "Needle: `n""" mNeedle """`n`n"
        Loop % Match.Count() {
            ResultText .= "Match["
            ResultText .= (Match.Name[A_Index] = "") 
                        ? A_Index 
                        :  Match.Name[A_Index] 
            ResultText .= "]: " Match[A_Index] "`n"
                       
        }
    }
    
    GuiControl, , mResult, %ResultText%
return

; This is called any time any of the edit boxes on the RegExReplace tab are changed.
UpdateReplace:
    Gui Submit, NoHide
    
    If not IsInteger(rStartPos) {
        rStartPos := 1
        Gui Font, cRed 
        GuiControl Font, rStartPos
    }Else {
        Gui Font, cDefault
        GuiControl Font, rStartPos
    }
    
    If not IsInteger(rLimit) {
        rLimit := -1
        Gui Font, cRed 
        GuiControl Font, rLimit
    }Else {
        Gui Font, cDefault
        GuiControl Font, rLimit
    }
    
    ;when needle is broken in several lines comments are stripped off every line and lines with text are concatenated
    LineArray := StrSplit(rNeedle, "`n", "`r")
    If (LineArray.MaxIndex() > 1) {
      tmp =
      For i, Line in LineArray
        If (CleanLine := RemoveComments(Trim(Line)))
          tmp .= CleanLine
      rNeedle := tmp
    }

    If rLF
      rNeedle := "`n" rNeedle
    If rCR
      rNeedle := "`r" rNeedle
    If rAnyCRLF
      rNeedle := "`a" rNeedle    
    
    NewStr := RegExReplace(rHaystack, rNeedle, rReplacement, rCount, rLimit, rStartPos)
    If (ErrLvl := ErrorLevel) {
        Gui Font, cRed 
        GuiControl Font, rNeedle
        ResultText := "Count: " rCount "`n" 
                    . "ErrorLevel: `n" ErrLvl "`n`n"
                    . "Needle: `n""" rNeedle """`n`n"
    }Else {
        Gui Font, cDefault
        GuiControl Font, rNeedle
        ResultText := "Count: " rCount "`n" 
                    . "NewStr: `n" NewStr
    }
    
    GuiControl, , rResult, %ResultText%
return

MakeGui:
    Gui, +ReSize +MinSize
    Gui Font, s10, Consolas
    Gui Add, Tab2, r25 w430 vTabSelection, RegExMatch|RegExReplace
    
    Gui Tab, RegExMatch
        Gui Add, Text, , Text to be searched:
        Gui Add, Edit, r10 w400 vmHaystack gUpdateMatch
        Gui Add, Text, Section vmTxtRegEx, Regular Expression:  Option
        Gui Add, Checkbox, x+2 vmLF gUpdateMatch, ``n
        Gui Add, Checkbox, x+2 vmCR gUpdateMatch, ``r
        Gui Add, Checkbox, x+2 vmAnyCRLF gUpdateMatch, ``a
        Gui Add, Edit, xs r5 w305 vmNeedle gUpdateMatch
        Gui Add, Text, x+15 ys vmTxtStart, Start: (1)
        Gui Add, Edit, r1 w75 vmStartPos gUpdateMatch, 1
        Gui Add, Text, xs vmTxtResult, Results:
        Gui Add, Edit, r14 w400 +readonly -TabStop vmResult
        
    Gui Tab, RegExReplace
        Gui Add, Text, , Text to be searched:
        Gui Add, Edit, r10 w400 vrHaystack gUpdateReplace, 
        Gui Add, Text, Section vrTxtRegEx, Regular Expression:  Option
        Gui Add, Checkbox, x+2 vrLF gUpdateReplace, ``n
        Gui Add, Checkbox, x+2 vrCR gUpdateReplace, ``r
        Gui Add, Checkbox, x+2 vrAnyCRLF gUpdateReplace, ``a
        Gui Add, Edit, xs r5 w305 vrNeedle gUpdateReplace, 
        Gui Add, Text, vrTxtReplace, Replacement Text:
        Gui Add, Edit, r2 w305 vrReplacement gUpdatereplace,
        Gui Add, Text,  vrTxtResult, Results:
        Gui Add, Edit, r10 w400 +readonly -TabStop vrResult
        Gui Add, Text, ys xs+320 Section vrTxtStart, Start: (1)
        Gui Add, Edit, r1 w75 vrStartPos gUpdateReplace, 1
        Gui Add, Text, xs y+15 vrTxtLimit, Limit: (-1)
        Gui Add, Edit, r1 w75 vrLimit gUpdateReplace, -1
return

IsInteger(str) {
    if str is integer
        return true
    else
        return false
}

GuiSize(GuiHwnd, EventInfo, Width, Height){
  AutoXYWH("wh", "TabSelection")
  AutoXYWH("wh0.333", "mHaystack", "rHaystack")
  AutoXYWH("y0.3333", "mTxtRegEx", "rTxtRegEx", "mLF", "mCR", "mAnyCRLF", "rLF", "rCR", "rAnyCRLF")
  AutoXYWH("xy0.3333", "mTxtStart", "rTxtStart", "mStartPos", "rStartPos", "rTxtLimit", "rLimit", "", "")
  AutoXYWH("y0.3333wh0.333", "mNeedle", "")
  AutoXYWH("y0.6666", "mTxtResult", "rTxtResult")
  AutoXYWH("y0.6666wh0.333", "mResult", "rResult")
  
  AutoXYWH("y0.3333wh0.166", "rNeedle")
  AutoXYWH("y0.5wh0.166", "rReplacement")
  AutoXYWH("y0.5", "rTxtReplace", "")
}

AutoXYWH(DimSize, cList*){   ;https://www.autohotkey.com/boards/viewtopic.php?t=1079
  Static cInfo := {}

  If (DimSize = "reset")
    Return cInfo := {}

  For i, ctrl in cList {
    ctrlID := A_Gui ":" ctrl
    If !cInfo.hasKey(ctrlID) {
      ix := iy := iw := ih := 0	
      GuiControlGet i, %A_Gui%: Pos, %ctrl%
      MMD := InStr(DimSize, "*") ? "MoveDraw" : "Move"
      fx := fy := fw := fh := 0
      For i, dim in (a := StrSplit(RegExReplace(DimSize, "i)[^xywh]"))) 
        If !RegExMatch(DimSize, "i)" . dim . "\s*\K[\d.-]+", f%dim%)
          f%dim% := 1

      If (InStr(DimSize, "t")) {
        GuiControlGet hWnd, %A_Gui%: hWnd, %ctrl%
        hParentWnd := DllCall("GetParent", "Ptr", hWnd, "Ptr")
        VarSetCapacity(RECT, 16, 0)
        DllCall("GetWindowRect", "Ptr", hParentWnd, "Ptr", &RECT)
        DllCall("MapWindowPoints", "Ptr", 0, "Ptr", DllCall("GetParent", "Ptr", hParentWnd, "Ptr"), "Ptr", &RECT, "UInt", 1)
        ix := ix - NumGet(RECT, 0, "Int")
        iy := iy - NumGet(RECT, 4, "Int")
      }

      cInfo[ctrlID] := {x:ix, fx:fx, y:iy, fy:fy, w:iw, fw:fw, h:ih, fh:fh, gw:A_GuiWidth, gh:A_GuiHeight, a:a, m:MMD}
    } Else {
      dgx := dgw := A_GuiWidth - cInfo[ctrlID].gw, dgy := dgh := A_GuiHeight - cInfo[ctrlID].gh
      Options := ""
      For i, dim in cInfo[ctrlID]["a"]
        Options .= dim (dg%dim% * cInfo[ctrlID]["f" . dim] + cInfo[ctrlID][dim]) A_Space
      GuiControl, % A_Gui ":" cInfo[ctrlID].m, % ctrl, % Options
} } }