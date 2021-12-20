;Since the obfuscator is set to do Dynamic obfuscation by default,
;leaving off obfuscator CHANGE_DEFAULTS statements at the beginning
;of your program will set the obfuscator to do dynamic obfuscation
  
;put a string assignment header like this in your program so that
;the program name and copyright info still shows up in the obfuscated ;version of this program
program_name:="MY PROGRAM NAME"
program_name:="Author: MY NAME"
program_name:="Copyright MY NAME, YEAR"

;these are the minimum DUMP statements you need to use when using
;dynamic obfuscation. none of these would be required
;for 'straight' obfuscation however you can still have them
;but they wont be used
;*******************************************************************************
;security fragments and triple mess fragments for common objects
;must be dumped before anything else
obf_dumpcommonobjfrags()
;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
obf_dumpunclassed()
;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
obf_dumpunsecclasses()
;dump all fragments 
obf_dumpall()
;******************************************************************************* 
;if you had created 'secure' obfuscation classes then they would 
;have to have dumps for them

;FUNCTIONS HAVE TO BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;OTHERWISE STRAIGHT OBFUSCATION WILL BE AUTOMATICALLY USED FOR THESE FUNCTIONS



;$OBFUSCATOR: $DEFGLOBVARS: mytrue, myfalse
mytrue = 1
myfalse = 0

;AUTOHOTKEY BUILT IN FUNCTIONS!
;tell obfuscator to obfuscate these autohotkey built in functions
;$OBFUSCATOR: $DEFSYSFUNCS: DllCall, WinExist 

DetectHiddenWindows On
;test obfuscation of dllcall(), winexist()
if not DllCall("IsWindowVisible", "UInt", WinExist("Untitled - Notepad"))  
    MsgBox, TESTING OBF OF BUILT IN AUTOHOTKEY FUNCTIONS:`n`nThe notepad window IS NOT visible.
else
	 MsgBox, TESTING OBF OF BUILT IN AUTOHOTKEY FUNCTIONS:`n`nThe notepad window IS visible.

;test obfuscation of function call
testfunction()

;test obfuscation of parameters
;msgbox will show 12 if obfuscation of parameters works
msgbox, % "TEST OF OBF OF PARAMETERS:`n`nparameter: " . test_parameters(12)

;test obfuscation of label
gosub test_label

;tests local variables, global variables, gosub label as 
;part of a 'gui, add' statement, and variables defined as associated
;with a gui control
creategui()
	 
RETURN
;PUT AFTER THE END OF THE AUTOEXECUTE SECTION:
;$OBFUSCATOR: $END_AUTOEXECUTE: 

;hotkeys will not be obfuscated!
;but functions and variables inside hotkeys should be
home::
	msgbox, home key pressed!
return

RControl & RShift::
	msgbox, right control + right shift pressed!
	helloworld()
return

^;::
	msgbox, control + semicolon pressed
	helloworld()
return

helloworld()
{
	msgbox, hello world!
}	

;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
testfunction()
{
	global
	msgbox, TESTING OBF OF A FUNCTION CALL:`n`ntestfunction has been called	
}

;will test the correct obfuscation of the parameter 'myparam'
;if successful the function will return the value it was sent
;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
test_parameters(myparam)
{
	global
	
	myparam:=myparam + myparam - myparam	
	return myparam	
}

test_label:
	msgbox, TESTING OBF OF A LABEL CALL:`n`ninside "gosublabel"
return

;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
creategui()
{
	global
	local h1font, h2font, basefont, mymessage
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

TESTING LITERAL STRING :
"%mymessage%"

-press home key to test hotkeys-
)
	gui, add, text, xm y+12, enter something here to test`nvariable obfuscation
;$OBFUSCATOR: $DEFGLOBVARS: usermessage
	gui, add, edit, xm y+2 Vusermessage r4, 
		
	gui, add, button, xm y+20 Gtestguisubmit, Test gui submit
	gui, add, button, x+20 yp Gcancelprog, Cancel program
	gui, show
}

testguisubmit:
	gui, submit, nohide
	msgbox, TESTING OBF OF Vvariablename IN 'gui, add':`n`nyou entered "%usermessage%"
return

cancelprog:
	exitapp
return

guigosub:
	msgbox, inside _guigosub_
return

;*******************************************************************************
;         O B F   D U M P   F U C T I O N S
;*******************************************************************************
;$OBFUSCATOR: $FUNCS_CHANGE_DEFAULTS: ,, -1
obf_dumpcommonobjfrags()
{
global
;security fragments and triple mess fragments for common objects
;must be dumped before anything else
;$OBFUSCATOR: $DUMP_SECFRAGS_FORCLASSES: common
;$OBFUSCATOR: $DUMP_TMESSFRAGS_FORCLASSES: common
}
;$OBFUSCATOR: $FUNCS_RESTORE_DEFAULTS:

;$OBFUSCATOR: $FUNCS_CHANGE_DEFAULTS: ,, -1
obf_dumpunclassed()
{
global
;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
;$OBFUSCATOR: $FUNCFRAGS_DUMPCLASS: unclassed
;$OBFUSCATOR: $LABELFRAGS_DUMPCLASS: unclassed
}

obf_dumpunsecclasses()
{
global
;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
;$OBFUSCATOR: $FUNCFRAGS_DUMPCLASS: unsecclasses
;$OBFUSCATOR: $LABELFRAGS_DUMPCLASS: unsecclasses
}
;$OBFUSCATOR: $FUNCS_RESTORE_DEFAULTS:

obf_dumpall()
{
global
;dump all fragments 
;$OBFUSCATOR: $GLOBVARFRAGS_DUMPALL:
;$OBFUSCATOR: $GLOBPARTIALVARSFRAGS_DUMPALL:
;$OBFUSCATOR: $SYSVARFRAGS_DUMPALL:
;$OBFUSCATOR: $LOSVARFRAGS_DUMPALL:
;$OBFUSCATOR: $PARAMFRAGS_DUMPALL:
;$OBFUSCATOR: $SYSFUNCFRAGS_DUMPALL:
;$OBFUSCATOR: $SYSPROPERTIESFRAGS_DUMPALL:
;$OBFUSCATOR: $SYSMETHODSFRAGS_DUMPALL:
} 