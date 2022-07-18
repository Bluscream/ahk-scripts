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
