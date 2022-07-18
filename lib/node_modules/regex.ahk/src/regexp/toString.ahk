toString() {
	flags := ""
	if (this.g) {
		flags .= "g"
	}
	if (this.i) {
		flags .= "i"
	}
	if (this.m) {
		flags .= "m"
	}
	return "/" this.pattern "/" flags
}


; tests
re := new regexp("123")
assert.test(re.toString(), "/123/")

re := new regexp("123", "g")
assert.test(re.toString(), "/123/g")


; omit
re := new regexp("123", "i")
assert.test(re.toString(), "/123/i")

re := new regexp("123", "m")
assert.test(re.toString(), "/123/m")