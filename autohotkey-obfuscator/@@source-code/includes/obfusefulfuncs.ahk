flipcoin() {
	random, isheads, 1, 2
	if (isheads = 1)
		return, true
	
	return, false
}

odds_5to1() {
	random, randnum, 1, 5
	if (randnum = 1)
		return, false
	
	return, true
}

ucase(thisstring) {
	StringUpper, thisstring, thisstring
	return, % thisstring
}

lcase(thisstring) {
	StringLower, thisstring, thisstring
	return, % thisstring
}

;**********************************************
; ADDED DIGIDON : USEFUL FCT
;**********************************************
IsType( p_Input , p_Type ) {
	If InStr("integer,float,number,digit,xdigit,alpha,upper,lower,alnum,space,time",p_Type,false)
		If p_Input is %p_Type%
			Return 1
	Return 0
}

str_getTail(_Str, _LineNum = 1) {
	StringReplace, _Str, _Str, `r,,All
	LinePrevNum:=_LineNum - 1
    StringGetPos, Pos, _Str, `n, R%_LineNum%
    StringTrimLeft, _Str, _Str, % ++Pos
	StringGetPos, Pos2, _Str, `n, R%LinePrevNum%
	StringTrimRight, _Str, _Str, % StrLen(_Str) - Pos2
    Return _Str
}

str_getTailLines(_Str, _LineNum = 1) {
	StringReplace, _Str, _Str, `r,,All
    StringGetPos, Pos, _Str, `n, R%_LineNum%
    StringTrimLeft, _Str, _Str, % ++Pos
    Return _Str
}

str_getTailf(_Str) {
    Return SubStr(_Str,InStr(_Str,"`n",False,0)+1)
}

str_getLines(_Str,_LinesFrom,_LinesTo) {
	loop, parse, _Str, `n, `r
	{
		if (A_Index>=_LinesFrom and A_Index<=_LinesTo)
			_StrNew.=A_LoopField . "`n"
	}
    Return _StrNew
}

str_getLinesNumb(_Str) {
	loop, parse, _Str, `n, `r
	max:=a_index
	return max
}

List_GetPos( Str="", Fld="", D="`n" )  {  ;    List GetPosition
	StringReplace, Str, Str, `r`n, `n
	Str := Substr( D Str D, 1, InStr( D Str D, D Fld D ) )
	StringReplace, Str, Str, %D%, %D%, UseErrorLevel
	Return ErrorLevel
}

Line_GetPos( Str="", Fld="", Trim=0 )  {
	if Trim=1
		Fld:=Trim(Fld)
	loop, parse, Str, `n, `r
		{
		if Trim=1
			AA_Loopfield:=Trim(A_Loopfield)
		else
			AA_Loopfield:=A_Loopfield
		if (AA_Loopfield=Fld)
			{
			Return A_Index
			}
		}
	Return
}

Pos_GetLine( Str="", Pos=1)  {
	loop, parse, Str, `n, `r
		{
		if (A_Loopfield=Fld)
			{
			Return A_Index
			}
		}
	Return
}

List_LineFromPos( Str="", Pos=1, D="`n" )  {
	if Pos>1
		SubStringBeforePos:= Substr(Str,1,Pos-1)
	SubStringFromPos:= Substr(Str,Pos)
	StringGetPos, PosNextLine1, SubStringFromPos, `n
	StringGetPos, PosNextLine2, SubStringFromPos, `r
	if (PosNextLine2 and PosNextLine2<PosNextLine1)
		PosNextLine:=PosNextLine2
	PosNextLine+=Pos
	StringGetPos, PosPrevLine, SubStringBeforePos, `n, R
	PosPrevLine+=2
	if PosPrevLine<=2
		{
		LengthUntilNextLine:=PosNextLine-1
		PosPrevLine=1
		}
	else
		LengthUntilNextLine:=PosNextLine-PosPrevLine
	SubString3:= Substr(Str,PosPrevLine,LengthUntilNextLine)
	Return SubString3
}

Getting_IndexChosenFromList(Lcl_ChosenVar,Lcl_List) {
	found=
	Loop, Parse, Lcl_List, |
		{
		if (Lcl_ChosenVar = A_Loopfield)
			{
			; msgbox found %Lcl_ChosenVar% at index %A_Index% in %Lcl_List%
			found:=A_Index
			}
		}
	return found
}

Getting_ValueChosenFromList(Lcl_ChosenIndex,Lcl_List) {
found=
	Loop, Parse, Lcl_List, |
		{
		if (Lcl_ChosenIndex = A_Index)
			{
			; msgbox found %Lcl_ChosenVar% at index %A_Index% in %Lcl_List%
			found:=A_LoopField
			}
		}
	return found
}

IsFctLocal(strippedLOFbodylines) {
	if (RegexMatch(strippedLOFbodylines,"im)^\h*global\h*$") or RegexMatch(strippedLOFbodylines,"im)^\h*local\h*[\w,]+\h*$"))
		return 0
	else
		return 1
}

ListItemsWithLinesIfExist(items*) {
	for i,item in items
		if item
		list.=item . "`n"
	list:=SubStr(list,1,-1)
	return list
}

max(num*){
	max := -9223372036854775807
	Loop % num.MaxIndex()
		max := (num[A_Index] > max) ? num[A_Index] : max
	return max
}

min(MinToRetain="",num*){
	min := 9223372036854775807
	Loop % num.MaxIndex()
		{
		if (num[A_Index]<=MinToRetain)
		continue
		min := (num[A_Index] < min) ? num[A_Index] : min
		}
	return min
}

InStrNNull(Haystack,Needle) {
if !Needle
	return
else
	return InStr(Haystack,Needle)
}