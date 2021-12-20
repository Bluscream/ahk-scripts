;use these statements to set obfuscation to straight obfuscation!
;$OBFUSCATOR: $STRAIGHT_MODE:
  
;put a string assignment header like this in your program so that
;the program name and copyright info still shows up in the obfuscated ;version of this program
program_name:="MY PROGRAM NAME"
program_name:="Author: MY NAME"
program_name:="Copyright MY NAME, YEAR"

;let's put at the beginning all our variable declarations for the obfuscator for simplicity
;$OBFUSCATOR: $DEFGLOBVARS: usermessage
;$OBFUSCATOR: $DEFGLOBVARS: mytrue, myfalse
mytrue = 1
myfalse = 0
;We can declare local variables of creategui as globals for simplicity
;$OBFUSCATOR: $DEFGLOBVARS: h1font, h2font, basefont, mymessage

;test obfuscation of function call
testfunction()

;test obfuscation of parameters
;msgbox will show 12 if obfuscation of parameters works
msgbox, % "parameter: " . test_parameters(12)

;test obfuscation of label
gosub test_label

;tests local variables, global variables, gosub label as 
;part of a 'gui, add' statement, and variables defined as associated
;with a gui control
creategui()
	 
RETURN
;put after the end of the autoexecute section
;$OBFUSCATOR: $END_AUTOEXECUTE: 

;hotkeys SHOULD NOT be obfuscated!
home::
	msgbox, home key pressed!
return

RControl & RShift::
	msgbox, hello dave
	testfunction()
return

^;::
	msgbox, hello world
	testfunction()
return	

testfunction()
{
	global
	msgbox, function: testfunction has been called	
}

;will test the correct obfuscation of the parameter 'myparam'
;if successful the function will return the value it was sent
test_parameters(myparam)
{
	global
	
	myparam:=myparam + myparam - myparam	
	return "my parameter was: " . myparam	
}

test_label:
	msgbox, inside "gosublabel"
return

creategui()
{
;WE could also declare variables to the obfuscator under each function
;Althought it is not recommanded for simplicity I can declare local vars to the obfuscator in each function instead of
;declaring them as if they were global anywhere once with DEFGLOBVARS to the obfuscator
;$OBFUSCATOR: $DEFLOSVARS: h1font, h2font, basefont, mymessage
	h1font 		= % "s22"
	h2font 		= % "s18"	
	basefont 	= % "s14"
	mymessage := "from Dynamic Obfuscator"

	gui 2:default
	gui, destroy
	gui, margin, 20, 20
	
	;the h1font variable below should be obfuscated
	gui, font, %h1font% bold
	gui, add, text, xm ym, Obfuscator Test GUI
	
	gui, font, %basefont% norm underline
	;the gosub label below should be obfuscated
	gui, add, text, xm y+12 cblue Gguigosub, test gosub obfuscation in gui statement
	
	gui, font, %basefont% norm
	gui, add, text, xm y+12 Gguigosub,
(
hello world
message in variable:
"%mymessage%"

-press home key to test hotkeys-
)
	gui, add, text, xm y+12, enter something here to test`nvariable obfuscation
	gui, add, edit, xm y+2 Vusermessage r4, 
		
	gui, add, button, xm y+20 Gtestguisubmit, Test gui submit
	gui, add, button, x+20 yp Gcancelprog, Cancel program
	gui, show
}

testguisubmit:
	gui, submit, nohide
	msgbox, you entered "%usermessage%"
return

cancelprog:
	exitapp
return

guigosub:
	msgbox, inside _guigosub_
return