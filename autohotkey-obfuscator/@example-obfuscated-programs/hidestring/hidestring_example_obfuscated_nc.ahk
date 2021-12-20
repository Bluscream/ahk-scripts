obf_copyright := " Date: 13:40 mercredi 12 juillet 2017           "
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
fff%kffffkfk%fk#k#fkfk = 1
kf%kfk#kf%kf%k#k#k#%f@%ffkffff@%f@ff = 0
msgbox, % "parameter: " . kffkkff%kffkk#fk%fkffffk(ff%k#fkff%kfff%fff@kffk%%k#kfk#fk%fkffff("9bbb7ece"))
msgbox % "obfuscated text = " f%k#f@fffk%%f@fkf@%fkffffkffff("52161b976a57")
RETURN
kffkkfffkffffk(f@k#k#f@kffkfkk#) { 
global
f@k#k#f%fkfffk%@kffkf%k#f@fkkf%kk#:=f@%kffkk#fk%k#k#f%fkffk#%@k%ffk#kfkf%ffkfkk# + %f@kfffff%f@k#k%k#fkkf%#f%f@f@kf%@kffkfkk# - f@k#k%kffffk%#f@kffkfkk#
return "my parameter was: " . f%kffkk#%@k#k#f@kffkfkk#
}
ffkffffkffff(k#kffkkfk#fffkkf) {  
global
static k#fff@ffkffff@kff@ff, kfk#ffkff@fff@k#f@k#, fkfkffk#f@ffffkf, ffffffkff@fff@, fff@f@fkfkfkk#kfff, k#fkfkf@f@k#f@
fk%f@k#fkk#%f%k#fkf@kf%%k#fkkff@%kfffk = % "0123456789abcdef"
fkk%kfkff@%%k#fkf@kf%fk#f%kff@ffff%@f@ffk#kf(k%fkfkf@ff%#kffk%ffkffff@%k%ffkffff@%fk#fffkkf)
k#k%k#kfk#fk%ff%f@k#kffk%kkfk#fffkkf = % substr(%fkffk#%k#kff%fffk%k%ffk#f@f@%kfk#fffkkf, 1, 1) . substr(k#%f@kffk%kffkkfk#fffkkf, 6)
kfk#ffk%fkfkf@%ff@fff@k#f@k# = % strlen(k#kf%fff@kffk%fkkfk#fffkkf)
k#fff@%fkfkf@ff%ffkffff@kff@ff =
loop, % strlen(k#k%kffffk%ffkkfk#fffkkf)
k#ff%fkfffk%f@ffkffff@kff@ff = % substr(k#kffkk%ffffffkf%f%kfffff%k#fffkkf, a_index, 1) . k#fff@f%f@k#kff@%fkffff@kff@ff
k#k%fkffk#%ffkkfk#%f@k#k#%fffkkf = % k#fff@%f@f@fkfk%ffkffff@kff@ff
k#fff@f%k#f@fkkf%fkffff%fkff%@kff@ff =
%kfk#kfff%fkf%f@kfffk#%kffk#%fkffkfkf%f@ffffkf = 1
while true
{
if (fkfkf%fkfkffk#%fk#f@ff%fffk%ffkf >kfk%ffk#fffk%#ffkf%k#kfk#fk%f@fff@k#f@k#)
break
ffff%fkk#kf%ff%f@k#fkk#%kff@%k#fkfkk#%fff@ = % substr(k#kff%kfk#%kkfk#%kffffkfk%f%k#fkff%ffkkf, fkfk%k#kfk#fk%ffk#f@ffffkf, 1)
f%k#fkf@kf%fffffkff@fff@ = % instr(%f@ffffff%fkfkfffk, %kffkff%ffff%k#f@fkkf%ffkf%f@f@kf%f@fff@) - 1
fff@%k#fkff%f@f%f@kff@k#%kfkf%f@kfffk#%kk#kfff = % substr(k#%f@f@kf%%ffk#f@f@%kffkkfk#fffkkf, fkf%k#fkfkk#%kffk#f@ffffkf + 1, 1)
fff%k#fkf@kf%@f@f%kfk#kf%kfkfkk#kfff = % instr(f%fkkfffk#%kf%f@f@fff@%k%kfkff@kf%fffk, fff@f@%k#f@ffkf%f%f@f@fkfk%k%kffkk#fk%fkfkk#kfff) - 1
ff%kffkk#fk%ffffkff@fff@ := f@%f@fk%kf%kffffkfk%k#f@fkk#fkf@(ff%kfffff%ffffkff@fff@)
fff%k#fkff%@f@f%ffkffkf@%k%fkkff@%fkfkk#kfff := f@kfk%fkkff@%#f@fkk#fkf@(fff%k#kff@fk%@%f@k#kff@%f@f%ffk#kfkf%kfkfkk#kfff)
k#fk%fkff%fkf@%f@f@k#ff%%kffffffk%f@k#f@ = % fff%fffff@f@%fffkf%fkf@ff%f@fff@ * 16 + fff@f@%fkkffkf@%f%fkffkfkf%kfkfkk#kfff
k#fff@%fkkfffk#%ffkff%f@f@k#ff%ff@%f@ffffff%kff@ff .= chr(k#fk%f@fkk#k#%fkf@f%kffkfk%@k#f@)
fkfk%k#kfff%ffk#f@f%ffkffff@%fffkf += 2
}
k%kfk#ff%%k#f@fffk%#fff%k#fkfkk#%@ffkffff@kff@ff = % fkf@k%f@ffffff%#ffffkf(k#ff%kfkf%f%ffffff%@ffkffff@kff@ff)
return, %k#f@ffkf%k#ff%f@f@fkf@%f@ffkffff@kff@ff
}
fkkfk#f@f@ffk#kf(fkfff@f@k#kff@) { 
global
fk%ffk#f@f@%k#%ffk#f@f@%f@k#ff := "fff@kkf1ffkfkfkfff#k1fk@kf#@fffk@#kk"
%fkkfffk#%fffkk%kfffk#%ff@ff := "fff@f1ff@kffkk#f1fffffkf"
%fkk#f@k#ff%%f@f@fff@%%f@ffffff%%f@k#%%fffkkff@ff%%f@kfffk#%1 = % substr(fk%f@f@fkfk%fff%fkfkf@%%kffkff%@f@k#kff@, 2, 1)
%k#fkkf%%fkk#f@k#ff%%f@f@fkf@%%kfk#kfff%%fffkkff@ff%%f@ffkfkf%2 = % substr(fkfff%kfk#%@f@%fkfkf@%k#kff@, 3, 1)
%fkk#f@k#ff%%fkffkfkf%%f@kfffk#%%f@fkk#k#%%fffkkff@ff%%fkk#fk%3 = % substr(fkf%fkffkfkf%ff@%k#kff@fk%f%kffffkff%@k#kff@, 4, 1)
%fkk#f@k#ff%%k#k#f@k#%%ffkffkf@%%kfffff%%fffkkff@ff%%ffk#f@f@%4 = % substr(fkff%f@k#kffk%f@f@k#kff@, 5, 1)
loop, 4
%kfkff@kf%%fkk#fk%%fkk#f@k#ff%%a_index% = % instr(fkfk%k#fkkf%fffk, %fff@kffk%%fkk#f@k#ff%%fffffff@%%ffk#kfkf%%kff@ffff%%fffkkff@ff%%a_index%) - 1
kff@k# = 0
}
f@kfk#f@fkk#fkf@(ffffk#kff@kf) { 
global
kff@k#++
if (k%f@k#k#%%fkfkffk#%%f@f@k#ff%ff@k# > 4)
%kfffk#%kf%fkkffkf@%f@%fkk#kf%k# = 1
%fkfkffk#%fff%kff@f@ff%fk#%f@fkk#k#%kff@kf -= %k#fkf@kf%%fkk#f@k#ff%%f@f@fff@%%kff@k#%%k#kffffk%%f@f@kf%
if (ffffk%f@f@k#ff%#kff@%k#k#ffkf%kf < 0)
fff%fkfffkf@%fk#kff@kf += 16
return %fkf@k#%ff%f@ffkfkf%ff%f@fkk#k#%k#kff@kf
}
fkf@k#ffffkf(kfffkffffffkk#) { 
global
StringReplace, %ffk#%kf%k#fkfk%ff%kfkf%kffffffkk#, kfffk%kffffkfk%ffffffkk#, % "````", % "``", all
StringReplace, k%fkfffkf@%fffkffffffkk#, kfffk%fkf@%ffffffkk#, % "``n", % "`n", all
StringReplace, kfff%f@fkk#k#%kf%k#k#k#%fffffkk#, kff%k#f@fffk%%f@fkk#k#%fk%k#f@fkkf%ffffffkk#, % "``r", % "`r", all
StringReplace, k%f@k#%fffkffffffkk#, k%k#kffffk%f%k#k#%f%ffkffff@%fkffffffkk#, % "``,", % "`,", all
StringReplace, k%f@ffffff%fffk%f@kfffff%f%f@ffkfkf%fffffkk#, %k#kffffk%kfffkffffffkk#, % "``%", % "`%", all
StringReplace, kfffk%fffk%ffffffkk#, kf%kffffkff%ffkfff%kfk#%fffkk#, % "``;", % "`;", all
StringReplace, k%kffffffk%ff%kfkf%f%kff@f@ff%kffffffkk#, kfffkff%k#k#fkf@%ffffkk#, % "``t", % "`t", all
StringReplace, kfffkf%fkff%f%fffffff@%ffffkk#, kff%kfffk#%fkff%k#f@f@fk%%f@f@k#ff%ffffkk#, % "``b", % "`b", all
StringReplace, %k#kfk#fk%k%f@fkk#k#%fffk%fkfffkf@%ffffffkk#, %f@k#kff@%kfff%f@ffkfkf%kffffffkk#, % "``v", % "`v", all
StringReplace, kff%ffffff%f%f@k#k#%kff%f@k#kff@%ffffkk#, kfffk%f@f@kf%ffffffkk#, % "``a", % "`a", all
StringReplace, kfffkff%k#kfk#fk%ffffkk#, kfff%f@kfffk#%k%k#k#f@k#%%fkkffkf@%ffffffkk#, % """""", % """", all
return k%kfk#fk%fffk%f@k#fkk#%ffff%k#kff@fk%ffkk#
}
