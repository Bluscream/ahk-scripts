#Include %A_ScriptDir%\..\export.ahk
#Include %A_ScriptDir%\..\node_modules
#Include unit-testing.ahk\export.ahk

#NoTrayIcon
#SingleInstance, force
SetBatchLines, -1

re := new regexp()
assert := new unittesting()

; Start speed function
QPC(1)

assert.label("internal()")
assert.test(re._join([1,2,3]), "123")
assert.test(re._join([1]), "1")

; omit






assert.label("typeException()")

assert.label("exec()")
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


assert.label("test()")
assert.label(".test - Simple use cases")
re := new regexp("Lunchtime")
assert.true(re.test("Time is an illusion. Lunchtime doubly so"))
assert.test(re.lastIndex, 22)

assert.false(re.test("Don't Panic"))
assert.test(re.lastIndex, 0)


; omit
assert.label(".test - correct lastIndex")
string := "1 2 3"
re := new regexp(" ")
re.test(string)
assert.test(re.lastIndex, 2)
re.test(string)
assert.test(re.lastIndex, 4)
re.test(string)
assert.test(re.lastIndex, 0)
re.test(string)
assert.test(re.lastIndex, 2)


assert.label("toString()")
re := new regexp("123")
assert.test(re.toString(), "/123/")

re := new regexp("123", "g")
assert.test(re.toString(), "/123/g")


; omit
re := new regexp("123", "i")
assert.test(re.toString(), "/123/i")

re := new regexp("123", "m")
assert.test(re.toString(), "/123/m")
;; Display test results in GUI
speed := QPC(0)
assert.fullreport()
msgbox, %speed%
ExitApp

QPC(R := 0)
{
	static P := 0, F := 0, Q := DllCall("QueryPerformanceFrequency", "Int64P", F)
	return ! DllCall("QueryPerformanceCounter", "Int64P", Q) + (R ? (P := Q) / F : (Q - P) / F)
}
