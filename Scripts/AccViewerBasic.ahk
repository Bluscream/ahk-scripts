q:: ;get information from object under cursor, 'AccViewer Basic' (cf. AccViewer.ahk)
ComObjError(False)
oAcc := Acc_ObjectFromPoint(vChildId)
vAccRoleNum := oAcc.accRole(vChildId)
vAccRoleNumHex := Format("0x{:X}", vAccRoleNum)
vAccStateNum := oAcc.accState(vChildId)
vAccStateNumHex := Format("0x{:X}", vAccStateNum)
oRect := Acc_Location(oAcc, vChildId)

vAccName := oAcc.accName(vChildId)
vAccValue := oAcc.accValue(vChildId)
vAccRoleText := Acc_GetRoleText(oAcc.accRole(vChildId))
vAccStateText := Acc_GetStateText(oAcc.accState(vChildId))
vAccStateTextAll := JEE_AccGetStateTextAll(vAccStateNum)
vAccAction := oAcc.accDefaultAction(vChildId)
vAccFocus := oAcc.accFocus
vAccSelection := JEE_AccSelection(oAcc)
StrReplace(vAccSelection, ",",, vCount), vCount += 1
vAccSelectionCount := (vAccSelection = "") ? 0 : vCount
vAccChildCount := oAcc.accChildCount
vAccLocation := Format("X{} Y{} W{} H{}", oRect.x, oRect.y, oRect.w, oRect.h)
vAccDescription := oAcc.accDescription(vChildId)
vAccKeyboard := oAcc.accKeyboardShortCut(vChildId)
vAccHelp := oAcc.accHelp(vChildId)
vAccHelpTopic := oAcc.accHelpTopic(vChildId)
hWnd := Acc_WindowFromObject(oAcc)
vAccPath := "--" ;not implemented
oAcc := ""
ComObjError(True)

;get window/control details
if (hWndParent := DllCall("user32\GetParent", Ptr,hWnd, Ptr))
{
	WinGetTitle, vWinTitle, % "ahk_id " hWndParent
	ControlGetText, vWinText,, % "ahk_id " hWnd
	WinGetClass, vWinClass, % "ahk_id " hWnd

	;control hWnd to ClassNN
	WinGet, vCtlList, ControlList, % "ahk_id " hWndParent
	Loop, Parse, vCtlList, `n
	{
		ControlGet, hCtl, Hwnd,, % A_LoopField, % "ahk_id " hWndParent
		if (hCtl = hWnd)
		{
			vWinClass := A_LoopField
			break
		}
	}
	ControlGetPos, vPosX, vPosY, vPosW, vPosH,, % "ahk_id " hWnd
	WinGet, vPName, ProcessName, % "ahk_id " hWndParent
	WinGet, vPID, PID, % "ahk_id " hWndParent
    usedParent := "Yes"
}
else
{
	WinGetTitle, vWinTitle, % "ahk_id " hWnd
	WinGetText, vWinText, % "ahk_id " hWnd
	WinGetClass, vWinClass, % "ahk_id " hWnd
	WinGetPos, vPosX, vPosY, vPosW, vPosH, % "ahk_id " hWnd
	WinGet, vPName, ProcessName, % "ahk_id " hWnd
	WinGet, vPID, PID, % "ahk_id " hWnd
    usedParent := "No"
}
hWnd := Format("0x{:X}", hWnd)
vWinPos := Format("X{} Y{} W{} H{}", vPosX, vPosY, vPosW, vPosH)

;truncate variables with long text
vList := "vWinText,vAccName,vAccValue"
Loop, Parse, vList, % ","
{
	%A_LoopField% := StrReplace(%A_LoopField%, "`r", " ")
	%A_LoopField% := StrReplace(%A_LoopField%, "`n", " ")
	if (StrLen(%A_LoopField%) > 100)
		%A_LoopField% := SubStr(%A_LoopField%, 1, 100) "..."
}

vOutput = ;continuation section
(
Name: %vAccName%
Value: %vAccValue%
Role: %vAccRoleText% (%vAccRoleNumHex%) (%vAccRoleNum%)
State: %vAccStateText% (%vAccStateNumHex%)
State (All): %vAccStateTextAll%
Action: %vAccAction%
Focused Item: %vAccFocus%
Selected Items: %vAccSelection%
Selection Count: %vAccSelectionCount%
Child Count: %vAccChildCount%

Location: %vAccLocation%
Description: %vAccDescription%
Keyboard: %vAccKeyboard%
Help: %vAccHelp%
HelpTopic: %vAccHelpTopic%

Child ID: %vChildId%
Path: %vAccPath%

WinTitle: %vWinTitle%
Text: %vWinText%
HWnd: %hWnd%
Location: %vWinPos%
Class(NN): %vWinClass%
Process: %vPName%
Proc ID: %vPID%
Used Parent: %usedParent%
)
ToolTip, % vOutput
return

;==================================================

JEE_AccGetStateTextAll(vState)
{
	;sources: WinUser.h, oleacc.h
	;e.g. STATE_SYSTEM_SELECTED := 0x2
	static oArray := {0x1:"UNAVAILABLE"
	, 0x2:"SELECTED"
	, 0x4:"FOCUSED"
	, 0x8:"PRESSED"
	, 0x10:"CHECKED"
	, 0x20:"MIXED"
	, 0x40:"READONLY"
	, 0x80:"HOTTRACKED"
	, 0x100:"DEFAULT"
	, 0x200:"EXPANDED"
	, 0x400:"COLLAPSED"
	, 0x800:"BUSY"
	, 0x1000:"FLOATING"
	, 0x2000:"MARQUEED"
	, 0x4000:"ANIMATED"
	, 0x8000:"INVISIBLE"
	, 0x10000:"OFFSCREEN"
	, 0x20000:"SIZEABLE"
	, 0x40000:"MOVEABLE"
	, 0x80000:"SELFVOICING"
	, 0x100000:"FOCUSABLE"
	, 0x200000:"SELECTABLE"
	, 0x400000:"LINKED"
	, 0x800000:"TRAVERSED"
	, 0x1000000:"MULTISELECTABLE"
	, 0x2000000:"EXTSELECTABLE"
	, 0x4000000:"ALERT_LOW"
	, 0x8000000:"ALERT_MEDIUM"
	, 0x10000000:"ALERT_HIGH"
	, 0x20000000:"PROTECTED"
	, 0x40000000:"HASPOPUP"}
	vNum := 1
	Loop, 30
	{
		if vState & vNum
			vOutput .= oArray[vNum] " "
		vNum <<= 1 ;multiply by 2
	}
	vOutput := RTrim(vOutput)
	return Format("{:L}", vOutput)
}

;==================================================

JEE_AccSelection(oAcc)
{
	vSel := oAcc.accSelection ;if one item selected, gets index, if multiple items selected, gets indexes as object
	if IsObject(vSel)
	{
		oSel := vSel, vSel := ""
		while oSel.Next(vValue, vType)
			vSel .= (A_Index=1?"":",") vValue
		oSel := ""
	}
	return vSel
}

;==================================================