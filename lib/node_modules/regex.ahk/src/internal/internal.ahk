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


; tests
assert.test(re._join([1,2,3]), "123")
assert.test(re._join([1]), "1")

; omit




; tests

; omit
