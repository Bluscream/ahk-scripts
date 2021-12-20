obf_copyright := " Date: 14:08 mercredi 12 juillet 2017           "
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
;of your program is enough set the obfuscator to do dynamic obfuscation
  
;put a string assignment header like this in your program so that
;the program name and copyright info still shows up in the obfuscated ;version of this program
program_name:="MY PROGRAM NAME"
program_name:="Author: MY NAME"
program_name:="Copyright MY NAME, YEAR"

;YOU MUST ALREADY BE USING DYNAMIC OBFUSCATION IN ORDER TO
;USE THE REWIRE FUNCTION ABILITY OF THIS OBFUSCATOR
;SO THE MINIMUM DUMP STATEMENTS YOU WILL NEED TO USE ARE SHOWN BELOW

;these are the minimum DUMP statements you need to use when using
;dynamic obfuscation. none of these would be required
;for 'straight' obfuscation
;ALL FUNCTIONS MUST BE MADE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!

;security fragments and triple mess fragments for common objects
;must be dumped before anything else
	;SECURITY CLASS FRAG: for class: COMMON for char: f
	k#k%k#f@fk%fk%fkkfffff%#fk%fkk#fk%fk%ffkfff%ffffff=%ffk#k#f@%f%fkfkk#%
	;SECURITY CLASS FRAG: for class: COMMON for char: k
	f%k#ffk#%kff%ffkffk%%fff@fkff%fkk#fkfff@fkf@kf=%f@k#f@k#%k%fkfkf@%
	;SECURITY CLASS FRAG: for class: COMMON for char: @
	k#ffkf%ffk#%ffff%f@ff%kfkfkf%f@k#k#fk%f@f@=%k#fkkff@%@%ffkffk%
	;SECURITY CLASS FRAG: for class: COMMON for char: #
	kffk%fff@fkff%f%fffkk#fk%ffkf@f@%k#fkk#ff%fkfkkfk#k#k#=%fkfkfff@%#%k#ffff%

;TRIPLE MESS FRAGMENTS FOR: f
	f%fkfffkk#fkfff@fkf@kf%ffkf%k#kfk#fkfkffffff%ffk%f@fkfk%%fffffk%f@fkk#ffk#f@kf:=%fkfffkk#fkfff@fkf@kf%#k%ffk#k#f@%f%fkfffkk#fkfff@fkf@kf%#fk%kfkfk#k#%fkffffff
	f@k%kffkfffkf@f@fkfkkfk#k#k#%f%k#fk%@f@%fkfffkk#fkfff@fkf@kf%ff%k#kfk#fkfkffffff%ffkffkkffk:=k#%fkfkkff@%kfk#%k#kfk#fkfkffffff%kfk%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%ffff
	fk%fkfffkk#fkfff@fkf@kf%fk#%k#kfk#fkfkffffff%%k#ffkfffffkfkfkff@f@%f%fffkk#fk%kfkf@:=k#%k#k#%kf%fkfffkk#fkfff@fkf@kf%#%k#kfk#fkfkffffff%kfkffffff
	k#%k#kfk#fkfkffffff%fffk%k#kfk#fkfkffffff%ffkf%k#ffkfff%fkf%kfffk#f@%kfkff:=k#kf%f@k#f@k#%k%kffkfffkf@f@fkfkkfk#k#k#%fkfk%k#kfk#fkfkffffff%fff%k#kfk#fkfkffffff%f
	k#f%fkff%%fkfffkk#fkfff@fkf@kf%%fkfffkk#fkfff@fkf@kf%#%k#kfk#fkfkffffff%fk#fff@:=k#k%k#kfk#fkfkffffff%k#%k#kfk#fkfkffffff%kf%fkfffkk#fkfff@fkf@kf%ff%f@fkk#ff%ff%fff@fkff%ff
	ff%k#kfk#fkfkffffff%%fkfffkk#fkfff@fkf@kf%kff%k#kfk#fkfkffffff%k#kf%k#fk%f%f@kfk#f@%fk#k#kffk:=k#kf%fkfkk#%k#%k#kfk#fkfkffffff%kfkff%k#kfk#fkfkffffff%fff
	fkfkfk%k#kfk#fkfkffffff%@%fkfffkk#fkfff@fkf@kf%ff@k%ffkfkf%#kffkfk:=k%f@fkfffk%#k%ffffkfk#%%k#kfk#fkfkffffff%k%kffkfffkf@f@fkfkkfk#k#k#%fk%k#kfk#fkfkffffff%kffffff
	fkkf%fkk#ffff%f@%fkk#ffff%f%k#ffkfffffkfkfkff@f@%%fkfffkk#fkfff@fkf@kf%#f@%fkfffkk#fkfff@fkf@kf%#k#f@kf:=k#k%k#kfk#fkfkffffff%k#fkf%ffkff@%%fkfffkk#fkfff@fkf@kf%ffffff
	f@f%k#ffkfffffkfkfkff@f@%k#%k#kfk#fkfkffffff%@fkfk%k#k#f@%k%fkk#kfff%ffkf@kf:=k%kffkfffkf@f@fkfkkfk#k#k#%kfk%kfffk#ff%#fk%k#kfk#fkfkffffff%%f@fkk#k#%%fkfffkk#fkfff@fkf@kf%ffffff
	fkkf%f@fkfk%kffkk%kffkfffkf@f@fkfkkfk#k#k#%kfkf%fkfffkk#fkfff@fkf@kf%ff@ff:=k#%f@k#ffk#%kfk#f%fkfffkk#fkfff@fkf@kf%fkff%k#kfk#fkfkffffff%fff
	f%fkfffkk#fkfff@fkf@kf%kfk%k#kfk#fkfkffffff%kfkf%fkfk%fff@%f@k#ffk#%fkf%fkfffkk#fkfff@fkf@kf%ffk#:=k#kf%kfk#%k#fkf%fkfffkk#fkfff@fkf@kf%ffff%k#kfk#fkfkffffff%f
	f@%kfkf%f%fkfffkk#fkfff@fkf@kf%fkf@k#%k#kfk#fkfkffffff%@fkfk%k#kfk#fkfkffffff%kkffkf@:=k#k%k#ffff%fk#%k#kfk#fkfkffffff%%fkfffkk#fkfff@fkf@kf%fk%k#kfk#fkfkffffff%fffff
	fk%k#kfk#fkfkffffff%ffkf%k#ffkfffffkfkfkff@f@%k#f%ffffkfk#%kk#k#:=k%k#k#kffk%%kffkfffkf@f@fkfkkfk#k#k#%kfk#%k#kfk#fkfkffffff%kf%fkfffkk#fkfff@fkf@kf%ffffff
	kf%fkfffkk#fkfff@fkf@kf%%kffkfffkf@f@fkfkkfk#k#k#%k#%fffffk%k%f@kffkff%fkff@fkf@:=k%kffkfffkf@f@fkfkkfk#k#k#%k%k#kfk#fkfkffffff%k%k#k#f@fk%#f%fkfffkk#fkfff@fkf@kf%fkffffff
	k#k%f@f@fff@%#kfk%k#kfk#fkfkffffff%kff%k#ffkfffffkfkfkff@f@%fffkf%fkfffkk#fkfff@fkf@kf%fkk#:=k#k%k#kfk#fkfkffffff%k%kffkfffkf@f@fkfkkfk#k#k#%f%fkfffkk#fkfff@fkf@kf%%kfk#%fkffffff
	ff%k#kfk#fkfkffffff%kfkf%k#fkk#ff%kfff%k#ffkfffffkfkfkff@f@%ffkf%fkff%f%k#ffkfffffkfkfkff@f@%kfffff:=k%kffkfffkf@f@fkfkkfk#k#k#%kfk#%fffkk#fk%fkfkf%k#kfk#fkfkffffff%ffff
	kf%fkfffkk#fkfff@fkf@kf%#k#f%k#kfk#fkfkffffff%f@k%fkkfffff%%f@fff@f@%#%k#kfk#fkfkffffff%kfffkf@kf:=k#k%k#fkk#%fk#fk%k#kfk#fkfkffffff%kff%k#kfk#fkfkffffff%fff
	kf%fkkfffff%%k#kfk#fkfkffffff%%k#ffkfffffkfkfkff@f@%k%k#kfk#fkfkffffff%%f@kffkff%k#kfk#kfff:=k#%kffkf@fk%kfk#%k#kfk#fkfkffffff%kf%fkfffkk#fkfff@fkf@kf%ffffff
	fffkf%k#kfk#fkfkffffff%f%fkfffkk#fkfff@fkf@kf%f@k%ffkfff%ffk%ffffkf%ffk#f@:=k%fkkfkf%#kf%fkfffkk#fkfff@fkf@kf%#f%fkfffkk#fkfff@fkf@kf%fk%f@f@fff@%ff%k#kfk#fkfkffffff%fff
	%ffkff@%fkf%k#kfk#fkfkffffff%fkk#%k#kfk#fkfkffffff%%k#ffkfffffkfkfkff@f@%f@k#f@fffk:=k#k%k#kfk#fkfkffffff%k#fkf%fkkfkf%%fkfffkk#fkfff@fkf@kf%ffffff
;TRIPLE MESS FRAGMENTS FOR: k
	ff%fkfffkk#fkfff@fkf@kf%fk%kffkfffkf@f@fkfkkfk#k#k#%k#ffk#%fkfffkk#fkfff@fkf@kf%#%fffkf@k#%f@k#f@kfff:=fkf%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%%fkffffkf%kk#%kfk#%fk%k#kfk#fkfkffffff%ff@fkf@kf
	k%k#kfk#fkfkffffff%f%k#ffkfffffkfkfkff@f@%k%k#ff%fff%k#k#f@fk%kffffff@kffkfkff:=%k#kfk#fkfkffffff%kf%f@k#k#fk%ffkk%f@kfk#%%kffkfffkf@f@fkfkkfk#k#k#%fkfff@fkf@kf
	kf%kfkfk#k#%f%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%ff%f@kfff%@k%kffkfffkf@f@fkfkkfk#k#k#%kfkf:=fkfff%fkfffkk#fkfff@fkf@kf%%f@fkfffk%k#%k#kfk#fkfkffffff%kfff@fkf@kf
	%fkfffkk#fkfff@fkf@kf%ff%k#kfk#fkfkffffff%k#%k#kfk#fkfkffffff%@fk%f@k#f@k#%fkk#kffkk#fk:=fkff%ffkffkk#%%k#kfk#fkfkffffff%kk%kffkfffkf@f@fkfkkfk#k#k#%fkfff%k#ffkfffffkfkfkff@f@%fkf@kf
	kff%fkfffkk#fkfff@fkf@kf%fk%k#kfk#fkfkffffff%@f%fffkfkf@%ff@fk:=fkfff%fkfffkk#fkfff@fkf@kf%k#fk%k#kfk#fkfkffffff%ff%fkkfkf%@fkf@kf
	%k#fk%%k#kfk#fkfkffffff%%fff@fkff%ff@%fkfffkk#fkfff@fkf@kf%#fkk#f@fk:=fk%fkf@kff@%ff%k#kfk#fkfkffffff%kk#f%fkfffkk#fkfff@fkf@kf%fff@fkf@kf
	fff@%k#kfk#fkfkffffff%@fff%k#k#f@fk%@fkf%f@k#k#fk%kk%kffkfffkf@f@fkfkkfk#k#k#%f%fkfffkk#fkfff@fkf@kf%kff@:=%k#kfk#fkfkffffff%%kfkffk%k%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%fkk#fkfff@fkf@kf
	k#fff%k#ffkfffffkfkfkff@f@%k%kffkfffkf@f@fkfkkfk#k#k#%k#kf%ffkffk%kffkkf:=fkfff%fkfffkk#fkfff@fkf@kf%k#fkf%k#kfk#fkfkffffff%f@fkf@%kfkf%kf
	k#%k#kfk#fkfkffffff%%ffk#k#f@%%kffffkk#%k%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%fff@f@fk:=fkff%ffkfkff@%fkk%ffk#kfff%#fk%k#kfk#fkfkffffff%ff@%k#kfk#fkfkffffff%%fkfffkk#fkfff@fkf@kf%f@kf
	ffk#%k#kfk#fkfkffffff%ffff@f%f@f@fff@%kffkf%k#kfk#fkfkffffff%kk#fff@:=fkf%fkk#kfff%f%k#kfk#fkfkffffff%kk%kffkfffkf@f@fkfkkfk#k#k#%fkfff@fkf@kf
	kff%k#kfk#fkfkffffff%k%fff@fkff%fk%k#kfk#fkfkffffff%k#ffk%ffk#fkf@%#f@k#f@:=%k#kfk#fkfkffffff%kf%k#kfk#fkfkffffff%fkk#%f@kfff%fkff%k#kfk#fkfkffffff%@fk%kfffff%f@kf
	%k#fkkf%k#k%kffkfffkf@f@fkfkkfk#k#k#%k#f%f@fkk#ff%k%k#kfk#fkfkffffff%@fkfkk#fk:=fkff%k#fkk#%%k#kfk#fkfkffffff%%fkfffkk#fkfff@fkf@kf%k#f%fkfffkk#fkfff@fkf@kf%fff%k#k#ff%@fkf@kf
	f@f%f@k#fk%%fff@fkff%@%k#kfk#fkfkffffff%fk%k#kfk#fkfkffffff%%fkfffkk#fkfff@fkf@kf%#ffkffkk#kff@:=fkff%ffkfffk#%%k#kfk#fkfkffffff%k%fkfffkk#fkfff@fkf@kf%%kffkfffkf@f@fkfkkfk#k#k#%fkfff@fkf@kf
	fk%k#kfk#fkfkffffff%f%fkfffkk#fkfff@fkf@kf%#ffk#%kfffff%fff@f%k#kfk#fkfkffffff%kfffk#k#:=fkff%f@fff@f@%fkk#%k#kfk#fkfkffffff%kfff%k#ffkfffffkfkfkff@f@%fkf%k#k#kf%@kf
	%ffkfff%f@f%k#ff%@f%fkfffkk#fkfff@fkf@kf%ff%fkfffkk#fkfff@fkf@kf%ffkkffk:=fk%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%fkk#f%fkfffkk#fkfff@fkf@kf%fff%k#fkk#%@fkf@kf
	k#%k#k#kf%k#%k#f@ffkf%k#f%k#kfk#fkfkffffff%fkf%k#ffkfffffkfkfkff@f@%fkk#%fkfffkk#fkfff@fkf@kf%ffkf@f@:=fkff%fkf@kff@%fkk%fffkk#fk%%kffkfffkf@f@fkfkkfk#k#k#%fkff%k#kfk#fkfkffffff%@fk%k#kfk#fkfkffffff%@kf
	kffffk%fkfffkk#fkfff@fkf@kf%ffk%k#kfk#fkfkffffff%@fkk%fkk#%ff@k%k#fkkff@%fkffk:=fk%fkff%%k#kfk#fkfkffffff%f%k#kfk#fkfkffffff%k%fkfffkk#fkfff@fkf@kf%#fkfff@fkf@kf
	ffkff%k#fkkff@%@f%fkfffkk#fkfff@fkf@kf%k#kfk%kffkfffkf@f@fkfkkfk#k#k#%k%kffkfffkf@f@fkfkkfk#k#k#%kffkff:=%fkkfkf%fkff%k#kfk#fkfkffffff%kk#%k#ffk#%fkff%k#kfk#fkfkffffff%@fkf%k#ffkfffffkfkfkff@f@%kf
	fff%fkfffkk#fkfff@fkf@kf%fkf@%f@fff@%f@%fkfffkk#fkfff@fkf@kf%fkff@%fkfffkk#fkfff@fkf@kf%#f@ff:=fk%k#kfk#fkfkffffff%f%k#kfk#fkfkffffff%kk#%k#fk%fkfff%f@fkk#k#%@fkf@kf
	k#%fkfkk#%fkf%k#ffkfffffkfkfkff@f@%k#f%fkfkk#%kff%k#kfk#fkfkffffff%@ffkfkf:=fkfff%fkfffkk#fkfff@fkf@kf%k#fkff%k#kfk#fkfkffffff%@fk%ffkff@%f@kf
;TRIPLE MESS FRAGMENTS FOR: @
	k#%ffkfkf%%fkfffkk#fkfff@fkf@kf%ffkk#%k#kfk#fkfkffffff%fk#fff%k#ffkfffffkfkfkff@f@%ffk#kfk#:=k#f%fkf@k#%%k#kfk#fkfkffffff%kfff%k#kfk#fkfkffffff%fk%k#f@fk%fk%k#kfk#fkfkffffff%kff@f@
	k#kfk%ffk#%fffk#%k#kfk#fkfkffffff%fk#fk%fkfffkk#fkfff@fkf@kf%#k%k#kfk#fkfkffffff%kfk#:=k#f%k#kffkf@%fkfff%k#kfk#fkfkffffff%fkfk%k#ff%f%fkfffkk#fkfff@fkf@kf%ff@f@
	k%kffkfffkf@f@fkfkkfk#k#k#%ff%fkk#%f@k#%k#kfk#fkfkffffff%@f%k#fkkf%f%fkfffkk#fkfff@fkf@kf%#ffk#f@kf:=%fkfffkk#fkfff@fkf@kf%#ff%fkfffkk#fkfff@fkf@kf%%k#kfk#fkfkffffff%fff%kfkffk%f%fkf@k#%kfkfkff@f@
	k%kffkfffkf@f@fkfkkfk#k#k#%%fkf@k#%f@%fkk#%kff%fkfffkk#fkfff@fkf@kf%kfffk#fkf@:=k%k#k#%#ffkf%k#kfk#fkfkffffff%ff%k#kfk#fkfkffffff%kf%fkfffkk#fkfff@fkf@kf%fkff@f@
	%k#kfk#fkfkffffff%k%k#kfk#fkfkffffff%%k#ffkfffffkfkfkff@f@%k%fkfkk#%fk#k#fkfk:=k#f%k#kfk#fkfkffffff%kf%k#kfk#fkfkffffff%ff%fkfkkff@%fkfkfkff@f@
	%ffkffkk#%fff@%k#kfk#fkfkffffff%ff%k#ffkfffffkfkfkff@f@%k#fkfkk#k#f@:=k#f%k#kfk#fkfkffffff%kffff%ffk#fkf@%f%fkfffkk#fkfff@fkf@kf%fk%k#kfk#fkfkffffff%kff@f@
	kff%f@fffkfk%%k#kfk#fkfkffffff%ffkfk%kffkfffkf@f@fkfkkfk#k#k#%f@%kffkk#%f@fff@f@ff:=%fkfffkk#fkfff@fkf@kf%#ffkf%ffk#kfff%ffffkf%fkfffkk#fkfff@fkf@kf%fkff@f@
	%ffffkf%k%k#kfk#fkfkffffff%kff%k#kfk#fkfkffffff%fkf%k#ffkfffffkfkfkff@f@%f%k#kffkf@%fkff@fk:=%f@fkfk%%fkfffkk#fkfff@fkf@kf%#f%k#kfk#fkfkffffff%k%ffk#fkf@%f%k#kfk#fkfkffffff%fffkfkfkff@f@
	f@%f@kfk#f@%k#%fkfffkk#fkfff@fkf@kf%#f%fkfffkk#fkfff@fkf@kf%k#fkk#%k#kfk#fkfkffffff%@ffk#f@k#:=k%f@f@fff@%#ffk%ffk#k#f@%ff%k#kfk#fkfkffffff%ff%fkfffkk#fkfff@fkf@kf%f%fkfffkk#fkfff@fkf@kf%fkff@f@
	ff%kfffk#k#%k#f@ffk%kffkfffkf@f@fkfkkfk#k#k#%fkk%k#kfk#fkfkffffff%k#fkf@f@f@:=k%kffkfffkf@f@fkfkkfk#k#k#%ffkf%f@kfk#f@%fff%k#kfk#fkfkffffff%kfkf%k#k#kf%kff@f@
	fff@%k#kfk#fkfkffffff%kf@%ffkfkf%k#f@%k#k#f@fk%f%k#ffkfffffkfkfkff@f@%k#k#:=k#ffk%fffffk%fffffk%k#kfk#fkfkffffff%kfk%k#kfk#fkfkffffff%f@f@
	f%k#k#%f%f@fkk#ff%kf%k#kfk#fkfkffffff%@f%k#kfk#fkfkffffff%ffkfffk#:=k%kffkfffkf@f@fkfkkfk#k#k#%%fff@fkff%%k#kfk#fkfkffffff%fk%k#kfk#fkfkffffff%ffffkfkfkff@f@
	%fkfffkk#fkfff@fkf@kf%%kffkfffkf@f@fkfkkfk#k#k#%fk%ffkfkff@%k#%f@kff@%fkfkk#fkfk:=%k#k#k#fk%k#%k#kfk#fkfkffffff%fkf%kff@%ff%k#kfk#fkfkffffff%fkfk%k#kfk#fkfkffffff%kff@f@
	ff%k#k#k#fk%%k#kfk#fkfkffffff%@kf%f@f@fff@%fkf%k#ffkfffffkfkfkff@f@%k#kfkff@:=k#%f@fffkfk%ffkff%k#kfk#fkfkffffff%ffkfk%k#kfk#fkfkffffff%kff%k#ffkfffffkfkfkff@f@%f@
	k%kffkfffkf@f@fkfkkfk#k#k#%%kfk#f@%ff%fkfffkk#fkfff@fkf@kf%fffk%k#kfk#fkfkffffff%f%k#ffk#%@fffkk#k#:=k#ff%fkfkkff@%kffff%k#kfk#fkfkffffff%k%k#kfk#fkfkffffff%kfkff@f@
	%f@kf%fkk%k#kfk#fkfkffffff%f@k#f@%fkfffkk#fkfff@fkf@kf%ffkfffkfff@:=k#ff%fff@f@f@%kf%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%ffk%k#kfk#fkfkffffff%kfkff@f@
	kfff%k#kfk#fkfkffffff%kf@%fkfffkk#fkfff@fkf@kf%ffk%k#k#kf%kfkf:=k#ff%fkfffkk#fkfff@fkf@kf%%k#kfk#fkfkffffff%f%ffkfkff@%fffkf%f@fff@f@%kfkff@f@
	f%f@k#fk%k%fkfffkk#fkfff@fkf@kf%ff@f%fkfffkk#fkfff@fkf@kf%fk%fkfffkk#fkfff@fkf@kf%ffkfk:=k#f%k#kfk#fkfkffffff%k%k#f@kf%ffff%k#kfk#fkfkffffff%kfkf%fkfffkk#fkfff@fkf@kf%ff@f%kffffkk#%@
	ffk%fkf@k#%%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%kk#k#f@fkff:=k#f%ffk#k#f@%fkf%fkfkf@%%k#kfk#fkfkffffff%ff%k#kfk#fkfkffffff%kfkfkff@f@
	kff%fff@fkff%@f%k#ffkfffffkfkfkff@f@%k#fk%k#kfk#fkfkffffff%fk#:=%fkfffkk#fkfff@fkf@kf%#ffkf%kfk#f@%fff%k#kfk#fkfkffffff%k%k#kfk#fkfkffffff%kfkff@f@
;TRIPLE MESS FRAGMENTS FOR: #
	ffk%fkk#k#kf%#fkf%kfkfff%@f@f@%fkfffkk#fkfff@fkf@kf%#kfk#%k#kfk#fkfkffffff%fff:=k%k#kfk#fkfkffffff%fkfffk%f@fkk#k#%f@f@fk%ffkffkk#%%k#kfk#fkfkffffff%kkfk#k#k#
	kfkf%kfkff@fk%ff%fkfffkk#fkfff@fkf@kf%#f%k#fk%@f%fkfffkk#fkfff@fkf@kf%fkfkf@k#:=%fkfffkk#fkfff@fkf@kf%ffkff%k#kfk#fkfkffffff%kf@f@%f@fkfk%f%fkfffkk#fkfff@fkf@kf%fkkfk#k#k#
	f@f@%ffk#fkf@%f%k#kfk#fkfkffffff%fkk#k%k#kfk#fkfkffffff%%fkk#kfff%k#f@f@k#k#:=%fkfffkk#fkfff@fkf@kf%f%k#kfk#fkfkffffff%kf%k#kfk#fkfkffffff%%ffk#kfff%fk%f@kfff%f@f@fkfkkfk#k#k#
	kfk#f@%kff@%k#ffk%kffkfffkf@f@fkfkkfk#k#k#%f%k#kfk#fkfkffffff%kfffkf:=k%f@kfff%ffkf%k#kfk#fkfkffffff%fkf%k#fkkff@%%k#ffkfffffkfkfkff@f@%f@fkfkkfk#k#k#
	ff%k#kfk#fkfkffffff%%k#ffkfffffkfkfkff@f@%k#k%kffkfffkf@f@fkfkkfk#k#k#%%ffffkfk#%kfkff@kffkffkfff:=kff%fkfffkk#fkfff@fkf@kf%fffkf@%k#kfk#fkfkffffff%@%fkf@kff@%fkfkk%k#kfk#fkfkffffff%k#k#k#
	k%kffkfffkf@f@fkfkkfk#k#k#%kfk%k#fkk#ff%ffk%k#kfk#fkfkffffff%@fffffkk#k#kff@:=kff%fkfffkk#fkfff@fkf@kf%fffk%k#fkk#%f@f@%k#kfk#fkfkffffff%kfkkfk%kffkfffkf@f@fkfkkfk#k#k#%k#k#
	kfff%k#f@fk%f%fkfffkk#fkfff@fkf@kf%ffff%fkfffkk#fkfff@fkf@kf%fk#%fkfffkk#fkfff@fkf@kf%#k#fff@ff:=kf%k#kfk#fkfkffffff%kf%k#kfk#fkfkffffff%fkf@f%f@fkffk#%@fk%kffkk#%fkkfk#k#k#
	k#%fkfffkk#fkfff@fkf@kf%#f@f%k#f@fk%kf%k#ffkfffffkfkfkff@f@%f%k#k#kffk%@k#%k#kfk#fkfkffffff%ff@ff:=kf%f@fff@%fkff%k#k#ff%fk%k#kfk#fkfkffffff%@f%k#ffkfffffkfkfkff@f@%fk%k#kfk#fkfkffffff%kkfk#k#k#
	kff@f%k#k#f@%%fkfffkk#fkfff@fkf@kf%fk%fkfffkk#fkfff@fkf@kf%#fkf@%fffkf@k#%f@f@k#k#:=kff%fkfffkk#fkfff@fkf@kf%fffk%fff@fkf@%f%k#ffkfffffkfkfkff@f@%f@f%fkfffkk#fkfff@fkf@kf%%f@kfk#%fkkfk#k#k#
	ffff%fkf@fk%k#f%k#ffkfffffkfkfkff@f@%k#k%f@fkfffk%f%k#kfk#fkfkffffff%fkffk:=%fkfffkk#fkfff@fkf@kf%ffkff%k#kfk#fkfkffffff%kf@%fkf@k#%f@fkfkkfk#k#k#
	%fffkfkf@%fkff%fkfffkk#fkfff@fkf@kf%%k#kfk#fkfkffffff%k#kfkfkff@fff@f@fk:=%fkfffkk#fkfff@fkf@kf%ffkfff%fkfffkk#fkfff@fkf@kf%f@%fkfk%f@f%ffkfff%kfkkfk#k#k#
	kfk#k%k#f@kf%#%k#kfk#fkfkffffff%@kffkf%fkfffkk#fkfff@fkf@kf%ffkff%k#ffkfffffkfkfkff@f@%f@kf:=k%k#kfk#fkfkffffff%fk%ffffkfk#%%k#kfk#fkfkffffff%ffkf@f@fkfkkfk#k#k#
	ff%k#kffkf@%k#f%fkfffkk#fkfff@fkf@kf%f@ff%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%fkk#:=kff%fkfffkk#fkfff@fkf@kf%%ffk#kfff%f%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%kf@f@fkfkkfk#k#k#
	kf%k#kfk#fkfkffffff%%k#ffkfffffkfkfkff@f@%k%ffkffk%#kff%k#ffff%kk#f@kffk:=kffk%k#kfk#fkfkffffff%ffkf%fkk#k#kf%@f@%k#kfk#fkfkffffff%kfkkf%fkfffkk#fkfff@fkf@kf%#k#k#
	fffkf%ffffkf%fffff%fkfffkk#fkfff@fkf@kf%f%fkfffkk#fkfff@fkf@kf%#fffkf@k#k#:=kffkf%k#kfk#fkfkffffff%%k#kfk#fkfkffffff%kf@%f@fff@%f@%kfk#f@%fkfkkfk#k#k#
	%fkfffkk#fkfff@fkf@kf%%f@fkf@k#%#kf%fkff%fff%k#ffkfffffkfkfkff@f@%%k#kfk#fkfkffffff%fk#f@ff:=kffkff%k#kfk#fkfkffffff%k%k#kfk#fkfkffffff%@f@fkf%fkfffkk#fkfff@fkf@kf%kfk#k%fkkfffff%#k#
	k#%k#kfk#fkfkffffff%kfkff%k#fkkff@%k%f@kfk#%ffff%k#ffkfffffkfkfkff@f@%kff@kf:=kff%k#fkkf%kfffk%ffkffkk#%f@f%k#ffkfffffkfkfkff@f@%fkfk%fkfffkk#fkfff@fkf@kf%fk#k#k#
	fk%fkfffkk#fkfff@fkf@kf%fk%k#kfk#fkfkffffff%ff%k#fk%ff%k#ff%%fkfffkk#fkfff@fkf@kf%#kf:=kffkf%k#kfk#fkfkffffff%fk%kffkfkf@%%k#kfk#fkfkffffff%@f@fkfkkfk#k#k#
	k#%fff@fkf@%kff%k#ffkfffffkfkfkff@f@%k#k%kfk#f@%fk%kffkfffkf@f@fkfkkfk#k#k#%k#%fkfffkk#fkfff@fkf@kf%f:=kffkfff%fkfffkk#fkfff@fkf@kf%f@f%fkf@fk%@fkfkkf%fkfffkk#fkfff@fkf@kf%#k#k#
	f%k#fkk#%@kfk#%fkfffkk#fkfff@fkf@kf%#kf%fkfffkk#fkfff@fkf@kf%#fkf@ffffff:=%kfffk#ff%kffkf%k#kfk#fkfkffffff%fkf@f@%k#kfk#fkfkffffff%kfkk%k#kfk#fkfkffffff%k#k#k#

;dump variable fragments 
;OBF_GLOBVAR name: mytrue
	k#%fkfkfkf@kff@k#kffkfk%k%fkkfkfkfkffff@fkfkffk#%kf%kfffffkfk#f@f@fff@f@ff%=f%fkkff@f@k#f@k#k#f@kf%%f@fkk#ff%k%k#kffff@ffk#f@ff%%kfk#k#kfkff@fkf@%f
	f%fkfk%%fff@fkf@k#f@f@k#k#%%ffkfk#k#ffk#k#f@k#f@kfff%%fffkffffffkfk#fffkf@k#k#%kf=ff%f@f@ffkfk#ffkffkk#kff@%%fkk#ffff%#f%fkfkfkf@kff@k#kffkfk%
;OBF_GLOBVAR name: myfalse
	%k#fkk#ffk#fff@%%ffffkf%@kfk%k#k#kfkfkff@fffkfkfkk#%f@k#kf=%fff@k#fkk#f@fk%fk%k#kfkffkf@fffffkk#k#kff@%fkf%f@fkk#k#%%k#fkk#%kkfkf
	k#f%fkf@kfk#k#fkfk%%kfffk#f@fkfkk#kffkk#fk%#k#%f@f@ffkfk#ffkffkk#kff@%#ff=kfk%k#fkkf%#%f@fkfkf@k#f@fkfkfkkffkf@%kfk%fff@k#fkk#f@fk%fkf


;PARAMETERS for function  named: SOMEFUNC
;OBF_FUNC_2_PARAM name: someparam
	%f@fkfkf@k#f@fkfkfkkffkf@%k%kff@kfk#kfk#kfff%fk%fffffk%%fkfkfff@%fk%kfk#f@k#ffk#ffkfffkf%fkf@f@ffkf=%ffkfkf%%fffkfffkf@kffkffk#f@%ff%fff@fff@k#fkfkk#k#f@%%f@f@fkffkffkkffk%ffkfkkf
	k%fkfkk#%f%f@f@fkffkffkkffk%ff@%ffk#fffff@fkffkffkk#fff@%#f@k%kfk#k#kfkff@fkf@%kffkfffffkff=f%fkkfkfkfkffff@fkfkffk#%f@%ffkfk#k#ffk#k#f@k#f@kfff%f%k#fkkf%fkf%k#f@fk%kkf
;PARAMETERS for function  named: REWIRED_SOMEFUNC
;OBF_FUNC_3_PARAM name: someparam
	f%fkkfkffkk#kfkfkff@ff%kfk%fkkfkfkfkffff@fkfkffk#%fk%f@kfk#%kfk%f@fkf@k#%#ff=k%ffffkf%%kfkfffk#f@fkfkfkf@k#%f%fkk#ffff%f%fff@k#fkk#f@fk%%fkfffkk#f@f@k#f@fffk%k#kffkk#
	fffkkf%fkff%f@kff%fff@fff@k#fkfkk#k#f@%fkffk%k#kfkffkf@fffffkk#k#kff@%k#k#f@=k#%ffk#fkf@%ffk%f@fkfkf@k#f@fkfkfkkffkf@%k%kffffkffffkfk#k#k#fff@ff%k%fkfkfkf@kff@k#kffkfk%fkk#
;PARAMETERS for function  named: yourfunc
;OBF_FUNC_4_PARAM name: myparam
	k#kf%k#k#kffk%k%fkffkffffkf@fkk#ffk#f@kf%k#ff%fkffk#ffk#fff@ffkfffk#k#%#kffkkf=k#kf%fkf@kff@%kff%kfffk#f@fkfkk#kffkk#fk%ffk#
	%kfffff%kfkfk#%kffkfkf@%f@ffkf%fffkfkfkfff@ffkff@kfffff%kkfk#f%kff@kfffkffffff@kffkfkff%k#ffk#=k%kfk#k#f@kffkfkffkff@f@kf%kfk%f@fkfkf@k#f@fkfkfkkffkf@%fkf%kfffff%fk#
;PARAMETERS for function  named: yourfunc_trapdoor
;OBF_FUNC_5_PARAM name: myparam
	%ffk#fkf@%k#ff%k#ffffkfffkffkfkfkff%@%fkkfkffkk#kfkfkff@ff%ff@f%k#fff@k#k#kfkffkkf%k#kffk=%f@fkk#k#%ff%k#ffffkfffkffkfkfkff%%ffk#f@ffk#fkkfk#fkf@f@f@%f%k#kfkfffk#ffk#fkk#kfkfk#%fkfffffk
	f@k#f%f@f@k#f@fkfkkffkf@kf%fkkf%fkk#fk%ffk%k#k#f@fkf@f@k#fff@ff%ffk#%kffffff@k#kfkf%fkfkf=f%f@ff%%fff@f@f@%f%fkkfkfkfkffff@fkfkffk#%@f%kfkffffkf@ffkff@fk%fk%fkkfk#f@fkfkf@%ffffk

;always use these dumps for function and label fragments when
;doing dynamic obfuscation 
;OBF_FUNC name: testfunction
	ff%fkfkfkf@kff@k#kffkfk%f%f@ff%%k#k#kfkfkff@fffkfkfkk#%f%f@f@fff@%kffkff=fk%k#k#f@fk%k%f@fkfkf@k#f@fkfkfkkffkf@%kf%k#fkkff@%%f@f@fkffkffkkffk%%ffffk#f@k#kfffkffk%fffkf@
	%fkfffkk#f@f@k#f@fffk%@f%k#kffkf@%fffk%kffffkffffkfk#k#k#fff@ff%%fff@kf%f@k#ffk#=fkk%k#k#kf%fk%k#ffffkfffkffkfkfkff%%kff@kfffkffffff@kffkfkff%#fffkf@


;OBF_LABEL name: cancelprog
	k%f@f@fff@%#k%fkkfkfkfkffff@fkfkffk#%fkf%kff@%@%fkkfkffkk#kfkfkff@ff%ff%kfffffkfk#f@f@fff@f@ff%fkf@kfkffkf@=f%fkk#k#kf%@fk%kff@kfk#kfk#kfff%@kff@k%f@k#f@f@kfffffkffkkffk%f%k#k#kfkfkff@fffkfkfkk#%fffkfffff@
	%f@f@ffkfk#ffkffkk#kff@%#%fff@f@f@%f%kffkf@fk%kff%k#k#k#fffkf@fkk#kffkf@f@%ffffkfkf@kfk#ff=f@fkf@%f@k#f@k#%kff@%ffffkf%kff%fffkkfffk#kfffk#k#kffk%%fkkfkffkk#kfkfkff@ff%ffkfffff@


;if you had created 'secure' obfuscation classes then they would 
;have to have dumps for them
;for obfuscated system function calls


;$OBFUSCATOR: $DEFGLOBVARS: %k#fkkf%%f@kfk#%%f@k#f@f@kfffffkffkkffk%f%k#k#ff%k#ff, k%kffkfkf@%%fffkfffkf@kffkffk#f@%k#%f@f@k#f@fkfkkffkf@kf%kf%k#f@fk%kk%k#ffff%fkf
%k#f@ff%%f@k#kf%%kfk#f@% = 1
%k#f@k#k#k#ff%%f@k#f@k#%%ffkfkff@% = 0

;to set functions as 'rewirable' functions, all you have to do
;is to use the $DUMP_REWIRE_STRAIGHT or the $DUMP_REWIREFUNCPATH
;obfuscator command comments in your code somewhere. No other
;actions by you are necessary. it is however necessary to use one
;of them before the first usage of the function in your program.

;im going to start rewiring the SOMEFUNC() function 
;to the REWIRED_SOMEFUNC() function


;DUMPING SWITCHED 'STRAIGHT' FUNC: switchfrom: SOMEFUNC
%f@f@fkffkffkkffk%fk#k%ffkff@%#fk%kffkfkf@fff@fk%#f@k%f@f@fffkk#kfk#f@f@k#k#%fk=%fkfkfkf@kff@k#kffkfk%k%kffkfkf@%%kffffkkffkf@fkkff@kfkffk%#f@k#fkfffk
f@%f@fkfk%k#f%kfk#k#kfkff@fkf@%fkk%fkkfkfffffk#kf%f@=fk%k#k#k#fkf@fkfkk#fk%%fkff%#f%f@kfk#%@%kfffk#f@fkfkk#kffkk#fk%#f%k#fkfffff@f@fk%fffk

;will go to the actual function
%fff@fkf@%%fkk#%%kfk#k#fkk#f@k#fk%("hello world - REWIRE STRAIGHT TEST")


;DUMPING SWITCHED FUNCS: switchfrom: SOMEFUNC switchto: REWIRED_SOMEFUNC
kfk#%kffffff@k#kfkf%#%fkffffkf%%fkkfk#f@fkfkf@%k%fffkfkf@f@kfkff@k#f@ff%#f@k#fk=f%ffffkfk#%@kf%fff@k#fkk#f@fk%%kfk#f@k#ffk#ffkfffkf%fk%ffk#fkf@%fkkfff
%f@fkk#ff%f@k%kfkfffk#f@fkfkfkf@k#%%kfk#k#fff@k#fkfffkf@kf%ffkk#f@=%ffkfkff@%f@%ffk#fffff@fkffkffkk#fff@%%kfk#k#fff@k#fkfffkf@kf%k#f%f@f@fkffkffkkffk%fkkfff

;it will now go to REWIRED_SOMEFUNC instead of SOMEFUNC!
%fff@fkff%%ffkffk%%f@k#fffkk#f@%("autohotkey rocks - REWIREFUNCPATH TEST")

loop, 4
{
	indexdivby2 := ((a_index // 2) * 2 == a_index) ? %kfk#k#kfkff@fkf@%f%fffffk%k%k#ffk#%#%k#fkk#ff%ff : kf%kfffkfkfk#ffk#f@k#f@%#%fffkk#fk%%k#ff%fkfkkfkf
	
	;will take one of the 2 branches and will rewire the function on the fly!
	if (indexdivby2) {	

;DUMPING SWITCHED 'STRAIGHT' FUNC: switchfrom: SOMEFUNC
%ffkfffk#%k%fffkkfffk#kfffk#k#kffk%k#k#%k#fkk#ffk#fff@%k%kffffkkffkf@fkkff@kfkffk%#f@k#fk=fk%kfffkfkfk#ffk#f@k#f@%#f%fkf@kfk#k#fkfk%%kffffff@k#kfkf%#f%fkf@k#%k%fffkfkf@%fffk
%k#k#kffk%f@%fff@k#fkk#f@fk%%kff@k#kffkk#f@kffk%fff%k#fff@k#k#kfkffkkf%k#f@=fkk%k#kffff@ffk#f@ff%f@%fkfkkff@%%kffkfkf@fff@fk%#fkfffk

	} else {

;DUMPING SWITCHED FUNCS: switchfrom: SOMEFUNC switchto: REWIRED_SOMEFUNC
kfk%ffkfkf%#k#f%fffkf@k#%kk#%f@k#f@f@kfffffkffkkffk%@k#f%kffffff@k#kfkf%=f%k#fkk#%%ffkffkk#k#f@fkff%k%kfk#%fk%kfk#k#f@kffkfkffkff@f@kf%fkfkkfff
f%fkkff@k#f@kffkfffkfff@%k#ff%k#ffkfff%fkk#%kff@kfk#kfk#kfff%@=f@%f@fkf@k#%k%k#fkk#ffk#fff@%k#f%k#k#k#fffkf@fkk#kffkf@f@%fk%fkffk#ffk#fff@ffkfffk#k#%fff

	}
	
	;this function can go to either function depending on which
	;path was followed in the if above!
	%fkk#ffff%%fkk#kfff%%kfk#k#fkk#f@k#fk%("`nLOOP FLIP FLOP TEST`n*EVEN INDEX GOOD, ODD REWIRED*`nmy loop index is: " . a_index)
}

;in this one i am going to use a rewired function that closes its
;own door


;DUMPING SWITCHED 'STRAIGHT' FUNC: switchfrom: yourfunc
ff%kfffk#k#%k#k%k#kffff@ffk#f@ff%kffk%fkffkffffkf@fkk#ffk#f@kf%k=f@f%f@fkfk%%kfffffkfk#f@f@fff@f@ff%k#f%fkf@kff@%%kffffkkffkf@fkkff@kfkffk%fkk%kfk#k#f@kffkfkffkff@f@kf%fkkf
kf%fkfffkk#f@f@k#f@fffk%%f@k#ffk#%%fffkkfffk#kfffk#k#kffk%k%kfk#k#fff@k#fkfffkf@kf%fffff@=f%f@kffkff%@f%fkff%%fkkff@fkfkkffkfk%k#f%f@f@fkffkffkkffk%%kff@kfk#kfk#kfff%kk#fkkf

%kffffkk#%%ffk#k#kffkfk%%kfkfff%("DUMPED 'REWIRE_STRAIGHT' BEFORE CALLING THIS")


;DUMPING SWITCHED FUNCS: switchfrom: yourfunc switchto: yourfunc_trapdoor
ffk%fkk#%#%kfffk#f@fkfkk#kffkk#fk%#k%k#ffffkfffkffkfkfkff%%k#ffffkfffkffkfkfkff%kfk=f@%ffk#%k%fkfffkf@k#fkk#k#%%k#k#kfkfkff@fffkfkfkk#%@ffk%f@fff@%#ffk#kf
kff%ffkff@%f%kfffk#f@fkfkk#kffkk#fk%ff%f@kff@%f%k#ffffkfffkffkfkfkff%ff@=f@kf%kff@kfk#kfk#kfff%@ffk%kfffk#k#%#ff%fff@f@fff@fkfkk#fkkff@%#kf

%fkkfffff%%kfffkffffff@%%fkfk%("DUMPED 'REWIREFUNCPATH' BEFORE CALLING THIS")

%ffk#k#kffkfk%%kfkff@k#%%kfffk#k#%("this call of this function was automatically rewired straight!")


;DUMPING SWITCHED FUNCS: switchfrom: yourfunc switchto: yourfunc_trapdoor
ffk%ffk#fkf@f@f@k#kfk#ffff%k%k#kff@k#kfk#k#kf%kffk%fkkfffff%fk=f@%ffk#fffff@fkffkffkk#fff@%%ffk#fkf@%f%k#k#kfkfkff@fffkfkfkk#%@%fkf@fk%ffk#ffk#kf
%k#k#%%fkfkk#%kf%fkkfkfkfkffff@fkfkffk#%f%fkffk#ffk#fff@ffkfffk#k#%f%k#ffffkfffkffkfkfkff%ffff@=%fkk#kfff%f@%fffkfffk%k%f@f@k#f@fkfkkffkf@kf%%fkfffkf@k#fkk#k#%@ffk#ffk#kf

%fff@fk%%kfffkffffff@%%k#k#k#fk%("*THIS SHOULD CALL THE TRAPDOOR AGAIN*")

%f@fkk#ff%%ffk#k#kffkfk%%kfkf%("trap door is now off and should not be called")

exitapp	 
RETURN

;hotkeys SHOULD NOT be obfuscated!
;HOTKEY ORIGINAL NAME: home
home::
	msgbox, home key pressed!
return


;HOTKEY ORIGINAL NAME: RControl & RShift
RControl & RShift::
	msgbox, hello dave
	f%k#k#k#fkf@fkfkk#fk%%fkf@kff@%kf%k#fff@k#k#kfkffkkf%f%f@kff@%k%fffkf@k#%#fffkf@()
return


;HOTKEY ORIGINAL NAME: ^;
^;::
	msgbox, hello world
	fkkf%k#fkk#%%fkffk#ffk#fff@ffkfffk#k#%fk#%k#ffkfff%fffkf@()
return	

;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;(technically this one would be all right because it does not call any
;functions or use any variables inside of it)
;FUNCTION ORIGINAL NAME: testfunction
fkkfkfk#fffkf@() { 
	global
	msgbox, TESTING OBF OF A FUNCTION CALL:`n`ntestfunction has been called
}


;LABEL ORIGINAL NAME: cancelprog
f@fkf@kff@kffffffkfffff@:
	exitapp
return

;MUST BE ASSUME GLOBAL FOR DYNAMIC OBFUSCATION!
;FUNCTION ORIGINAL NAME: SOMEFUNC
fkk#f@k#fkfffk(fff@kffkfkkf) { 
	global
	msgbox, inside function: "SOMEFUNC"`n`nparameter was: %k#fkk#%%fff@kffkfkkf%%k#fkk#ff%
	return f%f@k#f@f@kfffffkffkkffk%f@%fkk#fk%%fkfkk#%kffkfkkf

}

;this function is never called in the unobfuscated script!
;FUNCTION ORIGINAL NAME: REWIRED_SOMEFUNC
f@kfk#fkfkkfff(k#ffkfk#kffkk#) { 
	global
	msgbox, inside function: "REWIRED_SOMEFUNC"`n`nparameter was: %k#k#%%k#ffkfk#kffkk#%%fff@f@f@%`n`n***FUNCTION WAS REWIRED TO THIS FUNCTION***
	return
}


;FUNCTION ORIGINAL NAME: yourfunc
f@f@k#fkfkk#fkkf(k#kfkffkffk#) { 
	global
	
	msgbox, inside 'yourfunc'`nparameter is:`n%fkk#kfff%%k#kfkffkffk#%%k#f@kf%

}

;this function is never called in the unobfuscated script!
;FUNCTION ORIGINAL NAME: yourfunc_trapdoor
f@kff@ffk#ffk#kf(fff@f@fkfffffk) { 
	global
;this command will close the trap door!

;DUMPING SWITCHED 'STRAIGHT' FUNC: switchfrom: yourfunc
ff%f@kfk#f@%%kffkfkf@fff@fk%#k%fkffkfk#kfkfkff@fff@f@fk%kffkfk=%k#fkk#ffk#fff@%%kffffkf@kffkkfkf%f%fkfkf@%@k%kff@%#f%f@f@fkffkffkkffk%fkk#fkkf
%fffkfkf@f@kfkff@k#f@ff%f%fkfkfkf@kff@k#kffkfk%fkf%ffkff@%ff%f@fffkfk%fff@=f%k#fkk#fkfkk#fkfk%f@k%f@f@fffkk#kfk#f@f@k#k#%fkfk%kfffff%k%fff@k#k#kfkff@kffkffkfff%fkkf


	;maybe do some extra security things here
	
	;i will add something on to the parameter so that it will indicate
	;that i went through this function first!
	ff%ffkffk%f@f%fff@fkf@k#f@f@k#k#%fk%f@f@k#f@fkfkkffkf@kf%%fff@fkff%ffffk .= "`n`nI WENT THOUGH A TRAP DOOR named: yourfunc_trapdoor!`n" 
	
	;NOTICE I AM CALLING THE ORIGINAL FUNCTION NOW!
	return %f@k#k#fk%%kfffkffffff@%%fkk#k#kf%(fff%fff@fff@k#fkfkk#k#f@%f@%fffkkfffk#kfffk#k#kffk%kff%f@fkfffk%ff%fkfkkff@%fk)
}

