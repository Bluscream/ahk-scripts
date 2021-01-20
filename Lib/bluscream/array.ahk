Join(s,p*){
  static _:="".base.Join:=Func("Join")
  o:=""
  for k,v in p
  {
    if isobject(v)
      for k2, v2 in v
        o.=s v2
    else
      o.=s v
  }
  return SubStr(o,StrLen(s)+1)
}
JoinArray(strArray)
{
  s := ""
  for _i,v in strArray
    s .= ", " . v
  return substr(s, 3)
}
ItemInList(Item, List){    
    For Index, ListItem in List
        If (ListItem = Item)
            Return True
}
InList(haystack, needles*)
{
    for _i, needle in (needles.Count() = 1 ? StrSplit(needles[1], ",") : needles)
        if (haystack = needle)
            return true
}
singlePush(array, item) {
    if (array.indexOf(item) = -1) {
       array.push(item)
    }
}
RemoveDup(obj) {
	for _i, value in obj
		str.=value "`n"
	nodupArray:={}
	nodup:= "`n" 									; Added delimiter
	loop parse, str, `n
		if !InStr(nodup,  "`n"  A_LoopField "`n" )	; Added delimiter
		{
			nodup.=A_LoopField "`n"
			nodupArray.Push(A_LoopField)
		}
	Return nodupArray
}

Array(prms*) {
	prms.base := _Array
	return prms
}
class _Array {
    join(p*) {
        for k,v in p {
            s .= this v
        }
        return SubStr(s,StrLen(this)+1)
    }
    scramble() {
        s := this.insertDelims(this, "|")
        Sort, s, Random, D|
        return StrReplace(s, "|")
    }
    insertDelimiters(str, delim) {
            for k,v in StrSplit(str) {
                Result .= delim v
            }
            Return, Result
    }
	singlePush(param_value) {
		if (this.indexOf(param_value) = -1) {
			this.Push("" item)
		}
	}
	indexOf(searchElement, fromIndex:=0) {	
		len := this.Count()
		if (fromIndex > 0)
			start := fromIndex - 1    ; Include starting index going forward
		else if (fromIndex < 0)
			start := len + fromIndex  ; Count backwards from end
		else
			start := fromIndex
		loop, % len - start
			if (this[start + A_Index] = searchElement)
				return start + A_Index
		return -1
	}
    last() {
        return this[this.MaxIndex()]
    }
    chunks(max:=1) { ; https://www.autohotkey.com/boards/viewtopic.php?f=76&t=80157
        if (max > this.Count())
            return [this]
        l_array := Array()
        if (max < 1)
            return l_array
        param_array := this.Clone()
        while (param_array.Count() > 0) {
            l_InnerArr := []
            loop, % max {
                if (param_array.Count() == 0) {
                    break
                }
                l_InnerArr.push(param_array.RemoveAt(1))
            }
        l_array.push(l_InnerArr)
        }
        return l_array
    }
}