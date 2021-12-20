obf_copyright := " Date: 09:43 mardi 11 juillet 2017              "
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
#SingleInstance

;Since the obfuscator is set to do Dynamic obfuscation by default,
;leaving off obfuscator CHANGE_DEFAULTS statements at the beginning
;of your program will set the obfuscator to do dynamic obfuscation
  
;put a string assignment header like this in your program so that
;the program name and copyright info still shows up in the obfuscated ;version of this program
program_name:="obfclasses.ahk"
program_name:="Author: MY NAME"
program_name:="Copyright MY NAME, YEAR"

;these are the minimum DUMP statements you need to use when using
;dynamic obfuscation. none of these would be required
;for 'straight' obfuscation
;ALL FUNCTIONS MUST BE MADE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!

;security fragments and triple mess fragments for common objects
;must be dumped before anything else
	;SECURITY CLASS FRAG: for class: COMMON for char: f
	f%k#f@f@f@%k%f@ffk#%f%k#fff@kf%k%k#kffk%k#k#f@fkf@ffk#=%fkk#%f%f@f@fkfk%
	;SECURITY CLASS FRAG: for class: COMMON for char: k
	k#f%f@kfk#%%fkkf%fffff%fkfkk#f@%%kfkfff%kffkfkfffkkfk#=%ffkff@%k%fkf@kf%
	;SECURITY CLASS FRAG: for class: COMMON for char: @
	k#ff%f@ffffk#%k#fkf%k#ffk#%fffkfk%ffkff@%#fkkfk#=%ffk#f@%@%fffkkfkf%
	;SECURITY CLASS FRAG: for class: COMMON for char: #
	k#%k#fkk#k#%fff@k%kff@%#fk%fkfkfffk%kfk#f%fkf@kfkf%@kff@k#=%k#kff@fk%#%k#k#fk%

;TRIPLE MESS FRAGMENTS FOR: f
	f%k#ffffffkffkfkfffkkfk#%k#f%fkk#%k%fkfkk#k#f@fkf@ffk#%kf%k#ffffffkffkfkfffkkfk#%fff@fkff:=f%k#ffffffkffkfkfffkkfk#%fk%fkkf%k#%k#ffffffkffkfkfffkkfk#%#f%k#ffk#fkffffkfk#fkkfk#%fkf@ffk#
	%fkfkk#k#f@fkf@ffk#%@%k#f@fkff%k#k#%fkfkk#k#f@fkf@ffk#%@%fkfkk#k#f@fkf@ffk#%kfkfkfffk:=fk%k#f@%fkk%k#fff@k#fkkfk#f@kff@k#%k#%fkfkk#k#f@fkf@ffk#%@fk%fkfkk#k#f@fkf@ffk#%@ffk#
	f%fkfkf@%%k#ffk#fkffffkfk#fkkfk#%fff@k%fkfkk#k#f@fkf@ffk#%f@f@f%k#ffffffkffkfkfffkkfk#%k#kff@f@:=fkfk%k#ffffffkffkfkfffkkfk#%#%k#ffffffkffkfkfffkkfk#%%fffffff@%#f@f%k#k#fkff%kf@ffk#
	%fffkkfkf%ff%k#ffffffkffkfkfffkkfk#%%f@ffffk#%#ffkf%k#ffffffkffkfkfffkkfk#%ffkf@f@fff@kf:=%kfffk#k#%%fkkf%f%k#ffffffkffkfkfffkkfk#%%fkfkk#k#f@fkf@ffk#%kk%k#fff@k#fkkfk#f@kff@k#%k#f@fkf@ffk#
	fkk%kfk#k#%#f%fkfkk#k#f@fkf@ffk#%kff%k#ffk#fkffffkfk#fkkfk#%fkf%k#ffk#fkffffkfk#fkkfk#%:=fkfkk#%ffffff%k#%fkfkk#k#f@fkf@ffk#%@%fkfkk#k#f@fkf@ffk#%kf@ffk#
	kff@%ffk#f@%fkfff%fkfkk#k#f@fkf@ffk#%k%fkfkk#k#f@fkf@ffk#%kfk#:=f%k#ffffffkffkfkfffkkfk#%fkk%ffk#k#%#k%fkk#kf%%k#fff@k#fkkfk#f@kff@k#%f@%fkfkk#k#f@fkf@ffk#%kf@ffk#
	%kfkfkffk%k%ffkf%#%fkfkk#k#f@fkf@ffk#%%k#ffk#fkffffkfk#fkkfk#%k%fkfkk#k#f@fkf@ffk#%fkkfk#kf:=%kff@%fkf%k#ffffffkffkfkfffkkfk#%k%k#fff@k#fkkfk#f@kff@k#%k%k#fff@k#fkkfk#f@kff@k#%f@fkf@ffk#
	k#%fkfkkf%fkkffk%fkfkk#k#f@fkf@ffk#%kk#f@%fkfkk#k#f@fkf@ffk#%kkfkfffk#:=fkf%kff@%k%k#ffffffkffkfkfffkkfk#%%k#fff@k#fkkfk#f@kff@k#%k#f%k#ffk#fkffffkfk#fkkfk#%fkf@ffk#
	kfkf%fkfkk#k#f@fkf@ffk#%k%k#ffffffkffkfkfffkkfk#%%fkf@kfkf%#f@%f@ffkf%fff@fkkf:=f%k#ffffffkffkfkfffkkfk#%fkk#%k#ffffffkffkfkfffkkfk#%#f@f%fkk#%k%k#k#fkff%f@ffk#
	k#kf%f@f@ff%fk%k#ffffffkffkfkfffkkfk#%#f%k#ffffffkffkfkfffkkfk#%fkf@:=%ffk#%f%k#ffffffkffkfkfffkkfk#%fkk%k#fff@k#fkkfk#f@kff@k#%k%k#fff@k#fkkfk#f@kff@k#%f%fkkf%@fkf@ffk#
	fk%fkfkk#k#f@fkf@ffk#%%kfk#ff%fff%fkfkk#k#f@fkf@ffk#%@k#f@ffkf:=%fkk#f@%f%fkkffkkf%kfkk%k#fff@k#fkkfk#f@kff@k#%%k#ffffffkffkfkfffkkfk#%#f@fkf@ffk#
	f@f%f@kfk#%kfkk#%fkkffkkf%kff%k#ffk#fkffffkfk#fkkfk#%%fkfkk#k#f@fkf@ffk#%kf@f@kf:=fk%fkfkff%f%k#ffffffkffkfkfffkkfk#%k%fkf@fff@%#k#%fkfkk#k#f@fkf@ffk#%@%fkfkk#k#f@fkf@ffk#%kf@ffk#
	fk%fkfkk#k#f@fkf@ffk#%ff%k#f@f@f@%f%fkfkk#k#f@fkf@ffk#%f%k#kfk#%fkk#kfff:=fk%fffffff@%fkk%k#fff@k#fkkfk#f@kff@k#%k#%fkfkk#k#f@fkf@ffk#%@fkf@ffk#
	%f@fkfkf@%%kfk#k#%k#%k#ffffffkffkfkfffkkfk#%#%k#ffffffkffkfkfffkkfk#%fff%k#ffffffkffkfkfffkkfk#%fk#fffk:=fkfk%fffffff@%%k#ffffffkffkfkfffkkfk#%#k#%fkfkk#k#f@fkf@ffk#%@fk%k#fkk#k#%f@ffk#
	%fkfkk#k#f@fkf@ffk#%k%k#ffffffkffkfkfffkkfk#%#ff%fff@%kfff%fkk#%fk%fkfkk#k#f@fkf@ffk#%ffkkffkk#k#:=fkf%k#ffffffkffkfkfffkkfk#%k#%ffffff%k%k#fff@k#fkkfk#f@kff@k#%f@f%k#fff@kf%kf@ffk#
	k#k%kfk#%ff@%f@fkfkf@%%k#ffffffkffkfkfffkkfk#%ffk%k#ffffffkffkfkfffkkfk#%%k#fff@k#fkkfk#f@kff@k#%fkk#f@:=fk%fkfkk#k#f@fkf@ffk#%kk#%k#fkk#k#%%fkf@k#%k#f@%fkfkk#k#f@fkf@ffk#%kf@ffk#
	fkf@%k#ffffffkffkfkfffkkfk#%#kffk%k#fk%k#fkff%fkfkk#k#f@fkf@ffk#%k:=fkf%fkf@k#%kk#k%fkf@%#f@f%k#ffffffkffkfkfffkkfk#%f@f%fkfkk#k#f@fkf@ffk#%k#
	kff%k#ffk#fkffffkfk#fkkfk#%%fkfkk#k#f@fkf@ffk#%kk#%ffkff@%fkf@f%k#ffffffkffkfkfffkkfk#%fffkkfk#ff:=%fkfkk#k#f@fkf@ffk#%kf%k#ffffffkffkfkfffkkfk#%k#k#%kfk#k#%f@f%fkf@kfkf%kf@ffk#
	k#f%k#ffffffkffkfkfffkkfk#%k%k#kffk%#f%k#f@fkk#%kk#f%fkfkk#k#f@fkf@ffk#%f@k%k#fff@k#fkkfk#f@kff@k#%fffffkf@:=fkf%k#ffffffkffkfkfffkkfk#%%k#ffffffkffkfkfffkkfk#%#k#%k#ffkf%f%k#k#fk%@fkf@ffk#
	%fkfkk#k#f@fkf@ffk#%fk%fff@fffk%fk%fkfkk#k#f@fkf@ffk#%ff%fffkk#%k%fkfkk#k#f@fkf@ffk#%fkk#fkff:=f%kfkfff%%k#ffffffkffkfkfffkkfk#%%f@ffk#%f%k#ffffffkffkfkfffkkfk#%k%k#fff@k#fkkfk#f@kff@k#%k#f@fkf@ffk#
;TRIPLE MESS FRAGMENTS FOR: k
	k#k#%fkfkk#k#f@fkf@ffk#%k%fkfkk#k#f@fkf@ffk#%@%k#ffffffkffkfkfffkkfk#%fk#f%kfk#%@f@f@kfk#:=k%k#fff@k#fkkfk#f@kff@k#%ffff%k#kffff@%ffk%fkfkk#k#f@fkf@ffk#%fkfkfffkkfk#
	f@f@f%k#ffk#fkffffkfk#fkkfk#%ffkff%f@fkf@%ffffkk%fkfkk#k#f@fkf@ffk#%ff:=%f@fkfffk%k#ff%fkfkk#k#f@fkf@ffk#%f%fkfkk#k#f@fkf@ffk#%f%k#ffffffkffkfkfffkkfk#%ffkfkfffkkfk#
	fff@%fkfkk#k#f@fkf@ffk#%@k%fkfkk#k#f@fkf@ffk#%f%fkk#%kff%k#ffkf%fkfk:=k#fff%fkfkk#k#f@fkf@ffk#%ffk%fkfkk#k#f@fkf@ffk#%fkf%k#ffffffkffkfkfffkkfk#%fff%f@kfk#%kkfk#
	fk%k#ffffffkffkfkfffkkfk#%fk#k#%fkf@%k%fkfkk#k#f@fkf@ffk#%k#k#ff:=k#fff%k#f@fkff%fff%k#ffffffkffkfkfffkkfk#%ffkf%fffk%kf%fkfkk#k#f@fkf@ffk#%fkkfk#
	fkf%k#ffffffkffkfkfffkkfk#%k#%f@k#k#%k#k%fkfkk#k#f@fkf@ffk#%f@kf:=k#fff%kfkff@%fffk%fkfkk#k#f@fkf@ffk#%fkfkff%fkfkk#k#f@fkf@ffk#%kkfk#
	k#k%k#fff@k#fkkfk#f@kff@k#%ff%fkfkk#k#f@fkf@ffk#%ff%fkf@kf%@ffk%f@ffkf%#kf:=k#f%fkk#ff%fffffkf%fkfkk#k#f@fkf@ffk#%%k#ffffffkffkfkfffkkfk#%fkfffkkfk#
	kff%k#ffffffkffkfkfffkkfk#%ffff%fkfkk#k#f@fkf@ffk#%@f%fkkffkkf%@fkk%k#kfff%fff:=k#ff%k#k#%f%k#f@fkff%%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%kffkfkfffkkfk#
	fkff%k#ffffffkffkfkfffkkfk#%#ffk%ffffff%#k%k#fff@k#fkkfk#f@kff@k#%f@f@:=k#f%fffkk#%ffff%fkfkfffk%f%k#ffffffkffkfkfffkkfk#%ffk%fkfkk#k#f@fkf@ffk#%k%fkfkk#k#f@fkf@ffk#%ffkkfk#
	k#k%fkfkk#k#f@fkf@ffk#%kf%ffk#k#%f@%k#ffffffkffkfkfffkkfk#%%kff@fk%ff@f@ff:=k#ff%kfkff@%ffff%k#ffffffkffkfkfffkkfk#%ff%k#k#%kfkff%fkfkk#k#f@fkf@ffk#%kkfk#
	kfk%fkkffkff%#ff%f@ffk#%%k#ffffffkffkfkfffkkfk#%#fk%fkfkk#k#f@fkf@ffk#%kff:=k#f%ffkfkf%fffffk%fkfkk#k#f@fkf@ffk#%fk%fkfkk#k#f@fkf@ffk#%kfffkkfk#
	%fkfkk#k#f@fkf@ffk#%fk%f@fkfffk%%fkfkk#k#f@fkf@ffk#%f@k%f@fkf@%ffffffkkff@fk:=k#ff%f@ffkf%ffff%kfkff@%kffk%fkfkk#k#f@fkf@ffk#%kf%fkfkk#k#f@fkf@ffk#%fkk%fkfkk#k#f@fkf@ffk#%k#
	%fkkf%%fkfkk#k#f@fkf@ffk#%%k#ffffffkffkfkfffkkfk#%%k#ffffffkffkfkfffkkfk#%ffff@f@k#k#fkf@:=k#f%fkfkk#k#f@fkf@ffk#%ff%fffkkf%ffk%k#fkk#k#%ffkfk%fkfkk#k#f@fkf@ffk#%ffkkfk#
	k#%kfkf%k%k#fff@k#fkkfk#f@kff@k#%f%fkfkk#k#f@fkf@ffk#%ffkff@fk:=k#fff%k#ffk#%ff%fffkk#%fkf%fkfkk#k#f@fkf@ffk#%%k#ffffffkffkfkfffkkfk#%fkfffkkfk#
	kf%k#kff@f@%ffk%k#fff@k#fkkfk#f@kff@k#%fkfk%k#ffffffkffkfkfffkkfk#%fffkff@kf:=%k#ffffffkffkfkfffkkfk#%%k#fff@k#fkkfk#f@kff@k#%f%fkfff@%ffff%f@k#k#%fkff%k#ffffffkffkfkfffkkfk#%fkfffkkfk#
	%f@ff%kf%fkfkk#k#f@fkf@ffk#%f%fffffff@%%fkfkk#k#f@fkf@ffk#%@ff%k#ffffffkffkfkfffkkfk#%#f@k#k#f@:=k#f%k#k#fkff%%fkfkk#k#f@fkf@ffk#%ff%fkf@kf%%fkfkk#k#f@fkf@ffk#%fkff%k#ffffffkffkfkfffkkfk#%fkfffkkfk#
	fkk#ff%k#k#%kfk%fkfkk#k#f@fkf@ffk#%ff%fkfkk#k#f@fkf@ffk#%f%k#ffffffkffkfkfffkkfk#%#ffk#ffk#:=k#ff%fkfkk#k#f@fkf@ffk#%ff%fkfkk#k#f@fkf@ffk#%kffk%fkfkk#k#f@fkf@ffk#%kfff%fffkkfkf%kkfk#
	k%fkfkk#k#f@fkf@ffk#%f@%kffk%k%k#fff@k#fkkfk#f@kff@k#%f%k#ffk#fkffffkfk#fkkfk#%f@fffkk#:=k%fkk#kf%#f%fkfkk#k#f@fkf@ffk#%ff%fkfkkf%f%fkfkk#k#f@fkf@ffk#%kf%fkfkk#k#f@fkf@ffk#%kfkfffkkfk#
	f%f@fkf@%%k#ffk#fkffffkfk#fkkfk#%f@%k#ffffffkffkfkfffkkfk#%#%k#ffffffkffkfkfffkkfk#%fk#%f@f@k#%fff@ff:=k#f%fkfkk#k#f@fkf@ffk#%f%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%fkffk%f@fkfffk%fkfffkkfk#
	k%ffkf%ff@f%k#ffk#fkffffkfk#fkkfk#%%k#ffffffkffkfkfffkkfk#%#fkkfkffkkf:=k#ff%fkfkk#k#f@fkf@ffk#%fffkf%fkfkf@%fkfk%kfkfk#%fffkk%fkfkk#k#f@fkf@ffk#%k#
	fkk%f@f@ff%fk#%fkfkf@%f@%k#ffffffkffkfkfffkkfk#%%fkfkk#k#f@fkf@ffk#%%k#ffffffkffkfkfffkkfk#%fkfkf:=k#%k#fff@%%fkfkk#k#f@fkf@ffk#%ff%fkfkk#k#f@fkf@ffk#%ffk%fkfkk#k#f@fkf@ffk#%fkfkfffkkfk#
;TRIPLE MESS FRAGMENTS FOR: @
	ff%fkfkk#k#f@fkf@ffk#%@k%k#fff@k#fkkfk#f@kff@k#%f@%f@kf%k%k#fff@k#fkkfk#f@kff@k#%fk%kff@%fk:=k%k#ffk#%#ff%k#ffffffkffkfkfffkkfk#%#fk%fkfkk#k#f@fkf@ffk#%f%fkfkk#k#f@fkf@ffk#%fkfk#fkkfk#
	k#%k#ffffffkffkfkfffkkfk#%%k#fff@k#fkkfk#f@kff@k#%k#%k#ffffffkffkfkfffkkfk#%#k%fkkffkkf%f%k#f@fkff%f@fkk#:=k#ffk#f%k#ffffffkffkfkfffkkfk#%ff%ffkf%%fkfkk#k#f@fkf@ffk#%fkfk#fkkfk#
	ff%fffff@%k#%fkfkk#k#f@fkf@ffk#%@f%fkfkk#k#f@fkf@ffk#%kfk%k#fff@k#fkkfk#f@kff@k#%ffffkfk#:=k%fffffff@%#ffk#%k#fff@%f%k#ffffffkffkfkfffkkfk#%ffff%k#ffffffkffkfkfffkkfk#%fk#fkkfk#
	kff%fkfkk#k#f@fkf@ffk#%k#%ffkff@%ffkfk%fkfkk#k#f@fkf@ffk#%kfff:=k#f%ffkffk%fk#fkff%fkfkk#k#f@fkf@ffk#%fkfk#%fkfkk#k#f@fkf@ffk#%kkfk#
	f@%fkfkk#k#f@fkf@ffk#%k%f@kf%f%k#ffk#fkffffkfk#fkkfk#%k#%fkfkk#k#f@fkf@ffk#%kk%kffk%#fkf@kf:=%k#ffffffkffkfkfffkkfk#%#f%fkfkk#k#f@fkf@ffk#%k#fkf%k#f@%f%fkk#kf%ffkfk#fkkfk#
	kf%fkfkk#k#f@fkf@ffk#%kff%f@fkf@%f@k#%fkf@kf%k#k%k#fff@k#fkkfk#f@kff@k#%kf:=k#ff%fkf@f@%k#%f@k#k#%f%k#ffffffkffkfkfffkkfk#%%fkfkk#k#f@fkf@ffk#%ff%fkfkk#k#f@fkf@ffk#%kfk#fkkfk#
	f%k#ffffffkffkfkfffkkfk#%ffk%fkfkkf%#fk%fkfkk#k#f@fkf@ffk#%ff@%fkfkk#k#f@fkf@ffk#%kk#:=k#ffk%k#fff@k#fkkfk#f@kff@k#%fkff%fkfkk#k#f@fkf@ffk#%fk%fkfkf@%%f@ffk#%fk#fkkfk#
	%fkfkk#k#f@fkf@ffk#%fkff@%f@f@%%k#ffffffkffkfkfffkkfk#%#k%fkfkk#k#f@fkf@ffk#%k#ffk#kffkf@kf:=k#%fkfkk#k#f@fkf@ffk#%fk#%fkfkk#k#f@fkf@ffk#%k%k#f@%fff%fffffff@%fkfk#fkkfk#
	ffkf%fkfkk#k#f@fkf@ffk#%kk#f%k#ffk#fkffffkfk#fkkfk#%kf%ffk#f@%k#f%f@ffkf%fffkfkf:=k#f%fkfkk#k#f@fkf@ffk#%k#fkff%fkfkk#k#f@fkf@ffk#%fkfk%kfkfkf%#fkkfk#
	%fkfkff%f%kfkfkf%f%fkfkk#k#f@fkf@ffk#%f%k#ffffffkffkfkfffkkfk#%#ffkfk#kfk#k#fk:=k#ff%k#fkk#%k#f%k#ffffffkffkfkfffkkfk#%%fkfkk#k#f@fkf@ffk#%fffk%kfk#%fk#fkkfk#
	kff%k#ffffffkffkfkfffkkfk#%kfff%k#ffffffkffkfkfffkkfk#%#kfk%k#k#kff@%#f@f%kfkfff%k:=k#ffk%fkfkk#f@%#fkff%fkfkk#k#f@fkf@ffk#%fkfk#%fkfkk#k#f@fkf@ffk#%kkfk#
	f%k#k#%kfkk%fkfkk#k#f@fkf@ffk#%k%k#fff@k#fkkfk#f@kff@k#%kffff@kffk:=k#%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%k#fk%ffk#k#%fff%k#kff@%fkfk#fkkfk#
	ffk#%ffffff%%fkfkk#k#f@fkf@ffk#%k%fkfkk#k#f@fkf@ffk#%@kff%k#ffk#fkffffkfk#fkkfk#%fkk#ff:=%k#ffffffkffkfkfffkkfk#%#f%k#ffkf%fk#f%k#ffffffkffkfkfffkkfk#%ff%f@k#k#%ff%k#ffffffkffkfkfffkkfk#%fk#fkkfk#
	fkfff%k#ffk#fkffffkfk#fkkfk#%kf%fkfkk#k#f@fkf@ffk#%@%fkfkk#k#f@fkf@ffk#%%k#f@fkk#%@fkk#f@f@:=k#f%k#ffk#%f%k#ffffffkffkfkfffkkfk#%#fkffff%k#ffffffkffkfkfffkkfk#%fk#fkkfk#
	k#fkf%fkk#ff%@%fkfkk#k#f@fkf@ffk#%@kff%kfkfkf%fk%k#fff@k#fkkfk#f@kff@k#%k#f@kffkfk:=k#%fkfkk#k#f@fkf@ffk#%fk%fkf@k#%#fkfff%fkfkk#k#f@fkf@ffk#%kfk#fkkfk#
	fffkkfk%k#fff@k#fkkfk#f@kff@k#%kf%fkfkk#k#f@fkf@ffk#%ffkk#k%k#f@f@f@%fk#ff:=%k#kf%k%k#fff@k#fkkfk#f@kff@k#%%k#kf%ffk%k#fff@k#fkkfk#f@kff@k#%fkf%fkfkk#k#f@fkf@ffk#%ffkfk#fkkfk#
	k#k#%fkfkk#k#f@fkf@ffk#%%fkf@fkfk%kf%k#ffffffkffkfkfffkkfk#%f@fkfff@:=k%k#fff@k#fkkfk#f@kff@k#%ff%k#ffffffkffkfkfffkkfk#%#%kfkfkf%fk%f@f@%f%fkfkk#k#f@fkf@ffk#%ffkfk#fkkfk#
	f@f@fk%kfk#ff%kff@%k#ffffffkffkfkfffkkfk#%fk#ff%fkfkk#k#f@fkf@ffk#%kk#fkkf:=%fkf@k#%k#%k#k#kf%ff%k#ffffffkffkfkfffkkfk#%#f%k#ffffffkffkfkfffkkfk#%%fkfkk#k#f@fkf@ffk#%fffkfk#fkkfk#
	kffkk%fkfkk#k#f@fkf@ffk#%f%fkfkk#k#f@fkf@ffk#%fkk%fkfkk#k#f@fkf@ffk#%fk%k#fkf@%f@k#f@ffk#:=k#ffk%k#fff@k#fkkfk#f@kff@k#%fk%fkfkk#k#f@fkf@ffk#%f%kff@%f%fkfkff%fkfk#fkkfk#
	%k#kf%k#%k#kfff%%k#ffffffkffkfkfffkkfk#%%k#fff@k#fkkfk#f@kff@k#%f@%fkfkk#k#f@fkf@ffk#%fk#k#f@:=k%k#fff@k#fkkfk#f@kff@k#%ffk#%kff@f@%%fkfkk#k#f@fkf@ffk#%k%fkfkk#k#f@fkf@ffk#%fffkfk#fkkfk#
;TRIPLE MESS FRAGMENTS FOR: #
	f%f@kf%kk%k#kf%#k#%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%%k#ffffffkffkfkfffkkfk#%fk#f@fffk:=k#ff%f@ffk#%f@k%kfk#k#%%k#fff@k#fkkfk#f@kff@k#%f%k#ffffffkffkfkfffkkfk#%kfk#f@kff@k#
	%fff@%fkffkf%k#ffffffkffkfkfffkkfk#%#fk%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%fkkfkff@fkkf:=%k#ffffffkffkfkfffkkfk#%%f@fkfffk%#f%ffffff%ff%k#ffk#fkffffkfk#fkkfk#%k#%fkfkk#k#f@fkf@ffk#%kkfk#f@kff@k#
	kff%kff@fk%ffkkfff%fkfkk#k#f@fkf@ffk#%ffkf%k#ffk#fkffffkfk#fkkfk#%ffkffk:=k#fff@%k#ffffffkffkfkfffkkfk#%#fkk%f@f@k#%fk#%fkfkk#k#f@fkf@ffk#%@kff@k#
	f@ff%k#ffffffkffkfkfffkkfk#%#ff%k#ffffffkffkfkfffkkfk#%ff%k#k#fkff%%k#ffffffkffkfkfffkkfk#%f@fk%f@fkfffk%ffffk#:=k#f%fkkffkkf%%kfffk#k#%ff@%k#ffffffkffkfkfffkkfk#%#%fkfkk#k#f@fkf@ffk#%kkfk#f@kff@k#
	kff%k#ffk#fkffffkfk#fkkfk#%%fkfkk#k#f@fkf@ffk#%%f@f@%kkf%k#ffffffkffkfkfffkkfk#%fk#ffkffffffk:=k#fff%k#kff@%@k#%fkfkk#k#f@fkf@ffk#%kk%fkfkk#k#f@fkf@ffk#%k#f%k#ffk#fkffffkfk#fkkfk#%kff@k#
	%k#fkk#ff%%k#ffffffkffkfkfffkkfk#%fkf%fkfkk#k#f@fkf@ffk#%@f%fkfkk#k#f@fkf@ffk#%kffkf@fkff:=k#%k#fkf@%f%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%@k#fkkfk#f@kff@k#
	fffff@%kfkfkf%k#kfk#%k#ffffffkffkfkfffkkfk#%#kf%fkfkk#k#f@fkf@ffk#%fk#ff:=k%f@f@ffk#%#%fkfkk#k#f@fkf@ffk#%ff@k%k#fff@k#fkkfk#f@kff@k#%f%k#ffffffkffkfkfffkkfk#%kfk#f@kff@k#
	f@kfk%ffk#%#k%fkfkk#k#f@fkf@ffk#%f@k#k%fkfkk#k#f@fkf@ffk#%f@f@kf%fkfkk#k#f@fkf@ffk#%fff:=k#f%kffk%%fkfkk#k#f@fkf@ffk#%f@k#%fkfkk#k#f@fkf@ffk#%%k#fkk#ff%kkfk#f@kff@k#
	f%fkfkk#k#f@fkf@ffk#%fffffff%fkfkk#k#f@fkf@ffk#%k#fkf@k%kfk#fkkf%ff@kfk#:=k#%fkfkk#k#f@fkf@ffk#%ff%fffkkfkf%%k#ffk#fkffffkfk#fkkfk#%k%k#fff@k#fkkfk#f@kff@k#%fkk%f@fkfffk%fk#f@kff@k#
	fk%fkf@f@%%k#ffffffkffkfkfffkkfk#%%fkfkk#k#f@fkf@ffk#%kff@k#ffk#:=k%kfkf%#%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%%f@fkf@%f@k#%fkfkk#k#f@fkf@ffk#%kkfk#f@kff@k#
	k#k#f%k#ffffffkffkfkfffkkfk#%kff%k#ffffffkffkfkfffkkfk#%kf%k#f@%k#kf%f@fkf@%kfk#fk:=k#%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%f@k#%fkfkk#k#f@fkf@ffk#%kk%fkk#f@%fk#f@kff@k#
	kf%k#ffffffkffkfkfffkkfk#%#k%f@ffkf%#f%k#ffk#fkffffkfk#fkkfk#%fkf@f%k#ffffffkffkfkfffkkfk#%ffk#ffk#k#:=%k#ffffffkffkfkfffkkfk#%#f%f@f@ffk#%ff@k#%fkfkk#k#f@fkf@ffk#%kkf%fkkffkkf%k#f@kff@k#
	kfk%kfkf%ff%k#k#kf%@k#%k#ffffffkffkfkfffkkfk#%ff%k#ffk#fkffffkfk#fkkfk#%%k#ffffffkffkfkfffkkfk#%ffffkk#k#k#:=k#f%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%@k#%fkk#ff%fkk%fkfkk#k#f@fkf@ffk#%k#f@kff@k#
	k%kff@fk%#k#k%k#fff@k#fkkfk#f@kff@k#%k#k#%k#ffffffkffkfkfffkkfk#%#%fkfkk#k#f@fkf@ffk#%@f@:=k#f%fkfkk#k#f@fkf@ffk#%f@k#f%k#ffffffkffkfkfffkkfk#%kf%fkfkk#f@%k#f@%k#fkk#%kff@k#
	k%fkfkk#k#f@fkf@ffk#%ff%kfk#k#%ffk%fkfkk#k#f@fkf@ffk#%f@f%k#ffk#fkffffkfk#fkkfk#%k#kf:=k%k#fff@k#fkkfk#f@kff@k#%fff%k#k#kf%@%k#ffffffkffkfkfffkkfk#%%fkk#ff%#fkkfk#f@kff@k#
	f%k#k#%kkff%kfkfk#%@f%k#ffk#fkffffkfk#fkkfk#%f@%fkfkk#k#f@fkf@ffk#%@%k#ffffffkffkfkfffkkfk#%#ffkfkf:=k#fff%fkf@fff@%%k#ffk#fkffffkfk#fkkfk#%k#f%k#ffffffkffkfkfffkkfk#%kfk#f%k#ffk#fkffffkfk#fkkfk#%kff@k#
	fkf@%fkf@k#%f%fkfkk#k#f@fkf@ffk#%fkk%fkfkk#k#f@fkf@ffk#%f@ff:=k#%fkfkk#k#f@fkf@ffk#%ff%fffkk#%@%ffkf%k#fk%k#ffffffkffkfkfffkkfk#%fk%k#fff@k#fkkfk#f@kff@k#%f@kff@k#
	fkfk%k#kff@f@%f%k#ffk#fkffffkfk#fkkfk#%kf%fkfkk#k#f@fkf@ffk#%f%fkf@kfkf%k#f@k#kff@ff:=%f@kf%k#%fkfkk#k#f@fkf@ffk#%ff@k#fk%k#ffffffkffkfkfffkkfk#%fk#f@kff@k#
	ffk#%k#ffkf%kff@%k#ffffffkffkfkfffkkfk#%%fkfkk#k#f@fkf@ffk#%k#f%fkfkk#k#f@fkf@ffk#%fkkf:=k#f%fkfkk#k#f@fkf@ffk#%%fkfkk#k#f@fkf@ffk#%@k%k#fff@k#fkkfk#f@kff@k#%fk%f@fkf@%%fkf@kfkf%kfk#f@kff@k#
	f%k#ffffffkffkfkfffkkfk#%kf%fkfkk#k#f@fkf@ffk#%ffk%kfk#fkkf%fk%fkfkk#k#f@fkf@ffk#%kk#k%ffffff%fffk#:=k#f%kfk#fkkf%%fkfkk#k#f@fkf@ffk#%f@k#%fff@%%fkfkk#k#f@fkf@ffk#%kkfk#f@kff@k#

;dump variable fragments 
;OBF_GLOBVAR name: mytrue
	k%f@kfk#kff@k#kff@f@kfffff%f%k#kff@f@%@f@%fkkfk#f@kfkfkfkf%fk%ffffffffffk#fkf@kff@kfk#%kf=kfk%fkfffff@k#f@ffkf%f@k%k#k#kf%#%kffff@ffk#f@k#k#f@%#f@
	f%k#f@%%fkk#fkfkfkfff@fkff%fk%k#kff@kffkk#fkk#f@%ff%ffk#ffkfkffkf@f@fff@kf%=kf%k#k#ffffkff@fk%%k#fk%%ffk#ffkfkffkf@f@fff@kf%f@%kff@k#f@f@fffkk#%#k#f@
;OBF_GLOBVAR name: myfalse
	%fkf@%f%ffkff@kffffffkkff@fk%ff%ffkfkfffkffkk#fkff%fkfk#=%k#f@kffkkfk#kf%@f@%f@k#k#%%ffkff@kffffffkkff@fk%#f%ffk#ffkfkffkf@f@fff@kf%f@fk
	ff%kffkfffff@f@fkkfff%fk%k#k#fk%%k#kff@kffkk#fkk#f@%fk=%fkk#fkfkfkfff@fkff%%k#k#k#k#kff@fkk#%%kfkfk#ff%f%fffffff@%@k#fff@fk
;OBF_GLOBVAR name: securitypassed
	f%f@f@f@ffkffffffkkfff%f%kffkfffff@f@fkkfff%f%ffk#%%k#fkk#ff%fkf=f%k#kff@f@%%k#k#fkf@kfk#f@f@f@kfk#%%kff@fkffffkfkfk#%%fkfkfffk%%fkkffff@f@k#k#fkf@%kfkffkfk
	kf%fffff@%k#%fkfffffffkk#kfff%k%fkk#ffkffffkfffkkffkk#k#%f=fkf%kfk#ffk#fkfkff%kf%k#kff@f@%kf%kff@fk%%k#k#kfffkfk#fffk%kfk
;OBF_GLOBVAR name: usermessage
	f%ffkff@k#kfk#ffk#kffkf@kf%%kfkff@%%k#k#kfffkfk#fffk%k%kfk#ffk#fkfkff%f=f%fkk#ffkff@fkf@%%kff@fkk#fkf@fkfffkkfk#ff%kf%fffff@%%f@f@k#kfk#fff@ff%f@
	f%f@kfk#%f%fkkffkkf%fk%ffkff@kffffffkkff@fk%f%fkk#fkfkfkfff@fkff%k%kfffk#fkfkkfffkff@kf%#=%k#fkk#ff%%k#fkk#fkk#fff@k#fffffkf@%%k#fkkffkfkk#f@fkkfkfffk#%f%kff@fk%k%fkk#fkfkfkfff@fkff%kf@
;OBF_GLOBVAR name: hexdigits
	k%kff@f@%%f@fff@kff@f@fkk#kff@f@%%f@fkfkk#kff@fkf@f@kf%%kffkfff@k#k#k#kf%k#=f%ffkff@kffffffkkff@fk%f%kff@fkffffkfkfk#%k#%k#kff@fk%k#%fkf@k#kffkk#fkfffk%@
	ff%kfkfk#%kf%fkk#fkfkfkfff@fkff%%fkfkfffk%f%ffkff@kffffffkkff@fk%fffk#=fk%ffkf%f%k#fkkffkfkk#f@fkkfkfffk#%k%kfffffkff@f@k#kf%%k#k#fffff@ffk#kf%#f@
;OBF_GLOBVAR name: decodekey
	kf%kffk%fk%ffk#ffkfkffkf@f@fff@kf%f%kff@k#f@f@fffkk#%#f@=k%kfkff@ffkffkf@fkff%f%k#fkk#ff%%fkk#fkfkfkfff@fkff%kf%fkkffkff%f@k#
	k%kfkfkf%f%ffkff@%k%kff@fkffffkfkfk#%f%fkk#fkfkfkfff@fkff%k%k#k#k#k#k#k#f@f@%k#kf=k%f@ffk#ffkffkf@fkffffk#%f%k#kfff%fk%fkk#fkfkfkfff@fkff%f%fkffk#fkfff@fkk#%k#
;OBF_GLOBVAR name: ishexchar
	f%fkf@k#kffkk#fkfffk%%fkfffffffkk#kfff%@f%fffk%f%k#k#fffff@ffk#kf%fk#=k#%k#fkkffkfkk#f@fkkfkfffk#%kfk%fkkfk#k#kfk#k#ff%fk#
	kf%fkffk#ffk#k#f@f@%%fkf@fff@%#%f@f@k#kfk#fff@ff%#k#=%f@f@k#%k#%ffkfkfffkffkk#fkff%%fkkffff@f@k#k#fkf@%%fkfffffffkk#kfff%kkfk#
;OBF_GLOBVAR name: useshiftkey
	%k#f@f@f@%fk%f@fff@kff@f@fkk#kff@f@%%kfffk#ffkfkfkfff%k%fkf@k#kffkk#fkfffk%fk=k#%f@fkfkk#kff@fkf@f@kf%%fkfkkfk#kffff@kffk%f%f@ff%@f%f@ffk#%fff
	%f@fff@kff@f@fkk#kff@f@%%f@fff@kff@f@fkk#kff@f@%ff%ffkff@%fkkf=k%k#k#k#k#k#k#f@f@%f%kffkkffffkkffkf@k#f@ffk#%%f@f@k#%%f@f@ffk#%f@ffff

;LOS vars for function  named: creategui
;OBF_FUNC_5_LOSVAR name: h1font
	%k#fff@%%k#k#fkf@kfk#f@f@f@kfk#%#fkk%k#kff@kffkk#fkk#f@%f@fkfkfkfkfkf@fkfk=f@kf%fkk#ffkffffkfffkkffkk#k#%@%f@f@k#%kf%fkkfk#k#kfk#k#ff%fkff%f@fkf@%f%k#f@kffkkfk#kf%ffkkf
	fkk#%fkf@k#%fk%k#fkkffkfkk#f@fkkfkfffk#%@fkf%ffk#k#%kfffffk%f@k#k#f@fkfkfkfffk%kkfk#k#kf=f@kff%ffkff@%@kfkfk%ffk#ffkfkffkf@f@fff@kf%%fkk#ffkff@fkf@%ffffkkf
;OBF_FUNC_5_LOSVAR name: h2font
	%fkk#ffkffffkfffkkffkk#k#%f%fkfkfffk%ffk#%k#k#fkff%kf%k#kffkk#fkfkf@%k%k#k#fffff@ffk#kf%#fkkffff@k#fk=k#%k#kfff%f%f@ffk#%fk%fkkffffkfkfkk#kfffk#%fff%kffkfff@k#k#k#kf%k%k#k#k#k#k#k#f@f@%fkkf
	f%ffkff@k#kfk#ffk#kffkf@kf%k#k#kf%fff@fffk%fkfk%k#k#kfffkfk#fffk%@fkk%k#fkf@%#k#f@k#k#fk=k#%kffkfk%ffk#%fkf@k#kffkk#fkfffk%ff@k%f@ffk#ffkffkf@fkffffk#%fkkf
;OBF_FUNC_5_LOSVAR name: basefont
	k%fkf@kf%#fkfk%ffk#ffkfkffkf@f@fff@kf%@kff%kfffk#ffkfkfkfff%kffffkffffk#fkk#=f%fkf@fff@%%k#kff@f@%@f%kff@k#f@f@fffkk#%f%fkfffff@k#f@ffkf%f@f%kff@k#f@f@fffkk#%k#ffkff@
	k#%kfk#k#%k%ffk#%ff%k#f@kffkkfk#kf%k#f%fkfffffffkk#kfff%fkf@kfkffffkfkf@=f%fff@k#f@k#fkfk%%k#kffkk#fkfkf@%kff%k#kffkk#fkfkf@%@%f@fkfffk%fkk#ffkff@
;OBF_FUNC_5_LOSVAR name: mymessage
	%fff@fffk%%fkk#ffkfkfffffk#ffk#ffk#%%fkf@k#kffkk#fkfffk%kff%k#fff@%k%fkfffff@k#f@ffkf%ff@kfkffff@=%k#k#fk%kf%k#kfkff@kff@f@ff%%f@k#k#f@fkfkfkfffk%%f@f@ff%f@kfffffk#ffk#kfkf
	f@f@k%k#kfk#%#k#f@%ffk#ffkfkffkf@f@fff@kf%@f@f@%kfkffkk#f@fff@fkkf%@k#fkfk=k%kfkfkffk%fkff@k%fkfffff@k#f@ffkf%%kff@fkk#fkf@fkfffkkfk#ff%fffk#ffk#kfkf
;LOS vars for function  named: decode_ihidestr
;OBF_FUNC_8_LOSVAR name: newstr
	k#%fkk#ffkff@fkf@%@f%f@ffkf%ff%ffkfkf%%f@fff@kff@f@fkk#kff@f@%%fkfffffffkk#kfff%kk#ff=ff%fkkffff@f@k#k#fkf@%%fkf@k#kffkk#fkfffk%f%k#kff@fk%fk#kffkff
	%fkfkk#f@%fffk%k#ffk#ff%f%k#k#fkf@kfk#f@f@f@kfk#%%k#kff@kffkk#fkk#f@%ffffkk#kff@k#=%f@ffkf%ff%fkkfk#k#kfk#k#ff%fff%kff@f@%%kffff@ffk#f@k#k#f@%#kffkff
;OBF_FUNC_8_LOSVAR name: startstrlen
	f%k#k#fffff@ffk#kf%f%fkfkf@%@fffff%ffk#f@ffkfk#ffffkfk#%%kff@f@%ffkfffkfkff@f@k#=%ffk#f@%fk%kfk#ffk#fkfkff%#k%kfkffkk#f@fff@fkkf%f%fkkffkff%%ffk#ffkfkffkf@f@fff@kf%f@f@k#
	f@%kff@k#f@f@fffkk#%#f@%ffffff%kf%fkkfk#k#kfk#k#ff%ff%fkk#fkfkfkfff@fkff%fkf@fk=%fkk#ffkffffkfffkkffkk#k#%kk#%fffkk#%kff%fkfffffffkk#kfff%%k#k#fk%f@f@k#
;OBF_FUNC_8_LOSVAR name: charnum
	f%kfkf%f%fffkk#%%k#fkkffkfkk#f@fkkfkfffk#%@f%kffkfffff@f@fkkfff%kfkfk#ffffkfk#=fkk%fkfffff@k#f@ffkf%k#f@%fkk#ffkfkfffffk#ffk#ffk#%#%k#kffff@%k%f@f@kf%fk#kfk#
	f%k#k#kff@%ff%fkk#fkfkfkfff@fkff%f%f@fff@kff@f@fkk#kff@f@%fk%ffkf%k#fffkf@k#=f%f@fkk#f@%%kfffk#fkfkkfffkff@kf%kfk%kffffkkffffffkf@ffkffk%f@k%kff@fkkfkfk#ffkffffffk%kfk#kfk#
;OBF_FUNC_8_LOSVAR name: hinibble
	fkf@ff%f@ffkf%f@kff@f%fff@f@kffkfffkfk%%fkkfk#k#kfk#k#ff%#fkkfk#ffk#=f%kfkfkffk%%fffkkfk#kffffkk#kfk#ff%fk%k#fkk#fkk#fff@k#fffffkf@%fk%f@ffk#%%kff@fkffffkfkfk#%kfk#fk
	f%k#k#fkf@kfk#f@f@f@kfk#%%fkkfk#k#kfk#k#ff%ff@f%fffkk#%@kffkf@=%k#k#fk%f@%k#kffkk#fkfkf@%kf%f@fkfkk#kff@fkf@f@kf%%fkkf%kfkfk#fk
;OBF_FUNC_8_LOSVAR name: lownibble
	f@%fffkk#%f@%fffkkfkf%f%k#kffkk#fkfkf@%f%kffkkffffkkffkf@k#f@ffk#%f@ffkffk=ff%kff@k#f@f@fffkk#%#f%fkk#fkfkfkfff@fkff%f@k%f@ffkf%fkfk#
	f@fk%kfffk#k#%kfk%k#fkk#k#%#fff%ffkff@k#kfk#ffk#kffkf@kf%ffk%ffffffffffk#fkf@kff@kfk#%fkfkf@fk=%k#kffkk#fkfkf@%%k#k#kfffkfk#fffk%k%ffk#kff@kfk#fffkkf%f%f@ff%ff%ffkff@%@kfkfk#
;OBF_FUNC_8_LOSVAR name: mybinary
	fkk%f@f@k#%%k#kff@kffkk#fkk#f@%%fkf@k#kffkk#fkfffk%kkfk#fff@f@fffkff=fk%kffkfk%fff%kfffk#fkfkkfffkff@kf%ff%k#fkk#fkk#fff@k#fffffkf@%fk#ffk#fkkfkf
	k#ff%k#k#kfffkfk#fffk%@%f@f@k#%kfk#%k#k#kff@%%fkk#ffkfkfffffk#ffk#ffk#%#k%k#kff@kffkk#fkk#f@%ffffkfkfk#=%ffk#k#%fkfffkf%fkf@k#kffkk#fkfffk%f%kfkffkk#f@fff@fkkf%k#ffk#fkkfkf

;PARAMETERS for function  named: ihidestr
;OBF_FUNC_7_PARAM name: thisstr
	fff@%k#kff@fk%kfkfk#%f@f@f@ffkffffffkkfff%fffk%ffffffffffk#fkf@kff@kfk#%k#=fk%kfkff@%%fkfff@%k%fkfffffffkk#kfff%k#k%kfffffkff@f@k#kf%k#ff
	%k#fff@kf%kf%kfk#ffk#fkfkff%#kfk%k#kfff%ff%f@f@f@ffkffffffkkfff%fk%k#k#ffffkff@fk%#ffk#fkkfkf=fk%kfk#ff%k%fkf@k#kffkk#fkfffk%k#k%fkk#k#ffkfk#f@fffk%k#f%ffk#ffkfkffkf@f@fff@kf%
;PARAMETERS for function  named: decode_ihidestr
;OBF_FUNC_8_PARAM name: startstr
	fff@%fkkffff@f@k#k#fkf@%ffff%fff@k#f@k#fkfk%k%f@ff%#k%fkf@k#kffkk#fkfffk%f@k#k#=%fkk#ffkfkfffffk#ffk#ffk#%#%kfk#ffk#fkfkff%%ffkfkf%ff%kffkkfffk#kfk#f@fk%ffkfk#fk
	k%f@f@k#%ff%k#k#fkf@kfk#f@f@f@kfk#%kfkf%fff@f@kffkfffkfk%#f@ffk#fkf@=k#%k#k#fffff@ffk#kf%f%ffk#ffkfkffkf@f@fff@kf%%fff@k#f@k#fkfk%ff%f@f@ff%kfk#fk
;PARAMETERS for function  named: decode_hexshiftkeys
;OBF_FUNC_9_PARAM name: startstr
	k%k#fkk#k#%fk%fkffkfk#fkfffkkfkff@fkkf%%k#fkkffkfkk#f@fkkfkfffk#%fk#fkfkk#fffff@kffffk=f%kffkkffffkkffkf@k#f@ffk#%k%k#f@kffkkfk#kf%f@k%k#f@%#fkf@ffk#
	k#fk%fkf@k#kffkk#fkfffk%@fkf%fkk#ffkfkfffffk#ffk#ffk#%ffk%fffk%#fff%k#fff@%fk#fk=f@%fkkffkkf%kff@k%kfkff@k#kff@kffffkk#k#k#%fkf@f%k#f@kffkkfk#kf%k#
;PARAMETERS for function  named: decode_shifthexdigit
;OBF_FUNC_10_PARAM name: hexvalue
	f@%fkk#ffkffffkfffkkffkk#k#%ffkf%ffffff%%fkkffff@f@k#k#fkf@%k#k#k#=f@f%fkffk#ffk#k#f@f@%f%k#fkk#fkk#fff@k#fffffkf@%ffk#%f@fkk#f@%f@f@
	fkk#%fffkkfkf%ffkfff%kff@f@k#fkkfkffkkf%#kff%fkfkkfk#kffff@kffk%fffffkkf=%kff@fkffffkfkfk#%@f%fkkffff@f@k#k#fkf@%f%k#kffk%%kfk#fkkf%%fkfffffffkk#kfff%ffk#f@f@
;PARAMETERS for function  named: fixescapes
;OBF_FUNC_11_PARAM name: forstr
	k%fffffff@%#f@f%k#k#fffff@ffk#kf%f%fff@%k%fkfkk#k#kff@kf%fk#f@kffff@ffk#=fk%f@fkfffk%k#%fkfkk#k#kff@kf%#f%k#kff@f@%f%k#kffkk#fkfkf@%%fkffk#fkfff@fkk#%f@
	%k#fff@kf%ffk#f@f%k#kff@kffkk#fkk#f@%%k#k#fkf@kfk#f@f@f@kfk#%fk#kffff@k#k#k#f@=fkk%kff@fk%#k#%ffk#ffkfkffkf@f@fff@kf%f%ffkfkfffkffkk#fkff%@f@

;for obfuscated system function calls
;OBF_SYSFUNC name: substr
	kff%fffk%kf@k%fkk#ffkff@fkf@%fkf%fkk#ffkfkfffffk#ffk#ffk#%k#=%fkkf%%ffk#k#%s%kfk#fkkf%%k#kfk#%
	k#%ffkfkfffkffkk#fkff%fff%ffkff@kffffffkkff@fk%%fkkf%#f%fkf@kf%@kfkf=%k#kff@f@%%ffkf%u%k#k#kff@%b%fkf@fff@%s%f@ff%t%f@f@ffk#%r%f@f@%%fkfkff%
	f@%fkk#fkfkfkfff@fkff%%f@fkf@%ff@%kff@fkk#fkf@fkfffkkfk#ff%@kfkfk#=%k#kff@%%k#kfk#%s%k#fff@kf%u%k#fkk#%b%fffkkf%%fkfff@%
	k%fkkffkff%ff@f%ffkff@k#kfk#ffk#kffkf@kf%%k#f@kffkkfk#kf%ff@f%kff@fkk#fkf@fkfffkkfk#ff%k#ff=%fkk#f@%%k#fkk#ff%s%k#fff@%t%fkf@fff@%r%kfkff@%%k#ffk#ff%
	kff@%kff@fkk#fkf@fkfffkkfk#ff%fk%fkfffffffkk#kfff%%f@f@ffk#%k#%fkfffffffkk#kfff%kffff=%k#kffk%%f@ffffk#%s%f@kf%u%k#f@%%fffkkf%
	fff%ffk#ffkfkffkf@f@fff@kf%kf%fkk#ff%fkf%kfffk#ffkfkfkfff%f@kffk=%fkkfff%%fffkkf%b%kff@fk%s%f@kfk#%t%ffk#%r%fkkffkkf%%fkkf%
	f@f%kfkff@%@fk%fff@f@kffkfffkfk%#kfk%ffk#%#fkf%ffkffkk#f@kfk#ffffkfkf%=%fkfkf@%%k#fkk#ff%s%k#k#fk%u%f@ffk#%%fkk#f@%
	ffff%kfk#ffk#fkfkff%#kff%kfkf%@fkf%fkkffff@f@k#k#fkf@%fk=%ffkf%%kfkfk#%b%fffkk#%s%f@k#k#%t%kfkfk#ff%r%f@fkfffk%%k#ffkf%
;OBF_SYSFUNC name: strlen
	k#k%f@kfk#%ff@k%fkfkf@kfffk#f@k#kff@ff%kffk%f@fkfkk#kff@fkf@f@kf%f=%fffk%%fkf@fff@%s%f@kf%t%k#ffkf%r%f@f@kf%l%k#fk%e%ffkff@%%f@f@fkfk%
	kf%fkfkf@%k%k#k#k#k#k#k#f@f@%%fffkkfkf%%fkk#ffkfkfffffk#ffk#ffk#%ff%fkfffffffkk#kfff%k#k#fk=%fkf@%%ffk#%n%kfk#k#%%fffkkfkf%
	k#k%k#f@kffkkfk#kf%%k#fkk#fkk#fff@k#fffffkf@%ff%f@ffkf%%fkk#fkfkfkfff@fkff%k#k#=%k#ffk#ff%%kffk%s%fkfkf@%t%fff@fffk%r%ffk#%l%fffff@%e%f@k#k#%%kfffk#k#%
	kfk#%kff@fk%kf%k#fkk#fkk#fff@k#fffffkf@%%kfffk#fkfkkfffkff@kf%fkk%f@fff@kff@f@fkk#kff@f@%ffff=%f@kf%%ffk#k#%n%k#kf%%kff@%
	kf%k#k#fkf@kfk#f@f@f@kfk#%ff%k#kfff%fk%kffffkkffffffkf@ffkffk%fk%fkfffff@k#f@ffkf%k=%fkf@kfkf%%fkfkfffk%s%k#f@fkff%t%ffkfkf%r%fkf@k#%%ffkff@%
	fkff%f@f@%fffk%k#kfk#%f%f@k#k#f@fkfkfkfffk%fkfk%fkfffff@k#f@ffkf%f=%kfkfkf%%k#f@f@f@%l%f@ffk#%e%fkkfff%n%k#kff@f@%%k#kffff@%
	k#%fkffk#ffk#k#f@f@%%fffk%f%fkk#ffkff@fkf@%%fkk#ffkff@fkf@%f@fkffff=%f@f@%%k#kffff@%s%k#k#kff@%%fkkf%
	k#%ffkfkfffkffkk#fkff%fff%k#fkk#fkk#fff@k#fffffkf@%f%kff@k#f@f@fffkk#%#f%kfkfk#ff%@k#k#=%k#f@fkk#%%kfkff@%t%ffkff@%r%ffkff@%l%fkfff@%e%k#kfk#%n%kfffk#k#%%kfkfk#%
;OBF_SYSFUNC name: chr
	kff%fkk#f@%fk#k%f@k#k#f@fkfkfkfffk%kfff=%f@fkfkf@%%kfkfff%c%f@ffffk#%%k#fkk#%
	fkf@f%k#kffk%f%k#k#fkf@kfk#f@f@f@kfk#%fff%k#k#fffff@ffk#kf%#fff@=%f@f@ff%%fkf@kf%h%k#fkf@%r%f@fkfkf@%%f@ff%
	f@f%f@ffffk#%f%fkk#ffkff@fkf@%f%ffkff@kffffffkkff@fk%%fffff@k#kfk#k#kfffk#ff%f@f@k#ff=%kfkfk#%%k#kfk#%c%k#k#fkff%%kfk#k#%
	k%ffkff@%fk%f@kfk#kff@k#kff@f@kfffff%f%kff@%%fkfff@kff@f@fkk#f@f@%fffkk#kf=%f@fkf@%%fkkfff%h%fkf@k#%r%k#kfff%%f@fkf@%
	f@%k#kff@fk%k#k%k#k#kfffkfk#fffk%k%fkf@%#ff%kff@fkk#fkf@fkfffkkfk#ff%%fkk#ffkfkfffffk#ffk#ffk#%kfkf=%k#f@fkk#%%kfk#k#%c%k#ffkf%h%fkkffkff%%f@f@fkfk%
	fkf%k#k#fkf@kfk#f@f@f@kfk#%fk%fkf@k#%%fkfffffffkk#kfff%%k#k#fkff%@fff@k#=%fffffff@%%fffkkf%r%kfkfkf%%k#kffk%
	%fkkfk#f@kfkfkfkf%#f@%kfkfk#%fff%fkk#ffkfkfffffk#ffk#ffk#%fff%fkfff@kff@f@fkk#f@f@%=%k#k#kff@%%k#k#kf%c%fkf@kfkf%%f@f@k#%
	%kfk#fkkf%%ffk#ffkfkffkf@f@fff@kf%fff%kff@f@k#fkkfkffkkf%#f%fkk#ffkffffkfffkkffkk#k#%fffff@k#=%kfk#%%kfffkfkf%h%kff@%r%kff@f@%%kfkff@%
;OBF_SYSFUNC name: asc
	f@f%kff@fkk#fkf@fkfffkkfk#ff%f@f%kff@k#f@f@fffkk#%kf%k#k#kff@%fk=%k#fkk#k#%%f@f@ff%a%kffkkf%%fkk#%
	k%k#f@fkk#%ff%kfffk#ffkfkfkfff%kffk%fkfffff@k#f@ffkf%kfkk#=%f@ffffk#%%kfkfk#ff%s%f@fkfffk%c%f@f@%%k#fkf@%
	fk%k#fkk#fkk#fff@k#fffffkf@%%fkf@f@%%kfkff@%%fkkfk#f@kfkfkfkf%kffkfffffffk=%kffkkf%%f@f@k#%a%kfkfkffk%s%f@fkf@%%k#k#kff@%
	%k#ffkf%%k#k#kfffkfk#fffk%f%fkk#ffkff@fkf@%%kffkkf%f%fkffk#ffk#k#f@f@%fk#ffk#ff=%f@f@ff%%fkk#ff%c%fffkkfkf%%k#kff@%
	k#%k#kfff%%fkfffff@k#f@ffkf%ff%fkk#fkfkfkfff@fkff%f%kff@f@k#fkkfkffkkf%fkff=%fkf@kfkf%%k#k#fk%a%f@f@ff%s%fffk%%f@f@kf%
	fkf%k#fkkffkfkk#f@fkkfkfffk#%f%f@ffk#%fff%ffkfkfffkffkk#fkff%@f%ffffk#ffkfk#kfk#k#fk%kfff=%f@ff%%kfkfkffk%c%kfkfff%%kffkkf%
	f%fff@k#f@k#fkfk%%kffkfk%%fkk#fkfkfkfff@fkff%@fkkffkf@k#=%ffk#%%f@ff%a%fffffff@%s%k#k#fkff%%kfk#fkkf%
	f%fkffk#fkfff@fkk#%%fkk#ff%fk%k#fkk#fkk#fff@k#fffffkf@%kfffffff@=%fkfkfffk%%fkf@fff@%c%f@kf%%fffkkfkf%
;OBF_SYSFUNC name: instr
	%k#f@fkff%fk%k#kfkff@kff@f@ff%f%ffffff%%f@fkfkk#kff@fkf@f@kf%f%fkkfk#k#kfk#k#ff%ffkkf=%kfkff@%%k#ffk#%i%k#f@f@f@%n%kfk#fkkf%s%kfkfk#ff%t%f@fkfkf@%%fkk#kf%
	%kffkfk%f@%kff@f@%fkf%ffkffkk#f@kfk#ffffkfkf%k#%fkffk#ffk#k#f@f@%fffk#=%kfkfff%%fkkf%r%fkfkf@%%kff@fk%
	f@%f@fkk#f@%k#f%ffk#ffkfkffkf@f@fff@kf%ffff%kfkffkk#f@fff@fkkf%kkf=%f@kfk#%%ffkffk%i%f@f@kf%n%kfkfff%s%kfkfk#ff%%f@f@%
	fk%k#ffkf%f@f%k#kfkff@kff@f@ff%f%ffk#k#%@%f@f@f@ffkffffffkkfff%ffk=%f@f@ff%%k#kffff@%t%fkf@k#%r%k#fkk#ff%%f@fkk#f@%
	fk%fkfffffffkk#kfff%@fff%fkffk#ffk#k#f@f@%k%fkkfff%ff%k#fkk#k#%ff@f@=%kfk#k#%%kfkfkf%i%f@ff%n%fkfkkf%%ffkffk%
	%fkfffff@k#f@ffkf%@fff%ffk#f@ffkfk#ffffkfk#%k#fk%fkk#kf%ff=%fkf@k#%%ffk#f@%s%fkk#f@%t%kffkfk%r%f@f@ffk#%%kfkfkffk%
	f%fkffk#ffk#k#f@f@%%kfk#ffk#fkfkff%#%fkk#ffkffffkfffkkffkk#k#%@%fffffff@%f@k#f@=%f@ffk#%%fffk%i%f@ffkf%%k#fff@%
	kf%fkfkfffk%kff%k#k#f@ffk#k#f@%kfk%fkfffff@k#f@ffkf%fkf%fkfkk#k#kff@kf%fk=%kfkf%%k#fff@%n%kfkfk#ff%s%ffk#k#%t%f@fkk#f@%r%fffkkfkf%%ffkf%

;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
;OBF_FUNC name: SECURITYTESTS_bestcodesection
	f%f@k#k#%@%k#f@kffkkfk#kf%@k#k%fkk#ffkff@fkf@%ffffff=%k#fkk#fkk#fff@k#fffffkf@%@f%k#k#fffff@ffk#kf%f%k#fkk#%f%f@f@ffk#%fkfff@
	%k#fkk#%k#%f@ffkf%fk%ffkff@kffffffkkff@fk%%f@ffk#ffkffkf@fkffffk#%k#k#fkffff=f%k#kfk#%@f%k#k#fkf@kfk#f@f@f@kfk#%fff%kff@f@k#fkkfkffkkf%fff@
;OBF_FUNC name: WIREUP_bestcodesection
	k%k#k#kff@%fk%k#k#k#k#k#k#f@f@%f%f@fff@kff@f@fkk#kff@f@%k%fkkfff%#f%k#f@kffkkfk#kf%f@fk=f@%ffkff@kffffffkkff@fk%f%fkfffff@k#f@ffkf%%f@f@kf%fk#fkffkfkf
	ff%kffkfk%%kfkfkffk%fk%ffkfkfffkffkk#fkff%%k#k#k#k#kff@fkk#%kff%k#kfkff@kff@f@ff%f@kfff=f%fkfkkfk#kffff@kffk%kfffk%f@k#k#%#%f@fff@kff@f@fkk#kff@f@%kffkfkf
;OBF_FUNC name: creategui
	k#f%f@fkfkk#kff@fkf@f@kf%f%k#k#fkfkf@fkfff@%%fkk#ffkfkfffffk#ffk#ffk#%#f%k#ffkf%fkfkfk#=k#%fkfkk#k#kff@kf%f%kfkffkk#f@fff@fkkf%@k%k#f@%#%kff@f@k#fkkfkffkkf%#k%kfkff@%ffk
	ff%k#kfff%kfk%kfkffkk#f@fff@fkkf%ffk%f@ffk#ffkffkf@fkffffk#%f@=k#kf%k#fkkffkfkk#f@fkkfkfffk#%@k#%fffff@%k#k%fkf@k#kffkk#fkfffk%fk
;OBF_FUNC name: testfunction
	kf%k#fk%f@%f@fff@kff@f@fkk#kff@f@%ff%fkkffff@f@k#k#fkf@%fkf%kff@fkk#fkf@fkfffkkfk#ff%kfkf=fk%kfk#k#%f@k%kff@fkffffkfkfk#%%fkkffff@f@k#k#fkf@%fk#k#f@fk
	ffk%fkkfff%#k#f%kffkfff@k#k#k#kf%k%k#kffkk#fkfkf@%k#f@=%f@f@fkfk%fkf%k#k#f@ffk#k#f@%kfkf%ffkff@kffffffkkff@fk%#k#f@fk
;OBF_FUNC name: ihidestr
	ff%k#f@fkk#%k#%fkkfk#k#kfk#k#ff%ffkfk%fkkfk#f@kfkfkfkf%ffkfk=fff@%kfffk#k#%kff%k#kff@fk%kfk%f@k#k#f@fkfkfkfffk%%k#fkf@f@kfffk#k#f@kffkfk%k#k#
	k#kf%f@f@k#%kf%fkk#fkfkfkfff@fkff%ff@f%ffkfkfffkffkk#fkff%ff=fff%kfffk#ffkfkfkfff%kff%kff@k#f@f@fffkk#%fkf%fkfkk#f@%%f@kfk#%@k#k#
;OBF_FUNC name: decode_ihidestr
	k%f@f@ff%ffk%k#ffkf%ff%kfkffkk#f@fff@fkkf%%fkk#ffkff@fkf@%ffffk#kf=%k#fkk#fkk#fff@k#fffffkf@%%kff@fkk#fkf@fkfffkkfk#ff%ff%kffkfffff@f@fkkfff%fk%f@ffk#%%k#kff@fk%ffkfk
	ffk#%fkffk#ffk#k#f@f@%#f%k#ffkf%kk%ffk#kff@kfk#fffkkf%%k#fkk#ff%f@f@kf=f%f@fkfkk#kff@fkf@f@kf%%f@fkfkf@%ffk%kfk#%f%f@f@k#kfk#fff@ff%ffkfk
;OBF_FUNC name: decode_hexshiftkeys
	f@%fkk#fkfkfkfff@fkff%f%kff@f@k#fkkfkffkkf%#k%f@fff@kff@f@fkk#kff@f@%kf%f@ff%%k#kff@%f@fk=k#ffk%f@f@fkfk%#%kffkfffff@f@fkkfff%%fkk#ffkffffkfffkkffkk#k#%fkfkk#f@
	ff%kfkfff%f@%ffkff@kffffffkkff@fk%#%kffkkf%fk%f@fkfkk#kff@fkf@f@kf%ff%fffkkfk#kffffkk#kfk#ff%kf=k#ff%fkkffff@f@k#k#fkf@%#kf%kffkfk%fkfk%fkkffff@f@k#k#fkf@%#f@
;OBF_FUNC name: decode_shifthexdigit
	k#f%k#kff@kffkk#fkk#f@%%k#fkk#k#%kf%f@f@f@ffkffffffkkfff%%fff@fffk%#f@k#f@ff=f@%k#f@fkk#%k#%ffkff@%k%fkfffff@k#f@ffkf%f%kff@fkk#fkf@fkfffkkfk#ff%kf%fkf@k#kffkk#fkfffk%@f@
	f@f%ffffk#ffkfk#kfk#k#fk%ff%k#fk%%ffkfkfffkffkk#fkff%@%k#fkkffkfkk#f@fkkfkfffk#%kk#=f%k#ffk#ff%@%ffk#k#%k%fkk#k#ffkfk#f@fffk%kf%kff@fkffffkfkfk#%f%kfk#ffk#fkfkff%ff@f@
;OBF_FUNC name: fixescapes
	kf%kfk#k#%%fkk#ffkff@fkf@%fk%kffkkf%#k%f@fff@kff@f@fkk#kff@f@%k%fkfffffffkk#kfff%kffk=k%kff@fkffffkfkfk#%f%ffk#fkf@kff@fkk#ff%%k#kfk#%kf%kfkffkk#f@fff@fkkf%%k#kff@%fk#fkf@
	k#f%k#kfff%fkf%kffkfffff@f@fkkfff%#f@f%kfk#ffk#fkfkff%f@kf=%k#f@f@f@%kff%k#kff@fk%@%k#kfkff@kff@f@ff%ff%ffk#ffkfkffkf@f@fff@kf%k#fkf@


;OBF_LABEL name: testguisubmit
	ffk%f@ffk#ffkffkf@fkffffk#%fff@ffk%fkk#ff%#k#f%f@f@fkkff@kfk#fffkk#fkkf%k#%fff@f@kffkfffkfk%fffkffkkfffk#fk=%fffkkfkf%k#%k#fkkffkfkk#f@fkkfkfffk#%ff@%k#fff@kf%kfkfk%fkffkfk#fkfffkkfkff@fkkf%ffkfkfffk#kfk#k#kffffff@kfk#kf
	f%kffk%%f@f@k#kfk#fff@ff%f@k%kfkffkk#f@fff@fkkf%fff@fff@kff@ffk#fkkfk#=k#f%f@k#k#%ff@kf%kffkfk%kfk#f%fkk#fkfkfkfff@fkff%kf%kff@f@k#fkkfkffkkf%fffk#kfk#k#kffffff@kfk#kf
;OBF_LABEL name: cancelprog
	kfffk%k#kffkk#fkfkf@%f%kff@fkffffkfkfk#%kf%k#f@f@f@%k#fkf@k#kfk#k#fff@k#fk=f@k#kff%fkf@kf%ffkf%kfffkfkf%kk#%fkfkk#k#kff@kf%ff%ffffk#ffkfk#kfk#k#fk%f@k#f@f@fkkf
	%fkfkk#f@%%k#kf%fkk#k#%k#k#fkf@kfk#f@f@f@kfk#%ff@%k#f@kffkkfk#kf%@fkkfk#f@kff@k#f@kf=f@k#%ffkfkf%%kffk%kffff%f@f@f@ffkffffffkkfff%f%fkk#ffkfkfffffk#ffk#ffk#%k#k%ffkfkfffkffkk#fkff%f@f@k#f@f@fkkf
;OBF_LABEL name: guigosub
	kfk%kfk#ff%%fkk#k#ffkfk#f@fffk%fff@f@f%fkk#ffkff@fkf@%kf%k#f@kffkkfk#kf%ffkffkffkfffk=k%k#f@kffkkfk#kf%kff%fkffk#ffk#k#f@f@%fff%fkfkf@%kfkk#k#fff@fff@
	kf%kfk#%kf%k#k#kf%f%ffkffkk#f@kfk#ffffkfkf%fkk#f%fffkkfk#kffffkk#kfk#ff%kffkk#%k#fkk#fkk#fff@k#fffffkf@%kkfkfkfffffkf=k%k#k#%fk%k#kffkk#fkfkf@%fkff%f@k#k#f@fkfkfkfffk%kfk%fkkffff@f@k#k#fkf@%#k%fkf@%#fff@fff@



;$OBFUSCATOR: $DEFGLOBVARS: mytrue, myfalse
%k#f@f@kfk#kf%%f@f@kf%%fkfff@% = 1
%f@f@%f%fkfff@kff@f@fkk#f@f@%f%k#k#fkfkf@fkfff@%k%ffk#%%kfkff@%#fff@fk = 0

;AUTOHOTKEY BUILT IN FUNCTIONS!
;tell obfuscator to obfuscate these autohotkey built in functions
;$OBFUSCATOR: $DEFSYSFUNCS: substr, strlen, chr, asc, instr, 

;BECAUSE THIS PROGRAM HAS 'SECURE' OBFUSCATION CLASSES
;DUMPS MUST BE DONE FOR EACH SECURE CLASS!
;they will be done in the following functions:
;'SECURITYTESTS_bestcodesection' and 'WIREUP_bestcodesection'.
;the first function will pop a dialog box to the user if they
;want to run the program simulating security passed or security failed.
;poisened DUMPS can be run in that function!

;i will DUMP good security fragments or poisened security fragments
;for a secure obfuscation class named 'bestcodesection'

f@f%kfffk#fkfkkfffkff@kf%fff%fkkfff%k%f@fkf@%f%fkk#ffkffffkfffkkffkk#k#%f@()

;now i will DUMP triple mess fragments and object name fragments
;for a class named 'bestcodesection'. if poisened security fragments
;were dumped above, then the wiring up below will all be done wrong!
f%k#fkf@%%fkf@f@%@kf%ffkfkfffkffkk#fkff%fk#f%k#k#ffffkff@fk%ffkfkf()

;now i call a function that is in the 'bestcodesection' class.
;if the wiring up above has gone bad, then a call to the function
;below will end up with an ugly result or not running at all!
MsgBox, 4, RUN TEST, %fkfff@%%fkf@fkfk%%fkfkkfkffkfk%`n`nRUN TEST?`nCall the function named 'function_in_bestcodesection' in 'bestcodesection'?	
IfMsgBox Yes 
{
	kf%f@fkffk#kffkfkfkff%#k%f@f@kfffk#fkf@f@fkkf%ff@f%k#k#k#fkk#kfffk#%fkk#%k#fffff@fkkffkkff@k#%fk()
	msgbox, %fkf@fff@%%fkfkkfkffkfk%%fkkffkff%`n`nINTERPRET TEST RESULTS:`nMessage '123' should have shown! Otherwise the function never executed.
}

;now i call a label that is in the 'bestcodesection' class.
;if the wiring up above has gone bad, then a call to the function
;below will end up with an ugly result or not running at all!
MsgBox, 4, RUN TEST, %fkfkkfkffkfk%%kfk#%%fkf@fff@%`n`nRUN TEST?`nCall the label named [gosubin_bestcodesection] in 'bestcodesection'?	
IfMsgBox Yes 
{
	gosub, f@kfk%f@fkfkffk#fffkfk%kfkfkfk%fkkff@fff@ffk#k#fkf@kfk#kf%#k#fff%fffkkff@kffkfkk#f@fk%ffff%kfk#kffffkkfkffkfkfkf@k#%@kffkf@
	msgbox, %f@f@k#%%fkfkkfkffkfk%%k#fkk#%`n`nINTERPRET TEST RESULTS:`nMessage 'abc' should have shown! Otherwise the label wasn't called.
}

;now i call a function that creates a gui but the gui has a reference
;to a label that will be bad if you have choosen to simulate security
;failed. 
MsgBox, 4, RUN TEST, %k#fk%%fkfkkfkffkfk%%k#fkk#k#%`n`nRUN TEST?`nCreate GUI with reference to label in`nprotected class in it?	
IfMsgBox Yes 
{
	;tests local variables, global variables, gosub label as 
	;part of a 'gui, add' statement, and variables defined as associated
	;with a gui control
	k#%fkkfff%%k#kff@f@%%kfkf%kf%kfkffkk#f@fff@fkkf%%k#k#fkfkf@fkfff@%k#k#kffk()
	
	msgbox, %kfk#ff%%fkfkkfkffkfk%%fkf@fkfk%`n`nINTERPRET TEST RESULTS:`nThis message should show!
}
	 
RETURN

;the first statement creates a 'secure' class and the second
;statement tells it to add the function and label sections that
;follow in the source code to that class

;$OBFUSCATOR: $CREATEOBJCLASS: bestcodesection
;$OBFUSCATOR: $ADDFOLLOWING_TOCLASS: bestcodesection

;FUNCTION ORIGINAL NAME: function_in_bestcodesection
kfk#kff@fffkk#fk() { 
	global
	
	;yady yady yada
	
	msgbox, %kfffkfkf%%fkfkkfkffkfk%%kffkkf%`n`nInside function named [function_in_bestcodesection]`n`nMESSAGE: 123
}


;FUNCTION ORIGINAL NAME: returnfrom_bestcodesection
k#fff@k#fkf@() { 
	global
	
	return "hello from function named [returnfrom_bestcodesection]"	
}


;LABEL ORIGINAL NAME: gosubin_bestcodesection
f@kfk#kfkfkfk#k#fffffff@kffkf@:
	msgbox, %k#kfk#%%fffk%%fkfkkfkffkfk%`n`nInside label named [gosubin_bestcodesection]`n`nMESSAGE: abc
return

;this tells the obfuscator to stop adding function and label sections
;to the class
;$OBFUSCATOR: $ADDFOLLOWING_TOCLASS:


;FUNCTION ORIGINAL NAME: SECURITYTESTS_bestcodesection
f@fkfffkfff@() { 
	global
;$OBFUSCATOR: $DEFGLOBVARS: securitypassed
	
	MsgBox, 4, SHOULD SECURITY PASS, SHOULD SECURITY BE COUNTED AS PASSED?`n`nShould this run of this program be`ncounted as passing security?

	;the only difference in the program will be the 2 DUMPS
	;everything else remains the same with no security forks
	IfMsgBox Yes 
	{
	;SECURITY CLASS FRAG: for class: bestcodesection for char: f
	f%k#fkk#ff%kf@%f@k#k#f@fkfkfkfffk%%fkk#ffkfkfffffk#ffk#ffk#%k#f%fffff@%%fff@f@kffkfffkfk%f@fkfk:=fkff%fkk#fkfkfkfff@fkff%fff%f@k#k#f@fkfkfkfffk%%ffkf%kk#kfff
	;SECURITY CLASS FRAG: for class: bestcodesection for char: k
	k%k#kfk#%%k#ffk#%%kfffffkff@f@k#kf%%fkkfk#f@kfkfkfkf%%fkkffffkfkfkk#kfffk#%fkkffkk#f@:=kf%kff@%f@%kffff@ffk#f@k#k#f@%#f@%fkf@k#kffkk#fkfffk%@fffkk#
	;SECURITY CLASS FRAG: for class: bestcodesection for char: @
	kff%kfk#ff%@%kff@fkffffkfkfk#%@f%k#k#fkf@kfk#f@f@f@kfk#%ff%fff@%kfkffffk:=f%fkk#ffkff@fkf@%ffk#%ffkffk%%f@ffffk#%ffk%fkf@k#kffkk#fkfffk%k#%k#k#fkf@kfk#f@f@f@kfk#%fk#k#fk
	;SECURITY CLASS FRAG: for class: bestcodesection for char: #
	%fkk#ffkffffkfffkkffkk#k#%fkff%k#kfkff@kff@f@ff%fkkf%k#fkk#%fkf@fffk:=fk%k#k#%kfk%fkf@k#kffkk#fkfffk%f@k#%kff@fkffffkfkfk#%fk#
	;SECURITY CLASS FRAG: for class: bestcodesection for char: NULL
	ffkff%k#kff@fk%kk#f%kfkffkk#f@fff@fkkf%fk%k#k#fffff@ffk#kf%#%k#kffkk#fkfkf@%kk#kf:=%fkf@fff@%f@%k#k#kff@%%ffk#ffkfkffkf@f@fff@kf%%f@f@f@ffkffffffkkfff%fkf@

		%k#kffk%%k#kffk%%fkfkffkf% = SIMULATING SECURITY PASSED THIS RUN`nEverything should run as expected
	} else {
	;POISENED SECURITY CLASS FRAG: for class: bestcodesection for char: f =poisened char: #
	%kfkf%fk%fkfffffffkk#kfff%@fkk%kfkff@ffkffkf@fkff%fkf@%fkfffffffkk#kfff%kfk:=fk%k#k#kfffkfk#fffk%@f%fkkffkkf%f%kfk#%f%kff@k#f@f@fffkk#%kff@ff
	;POISENED SECURITY CLASS FRAG: for class: bestcodesection for char: k =poisened char: NULL
	k#k%fffff@%#%k#f@kffkkfk#kf%%k#k#fffff@ffk#kf%kff%k#k#fkf@kfk#f@f@f@kfk#%k#f@:=%k#k#fkf@kfk#f@f@f@kfk#%%ffk#kff@kfk#fffkkf%%f@ff%%f@fkfkk#kff@fkf@f@kf%@
	;POISENED SECURITY CLASS FRAG: for class: bestcodesection for char: @ =poisened char: f
	kff%ffkff@%@f@%k#kff@f@%f%kff@f@k#fkkfkffkkf%ffkf%kffkfffff@f@fkkfff%ffffk:=ff%kffkfffff@f@fkkfff%f%k#k#fkf@kfk#f@f@f@kfk#%f%k#f@kffkkfk#kf%f%k#ffk#%kffkk#fkff
	;POISENED SECURITY CLASS FRAG: for class: bestcodesection for char: # =poisened char: k
	f%fkf@k#%f%fkkffff@f@k#k#fkf@%%ffk#ffkfkffkf@f@fff@kf%fk%k#f@kffkkfk#kf%kkffkf@fffk:=%kfkfkffk%kf%fkkf%%k#f@kffkkfk#kf%kff%k#fkk#fkk#fff@k#fffffkf@%f%k#fkk#fkk#fff@k#fffffkf@%@f@fkkfff
	;POISENED SECURITY CLASS FRAG: for class: bestcodesection for char: NULL =poisened char: @
	ffkf%fkf@kf%fkk#ff%fkf@k#kffkk#fkfffk%k%k#k#ffffkff@fk%#fkk#kf:=ffk#f%f@f@fkkff@kfk#fffkk#fkkf%ffk%f@fff@kff@f@fkk#kff@f@%k#ff%f@fkfffk%%fkfffffffkk#kfff%fkfk#

		%fkk#ffkff@fkf@%%kffff@ffk#f@k#k#f@%fkk%kfk#fkkf%fkf%k#k#kff@%fkfk = SIMULATING SECURITY FAILED THIS RUN`nEverything SHOULD HAVE PROBLEMS running!
	}
}


;FUNCTION ORIGINAL NAME: WIREUP_bestcodesection
f@kfffk#fkffkfkf() { 
	global	
;TRIPLE MESS FRAGMENTS for class: bestcodesection for char: f
	k#f@f%fff@k#f@k#fkfk%k#k#%fkf@%f@%ffkfkfffkffkk#fkff%@kffk%k#kffkk#fkfkf@%ff@:=kfkf%fkf@fkk#fkf@fkfk%k%k#k#fkkffkk#f@%#f@fff@fkkf
	%k#k#kfffkfk#fffk%@fkf%fkfkkf%fffk#f@%k#kff@kffkk#fkk#f@%@ffk#k#ff:=ffk#ff%k#k#fkkffkk#f@%fkf%fkf@fkk#fkf@fkfk%kf@f@fff@kf
	fkf%f@k#k#f@fkfkfkfffk%%ffkff@%f%k#k#f@ffk#k#f@%%ffkff@kffffffkkff@fk%#ffkfff:=k#k%ffkffkfkkffkf@fffk%kff%fkf@fkk#fkf@fkfk%%k#k#fkkffkk#f@%fk#fffk
	kff@%fkk#ffkff@fkf@%%fkf@k#kffkk#fkfffk%f@fkk%f@kfk#%#ffk%kfkff@%#fffk:=fkf@%k#k#fkkffkk#f@%#%k#k#fkkffkk#f@%ffkk%ffkffkfkkffkf@fffk%fkfffk
	f@k%fkkff@f@f@f@k#ffkfkf%k#fkfk%fkfffff@k#f@ffkf%ffkf@f%fkk#ff%kfffkkfkf:=kfkf%fkf@fkk#fkf@fkfk%kk#f@%fkf@fkk#fkf@fkfk%ff@fkkf
	%fkffk#ffk#k#f@f@%#f%fkfkkfk#kffff@kffk%k%k#kff@fk%#fkk#fff@kf:=k%ffkffkfkkffkf@fffk%kf%fkf@fkk#fkf@fkfk%@kffkk#fkk#f@
	f@%f@f@f@ffkffffffkkfff%#k#k#f%fffkk#%f%k#fkkffkfkk#f@fkkfkfffk#%@fkkf%f@fkfkk#kff@fkf@f@kf%@f@fffk:=fk%fkf@fkk#fkf@fkfk%ffff@%k#k#fkkffkk#f@%#f@ffkf
	fk%f@f@f@ffkffffffkkfff%%kffkfk%ff%f@fkfkk#kff@fkf@f@kf%ff%fkk#ffkff@fkf@%@%fkkfff%k#k#:=kfkf%fkf@fkk#fkf@fkfk%k%k#k#fkkffkk#f@%#f@fff@fkkf
	f@%fkfkk#k#kff@kf%fk%k#f@kffkkfk#kf%ffff%ffkfkfffkffkk#fkff%%k#k#%ffkfff@f@f@:=fkk#f%fkf@fkk#fkf@fkfk%kf%fkf@fkk#fkf@fkfk%ffkff%fkf@fkk#fkf@fkfk%kkffkk#k#
	k%fkffkfk#fkfffkkfkff@fkkf%k#%k#f@fkff%k#%k#ffk#%%k#kffkk#fkfkf@%kk#kfffk#:=%k#k#fkkffkk#f@%#f%kff@f@fkffkfkffffk%kf%fkf@fkk#fkf@fkfk%kkfk#kf
;TRIPLE MESS FRAGMENTS for class: bestcodesection for char: k
	f@ff%fffkkf%ff%kff@fkk#fkf@fkfffkkfk#ff%%f@f@fkkff@kfk#fffkk#fkkf%fkk%fkf@fkfk%ffff@:=%k#k#fkkffkk#f@%%fkf@fkk#fkf@fkfk%f@f@k#fkkfkffkkf
	f%fkkfff%kf@k%fffff@k#kfk#k#kfffk#ff%k#%kff@fkffffkfkfk#%ff%fkkfk#k#kfk#k#ff%fkk#k#k#f@fff@:=fkk#ffk%fkf@fkk#fkf@fkfk%kffff%fkf@fkk#fkf@fkfk%k#ffk#ffk#
	k#ff%k#f@fkk#%ff%kff@fkffffkfkfk#%fk%k#fkkffkfkk#f@fkkfkfffk#%f@f@ff%fkfffff@k#f@ffkf%@kff@fkf@:=%k#k#fkkffkk#f@%#k%fkf@fkk#fkf@fkfk%kff@%k#k#fkkffkk#f@%ff@f@ff
	f%ffk#%@k#k%fkk#ffkff@fkf@%f@k%k#k#fkkffkkfk#kfkfk#fk%fkfkkfk#fkkfkf:=%k#k#fkkffkk#f@%#kfk%fkf@fkk#fkf@fkfk%f%kff@f@fkffkfkffffk%kff@f@ff
	k#k#%fkfkff%ff%ffkfkf%f%kffkfffff@f@fkkfff%%kff@fkffffkfkfk#%kk#ffk#:=f%k#k#fkkffkk#f@%%fkf@fkk#fkf@fkfk%fk%ffkffkfkkffkf@fffk%ffk#k#f@f@
	k%k#kff@%%kfkfkffk%#k%k#k#kfffkfk#fffk%ff%k#fkkffkfkk#f@fkkfkfffk#%kk%fkf@k#kffkk#fkfffk%f@fk:=fkffk#%fkf@fkk#fkf@fkfk%fk%ffkffkfkkffkf@fffk%k#f@f@
	f@fkf%k#ffkf%fk#k%k#f@kffkkfk#kf%fkfk%k#k#kfffkfk#fffk%kff:=ffk%fkf@fkk#fkf@fkfk%f@%k#k#fkkffkk#f@%ffffffkkff@fk
	k%f@fff@kff@f@fkk#kff@f@%k#%k#fkf@%kf%kff@fkffffkfkfk#%fk#%k#kff@kffkk#fkk#f@%ff@ffkf:=fkkfff%fkf@fkk#fkf@fkfk%@f@%k#k#fkkffkk#f@%#k#fkf@
	ffk%k#fkk#fkk#fff@k#fffffkf@%%k#fkk#k#%fkff%fkkffkkf%%f@f@k#kfk#fff@ff%ff@f@fff@kfffkf:=fff@f@k%fkf@fkk#fkf@fkfk%%fkf@fkk#fkf@fkfk%kfffkfk
	f%k#fkk#%@f%fkk#ffkfkfffffk#ffk#ffk#%fkff%f@f@k#kfk#fff@ff%ff@%f@k#k#f@fkfkfkfffk%@f@k#:=f%k#k#fkkffkk#f@%fkk#%k#k#fkkffkk#f@%#%k#k#fkkffkk#f@%ff@kf
;TRIPLE MESS FRAGMENTS for class: bestcodesection for char: @
	fkf%k#fkk#%kkf%f@ffffk#%f%f@f@f@ffkffffffkkfff%fk%fkkffff@f@k#k#fkf@%ff%fkk#ffkff@fkf@%ff:=kffk%k#k#fkkffkk#f@%ffffkkf%fkf@fkk#fkf@fkfk%kf@%k#k#fkkffkk#f@%#f@ffk#
	%f@f@k#kfk#fff@ff%ff@%kfffk#k#%f%fkfff@kff@f@fkk#f@f@%%kff@fkk#fkf@fkfffkkfk#ff%@k#fkfff@f@k#:=k#k%ffkffkfkkffkf@fffk%f@ff%k#k#fkkffkk#f@%#k%ffkffkfkkffkf@fffk%f@
	k%ffkfkfffkffkk#fkff%f%fkfff@kff@f@fkk#f@f@%f@k#%fkk#ffkffffkfffkkffkk#k#%fk%kfk#fkkf%%k#fk%fk#fkkfff:=fkffk%ffkffkfkkffkf@fffk%fkff%fkf@fkk#fkf@fkfk%@fkk#
	f@fkf%f@f@kf%@fkf%fkk#fkfkfkfff@fkff%k#k#k%f@fkfkk#kff@fkf@f@kf%fkkffkfkff:=fkf%fkf@fkk#fkf@fkfk%k#f%k#k#fkkffkk#f@%%fkf@fkk#fkf@fkfk%ff@fkk#
	%fkfffff@k#f@ffkf%fk%ffk#kff@kfk#fffkkf%kf%f@fff@kff@f@fkk#kff@f@%ff@%fkf@fkfk%k%kfkfkf%ffkfffkkffff@:=kff%k#k#fkkffkk#f@%%k#k#fkkffkk#f@%fffk#kfk#f@fk
	f@fk%k#kfff%f@f%fkk#ffkfkfffffk#ffk#ffk#%%k#fkkffkfkk#f@fkkfkfffk#%k%kff@fkffffkfkfk#%%kffkfk%fffk#kfffk#:=f@fkf%kff@f@fkffkfkffffk%k%ffkffkfkkffkf@fffk%fk%k#k#fkkffkk#f@%#fkf@kf
	%k#fkf@%k#kf%kfk#ffk#fkfkff%ffk%k#fkkffkfkk#f@fkkfkfffk#%kf@k#:=f%k#k#fkkffkk#f@%%fkf@fkk#fkf@fkfk%%fkf@fkk#fkf@fkfk%k#fkfff@fkk#
	k%kfk#%%fkffkfk#fkfffkkfkff@fkkf%ff%ffkff@kffffffkkff@fk%#fff@f@ffkf:=k%ffkffkfkkffkf@fffk%%k#k#fkkffkk#f@%#k%ffkffkfkkffkf@fffk%k#kff@fkk#
	k#%fkkfk#k#kfk#k#ff%#f%fff@k#f@k#fkfk%kfkfff%f@kf%f@k#fkkffk:=fff@%k#k#fkkffkk#f@%#f%kff@f@fkffkfkffffk%k#%fkf@fkk#fkf@fkfk%kfk
	k#%fkfkk#k#kff@kf%f%k#k#kff@%f@fkff%k#k#kfffkfk#fffk%@fff%kffkfff@k#k#k#kf%f@f@ffk#f@:=f%kff@f@fkffkfkffffk%f@f%k#k#fkkffkk#f@%kff@kfk#fffkk#fkkf
;TRIPLE MESS FRAGMENTS for class: bestcodesection for char: #
	kff%k#ffk#ff%kf%ffkff@kffffffkkff@fk%kfkff@f%fkk#ffkffffkfffkkffkk#k#%kfkffff@:=fkkff%kff@f@fkffkfkffffk%f@f@%fkf@fkk#fkf@fkfk%@k#%fkf@fkk#fkf@fkfk%fkfkf
	f@f%fkf@%k%f@k#k#f@fkfkfkfffk%k%f@fkfkk#kff@fkf@f@kf%fk%k#ffkf%#ff%k#k#kfffkfk#fffk%kfk:=%fkf@fkk#fkf@fkfk%kfkf@k%fkf@fkk#fkf@fkfk%ffk#f@k#kff@ff
	fff%fkf@k#%@%k#kff@kffkk#fkk#f@%@k%fkf@fffkkff@ff%f@fkf@:=fk%k#k#fkkffkk#f@%fkff@%k#k#fkkffkk#f@%#ffk#
	fff%fkffk#ffk#k#f@f@%%k#kff@fk%%kfkfkffk%f%kff@f@k#fkkfkffkkf%ffk#ffk#fff@:=f%k#k#fkkffkk#f@%%fkf@fkk#fkf@fkfk%@fffkkff@ff
	f@f%fff@%kkfk%fkk#ffkffffkfffkkffkk#k#%f%fkf@k#kffkk#fkfffk%k#ffk%kfffffkff@f@k#kf%kfk#f@kf:=fkk#k#f%fkf@fkk#fkf@fkfk%k%fkf@fkk#fkf@fkfk%k#f@fffk
	ff%kfkffkk#f@fff@fkkf%k%f@f@f@ffkffffffkkfff%f%k#ffkf%%fkfkf@%fffkkffk:=fffff%kff@f@fkffkfkffffk%k#kfk#k%ffkffkfkkffkf@fffk%kfff%k#k#fkkffkk#f@%#ff
	ff%kffff@ffk#f@k#k#f@%ff%fff@k#f@k#fkfk%kf%f@fff@kff@f@fkk#kff@f@%fk%fkk#kf%ff%k#fkk#%f:=k#k#fkk%fkf@fkk#fkf@fkfk%fkk%fkf@fkk#fkf@fkfk%k#kfkfk#fk
	%fkf@k#%%k#k#kfffkfk#fffk%@fff@k%k#kffkk#fkfkf@%kffkffk#k#:=fkk#%k#k#fkkffkk#f@%#ffkfk%ffkffkfkkffkf@fffk%f@fffk
	%k#k#fffff@ffk#kf%fkfk%kffkkf%%fkkfff%%kfk#k#f@fkf@fkffk#ffk#k#%f@fffkfffk:=f%k#k#fkkffkk#f@%%fkf@fkk#fkf@fkfk%kf@kfffk#f@k#kff@ff
	f%k#fkk#k#%@f@%kfkfkffk%k#f%f@f@k#kfk#fff@ff%%ffk#ffkfkffkf@f@fff@kf%fffkf:=kfk%fkf@fkk#fkf@fkfk%%fkf@fkk#fkf@fkfk%%kff@f@fkffkfkffffk%k#kff@kffffkk#k#k#
;TRIPLE MESS FRAGMENTS for class: bestcodesection for char: NULL
	fkff%fff@fffk%kfkff@%ffk#ffkfkffkf@f@fff@kf%@f@f@%fkk#ffkffffkfffkkffkk#k#%kff:=f%fkf@fkk#fkf@fkfk%kf
	%k#kfkff@kff@f@ff%f%fkf@k#kffkk#fkfffk%@kf%fkfkf@%f@k#fffkfkfffff@:=k%fkf@fkk#fkf@fkfk%f@f%k#k#fkkffkk#f@%
	fkff%fkf@k#kffkk#fkfffk%%kff@fkffffkfkfk#%fkkf%ffk#ffkfkffkf@f@fff@kf%@fkk%k#kff@fk%fkfff:=k%fkf@fkk#fkf@fkfk%kf%k#k#fkkffkk#f@%f
	%fkk#ff%fffk%k#fff@%%k#f@kffkkfk#kf%@k#%kfffk#fkfkkfffkff@kf%#fkk#kf:=ff%k#k#fkkffkk#f@%ffk
	kf%kfkffkk#f@fff@fkkf%%fkkfff%fk#%fkfkk#k#kff@kf%ffkkfffkff@f@f@k#:=k%fkf@fkk#fkf@fkfk%%k#k#fkkffkk#f@%f%k#k#fkkffkk#f@%#ff
	ff%kfkffkk#f@fff@fkkf%kfkf%kffkfk%kff%k#kff@kffkk#fkk#f@%kkfffffkf:=k%fkf@fkk#fkf@fkfk%%k#k#fkkffkk#f@%#%fkf@fkk#fkf@fkfk%f
	kf%f@fff@kff@f@fkk#kff@f@%f%f@fkf@%f%k#kffff@%@%k#fkkffkfkk#f@fkkfkfffk#%ff%f@f@k#kfk#fff@ff%f@fk:=k%ffkffkfkkffkf@fffk%ffk%fkf@fkk#fkf@fkfk%
	k%k#f@kffkkfk#kf%k#kffff%k#kff@f@%kkfkff%fkffk#ffk#k#f@f@%fkfkf@k#:=ff%k#k#fkkffkk#f@%%ffkffkfkkffkf@fffk%k#
	fk%k#k#fffff@ffk#kf%#f%fkfff@kff@f@fkk#f@f@%f%kff@fk%kk#fkffffk#k#fff@:=%fkf@fkk#fkf@fkfk%ff%fkf@fkk#fkf@fkfk%f@
	f@k%fkfkf@%%kfkfff%fk%ffk#ffkfkffkf@f@fff@kf%f%k#f@kffkkfk#kf%fff@fkf@:=k%fkf@fkk#fkf@fkfk%f%kff@f@fkffkfkffffk%fk
	k%fkfff@%fkf%kffkfffff@f@fkkfff%#k#%fkfffff@k#f@ffkf%kff%fff@%ff:=k#%k#k#fkkffkk#f@%%fkf@fkk#fkf@fkfk%ff
	%fkk#f@%f%ffk#fkf@kff@fkk#ff%k%kfffffkff@f@k#kf%kffkk#k#k#kff@:=%k#k#fkkffkk#f@%%ffkffkfkkffkf@fffk%k#kff@
	f@ff%kffff@ffk#f@k#k#f@%#k%fkkffkkf%#ff%fkk#ffkffffkfffkkffkk#k#%%k#k#fkfkf@fkfff@%f@kffffkk#k#:=ff%fkf@fkk#fkf@fkfk%kkf
	k#fff%f@ffk#%ff@fk%ffk#%kff%fkkfk#k#kfk#k#ff%kf%fkfffffffkk#kfff%@k#:=k%ffkffkfkkffkf@fffk%f%kff@f@fkffkfkffffk%
	k#%k#f@fkff%f@fkf%ffkff@kffffffkkff@fk%f%fkkffkkf%kf%fkffk#ffk#k#f@f@%kfk#k#k#kffkff:=fkf@%fkf@fkk#fkf@fkfk%kfk
	f%kffkfk%ff%kfkfkffk%%kff@fkk#fkf@fkfffkkfk#ff%%ffkff@kffffffkkff@fk%#k#%kfkffkk#f@fff@fkkf%kkfkff@:=fkf%kff@f@fkffkfkffffk%k#
	%fffffff@%%k#fk%f%fkk#ffkffffkfffkkffkk#k#%ff%f@fkfkk#kff@fkf@f@kf%ffk%ffkfkfffkffkk#fkff%@kfkfk#k#:=fk%fkf@fkk#fkf@fkfk%k%fkf@fkk#fkf@fkfk%f
	f@k#%ffkfkfffkffkk#fkff%ffk%kfkfkffk%k#ff%kff@f@k#fkkfkffkkf%#fk:=%k#k#fkkffkk#f@%%ffkffkfkkffkf@fffk%%fkf@fkk#fkf@fkfk%fk#ff
	f@f%kffkfff@k#k#k#kf%kf%fkf@k#kffkk#fkfffk%%fkkfff%fk%f@ffffk#%#fkf@f@fkkf:=kfkf%k#k#fkkffkk#f@%#ff
	f%kfkf%%k#kffkk#fkfkf@%%kfkffkk#f@fff@fkkf%fk%kff@fkk#fkf@fkfffkkfk#ff%kffk%kff@%kfffffkffkkfkf:=k%ffkffkfkkffkf@fffk%%fkf@fkk#fkf@fkfk%%fkf@fkk#fkf@fkfk%kf
	kff%ffkf%%kfffk#k#%%kfffk#ffkfkfkfff%f%fkk#ffkffffkfffkkffkk#k#%f%fkk#fkfkfkfff@fkff%fkkfkff@kf:=f%kff@f@fkffkfkffffk%%fkf@fkk#fkf@fkfk%kf%k#k#fkkffkk#f@%f@
	f%fkkfff%k%k#fkk#k#%k%fkk#ffkffffkfffkkffkk#k#%k#%k#kffkk#fkfkf@%kffk#fkkfkf:=%k#k#fkkffkk#f@%f%fkf@fkk#fkf@fkfk%@
	f@%k#f@f@f@%k#fk%fkfkk#f@%f@f@%f@fkfkk#kff@fkf@f@kf%@%f@fff@kff@f@fkk#kff@f@%fk#k%k#f@kffkkfk#kf%f@:=k%fkf@fkk#fkf@fkfk%%k#k#fkkffkk#f@%#
	kfk%k#kffkk#fkfkf@%k#%kfkfk#ff%%k#kff@kffkk#fkk#f@%ffff%fkfff@kff@f@fkk#f@f@%kfk#fkk#kff@k#:=k#%k#k#fkkffkk#f@%%fkf@fkk#fkf@fkfk%fk
	%k#fk%fkf%fkkfk#k#kfk#k#ff%%fkfkf@%fkk%f@fff@kff@f@fkk#kff@f@%f@%fkfffff@k#f@ffkf%kfffkfkkf:=%fkf@fkk#fkf@fkfk%fk#%k#k#fkkffkk#f@%#
	%f@ffkf%fffk%fkkfk#k#kfk#k#ff%ff@%fkffk#ffk#k#f@f@%ffkf%kffff@ffk#f@k#k#f@%k#%k#kffk%f@fk:=k%ffkffkfkkffkf@fffk%k%ffkffkfkkffkf@fffk%kff@
	%k#fkk#fkk#fff@k#fffffkf@%ff@%k#f@%ff%k#kfk#%f@%kfk#ffk#fkfkff%f%k#kff@kffkk#fkk#f@%kk#kfffkffkf@:=f%kff@f@fkffkfkffffk%%fkf@fkk#fkf@fkfk%@
	kff%fkk#ffkfkfffffk#ffk#ffk#%fkf%k#k#fkfkf@fkfff@%fk%fkk#f@%f%f@fkf@%kf@fkf@fk:=kf%fkf@fkk#fkf@fkfk%%fkf@fkk#fkf@fkfk%kf%k#k#fkkffkk#f@%f
	fk%f@f@kf%f@%k#fkk#fkk#fff@k#fffffkf@%kk#f%f@fkfkk#kff@fkf@f@kf%k#f@kf:=f%kff@f@fkffkfkffffk%kfk%ffkffkfkkffkf@fffk%
	f@kf%k#fkk#ff%f@f@kf%fkk#ffkfkfffffk#ffk#ffk#%%f@fkfkk#kff@fkf@f@kf%f@fkf%ffk#f@ffkfk#ffffkfk#%fkf@ff:=%fkf@fkk#fkf@fkfk%@f%kff@f@fkffkfkffffk%k#
	fkf@%k#fkk#ff%kfk#%fkkfk#k#kfk#k#ff%#f%ffkffkk#f@kfk#ffffkfkf%kf:=fkf%k#k#fkkffkk#f@%k#f@
	fkkf%f@fkfkk#kff@fkf@f@kf%@fff@%k#k#kf%ffk%fffk%#k#f%k#kfkff@kff@f@ff%f@k%f@fkfkk#kff@fkf@f@kf%k#kf:=%fkf@fkk#fkf@fkfk%@fk%fkf@fkk#fkf@fkfk%ffk
	kf%fffk%fffkk%fkffkfk#fkfffkkfkff@fkkf%k#%k#kff@f@%k#kfk%fkf@fffkkff@ff%ffff%fkk#ffkff@fkf@%@kfk#:=f%fkf@fkk#fkf@fkfk%k#%fkf@fkk#fkf@fkfk%@
	ffkfff%ffk#ffkfkffkf@f@fff@kf%@fkf%k#kff@%@kffk%fkfffffffkk#kfff%kk#fff%kfffk#fkfkkfffkff@kf%fk:=k%ffkffkfkkffkf@fffk%fk
	fkfkf@%k#kff@f@%ffkff%fkk#fkfkfkfff@fkff%kff%k#kffkk#fkfkf@%kfkfk#%f@k#k#f@fkfkfkfffk%kk#:=f%k#k#fkkffkk#f@%f%k#k#fkkffkk#f@%f@
	ff%k#k#ffffkff@fk%fkffk%fkfffffffkk#kfff%fffk%f@f@ff%fk#:=f%kff@f@fkffkfkffffk%fk%fkf@fkk#fkf@fkfk%%k#k#fkkffkk#f@%f@
	k#f%fkf@%%ffkffkk#f@kfk#ffffkfkf%f@%fkkfk#f@kfkfkfkf%%ffkfkfffkffkk#fkff%k#k#f@ff:=%fkf@fkk#fkf@fkfk%f%fkf@fkk#fkf@fkfk%kkf
	fkf@%fkk#ffkffffkfffkkffkk#k#%%f@fff@kff@f@fkk#kff@f@%f%kff@%kk%k#f@kffkkfk#kf%k#%kff@fk%fkfffffff@:=k#k%fkf@fkk#fkf@fkfk%ff
	ff%f@ff%f%kffkkf%@%f@fff@kff@f@fkk#kff@f@%@f@%fkfffff@k#f@ffkf%k%fkkfk#f@kfkfkfkf%fk#k#ff:=fkf%k#k#fkkffkk#f@%k#f@
	%ffk#ffkfkffkf@f@fff@kf%%kff@fkk#fkf@fkfffkkfk#ff%kf%kffkkf%f@f@kffkk#ffkff@kf:=kf%fkf@fkk#fkf@fkfk%kkf

;OBF_FUNC name: function_in_bestcodesection
	f%fffk%%k#kffkk#fkfkf@%%fkfffffffkk#kfff%kf%ffkfkfffkffkk#fkff%f@f@fkfk=kfk%f@k#kffkk#k#k#kff@%#%f@fffff@fkkffff@%ff%fkf@kfk#k#f@kf%%ffk#kffff@kffkfffkkffff@%f%f@k#k#fkfkfffkf@fkfffkkfkf%fkk#fk
	%f@fkk#f@%f%fkfffff@k#f@ffkf%fkf%fkfffffffkk#kfff%k#f@k#fk=k%kff@kff@k#fffkfkfffff@%f%ffkffkffkff@f@fff@kfffkf%#kff%ffk#kffff@kffkfffkkffff@%fffkk#fk
;OBF_FUNC name: returnfrom_bestcodesection
	%fff@%k#fk%fffkkfkf%%k#kff@kffkk#fkk#f@%kfk%kfkffkk#f@fff@fkkf%kkfk#fk=k#%f@k#k#k#fff@fkkff@f@fffk%ff%f@fkf@fkffk#k#kffkkffkfkff%%k#fffff@fkkffkkff@k#%k%k#fffff@fkkffkkff@k#%#fkf@
	%fkf@k#kffkk#fkfffk%@k%kfkfkffk%ff@%kfkffkk#f@fff@fkkf%fk#%k#k#fkff%kfffff=k#f%k#f@fkfkfkfkkfk#k#k#kffkff%ff%k#kff@fkfff@fff@f@f@ffk#f@%%f@fkfkffkff@f@f@k#%#%kfffk#kffkkfffkff@f@f@k#%fkf@
;OBF_LABEL name: gosubin_bestcodesection
	f@f@ff%f@f@f@ffkffffffkkfff%%kff@fk%ff%f@fkfkk#kff@fkf@f@kf%f@k#fkffkfk#fkk#fffkfff@=f@kfk#k%fkfff@k#ffkfff%kfk%f@kfkffffffffkfff@f@f@%k#k#%ffffkfkffkkfffffkffkkfkf%fffffff@kffkf@
	f%kffkfffff@f@fkkfff%k%k#k#k#k#k#k#f@f@%ff%f@f@%k#%k#fff@kf%fffkfff@ffk#kfkfffffff=f@kfk%fkfkfkkff@fkfffkfkkf%#kf%k#k#fffkfkk#ffk#%fkf%kfk#kfffk#fff@ffkf%#%k#ffffffkff@f@fff@kff@fkf@%#fffffff@kffkf@

}

 
;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;FUNCTION ORIGINAL NAME: creategui
k#kff@k#k#kffk() { 
	global
	local f@kff@kfkfkffffffkkf, k#ffk#fff@k#fkkf, f@fkfff@fkk#ffkff@, kfkff@kfffffk#ffk#kfkf
;$OBFUSCATOR: $DEFLOSVARS: h1font, h2font, basefont, mymessage

	f%f@fkf@k#fkk#fkf@kf%kff%f@fkf@k#fkk#fkf@kf%kfkf%fffkk#%kfff%fkfkfffk%%k#k#fk%fffkkf 		= % "s22"
	k#f%ffkf%fk%fkffkfk#fkfffkkfkff@fkkf%fff@k%kfkfkf%#fkkf 		= % "s18"	
	f@f%fkf@kfkf%%kffkfffff@f@fkkfff%fff@f%k#k#%kk#ffkff@ 	= % "s14"
	k%ffk#ffkfkffkf@f@fff@kf%kff%k#kfk#%@kfff%k#f@f@f@%ffk#ffk#kfkf := fff%f@f@kf%fkf%kffkfffff@f@fkkfff%f%k#kf%%k#fkk#fkk#fff@k#fffffkf@%kfk("ddbfa495f4b5e3d60405d393bfd54375c38544e3bf75a3c613")

	gui 2:default
	gui, destroy
	gui, margin, 20, 20
	
	;the h1font variable below should be obfuscated
	gui, font, %k#ffk#%%f@f@ff%%f@kff@kfkfkffffffkkf% bold
	gui, add, text, xm ym, Obfuscator Test GUI
	
	gui, font, %fkk#f@%%f@fkfff@fkk#ffkff@%%fkkf% norm underline
	;the gosub label below should be obfuscated
	gui, add, text, xm y+12 cblue Gf%kff@kff@k#fffkfkfffff@%@k%fff@fff@kffkk#kfffkffkf@%fk%f@fff@kfkffkffk#k#%%kfk#kfffk#fff@ffkf%fkfkfk#k#fffffff@kffkf@, CALL GOSUB IN '_bestcodesection'
	
	gui, font, %f@fkfff@fkk#ffkff@%%k#k#fkff%%k#fff@kf% norm
	gui, add, text, xm y+12 Gkfkf%k#ffk#ff%f%k#k#fkf@kfk#f@f@f@kfk#%fffkf%ffkff@%kk#k#f%fkk#ffkffffkfffkkffkk#k#%f@fff@,
(
hello world

TESTING LITERAL STRING OBFUSCATION:
"%f@fkfkf@%%kfkff@kfffffk#ffk#kfkf%%ffk#%"

-press home key to test hotkeys-
)
	gui, add, text, xm y+12, enter something here to test`nvariable obfuscation
;$OBFUSCATOR: $DEFGLOBVARS: usermessage
	gui, add, edit, xm y+2 V%fkf@kfkf%%f@fkkf%%fkfkff% r4, 
		
	gui, add, button, xm y+20 Gk#fff%fff@%%k#fkk#k#%@kf%fkkffkkf%kfk%fkkffffkfkfkk#kfffk#%ffk%k#kff@kffkk#fkk#f@%kfffk#kfk#k#kffffff@kfk#kf, Test gui submit
	gui, add, button, x+20 yp Gf@%fkfkf@%k#%fkkffkkf%kf%k#kff@kffkk#fkk#f@%%k#kffk%%k#fkkffkfkk#f@fkkfkfffk#%fkfkk#kff@f@k#f@f@fkkf, Cancel program
	gui, show
}


;LABEL ORIGINAL NAME: testguisubmit
k#fff@kfkfk#ffkfkfffk#kfk#k#kffffff@kfk#kf:
	gui, submit, nohide
	msgbox, TESTING OBF OF Vvariablename IN 'gui, add':`n`nyou entered "%k#k#fk%%kfk#%%fffkfkf@%"
return


;LABEL ORIGINAL NAME: cancelprog
f@k#kffffkfkk#kff@f@k#f@f@fkkf:
	exitapp
return


;LABEL ORIGINAL NAME: guigosub
kfkffkfffkfkk#k#fff@fff@:
	msgbox, inside _guigosub_
return

;HOTKEYS SHOULD NOT BE OBFUSCATED!
;HOTKEY ORIGINAL NAME: home
home::
	msgbox, home key pressed!
return


;HOTKEY ORIGINAL NAME: RControl & RShift
RControl & RShift::
	msgbox, hello dave
	fkf%ffkff@k#kfk#ffk#kffkf@kf%%fkkfk#k#kfk#k#ff%fk%kfffk#k#%fk%k#k#kf%#k%k#fkf@%#f@fk()
return


;HOTKEY ORIGINAL NAME: ^;
^;::
	msgbox, hello world
	f%f@f@ffk#%kf@k%k#f@kffkkfk#kf%kfk#%fffffff@%k#f@%k#kffff@%fk()
return	

;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;(technically this one would be all right because it does not call any
;functions or use any variables inside of it)
;FUNCTION ORIGINAL NAME: testfunction
fkf@kfkfk#k#f@fk() { 
	global
	msgbox, TESTING OBF OF A FUNCTION CALL:`n`ntestfunction has been called
}


;SKIPPED MOVING function: 'ihidestr()' to OBF CODE

;put this function in your source code. it will actually be called
;by the obfuscated code to 'decode' the obfuscated strings.
;this function and all calls to it will also be obfuscated in
;the output obfuscated program
;FUNCTION ORIGINAL NAME: decode_ihidestr
ffffkfkffkfk(k#kff@ffkfk#fk) {  
	global	
;$OBFUSCATOR: $DEFGLOBVARS: hexdigits
	
	static ffkfffk#kffkff, fkk#kffff@f@k#, fkkfk#f@k#kfk#kfk#, f@fkffkfkfk#fk, ffk#fff@kfkfk#, fkfffkffffk#ffk#fkkfkf
;$OBFUSCATOR: $DEFLOSVARS: newstr, startstrlen, charnum, hinibble, lownibble, mybinary

	fk%fff@%ff%k#f@f@f@%%fkkfk#f@kfkfkfkf%#k%fkffkfk#fkfffkkfkff@fkkf%f@ = % "0123456789abcdef"
		
	;will get the encoded key hidden in the obfuscated literal string
	%fff@%%f@ffk#kfkff@fk%%f@f@fkfk%(k#kf%f@f@fkfk%f@ff%k#ffk#%%kffkfffff@f@fkkfff%fk#fk)
	
	;grab encoded data
	k%fkffkfk#fkfffkkfkff@fkkf%k%fkf@k#kffkk#fkfffk%f%kffkkf%@f%fkfkkf%%fffkk#%fkfk#fk = % %f@fkfkf@%%k#kff@%%kffkf@kffkfkk#%%k#ffffk#f@kfkf%%f@f@kf%%fkf@kfkf%(%k#ffkf%k%k#k#fkkffkkfk#kfkfk#fk%kff%fkf@kf%@f%kfkfkf%fkfk#fk, 1, 1) . %f@fff@f@kfkfk#%%ffk#%%k#kff@fk%%kfk#ff%%kff@f@fff@ffk#ff%%fffffff@%(k#%kffff@ffk#f@k#k#f@%%kffk%ff%fkk#%%fff@k#f@k#fkfk%f%f@ffffk#%fkfk#fk, 6)
	f%kffff@ffk#f@k#k#f@%k#k%k#fkf@%fff%fkf@fkfk%f@%kfkfk#%f@k# = % %kff@%%k#kff@k#kffkff%%ffk#k#%%ffk#k#%%k#kffk%%kfk#kfffk#k#fk%(k#%fkkffff@f@k#k#fkf@%ff%kfffk#ffkfkfkfff%ffk%f@f@%fk%k#f@f@f@%#fk)
		
	%kff@fkffffkfkfk#%fk%k#kffkk#fkfkf@%ffk%kff@f@%#%k#ffk#%kffkff = 
	;reverse the hex string
	loop, % %k#k#kff@%%fkk#%%k#kfffffk#k#%%f@f@fkfk%%kfk#kffkfkkfffff%%fkf@kfkf%(k%f@kfk#kff@k#kff@f@kfffff%k%kfkffkk#f@fff@fkkf%f%f@kf%@f%kff@f@%%k#k#kf%fkfk#fk) 
		%fffkfkfffffkk#kff@k#%%k#k#fkff%%ffk#% = % %kff@ffkfk#fkffff%%k#fff@%%f@k#k#%%fff@fffk%%ffffkffkf@f@kffk%%ffk#k#%(%kfkfkf%k#kf%ffk#f@%f@f%kfkffkk#f@fff@fkkf%kfk#fk, a_index, 1) . f%ffk#k#%f%kfk#ffk#fkfkff%f%f@ffkf%ff%fkf@%k#%kfffk#fkfkkfffkff@kf%ffkff
	
	k#k%kff@fkk#fkf@fkfffkkfk#ff%f%ffk#k#%@ff%f@f@k#kfk#fff@ff%fk%kfk#fkkf%#fk = % %fffkfkfffffkk#kff@k#%%f@f@ffk#%%fffff@%
	ff%k#k#fffff@ffk#kf%%k#fk%%ffkf%f%f@ffkf%ffk#kffkff = 
	fkkf%k#ffkf%%k#fk%k#%fkf@k#kffkk#fkfffk%@k#%f@fkfffk%kfk#kfk# = 1
	;convert from hexidecimal to binary	
	while true
	{
		if (%k#ffkf%%kff@fkk#fkf@fkfffkkfk#ff%kk%k#fkk#fkk#fff@k#fffffkf@%k#f%f@f@fkfk%@k#%kfk#%kfk#kfk# >f%kffff@ffk#f@k#k#f@%k%k#fff@%#k%kfk#fkkf%ffff@f@k#)
			break
			
		%kfk#%%fkf@fff@kff@fkk#fkkfk#ffk#%%f@fkfffk% = % %kfk#ff%%f@f@fkk#kfk#fkf@%%fff@%%f@ffffk#%%f@kfk#%%ffffk#kff@fkfkfk%(k%f@kfk#kff@k#kff@f@kfffff%%k#kfkff@kff@f@ff%f%f@f@fkfk%%ffkfkf%f@%k#kff@f@%ffkfk#fk, %k#f@fkk#%%fff@fkkfkfk#ffffkfk#%%k#f@fkk#%, 1)
		;find it in hexdigits and convert to decimal number
		%f@f@%f%ffffk#ffkfk#kfk#k#fk%%k#kff@kffkk#fkk#f@%%fkf@k#%kf%kff@f@%fkfkfk#fk = % %fkkfffkffkkf%%k#kf%%f@fkfkf@%%f@f@fkfk%%f@fkf@k#kfffk#%%k#kfff%(%ffkfffkfffk#%%k#k#kf%%fff@fffk%, f%fkf@kfkf%@%ffkfkfffkffkk#fkff%kf%kfkff@%f%kfk#%kfkfk#fk) - 1
		
		f%ffkfkf%%ffk#f@%f%fkfkk#k#kff@kf%#f%fffkkfkf%ff@kfkfk# = % %k#kff@f@%%f@f@ffk#%%kffkf@kffkfkk#%%kff@%%ffkfkf%%k#ffffk#f@kfkf%(k#%fkkfk#k#kfk#k#ff%ff%k#f@%%f@f@%@ff%kfkfkf%kfk#fk, fkk%fkk#%fk#f%fff@k#f@k#fkfk%k#kf%ffkf%k#kfk# + 1, 1)
		;find it in hexdigits and convert to decimal number
		ff%kff@fk%k#ff%fkkffkkf%f%kffkkfffk#kfk#f@fk%kfkfk# = % %kfk#%%fkf@fff@%%f@k#fffffffkkf%%k#kffff@%%fkf@f@%%fkf@fkf@kffk%(f%k#kffff@%kf%k#fkk#k#%f%ffkff@%k%fkk#k#ffkfk#f@fffk%k#%f@k#k#f@fkfkfkfffk%@, %ffkff@%%f@f@fff@f@ffkffk%%kfkfkffk%) - 1
		
		;unshift the hex
		%ffk#ffkfkffkf@f@fff@kf%@%k#fkkffkfkk#f@fkkfkfffk#%k%fkfkk#f@%%k#fff@kf%f%kffkfk%fkfkfk#fk := %kfk#fkkf%f%fffkkfk#kffffkk#kfk#ff%k#%kff@f@%kf%k#f@kffkkfk#kf%f%f@f@ffk#%kff@f@(f@f%fkfkk#k#kff@kf%%k#k#kf%ff%kffkfk%kfkfk#fk)
		ffk%fkfkf@kfffk#f@k#kff@ff%fff%fkf@kfkf%@kf%fffffff@%k%k#k#kf%fk# := %kfkfkf%f%f@fkf@k#fkk#fkf@kf%%fkfkk#f@%k%f@fkk#f@%#k%k#kffkk#fkfkf@%ffkff@f@(ffk%k#kfff%%k#kfk#%%fkffkfk#fkfffkkfkff@fkkf%f%k#k#kff@%ff@kfkfk#)
		
		%kff@%%fffkkf%%fkkffkkfk#fff@f@fffkff% = % %k#fkk#fkk#fff@k#fffffkf@%@%f@kf%%fffkk#%fkf%k#k#kfffkfk#fffk%kfkfk#fk * 16 + f%fkkfff%fk%f@k#k#%#f%f@fkfkk#kff@fkf@f@kf%f%fkf@k#%@%kffff@ffk#f@k#k#f@%fkfk#
		%f@f@ff%%ffkf%%fffkfkfffffkk#kff@k#% .= %kfffk#kfkfff%%kff@f@%%fkf@f@%%fkf@ffkfffk#fff@%%fkk#kf%%k#f@fkff%(f%kffff@ffk#f@k#k#f@%fffk%fff@fffk%ffff%k#kfkff@kff@f@ff%#%ffkff@%ffk#fkkfkf)
		
		%fkk#ff%%fff@fkkfkfk#ffffkfk#%%f@fkk#f@% += 2		
	}
		
	f%f@k#k#f@fkfkfkfffk%kfff%k#ffk#%k#k%f@kf%ffkff = % k%fkf@k#kffkk#fkfffk%%kfkfk#%f%ffkf%@k%k#kffkk#fkfkf@%ffk#fkf@(ffk%k#k#kf%fff%kff@f@k#fkkfkffkkf%#%k#k#%%kffff@ffk#f@k#k#f@%ffkff)
		
	return, f%ffkfkfffkffkk#fkff%k%ffffff%fff%k#k#fk%%f@fkfffk%k#kffkff	
}


;FUNCTION ORIGINAL NAME: decode_hexshiftkeys
k#ffk#kffkfkk#f@(f@kff@k#fkf@ffk#) { 
	global
;$OBFUSCATOR: $DEFGLOBVARS: decodekey, ishexchar, useshiftkey
	
	;these have '1's in them
	k%kfk#fkkf%#%fff@fffk%f%k#kffkk#fkfkf@%kf%fkk#ffkff@fkf@%@k# := "fff@kkf1ffkfkfkfff#k1fk@kf#@fffk@#kk"
	%kfk#k#%%fff@ffkfk#%%k#kff@f@% := "fff@f1ff@kffkk#f1fffffkf"
	
	;grab randomly created encrypt key
	;i hid it in the obfuscated literal string, 2 characters in
	%k#ffkff@k#%%fkk#%%k#kfk#%%k#ffk#ff%%k#fkfkkfk#%%k#k#kf%1 = % %k#fff@%%k#kff@fk%%f@fff@f@kfkfk#%%k#kf%%kff@f@fff@ffk#ff%%fkf@fff@%(f@%kffkkf%kff@k%fkf@fffkkff@ff%fk%fffff@%f@ffk#, 2, 1)
	%k#ffkff@k#%%f@ffkf%%fkkffkff%%kfkfk#ff%%k#fkfkkfk#%%fff@fffk%2 = % %kff@ffkfk#fkffff%%fffkkf%%f@f@fkfk%%ffffkffkf@f@kffk%%f@f@fkfk%%fkfkk#f@%(f@%kfffk#fkfkkfffkff@kf%ff%fkfkk#f@%@k%kfkfk#ff%#fkf@ffk#, 3, 1)
	%f@fkfffk%%k#ffkff@k#%%k#f@f@f@%%k#k#kf%%k#fkfkkfk#%%f@f@%3 = % %fkf@kfkf%%fkf@k#%%f@f@fkk#kfk#fkf@%%ffk#%%ffffk#kff@fkfkfk%%k#k#kff@%(f%fkf@k#%@kff%fkk#ff%@%kffff@ffk#f@k#k#f@%#fkf@ffk#, 4, 1)
	%k#fff@%%k#ffkff@k#%%ffkffk%%f@f@kf%%k#fkfkkfk#%%kff@%4 = % %kffkf@kffkfkk#%%kfkfk#ff%%k#fff@kf%%fkkf%%k#kffk%%k#ffffk#f@kfkf%(f@kff%k#fkk#k#%@k#fk%fkfffff@k#f@ffkf%@ffk#, 5, 1)
	
	;covert key values to actual numbers
	loop, 4
		%k#ffkff@k#%%kfkf%%f@f@fkfk%%a_index% = % %fkfkk#f@%%fkf@fffkkffff@f@%%fkfkk#f@%%fkf@kf%%f@fff@k#fkff%%kfffkfkf%(%ffkfkfffkffkk#fkff%k%k#f@f@f@%ff%fkfkf@%k%fkk#k#ffkfk#f@fffk%k#f@, %f@ffk#%%k#ffkff@k#%%k#k#fk%%kfkfk#ff%%ffk#k#%%k#fkfkkfk#%%a_index%) - 1
			
	%kffff@ffk#f@k#k#f@%#f%kfkfkffk%%k#kffk%@f%kff@%@ffff = 0
}	


;FUNCTION ORIGINAL NAME: decode_shifthexdigit
f@k#kfffkff@f@(f@fkffffk#f@f@) { 
	global
	
	;each time i enter this routine i will use the next key value
	;to shift the hexvalue
	k#%ffk#f@%f@%f@fkfkk#kff@fkf@f@kf%@f%ffk#f@%ff%k#kffff@%f++
	if (k#%k#k#kfffkfk#fffk%%fkfkkfk#kffff@kffk%%k#kfff%%fkkffkkf%f%f@ffffk#%@ffff > 4)
		k#%fkkffkff%%fkk#ffkff@fkf@%%fkkf%@f%kfk#ff%@ffff = 1	
	
	;subtract the shift key from the hexvalue 
	f@f%kff@k#f@f@fffkk#%ffff%f@fkf@%k%fkf@%#f@f@ -= %k#ffkff@k#%%fffkkfkf%%k#fkk#%%f@f@fkfk%%k#f@f@ffff%%kfk#%
	
	;if i go under zero, just add 16
	if (f%kfffk#ffkfkfkfff%f%fkffk#ffk#k#f@f@%fff%k#k#kff@%fk%fkfff@%#f@f@ < 0) 
		%fkkfff%f%k#k#k#k#kff@fkk#%fk%kfkffkk#f@fff@fkkf%%fffff@%f%fkfkff%ffk#f@f@ += 16
		
	return %k#fff@%%fkk#ffkfffk#kff@fffffkkf%%kfkfk#%	
}


;FUNCTION ORIGINAL NAME: fixescapes
kff@kfffk#fkf@(fkk#k#fff@f@) { 
	global
	
	StringReplace, fk%k#kfk#%k#%f@f@k#%k#%kfkf%fff%ffk#f@ffkfk#ffffkfk#%f@, %fkk#ffkff@fkf@%%fkfkk#f@%k%f@fkfffk%k#k%ffk#f@%#fff@f@, % "````", % "``", all
	StringReplace, fkk%fkkf%#%kff@fk%k#f%kfkffkk#f@fff@fkkf%f%kfffk#ffkfkfkfff%f@, %fff@fffk%%k#fkk#%%ffk#f@ffkfk#kffff@k#k#k#f@%, % "``n", % "`n", all
	StringReplace, %k#fkf@%%k#f@fkfkkfk#f@kffff@ffk#%%k#ffkf%, f%kfkfkffk%k%kfk#ffk#fkfkff%#%k#f@fkk#%k#f%k#fkk#fkk#fff@k#fffffkf@%f@f@, % "``r", % "`r", all
	StringReplace, %kfkfk#%fk%fkkfk#k#kfk#k#ff%#%fkk#ffkfkfffffk#ffk#ffk#%#%f@f@%ff%fkk#kf%f@f@, %kfk#%%ffk#f@ffkfk#kffff@k#k#k#f@%%kfkfk#ff%, % "``,", % "`,", all
	StringReplace, %k#fff@kf%f%kff@k#f@f@fffkk#%k#%kffkkf%%fkf@fkfk%k#%f@k#k#f@fkfkfkfffk%ff@f@, %fkkf%%kfkf%fkk%fkkffkkf%%fkk#k#ffkfk#f@fffk%k#fff@f@, % "``%", % "`%", all	
	StringReplace, fkk%kffffkkffffffkf@ffkffk%k%fkf@fffkkff@ff%fff%fff@fffk%@f@, f%fkffk#ffk#k#f@f@%k#%fkfkk#k#kff@kf%#f%fkfkk#f@%ff%f@fkfffk%@f%k#fkk#k#%@, % "``;", % "`;", all	
	StringReplace, %k#f@kffkkfk#kf%k%k#kff@%k#%k#k#%k#f%fkk#ffkff@fkf@%f@f@, fk%kff@k#f@f@fffkk#%#k%fkf@kf%%fffkk#%#f%ffk#ffkfkffkf@f@fff@kf%%fkf@k#%f@f@, % "``t", % "`t", all
	StringReplace, fkk%fffff@k#kfk#k#kfffk#ff%%kfk#fkkf%k#%kfk#fkkf%ff%fkfkfffk%f@f@, %f@k#k#f@fkfkfkfffk%kk%kffffkkffffffkf@ffkffk%k#%fffff@%%k#fkk#ff%f%kfk#%ff@f@, % "``b", % "`b", all
	StringReplace, f%fkffk#ffk#k#f@f@%%k#k#fkf@kfk#f@f@f@kfk#%#%k#k#kff@%k%fff@fffk%#fff@f@, %f@fkf@%fk%f@fkk#f@%k#k%fkfkf@kfffk#f@k#kff@ff%f%k#fff@%ff@f@, % "``v", % "`v", all
	StringReplace, fk%kfk#ffk#fkfkff%#k%fkkfkff@k#ffk#%f%k#k#fk%ff@%f@fkf@%f@, %k#k#kfffkfk#fffk%k%kfffkfkf%k#%kff@f@%k%fkkff@f@f@f@k#ffkfkf%ff%k#k#%f@f@, % "``a", % "`a", all
	
	StringReplace, f%fkk#ff%kk#%f@f@f@ffkffffffkkfff%#ff%k#fkk#%f@f%ffk#fkf@kff@fkk#ff%, %ffk#f@ffkfk#kffff@k#k#k#f@%%k#kfff%%fkkfff%, % """""", % """", all
	
	return fkk%ffk#kff@kfk#fffkkf%k#f%ffk#%%ffk#%ff@f@
}

