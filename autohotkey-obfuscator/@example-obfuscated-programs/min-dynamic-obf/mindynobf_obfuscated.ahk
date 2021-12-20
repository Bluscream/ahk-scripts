obf_copyright := " Date: 14:10 mercredi 12 juillet 2017           "
obf_copyright := "                                                "
obf_copyright := " THE FOLLOWING AUTOHOTKEY SCRIPT WAS OBFUSCATED "
obf_copyright := " BY DYNAMIC OBFUSCATOR L FOR AUTOHOTKEY         "
obf_copyright := " By DigiDon									  "
obf_copyright := "                                                "
obf_copyright := " Based on DYNAMIC OBFUSCATOR                    "
obf_copyright := " Copyright (C) 2011-2013  David Malia           "
obf_copyright := " DYNAMIC OBFUSCATOR is released under           "
obf_copyright := " the Open Source GPL License                    "


;AUTOEXECUTE ORIGINAL NAME: autoexecute
;autoexecute
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
k%kffkkfkf%ffk%kfk#fkk#%fkk#%k#ffff%k#kf()
;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
kffffff%f@fffkkf%@kfkf%k#k#kfff%fkkf()
;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
f@k#fk%fkk#fkkf%f%kff@fk%fk#kfk#f@()
;dump all fragments 
%fff@f@ff%%kffffkfkkfk#f@fk%%ffkfkfkf%()
;******************************************************************************* 
;if you had created 'secure' obfuscation classes then they would 
;have to have dumps for them

;FUNCTIONS HAVE TO BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;OTHERWISE STRAIGHT OBFUSCATION WILL BE AUTOMATICALLY USED FOR THESE FUNCTIONS



;$OBFUSCATOR: $DEFGLOBVARS: f%f@f@f@%%kfkffkk#kffkk#fffk%fk%k#f@f@fkk#fffkf@k#kfkf%%k#k#k#kf%kf%fff@k#fk%@fk, k%fkkfk#f@f@kff@kf%k%k#k#k#kf%%ffkfff%%fffkf@ff%#ffff
f@%f@f@f@k#kfkfkff@k#k#%kf%ffkfkf%%f@f@k#ff%k%kfk#fkfk%f@fk = 1
%f@f@k#ff%%f@fkkfk#f@%%kff@ffk#% = 0

;AUTOHOTKEY BUILT IN FUNCTIONS!
;tell obfuscator to obfuscate these autohotkey built in functions
;$OBFUSCATOR: $DEFSYSFUNCS: DllCall, WinExist 

DetectHiddenWindows On
;test obfuscation of dllcall(), winexist()
if not %fkfff@%%ffkffffkkffkf@ff%%k#f@%%k#f@k#fk%%k#f@%%kffffkk#fkkf%("IsWindowVisible", "UInt", %f@ff%%fff@f@fkfffkfkkf%%k#f@ffkf%%kffkk#%%fff@f@ff%%f@fffkk#fffkf@kf%("Untitled - Notepad"))  
    MsgBox, TESTING OBF OF BUILT IN AUTOHOTKEY FUNCTIONS:`n`nThe notepad window IS NOT visible.
else
	 MsgBox, TESTING OBF OF BUILT IN AUTOHOTKEY FUNCTIONS:`n`nThe notepad window IS visible.

;test obfuscation of function call
k#%f@f@kfkfffkff@kf%ff%fkffffkfffk#kf%f%f@ffff%%f@k#k#kf%k%k#f@ffkf%fkkff@()

;test obfuscation of parameters
;msgbox will show 12 if obfuscation of parameters works
msgbox, % "TEST OF OBF OF PARAMETERS:`n`nparameter: " . %kff@kf%k%k#k#ffk#fff@fkf@fkf@%f%k#ffk#k#k#kffkfk%f%ffkfkfff%@%k#k#%f@kfk#(12)

;test obfuscation of label
gosub %f@f@k#ff%%k#ffkfffkfk#kfk#f@kffkfkk#f@f@kfff%%kff@fk%

;tests local variables, global variables, gosub label as 
;part of a 'gui, add' statement, and variables defined as associated
;with a gui control
%k#fkkff@%k#kf%fkk#fff@kff@fk%#ff%kffff@%%fffkf@ff%k#f@kfk#()
	 
RETURN

;hotkeys will not be obfuscated!
;but functions and variables inside hotkeys should be
;HOTKEY ORIGINAL NAME: home
home::
	msgbox, home key pressed!
return


;HOTKEY ORIGINAL NAME: RControl & RShift
RControl & RShift::
	msgbox, right control + right shift pressed!
	fk%kffkkfkfk#kffkkf%%fffkk#f@ffkfkfkf%k%kffffff@%%kffkk#k#%ff%f@ff%fkffkf@()
return


;HOTKEY ORIGINAL NAME: ^;
^;::
	msgbox, control + semicolon pressed
	fk%fkk#k#%k#k%f@f@k#%ff%ffffk#f@kfkff@f@fk%kf%k#f@fffffff@fkf@ff%kf@()
return


;FUNCTION ORIGINAL NAME: helloworld
fkk#kfffkffkf@() { 
	msgbox, hello world!
}	

;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;FUNCTION ORIGINAL NAME: testfunction
k#kffffkfkkff@() { 
	global
	msgbox, TESTING OBF OF A FUNCTION CALL:`n`ntestfunction has been called	
}

;will test the correct obfuscation of the parameter 'myparam'
;if successful the function will return the value it was sent
;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;FUNCTION ORIGINAL NAME: test_parameters
kff@f@f@kfk#(fkkffkk#k#fkffff) { 
	global
	
	%k#f@kfffk#k#fkffkffk%kkff%k#fffkf@%%fkff%%fkfkk#ff%kk#k#fkffff:=%k#k#kfff%%f@fkfkk#k#k#fkk#%%k#kfff% + fk%f@f@ffk#k#k#kfk#f@k#k#%ffk%f@f@k#%k#k#%f@k#k#fkfffkffk#f@%k%k#f@kfkf%ffff - fk%kffff@k#%kff%f@f@fkfk%kk%fkkffkfkkfkffffk%k#fkffff	
	return %f@f@k#ff%%f@kffffkf@ffkff@fffff@%%f@kf%	
}


;LABEL ORIGINAL NAME: test_label
fff@k#k#k#fkk#kfk#f@kff@k#ff:
	msgbox, TESTING OBF OF A LABEL CALL:`n`ninside "gosublabel"
return

;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;FUNCTION ORIGINAL NAME: creategui
k#kfk#ffk#f@kfk#() { 
	global
	local fff@kfffkff@k#kffkff, fff@f@k#f@k#k#k#kf, fkk#fffkk#fkfkkfff, f@fffkk#kffffk
;$OBFUSCATOR: $DEFLOSVARS: ff%kff@fk%f%f@fff@fk%@k%f@f@f@k#kfkfkff@k#k#%ff%ffk#ff%kff@k#kffkff, fff@f%ffk#ffk#%%k#k#kfffffkff@fkffff%k#f@k%k#f@fffk%#k#k#kf, fkk#ff%f@k#k#fkfffkffk#f@%%kfff%%kffff@%kk#fkfkkfff, f@%ffkfkfkf%ff%fkk#k#%f%k#f@k#fkkffkk#f@f@kffffk%k#%kfkffkkffff@k#kf%%fffk%ffffk

	fff@k%k#f@fffffff@fkf@ff%ffkff%ffkf%@k#kf%k#f@kfffk#k#fkffkffk%kff 		= % "s22"
	ff%k#f@kfffk#k#fkffkffk%@f@%fffk%k#f%k#k#fffk%@%f@fk%k#k#k#kf 		= % "s18"	
	%ffk#%%k#ffffk#fkk#ffk#kfff%%f@fk% 	= % "s14"
	f@f%fffff@%ffkk%fffkff%#%ffkfffkffffkf@fk%ffffk := "from Dynamic Obfuscator"

	gui 2:default
	gui, destroy
	gui, margin, 20, 20
	
	;the h1font variable below should be obfuscated
	gui, font, %kfffk#%%fff@kfffkff@k#kffkff%%k#kfkf% bold
	gui, add, text, xm ym, Obfuscator Test GUI
	
	gui, font, %f@k#k#kf%%fkk#fffkk#fkfkkfff%%f@fkk#ff% norm underline
	;the gosub label below should be obfuscated
	gui, add, text, xm y+12 cblue G%fffkk#fkfkfkfkk#fkk#k#fkk#ff%%k#k#fkkf%%fkf@%, test gosub obfuscation in gui statement
	
	gui, font, %fkk#fffkk#fkfkkfff%%kfffff%%fkfffkff% norm
	gui, add, text, xm y+12 G%f@f@fkfk%kffff@%k#f@k#k#f@k#kfkfk#fkfffk%f%fffk%k#f@k#%k#f@k#fkkffkk#f@f@kffffk%#k#fkfffffffkfkffk#,
(
hello world

TESTING LITERAL STRING :
"%f@fffkk#kffffk%%f@f@fkfk%%k#ffff%"

-press home key to test hotkeys-
)
	gui, add, text, xm y+12, enter something here to test`nvariable obfuscation
;$OBFUSCATOR: $DEFGLOBVARS: %k#f@fk%kf%k#fffkf@%k%kfk#f@kff@ffkff@kf%k#%fkf@fkfff@k#f@f@fkk#%fk#
	gui, add, edit, xm y+2 V%fkk#ffk#ffffk#fffkfkfkf@%f%fkf@k#%kf%f@f@ffk#k#k#kfk#f@k#k#%%fkkf%#kfk# r4, 
		
	gui, add, button, xm y+20 Gfkfk%f@fffk%%fffff@%%f@fkkf%kff@%k#f@k#k#f@k#kfkfk#fkfffk%f%fkk#ffk#ffffk#fffkfkfkf@%fk#fkkfffk#ff, Test gui submit
	gui, add, button, x+20 yp G%kff@f@k#fkffffffffk#f@f@k#k#%%k#f@k#fk%%fff@kf%, Cancel program
	gui, show
}


;LABEL ORIGINAL NAME: testguisubmit
fkfkkff@ffkfk#fkkfffk#ff:
	gui, submit, nohide
	msgbox, TESTING OBF OF Vvariablename IN 'gui, add':`n`nyou entered "%fkf@k#k#%%kfkfk#kfk#%%fff@k#fk%"
return


;LABEL ORIGINAL NAME: cancelprog
fkfkfff@k#f@k#k#f@kffkk#f@:
	exitapp
return


;LABEL ORIGINAL NAME: guigosub
kffff@ffk#f@k#k#k#fkfffffffkfkffk#:
	msgbox, inside _guigosub_
return

;*******************************************************************************
;         O B F   D U M P   F U C T I O N S
;*******************************************************************************
;$OBFUSCATOR: $FUNCS_CHANGE_DEFAULTS: ,, -1
;FUNCTION ORIGINAL NAME: obf_dumpcommonobjfrags
kffkfkk#k#kf() { 
global
;security fragments and triple mess fragments for common objects
;must be dumped before anything else
	;SECURITY CLASS FRAG: for class: COMMON for char: f
	f@%k#fkfkk#%fkk%ffk#f@kf%#f@k#%f@kf%fkfkf@fkfkfk=%ffk#k#%f%fkk#ffk#%
	;SECURITY CLASS FRAG: for class: COMMON for char: k
	k%fffkf@ff%%k#f@fffk%ffff%kfff%kkf%k#fkfkk#%f@fff@f@k#fk=%f@f@fkfk%k%f@fff@fk%
	;SECURITY CLASS FRAG: for class: COMMON for char: @
	kff@fk%fkf@%%fkfffkff%%k#ffff%%kfk#fkk#%ffkfffkfk#f@k#ffff=%kfk#fkfk%@%fkk#k#%
	;SECURITY CLASS FRAG: for class: COMMON for char: #
	k#fkff%f@fffk%%f@kff@%kfk#fk%kfffkffk%f%k#fkfkk#%fk#fffkfkf@=%kff@%#%ffk#f@kf%

;TRIPLE MESS FRAGMENTS FOR: f
	k%k#fkffkfk#fkffk#fffkfkf@%f@f%kff@fkffkfffkfk#f@k#ffff%fk%ffk#ff%k%k#fkffkfk#fkffk#fffkfkf@%fffkf@k#kfkf:=f@%f@fkk#f@k#fkfkf@fkfkfk%kk#f%f@ff%@k%k#fkffkfk#fkffk#fffkfkf@%fkfkf%fkfff@f@%@fkfkfk
	f@%fkf@k#%k#%fff@f@ff%k#%f@fkk#f@k#fkfkf@fkfkfk%k%f@fkk#f@k#fkfkf@fkfkfk%ffkffk#f@:=%f@kf%f%kff@fkffkfffkfk#f@k#ffff%fk%kffffkkff@fff@f@k#fk%%k#fkffkfk#fkffk#fffkfkf@%%ffkf%f@k#fkfkf@fkfkfk
	k#k#ff%f@fkk#f@k#fkfkf@fkfkfk%kf%f@f@k#%%kff@fkffkfffkfk#f@k#ffff%f@f%f@fkk#f@k#fkfkf@fkfkfk%kfkfkffkff:=f%fff@kf%@fkk#%kff@kf%f@k#%f@fkk#f@k#fkfkf@fkfkfk%kfkf%kff@fkffkfffkfk#f@k#ffff%fkfkfk
	k%k#fffkf@%#k%k#fkffkfk#fkffk#fffkfkf@%ff%kffffkkff@fff@f@k#fk%#f%f@fkk#f@k#fkfkf@fkfkfk%f@fkf@fkf@:=f%kff@fkffkfffkfk#f@k#ffff%fkk#%f@fkk#f@k#fkfkf@fkfkfk%@k#%f@fkk#f@k#fkfkf@fkfkfk%kfk%fkfff@%f@%f@fkkf%fkfkfk
	%fffkf@ff%%fkfff@%f@kf%f@fkk#f@k#fkfkf@fkfkfk%kf%kffffkkff@fff@f@k#fk%kff@f@k#k#fkfk:=f@f%k#kfff%kk#%kffkk#%f@k%k#fkffkfk#fkffk#fffkfkf@%fkfk%f@fkk#f@k#fkfkf@fkfkfk%@fkfkfk
	f@f@%fffkff%kf%f@fkk#f@k#fkfkf@fkfkfk%%kff@fkffkfffkfk#f@k#ffff%f@k#f@%f@fkk#f@k#fkfkf@fkfkfk%fffk#fkf@:=f@%f@fkk#f@k#fkfkf@fkfkfk%kk#f%kff@fkffkfffkfk#f@k#ffff%k%k#fkffkfk#fkffk#fffkfkf@%fk%fkf@k#%f%ffkf%kf@fkfkfk
	f@f@f@%f@fkff%k#k%f@fkk#f@k#fkfkf@fkfkfk%kfkff%kff@fkffkfffkfk#f@k#ffff%k#k#:=f@fkk#%f@fkk#f@k#fkfkf@fkfkfk%@k#f%kffffkkff@fff@f@k#fk%fkf@%k#kfff%fkfkfk
	k#f@k%fffff@%f%f@kff@%ffk#%kffffkkff@fff@f@k#fk%%k#fkffkfk#fkffk#fffkfkf@%fkffkffk:=f@fkk%kffff@k#%#f@k#f%kffffkkff@fff@f@k#fk%fkf@fk%f@fkk#f@k#fkfkf@fkfkfk%kfk
	fk%k#fkk#f@%fff%f@fkk#f@k#fkfkf@fkfkfk%%kffffkkff@fff@f@k#fk%fff%kffff@k#%k#kf:=%f@fkk#f@k#fkfkf@fkfkfk%@fk%fffff@%%kffffkkff@fff@f@k#fk%#f%fff@kf%@k#fkfkf@fkfkfk
	%kffffkkff@fff@f@k#fk%%f@f@f@fk%fk#%f@fkk#f@k#fkfkf@fkfkfk%@kff@ffkff@kf:=f@f%kffffkkff@fff@f@k#fk%%fkkf%k#f@k%k#fkffkfk#fkffk#fffkfkf@%%f@fk%fkfkf@fkfkfk
	k#f%kffffkkff@fff@f@k#fk%k%k#fkffkfk#fkffk#fffkfkf@%fffkff%k#kfkf%ffk#fkffkf:=%ffk#f@kf%f@%f@fkk#f@k#fkfkf@fkfkfk%kk#f@%kffffkkff@fff@f@k#fk%#fkfkf@fkfkfk
	f@%fkfkfk%%k#fkfk%ffkf%kffffkkff@fff@f@k#fk%fk%f@fkk#f@k#fkfkf@fkfkfk%ffk#fkffkfkf:=f@%f@fkk#f@k#fkfkf@fkfkfk%kk#f@%k#f@k#fk%k#%f@fkk#f@k#fkfkf@fkfkfk%kfkf%f@kff@%@fkfkfk
	k%kfffff%#%f@fkk#f@k#fkfkf@fkfkfk%kf@f%kffffkkff@fff@f@k#fk%k#%f@fkk#f@k#fkfkf@fkfkfk%ff@f%ffk#ff%kkff@ff:=f%k#fkfkk#%@fkk#f@%kffffkkff@fff@f@k#fk%#fkfkf%kff@fkffkfffkfk#f@k#ffff%fkfkfk
	ffffk%k#fkffkfk#fkffk#fffkfkf@%f@kfk%k#fkfk%ff@f%kff@fkffkfffkfk#f@k#ffff%fk:=f@%f@ffff%fkk%ffkfkfkf%#f@k%k#fkffkfk#fkffk#fffkfkf@%fkf%kffffkkff@fff@f@k#fk%%f@fkk#f@k#fkfkf@fkfkfk%@fkfkfk
	kfk%f@f@fkfk%%f@fkk#f@k#fkfkf@fkfkfk%kff@%f@fkk#f@k#fkfkf@fkfkfk%f%f@fkk#f@k#fkfkf@fkfkfk%fffk#fkfkff:=f%kff@fkffkfffkfk#f@k#ffff%fk%kffffkkff@fff@f@k#fk%#%f@fkk#f@k#fkfkf@fkfkfk%%f@f@ff%@%k#k#%k#fkfkf@fkfkfk
	f%f@fkk#f@k#fkfkf@fkfkfk%k#fkf@%f@kf%fff@k#%kfk#ff%fff@%kffffkkff@fff@f@k#fk%#fkf@:=f@%kffkkfkf%%kffkk#%fk%kffffkkff@fff@f@k#fk%#f%kff@fkffkfffkfk#f@k#ffff%k#f%kffffkkff@fff@f@k#fk%fkf@fkfkfk
	k#f@%kfk#ff%fff%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%ff@fkf@ff:=f@fk%fkfkfk%k#f@%kffffkkff@fff@f@k#fk%#fk%f@fkk#f@k#fkfkf@fkfkfk%kf%fkfkffk#%@fkfkfk
	f@fk%f@fkk#f@k#fkfkf@fkfkfk%@fffkfk%kffff@k#%%f@fkk#f@k#fkfkf@fkfkfk%kf@kfffk#fk:=f@%fffff@%%f@fkk#f@k#fkfkf@fkfkfk%k%kffffkkff@fff@f@k#fk%#f@k#fkfkf@fkfkfk
	f@f%f@fkk#f@k#fkfkf@fkfkfk%kfk%k#fkffkfk#fkffk#fffkfkf@%fff%fkff%fkff@ffk#kfkf:=f@f%kffffkkff@fff@f@k#fk%k%kffkkfkf%#%f@fkk#f@k#fkfkf@fkfkfk%@%k#f@fk%%kffffkkff@fff@f@k#fk%#fkfkf@fkfkfk
	%kffffkkff@fff@f@k#fk%#f%kff@fkffkfffkfk#f@k#ffff%%fkk#k#%k#%fkk#k#%k#f%kff@fkffkfffkfk#f@k#ffff%k#kfkfk#fkfffk:=f@fkk%fkfff@%#f@%kffffkkff@fff@f@k#fk%#fkfk%k#ffff%f@f%kffffkkff@fff@f@k#fk%fkfk
;TRIPLE MESS FRAGMENTS FOR: k
	fk%ffkff@fk%fff@f%kff@fkffkfffkfk#f@k#ffff%f@f@%kffffkkff@fff@f@k#fk%#f@:=kf%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%fkkf%k#fkkff@%f%kff@fkffkfffkfk#f@k#ffff%fff@f@k#fk
	fkk%kfk#ff%%k#fkffkfk#fkffk#fffkfkf@%ff%fkk#k#%f%kff@fkffkfffkfk#f@k#ffff%kff@fk:=kffff%fffkf@ff%kk%ffk#ffk#%f%f@fkk#f@k#fkfkf@fkfkfk%@ff%f@fkk#f@k#fkfkf@fkfkfk%@f@k#fk
	%f@fkk#f@k#fkfkf@fkfkfk%ffkf%k#f@fffk%ff%kff@fkffkfffkfk#f@k#ffff%k#f@kff@:=kf%k#f@kfkf%fffkk%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%@fff%k#f@fk%@f@k#fk
	f@f%kff@fkffkfffkfk#f@k#ffff%ffk#k%k#fkffkfk#fkffk#fffkfkf@%k#kfk#f%f@kfkf%@k#k#:=%fkk#%kf%k#fkkf%f%f@fkk#f@k#fkfkf@fkfkfk%fk%kffffkkff@fff@f@k#fk%ff@fff@f@k#fk
	ffk%f@fkk#f@k#fkfkf@fkfkfk%f%fffkff%fkff%f@fkk#f@k#fkfkf@fkfkfk%f%kffffkkff@fff@f@k#fk%f@fk:=kfff%kfffkffk%fk%kffffkkff@fff@f@k#fk%f%f@fkk#f@k#fkfkf@fkfkfk%%fff@f@ff%@fff@f@k#fk
	f%fkkf%kk#ffk%k#fkffkfk#fkffk#fffkfkf@%fff%f@fkk#f@k#fkfkf@fkfkfk%k#fff%kffffkkff@fff@f@k#fk%fkfkf@:=%k#fffkf@%kffff%kffffkkff@fff@f@k#fk%kf%f@fkk#f@k#fkfkf@fkfkfk%@f%f@fkk#f@k#fkfkf@fkfkfk%f@f@k#fk
	kff%kffffkkff@fff@f@k#fk%k%ffkfkfkf%fkfk%k#fkffkfk#fkffk#fffkfkf@%kffkkf:=kffff%kffkfkk#%%fff@kf%kk%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%@fff@f@k#fk
	k#fk%k#f@kfff%fkkf%f@fkk#f@k#fkfkf@fkfkfk%kfk%k#kfkf%k%k#fkffkfk#fkffk#fffkfkf@%%f@fkk#f@k#fkfkf@fkfkfk%@f@ff:=kf%f@fkkf%%f@fkk#f@k#fkfkf@fkfkfk%ffkk%k#fkf@ff%ff@ff%f@fkk#f@k#fkfkf@fkfkfk%@f@k#fk
	k#k#fk%k#f@fk%fffkkff%kff@fkffkfffkfk#f@k#ffff%fkk%k#fkffkfk#fkffk#fffkfkf@%kffkkf:=k%f@fkk#f@k#fkfkf@fkfkfk%ff%f@fkk#f@k#fkfkf@fkfkfk%kkff@%f@ffff%fff@%f@fff@fk%f@k#fk
	f@f%f@k#fkk#%k%f@fkk#f@k#fkfkf@fkfkfk%@%f@fkk#f@k#fkfkf@fkfkfk%fk#%kffff@k#%ffkffkfk:=kfff%fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%%k#f@k#fk%kkff@%f@fkk#f@k#fkfkf@fkfkfk%ff@f@k#fk
	f%kffffkkff@fff@f@k#fk%ffk%f@fkk#f@k#fkfkf@fkfkfk%f%k#f@kfkf%ff%k#kfff%ff@f@:=kf%f@fkk#f@k#fkfkf@fkfkfk%ffkk%f@fkk#f@k#fkfkf@fkfkfk%f%fffkf@ff%@fff%k#kffk%@f@k#fk
	%kfk#ff%%f@fkk#f@k#fkfkf@fkfkfk%%kff@fkffkfffkfk#f@k#ffff%f%kff@fkffkfffkfk#f@k#ffff%kfkfffkff@kf:=kf%kfk#fkfk%fff%kffffkkff@fff@f@k#fk%k%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%@fff@f@k#fk
	%k#fkfk%fkf%kff@fkffkfffkfk#f@k#ffff%fk%f@ff%f%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%@k#f@f@fkk#:=kff%f@fffk%%f@f@k#%f%f@fkk#f@k#fkfkf@fkfkfk%kkff%kff@fkffkfffkfk#f@k#ffff%f%f@fkk#f@k#fkfkf@fkfkfk%f@f@k#fk
	k#f@k#%kfk#fkk#%fk%kffffkkff@fff@f@k#fk%%kffkkfkf%%f@fkk#f@k#fkfkf@fkfkfk%fkk#f@f@kffffk:=kff%f@fk%%f@fkk#f@k#fkfkf@fkfkfk%fkkf%f@fkk#f@k#fkfkf@fkfkfk%@fff%kff@fkffkfffkfk#f@k#ffff%%fkf@k#%f@k#fk
	kfkf%kffffkkff@fff@f@k#fk%%ffk#ff%#k%f@fkk#f@k#fkfkf@fkfkfk%ffk#k#:=k%f@fkk#f@k#fkfkf@fkfkfk%ff%f@fkk#f@k#fkfkf@fkfkfk%%fkkf%kkf%f@fkk#f@k#fkfkf@fkfkfk%@ff%fff@k#fk%f@f@k#fk
	kf%kffffkkff@fff@f@k#fk%ffk%fffkf@ff%k%k#f@%f%f@fkk#f@k#fkfkf@fkfkfk%f%f@fkk#f@k#fkfkf@fkfkfk%@k#kf:=kfff%kfk#fkfk%f%kffffkkff@fff@f@k#fk%kff@%f@fkk#f@k#fkfkf@fkfkfk%ff@f%kff@fkffkfffkfk#f@k#ffff%k#fk
	f%kff@%%f@fkff%f%f@fkk#f@k#fkfkf@fkfkfk%%kff@fkffkfffkfk#f@k#ffff%fffkkfk#kfkfk#:=k%fkfff@%ffff%kffffkkff@fff@f@k#fk%kff@%f@fkk#f@k#fkfkf@fkfkfk%ff%ffkff@fk%@f@k#fk
	k%k#f@fk%f%f@fkk#f@k#fkfkf@fkfkfk%f%kffffkkff@fff@f@k#fk%#k%f@kfkf%#k#kffk:=kf%f@fkk#f@k#fkfkf@fkfkfk%ffkk%k#fkf@ff%ff@f%fffkf@ff%f%f@fkk#f@k#fkfkf@fkfkfk%@%f@fkk#f@k#fkfkf@fkfkfk%@k#fk
	f@f%kffffkkff@fff@f@k#fk%kf%f@fk%fk%f@fkk#f@k#fkfkf@fkfkfk%@%f@fkk#f@k#fkfkf@fkfkfk%@ff%ffkff@fk%f@:=kf%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%%fkkf%fkk%f@fkk#f@k#fkfkf@fkfkfk%f@fff@f@k#fk
	%f@fkk#f@k#fkfkf@fkfkfk%@fk%f@fkk#f@k#fkfkf@fkfkfk%%fkf@k#%%kff@fkffkfffkfk#f@k#ffff%ff%f@ff%kffff@k#ff:=kf%kfff%fff%kffffkkff@fff@f@k#fk%kff@f%f@fkk#f@k#fkfkf@fkfkfk%f@%k#f@ffkf%f@k#fk
;TRIPLE MESS FRAGMENTS FOR: @
	ffff%kffffkkff@fff@f@k#fk%#k#%f@fkk#f@k#fkfkf@fkfkfk%%kff@%@k%k#fkffkfk#fkffk#fffkfkf@%f@%f@f@k#ff%kffffkkf:=kff@fk%k#ffff%ffkff%f@fkk#f@k#fkfkf@fkfkfk%kf%kffffkkff@fff@f@k#fk%#f@%fkfkfk%k#ffff
	k%k#fkffkfk#fkffk#fffkfkf@%%fkf@k#%f@kf%kffkk#k#%f%kffffkkff@fff@f@k#fk%fk%kffffkkff@fff@f@k#fk%#kfffkfk#ff:=kff@f%kffffkkff@fff@f@k#fk%ff%kffffkkff@fff@f@k#fk%fff%ffkfkfkf%kfk#f@k#ffff
	%f@fkk#f@k#fkfkf@fkfkfk%@kf%f@fkk#f@k#fkfkf@fkfkfk%%f@fffk%%f@fk%kk#fkk#ffff:=kff@fk%f@fkk#f@k#fkfkf@fkfkfk%fkf%kff@%ffkfk%k#fkffkfk#fkffk#fffkfkf@%f@k#ff%f@fkk#f@k#fkfkf@fkfkfk%f
	k#%f@fkk#f@k#fkfkf@fkfkfk%fk%k#f@fffk%#k#%kffffkkff@fff@f@k#fk%#kffkfk:=k%k#kfff%ff@f%kffffkkff@fff@f@k#fk%ffkff%f@fkk#f@k#fkfkf@fkfkfk%kfk#f@k#ffff
	k%fkfkffk#%f%kffffkkff@fff@f@k#fk%ffk%kffffkkff@fff@f@k#fk%#kff%k#f@fk%kk#fffk:=k%k#fkk#f@%f%f@fkk#f@k#fkfkf@fkfkfk%@fk%f@fkk#f@k#fkfkf@fkfkfk%fkfff%kffffkkff@fff@f@k#fk%fk#f@k#ffff
	k#k#%fkfff@f@%kf%f@fkk#f@k#fkfkf@fkfkfk%ff%f@fkk#f@k#fkfkf@fkfkfk%kff@fkffff:=kff@f%kffffkkff@fff@f@k#fk%ff%kffffkkff@fff@f@k#fk%fffkf%ffk#k#%k#f@k#ffff
	fkf%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%@f%f@fkk#f@k#fkfkf@fkfkfk%%fkfkfkk#%%kfk#fkfk%kffkk#f@ffffff:=k%f@fkk#f@k#fkfkf@fkfkfk%f@%f@fkk#f@k#fkfkf@fkfkfk%k%ffkf%ffkfff%kffffkkff@fff@f@k#fk%fk#f@k#ffff
	f@kf%ffk#%k#k#%kffffkkff@fff@f@k#fk%#ff%kffffkkff@fff@f@k#fk%%f@fkk#f@k#fkfkf@fkfkfk%kff@ff:=kff@fk%k#k#%%f@fkk#f@k#fkfkf@fkfkfk%fkfff%kffffkkff@fff@f@k#fk%fk%k#fkffkfk#fkffk#fffkfkf@%f@k#ffff
	k%fff@k#fk%ffk%f@fkk#f@k#fkfkf@fkfkfk%%kffffkkff@fff@f@k#fk%k%f@fkk#f@k#fkfkf@fkfkfk%k#kfkfk#:=%kffffkkff@fff@f@k#fk%f%fkfkk#ff%f@%f@fkk#f@k#fkfkf@fkfkfk%kffk%k#f@kfkf%fffkfk#f@k#ffff
	f@%kffffkkff@fff@f@k#fk%fk%k#fkfk%ffff%k#fkkf%kf%kff@fkffkfffkfk#f@k#ffff%fkk#k#f@fk:=k%f@fk%%f@fffkkf%%f@fkk#f@k#fkfkf@fkfkfk%f@f%kffffkkff@fff@f@k#fk%ff%kffffkkff@fff@f@k#fk%fffkfk#f@k#ffff
	fkf%kffffkkff@fff@f@k#fk%f@k%f@fkk#f@k#fkfkf@fkfkfk%f@%k#k#fffk%kff@k%f@fkk#f@k#fkfkf@fkfkfk%fff@:=kff@%f@fkk#f@k#fkfkf@fkfkfk%kff%k#fkfk%kfffk%ffk#ff%f%kffffkkff@fff@f@k#fk%#f@k#ffff
	fkk%f@fkk#f@k#fkfkf@fkfkfk%f@%kff@ffk#%%f@fkk#f@k#fkfkf@fkfkfk%@f@f%f@kfkf%kk#f@kffk:=kff@f%kffffkkff@fff@f@k#fk%f%kfff%%f@fkk#f@k#fkfkf@fkfkfk%%kffffkkff@fff@f@k#fk%fffkfk#f@k#ffff
	%f@fkk#f@k#fkfkf@fkfkfk%kk%f@fkk#f@k#fkfkf@fkfkfk%%k#fkf@ff%k%k#f@k#fk%%f@fkk#f@k#fkfkf@fkfkfk%fkfffff@fkf@:=kff@f%kffffkkff@fff@f@k#fk%ffk%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#ff%ffkfk#f@k#ffff
	fkk%k#fkffkfk#fkffk#fffkfkf@%k#%kffffkkff@fff@f@k#fk%ff%k#fkfkk#%k%kff@%%f@fkk#f@k#fkfkf@fkfkfk%fkfk#:=kff@f%kffffkkff@fff@f@k#fk%ff%kffffkkff@fff@f@k#fk%fffk%f@ff%fk%fffff@%#f@k#ffff
	%k#k#k#kf%k#k#f%f@fkk#f@k#fkfkf@fkfkfk%f@fff@%kffffkkff@fff@f@k#fk%#fkfkff:=kff@%f@fffk%fk%fff@k#fk%ff%kffffkkff@fff@f@k#fk%fff%kffffkkff@fff@f@k#fk%fk#%f@fkk#f@k#fkfkf@fkfkfk%@k#ffff
	k%f@fkk#f@k#fkfkf@fkfkfk%fff%kfffk#%ff%kff@fkffkfffkfk#f@k#ffff%fkfkkfkf:=kff@f%kffffkkff@fff@f@k#fk%ffkfffk%f@fkk#f@k#fkfkf@fkfkfk%k#f@k%k#kfkf%#ffff
	ff%kffffff@%f%kffffkkff@fff@f@k#fk%f@f%kff@fkffkfffkfk#f@k#ffff%kf%f@fkk#f@k#fkfkf@fkfkfk%@ffk#ffff:=k%f@fff@fk%ff@%k#f@fk%fk%f@fkk#f@k#fkfkf@fkfkfk%f%kffffkkff@fff@f@k#fk%fffk%f@fkk#f@k#fkfkf@fkfkfk%k#f@k#ffff
	ffkfk%k#fkffkfk#fkffk#fffkfkf@%k%f@f@k#%#f@kff%kff@fkffkfffkfk#f@k#ffff%kff@f@:=%kffffkkff@fff@f@k#fk%ff@%f@f@k#%fkffkff%f@fkk#f@k#fkfkf@fkfkfk%kfk#f@k#ffff
	k%kffkkfkf%f%f@fkk#f@k#fkfkf@fkfkfk%fkfk#fk%f@fkk#f@k#fkfkf@fkfkfk%@kfffkffff@:=kff@f%kffffkkff@fff@f@k#fk%f%f@fkk#f@k#fkfkf@fkfkfk%kfff%fkf@k#k#%kfk%k#fkffkfk#fkffk#fffkfkf@%f@k#ffff
	%f@fkk#f@k#fkfkf@fkfkfk%%ffkff@fk%%kfkff@%kf%kffffkkff@fff@f@k#fk%%kffffkkff@fff@f@k#fk%fk#k#k#f@kf:=kff@f%k#kfff%kffk%f@fkk#f@k#fkfkf@fkfkfk%f%ffk#f@kf%fkfk#%f@fkk#f@k#fkfkf@fkfkfk%@k#ffff
;TRIPLE MESS FRAGMENTS FOR: #
	fk%kfkff@%kfk%f@kf%#f%kff@fkffkfffkfk#f@k#ffff%f%kff@fkffkfffkfk#f@k#ffff%kff%kff@fkffkfffkfk#f@k#ffff%kf:=k#fk%fffkf@ff%%kffff@k#%f%f@fkk#f@k#fkfkf@fkfkfk%kfk#f%kffffkkff@fff@f@k#fk%ffk#fffkfkf@
	%kff@ffk#%k%f@fkk#f@k#fkfkf@fkfkfk%k%k#fkffkfk#fkffk#fffkfkf@%ffkfk#k#f@kfkfkfff:=k%fkfff@%#fkf%f@fkk#f@k#fkfkf@fkfkfk%kfk#f%kffffkkff@fff@f@k#fk%ffk%k#fkffkfk#fkffk#fffkfkf@%fffkfkf@
	ff%kffkfkk#%fk%kffffkkff@fff@f@k#fk%fk#%f@fkk#f@k#fkfkf@fkfkfk%kk%k#fkffkfk#fkffk#fffkfkf@%fff@ff:=%kffffkkff@fff@f@k#fk%%k#fkffkfk#fkffk#fffkfkf@%fkffk%fff@k#fk%f%kffffkkff@fff@f@k#fk%#fkffk#fffkfkf@
	k#fff@f%f@fkk#f@k#fkfkf@fkfkfk%%f@fffk%k%k#fkffkfk#fkffk#fffkfkf@%k#ffk#kffkfkfk:=k#f%kffffkkff@fff@f@k#fk%%kfk#fkk#%ffkfk#%f@fkk#f@k#fkfkf@fkfkfk%k%f@fkk#f@k#fkfkf@fkfkfk%fk#fffkfkf@
	k%kfff%#fff@%f@fkk#f@k#fkfkf@fkfkfk%%kffffkkff@fff@f@k#fk%fkf@f%f@fkk#f@k#fkfkf@fkfkfk%ffffff:=k#f%kffffkkff@fff@f@k#fk%ffkf%kffffkkff@fff@f@k#fk%#fkff%f@k#k#%k#ff%fkfkfk%fkfkf@
	%f@fkk#f@k#fkfkf@fkfkfk%k%f@fkk#f@k#fkfkf@fkfkfk%@%f@fkk#f@k#fkfkf@fkfkfk%f%f@fffkkf%f%k#k#fkkf%ff@k#ff:=k#%fffk%f%kffffkkff@fff@f@k#fk%f%f@fkk#f@k#fkfkf@fkfkfk%kfk#fk%k#f@kfkf%ffk#fffkfkf@
	fff%kffkk#%ffk%f@fkk#f@k#fkfkf@fkfkfk%k%f@fkk#f@k#fkfkf@fkfkfk%ff%kffffkkff@fff@f@k#fk%k#fkkf:=k%f@fkkf%%kfk#ff%#fkf%f@fkk#f@k#fkfkf@fkfkfk%kfk#fk%f@fkk#f@k#fkfkf@fkfkfk%fk#fffkfkf@
	f%f@fkk#f@k#fkfkf@fkfkfk%%f@fkk#f@k#fkfkf@fkfkfk%k%k#fkkff@%f@f%ffkfkf%@fkfkfkf@:=k#fkf%f@fkkf%fkfk#f%kffffkkff@fff@f@k#fk%ffk%k#fkffkfk#fkffk#fffkfkf@%fffkfk%f@fkk#f@k#fkfkf@fkfkfk%@
	fff%f@fkff%kk#fff%kffffkkff@fff@f@k#fk%k%k#fkffkfk#fkffk#fffkfkf@%ffk#fff@:=k#%ffk#ff%fkf%f@fkk#f@k#fkfkf@fkfkfk%%k#fkkff@%kfk#%f@fkk#f@k#fkfkf@fkfkfk%kffk%k#fkffkfk#fkffk#fffkfkf@%fffkfkf@
	%f@fkk#f@k#fkfkf@fkfkfk%k%f@fkk#f@k#fkfkf@fkfkfk%@f%kfffff%%f@f@fkfk%kkf%kffffkkff@fff@f@k#fk%fk#fkkffffkf@:=%kffffkkff@fff@f@k#fk%#fkff%kffffkkff@fff@f@k#fk%fk#fk%fkf@%ffk#fffkfkf@
	%k#k#fkkf%ff%f@fkk#f@k#fkfkf@fkfkfk%%kffffkkff@fff@f@k#fk%k%k#fkffkfk#fkffk#fffkfkf@%f@ffkfkfkf:=k#fkf%f@fkk#f@k#fkfkf@fkfkfk%kfk#fk%kffkk#k#%ffk#ff%f@fkk#f@k#fkfkf@fkfkfk%kfkf@
	f%kff@fkffkfffkfk#f@k#ffff%k%f@fffkkf%ff%kffffkkff@fff@f@k#fk%fffkffk#k#:=k#f%kffffkkff@fff@f@k#fk%ffkf%kffffkkff@fff@f@k#fk%#f%kffffkkff@fff@f@k#fk%ff%k#f@%k#f%k#fkf@ff%ffkfkf@
	%ffkfkf%f@ffk%k#f@fk%ff@%f@fkk#f@k#fkfkf@fkfkfk%@%f@fkk#f@k#fkfkf@fkfkfk%kfkkfkff@f@:=k#f%kffffkkff@fff@f@k#fk%ffkf%ffkfkf%k%ffk#f@kf%#fkf%f@fkk#f@k#fkfkf@fkfkfk%k%k#fkffkfk#fkffk#fffkfkf@%fffkfkf@
	f%f@fffkkf%k%ffkfkf%kf%f@fkk#f@k#fkfkf@fkfkfk%k%f@fkk#f@k#fkfkf@fkfkfk%kkfkffffk:=k#%f@fkk#f@k#fkfkf@fkfkfk%kffk%fffk%fk#fk%f@fkk#f@k#fkfkf@fkfkfk%fk#f%k#kfff%ffkfkf@
	k#%kfk#fkk#%f%kff@fkffkfffkfk#f@k#ffff%kf%kffffkkff@fff@f@k#fk%#kfkfk#f@:=k#fkff%kffffkkff@fff@f@k#fk%f%kffffkkff@fff@f@k#fk%#fkffk%k#k#fffk%#%f@fkk#f@k#fkfkf@fkfkfk%ffkfkf@
	fk%k#kffk%k#%f@fkk#f@k#fkfkf@fkfkfk%%kff@fkffkfffkfk#f@k#ffff%f@f@f@k#f@k#fkfk:=k#fkff%kffffkkff@fff@f@k#fk%fk#fkf%k#f@kfkf%f%kffffkkff@fff@f@k#fk%#f%f@kfkf%ffkfkf@
	fkfff%kff@fkffkfffkfk#f@k#ffff%%kffffkkff@fff@f@k#fk%fk%fkk#k#%ffkfkf@:=k#f%kffffkkff@fff@f@k#fk%ff%k#kffk%kfk%k#fkffkfk#fkffk#fffkfkf@%fkf%f@fkk#f@k#fkfkf@fkfkfk%k#fffkfkf@
	fkkf%k#f@ffkf%fkk%f@fkk#f@k#fkfkf@fkfkfk%k#kf%f@fkk#f@k#fkfkf@fkfkfk%@fkkf%f@fkk#f@k#fkfkf@fkfkfk%@k#:=k#%f@f@f@%fkffkf%kffffkkff@fff@f@k#fk%#fkffk%k#fkffkfk#fkffk#fffkfkf@%%f@fkk#f@k#fkfkf@fkfkfk%ffkfkf@
	kfkff%kffff@%kk#k%f@fkk#f@k#fkfkf@fkfkfk%k%f@fkk#f@k#fkfkf@fkfkfk%f@fkk#k#ff:=k#f%kffffkkff@fff@f@k#fk%%f@fffk%ffkf%kffffkkff@fff@f@k#fk%#fkffk#fffkfkf@
	%fkfkffk#%f@f%kff@fkffkfffkfk#f@k#ffff%k#fk%fkfkk#ff%fffk%f@fkk#f@k#fkfkf@fkfkfk%f%kffffkkff@fff@f@k#fk%ffkf@:=%kffffkkff@fff@f@k#fk%#%f@fkk#f@k#fkfkf@fkfkfk%k%f@fkk#f@k#fkfkf@fkfkfk%f%k#f@fffk%kfk%f@f@ff%#fkffk#fffkfkf@

}

;$OBFUSCATOR: $FUNCS_RESTORE_DEFAULTS:

;$OBFUSCATOR: $FUNCS_CHANGE_DEFAULTS: ,, -1
;FUNCTION ORIGINAL NAME: obf_dumpunclassed
kffffff@kfkffkkf() { 
global
;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
;OBF_FUNC name: helloworld
	k%kfk#ffkfk#k#f@kfkfkfff%%f@fkk#ff%f%k#f@kfffk#k#fkffkffk%%fkfkk#ff%%k#f@f@fkk#fffkf@k#kfkf%@k#f@ffkf=fk%f@fkf@ffkffff@k#ff%#%f@f@ff%kf%fkk#k#%%f@f@kff@f@k#f@ffffk#fkf@%%k#k#fffkf@f@ffkfkfkffkff%kffkf@
	ffk%fffkk#fffkk#ffk#fff@%ff%f@f@f@fk%f%k#f@kffkfkk#kfffkfk#ff%fff%f@kfkf%@kf=%kfffk#%fk%kfffk#k#k#kffk%#k%f@fkf@fffkfkfkf@kfffk#fk%ffk%k#f@k#k#f@k#kfkfk#fkfffk%fkf@
;OBF_FUNC name: testfunction
	f@ff%k#f@k#k#f@k#kfkfk#fkfffk%ff%ffk#%@kfk%fffffkfkfffkk#fkkf%=%kffkkfkfk#kffkkf%#k%k#fkkf%ff%fffff@%f%kfk#f@kff@ffkff@kf%kfkkff@
	kf%kffkkfkfk#kffkkf%f%f@ffkfk#ffffkff@ffk#kfkf%kf%f@fffkkf%@f%ffffk#f@kfkff@f@fk%k#ff=k#kf%f@fkf@fffkfkfkf@kfffk#fk%ffkf%fff@kf%%kfffk#k#k#kffk%kff@
;OBF_FUNC name: test_parameters
	%f@f@ffk#k#k#kfk#f@k#k#%%fkfff@f@%%f@ffkfk#ffffkff@ffk#kfkf%%f@fff@fk%%fkfff@f@f@f@k#f@%fk#f@k#fkfk=k%kfk#fkk#%f%k#f@f@fkk#fffkf@k#kfkf%@f%f@kff@%@%k#f@k#k#f@k#kfkfk#fkfffk%%k#f@kffkfkk#kfffkfk#ff%kfk#
	fff%kfff%%f@f@kfkfffkff@kf%ff%f@f@f@k#kfkfkff@k#k#%@k#fkfkff=kf%kffff@%f@%fkfff@%%k#fkk#fffkffffk#fkffkf%%f@kfkffffkf@fkk#k#f@fk%f@kfk#
;OBF_FUNC name: creategui
	%kfffk#k#k#kffk%%f@ffkff@f@fkfkkfkff@f@%%fkkf%f%kffffff@%@k%k#f@k#k#f@k#kfkfk#fkfffk%kff@k#k#=k#%k#f@fffk%kfk%fffkk#f@ffkfkfkf%ffk%ffkfff%%k#f@kfk#kfkfk#f@%%ffffk#f@kfkff@f@fk%@kfk#
	%kfkffkkffff@k#kf%#%ffkff@fk%%fkfffkff%f@%k#f@f@fkk#fffkf@k#kfkf%f%kfk#f@kff@ffkff@kf%@fkk#k#k#=k#k%k#kffk%f%f@fkf@ffk#ffkffkfk%#%f@fkkf%f%f@kffkfkkff@f@k#k#fkfk%k#f@kfk#
;OBF_FUNC name: obf_dumpcommonobjfrags
;OBF_FUNC name: obf_dumpunclassed
;OBF_FUNC name: obf_dumpunsecclasses
;OBF_FUNC name: obf_dumpall
	kff%k#f@kfffk#k#fkffkffk%fkfk%k#fkfkk#%kfk#%fffkf@ff%f@fk=f@f@%f@ffkfkfkfffk#fkffkfkf%kfk%fkfff@%%k#k#fffkf@f@ffkfkfkffkff%ffkfk
	k%f@ffkfkfkfffk#fkffkfkf%%f@fff@fk%f@k%f@f@kff@f@k#f@ffffk#fkf@%kfkfffff=f@%k#k#ffk#fff@fkf@fkf@%%fkk#ffk#%@%f@fkf@fffkfkfkf@kfffk#fk%kf%kffkk#k#%k%f@ffkfkfkfffk#fkffkfkf%ffkfk

;OBF_LABEL name: test_label
	k%f@kfkf%#%f@ffkfk#ffffkff@ffk#kfkf%fk%ffk#fkf@fff@k#fff@k#fkf@%ffkfk#kfk#f@kffkfkk#f@f@kfff=%fkffffkfffk#kf%ff@k#%k#fkfkkffkfkk#f@f@ff%#k#%kfffk#%%k#k#fkkf%fk%kffkkfkfk#kffkkf%#kfk#f@kff@k#ff
	kf%fkkf%k#fk%f@k#k#%f@f@ff%ffffk#f@kfkff@f@fk%kfffk%kfkffkkffff@k#kf%#fkf@k#fkff=fff@k%fffkk#fffkk#ffk#fff@%k#k#fkk%f@kffkfffkffk#k#%kfk#f@k%kffff@%ff@k#ff
;OBF_LABEL name: testguisubmit
	f@f@fk%k#k#k#kf%fffk%k#k#f@f@%ffkfff%f@f@f@k#kfkfkff@k#k#%f%fkffffkfffk#kf%@f@k#ff=fk%fkk#%%fkfff@%f%fkk#ffk#ffffk#fffkfkfkf@%kf%f@f@kff@f@k#f@ffffk#fkf@%%kffkfkkfk#kfkfk#%ffkfk#fkkfffk#ff
	f%fkk#ffk#%k%f@k#fkk#%f%k#ffk#k#k#kffkfk%k#f%k#f@kfffk#k#fkffkffk%fkf%f@kffkfkkff@f@k#k#fkfk%k#ffk#kfffk#=fkf%k#k#fffk%kkff@f%f@k#fkk#%fkfk%kfk#ffkfk#k#f@kfkfkfff%fkkfff%k#fkfkkffkfkk#f@f@ff%#ff
;OBF_LABEL name: cancelprog
	%fkf@fkfff@k#f@f@fkk#%ff@f%fkff%@%fkk#ffk#ffffk#fffkfkfkf@%#fkf%kff@%fffffffk#f@f@k#k#=fkfkf%fkffffkfffk#kf%f@k%fffkk#fffkk#ffk#fff@%f@%f@fkf@ffk#ffkffkfk%%kff@ffk#%#k%fkf@k#%#f@kffkk#f@
	fk%k#fkk#fffkffffk#fkffkf%@f@fkk%f@kffkfffkffk#k#%k#fkffk%k#k#f@f@%fk%f@kf%ff@fkf@k#fffk=%f@k#fkk#%fkfkf%k#f@f@fkk#fffkf@k#kfkf%f@%fkk#fff@kff@fk%#f@k#k#f@kffkk#f@
;OBF_LABEL name: guigosub
	fffkk#f%fkk#fff@kff@fk%fk%fkffffkfffk#kf%kfkk#f%f@f@fkfk%k%k#fkkff@%k#k#fkk#ff=%kfkffkkffff@k#kf%%f@ffkfkfkfffk#fkffkfkf%fff@f%k#fkkf%fk#f@k#%kfkfk#kfffk#k#%#k#fkfffffffkfkffk#
	f@f@%ffkf%fkkffff%fffkf@f@kff@ffk#ffff%k#k#f%ffkfff%ffkk#fk%f@kffkfkkff@f@k#k#fkfk%@ffkf=kfff%fkf@%f@%f@ffkfkfkfffk#fkffkfkf%%f@fkk#%fk%fffkf@f@fkfkfkf@%f@k#k#%k#fkfkkffkfkk#f@f@ff%#fkfffffffkfkffk#

}


;FUNCTION ORIGINAL NAME: obf_dumpunsecclasses
f@k#fkffk#kfk#f@() { 
global
;always use these dumps for function and label fragments when
;doing dynamic obfuscation 


}

;$OBFUSCATOR: $FUNCS_RESTORE_DEFAULTS:

;FUNCTION ORIGINAL NAME: obf_dumpall
f@f@fkfkfffkfk() { 
global
;dump all fragments 
;OBF_GLOBVAR name: mytrue
	kf%kfk#ff%%fffkff%f@%k#fkf@fkk#fff@fkkff@ff%kf%k#f@f@fkk#fffkf@k#kfkf%=f@%kfk#ff%f%fkk#ffk#ffffk#fffkfkfkf@%%k#fkf@fkk#fff@fkkff@ff%kf@fk
	fk%f@fffk%%fkfkffk#%f@%kfffk#k#k#kffk%f%f@fkkffkf@f@fff@%ff%f@f@f@k#kfkfkff@k#k#%=%f@ffkfkfkfffk#fkffkfkf%@fk%k#f@fffffff@fkf@ff%k%fkk#k#%f@fk
;OBF_GLOBVAR name: myfalse
	f@%kfk#f@kff@ffkff@kf%f%fkk#fff@kff@fk%ff%k#f@f@fkk#fffkf@k#kfkf%f@=k#%fkfff@f@f@f@k#f@%#f%kfffk#%%k#f@kfffk#k#fkffkffk%ff
	f%kffffff@fkfkkfkf%fk%kffff@%kf%f@fkff%%f@f@kfkfffkff@kf%#%ffffk#f@kfkff@f@fk%@=k#%f@f@k#ff%k#%k#f@fffffff@fkf@ff%ff%kfk#f@kff@ffkff@kf%
;OBF_GLOBVAR name: usermessage
	f@k%k#fkkff@%%f@k#k#fkfffkffk#f@%%f@fkkffkf@f@fff@%#fkkf=kf%fkk#%k%kfkfkff@ffffffk#fkfkff%k#%k#fkfkkffkfkk#f@f@ff%fk#
	%k#f@f@fkk#fffkf@k#kfkf%k%kfkfkff@ffffffk#fkfkff%%f@kffkk#fkk#ffff%f%k#fkf@ff%@k#=kf%k#fkkf%kfk%f@kffkfffkffk#k#%%k#k#fkfffkkff@fkk#kffkkf%fk#

;$OBFUSCATOR: $GLOBPARTIALVARSFRAGS_DUMPALL:
;LOS vars for function  named: creategui
;OBF_FUNC_4_LOSVAR name: h1font
	k#%f@f@kff@f@k#f@ffffk#fkf@%kkf%fkfff@%kfk%k#f@kfk#kfkfk#f@%ffk%k#f@fffffff@fkf@ff%f@f%f@f@k#ff%fk#=fff%f@k#fkk#%@k%k#f@k#k#f@k#kfkfk#fkfffk%ffkff%k#k#kfffffkff@fkffff%k#kffkff
	kf%k#f@fffffff@fkf@ff%@f%f@kfkffffkf@fkk#k#f@fk%f@f%kff@%@k#%k#k#f@f@%%k#k#ffk#fff@fkf@fkf@%@f@f@fk=%fkf@k#%f%k#f@k#k#f@k#kfkfk#fkfffk%f%fkfkkfk#k#k#f@kf%kfffk%k#fkk#fffkffffk#fkffkf%f@k#kffkff
;OBF_FUNC_4_LOSVAR name: h2font
	fk%ffkf%f%kffkfkk#%ff%fkk#k#kffkffkfk#%%f@kffkfkkff@f@k#k#fkfk%kf@fffffkfk=%k#ffff%f%kfk#f@kff@ffkff@kf%f%k#f@kffkfkk#kfffkfk#ff%%fkffffkfffk#kf%@k#f@k#k#k#kf
	%kfk#fkfk%f@%ffkfffkffffkf@fk%#k#%kfk#f@kff@ffkff@kf%kk#k%k#k#fffkf@f@ffkfkfkffkff%kff@kffkf@=f%f@fkff%ff@%ffkfkfff%f%kfkffkk#kffkk#fffk%k%fkkfk#f@f@kff@kf%f%kffffff@fkfkkfkf%k#k#k#kf
;OBF_FUNC_4_LOSVAR name: basefont
	%k#k#ffk#fff@fkf@fkf@%%k#fkf@ff%@f@%f@f@kff@f@k#f@ffffk#fkf@%kf@%f@f@f@k#kfkfkff@k#k#%@f@fkkf=fkk#%kfk#f@kff@ffkff@kf%ffkk%kfkff@%#%k#f@kfffk#k#fkffkffk%k%fffk%fkkfff
	k#%ffk#%f%k#f@k#k#f@k#kfkfk#fkfffk%ffk%f@f@k#fkfffkffkffkf@%fkk#%kfk#f@kff@ffkff@kf%fk#kfff=fkk%f@k#k#kf%#f%k#f@fffk%ff%f@fkkffkf@f@fff@%k#f%fkffkffffff@f@%fk%fffkfff@k#f@kff@%fff
;OBF_FUNC_4_LOSVAR name: mymessage
	k#k%kfffk#%#kfk%fkk#f@f@f@f@k#f@k#fkfk%%kffkkfkfk#kffkkf%#f@fkkf=f%fff@f@ff%@%kff@kf%ff%ffffk#f@kfkff@f@fk%k%ffkfffkffffkf@fk%#kffffk
	f%k#f@kffkfkk#kfffkfk#ff%%k#f@fffk%k%kffkk#%f%k#f@k#fkkffkk#f@f@kffffk%#f@fkfkkfkfkf=f%ffkfkfff%@fff%kfffk#k#k#kffk%k#%fkk#fff@kff@fk%ffffk

;PARAMETERS for function  named: test_parameters
;OBF_FUNC_3_PARAM name: myparam
	f@%kffkfkk#%kff%f@f@ff%ffk%f@ffkfkfkfffk#fkffkfkf%@ffk%ffffk#f@kfkff@f@fk%f@ff%f@kffkfkkff@f@k#k#fkfk%ff@=f%fkfkk#ff%%fkfff@f@f@f@k#f@%%fkfff@f@f@f@k#f@%ffkk#k#fkffff
	%k#f@k#fk%f@fkf%fkk#ffk#ffffk#fffkfkfkf@%k#%f@fkkffkf@f@fff@%#k#fkk#=fkk%f@fkkf%ff%ffkfffkffffkf@fk%k#k%fffkk#f@ffkfkfkf%fkffff

;OBF_SYSFUNC name: DllCall
	ffkf%f@kff@%fffk%f@fkkffkf@f@fff@%ffk%fkfkfkk#%f@ff=%f@ffff%%f@ff%D%ffk#%l%ffkfkfkf%l%fffk%C%k#fkkf%a%fkfkfk%%ffkfkf%
	kff%k#f@kfff%ff%fffkfff@k#f@kff@%k#f%kff@%kkf=%k#k#fffk%%f@k#fkk#%l%fkkf%l%kffkfkk#%%k#fkf@ff%
	%f@fkk#ff%f%kfkffkk#kffkk#fffk%%kfkfkff@ffffffk#fkfkff%@f%f@fkff%@f%k#f@fffffff@fkf@ff%f@kffkf@=%fkfff@f@%%fkff%D%k#k#fffk%%k#f@fk%
	%kfffk#k#k#kffk%f%fkfff@f@f@f@k#f@%%kffkkfkf%ff@%fffff@%k#fffkkf=%kfk#fkfk%%k#kffk%l%kfk#ff%l%k#k#f@f@%C%f@fkff%a%f@kfkf%l%k#f@kfkf%l%fkf@k#k#%%f@fkk#%
	f%f@ffkfkfkfffk#fkffkfkf%f@%k#f@kfffk#k#fkffkffk%kf%ffkf%k%fkf@k#%kfkfk#fk=%f@fk%%k#f@%D%f@f@ff%%k#f@ffkf%
	fkf%kfk#fkk#%%f@f@ffk#k#k#kfk#f@k#k#%%k#fkfkkffkfkk#f@f@ff%#k#%k#fkf@fkk#fff@fkkff@ff%ffkfk=%f@fkk#ff%%kffkk#k#%l%ffkfkfff%l%k#fkfkk#%C%kff@fk%a%kffkfkk#%l%k#fkk#f@%l%fkf@k#%%f@kf%
	fk%kfkff@%fff%ffffk#f@kfkff@f@fk%f%f@fkf@ffkffff@k#ff%k#kffffk=%f@f@f@%%f@f@f@fk%D%kffkk#k#%l%ffk#ffk#%l%f@kff@%C%f@f@k#ff%a%ffk#ffk#%%k#f@fk%
	kf%fkfkfkk#%f%fffkf@f@kff@ffk#ffff%f%k#k#ffk#fff@fkf@fkf@%ff%fff@f@ff%k%f@kffkfkkff@f@k#k#fkfk%ffk#ff=%k#fkkf%%fffkf@ff%l%k#ffff%l%fffkff%%k#f@kfkf%
;OBF_SYSFUNC name: WinExist
	%f@fkf@fffkfkfkf@kfffk#fk%f%k#k#fffkf@f@ffkfkfkffkff%%fkk#k#kffkffkfk#%f@%fffk%fk%k#f@kfkf%fffkfkkf=%ffk#k#%%f@fffkkf%W%fff@k#fk%i%kffkk#%n%kffffff@%E%f@kfkf%x%f@k#fkk#%i%kfk#fkk#%%f@fkkf%
	f@%k#k#kfff%fff%kfffk#k#k#kffk%k#%ffk#%f%k#f@fffffff@fkf@ff%fkf%ffffk#k#f@k#f@kffffkkf%kf=%f@f@fkfk%%fkk#fkkf%s%k#kfkf%t%f@kff@%%ffk#ff%
	kff%k#k#%k%kfkfk#kfffk#k#%#fk%k#fkfkkffkfkk#f@f@ff%%k#k#ffk#fff@fkf@fkf@%kfk#=%f@kfkf%%ffk#ff%W%f@fk%i%f@fk%%fkfkfkk#%
	kff%k#f@kfffk#k#fkffkffk%ffff%k#fkfkkffkfkk#f@f@ff%f%f@f@f@%fkf@kf=%k#kfff%%kfk#fkfk%n%k#kfff%E%f@f@f@fk%x%ffk#%i%fff@f@ff%s%k#fkf@ff%t%k#f@k#fk%%fff@kf%
	f%ffkfffkffffkf@fk%f%kfffk#k#k#kffk%f%ffkfkfkf%f%fff@k#fk%kfkfkfff=%kffff@k#%%fff@k#fk%W%fkk#ffk#%i%fkfkfk%n%kffff@k#%%ffk#%
	k%f@fff@fk%fkf%ffk#fkf@fff@k#fff@k#fkf@%@f@k%k#fff@ffk#k#ffk#kffkfkfk%kfk#kf=%f@fkk#%%k#f@%E%kfffff%x%k#f@fk%i%k#kfkf%s%f@f@k#%t%f@f@fkfk%%fkfkffk#%
	f%k#fkkff@%@%f@fkf@ffk#ffkffkfk%ffk%f@fkf@fffkfkfkf@kfffk#fk%@f%f@f@f@k#kfkfkff@k#k#%ffk#=%kfk#fkk#%%f@fffkkf%W%kfk#ff%i%fff@kf%n%k#ffff%%kfffkffk%
	f%k#f@kfffk#k#fkffkffk%fk%k#f@kfkf%ff%f@f@f@k#kfkfkff@k#k#%fk%f@ffkfk#ffffkff@ffk#kfkf%ffk#=%kffffff@%%k#fkf@ff%E%f@k#k#%x%f@fkkf%i%k#k#f@f@%s%kffkfkk#%t%kfk#fkfk%%k#f@k#fk%


} 

