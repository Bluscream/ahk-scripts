; SetFormat, Integer, H
; Hotkey, Space, OnKeyStroke
; Loop, 0x7f
; Hotkey, % ""*~"" . chr(A_Index), OnKeyStroke

Hotkey, ~:, OnKeyStroke
OnKeyStroke:
    OnKeyStroke("{Enter}")
    return
~Enter::
~#Enter::
~!Enter::
~^Enter::
    OnKeyStroke("{Enter}")
    return
Space::
~#Space::
~!Space::
~^Space::
    OnKeyStroke(A_Space)
    send {space}
    return
~Tab::
~#Tab::
~^Tab::
    OnKeyStroke(A_Tab)
    return
~Backspace::
~#Backspace::
~!Backspace::
    OnKeyStroke("{BackSpace}")
    return
~a::OnKeyStroke("a")
~#a::OnKeyStroke("a")
~!a::OnKeyStroke("a")
~^a::OnKeyStroke("a")
~b::OnKeyStroke("b")
~#b::OnKeyStroke("b")
~!b::OnKeyStroke("b")
~^b::OnKeyStroke("b")
~c::OnKeyStroke("c")
~#c::OnKeyStroke("c")
~!c::OnKeyStroke("c")
~^c::OnKeyStroke("c")
~d::OnKeyStroke("d")
~#d::OnKeyStroke("d")
~!d::OnKeyStroke("d")
~^d::OnKeyStroke("d")
~e::OnKeyStroke("e")
~#e::OnKeyStroke("e")
~!e::OnKeyStroke("e")
~^e::OnKeyStroke("e")
~f::OnKeyStroke("f")
~#f::OnKeyStroke("f")
~!f::OnKeyStroke("f")
~^f::OnKeyStroke("f")
~g::OnKeyStroke("g")
~#g::OnKeyStroke("g")
~!g::OnKeyStroke("g")
~^g::OnKeyStroke("g")
~h::OnKeyStroke("h")
~#h::OnKeyStroke("h")
~!h::OnKeyStroke("h")
~^h::OnKeyStroke("h")
~i::OnKeyStroke("i")
~#i::OnKeyStroke("i")
~!i::OnKeyStroke("i")
~^i::OnKeyStroke("i")
~j::OnKeyStroke("j")
~#j::OnKeyStroke("j")
~!j::OnKeyStroke("j")
~^j::OnKeyStroke("j")
~k::OnKeyStroke("k")
~#k::OnKeyStroke("k")
~!k::OnKeyStroke("k")
~^k::OnKeyStroke("k")
~l::OnKeyStroke("l")
~#l::OnKeyStroke("l")
~!l::OnKeyStroke("l")
~^l::OnKeyStroke("l")
~m::OnKeyStroke("m")
~#m::OnKeyStroke("m")
~!m::OnKeyStroke("m")
~^m::OnKeyStroke("m")
~n::OnKeyStroke("n")
~#n::OnKeyStroke("n")
~!n::OnKeyStroke("n")
~^n::OnKeyStroke("n")
~o::OnKeyStroke("o")
~#o::OnKeyStroke("o")
~!o::OnKeyStroke("o")
~^o::OnKeyStroke("o")
~p::OnKeyStroke("p")
~#p::OnKeyStroke("p")
~!p::OnKeyStroke("p")
~^p::OnKeyStroke("p")
~q::OnKeyStroke("q")
~#q::OnKeyStroke("q")
~!q::OnKeyStroke("q")
~^q::OnKeyStroke("q")
~r::OnKeyStroke("r")
~#r::OnKeyStroke("r")
~!r::OnKeyStroke("r")
~^r::OnKeyStroke("r")
~s::OnKeyStroke("s")
~#s::OnKeyStroke("s")
~!s::OnKeyStroke("s")
~^s::OnKeyStroke("s")
~t::OnKeyStroke("t")
~#t::OnKeyStroke("t")
~!t::OnKeyStroke("t")
~^t::OnKeyStroke("t")
~u::OnKeyStroke("u")
~#u::OnKeyStroke("u")
~!u::OnKeyStroke("u")
~^u::OnKeyStroke("u")
~v::OnKeyStroke("v")
~#v::OnKeyStroke("v")
~!v::OnKeyStroke("v")
~^v::OnKeyStroke("v")
~w::OnKeyStroke("w")
~#w::OnKeyStroke("w")
~!w::OnKeyStroke("w")
~^w::OnKeyStroke("w")
~x::OnKeyStroke("x")
~#x::OnKeyStroke("x")
~!x::OnKeyStroke("x")
~^x::OnKeyStroke("x")
~y::OnKeyStroke("y")
~#y::OnKeyStroke("y")
~!y::OnKeyStroke("y")
~^y::OnKeyStroke("y")
~z::OnKeyStroke("z")
~#z::OnKeyStroke("z")
~!z::OnKeyStroke("z")
~^z::OnKeyStroke("z")
~+A::OnKeyStroke("A")
~#+A::OnKeyStroke("A")
~!+A::OnKeyStroke("A")
~^+A::OnKeyStroke("A")
~+B::OnKeyStroke("B")
~#+B::OnKeyStroke("B")
~!+B::OnKeyStroke("B")
~^+B::OnKeyStroke("B")
~+C::OnKeyStroke("C")
~#+C::OnKeyStroke("C")
~!+C::OnKeyStroke("C")
~^+C::OnKeyStroke("C")
~+D::OnKeyStroke("D")
~#+D::OnKeyStroke("D")
~!+D::OnKeyStroke("D")
~^+D::OnKeyStroke("D")
~+E::OnKeyStroke("E")
~#+E::OnKeyStroke("E")
~!+E::OnKeyStroke("E")
~^+E::OnKeyStroke("E")
~+G::OnKeyStroke("G")
~#+G::OnKeyStroke("G")
~!+G::OnKeyStroke("G")
~^+G::OnKeyStroke("G")
~+H::OnKeyStroke("H")
~#+H::OnKeyStroke("H")
~!+H::OnKeyStroke("H")
~^+H::OnKeyStroke("H")
~+I::OnKeyStroke("I")
~#+I::OnKeyStroke("I")
~!+I::OnKeyStroke("I")
~^+I::OnKeyStroke("I")
~+J::OnKeyStroke("J")
~#+J::OnKeyStroke("J")
~!+J::OnKeyStroke("J")
~^+J::OnKeyStroke("J")
~+K::OnKeyStroke("K")
~#+K::OnKeyStroke("K")
~!+K::OnKeyStroke("K")
~^+K::OnKeyStroke("K")
~+L::OnKeyStroke("L")
~#+L::OnKeyStroke("L")
~!+L::OnKeyStroke("L")
~^+L::OnKeyStroke("L")
~+M::OnKeyStroke("M")
~#+M::OnKeyStroke("M")
~!+M::OnKeyStroke("M")
~^+M::OnKeyStroke("M")
~+N::OnKeyStroke("N")
~#+N::OnKeyStroke("N")
~!+N::OnKeyStroke("N")
~^+N::OnKeyStroke("N")
~+O::OnKeyStroke("O")
~#+O::OnKeyStroke("O")
~!+O::OnKeyStroke("O")
~^+O::OnKeyStroke("O")
~+P::OnKeyStroke("P")
~#+P::OnKeyStroke("P")
~!+P::OnKeyStroke("P")
~^+P::OnKeyStroke("P")
~+Q::OnKeyStroke("Q")
~#+Q::OnKeyStroke("Q")
~!+Q::OnKeyStroke("Q")
~^+Q::OnKeyStroke("Q")
~+R::OnKeyStroke("R")
~#+R::OnKeyStroke("R")
~!+R::OnKeyStroke("R")
~^+R::OnKeyStroke("R")
~+S::OnKeyStroke("S")
~#+S::OnKeyStroke("S")
~!+S::OnKeyStroke("S")
~^+S::OnKeyStroke("S")
~+T::OnKeyStroke("T")
~#+T::OnKeyStroke("T")
~!+T::OnKeyStroke("T")
~^+T::OnKeyStroke("T")
~+U::OnKeyStroke("U")
~#+U::OnKeyStroke("U")
~!+U::OnKeyStroke("U")
~^+U::OnKeyStroke("U")
~+V::OnKeyStroke("V")
~#+V::OnKeyStroke("V")
~!+V::OnKeyStroke("V")
~^+V::OnKeyStroke("V")
~+W::OnKeyStroke("W")
~#+W::OnKeyStroke("W")
~!+W::OnKeyStroke("W")
~^+W::OnKeyStroke("W")
~+X::OnKeyStroke("X")
~#+X::OnKeyStroke("X")
~!+X::OnKeyStroke("X")
~^+X::OnKeyStroke("X")
~+Y::OnKeyStroke("Y")
~#+Y::OnKeyStroke("Y")
~!+Y::OnKeyStroke("Y")
~^+Y::OnKeyStroke("Y")
~+Z::OnKeyStroke("Z")
~#+Z::OnKeyStroke("Z")
~!+Z::OnKeyStroke("Z")
~^+Z::OnKeyStroke("Z")
~`::OnKeyStroke("``")
~#`::OnKeyStroke("``")
~!`::OnKeyStroke("``")
~^`::OnKeyStroke("``")
~!::OnKeyStroke("!")
~#!::OnKeyStroke("!")
~!!::OnKeyStroke("!")
~^!::OnKeyStroke("!")
~@::OnKeyStroke("@")
~#@::OnKeyStroke("@")
~!@::OnKeyStroke("@")
~^@::OnKeyStroke("@")
~#::OnKeyStroke("#")
~##::OnKeyStroke("#")
~!#::OnKeyStroke("#")
~^#::OnKeyStroke("#")
~$::OnKeyStroke("$")
~#$::OnKeyStroke("$")
~!$::OnKeyStroke("$")
~^$::OnKeyStroke("$")
~^::OnKeyStroke("^")
~#^::OnKeyStroke("^")
~!^::OnKeyStroke("^")
~^^::OnKeyStroke("^")
~&::OnKeyStroke("&")
~#&::OnKeyStroke("&")
~!&::OnKeyStroke("&")
~^&::OnKeyStroke("&")
~*::OnKeyStroke("*")
~#*::OnKeyStroke("*")
~!*::OnKeyStroke("*")
~^*::OnKeyStroke("*")
~(::OnKeyStroke("(")
~#(::OnKeyStroke("(")
~!(::OnKeyStroke("(")
~^(::OnKeyStroke("(")
~)::OnKeyStroke(")")
~#)::OnKeyStroke(")")
~!)::OnKeyStroke(")")
~^)::OnKeyStroke(")")
~-::OnKeyStroke("-")
~#-::OnKeyStroke("-")
~!-::OnKeyStroke("-")
~^-::OnKeyStroke("-")
~_::OnKeyStroke("_")
~#_::OnKeyStroke("_")
~!_::OnKeyStroke("_")
~^_::OnKeyStroke("_")
~=::OnKeyStroke("=")
~#=::OnKeyStroke("=")
~!=::OnKeyStroke("=")
~^=::OnKeyStroke("=")
~+::OnKeyStroke("+")
~#+::OnKeyStroke("+")
~!+::OnKeyStroke("+")
~^+::OnKeyStroke("+")
~[::OnKeyStroke("[")
~#[::OnKeyStroke("[")
~![::OnKeyStroke("[")
~^[::OnKeyStroke("[")
~{::OnKeyStroke("{{}")
~#{::OnKeyStroke("{{}")
~!{::OnKeyStroke("{{}")
~^{::OnKeyStroke("{{}")
~]::OnKeyStroke("]")
~#]::OnKeyStroke("]")
~!]::OnKeyStroke("]")
~^]::OnKeyStroke("]")
~}::OnKeyStroke("{}}")
~#}::OnKeyStroke("{}}")
~!}::OnKeyStroke("{}}")
~^}::OnKeyStroke("{}}")
~\::OnKeyStroke("\")
~#\::OnKeyStroke("\")
~!\::OnKeyStroke("\")
~^\::OnKeyStroke("\")
~|::OnKeyStroke("|")
~#|::OnKeyStroke("|")
~!|::OnKeyStroke("|")
~^|::OnKeyStroke("|")
~+;::OnKeyStroke(":")
~#+;::OnKeyStroke(":")
~!+;::OnKeyStroke(":")
~^+;::OnKeyStroke(":")
~;::OnKeyStroke("`;")
~#;::OnKeyStroke("`;")
~!;::OnKeyStroke("`;")
~^;::OnKeyStroke("`;")
~SC028::OnKeyStroke("'")
~#SC028::OnKeyStroke("'")
~!SC028::OnKeyStroke("'")
~^SC028::OnKeyStroke("'")
~+SC028::OnKeyStroke("""""")
~#+SC028::OnKeyStroke("""""")
~!+SC028::OnKeyStroke("""""")
~^+SC028::OnKeyStroke("""""")
~,::OnKeyStroke(",")
~#,::OnKeyStroke(",")
~!,::OnKeyStroke(",")
~^,::OnKeyStroke(",")
~.::OnKeyStroke(".")
~#.::OnKeyStroke(".")
~!.::OnKeyStroke(".")
~^.::OnKeyStroke(".")
~<::OnKeyStroke("<")
~#<::OnKeyStroke("<")
~!<::OnKeyStroke("<")
~^<::OnKeyStroke("<")
~>::OnKeyStroke(">")
~#>::OnKeyStroke(">")
~!>::OnKeyStroke(">")
~^>::OnKeyStroke(">")
~/::OnKeyStroke("/")
~#/::OnKeyStroke("/")
~!/::OnKeyStroke("/")
~^/::OnKeyStroke("/")
~?::OnKeyStroke("?")
~#?::OnKeyStroke("?")
~!?::OnKeyStroke("?")
~^?::OnKeyStroke("?")
~1::OnKeyStroke("1")
~#1::OnKeyStroke("1")
~!1::OnKeyStroke("1")
~^1::OnKeyStroke("1")
~2::OnKeyStroke("2")
~#2::OnKeyStroke("2")
~!2::OnKeyStroke("2")
~^2::OnKeyStroke("2")
~3::OnKeyStroke("3")
~#3::OnKeyStroke("3")
~!3::OnKeyStroke("3")
~^3::OnKeyStroke("3")
~4::OnKeyStroke("4")
~#4::OnKeyStroke("4")
~!4::OnKeyStroke("4")
~^4::OnKeyStroke("4")
~5::OnKeyStroke("5")
~#5::OnKeyStroke("5")
~!5::OnKeyStroke("5")
~^5::OnKeyStroke("5")
~6::OnKeyStroke("6")
~#6::OnKeyStroke("6")
~!6::OnKeyStroke("6")
~^6::OnKeyStroke("6")
~7::OnKeyStroke("7")
~#7::OnKeyStroke("7")
~!7::OnKeyStroke("7")
~^7::OnKeyStroke("7")
~8::OnKeyStroke("8")
~#8::OnKeyStroke("8")
~!8::OnKeyStroke("8")
~^8::OnKeyStroke("8")
~9::OnKeyStroke("9")
~#9::OnKeyStroke("9")
~!9::OnKeyStroke("9")
~^9::OnKeyStroke("9")
~0::OnKeyStroke("0")
~#0::OnKeyStroke("0")
~!0::OnKeyStroke("0")
~^0::OnKeyStroke("0")
~Numpad0::OnKeyStroke(" 0")
~#Numpad0::OnKeyStroke("0")
~!Numpad0::OnKeyStroke("0")
~^Numpad0::OnKeyStroke("0")
~Numpad1::OnKeyStroke( "1")
~#Numpad1::OnKeyStroke("1")
~!Numpad1::OnKeyStroke("1")
~^Numpad1::OnKeyStroke("1")
~Numpad2::OnKeyStroke( "2")
~#Numpad2::OnKeyStroke("2")
~!Numpad2::OnKeyStroke("2")
~^Numpad2::OnKeyStroke("2")
~Numpad3::OnKeyStroke( "3")
~#Numpad3::OnKeyStroke("3")
~!Numpad3::OnKeyStroke("3")
~^Numpad3::OnKeyStroke("3")
~Numpad4::OnKeyStroke( "4")
~#Numpad4::OnKeyStroke("4")
~!Numpad4::OnKeyStroke("4")
~^Numpad4::OnKeyStroke("4")
~Numpad5::OnKeyStroke( "5")
~#Numpad5::OnKeyStroke("5")
~!Numpad5::OnKeyStroke("5")
~^Numpad5::OnKeyStroke("5")
~Numpad6::OnKeyStroke( "6")
~#Numpad6::OnKeyStroke("6")
~!Numpad6::OnKeyStroke("6")
~^Numpad6::OnKeyStroke("6")
~Numpad7::OnKeyStroke( "7")
~#Numpad7::OnKeyStroke("7")
~!Numpad7::OnKeyStroke("7")
~^Numpad7::OnKeyStroke("7")
~Numpad8::OnKeyStroke( "8")
~#Numpad8::OnKeyStroke("8")
~!Numpad8::OnKeyStroke("8")
~^Numpad8::OnKeyStroke("8")
~Numpad9::OnKeyStroke( "9")
~#Numpad9::OnKeyStroke("9")
~!Numpad9::OnKeyStroke("9")
~^Numpad9::OnKeyStroke("9")
Hotkey, IfWinActive