exec(param_string) {
	if (IsObject(param_string)) {
		this._typeException()
	}

	; prepare
	this.input := param_string


	; create
	l_searchPosition := 1
	oMatch := []
	while l_searchPosition := RegExMatch(this.input, "O)(" this.pattern ")", l_match, l_searchPosition) {
		; oMatch.input := this.input
		vPosLast := l_searchPosition
		l_searchPosition += StrLen(l_match.0)
		; prevent infinite loop
		if (l_searchPosition = vPosLast) {
			return -1
		}
		oMatch.Push(l_match.0)
		this.lastIndex := vPosLast
	}
	if (oMatch.Count() == 0) {
		this.lastIndex := 0
		return oMatch
	}
	return oMatch
}


; tests
assert.label(".test - Simple use cases")
re := new regexp("Lunchtime")
string := "Time is an illusion. Lunchtime doubly so"
result := re.exec(string)
assert.test(result, ["Lunchtime"])

assert.test(re.exec("Don't Panic"), [])


; omit
re := new regexp("(ime)")
string := "Time is an illusion. Lunchtime doubly so"
result := re.exec(string)
assert.test(result, ["ime", "ime"])
assert.test(result)
