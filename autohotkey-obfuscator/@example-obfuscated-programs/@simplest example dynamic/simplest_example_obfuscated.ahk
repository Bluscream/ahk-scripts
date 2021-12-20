obf_copyright := " Date: 22:38 lundi 19 mars 2018                 "
obf_copyright := "                                                "
obf_copyright := " THE FOLLOWING AUTOHOTKEY SCRIPT WAS OBFUSCATED "
obf_copyright := " BY DYNAMIC OBFUSCATOR L FOR AUTOHOTKEY         "
obf_copyright := " By DigiDon                             		  "
obf_copyright := "                                                "
obf_copyright := " Based on DYNAMIC OBFUSCATOR                    "
obf_copyright := " Copyright (C) 2011-2013  David Malia           "
obf_copyright := " DYNAMIC OBFUSCATOR is released under           "
obf_copyright := " the Open Source GPL License                    "


;AUTOEXECUTE ORIGINAL NAME: autoexecute
;autoexecute
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;[!! IMPORTANT !!] use this statement to set dynamic obfuscation
;$OBFUSCATOR: $DYNAMIC_MODE:

;[!! IMPORTANT !!] DUMP CALLS : For dynamic obfuscation we need to call these functions before anything needs to be obfuscated
;**************************************
;DUMP FUNCTION CALLS (DUMP FUNCTIONS ARE INSERTED BELOW)
k#@ff%@kk@f#k#%k#f@f#k@f@k() 
f@k%#f#k@k%#ffff@fkk@f() 
f%kfffkf%@@k@kk%@kk@f#k#%fkf#fff() 
#ffk%kfk#@fkfkf#k#kkk#f#k%fk@k##f%k@f@#f@k%#kkk() 
;************************************* 


;[!! IMPORTANT !!] You CAN ask to obfuscate your global variables 
;You CAN also use this command for local variables if you wish to put them all on top, and do not want to specify them each time inside the function
;$OBFUSCATOR: $DEFGLOBVARS: k%k@k#k#%%k#k@f#kffffkk#@k@f#fkf%%f@#f@k@k%fk@kf@,f%@kkkfk%k%k#@k%f%f#k@@fkkk@@fk@@f%k#kf

k%#fk@k#f@kkf#k#kf%f%ffff@k@k%k%f#fk#f%@kf@:="The value of global is:"
f%ffkk@k@k@f@f#f%%kk@kk#k@k#fkk@f#kkk#%f%kkfkf#ff%k%kf@kffk#%#kf:="This is a test"

;test obfuscation of function call
%f@#ffffff#kf@fk@%%#kf#kkk#%%fkf##f@k%()

return

;[!! IMPORTANT !!] RESPECT THE FUNCTION CONVENTIONS
;only the opening bracket CAN be at character 1 of the line
;only the end bracket MUST BE at character 1 of the line
;FUNCTION ORIGINAL NAME: testfunction
k#k@f#fkf#@kff#k(f@fff#f@#f#fkf="params are automatically obfuscated") {
global
local @k@k#ff@#f#f@kf@k@k@@k,kfkk@fkkk#ff#f
;[!! IMPORTANT !!] You CAN ask to obfuscate the local variables by listing them INSIDE the function
;$OBFUSCATOR: $DEFLOSVARS: %f#fk#f%%f#ffkk%%@k@kkk#kfkf@k@k@k@fk@kk@fffk%,%#f#k@k%%k#kkfkkkf#k@ffk#k@#k@kff#ff#%%k@kk%

%f@ff@f%%kk#f#ffkf@k@k#ff#ff@@kk#%%@kfkkf%:="The value of local is:"
kfk%fkk@k#%k%k@k#@kkkffk#fkkk@f@k%f%k#kkfk#fkff@f@@k%kk#ff#f:="This is a test"
msgbox % @k@%@k#fff%k#f%@kf##f#fff#kf#k@f@%@#f%fkk@f#fkfk#kkkkffk%f@kf@k@k@@k "`n" kfk%kk#fk@fkff@f@ffffkk@#f%%ffkf#k@k%@fk%ffk##kk#%kk#ff#f "`n" k%@ff#f#kk#k#kk#fkk@fkkk%f%kfffk#@fkkkk#f%%@kk#%@%#kf@f@ff%kf@ "`n" f%#k@fk@f#k#k@#kkf@fk@@fkk%ffk%@f#kk@fk%#kf "`n" f%kfk##k%@%kkf#f@#kf#kk@f@kfkff%ff%#kf#kkk#%#f%@ff#f#kk#k#kk#fkk@fkkk%#f#fkf

}

;[!! IMPORTANT !!] DUMP FUNCTIONS : JUST COPY PASTE THIS INTO YOUR SCRIPT
;*************************************************************
;         O B F   D U M P   F U C T I O N S 
;************************************************************* 
;$OBFUSCATOR: $FUNCS_CHANGE_DEFAULTS: ,, -1 
;FUNCTION ORIGINAL NAME: obf_dumpcommonobjfrags
k#@ffk#f@f#k@f@k() {  
global 
	;SECURITY CLASS FRAG: for class: COMMON for char: f
	#%fk#ff#@k%kf%kkf#fk%k%@k@f%f#%kfkk#fff%#f#kkffkkk=%kfk#kk%f%fk#fff@k%
	;SECURITY CLASS FRAG: for class: COMMON for char: k
	f%ff@kk@@k%f%@fkk%ff%@kk#%%kfk##k%k@f##f@f=%kkf#fk%k%fk#k%
	;SECURITY CLASS FRAG: for class: COMMON for char: @
	f%@ffk%%k@f#k@f#%k%#kfkffk@%%f@ff#f%#ff@kkfkfk@k#f=%k@#kk@f@%@%kffkf#%
	;SECURITY CLASS FRAG: for class: COMMON for char: #
	f@%k@kk%f%#f#k@k%#%ffk##kk#%kfk##f@kkk=%ffff@k@k%#%f@#f@k@k%

;TRIPLE MESS FRAGMENTS FOR: f
	f@k#%kkfkf#ff%fkf%#kfkf##f#kkffkkk%fk#f%ffffk@f##f@f%ff@f##k:=#%k@kk%kf%ffffk@f##f@f%f#%f#kk#fk@%#%#kfkf##f#kkffkkk%%f@f#kfk##f@kkk%kkffkkk
	f#%k@f#k@f#%k@@%#f#f@fkf%fk%ffffk@f##f@f%k@%fk#ff@kkfkfk@k#f%fk@@f:=#%ffffk@f##f@f%%ffk##kk#%%#kfkf##f#kkffkkk%%@ffk%k%#kfkf##f#kkffkkk%##f#kkffkkk
	@kf%f@f#kfk##f@kkk%%#kfkf@@f%#f%#kf@#k%%f@f#kfk##f@kkk%fff#kf#k@f@:=#k%#kfkf##f#kkffkkk%kf%kk@kkff#%##f%f@f#kfk##f@kkk%kkffkkk
	k%#kfkf##f#kkffkkk%%#kfkf##f#kkffkkk%%#f#k@k%k%#fk#f@fk%k%#kfkf##f#kkffkkk%@fkf@k#k#f#f#f:=#%kk@kkff#%%kk#ff#%kf%ffffk@f##f@f%%#kfkf##f#kkffkkk%##f#kkffkkk
	@fk@f%ffffk@f##f@f%f%fkkfff%@kk%#kfkf##f#kkffkkk%kkf%#kfkf##f#kkffkkk%#kkkkffk@:=#kf%ffffk@f##f@f%f##%#kfkf##f#kkffkkk%%fkk@k#%%fkk@k#%#kkffkkk
	f%#ffk@kfk%f%#f@k#kk#%kf%ffffk@f##f@f%%fk#ff@kkfkfk@k#f%f@k@@fkkffk@:=#%#fkkk#f#%kf%ffffk@f##f@f%f%f@f#kfk##f@kkk%#f%f@f#kfk##f@kkk%kkffkkk
	#%@f#kk@@k%kf%f#kk#fk@%k@k%#kfkf##f#kkffkkk%@f%fk#ff@kkfkfk@k#f%k#k#@f:=#%k@f#k@f#%%k@f@#f@k%%ffffk@f##f@f%f%ffffk@f##f@f%f##f#kkffkkk
	f##%@k@fffkf%ff#%f@@kkk#k%fk%ffffk@f##f@f%#f%#kfkf##f#kkffkkk%ff%#kfkf##f#kkffkkk%fff#kfkfk:=#k%f@@kkk#k%fkf%f@f#kfk##f@kkk%#%#kfkf##f#kkffkkk%#k%ffffk@f##f@f%ffkkk
	f@%f@f#kfk##f@kkk%k%@f#kk@@k%f@k%#kfkf##f#kkffkkk%kfffkkfk:=#k%fkkfff%fk%#kfkf##f#kkffkkk%#%f@f#kfk##f@kkk%%#kfkf##f#kkffkkk%#kkffkkk
	f@k#%kk#fk#ff%fffkf%@k@k%@%ffffk@f##f@f%#kk%#kfkf##f#kkffkkk%f@fffffff:=#k%f#k#k@@f%fkf#%f@f#kfk##f@kkk%f%f@f#kfk##f@kkk%kkffkkk
	fff%f@f#kfk##f@kkk%f%@kk@f#k#%ff%f#k#k@@f%%f@f#kfk##f@kkk%k#kkkf#k:=#kf%kk#ff#%%ffffk@f##f@f%f%f@f#kfk##f@kkk%#%#kfkf##f#kkffkkk%#kkffkkk
	#kfk#k%ffffk@f##f@f%#@kk#@f%fkkfff%%#kfkf##f#kkffkkk%@#ff#kk#k:=#kfk%#kfkf##f#kkffkkk%##f%f@f#kfk##f@kkk%kkff%#kf@#k%kkk
	@%f@kf@f#f%k%#kfkf##f#kkffkkk%f%#kfkf##f#kkffkkk%ffkfkkff@@k:=#k%#kfkf##f#kkffkkk%kf##%f#ffkk%%#kfkf##f#kkffkkk%#kkffkkk
	kk@%fkf#%%ffffk@f##f@f%%kk@kkff#%k%f@f#kfk##f@kkk%k@k#fkk@f#kkk#:=#k%ffff@k@k%fk%#kfkf##f#kkffkkk%%f@f#kfk##f@kkk%#f%k#@fkkf#%#kkffkkk
	#k%f@fkk@%@k%ffffk@f##f@f%k%ffffk@f##f@f%%ffffk@f##f@f%ff#fk@:=#%ffff@k@k%kfk%#kfkf##f#kkffkkk%##%#kfkf##f#kkffkkk%#kkffkkk
	k%kk#ff#%@f%f@f#kfk##f@kkk%fkk%fk#ff@kkfkfk@k#f%%k@f@#f@k%fk%#kfkf##f#kkffkkk%k@fff@fk#k@:=#%k@#kk@f@%k%#kfkf##f#kkffkkk%%k@f@#f@k%%ffffk@f##f@f%%#kfkf##f#kkffkkk%##f#kkffkkk
	#f%kkkk#k%kk%f@f#kfk##f@kkk%kk%fk#ff@kkfkfk@k#f%@ff@fkf#kk#f#f@f:=#%ffffk@f##f@f%fk%f@#f@k@k%f#%f@f#kfk##f@kkk%f#kkffkkk
	kkf%@kk#%#f%fk@fk#fk%@#k%#kfkf##f#kkffkkk%#kk%fk#ff@kkfkfk@k#f%f@%ffffk@f##f@f%fkff:=#%@f#kk@fk%%ffffk@f##f@f%f%ffffk@f##f@f%%#kfkffk@%f##f#kkffkkk
	k%kkkff@k#%@%ffffk@f##f@f%%ffffk@f##f@f%f%f@@kkk#k%f%#kfkf##f#kkffkkk%fkkf@k@:=#%ffffk@f##f@f%%@k#fff%fkf%f@f#kfk##f@kkk%#f#kkffkkk
	@f%#kfkf##f#kkffkkk%@k%ffk##kk#%@@k%fk#ff@kkfkfk@k#f%k#k@kfk#f#k:=#kf%fk#k%k%#kfkf##f#kkffkkk%#%f@f#kfk##f@kkk%%#kfkf##f#kkffkkk%#kkffkkk
;TRIPLE MESS FRAGMENTS FOR: k
	f%#kfkf##f#kkffkkk%%#f#k@k%%#kf@#k%k%ffffk@f##f@f%@k@k@f@f#f:=ff%@ffk%f%#kfkf##f#kkffkkk%%ffffk@f##f@f%@%fkkfff%f##f@f
	kk%kfffkf%@fk%f@f#kfk##f@kkk%@f%ffffk@f##f@f%#ff%f@f#kfk##f@kkk%kff@kffk#:=ff%#kfkf##f#kkffkkk%%kffkf#%f%ffffk@f##f@f%@%k@@kk##f%f##f@f
	f%f#kk#fk@%%ffffk@f##f@f%k%#kfkf##f#kkffkkk%fk%fk@f%#fkff#@fff:=ff%kffkf#%f%#kfkf##f#kkffkkk%k@%#kfkf##f#kkffkkk%#%f@f#kfk##f@kkk%f@f
	k#%k@kk%%kk#fff%k%ffffk@f##f@f%fk%f@f#kfk##f@kkk%fk%#kfkf##f#kkffkkk%f@f@@k:=ff%#kk#k@fk%ffk%fk#ff@kkfkfk@k#f%f%f@f#kfk##f@kkk%#f@f
	f%f@f#kfk##f@kkk%%fkf#%#k#%ffffk@f##f@f%%ffffk@f##f@f%%kk#fk#ff%kk@ffk#k#f@@k@k:=ff%@kkk#kfk%f%#kfkf##f#kkffkkk%k%fk#ff@kkfkfk@k#f%f%f@f#kfk##f@kkk%#f@f
	k%f@ff@f%@%#kfkf##f#kkffkkk%%ffffk@f##f@f%f%kf@kffk#%#kffk@k@f#k:=ff%#kfkf##f#kkffkkk%f%f@@kkk#k%%@k@fffkf%k%fk#ff@kkfkfk@k#f%f##f@f
	ff%ffffk@f##f@f%#%#kfkf##f#kkffkkk%kfkk@%kfffkf%@fk#kkf@@f#f:=ff%#kfkf##f#kkffkkk%fk%f#ffkk%@f%f@f#kfk##f@kkk%#f%fk#ff@kkfkfk@k#f%f
	#k%@kfkk#f#%@fk@f#k%f@f#kfk##f@kkk%k@#kkf%fk#ff@kkfkfk@k#f%fk@@fkk:=fff%f#fk#f%fk@%#kfkf##f#kkffkkk%##%#kfkf##f#kkffkkk%@f
	k%f@f#kfk##f@kkk%f%f#k#k@@f%#k#%f@f#kfk##f@kkk%k@%ffffk@f##f@f%#fkkk@ffff:=ff%k#@fkkf#%ff%ffffk@f##f@f%%fk#ff@kkfkfk@k#f%f#%f@f#kfk##f@kkk%f@f
	kf@f%k#@k%fk%#kfkf##f#kkffkkk%%ffffk@f##f@f%@ffff#fk:=f%#kfkf##f#kkffkkk%%f@#f@k@k%%#kfkf##f#kkffkkk%%@f#kk@@k%f%ffffk@f##f@f%@f##f@f
	k%k@@kk##f%%f@f#kfk##f@kkk%k#kf%@kf@fk%#ffk%f@f#kfk##f@kkk%kkff#@kkff@:=ff%#kfkf##f#kkffkkk%fk%kfk#kk%@%#kfkf##f#kkffkkk%##f@f
	kfk@%f@f#kfk##f@kkk%k@k%kfffkf%f@kf%ffffk@f##f@f%fff#kfk:=ff%#kfkf##f#kkffkkk%fk%fk@fk#fk%@f%f@f#kfk##f@kkk%#%#kfkf##f#kkffkkk%@f
	k%#fkkk#f#%k%f@f#kfk##f@kkk%fk@%#kfkf##f#kkffkkk%kf%#kfkf##f#kkffkkk%@f@ffffkk@#f:=f%#kfkf##f#kkffkkk%f%kf#ffk%%f#kkff%f%ffffk@f##f@f%%fk#ff@kkfkfk@k#f%f##f@f
	k%#kfkf##f#kkffkkk%%#kfkf##f#kkffkkk%fk%kkffkff#%#@fkkkk#f:=f%ffk##k%f%#kfkf##f#kkffkkk%fk%fk#ff@kkfkfk@k#f%%#kfkf##f#kkffkkk%##f@f
	kk#f%kfffkf%#k%ffffk@f##f@f%k@kf%f@f#kfk##f@kkk%fk%ffffk@f##f@f%kffkkkfk@:=fff%#kfkf##f#kkffkkk%k@f%f#ffkk%##f%fk#ff@kkfkfk@k#f%f
	k#%f@f#kfk##f@kkk%fk%#kf#kkk#%k%ffkf#k@k%k%f@f#kfk##f@kkk%k%fk#ff@kkfkfk@k#f%fkfkffff:=f%#fk#%f%#kfkf##f#kkffkkk%f%ffffk@f##f@f%%fk#ff@kkfkfk@k#f%f##f@f
	k@k@%f#k#k@@f%kkk%ffffk@f##f@f%k#f@%#kfkf##f#kkffkkk%kf#k#%fk#ff@kkfkfk@k#f%k#k@k:=f%ffff%f%#kfkf##f#kkffkkk%fk%fk#ff@kkfkfk@k#f%f#%f@f#kfk##f@kkk%f@f
	f#%@kk#%@k@%#kfkf##f#kkffkkk%%fk#ff@kkfkfk@k#f%ff%fk@fk#fk%#@%ffffk@f##f@f%fkfk@k#kkk:=f%#kfkf##f#kkffkkk%ff%f@ff#f%%ffffk@f##f@f%@f%kkk@#f%##f@f
	ff@%#kfkffk@%fk@%kffkf#%@k%ffffk@f##f@f%#f%ffffk@f##f@f%f#kk#k:=f%#kfkf##f#kkffkkk%ff%ffffk@f##f@f%%fk#ff@kkfkfk@k#f%f#%k#f#k#%#f@f
	#k@f@%#kfkf##f#kkffkkk%f%fk#k%@#k%ffk##k%%#kfkf##f#kkffkkk%@fk@ffkk@ff#k:=f%#kfkf##f#kkffkkk%%fk@f%%#kfkf##f#kkffkkk%%#f#k@k%%#kfkf##f#kkffkkk%k@f##f@f
;TRIPLE MESS FRAGMENTS FOR: @
	kff%k@f#k@f#%%kkffkff#%@%f@f#kfk##f@kkk%k@%#kfkf##f#kkffkkk%@kk@@k#k#k:=fk%f@f#kfk##f@kkk%ff%@f#kk@@k%%fk#ff@kkfkfk@k#f%k%ffffk@f##f@f%fkfk@k#f
	#k@%kf#ffk%kk%fk#ff@kkfkfk@k#f%#%ffffk@f##f@f%#kkk#f:=f%ffffk@f##f@f%#%#kfkf##f#kkffkkk%%@f@ff#f@%%#kfkf##f#kkffkkk%%f@ff@f%@kkfkfk@k#f
	k%#kfkf##f#kkffkkk%%ffffk@f##f@f%#@f%f#kkff%kf%ffffk@f##f@f%f#k#kkk#f#k:=f%ffffk@f##f@f%%f@f#kfk##f@kkk%ff%kk@kkff#%@kk%#kfkf##f#kkffkkk%kfk@k#f
	@ff%#kf#kkk#%#%#kfkf##f#kkffkkk%%f@f#kfk##f@kkk%kk%@kk@f#k#%#k#%ffffk@f##f@f%k#fkk@fkkk:=f%@kfkk#f#%k#%#kfkf##f#kkffkkk%f@%#fkkk#f#%%ffffk@f##f@f%k%#kfkf##f#kkffkkk%kfk@k#f
	@%#kfkf##f#kkffkkk%k%kfk##k%@%#kfkf##f#kkffkkk%%ffffk@f##f@f%f#k@f##kf@:=fk%k@f##k#k%%f@f#kfk##f@kkk%f%#kfkf##f#kkffkkk%@k%ffffk@f##f@f%fkfk@k#f
	#f#%ffff%ff@%ffffk@f##f@f%#%ffffk@f##f@f%%f@f#kfk##f@kkk%#kkfkff#ff:=fk%f@f#kfk##f@kkk%ff@%f@#f@k@k%k%@f@ff#f@%%ffffk@f##f@f%fkfk@k#f
	f%f@f#kfk##f@kkk%kk%fk#ff@kkfkfk@k#f%kffk%f##fk#%k%kf#ffk%fff@k#f@f@:=fk%f@f#kfk##f@kkk%%#kfkf##f#kkffkkk%f%f@ff@f%%fkf#%@%ffffk@f##f@f%kfkfk@k#f
	#ff%k#@k%k%f@f#kfk##f@kkk%kk#%ffffk@f##f@f%@k#f@:=fk%f@f#kfk##f@kkk%%#kfkf##f#kkffkkk%f%#kf#kkk#%@kkfkfk@k#f
	kkk%#kfkf@@f%#%k#f#k#%%#kfkf##f#kkffkkk%k%#kfkf##f#kkffkkk%f#fkk#kk##k@fkkkk:=fk%f@f#kfk##f@kkk%f%@fkfkk%f@%ffffk@f##f@f%%ffffk@f##f@f%f%@k@f%kfk@k#f
	f##%#kf@#k%k#f@%ffffk@f##f@f%k#k@%f@f#kfk##f@kkk%fff%fk#ff@kkfkfk@k#f%fk#fkff:=f%kk#ff#%k#f%#kfkf##f#kkffkkk%@kkf%ffffk@f##f@f%fk@k#f
	k@k%kf@kffk#%#@%ffffk@f##f@f%kkffk%f@f#kfk##f@kkk%fkkk@f@k:=fk%f@f#kfk##f@kkk%%#kfkf##f#kkffkkk%f%fk#ff@kkfkfk@k#f%kk%kk#ff#%%kkf#fk%fkfk@k#f
	k#k@%#kfkf##f#kkffkkk%#%ffffk@f##f@f%ffff%f@ff#f%kk#%k#@k%@k@f#fkf:=fk#%kkkk#k%ff@%ffffk@f##f@f%kf%ffffk@f##f@f%fk@%ffffk@f##f@f%#f
	@%ffffk@f##f@f%k@fff%#kfkf##f#kkffkkk%f%@kkk#kfk%ff%@ffk%f#kkkf#kf#fff:=fk#%fkf@ff%ff%fk#ff@kkfkfk@k#f%%ffffk@f##f@f%kfk%#fk#%fk@k#f
	@%k#@k%f%fk#ff@kkfkfk@k#f%ffk%#kfkf##f#kkffkkk%fff%fk#ff@kkfkfk@k#f%fkf@f:=fk#f%ffk##k%f%fk#ff@kkfkfk@k#f%%ffffk@f##f@f%kfkfk@k#f
	kf@%#kfkf##f#kkffkkk%k%ffffk@f##f@f%kfk%#ffk@kfk%#%fk#ff@kkfkfk@k#f%kfkkk:=fk#%#kfkf##f#kkffkkk%f@%ffffk@f##f@f%%f@ff#f%kfk%k#@fkkf#%fk@k#f
	k%kk#ff#%ffk%#kfkf##f#kkffkkk%%#kfkf##f#kkffkkk%k@@k%ffffk@f##f@f%#f#ff#ffkf@:=fk%@k@fff%#f%#kfkf##f#kkffkkk%@%f@f##fkk%k%ffffk@f##f@f%%#kfkf##f#kkffkkk%kfk@k#f
	#%@f#kk@fk%%f#fkk@%fk@%ffffk@f##f@f%%f@f#kfk##f@kkk%f@kkf#k#kf:=fk%kkf#fk%#f%#kfkf##f#kkffkkk%@kkf%ffffk@f##f@f%fk@k#f
	k@#k%ffffk@f##f@f%%fk#ff@kkfkfk@k#f%k@f%k@@kk##f%##%kk#ff#%fkff#@fk#:=f%ffffk@f##f@f%#f%#kfkf##f#kkffkkk%%k#f#k#%@kkfkfk@k#f
	f%@kkk#kfk%%fk#ff@kkfkfk@k#f%%fk#ff@kkfkfk@k#f%%#kfkf##f#kkffkkk%%f#kkff%f#k##f#f@k:=fk%@kkkfk%#f%#kfkf##f#kkffkkk%%fk#ff@kkfkfk@k#f%kk%#kfkf##f#kkffkkk%k%fk#fff@k%fk@k#f
	@%#kfkf##f#kkffkkk%#%#f@k#kk#%ffk%ffffk@f##f@f%%fk#ff@kkfkfk@k#f%f#fkkf#f:=f%ffffk@f##f@f%#%kfk##k%%#kfkf##f#kkffkkk%f@%ffffk@f##f@f%k%f#fkk@%fkfk@k#f
;TRIPLE MESS FRAGMENTS FOR: #
	#k%f@f#kfk##f@kkk%%#kf@#k%%#kfkf##f#kkffkkk%#k@%#kfkf##f#kkffkkk%f#k#f##f:=f%f@ff@f%@%#kfkf##f#kkffkkk%#%ffffk@f##f@f%%#kfkf##f#kkffkkk%k##f@kkk
	kk%#kfkf##f#kkffkkk%kfk%@kk#%#%ffffk@f##f@f%%ffffk@f##f@f%f#kf#k@fk@f:=f%fk#ff#@k%@%#kfkf##f#kkffkkk%%f@f#kfk##f@kkk%kf%f#fkk@%k##f@kkk
	k%#kfkf##f#kkffkkk%%k#@k%%#kfkf##f#kkffkkk%%#kfkf##f#kkffkkk%@kfk#kk#kf:=f%fk#ff@kkfkfk@k#f%f%f@f#kfk##f@kkk%k%f@f##fkk%fk%f@f#kfk##f@kkk%#f@kkk
	kf%fk#ff@kkfkfk@k#f%fk@#k%f#ffkk%#kk%f@f#kfk##f@kkk%#ff#@f@k:=f@f%@f@ff#f@%#%ffffk@f##f@f%f%ffffk@f##f@f%##f@kkk
	@f%fkf##f@k%#k%f@f#kfk##f@kkk%k%k@f@#f@k%%ffffk@f##f@f%f@%#kfkf##f#kkffkkk%@ff@#f@kkfk@:=f%f#k#k@@f%%kkkff@k#%%fk#ff@kkfkfk@k#f%f%f@f#kfk##f@kkk%k%#kfkf##f#kkffkkk%k##f@kkk
	k%f@f#kfk##f@kkk%k#%f#kk#fk@%kk%fkf#%ff%ffffk@f##f@f%k%f@f#kfk##f@kkk%kkkf#k@f#k@f#:=f@%kfk#kk%f#%ffffk@f##f@f%f%ffffk@f##f@f%%#kk#k@fk%##f@kkk
	#%@k@f%%ffffk@f##f@f%%#kfkf##f#kkffkkk%fkk%ffffk@f##f@f%@fff@@k@k:=f@%#kfkf##f#kkffkkk%#%ffffk@f##f@f%%@k@fffkf%f%ffffk@f##f@f%##f@kkk
	f#%@kk@f#k#%%ffffk@f##f@f%%fk#ff@kkfkfk@k#f%@ffk@f@k@f#f#f:=f@%#kfkf##f#kkffkkk%#k%#kfkf##f#kkffkkk%k#%#fkkk#f#%#f@kkk
	@%@k@fffkf%fk%#kfkf##f#kkffkkk%%f@fkk@%%fk#ff@kkfkfk@k#f%%ffffk@f##f@f%k#f@k@f#fff#f#f#f#:=f@%k@k#k#%%#fk#f@fk%%#kfkf##f#kkffkkk%%f@f#kfk##f@kkk%kfk##f@kkk
	f#%#kfkf##f#kkffkkk%fk#@%ffffk@f##f@f%#f%kkkk#k%kk@kf@:=f%k@#kk@f@%@%#kfkf##f#kkffkkk%#k%#kfkf##f#kkffkkk%k#%f@f#kfk##f@kkk%f@kkk
	kf%#kfkf##f#kkffkkk%@%#kk#k@fk%@%ffffk@f##f@f%@kf##kk##f:=f%f##kf@%%fk#ff@kkfkfk@k#f%f%f@f#kfk##f@kkk%%ffffk@f##f@f%fk##f@kkk
	k%#f#k@k%ff%#kfkf##f#kkffkkk%%#kfkf##f#kkffkkk%@%#kfkf##f#kkffkkk%f#kk@f#:=f@f%f@f#kfk##f@kkk%k%ff@kk@@k%fk%f@f#kfk##f@kkk%#f@kkk
	#%fkkfff%fk%ffffk@f##f@f%k#%#kfkf##f#kkffkkk%k%ffffk@f##f@f%@kkk#k@:=f%fk#ff@kkfkfk@k#f%f%kfkk#fff%#%ff@kk@@k%kf%ffffk@f##f@f%##f@kkk
	#%ffffk@f##f@f%k%fk#ff@kkfkfk@k#f%k#%fk#ff@kkfkfk@k#f%k%kk#fff%f#k%kk@kkff#%kf#fkkkkff#fk:=f%kk#ff#%@%#kfkf##f#kkffkkk%#%f#k#k@@f%%ffffk@f##f@f%f%ffffk@f##f@f%##f@kkk
	k#%#kfkf##f#kkffkkk%%kk@kkff#%%fk#ff@kkfkfk@k#f%f%fk#ff@kkfkfk@k#f%kkff@f@kk#ff:=f%fkf@ff%@f%ffkf#k@k%%f@f#kfk##f@kkk%k%#kfkf##f#kkffkkk%k##f@kkk
	fk%ffffk@f##f@f%@%f##fk#%%k@@kk##f%%#kfkf##f#kkffkkk%#f%ffffk@f##f@f%fk#kkkkffk:=f%fk#ff@kkfkfk@k#f%%#kfkf##f#kkffkkk%#%k@f#k@f#%k%#kfkf##f#kkffkkk%k%@k@fffkf%##f@kkk
	f#%ffffk@f##f@f%fk@%#ffk@kfk%f%fk@fk#fk%ff#%fk#ff@kkfkfk@k#f%kkk%ffffk@f##f@f%kf@kk#fk#:=f@%k@k#k#%f#%ffffk@f##f@f%f%ffffk@f##f@f%##%#kfkf##f#kkffkkk%@kkk
	@%fkf#f@%%ffffk@f##f@f%ff@%ffffk@f##f@f%f@k@%#kfkf##f#kkffkkk%fkf@k@kkkffkk:=f@f%f@f#kfk##f@kkk%%ffffk@f##f@f%%kkffkff#%fk##f@kkk
	k@ffk#%#kfkf##f#kkffkkk%%f@f#kfk##f@kkk%@%@kk#%ffk@ffff@kf#fff:=f%fk#ff@kkfkfk@k#f%%k#k@k#%f#%ffffk@f##f@f%%kfkk#fff%fk##f@kkk
	@ff%#kfkf##f#kkffkkk%%#f@k#kk#%k#%@kkkfk%@%ffffk@f##f@f%#kk@#kkk:=f@f%fkf##f@k%#%ffffk@f##f@f%%#kfkf##f#kkffkkk%k##f@kkk

} 

;$OBFUSCATOR: $FUNCS_RESTORE_DEFAULTS: 

;$OBFUSCATOR: $FUNCS_CHANGE_DEFAULTS: ,, -1 
;FUNCTION ORIGINAL NAME: obf_dumpunclassed
f@k#ffff@fkk@f() {  
global 
;OBF_FUNC name: testfunction
	f@%@f#kk@@k%#%#k@kkkkkff#fk@%f%ffkfk@f@k@@fkkffk@%f%f@#kf@kfkfffkkfk%f#kf@fk@=k#k%@f@ffkffff@fkf@f%f#%f@#kf@kfkfffkkfk%%@k@f%kf#@kff#k
	#f%fkf#%kff%k#k@f#kffffkk#@k@f#fkf%fk%@ff#f#kk#k#kk#fkk@fkkk%fffkk=k#k@%@fk@fkf@kkfkkff#kkkkffk@%#%k@kkffffkkf@k@%%kk@kkff#%kf#@kff#k
;OBF_FUNC name: obf_dumpcommonobjfrags
;OBF_FUNC name: obf_dumpunclassed
;OBF_FUNC name: obf_dumpunsecclasses
;OBF_FUNC name: obf_dumpall
	f%f#kfk@fff#@kkkkkf@kk#fk#%%@kf##f#fff#kf#k@f@%#%f@fkk@%k%@kf##f#fff#kf#k@f@%f#kfk@#f=#f%k@kk%fk%f@kf@f#f%@f%kfffk#@fkkkk#f%%#fk@k#f@kkf#k#kf%%f#@k@f@ff#@kfkfk@k#kkk%##f#kkk
	#k%fk@f%%k@ffk#f#@ffk@ffff@kf#fff%kkk%f##k#kkkk@ffk#k#f@@k@k%#f%kffff@ff#kk@f#%fff#f@=#%@kf##f#fff#kf#k@f@%f%@f#kk@fk%%fkkffk#fkff#@fff%@f%@ffk%k@%k@fkf#kffk@k@f#k%##f#kkk


} 


;FUNCTION ORIGINAL NAME: obf_dumpunsecclasses
f@@k@kkfkf#fff() {  
global 


} 

;$OBFUSCATOR: $FUNCS_RESTORE_DEFAULTS: 

;FUNCTION ORIGINAL NAME: obf_dumpall
#ffk@fk@k##f#kkk() {  
global 
;$OBFUSCATOR: $ALLFRAGS_DUMPALL: 


;OBF_GLOBVAR name: globalvar1
	f%@k@fffkf%f%@f#kk@fk%%@fffk#@k#kk@#kkk%%#kfk#kk#@kk#@ff@#ff#kk#k%@f@f=k%#k@kk@#k#kkk#f%%kkkff@k#%%@ff@k@@k@k#k@kfk#f#k%%#f#k@k%%k@fkf#kffk@k@f#k%@kf@
	#%@kk#%k%ffkk@k@k@f@f#f%%f##ff#fkk#ffffffff#kfkfk%%kk#f#kkk@kf#fkkkffkkkfk@%@k@=k%k@f##k#k%%k@#kk@k@f##fkff#@fk#%%#kfk@kf@f@k#k#@f%k@kf@
;OBF_GLOBVAR name: globalvar2
	%f#@k@f@ff#@kfkfk@k#kkk%%kfk#kk%%fk@k@f%%kf@ffkfk@ffff#fk%%kkfkfk#kkf#kf#k@fk@f%kfffk=f%#k@f@ff@#kf@fk@ffkk@ff#k%%@k@f%f%f@#kf@kfkfffkkfk%k#kf
	k%kk@kkff#%%#fkkk#fkk@kkk#k@%k%kffff@ff#kk@f#%#%k@f#k@f#%%f@#kf@kfkfffkkfk%#fkk#f=f%kf@ffkfk@ffff#fk%%k@kkffffkkf@k@%%f##kf@%%#f#k@k%%f#k@@fkkk@@fk@@f%k#kf

;PARAMETERS for function  named: testfunction
;OBF_FUNC_1_PARAM name: paramvar
	@%f@kf@f#f%kfk%@kff@kf@k@ffkf@k@kkkffkk%%kk@fk#@fk#ff#kff@kffk#%%@ff@k@@k@k#k@kfk#f#k%%@f#kk@fk%f#fkkf#@ff#k#f#kk=f@f%kkf#f@#kf#kk@f@kfkff%f#f%#ffk#kk#k@k#f@%#f#%f#fkk@%fkf
	#f%kffkkf@fkf@k#k#f#f#f%@#%kkf#f@#kf#kk@f@kfkff%ff%kfk#kk%%ffkk@k@k@f@f#f%%k@kf@k%kfffk@kf#f#kfkf#f=f%fkkfff%@%#kfk@kf@f@k#k#@f%%f#k@@fkkk@@fk@@f%%f@#kf@kfkfffkkfk%#f@#f#fkf

;LOS vars for function  named: testfunction
;OBF_FUNC_1_LOSVAR name: localvar1
	@k%@kfkk#f#%@kkk#%kk@fk#@fk#ff#kff@kffk#%%f@k#fffkf@k#kkff@fffffff%kf@k@k@k@fk@kk@fffk=@%fkf@ff%k@%#k@f@ff@#kf@fk@ffkk@ff#k%%@fkf@kk#f@k@f#fff#f#f#f#%%@kfffffkfkkff@@k%f@#f#f@kf@k@k@@k
	kk%k#k#kkffkk#kkkf#k@f#k@f#%f#f%ffk##k%fkf@k@%kfffk#@fkkkk#f%#ff#ff@@kk#=@%fkf#%%kfk@#k@kf@kfkfff#kfk%@k#%#k@kkkkkff#fk@%f@%#k#f#k@ff#k#f##f%f#f@kf@k@k@@k
;OBF_FUNC_1_LOSVAR name: localvar2
	k%k#k#kkffkk#kkkf#k@f#k@f#%kkfkkk%@kfffffkfkkff@@k%#k@f%fkf#f@%fk#%k@fkf#kffk@k@f#k%@#k@kff#ff#=kf%kkk@#f%%fkkffk#fkff#@fff%%kfk##k%k@%#kfk@kf@f@k#k#@f%kkk#ff#f
	@%kf@kffk#%k@%fk#fff@k%f@k%k@k#@kkkffk#fkkk@f@k%fkf%@ff@k@@k@k#k@kfk#f#k%@fffkk@=kf%@f#kk@@k%kk%#kfkf@@f%%#fk@k#f@kkf#k#kf%%@fk@fkf@kkfkkff#kkkkffk@%kkk#ff#f




}

