obf_copyright := " Date: 08:13 mercredi 12 juillet 2017           "
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

;$OBFUSCATOR: $DEFGLOBVARS: f@f%f@k#k#%ff@fff@fk, %fkffffkf%f%f@f@fffk%k%fkf@f@kf%kff@f@k#kf
f%fkffk#ff%@%kffkfk%fff%fkf@kfk#%@fff@fk = 1
fkk%k#kfk#%ff@f@%k#f@kffk%k#kf = 0

;test obfuscation of function call
%ffkfkf%kf%f@k#k#%kff@%f@fk%kfkff@ff()

;test obfuscation of parameters
;msgbox will show 12 if obfuscation of parameters works
msgbox, % "parameter: " . kfk%f@kf%ff@f@%ffff%kfk#%ffk#k#%kfkf(12)

;test obfuscation of label
gosub f@k#kff%fkffk#ff%kk#fff@k#f@fff@kff@fff@f@ffffkfk#f@

;tests local variables, global variables, gosub label as 
;part of a 'gui, add' statement, and variables defined as associated
;with a gui control
f@%kffffkff%f@k#fkffk#k#k#()
	 
RETURN

;hotkeys SHOULD NOT be obfuscated!
;HOTKEY ORIGINAL NAME: home
home::
	msgbox, home key pressed!
return


;HOTKEY ORIGINAL NAME: RControl & RShift
RControl & RShift::
	msgbox, hello dave
	kf%f@k#%kff@kfkff@ff()
return


;HOTKEY ORIGINAL NAME: ^;
^;::
	msgbox, hello world
	kfk%fkffffkf%ff@k%kffkk#kf%f%f@fk%kff@ff()
return	


;FUNCTION ORIGINAL NAME: testfunction
kfkff@kfkff@ff() { 
	global
	msgbox, function: testfunction has been called	
}

;will test the correct obfuscation of the parameter 'myparam'
;if successful the function will return the value it was sent
;FUNCTION ORIGINAL NAME: test_parameters
kfkff@f@kfk#kfkf(f@fkffkfkfkff@ff) { 
	global
	
	%fkkf%f@fkf%f@f@ffff%fkfkf%fkffk#ff%kff@ff:=f@fk%fff@kfk#%ffkfkfk%k#k#f@k#%ff@ff + f%f@k#fk%@fkff%kfkffk%kfkfkff@ff - f@fkff%kff@k#%kfkf%ffk#fk%kff@ff	
	return "my parameter was: " . f@f%k#f@ff%kffkfkfkff@ff	
}


;LABEL ORIGINAL NAME: test_label
f@k#kffkk#fff@k#f@fff@kff@fff@f@ffffkfk#f@:
	msgbox, inside "gosublabel"
return


;FUNCTION ORIGINAL NAME: creategui
f@f@k#fkffk#k#k#() { 
;$OBFUSCATOR: $DEFLOSVARS: f%f@k#f@%k%ffk#fkkf%f@f%fkk#ffkf%ffkf@fkfk, f%k#fkf@%kfkf@fkf@fkfkf@fkk#, ffk#kf%f@fkk#%k#fkk#ffkffkk#, f@f%kffkk#kf%k%fffkk#%k#ffkffkfkffkffkf@
	fk%kfk#%f@fffkf%f@fkf@kf%@fkfk 		= % "s22"
	fkfkf@f%kffffk%kf@%ffk#k#%fkfkf@fkk# 		= % "s18"	
	ff%kfffk#%k#kfk#fkk#ffkffkk# 	= % "s14"
	f@%f@kf%fk%fkf@fk%k#f%k#fkkf%fkffkfkffkffkf@ := fk%k#k#fff@%kfff%k#kfk#%%k#fkkf%fkf@k#f@kf("dfbcf6e2f602e5230652d5e0b12245c2c5d24630b1c2a51315")

	gui 2:default
	gui, destroy
	gui, margin, 20, 20
	
	;the h1font variable below should be obfuscated
	gui, font, %fkf@fffkf@fkfk%%fkffk#ff%%f@f@fffk% bold
	gui, add, text, xm ym, Obfuscator Test GUI
	
	gui, font, %f@ffk#k#%%ffk#kfk#fkk#ffkffkk#%%k#k#fff@% norm underline
	;the gosub label below should be obfuscated
	gui, add, text, xm y+12 cblue Gff%f@fkk#%k#f@kffffff@kfk#fkkffkk#fffff@, test gosub obfuscation in gui statement
	
	gui, font, %ffk#kfk#fkk#ffkffkk#%%fff@kfk#%%fkkf% norm
	gui, add, text, xm y+12 Gffk%k#fkf@%#%k#fkff%f@kff%fkf@fkkf%ffff@kfk#fkkffkk#fffff@,
(
hello world
message in variable:
"%f@fkk#ffkffkfkffkffkf@%%f@fk%%k#f@f@f@%"

-press home key to test hotkeys-
)
	gui, add, text, xm y+12, enter something here to test`nvariable obfuscation
;$OBFUSCATOR: $DEFGLOBVARS: f%f@k#fk%@k%fkkf%#k#k#fkfk
	gui, add, edit, xm y+2 Vf%kffkff%@%f@k#f@%k#k#k#fkfk r4, 
		
	gui, add, button, xm y+20 Gk#fkkff%f@fkff%kffkffkk#fkfkkff@k#, Test gui submit
	gui, add, button, x+20 yp Gf%kffkff%@f@fff@fkfkkfkffffkkffk, Cancel program
	gui, show
}


;LABEL ORIGINAL NAME: testguisubmit
k#fkkffkffkffkk#fkfkkff@k#:
	gui, submit, nohide
	msgbox, you entered "%kffkfkfk%%f@k#k#k#fkfk%%fff@f@kf%"
return


;LABEL ORIGINAL NAME: cancelprog
f@f@fff@fkfkkfkffffkkffk:
	exitapp
return


;LABEL ORIGINAL NAME: guigosub
ffk#f@kffffff@kfk#fkkffkk#fffff@:
	msgbox, inside _guigosub_
return


;SKIPPED MOVING function: 'ihidestr()' to OBF CODE

;put this function in your source code. it will actually be called
;by the obfuscated code to 'decode' the obfuscated strings.
;this function and all calls to it will also be obfuscated in
;the output obfuscated program
;FUNCTION ORIGINAL NAME: decode_ihidestr
fkkffffkf@k#f@kf(kfkfkff@fkk#k#) {  
	global	
;$OBFUSCATOR: $DEFGLOBVARS: f@f%ffk#fk%fffkfff
	
	static ffffk#fkf@kff@f@k#fk, f@ffkfk#kfk#f@f@kffk, f@k#ffkfffffkf, fkf@fkfkkfffkffffffk, fffkkfffk#k#, k#fkk#f@fffkk#ffkfk#
;$OBFUSCATOR: $DEFLOSVARS: ffffk#%f@f@ff%fkf@%k#k#f@k#%kff@f%fkf@kfk#%@k#fk, %k#k#fff@%f@f%kffkff%fkfk#k%f@kf%fk#f@f@kffk, f%f@kf%@k%k#f@%#ffk%k#k#f@%fffffkf, f%fkk#kffk%kf@fkfkkfffkffffffk, ff%fkf@kfk#%fkkff%ffk#k#%fk#k#, k#fk%kffkff%k#f@fffkk#ffkfk#

	f@f%f@fkf@kf%%kffkfk%ff%f@f@fk%fkfff = % "0123456789abcdef"
		
	;will get the encoded key hidden in the obfuscated literal string
	kfkffk%ffkfkf%f@kff@k%f@fkff%#ff(k%f@kffkk#%fkfkff@fkk#k#)
	
	;grab encoded data
	kf%fkffffkf%kfkf%fff@kfk#%f@fkk#k# = % substr(kfk%kffffk%fk%k#f@ff%ff@f%f@fffkkf%kk#k#, 1, 1) . substr(kfk%fffk%fkff%f@kfffk#%@%ffkffkkf%fkk#k#, 6)
	f@%k#kfk#%ffk%ffkfkf%fk#kfk#f@f@kffk = % strlen(kfkfk%k#fkkfk#%ff@fkk#%k#kf%k#)
		
	ffffk%k#ffff%#fkf@kff@f@k#fk = 
	;reverse the hex string
	loop, % strlen(kfkfk%fff@f@kf%ff@fkk#k#) 
		ff%fkfkff%ffk#fkf@kff@f@k#fk = % substr(kfkfkf%k#kfff%f@fkk#k#, a_index, 1) . %fkfkff%ffffk#%kffffkff%fkf@kff@f@k#fk
	
	kf%fkf@f@kf%kf%kffkfkfk%k%kff@f@%ff@fkk#k# = % ffffk%f@kffk%#%fkffffkf%f%fkk#kffk%kf@kff@f@k#fk
	fff%f@ff%fk#fkf%ffkff@fk%@kff@f@k#fk = 
	f@k#f%ffffff%fkfffffkf = 1
	;convert from hexidecimal to binary	
	while true
	{
		if (f@%f@kfff%%fkfffkk#%k%ffff%#ffkfffffkf >f@ffk%k#f@fk%f%kffkfk%k#kfk#f@f@kffk)
			break
			
		fkf@fkf%f@fffkkf%kkfffkffffffk = % substr(kfkfk%f@k#k#%ff%k#f@ff%@fkk#k#, f@k#%k#f@%ff%ffffk#%kfffffkf, 1)
		;find it in hexdigits and convert to decimal number
		f%k#fkf@%k%k#fkkf%f@fk%ffk#k#%fkkfffkffffffk = % instr(f@f%kfk#f@%%fkf@fkkf%fffkfff, fkf@fk%k#ffk#%fkk%k#fkkf%fffkffffffk) - 1
		
		ff%fkffffkf%fkkfffk#k# = % substr(%k#fkkf%kf%k#f@ff%%f@fkk#%kfkff@fkk#k#, f@k#%ffk#kf%ffkf%f@kffkk#%ff%ffkffffk%ffkf + 1, 1)
		;find it in hexdigits and convert to decimal number
		f%kffkfk%ffkkfffk#k# = % instr(%f@kffkfk%f%f@fkk#%%f@kffkk#%@ffffkfff, f%kffffkff%ffkkff%f@k#fk%fk#k#) - 1
		
		;unshift the hex
		fkf@fk%f@ffk#ff%fkkff%ffk#k#%fkff%kfk#%ffffk := k#fkfkk%k#k#f@k#%#kffkk#(fkf@fk%k#fkkf%fkkfffkffffffk)
		fff%k#k#f@k#%kkfffk#k# := k%fkk#f@f@%#fkf%f@ffk#k#%kk%f@kffkk#%#kffkk#(fffkkf%f@kff@f@%ffk#k#)
		
		k#fkk#%k#k#f@%f%ffkf%@fffkk#ffkfk# = % fkf@fkf%kffkfkfk%kkfffkffffffk * 16 + fffkkf%fkk#ffkf%ffk#k#
		ff%f@k#k#%ffk#f%f@f@fffk%kf@kff@f@k#fk .= chr(k#fk%kffkfk%%f@ff%k#f%f@k#k#%@fffkk#ffkfk#)
		
		f@k%kfkff@%%k#fkkf%#ff%k#ffk#%kfffffkf += 2		
	}
		
	ffff%fffk%k#%fkfkff%fkf@kff@f@k#fk = % fkk%ffffff%%k#k#fff@%ffk%fkf@fkkf%fkf@ffkff@(f%f@fkff%fffk#fkf@kff@f@k#fk)
		
	return, fff%k#kf%fk#fkf@kff@f@k#fk	
}


;FUNCTION ORIGINAL NAME: decode_hexshiftkeys
kfkffkf@kff@k#ff(kff@fkf@fkk#) { 
	global
;$OBFUSCATOR: $DEFGLOBVARS: %ffff%kff%kfkfk#f@%ff@k#f@fk, fkk%kff@k#%ffff@f%kff@f@%kfk, kfkff%k#k#k#fk%ffkk#
	
	;these have '1's in them
	k%k#fkf@%fff%kff@k#%f@%k#f@fk%k#f@fk := "fff@kkf1ffkfkfkfff#k1fk@kf#@fffk@#kk"
	fkk%kfkfk#f@%%fkk#f@f@%ffff@fkfk := "fff@f1ff@kffkk#f1fffffkf"
	
	;grab randomly created encrypt key
	;i hid it in the obfuscated literal string, 2 characters in
	%ffk#k#%%kffff@k#f@fk%%f@kf%%k#k#fff@%%fff@f@kf%%fkkffff@fkfk%1 = % substr(kf%fffkff%%kffkfk%f@fk%fffk%f@fkk#, 2, 1)
	%kffff@k#f@fk%%k#ff%%ffkffkkf%%fkkffff@fkfk%%f@kfff%%kffffkff%2 = % substr(kff%ffkfkf%%fkf@fk%@fkf@fkk#, 3, 1)
	%f@k#k#%%kffff@k#f@fk%%ffffk#%%kffkff%%fkkffff@fkfk%%f@kff@ff%3 = % substr(kff@%ffffk#%fkf%kfk#f@%@fkk%kff@ff%#, 4, 1)
	%kffff@k#f@fk%%f@kffkfk%%k#ffk#%%kfkff@%%fkkffff@fkfk%%kffkff%4 = % substr(k%k#f@kffk%ff%fkk#ffkf%@f%f@kffkk#%kf@fkk#, 5, 1)
	
	;covert key values to actual numbers
	loop, 4
		%kfk#%%kffff@k#f@fk%%f@kffkfk%%a_index% = % instr(f@f%kff@ff%fffkf%f@f@k#%ff, %fkf@%%kffff@k#f@fk%%fkfffkk#%%f@fk%%k#fk%%fkkffff@fkfk%%a_index%) - 1
			
	kfkffff%fffkff%kk# = 0
}	


;FUNCTION ORIGINAL NAME: decode_shifthexdigit
k#fkfkk#kffkk#(f@kffffkfffffk) { 
	global
	
	;each time i enter this routine i will use the next key value
	;to shift the hexvalue
	%f@kffk%kf%fkf@%kffffkk#++
	if (%fkk#%kf%f@fkff%k%ffk#fkkf%ffffkk# > 4)
		kfkffff%k#kfff%kk# = 1	
	
	;subtract the shift key from the hexvalue 
	f@kfff%k#ffk#%fkfffffk -= %k#k#k#fk%%kffff@k#f@fk%%fkffffkf%%kfkffffkk#%%ffff%%f@fkf@kf%
	
	;if i go under zero, just add 16
	if (%k#f@ff%f@kffffkfffffk < 0) 
		f%k#k#%@kff%f@fffkkf%ffkfffffk += 16
		
	return f@k%kfkf%ffffkfffffk	
}


;FUNCTION ORIGINAL NAME: fixescapes
fkkffkfkf@ffkff@(fkf@k#kffkfff@) { 
	global
	
	StringReplace, fk%f@kffkk#%f@k#kffkfff@, fkf@k#%ffff%kffkf%k#k#f@k#%ff@, % "````", % "``", all
	StringReplace, f%k#k#%%ffkfkf%kf%k#fkf@%@k#kffkfff@, fkf@k#k%k#k#f@k#%ffkfff@, % "``n", % "`n", all
	StringReplace, fkf%k#k#f@%@k%fffk%#kff%kfk#f@%kfff@, fkf@%ffk#%k%fkk#kffk%#kff%kfkffk%kfff@, % "``r", % "`r", all
	StringReplace, %fkk#ffkf%fkf@k#kffkfff@, fkf%fkkf%%fkf@kfk#%@k#k%f@kff@ff%ffkfff@, % "``,", % "`,", all
	StringReplace, fkf@k%fkk#kffk%#kffkff%kfkffk%f@, fkf@%kffffk%k#kffkfff@, % "``%", % "`%", all	
	StringReplace, fkf@k#%f@fffkkf%kffkf%fff@f@kf%ff@, fkf%f@kf%@%f@k#f@%k%k#f@fk%#kffkfff@, % "``;", % "`;", all	
	StringReplace, f%kfk#%kf@%k#ffk#%k#kffkfff@, fk%f@ffkfkf%f@k#kf%kffkk#kf%fkfff@, % "``t", % "`t", all
	StringReplace, fk%kfkfkf%f@%f@kffkfk%k#%k#kff@ff%kffkfff@, fkf@%kfk#f@%k#kffkfff@, % "``b", % "`b", all
	StringReplace, fkf@%k#ffff%k#kffkfff@, fk%fkf@kfk#%f@k%f@kffkk#%#k%k#k#fff@%ffkfff@, % "``v", % "`v", all
	StringReplace, fkf%f@kfffk#%%ffk#fkkf%@k#kffkfff@, fkf@k%fkf@kfk#%#k%f@kffkfk%ffkfff@, % "``a", % "`a", all
	
	StringReplace, fkf@k%fkf@f@kf%#kffkfff@, fk%fff@f@kf%f@k#kffkfff@, % """""", % """", all
	
	return f%ffkff@fk%kf@k#kffkfff@
}

