class regexp {

	; --- Static Variables ---
	static flags := {i: true, g:false, m:false}

	__New(param_default:="", param_flags:="") {

		param_flags := StrSplit(param_flags)
		this.g := false, this.i := false, this.m := false
		for _, value in param_flags {
			if (value == "g" || value == "G") {
				this.g := true
			}
			if (value == "i" || value == "I") {
				this.i := true
			}
			if (value == "m" || value == "M") {
				this.m := true
			}
		}
		this.data := []

		; workspace
		this.lastIndex := 0


		this.throwExceptions := true
		if (param_default != "") {
			this.pattern := param_default
		}
	}




	; --- Static Methods ---
	; /--\--/--\--/--\--/--\--/--\
	; Internal functions
	; \--/--\--/--\--/--\--/--\--/

	_internal(param_key) {

	}

	_join(param_array, param_sepatator:="") {
		for l_key, l_value in param_array {
			if (l_key == 1) {
				l_string := "" l_value
				continue
			}
			l_string .= param_sepatator l_value
		}
		return l_string
	}
	_typeException() {
		if (this.throwExceptions == true) {
			throw Exception("Type Error", -2)
		}
	}
	exec(param_string) {
		if (IsObject(param_string)) {
			this._typeException()
		}

		; prepare
		this.input := param_string

		; create
		l_searchPosition := 1
		oMatch := []
		while (l_searchPosition := RegExMatch(this.input, "O)(" this.pattern ")", l_match, l_searchPosition)) {
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
		this.lastIndex := l_searchPosition
		if (l_searchPosition != 0) {
			return true
		}
		return false
	}
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
}
