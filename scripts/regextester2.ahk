ScriptName = AHK RegEx Tester
Version = 2.1
;by toralf
;requires AHK 1.0.46+
;www.autohotkey.com/forum/topic17844.html

/*
Version history:

2.1)
- subpattern can be encapsulated (thanks titan)
- tab with text fields allow theme (thanks titan)  
- a small fix for the layout of the result
2)
- script generates ini file right next to script to store data
- remembers last position and size of GUI (thanks majkinetor)
- up to 10 regex can be stored (thanks majkinetor)
- haystack is remembered between sessions (thanks majkinetor)
- regex can be copied to clipboard with a button (thanks Helpy)
1)
- Initial release
*/

;Get script/app name
SplitPath, A_ScriptName, , , , OutNameNoExt
;get ini file name
IniFile = %OutNameNoExt%.ini

SeparatorChars = @µ§&#°¤¶®©¡¦
DefaultSeparator = @
DefaultRegEx = The (.*?) (?P<Name>.*?) (.*?) (.*?) the
DefaultHaystack = The quick brown fox jumps over the street.

Separator := ReadIniKey("RegEx","Separator",DefaultSeparator)
RegExList := ReadIniKey("RegEx","RegEx",DefaultRegEx)
StringReplace, RegExList, RegExList, %Separator%, `n, All

Separator := ReadIniKey("Haystack","Separator",DefaultSeparator)
Haystack := ReadIniKey("Haystack","Haystack",DefaultHaystack)
StringReplace, Haystack, Haystack, %Separator%, `n, All

Gui, 1:+Resize +MinSize +LastFound +Delimiter`n
Gui1HWND := WinExist()
Gui, 1:Add, Text, , Haystack
Gui, 1:Add, Edit, w220 r8 vEdtHaystack gEvaluateRegEx , %Haystack%   
Gui, 1:Add, Text, w220, Needle (RegEx)`nNote: Use \n instead of ``n, etc.`nUnlike in AHK quotes (") must not be escaped.  
Gui, 1:Add, ComboBox, w220 r10 vCbbRegEx gEvaluateRegEx , %RegExList%
GuiControl, Choose, CbbRegEx, 1 
Gui, 1:Add, Tab,  w220 r2.3 +Theme vTabRegExType gEvaluateRegEx , Match`nReplace
  Gui, 1:Tab, Match
    Gui, 1:Add, Text, Section +BackgroundTrans , OutputVar:
    Gui, 1:Add, Edit, x+2 ys-4 r1 w144 vEdtUnquotedOutputVar gEvaluateRegEx , Out
    Gui, 1:Add, Text, xs Section +BackgroundTrans, StartingPos:
    Gui, 1:Add, Edit, x+2 ys-4 r1 w28 Right vEdtMStartingPos gEvaluateRegEx , 1
    Gui, 1:Add, Text, x+15 ys +BackgroundTrans, # Subpattern:
    Gui, 1:Add, Edit, x+2 ys-4 r1 w28 Right Number vEdtNumSubpattern gEvaluateRegEx , 5
  Gui, 1:Tab, Replace
    Gui, 1:Add, Text, Section +BackgroundTrans, Replacement:
    Gui, 1:Add, Edit, x+2 ys-4 r1 w129 vEdtReplacement gEvaluateRegEx , $3
    Gui, 1:Add, Text, xs Section +BackgroundTrans, Limit:
    Gui, 1:Add, Edit, x+2 ys-4 r1 w28 Right vEdtLimit gEvaluateRegEx , -1
    Gui, 1:Add, Text, x+25 ys +BackgroundTrans, StartingPos:
    Gui, 1:Add, Edit, x+2 ys-4 r1 w28 Right vEdtRStartingPos gEvaluateRegEx , 1
Gui, 1:Tab
Gui, 1:Add, Text, xm, Result 
Gui, 1:Add, Edit, w220 r8 vEdtResult ,
Gui, 1:Add, Button, vBtnClose gGuiClose , Close
Gui, 1:Add, Button, x+10 vBtnStoreRegEx gBtnStoreRegEx , Store Regex
Gui, 1:Add, Button, x+10 vBtnCopyToCB gBtnCopyToCB , Copy Regex
Gui, 1:Show, Hide, %ScriptName% v%Version%
RestoreGuiPosSize(Gui1HWND, 1)  ;restore old size
Gui, 1:Show

GoSub, EvaluateRegEx 
Return

;user has changed any data in the gui
; => update the regex result
EvaluateRegEx:
  If UpdateComboBox
      Return
  Gui, 1:Submit, NoHide                                ;get all data
  If (!CbbRegEx OR !EdtHaystack){    ;if no haystack or needle
      GuiControl, 1:, EdtResult,                            ;no result and
      Return                                                ;ne evaluation
    }
  If (TabRegExType = "Match") {                      ;if match is selected
      ;what results need to be shown
      IsOutputVar := False                           ;set default options
      IsPositionAndLength := False
      If EdtUnquotedOutputVar is not space           ;output var is wanted
        {
          IsOutputVar := True                        ;set option
          
          Loop, %EdtNumSubpattern% {                 ;set internal vars to nothing
              Output%A_Index% =
              OutputPos%A_Index% =
              OutputLen%A_Index% =
            }
          
/* original regex to get the subpattern specified in CbbRegEx, not allowing encapsulation of subpattern
"s)(?<!\\)\((?:\?(?:P?<(\w+)>|'(\w+)')).+?(?<!\\)\)"
s)                                                 ;dotall 
  (?<!\\)                                          ;no \ before
         \(                                        ;a "("
           (?:                                     ;no subpattern start
              \?                                   ;a "?"
                (?:                                ;no subpattern start
                   P?                              ;maybe a "P"
                     <(\w+)>                       ;a subpattern word enclosed with "<>"
                            |                      ;or
                             '(\w+)'               ;a subpattern word enclosed with "''"
                                    )              ;no subpattern end
                                     )             ;no subpattern end
                                      .+?          ;any ungreedy text
                                         (?<!\\)   ;no \ before
                                                \) ;a ")"
*/ 
                                              
/* simplified regex to get the subpattern specified in CbbRegEx, allowing encapsulation of subpattern
"(?<!\\)\((?:\?P?<(\w+)>|'(\w+)')"
(?<!\\)                           ;no \ before
       \(                         ;a "("
         (?:                      ;no subpattern start
            \?                    ;a "?"
               P?                 ;maybe a "P"
                 <(\w+)>          ;a subpattern word enclosed with "<>"
                        |         ;or
                         '(\w+)'  ;a subpattern word enclosed with "''"
                                ) ;no subpattern end
*/                                               
          pos = 1                                    ;get named subpattern
          sub = 0
        	Loop{
          		If pos := RegExMatch(CbbRegEx,"(?<!\\)\((?:\?P?<(\w+)>|'(\w+)')", Name , pos)
          		  {
            			sub++                              ;subpattern index
            			Name0 := Name1 = "" ? Name2 : Name1
                  Output%Name0% =                    ;set subpattern var to nothing 
                  OutputPos%Name0% =
                  OutputLen%Name0% =
                  sub%sub% := Name0                  ;subpattern array
                  pos += StrLen(Name)                ;calculate next starting position
                }
          		Else Break                             ;no more named subpattern found
            }

          If RegExMatch(CbbRegEx, "^[\w`]*P[\w`]*\)")  ;Positions and length are wanted
              IsPositionAndLength := True
        }
          
      ;do the regex
      FoundPos := RegExMatch(EdtHaystack, CbbRegEx, Output, EdtMStartingPos)

      ;show results
      Result = ErrorLevel = %ErrorLevel%`nFoundPos = %FoundPos%`n
      
      If IsOutputVar {                               ;show output var results
          Result .= EdtUnquotedOutputVar " = " Output "`n"

        	Loop, %sub% {                                ;named subpattern
              If A_index = 1
                  Result .= "`n------- Named subpattern --------`n"
              If IsPositionAndLength {
                  T := "OutputPos" sub%A_Index%
                  Result .= EdtUnquotedOutputVar "Pos" sub%A_Index% " = " %T% "`n"
                  T := "OutputLen" sub%A_Index%
                  Result .= EdtUnquotedOutputVar "Len" sub%A_Index% " = " %T% "`n"
              }Else{
            	    T := "Output" sub%A_Index%
                  Result .= EdtUnquotedOutputVar sub%A_Index% " = " %T% "`n"
                }
        	  }

          If (EdtNumSubpattern > 0) {                ;numbered subpattern
              Result .= "`n------- Subpattern --------`n"
              Loop, %EdtNumSubpattern% {
                  If IsPositionAndLength {
                      Result .= EdtUnquotedOutputVar "Pos" A_Index " = " OutputPos%A_Index% "`n"
                      Result .= EdtUnquotedOutputVar "Len" A_Index " = " OutputLen%A_Index% "`n"
                  }Else
                      Result .= EdtUnquotedOutputVar A_Index " = " Output%A_Index% "`n"
                }
            }
        }
  }Else {                                            ;replace is selected
      ;do regex
      NewStr := RegExReplace(EdtHaystack, CbbRegEx, EdtReplacement, Count, EdtLimit, EdtRStartingPos)

      ;show result
      Result = ErrorLevel = %ErrorLevel%`nCount = %Count%`nNewStr = %NewStr%`n
    }
  GuiControl, 1:, EdtResult, %Result%                ;update gui
Return              

BtnCopyToCB:
  Gui, 1:Submit, NoHide
  Clipboard = %CbbRegEx%
Return

BtnStoreRegEx:
  Gui, 1:Submit, NoHide
  RegExList := StoreRegEx(RegExList, CbbRegEx)
Return

StoreRegEx(RegExList, CbbRegEx){
    Global UpdateComboBox
    RegExList = %CbbRegEx%`n%RegExList%     ;add current regex
    StringSplit, RegExList, RegExList, `n   ;create an array
    RegExList =                             ;empty list
    Loop, %RegExList0% {                    ;loop though array
        ID := A_Index
        AlreadyInList := False              ;check if item is already in list
        Loop, % ID - 1 {
            If (RegExList%ID% == RegExList%A_Index%) {
                AlreadyInList := True
                Break
              }
          } 
        If !AlreadyInList {                 ;if item is not in list, add him
            RegExList .= RegExList%ID% "`n"
            i++                             ;stop after 10 items
            If (i = 10)
                Break
          }        
      }
    StringTrimRight, RegExList, RegExList, 1   ;remove last `n
    GuiControl, 1:, CbbRegEx, `n%RegExList%    ;update combobox
    GuiControl, 1:Choose, CbbRegEx, 1
    Return RegExList
  }

GuiClose:
  Gui, 1:Submit, NoHide
  StoreListInIni("Haystack", EdtHaystack)
  StoreListInIni("RegEx", RegExList)
  StoreGuiPosSize(Gui1HWND, 1)  
  ExitApp
Return

StoreListInIni(Name, List){
    Global SeparatorChars
    Loop, Parse, SeparatorChars
      {
        If (InStr(List, A_LoopField) = 0){
            Separator = %A_LoopField%
            Break
          } 
      } 
    StringReplace, List, List, `n , %Separator%, All
    WriteIniKey(Name, "Separator", Separator)
    WriteIniKey(Name, Name, List)
  }

;return key value from ini file
ReadIniKey(Section,Key,Default=""){
    global IniFile
    DefaultTestValue = kbcewlkj1u234z98hr2310587fh
    IniRead, KeyValue, %IniFile%, %Section%, %Key%, %DefaultTestValue%
    If (KeyValue = DefaultTestValue) {
        WriteIniKey(Section,Key,Default)
        KeyValue = %Default%
      } 
    Return KeyValue
  }

;write key value to ini file
WriteIniKey(Section,Key,KeyValue){
    global IniFile
    IniWrite, %KeyValue%, %IniFile%, %Section%, %Key%
  }

;restore previous gui position and size
RestoreGuiPosSize(GuiUniqueID, GuiID = 1){
    GuiX := ReadIniKey("Gui" GuiID,"GuiX","")
    GuiY := ReadIniKey("Gui" GuiID,"GuiY","")
    GuiW := ReadIniKey("Gui" GuiID,"GuiW","")
    GuiH := ReadIniKey("Gui" GuiID,"GuiH","")
    DetectHiddenWindows, On
    WinMove, ahk_id %GuiUniqueID%, , %GuiX%, %GuiY%, %GuiW%, %GuiH%
    DetectHiddenWindows, Off
  }

;store current gui position and size
StoreGuiPosSize(GuiUniqueID, GuiID = 1){
    WinGetPos, GuiX, GuiY, GuiW, GuiH, ahk_id %GuiUniqueID%
    If (GuiX > -100 AND GuiX < A_ScreenWidth - 20){
        WriteIniKey("Gui" GuiID, "GuiX", GuiX)
        WriteIniKey("Gui" GuiID, "GuiY", GuiY)
        WriteIniKey("Gui" GuiID, "GuiW", GuiW)
        WriteIniKey("Gui" GuiID, "GuiH", GuiH)
      }
  }

GuiSize:
  Anchor("EdtHaystack","w")
  Anchor("CbbRegEx","w")
  Anchor("TabRegExType","w")
  Anchor("EdtUnquotedOutputVar","w")
  Anchor("EdtReplacement","w")
  Anchor("EdtResult","wh")
  Anchor("BtnClose","y")
  Anchor("BtnStoreRegEx","y")
  Anchor("BtnCopyToCB","y")
Return

Anchor(c, a, r = false) { ; v3.5.1 - Titan
  	static d
  	GuiControlGet, p, Pos, %c%
  	If !A_Gui or ErrorLevel
  		Return
  	i = x.w.y.h./.7.%A_GuiWidth%.%A_GuiHeight%.`n%A_Gui%:%c%=
  	StringSplit, i, i, .
  	d .= (n := !InStr(d, i9)) ? i9 :
  	Loop, 4
  		x := A_Index, j := i%x%, i6 += x = 3
  		, k := !RegExMatch(a, j . "([\d.]+)", v) + (v1 ? v1 : 0)
  		, e := p%j% - i%i6% * k, d .= n ? e . i5 : ""
  		, RegExMatch(d, RegExReplace(i9, "([[\\\^\$\.\|\?\*\+\(\)])", "\$1")
  		. "(?:([\d.\-]+)/){" . x . "}", v)
  		, l .= InStr(a, j) ? j . v1 + i%i6% * k : ""
  	r := r ? "Draw" :
  	GuiControl, Move%r%, %c%, %l%
  }