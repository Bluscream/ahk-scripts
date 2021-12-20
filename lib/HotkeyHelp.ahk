Files_Excluded 	:= " "

; File Name for Exported Help Dialog
TextOut_FileName := "HotKey Help - Dialog.txt"

; Long or Short Hotkey and Hotstring Names (Modifier Order Matters)
; Hot_Excluded 	:= "Win+Ctrl+Alt+Escape|If|IfWinActive|#a|fyi|brb"
Hot_Excluded 	:= " "

; Text File Extension List for Text Help Files
Text_Ext_List := [
(Join,
"txt"
)]

; Spacing for Position of Information Column in Help Dialog
Pos_Info = 25

; Parse Delimiter and OmitChar.  Sometimes changing these can give better results.
Parse_Delimiter := "`n"
Parse_OmitChar := "`r" 

; Default Settings if Not Changed by Ini File
Set_ShowBlank		= 1
Set_ShowBlankInclude	= 1
Set_ShowExe		= 1
Set_ShowHotkey		= 1	; Hotkeys created with the Hotkey Command Tend to be Unusal
Set_VarHotkey		= 1	; Attempt to Resolve a Variable Used in Hotkeys Definition
Set_FlagHotkey		= 1	; Flag Hotkeys created with the Hotkey Command with <HK>
Set_ShowString		= 1
Set_AhkExe		= 1
Set_AhkTxt		= 1
Set_AhkTxtOver		= 1
Set_SortInfo		= 1
Set_CapHotkey		= 1	; Set to 0 to not change Capitalization of Hotkey, 1 for Capitalization as Determined by Set_CapHotkey_Radio
Set_CapHotkey_Radio	= 1	; Set to 1 to use Title Capitalization, 2 for UPPER Capitalization
Set_HideFold		= 1
Set_TextOut		= 0	; Set to 1 to automatically create text file output of Help Dialog
Set_FindPos		= 1
Set_IniSet		= 1	; Set to 0 to Use Defaults Settings and Not Use INI File
Set_IniExcluded		= 1	; Set to 0 to Use Default Excluded Information and Not Use INI File
Set_Hotkey_Mod_Delimiter := "+"	; Delimiter Character to Display Between Hotkey Modifiers
SearchEdit.Docked := true

; SUBROUTINES
;{-----------------------------------------------
;

; Get Value of Variable From Script Dialog
HotkeyVariable(Script,Variable)
{
	static
	Var := Trim(Variable," %")
	If !Script_List
		Script_List := {}
	if !Script_List[Script]
	{
		DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
		SetTitleMatchMode 2
		WinMove, %Script%,,A_ScreenWidth, A_ScreenHeight
		PostMessage, 0x111, 65407, , , %Script%
		ControlGetText, Text, Edit1, %Script%
		WinHide, %Script%
		Script_List[Script] := Text
	}
	Pos := RegExMatch(Script_List[Script], Var ".*\:(.*)",Match)
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	if (Pos and Match1)
		return Match1
	else
		return Variable
}

; Get Hotkeys From Script Dialog
ScriptHotkeys(Script)
{
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	SetTitleMatchMode 2
	WinMove, %Script%,,A_ScreenWidth, A_ScreenHeight
	if (Script = A_ScriptFullPath)
		ListHotkeys
	else
		PostMessage, 0x111, 65408, , , %Script%
	ControlGetText, Text, Edit1, %Script%
	WinHide, %Script%
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	Result := {}
	Loop, Parse, Text, `n, `r
	{
		Pos := RegExMatch(A_LoopField,"^[(reg|k|m|2|joy)].*\t(.*)$",Match)
		if Pos
			Result.Insert(Match1)
	}
	return Result
}

; Expand File Path
Get_Full_Path(path) 
{
	Loop, %path%, 1
		return A_LoopFileLongPath
	return path
}

; Add Character Wings to Each Side of String to Create Graphical Break
String_Wings(String,Length:=76,Char:="=",Case:="U")
{
	if (Case = "U")
		StringUpper, String, String
	else if (Case = "T")
		StringUpper, String, String, T
	else if (Case = "L")
		StringLower, String, String
	WingX1 := Round(((Length-StrLen(String))/2)/StrLen(Char)-.5)
	WingX2 := Round((Length-StrLen(String)-(WingX1*StrLen(Char)))/StrLen(Char)+.5)
	loop %WingX1%
		Wing_1 .= Char
	loop %WingX2%
		Wing_2 .= Char
	return SubStr(Wing_1 String Wing_2,1,Length)
}

; Format Spaces Between Hot Keys and Help Info to Create Columns
Format_Line(Hot,Info,Pos_Info)
{
	Spaces := ""
	Length := Pos_Info - StrLen(Hot) - 1
	Loop %Length%
		Spaces .= " "
	return Hot Spaces Info
}

; Reference One Branch of Array and Return Corrisponding Information on Cross Branch
ArrayCrossRef(Array, Haystack, Needle, Cross)
{
	for index, element in Array
		if (Needle = element[Haystack])
			return element[Cross]
	return
}
;}

; CLASSES
;{-----------------------------------------------
;

; [Class] SearchEdit - Find Text within Edit Control (Edit Control Must have +0x100 Style for Unfocused Highlights)
class SearchEdit
{
	Dialog(pGuiControlID, pOffset:=3, pFindInput := "")
	{
		static
		GuiControlID := pGuiControlID ; assign to static method variable
		SearchEdit.Offset := pOffset ; assign to class variable
		SearchEdit.ParentID := DllCall("GetParent", UInt, GuiControlID) ; assign to class variable
		SysGet, Area, MonitorWorkArea ; AreaLeft, AreaRight, AreaBottom, AreaTop
		if !GuiFindID
		{
			Gui SearchEdit_Dialog:Default
			Gui -Caption +HwndGuiFindID +ToolWindow +Owner%GuiControlID%
			Gui Add, Edit, x10 y3 w200 r2 gFindText_Sub vFindText_Var -VScroll
			GuiControl, Move, FindText_Var, h20
			Gui Add, StatusBar, gStatusBar, `tType Find string and press Enter
			SearchEdit.GuiFindID := GuiFindID ; assign to class variable
			if !IsObject(SearchEdit.UnDock)
				SearchEdit.Docked := true
		}
		if (pFindInput = "")
		{
			Found := false, StartingPos := 1
			WinGetPos, X, Y, W, H, % "ahk_id " SearchEdit.ParentID
			Calc := SearchEdit.Calc_Position(X, Y, W, H)
			Gui SearchEdit_Dialog:Show, % "h" Calc.H " w" Calc.W " x" Calc.X " y" Calc.Y
			SearchEdit.Visible := true
			OnMessage(0x201, ObjBindMethod(SearchEdit, "WM_LBUTTONDOWN"))
			OnMessage(0x47, ObjBindMethod(SearchEdit,"WM_WINDOWPOSCHANGED"))
			return
		}
		if (FindInput<>pFindInput)
			Found := false, StartingPos := 1
		FindInput := pFindInput				
		WrapToTop:
		StartingPos := SearchEdit.FindText(FindInput, GuiControlID,, StartingPos)
		GuiControl,, FindText_Var, %FindInput%
		Send ^{Right}
		if !StartingPos
		{
			SendMessage 0xB1, -1,,, ahk_id %GuiControlID%  ; EM_SETSEL ; Deselect
			if Found
			{
				Found := false, StartingPos := 1
				goto WrapToTop
			}
			MsgBox % "NOT FOUND:`n`n" FindInput
			GuiControl,, FindText_Var
			Found := false, StartingPos := 1
		}
		else
			Found := true
		return
		FindText_Sub:
			Gui SearchEdit_Dialog:Submit, NoHide
			if !(InStr(FindText_Var, "`n"))
				return
			SearchEdit.Dialog(GuiControlID, SearchEdit.Offset, Trim(FindText_Var, "`n"))
		return
		SearchEdit_DialogGuiEscape:
			Gui SearchEdit_Dialog:Hide
			SearchEdit.Visible := false
		return
		StatusBar: ; Double Click
			SearchEdit.Docked := true
			WinGetPos, X, Y, W, H, % "ahk_id " SearchEdit.ParentID
			Calc := SearchEdit.Calc_Position(X, Y, W, H)
			Gui SearchEdit_Dialog:Show, % "h" Calc.H " w" Calc.W " x" Calc.X " y" Calc.Y
		return
	}
	FindText(FindText, GuiControlID, CaseSensitive:=false, StartingPos:=1, Occurance:=1)
	{
		GuiControlGet, Text,, %GuiControlID%
		Text := RegExReplace(Text, "\R", "`r`n")
		if !(Pos := InStr(Text, FindText, CaseSensitive, StartingPos, Occurance))
			return
		StartingPos := Pos - 1
		EndingPos := StartingPos + StrLen(FindText)
		SendMessage 0xB1, StartingPos, EndingPos,, ahk_id %GuiControlID%  ; EM_SETSEL
		SendMessage 0xB7, 0, 0,, ahk_id %GuiControlID%         ;- EM_SCROLLCARET
		return EndingPos + 1 ; Start Position for Next Search
	}
	WM_LBUTTONDOWN() ; Private Method
	{
		If (A_Gui = "SearchEdit_Dialog")
		{
			PostMessage, 0xA1, 2,,,A
			SearchEdit.Docked := false
			Sleep 20
			WinGetPos, X, Y, W, H, % "ahk_id " SearchEdit.ParentID
			WinGetPos, gX, gY, gW, gH, % "ahk_id " SearchEdit.GuiFindID
			SearchEdit.UnDock := {"deltaX":gX-X, "deltaY":gY-Y}
		}
	}
	WM_WINDOWPOSCHANGED(wParam, lParam, msg, Hwnd) ; Private Method
	{
		
		if (Hwnd != SearchEdit.ParentID or !SearchEdit.Visible)
			return
		if !WinExist("ahk_id " Hwnd)
		{
			Gui SearchEdit_Dialog:Hide
			return
		}
		X := NumGet(lParam+0, A_PtrSize + A_PtrSize, "int")
		Y := NumGet(lParam+0, A_PtrSize + A_PtrSize + 4, "int")
		W := NumGet(lParam+0, A_PtrSize + A_PtrSize + 8, "int")
		H := NumGet(lParam+0, A_PtrSize + A_PtrSize + 12, "int")
		Flags := NumGet(lParam+0, A_PtrSize + A_PtrSize + 16)
		if (Flags = 6147 or Flags = 6163 or Flags = 33072 or Flags = 33060) ; Minimize/Restore
			return
		Calc := SearchEdit.Calc_Position(X, Y, W, H)
		Gui SearchEdit_Dialog:Show, % "h" Calc.H " w" Calc.W " x" Calc.X " y" Calc.Y
	}
	Calc_Position(X, Y, W, H) ; Private Method
	{
		guiO := SearchEdit.Offset ; assign Class variable for convenience
		guiH:=45, guiW:=220 ; Gui - Base Height, Base Width
		if !SearchEdit.Docked
			return {"h":guiH, "w":guiW, "x":X+SearchEdit.UnDock.deltaX, "y":Y+SearchEdit.UnDock.deltaY}
		SysGet, Area, MonitorWorkArea ; AreaLeft, AreaRight, AreaBottom, AreaTop
		scaleH := Floor(guiH*A_ScreenDPI/96), scaleW := Floor(guiW*A_ScreenDPI/96) ; Adjust for different DPI screens
		if (Y+H+scaleH-guiO < AreaBottom)
			return {"h":guiH, "w":guiW, "x":X+guiO, "y":Y+H-guiO} ; bottom under outside
		else if (X+W+scaleW-guiO < AreaRight)
			return {"h":guiH, "w":guiW, "x":X+W-guiO, "y":Y+H-guiO-scaleH} ; bottom right outside
		else if (X-scaleW > AreaLeft)
			return {"h":guiH, "w":guiW, "x":X-scaleW+guiO, "y":Y+H-scaleH-guiO} ; bottom left outside
		else
			return {"h":guiH, "w":guiW, "x":X+W-scaleW-guiO, "y":Y+H-scaleH-guiO} ; bottom right inside
	}
}
;}


; FUNCTIONS - LIBRARY
;{-----------------------------------------------
;

;{ AHKScripts
; Fanatic Guru
; 2014 03 31
;
; FUNCTION that will find the path and file name of all AHK scripts running.
;
;---------------------------------------------------------------------------------
;
; Method:
;   AHKScripts(ByRef Array)
;
; Parameters:
;   1) {Array} variable in which to store AHK script path data array
;
; Returns:
;   String containing the complete path of all AHK scripts running
;   One path per line of string, delimiter = `n
;
; ByRef:
;   Populates {Array} passed as parameter with AHK script path data
;     {Array}.Path
;     {Array}.Name
;     {Array}.Dir
;     {Array}.Ext
;     {Array}.Title
;     {Array}.hWnd
;
; Example Code:
/*
	MsgBox % AHKScripts(Script_List)
	for index, element in Script_List
		MsgBox % "#:`t" index "`nPath:`t" element.Path "`nName:`t" element.Name "`nDir:`t" element.Dir "`nExt:`t" element.Ext "`nTitle:`t" element.Title "`nhWnd:`t" element.hWnd
	return
*/
AHKScripts(ByRef Array)
{
	DetectHiddenWindows, % (Setting_A_DetectHiddenWindows := A_DetectHiddenWindows) ? "On" :
	WinGet, AHK_Windows, List, ahk_class AutoHotkey
	Array := {}
	list := ""
	Loop %AHK_Windows%
	{
		hWnd := AHK_Windows%A_Index%
		WinGetTitle, Win_Name, ahk_id %hWnd%
		File_Path := RegExReplace(Win_Name, "^(.*) - AutoHotkey v[0-9\.]+$", "$1")
		SplitPath, File_Path, File_Name, File_Dir, File_Ext, File_Title
		Array[A_Index,"Path"] := File_Path
		Array[A_Index,"Name"] := File_Name
		Array[A_Index,"Dir"] := File_Dir
		Array[A_Index,"Ext"] := File_Ext
		Array[A_Index,"Title"] := File_Title
		Array[A_Index,"hWnd"] := hWnd
		list .= File_Path "`n"
		
	}
	DetectHiddenWindows, %Setting_A_DetectHiddenWindows%
	return Trim(list, " `n")
}
;}
;}

