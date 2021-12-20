obf_copyright := " Date: 13:39 mercredi 12 juillet 2017           "
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
;use these statements to set obfuscation to straight obfuscation!
;$OBFUSCATOR: $STRAIGHT_MODE:
  
;put a string assignment header like this in your program so that
;the program name and copyright info still shows up in the obfuscated ;version of this program
program_name:="MY PROGRAM NAME"
program_name:="Author: MY NAME"
program_name:="Copyright MY NAME, YEAR"

;$OBFUSCATOR: $DEFGLOBVARS: k#fkf%kfkfffk#%@k#ff, %fkf@kf%fkf@fkf@ffff
k%fkfffffk%#fk%fkkf%f%k#fk%@k#ff = 1
fkf@%k#f@fkf@%fkf@ffff = 0

;test obfuscation of parameters
;msgbox will show 12 if obfuscation of parameters works
msgbox, % "parameter: " . k#f@k#f%kfk#ffff%fkf%fkfkkf%k#ffkf(%k#f@kf%fffkf%fff@ff%%kffff@%kk#fffkfkff("fe2fd231"))

msgbox % "obfuscated text = " fffkfk%f@k#f@kf%%fkkf%k#fffkfkff("865f44db939b")
	 
RETURN

;will test the correct obfuscation of the parameter 'myparam'
;if successful the function will return the value it was sent
;FUNCTION ORIGINAL NAME: test_parameters
k#f@k#ffkfk#ffkf(ffk#kff@fkffk#) { 
	global
	
	ffk#kff%k#ff%@fkffk#:=ffk%fkf@kff@%#kff@fk%k#f@fk%ffk# + %k#fk%ffk#%kfk#f@%%fkfkfk%kff@fkffk# - ffk%k#kffkkf%#%k#kfk#%kff%f@ffk#f@%@fkffk#	
	return "my parameter was: " . ffk%fkkf%#kff@f%kfffkf%kffk#	
}


;SKIPPED MOVING function: 'ihidestr()' to OBF CODE

;put this function in your source code. it will actually be called
;by the obfuscated code to 'decode' the obfuscated strings.
;this function and all calls to it will also be obfuscated in
;the output obfuscated program
;FUNCTION ORIGINAL NAME: decode_ihidestr
fffkfkk#fffkfkff(fkkff@kfk#kff@) {  
	global	
;$OBFUSCATOR: $DEFGLOBVARS: k#%fff@%%k#fffkff%k#%fkf@ffkf%kf
	
	static f@kffkfkk#ffk#fffkf@k#, ffkff@f@kff@fff@, fff@kff@kfkfff, f@kff@ffffk#kffff@ff, kfk#kfk#kfkfkf, kfkfk#fkfkfkfkff
;$OBFUSCATOR: $DEFLOSVARS: %kfffk#kf%f@kffkfkk#ffk#fffkf@k#, ffkff@f%kffff@k#%@kff@fff@, fff%ffkf%@kff@kfkfff, f@kff%fkk#%%kfk#f@%@ffffk#kffff@ff, kf%f@k#ffk#%k#kfk#kfkfkf, %k#fkfffk%kfkfk%fkffkffk%#f%kfffkf%kfkfkfkff

	%fkfkkf%k#k%fkfffffk%#kf = % "0123456789abcdef"
		
	;will get the encoded key hidden in the obfuscated literal string
	ffk#ffk%kfk#ffff%#k#f@fk(f%k#k#f@fk%kk%fffkffk#%ff@%fkffkff@%kfk#kff@)
	
	;grab encoded data
	fkkff@%ffkfkf%kfk#kff@ = % substr(fkkf%fkkff@fk%f@kfk#k%fffkfk%ff@, 1, 1) . substr(fkkff%k#f@kf%@kfk#k%ffffffff%ff@, 6)
	ffkff%fkkf%@f@k%k#k#f@%ff@ff%kfk#ffff%f@ = % strlen(fk%k#fk%kff@%fkfkkf%kf%k#kffkkf%k#kff@)
		
	f@kffkf%kffff@%kk#ffk#fffkf@k# = 
	;reverse the hex string
	loop, % strlen(fkkf%kfffk#kf%f@kfk#kff@) 
		f@k%kfffffk#%f%f@ff%fkfkk#ffk#fffkf@k# = % substr(f%fff@ff%kkff@kfk#kff@, a_index, 1) . %k#fkf@f@%f@kffk%fkk#ffkf%f%fkfffffk%kk#ffk#fffkf@k#
	
	fkkf%kfffffk#%f@k%fffkkf%fk#%kfffkf%kff@ = % f@kf%k#k#fk%fkfkk#ffk#fffkf@k#
	f%k#f@kf%@kffkfkk#ffk#fffkf@k# = 
	fff%kfff%@kff@kfkfff = 1
	;convert from hexidecimal to binary	
	while true
	{
		if (fff@%kfk#k#kf%kf%k#fkk#%f@k%k#fkf@f@%fkfff >ffkf%ffkff@%f@f@kff@fff@)
			break
			
		f@kff@f%f@ff%fffk#kffff@ff = % substr(fkkff@k%kff@ffkf%fk#kff@, fff@%kfkfffk#%kff@kfkfff, 1)
		;find it in hexdigits and convert to decimal number
		f@k%k#fkf@f@%f%fff@%f@fff%kfk#kfkf%fk#kffff@ff = % instr(k#k#kf, f@k%fkf@kf%ff@fff%fkfkk#kf%fk#kffff@ff) - 1
		
		kfk#%kfk#fkfk%k%kffff@%fk%k#ffkf%#kfkfkf = % substr(fkkff@%k#fffkff%kfk#kff@, fff%fkk#%@%fkf@fk%kff@kfkfff + 1, 1)
		;find it in hexdigits and convert to decimal number
		kfk#k%fkk#ffkf%fk#kfk%ffffffk#%fkf = % instr(k#%ffkf%k#%fkk#fkfk%kf, k%kffkfff@%f%k#f@fkf@%k%fkkffkff%#kfk#kfkfkf) - 1
		
		;unshift the hex
		f@%fkfff@%kff@ffffk#kffff@ff := k%kfk#k#kf%ff%k#kffkkf%@fkk#fffkf@f@(f@k%fkfkkf%f%fkkff@fk%f@ffffk#kffff@ff)
		kf%k#kfkf%k#k%ffkfkf%fk#kfkfkf := kff%f@kffff@%@%k#fkf@f@%fkk%fkfffkff%#fffkf@f@(kfk#k%ffkfffk#%fk#kfkfkf)
		
		kfk%ffffk#k#%fk#fk%fffkkf%%fffkf@%fkfkfkff = % f@kff%fkk#f@%@f%kffff@%fffk#kffff@ff * 16 + kf%ffkfffk#%k#kfk#kfkfkf
		f@k%kfffkf%ff%ffffk#k#%kfkk#f%k#fkk#%fk#fffkf@k# .= chr(kfkfk#%k#ffkfff%%fkkff@fk%fkfkfkfkff)
		
		fff@%fkfff@%kff%fkfffkff%@kf%fffkkf%kfff += 2		
	}
		
	f@kf%f@fkkffk%fkfkk#%fkf@kf%ffk#fffkf@k# = % kfk%k#f@fk%ff@f@ffffk#fk(f@kf%fkfkk#kf%fkfkk#ffk#fffkf@k#)
		
	return, %fff@f@fk%f@kffkfkk#ffk#fffkf@k#	
}


;FUNCTION ORIGINAL NAME: decode_hexshiftkeys
ffk#ffk#k#f@fk(fkkfkfkfffk#f@k#) { 
	global
;$OBFUSCATOR: $DEFGLOBVARS: fkff%k#fkfff@%ffkfkf, k#fkk#k%fkk#f@%fff, %ffkfffk#%f%fkk#fkfk%%fkfkkf%@fkkf
	
	;these have '1's in them
	f%fff@ff%kff%k#f@fk%ffkfkf := "fff@kkf1ffkfkfkfff#k1fk@kf#@fffk@#kk"
	k%fffkffk#%#fkk#kfff := "fff@f1ff@kffkk#f1fffffkf"
	
	;grab randomly created encrypt key
	;i hid it in the obfuscated literal string, 2 characters in
	%fffkf@%%f@ff%%fkffffkfkf%%ffffffff%%k#fkk#kfff%%k#fkk#%1 = % substr(fkkf%fffkffk#%kfkfffk#f@k#, 2, 1)
	%fffffkk#%%fkffffkfkf%%k#ff%%kfk#k#f@%%kfk#ffff%%k#fkk#kfff%2 = % substr(fkkfkfk%k#ff%fffk#%kfk#f@%f@k#, 3, 1)
	%ffff%%k#k#fk%%fkffffkfkf%%k#fkk#kfff%%kffkf@fk%%f@fkf@f@%3 = % substr(fkkfk%f@k#f@kf%fkfffk#f@k#, 4, 1)
	%fkffffkfkf%%fkk#ffkf%%fkkf%%k#fkk#kfff%%ffkfk#%%ffffk#k#%4 = % substr(fk%f@f@fk%%kff@ffkf%kfkfkfffk#f@k#, 5, 1)
	
	;covert key values to actual numbers
	loop, 4
		%fkk#ffkf%%fkfffkff%%fkffffkfkf%%a_index% = % instr(%kfffkf%%fkfkk#kf%k#%ffffffff%k#kf, %fkk#ffkf%%ffk#k#%%fkffffkfkf%%f@fkkffk%%k#fkk#kfff%%k#fkf@f@%%a_index%) - 1
			
	f%kffff@k#%@fk%k#fffkff%kf = 0
}	


;FUNCTION ORIGINAL NAME: decode_shifthexdigit
kff@fkk#fffkf@f@(fkffk#k#f@f@f@) { 
	global
	
	;each time i enter this routine i will use the next key value
	;to shift the hexvalue
	f@f%ffk#f@%kkf++
	if (f@fkkf > 4)
		%kfk#kffk%f@%fkfff@%f%ffffk#k#%kkf = 1	
	
	;subtract the shift key from the hexvalue 
	%kff@fk%fk%f@k#f@kf%ffk#k#f@f@f@ -= %fkffffkfkf%%kffkfff@%%fkf@kff@%%k#f@fk%%fkf@fkff%%f@fkkf%
	
	;if i go under zero, just add 16
	if (fkff%fkffkffk%k#k#f@f%f@f@fkff%@f@ < 0) 
		%k#kf%fkffk#k%fkk#f@%#f@f@f@ += 16
		
	return %fffffkk#%fkffk#k#f@f@f@	
}


;FUNCTION ORIGINAL NAME: fixescapes
kfkff@f@ffffk#fk(k#fkk#fkkfkffff@) { 
	global
	
	StringReplace, k%f@f@fkff%#fkk%kfff%#fkkf%kfk#kfkf%kffff@, k#fkk%ffk#k#%#f%f@kff@kf%kkfkffff@, % "````", % "``", all
	StringReplace, k#f%fff@k#%kk#fkkfkffff@, k#fkk%fkf@fkff%#f%fkk#fkfk%kkfkffff@, % "``n", % "`n", all
	StringReplace, k#%f@kff@kf%fkk#fkkfkffff@, k#fkk%f@kff@kf%#fkk%fkk#ffkf%fkfff%kff@ffkf%f@, % "``r", % "`r", all
	StringReplace, k#%f@fkf@f@%fkk#%f@f@fk%fk%f@fkf@f@%kfkffff@, %k#k#fk%k#fk%fkk#f@%k#fk%k#ffk#k#%kfkffff@, % "``,", % "`,", all
	StringReplace, %f@ffk#f@%k#fkk#fkkfkffff@, %f@f@fkff%%fkf@kf%k#fkk#fkkfkffff@, % "``%", % "`%", all	
	StringReplace, k#f%k#ffkf%kk#%fkk#%%ffk#f@%fkkfkffff@, k%fkkffkff%#fkk#fk%f@f@fk%kfkffff@, % "``;", % "`;", all	
	StringReplace, k#f%kff@%kk#%fkf@fk%fkkfkffff@, k#%fkkff@fk%f%ffkfk#%kk%fkf@kff@%#fkkfkffff@, % "``t", % "`t", all
	StringReplace, k#f%f@kff@kf%kk#fkkf%ffk#k#%kffff@, k%ffkff@%#f%ffffffk#%k%k#ff%k#fkkfkffff@, % "``b", % "`b", all
	StringReplace, k#f%k#kffk%kk#fk%k#kffk%kfkff%fkffkff@%ff@, k#%fkfkkf%fkk#fkkfkffff@, % "``v", % "`v", all
	StringReplace, %fkkffkfk%k#fkk#fkkfkffff@, k#f%fkf@kf%kk#%k#k#fk%fkkf%ffkfffk#%kffff@, % "``a", % "`a", all
	
	StringReplace, %fff@k#%k#f%fkf@fkff%kk#fk%k#kffk%kfkffff@, k#f%kfk#kffk%%fkkff@fk%kk#fkkfkffff@, % """""", % """", all
	
	return %ffffffk#%k#fkk#fkkfkffff@
}

