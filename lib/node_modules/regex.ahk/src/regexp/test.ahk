test(param_string) {
	if (IsObject(param_string)) {
		this._typeException()
	}

	; prepare
	; Todo
	; differenciate between golbal and singular
	if (this.lastIndex != 0 && param_string != this.input) {
		this.lastIndex := 0
	}
	this.input := param_string


	; create
	l_searchPosition := RegExMatch(this.input, "O)(" this.pattern ")", l_match, this.lastIndex + 1)
	if (l_searchPosition != 0) {
		this.lastIndex := l_searchPosition
		return true
	}
	return false
}


; tests
assert.label(".test - Simple use cases")
re := new regexp("Lunchtime")
assert.true(re.test("Time is an illusion. Lunchtime doubly so"))
assert.test(re.lastIndex, 22)

assert.false(re.test("Don't Panic"))
assert.test(re.lastIndex, 0)


; omit
assert.label(".test - correct lastIndex")
string := "Time is an illusion. Lunchtime doubly so"
re := new regexp(" ")
re.test(string)
assert.test(re.lastIndex, 5)
re.test(string)
assert.test(re.lastIndex, 8)
re.test(string)
assert.test(re.lastIndex, 11)
re.test(string)
assert.test(re.lastIndex, 21)
