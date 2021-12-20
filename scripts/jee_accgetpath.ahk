#SingleInstance Force
#NoEnv
SetWorkingDir %A_ScriptDir%
SetBatchLines -1

#Include <Acc>

q:: ;acc get path of element under the cursor
WinGet, hWnd, ID, A
;hWnd := -1 ;get all possible ancestors
oAcc := Acc_ObjectFromPoint(vChildID)
vAccPath := JEE_AccGetPath(oAcc, hWnd)
if vChildID
	MsgBox, % Clipboard := vAccPath " c" vChildID
else
	MsgBox, % Clipboard := vAccPath

;use acc path (check that the acc path is correct)
oAcc := Acc_Get("Object", vAccPath, vChildID, "ahk_id " hWnd)
vName := vValue := ""
try vName := oAcc.accName(vChildID)
try vValue := oAcc.accValue(vChildID)
MsgBox, % vName "`r`n" vValue
return

;==================================================

;note: path might be too short e.g. menu items
;note: path might be too long (I haven't seen this happen)
;note: if there is ambiguity identifying the index, 'or' is used (see JEE_AccGetEnumIndex)
JEE_AccGetPath(oAcc, hWnd:="")
{
	local
	if (hWnd = "")
		hWnd := Acc_WindowFromObject(oAcc)
		, hWnd := DllCall("user32\GetParent", Ptr,hWnd, Ptr)
	vAccPath := ""
	vIsMatch := 0
	if (hWnd = -1) ;get all possible ancestors
		Loop
		{
			vIndex := JEE_AccGetEnumIndex(oAcc)
			if !vIndex
				break
			vAccPath := vIndex (A_Index=1?"":".") vAccPath
			oAcc := oAcc.accParent
		}
	else
		Loop
		{
			vIndex := JEE_AccGetEnumIndex(oAcc)
			hWnd2 := Acc_WindowFromObject(oAcc)
			if !vIsMatch && (hWnd = hWnd2)
				vIsMatch := 1
			if vIsMatch && !(hWnd = hWnd2)
				break
			vAccPath := vIndex (A_Index=1?"":".") vAccPath
			oAcc := oAcc.accParent
		}
	if vIsMatch
		return SubStr(vAccPath, InStr(vAccPath, ".")+1)
	return vAccPath
}

;==================================================

;note: AccViewer uses a mod of Acc_Location that returns a 'pos' key,
;this function is compatible with the older and AccViewer versions of Acc_Location
;note: if there is ambiguity identifying the index, 'or' is used
JEE_AccGetEnumIndex(oAcc, vChildID:=0)
{
	local
	vOutput := ""
	vAccState := oAcc.accState(0)
	if !vChildID
	{
		Acc_Location(oAcc, 0, vChildPos)
		for _, oChild in Acc_Children(Acc_Parent(oAcc))
		{
			if !(vAccState = oChild.accState(0))
				continue
			Acc_Location(oChild, 0, vPos)
			if IsObject(oChild) && (vPos = vChildPos)
				vOutput .= A_Index "or"
		}
	}
	else
	{
		Acc_Location(oAcc, vChildID, vChildPos)
		for _, oChild in Acc_Children(oAcc)
		{
			if !(vAccState = oChild.accState(0))
				continue
			Acc_Location(oAcc, oChild, vPos)
			if !IsObject(oChild) && (vPos = vChildPos)
				vOutput .= A_Index "or"
		}
	}
	return SubStr(vOutput, 1, -2)
}

;==================================================
