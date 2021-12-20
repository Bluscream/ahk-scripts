obf_copyright := " Date: 08:22 mercredi 12 juillet 2017           "
obf_copyright := "                                                "
obf_copyright := " THE FOLLOWING AUTOHOTKEY SCRIPT WAS OBFUSCATED "
obf_copyright := " BY DYNAMIC OBFUSCATOR L FOR AUTOHOTKEY         "
obf_copyright := " By DigiDon									  "
obf_copyright := "                                                "
obf_copyright := " Based on DYNAMIC OBFUSCATOR                    "
obf_copyright := " Copyright (C) 2011-2013  David Malia           "
obf_copyright := " DYNAMIC OBFUSCATOR is released under           "
obf_copyright := " the Open Source GPL License                    "

;autoexecute
program_name:="MY PROGRAM NAME"
program_name:="Author: MY NAME"
program_name:="Copyright MY NAME, YEAR"
kf%fffkfkk#%k#kfk#k# = 1
f%fkk#ffkf%@%f@kfk#k#%f%k#fkk#%ffkf@ = 0
fk%ffk#%kf%kfk#%fkf%f@k#f@%kfkk#kfff()
msgbox, % "parameter: " . kff@f@f%k#fk%ff@k#k#(12)
gosub kf%fkkffkkf%%fff@f@%k%f@fkfk%ff@ffkfkfkffkkffkk#k#k#f@ff
kffk%kffff@%%ffk#ff%k#f%k#k#%kffkffk()
RETURN
home::
msgbox, home key pressed!
return
RControl & RShift::
msgbox, hello dave
f%kff@%k%fkkfff%kffkfkfkk#kfff()
return
^;::
msgbox, hello world
fk%fkkffkkf%%ffk#k#%%kffkfk%kffkfkfkk#kfff()
return
fkkffkfkfkk#kfff() { 
global
msgbox, function: testfunction has been called
}
kff@f@fff@k#k#(fffffkffk#fk) { 
global
ff%kffff@%fffkffk#fk:=ffff%kfffk#ff%fk%fkffk#%ffk#fk + f%kffff@%%fkffffkf%ffffkffk#fk - f%k#fkfffk%ffffkffk#fk
return "my parameter was: " . ff%f@fkfkf@%f%fkkfkff@%ffkffk#fk
}
kfkff@ffkfkfkffkkffkk#k#k#f@ff:
msgbox, inside "gosublabel"
return
kffkk#fkffkffk() { 
%kfk#kfk#%f@%fffkf@fk%fkkfkff@ffkfk#ff 		= % "s22"
ffk%fffkf@fk%f%fkkffkkf%kffkf@k#fkkf 		= % "s18"
k#kf%fkkfkff@%f@f%k#k#%@kfk#k#fkkfk# 	= % "s14"
%f@f@f@%%k#f@fk%f@ff%fkkfkf%k#kfffk# := k#%ffkffk%k%kfk#k#f@%fkf%kfk#ff%fkk#f@fffk("bc9e4334d354c275e3a4b2329e742214a22423829e148265f2")
gui 2:default
gui, destroy
gui, margin, 20, 20
gui, font, %fffkffkf%%f@fkkfkff@ffkfk#ff%%ffkff@k#% bold
gui, add, text, xm ym, Obfuscator Test GUI
gui, font, %f@ffkf%%f@k#%%k#kff@f@kfk#k#fkkfk#% norm underline
gui, add, text, xm y+12 cblue G%f@f@%kfk#k#kffkk#f@f@fff@kfkfk#f@, test gosub obfuscation in gui statement
gui, font, %k#fkfffk%%k#kff@f@kfk#k#fkkfk#%%fff@% norm
gui, add, text, xm y+12 Gk%k#k#%fk#k#kf%f@fkf@%f%f@ffkf%kk#f@f@fff@kfkfk#f@,
(
hello world
message in variable:
"%fkf@%%fkf@k#%%f@ffk#kfffk#%"

-press home key to test hotkeys-
)
gui, add, text, xm y+12, enter something here to test`nvariable obfuscation
gui, add, edit, xm y+2 Vf%k#kf%kk%ffffkf%#f%k#k#%kkfk# r4,
gui, add, button, xm y+20 Gf@kfk#%k#f@fk%f@f@k#k#k#k#fkk#fffkfkfkf@fkk#kf, Test gui submit
gui, add, button, x+20 yp Gk#f@f%ffkfkfff%k%kffff@%%k#fkkffk%fkkfk#fkkfk#fffkfkkffkk#f@ffff, Cancel program
gui, show
}
f@kfk#f@f@k#k#k#k#fkk#fffkfkfkf@fkk#kf:
gui, submit, nohide
msgbox, you entered "%fkk#fkkfk#%%k#k#k#%%f@ffkf%"
return
k#f@fkfkkfk#fkkfk#fffkfkkffkk#f@ffff:
exitapp
return
kfk#k#kffkk#f@f@fff@kfkfk#f@:
msgbox, inside _guigosub_
return
k#kfkffkk#f@fffk(fffkf@ffk#f@) {  
global
static f@fkkfffk#f@kf, f@k#f@fffkkfk#fkf@fff@, f@kffkfkkffffkkfkfffk#, fkk#ffk#f@f@k#f@, k#k#fffffff@f@f@f@f@ff, fkkfkffkfkf@kf
k#fk%fkkffkkf%k#kffk = % "0123456789abcdef"
fkfkk#%fkfffk%fff@f@ff(f%kfff%f%ffk#%%ffk#ff%fkf@ffk#f@)
fff%k#fkkffk%kf@%fkf@%ff%fff@f@%k#f@ = % substr(fffkf@%k#f@ffk#%ffk#f@, 1, 1) . substr(fffkf@f%kfffk#%fk#f@, 6)
f@%fkkfff%k#f@fffkkfk#fkf@fff@ = % strlen(fffkf%f@kfk#k#%@ff%ffkffk%k#f@)
f@%kfk#k#f@%fk%fkkfffk#%kfffk#f@kf =
loop, % strlen(fffk%f@ffk#%f@ffk#f@)
f@%k#fkfffk%fkkfffk#f@kf = % substr(%kff@%f%ffff%ffkf@ffk#f@, a_index, 1) . f@fkkff%kfk#ff%fk#f@kf
fffkf@%fkkfff%ffk#f@ = % f%kff@%@%kff@kf%fkkf%kff@%ffk#f@kf
f%f@f@%@fkk%f@kffkff%fffk#f@kf =
f%ffk#ff%@%f@ffk#%kf%fkk#ffkf%fkfkkffffkkfkfffk# = 1
while true
{
if (f@k%f@k#k#%ffkfkkffffkkfkfffk# >%kfk#f@%%kfk#k#f@%f@k#f@%ffkff@k#%fffkkfk#fkf@fff@)
break
fkk#ffk%fkf@k#%#f@f@k#f@ = % substr(fff%k#fk%kf@ffk#f@, f%fffkf@fk%@kffkfkkffffkkfkfffk#, 1)
fkk#f%ffffffk#%fk#%kfk#f@%f@f@%kfkfk#ff%k#f@ = % instr(k#fkk#k%fffkf@fk%ffk, fk%fkffk#%k%k#f@fk%#ffk#f@f@k#f@) - 1
k%fkffk#%#k#ff%ffkff@k#%fff%k#kf%ff@f@f@f@f@ff = % substr(fffk%k#fk%f@ffk%k#f@fk%#f@, f@kffkf%f@ffff%kkffffkkfkfffk# + 1, 1)
k#k#ff%f@f@kf%ffff%k#k#%f@f@f@f@f@ff = % instr(k#f%ffkfkfff%kk%ffkfk#f@%#%ffk#k#%kffk, k%k#f@fk%#%f@f@f@%k#fffff%fkk#ffkf%ff@f@f@f@f@ff) - 1
fkk#%k#k#%ffk#f@f@k#f@ := kff@k#%fkffff%kfkffffk(f%fkk#%kk#ff%kff@kf%k#f@f%k#f@%@k#f@)
k#k#fff%f@ffk#%ffff@f@f@f@f@ff := kff@k%kffkfk%#kfkffffk(k#%f@ffkf%k#fffffff@f@f@f@f@ff)
f%kfk#k#ff%kkfkffkfkf@kf = % fkk#f%kfk#k#f@%f%f@k#f@%k#f@f@k#f@ * 16 + %f@fkff%k#k#fffffff@f@f@f@f@ff
f@f%ffkfkfff%%f@kfk#k#%kkff%kff@kf%fk#f@kf .= chr(fkkfkf%f@f@%fkfkf@%f@fkf@%kf)
%kfk#kfk#%f@kf%ffkfk#f@%fkfkkf%kfkfk#ff%fffkkfkfffk# += 2
}
f@f%f@ffk#%%fkfkk#%kkff%fkk#%fk#f@kf = % f%fkffffkf%@f%fffk%@k#fkfkk#ffkf(f@f%fff@k#kf%kk%f@f@ff%f%kff@k#%ffk#f@kf)
return, f@f%f@fkf@%%kfk#ff%%k#f@fk%kkfffk#f@kf
}
fkfkk#fff@f@ff(k#f@k#kffffkkf) { 
global
%k#f@ffk#%k#k%kfk#kfk#%#kffffkff := "fff@kkf1ffkfkfkfff#k1fk@kf#@fffk@#kk"
kfk#%f@k#k#kf%f%fkkffkkf%@k#f@kf := "fff@f1ff@kffkk#f1fffffkf"
%k#k#kffffkff%%fkk#ffkf%%fkkfffk#%%fff@f@%%kfk#f@k#f@kf%%fkkfffk#%1 = % substr(k#f@k%k#k#fffk%#kffffkkf, 2, 1)
%ffkfk#f@%%fkf@%%k#k#kffffkff%%kfk#f@k#f@kf%%f@f@kf%%fffk%2 = % substr(k%k#fkfffk%#%ffkf%f@%kfff%k#kffffkkf, 3, 1)
%k#k#%%k#k#kffffkff%%fffkffkf%%kfk#f@k#f@kf%%f@ffk#%%ffk#k#%3 = % substr(k#%kfffk#%f@k#%fff@%kfff%k#f@ffk#%fkkf, 4, 1)
%ffk#ff%%k#k#kffffkff%%kfk#fk%%ffk#k#%%ffkfk#f@%%kfk#f@k#f@kf%4 = % substr(k#f@k#k%fkf@k#%ffffkkf, 5, 1)
loop, 4
%f@fk%%k#kf%%k#k#kffffkff%%a_index% = % instr(k#%fkfkk#%fkk#kffk, %k#k#k#%%k#k#kffffkff%%kfk#%%k#ffkf%%kfk#f@k#f@kf%%k#f@fk%%a_index%) - 1
ffkf%fff@f@%%ffffkf%%f@f@kf%f@k#f@ff = 0
}
kff@k#kfkffffk(f@k#ffkfffff) { 
global
ff%fkf@ffk#%kff%fkfffk%@k#%k#fk%f@ff++
if (ff%fkffffkf%kff@k#%fffk%f@ff > 4)
f%k#k#kfkf%fk%kff@k#%ff@%k#fkkffk%k#f@ff = 1
f@%fkk#ffkf%k%kffff@%#ff%fkf@fk%kfffff -= %kff@kf%%k#k#kffffkff%%k#f@ffk#%%k#k#fffk%%ffkff@k#f@ff%%fkffff%
if (f@%k#kff@fk%k#ff%f@f@%kfffff < 0)
f@k#%k#k#%ff%fkf@k#%kfffff += 16
return f@k#%fkk#%ffkfffff
}
f@f@k#fkfkk#ffkf(f@f@k#k#fffffkkf) { 
global
StringReplace, f@f@k#%f@fffkk#%k#fffffkkf, f@f@%k#fk%k#k#fffffkkf, % "````", % "``", all
StringReplace, f@f@k#k%fff@%#fffffkkf, f@f@%fkkfffk#%k#k#f%f@fkkf%ffffk%fkkfff%kf, % "``n", % "`n", all
StringReplace, f%kfkfk#ff%@f@k#%fkkffkkf%%kffkfk%k#fffffkkf, %kff@kf%%fkfk%f@f@k%f@kf%#k#fffffkkf, % "``r", % "`r", all
StringReplace, f@%f@ffkf%f@%fkk#fkf@%k#k#f%ffkfkf%ffffkkf, f@f@k#%k#kff@fk%k#fffffkkf, % "``,", % "`,", all
StringReplace, f@f@%f@fkff%k#k#ff%fffkff%fffkkf, f@f@k#%f@fk%k#fffffkkf, % "``%", % "`%", all
StringReplace, f@%fkkfff%f@k#k#fffffkkf, f%ffk#%@f@k#%fkfkk#%%ffk#ff%k#fffffkkf, % "``;", % "`;", all
StringReplace, f@f@%fkk#kff@%k#k#%k#k#kfkf%ff%kffkfk%fffkkf, f@%f@ffk#%f@k#%f@f@%%f@ffk#%k#fffffkkf, % "``t", % "`t", all
StringReplace, f@f@k#%k#k#k#%k#%f@ffkf%fffffkkf, f@f%fffkff%@k%k#kf%#k#ff%fkffff%fffkkf, % "``b", % "`b", all
StringReplace, f@f@k#%kfk#k#f@%k%f@kf%#fffffkkf, f@%k#kf%f@k#k#fffffkkf, % "``v", % "`v", all
StringReplace, f@f%fkk#kff@%@k#k%fkf@fk%#fffffkkf, %kfkfk#ff%f@f%f@k#k#%@k#k#fffffkkf, % "``a", % "`a", all
StringReplace, f@%f@k#f@%f@k#k#fffffkkf, f%k#fkk#%@f@k%kfk#%#k#fffffkkf, % """""", % """", all
return f@f%f@kffkff%@k#k%k#fkk#%#ffff%kfk#k#f@%fkkf
}
