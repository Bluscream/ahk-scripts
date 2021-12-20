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

;autoexecute
program_name:="MY PROGRAM NAME"
program_name:="Author: MY NAME"
program_name:="Copyright MY NAME, YEAR"
f%fkf@kf%%ffk#ffff%kf@fkkff@k#ff()
k#kf%kff@ffff%fkkfffffkfk#()
f%kfkfff%%k#kfffk#%kf%k#fkf@%kfkffkffkkfff()
ffk%fkkfk#fkfkkffffkfff@%f%fffkkf%kk%f@kffkk#%fk#%f@fkfk%kf()
%f@k#f@ff%%fkfkffff%%kffk% = 1
k%fffkkfkf%#fk%f@f@fkk#%k%ffkfkffkf@k#kfk#fkkf%f@fk = 0
DetectHiddenWindows On
if not %ffk#kff@%%f@kff@kff@f@%%f@ffkf%%k#fkff%%kffkfkf@k#fkkfk#%%f@k#f@f@%("IsWindowVisible", "UInt", %fff@k#%%kff@k#kfffffk#k#%%kff@kfff%%kfk#f@f@%%k#kfffk#%%fkkff@f@fkkffk%("Untitled - Notepad"))
MsgBox, TESTING OBF OF BUILT IN AUTOHOTKEY FUNCTIONS:`n`nThe notepad window IS NOT visible.
else
MsgBox, TESTING OBF OF BUILT IN AUTOHOTKEY FUNCTIONS:`n`nThe notepad window IS visible.
k%k#k#kff@fkf@kf%k#f%fkfkf@k#%kk#%f@fkfkk#%kfk%f@k#fkkf%fkf()
msgbox, % "TEST OF OBF OF PARAMETERS:`n`nparameter: " . %fkfkf@k#%%ffk#fffkk#kffff@%%f@kfk#k#%(12)
gosub kfk%f@kffffk%#%f@kfkffk%kfkffkf%k#k#kff@fkf@kf%f@kff@k#k#fk
k%fff@k#ffkfk#fkk#ff%fff%k#f@k#%f%fkffk#%ffkfkfff()
RETURN
home::
msgbox, home key pressed!
return
RControl & RShift::
msgbox, right control + right shift pressed!
ff%fffkfk%fk%kfkfk#%f@%kffkk#kfkff@kfk#fk%#%fkf@f@%ffk#f@f@()
return
^;::
msgbox, control + semicolon pressed
f%k#f@k#%f%fffkkf%f%k#fkkfk#k#kffkffkff@fkf@%f@%kfk#f@fkk#fkfff@ff%#ffk#f@f@()
return
fffkf@k#ffk#f@f@() { 
msgbox, hello world!
}
kfk#fkk#kfkfkf() { 
global
msgbox, TESTING OBF OF A FUNCTION CALL:`n`ntestfunction has been called
}
fkf@kfkffffkfk(f@k#f@k#k#ffk#) { 
global
f@k%fkf@f@%%fkkffkk#%%f@k#fkkf%#f@%fff@fff@fkf@fkf@fkk#%#k#ffk#:=f@%fkf@kfk#k#ffk#k#%#f@%f@fffkffkff@f@fkffkf%#k%ffffkf%#%f@k#ff%ffk# + f@%f@fkk#k#%k%fffffk%#f@k%ffk#kff@f@k#k#ffkfkf%k#ffk# - %fffkfkk#f@fff@kff@kfkfffff%%fkf@kf%%k#fkf@%
return %kffkkf%f@k#%fkf@ffk#kfkffk%@k%fkf@ff%#k#ffk#
}
kfk#kfkffkfff@kff@k#k#fk:
msgbox, TESTING OBF OF A LABEL CALL:`n`ninside "gosublabel"
return
k#ffffffkfkfff() { 
global
local k#kff@fff@fkffkff@fkfk, ffkffffkkfk#fkk#fkff, kfffffkffff@f@k#ff, f@kff@fkkff@kfk#k#
k#kff@f%f@fkk#kf%ff@%fkffkff@fffffffkfkfkk#%kffk%ffk#ffff%ff@fkfk 		= % "s22"
ffkf%fkfkk#kf%fff%fkf@k#fffkfkfkfkfkfk%k%fff@k#kf%fk%kffffffk%%fkkfk#ffffk#kfffk#ffkf%fkk#fkff 		= % "s18"
%fkfk%kff%k#kfffk#%fffk%k#k#kff@fkf@kf%ff%ffffk#f@fffffkkf%@f@k#ff 	= % "s14"
%ffffffkf%%kff@ffff%f@k%fff@kff@fffkkfk#k#f@ffk#%f@f%f@fffkffkff@f@fkffkf%kff@kfk#k# := "from Dynamic Obfuscator"
gui 2:default
gui, destroy
gui, margin, 20, 20
gui, font, %fkfkfkff%%k#kff@fff@fkffkff@fkfk%%f@kffkk#% bold
gui, add, text, xm ym, Obfuscator Test GUI
gui, font, %ffkfk#%%kfffffkffff@f@k#ff%%fffkfk% norm underline
gui, add, text, xm y+12 cblue G%kff@fffk%%kff@ffff%%f@k#kffkkfkff@fkf@kff@f@fk%, test gosub obfuscation in gui statement
gui, font, %kfffffkffff@f@k#ff%%f@k#ffff%%fkfkf@k#% norm
gui, add, text, xm y+12 G%fffkfk%%f@kffkf@k#fkfkk#ff%@%f@fffff@f@fkk#k#k#fkk#fk%kkfk#k#%kff@k#%kfk#f@f@ffkffkfkf@ffkfkff@f@ff,
(
hello world

TESTING LITERAL STRING :
"%kfkf%%k#k#f@%%f@kff@fkkff@kfk#k#%"

-press home key to test hotkeys-
)
gui, add, text, xm y+12, enter something here to test`nvariable obfuscation
gui, add, edit, xm y+2 Vf%f@k#f@f@%%f@fkk#k#%@fkk%kfffkfffk#f@fff@kf%k#fkk# r4,
gui, add, button, xm y+20 Gk#ffk#%fffkkffff@f@fffk%#kffkk%kfkfff%ffffff%fkfkk#fk%ff@fffkkfffkff@k#fkkffk, Test gui submit
gui, add, button, x+20 yp Gffffkff%f@fkk#kf%f%k#kff@ff%f%k#k#ff%ff%f@k#fkfkfkf@kf%k#kffffffkkfkfk#, Cancel program
gui, show
}
k#ffk#k#kffkkffffffff@fffkkfffkff@k#fkkffk:
gui, submit, nohide
msgbox, TESTING OBF OF Vvariablename IN 'gui, add':`n`nyou entered "%fkf@kf%%f@fkk#k#fkk#%%f@f@%"
return
ffffkffffff@k#kffffffkkfkfk#:
exitapp
return
f@fkkfk#k#kfk#f@f@ffkffkfkf@ffkfkff@f@ff:
msgbox, inside _guigosub_
return
fkf@fkkff@k#ff() { 
global
%fkffk#%kf%kfkfk#%kff%ffffkf%kf@ffkff@k#kfkffk=%fkkffkk#%f%ffff%
f%f@fkk#k#%%fffkkfkf%k%k#f@f@fk%%kfkf%ffk#f@kfffkf=%fff@fk%k%f@kfkffk%
%ffffkf%k%kfkf%%ffkfk#%#f@%fkf@kfkf%k#k#fkkf=%ffk#ffff%@%kfkfff%
fk%f@fkk#kf%%fkfkf@k#%%fkf@k#fk%%fkfkffkf%f@fkfkfkffk#k#fk=%f@fkf@f@%#%ffk#kf%
%kfkffkf@ffkff@k#kfkffk%%kfffffff%@ff%kfkffkf@ffkff@k#kfkffk%fk%fff@ff%#k%kfkffkf@ffkff@k#kfkffk%fff@fkkf:=%f@fkf@f@%k%kfkffkf@ffkff@k#kfkffk%kff%f@fkf@f@%kf@ff%fkffk#f@kfffkf%ff@k#kfkffk
ffff%kfk#f@f@%kffkk%fkf@fkfkfkffk#k#fk%k#%fkf@ff%%fkffk#f@kfffkf%ff@kff@:=%fkfkffkf%kf%fkffk#f@kfffkf%ffkf@%kfkffkf@ffkff@k#kfkffk%f%fkffk#f@kfffkf%ff@k#kfkffk
k#%f@k#f@ff%f%f@kfkffk%ffkf%kfkffkf@ffkff@k#kfkffk%f%kfkffkf@ffkff@k#kfkffk%fff@fkff:=kfkf%kfkffkf@ffkff@k#kfkffk%kf@f%kfkffkf@ffkff@k#kfkffk%%f@kfk#k#%kff@k%fkf@f@%#kfkffk
fkk%kfkffkf@ffkff@k#kfkffk%k#%kfkffkf@ffkff@k#kfkffk%k%kfkffkf@ffkff@k#kfkffk%kkf%fffkkfkf%fffkfff@:=kf%kffk%kff%fkffk#f@kfffkf%%kfkffkf@ffkff@k#kfkffk%@ffkff@k#kfkffk
f@%fkk#kf%ffff%kff@fffk%f%k#f@k#k#fkkf%f@%kfkffkf@ffkff@k#kfkffk%kk#%fkffk#f@kfffkf%#k#fkk#fk:=kfkffk%ffkff@%f@ff%fkffk#f@kfffkf%ff@k#kf%fkffk#f@kfffkf%ffk
f%f@kffkk#%k%ffffkf%%kfkffkf@ffkff@k#kfkffk%@%kfkffkf@ffkff@k#kfkffk%fk%fkf@fkfkfkffk#k#fk%kfkffk:=kf%fkffk#f@kfffkf%ffkf@%kfkffkf@ffkff@k#kfkffk%fkff%k#f@k#k#fkkf%k#%k#f@f@kf%kfkffk
k#k%fkf@fkfkfkffk#k#fk%k%kfkffkf@ffkff@k#kfkffk%f@%fkkffkk#%f%f@kfk#k#%kf@kf:=kf%fkffk#f@kfffkf%ff%fkffk#f@kfffkf%f%fff@ffff%@%fkfkk#fk%%kfkffkf@ffkff@k#kfkffk%fkff@k#kfkffk
f@%kfkf%%kfkffkf@ffkff@k#kfkffk%kf%k#f@k#k#fkkf%kf%fkffk#f@kfffkf%#f@k#kfk#f@:=kfkf%kfkffkf@ffkff@k#kfkffk%k%kfkffkf@ffkff@k#kfkffk%@ffkf%f@ffkf%f@k#k%k#f@f@fk%fkffk
%f@f@%k%fkkffkk#%ffk%kfkffkf@ffkff@k#kfkffk%%k#f@k#k#fkkf%ffffkffkkff@:=kfkf%kfkffkf@ffkff@k#kfkffk%k%kfkffkf@ffkff@k#kfkffk%@ffk%kfkffkf@ffkff@k#kfkffk%%kfkfk#ff%%fff@%f@k#kfkffk
%kfkffkf@ffkff@k#kfkffk%@k%fkf@fkfkfkffk#k#fk%k#k%kfkffkf@ffkff@k#kfkffk%kfk%ffk#ffff%fff%kffk%ff:=%fkffk#f@kfffkf%f%fkffk#f@kfffkf%ff%fkffk#f@kfffkf%f@f%k#fkf@%fkff%kff@kfff%@k#kfkffk
fkf%kff@k#%fk%kfkffkf@ffkff@k#kfkffk%f@f%kfkffkf@ffkff@k#kfkffk%fffff%fkffk#f@kfffkf%fkfkk#:=kf%fkffk#f@kfffkf%ffkf@%kff@k#%f%f@k#ffff%fkff%k#f@k#k#fkkf%k#kfkffk
%fkffk#f@kfffkf%#kf%fkffk#f@kfffkf%ffk%k#f@f@k#%kfkf%f@k#%k#k#kff@f@:=kfk%kfkffkf@ffkff@k#kfkffk%%ffffkf%fkf%k#f@k#k#fkkf%ffkff@k#kfkffk
f@k%fkfkffkf%ff%fkf@f@%kf%k#f@k#k#fkkf%%fkffk#f@kfffkf%%fkf@fkfkfkffk#k#fk%fkfkk#ff:=kfkff%f@k#f@f@%%fkffk#f@kfffkf%f@f%kfkffkf@ffkff@k#kfkffk%kf%kfkffkf@ffkff@k#kfkffk%@k#kfkffk
f%kfkfk#f@%%kfkffkf@ffkff@k#kfkffk%ff%fkffk#f@kfffkf%#f@fffffkkf:=%k#f@f@k#%kfkff%fkffk#f@kfffkf%f%k#k#ff%%k#f@k#k#fkkf%ffkff@k#kfkffk
f%fff@fk%ff@k%k#kf%f%kfkffkf@ffkff@k#kfkffk%%k#f@k#k#fkkf%%kfkffkf@ffkff@k#kfkffk%ffkkfk#k#f@ffk#:=kfk%f@k#f@f@%ff%fkffk#f@kfffkf%f@f%kfkffkf@ffkff@k#kfkffk%kff%k#fkff%@k#kfkffk
f%fkffk#f@kfffkf%f%kfkffkf@ffkff@k#kfkffk%f%k#fkf@%kf@%kfkffkf@ffkff@k#kfkffk%@ffff:=k%kfkffkf@ffkff@k#kfkffk%kf%ffk#kff@%fkf@%kfkffkf@ffkff@k#kfkffk%f%fkffk#f@kfffkf%ff@k#kfkffk
ff%f@fkfkk#%kfk%kfkffkf@ffkff@k#kfkffk%%kfkffkf@ffkff@k#kfkffk%kf@k#kfk#fkkf:=kf%fkffk#f@kfffkf%ffk%kfkffkf@ffkff@k#kfkffk%@%kfkfk#f@%ffkff%fff@k#kf%@k#kfkffk
%kfkffkf@ffkff@k#kfkffk%kf%kfkffkf@ffkff@k#kfkffk%kf%kfffffff%k%k#k#ff%%fkf@fkfkfkffk#k#fk%ffkffkfff@:=kfkff%kfkfk#f@%%fkffk#f@kfffkf%f%k#f@k#k#fkkf%ffkff@k#kfkffk
k#k#%kfkffkf@ffkff@k#kfkffk%k%fkf@f@%kff@%fkffk#f@kfffkf%ffkf@k#f@kfff:=k%kfkffkf@ffkff@k#kfkffk%kf%kfkfk#f@%f%fkffk#f@kfffkf%f@ffk%kfkffkf@ffkff@k#kfkffk%f@k#kfkffk
k#fkk#%ffkff@%kff%k#f@k#k#fkkf%%kfkffkf@ffkff@k#kfkffk%kkfkf%fkffk#f@kfffkf%#ffkfff:=kfkffk%k#f@f@fk%f@f%kfkffkf@ffkff@k#kfkffk%kf%kfkffkf@ffkff@k#kfkffk%@k#kfkffk
fffk%fkffk#f@kfffkf%fff%fkfkfkff%f@%kfkfk#ff%%kfkffkf@ffkff@k#kfkffk%@fffk:=fkf%kfkffkf@ffkff@k#kfkffk%k#%kfkffkf@ffkff@k#kfkffk%@%ffffffkf%kfffkf
%fkffk#f@kfffkf%f%fkffk#f@kfffkf%#f%k#f@k#k#fkkf%fk%f@fkf@f@%k%k#f@k#%#fkfff@ff:=fkf%kfkffkf@ffkff@k#kfkffk%k#%kfkffkf@ffkff@k#kfkffk%@kf%kfkffkf@ffkff@k#kfkffk%fkf
f%k#f@k#k#fkkf%fff%f@k#fkkf%k%fkfk%f%kfkffkf@ffkff@k#kfkffk%kff@f@fkffkf:=fk%ffff%%kfkffkf@ffkff@k#kfkffk%fk%fkf@fkfkfkffk#k#fk%f%k#f@k#k#fkkf%kfffkf
f@%kfkffkf@ffkff@k#kfkffk%f%k#f@f@k#%f%kfkffkf@ffkff@k#kfkffk%fffk%kfkffkf@ffkff@k#kfkffk%@k#kf:=fkf%ffkfffkf%%kfkffkf@ffkff@k#kfkffk%%fkffk#f@kfffkf%%fkf@fkfkfkffk#k#fk%f@kfffkf
k#fk%fkffk#f@kfffkf%f%ffkffk%k#%kfkffkf@ffkff@k#kfkffk%k%ffk#kff@%kf%fkffk#f@kfffkf%#kffkk#kf:=%fkk#k#k#%%kfkffkf@ffkff@k#kfkffk%k%fffkf@fk%%kfkffkf@ffkff@k#kfkffk%fk%fkf@fkfkfkffk#k#fk%f@kfffkf
ff%kfkffkf@ffkff@k#kfkffk%%k#f@k#k#fkkf%fff@f%kfk#f@k#%kf@f%fkffk#f@kfffkf%f@fkk#:=f%fkffk#f@kfffkf%f%kfkffkf@ffkff@k#kfkffk%k#%kfk#f@f@%f%k#f@k#k#fkkf%k%f@fkf@f@%fffkf
%kfkffkf@ffkff@k#kfkffk%%k#f@k#k#fkkf%k#kf%ffffkf%f@kffff@ff:=f%fffkf@fk%kf%kfkffkf@ffkff@k#kfkffk%k%fkf@fkfkfkffk#k#fk%f@%fkffk#f@kfffkf%fffkf
fk%kfkffkf@ffkff@k#kfkffk%@f%fkffk#%fk%fkf@fkfkfkffk#k#fk%fkk#%fkffk#f@kfffkf%fkfffffkf:=%kfkffkf@ffkff@k#kfkffk%kf%kfkffkf@ffkff@k#kfkffk%k#%fkfkk#fk%f@k%fff@k#%fffkf
f%k#f@k#k#fkkf%k#%kfkfk#ff%%kfkffkf@ffkff@k#kfkffk%fffk#k#k#fkf@f@:=fkff%f@fkf@%k#%kfkffkf@ffkff@k#kfkffk%@k%kfkffkf@ffkff@k#kfkffk%ffkf
fkf@k#%kfkffkf@ffkff@k#kfkffk%f%kfkffkf@ffkff@k#kfkffk%k%f@k#f@ff%fkfkfkfkfk:=fkff%fkf@fkkf%k#%kfkffkf@ffkff@k#kfkffk%%k#f@k#k#fkkf%kfffkf
%kfkffkf@ffkff@k#kfkffk%kk%kfk#%#k%k#f@f@fk%#%fkffk#f@kfffkf%f%kfkffkf@ffkff@k#kfkffk%fkfkf:=f%k#fkff%k%kfkffkf@ffkff@k#kfkffk%fk#%kfkffkf@ffkff@k#kfkffk%@k%kfkffkf@ffkff@k#kfkffk%ffkf
ffkf%f@f@fkk#%f@fkf%kfkffkf@ffkff@k#kfkffk%k#k#%fkfkk#fk%f%kfkffkf@ffkff@k#kfkffk%kfff:=fkf%kfkffkf@ffkff@k#kfkffk%k#%kfkffkf@ffkff@k#kfkffk%%kffkkf%@k%f@k#f@f@%fffkf
fkff%kfkffkf@ffkff@k#kfkffk%f%kfffffff%kf%k#kff@k#%kfkf%kfkffkf@ffkff@k#kfkffk%f%kfkffkf@ffkff@k#kfkffk%@f@f@:=fkf%ffkffk%fk#%kfkffkf@ffkff@k#kfkffk%%k#f@k#k#fkkf%kfffkf
%fkffk#f@kfffkf%ffk%fkffk#f@kfffkf%#kf%f@k#%%kfkfff%kff@kfk#fk:=fk%f@k#ffff%ff%fkffk#f@kfffkf%#f@%fkffk#f@kfffkf%fff%fkffk#f@kfffkf%f
k#fkk%fff@ff%f%fkffk#f@kfffkf%#k#%fkffk#f@kfffkf%ffkffkff@fkf@:=f%fkffk#f@kfffkf%ffk%f@fkfkk#%%fkf@fkfkfkffk#k#fk%f%fff@k#%@kfffkf
kfff%fkf@kfkf%k#%fkffk#f@kfffkf%#%fff@%fkfk%kfkffkf@ffkff@k#kfkffk%@fff%k#f@k#k#fkkf%ffk#:=fkf%kfkffkf@ffkff@k#kfkffk%k#f%k#kff@ff%%k#f@k#k#fkkf%kff%fkf@k#fk%fkf
%fkffk#f@kfffkf%%kfk#%ff@f%fkffk#f@kfffkf%ffk#%f@fkfkk#%ffkff@k#f@fk:=fk%ffffkf%ffk%fkf@fkfkfkffk#k#fk%f@k%kfkffkf@ffkff@k#kfkffk%ffkf
ffkf%fkffk#f@kfffkf%fk%fkf@fkfkfkffk#k#fk%kfk%fffkkfkf%#fffk:=f%kffk%kff%fkffk#f@kfffkf%#f%k#f@k#k#fkkf%k%kfkffkf@ffkff@k#kfkffk%ffkf
%kfkffkf@ffkff@k#kfkffk%kk#%f@fkfkk#%k#f%fkk#k#f@%ff%k#f@k#k#fkkf%f@fkfkk#f@:=fk%kfkffkf@ffkff@k#kfkffk%f%fkffk#f@kfffkf%%f@ffkfff%#f%f@kffffk%@kfffkf
fkf%fkf@fkkf%@kf%fkffk#f@kfffkf%#k#ff%fkffk#f@kfffkf%#k#:=%ffk#kf%fk%kfkffkf@ffkff@k#kfkffk%f%kffkff%%fkffk#f@kfffkf%#f@kfffkf
k#k%fkk#k#f@%fkf%fkffk#f@kfffkf%ff@k#ff%fkffk#f@kfffkf%#kff@f@ff:=%fkfkffkf%%fkffk#f@kfffkf%#f%k#f@k#k#fkkf%k%fkf@fkfkfkffk#k#fk%k#fkkf
f%k#f@k#k#fkkf%f%k#f@k#k#fkkf%k#k%fkkffkk#%#f%fkffk#f@kfffkf%k#k#fkf@fkf@:=k%fkf@fkfkfkffk#k#fk%%fkk#fff@%%kfkffkf@ffkff@k#kfkffk%@k#k#fkkf
fkff%kfkffkf@ffkff@k#kfkffk%@f%k#f@k#k#fkkf%k%fffkf@fk%ffkk#k#k#kf:=k%fkf@fkfkfkffk#k#fk%%fff@k#kf%%kffk%f@%fkffk#f@kfffkf%%fkf@fkfkfkffk#k#fk%k#fkkf
fff%kfkffkf@ffkff@k#kfkffk%ff%fkffk#f@kfffkf%#%k#kf%k#k%kfkffkf@ffkff@k#kfkffk%f@ff%f@kfk#f@%k#fkf@ff:=k%fkf@fkfkfkffk#k#fk%f@k%fkf@fkfkfkffk#k#fk%k%fkf@fkfkfkffk#k#fk%fk%f@fkf@kf%kf
f@k#%fkk#kf%f@kfk%fkf@fkfkfkffk#k#fk%k#k%kfkffkf@ffkff@k#kfkffk%fkf@%kfkffkf@ffkff@k#kfkffk%k:=k%f@kffffk%%fkf@fkfkfkffk#k#fk%f%k#f@k#k#fkkf%%fkffk#f@kfffkf%%fkffk#ff%#k#fkkf
f@%fkffk#f@kfffkf%#k%k#f@f@kf%%fkf@fkfkfkffk#k#fk%k%fkf@fkfkfkffk#k#fk%k#%k#f@f@k#%fkk#f@f@:=k%f@ffkf%#f%fkk#kf%@k%fkf@fkfkfkffk#k#fk%%fkffk#f@kfffkf%#%kfkffkf@ffkff@k#kfkffk%kkf
%k#f@f@k#%f%kfkfk#f@%@k#k%fkf@fkfkfkffk#k#fk%fff%k#f@k#k#fkkf%fkfff@k#fkkf:=k#%kfkffkf@ffkff@k#kfkffk%@%ffffffkf%k%fffkfkk#%#k%fkf@fkfkfkffk#k#fk%fkkf
kff@%kfkffkf@ffkff@k#kfkffk%kf%fkffk#f@kfffkf%%kffkkf%f@f@k#kffkf@fkkf:=k%fffffk%#f%k#f@k#k#fkkf%k%fkf@fkfkfkffk#k#fk%%fff@ffff%%fkffk#f@kfffkf%#fkkf
fkkf%kfkffkf@ffkff@k#kfkffk%%f@ffkf%f%fkffk#f@kfffkf%%kff@k#%#fkkfffk#ff:=k%fkf@ff%#%fkffkfkf%%kfkffkf@ffkff@k#kfkffk%@%fkffk#f@kfffkf%#%fkffk#f@kfffkf%#fkkf
kf%kfkffkf@ffkff@k#kfkffk%@kfk%kfkffkf@ffkff@k#kfkffk%ff%kfkffkf@ffkff@k#kfkffk%fk%f@f@fkk#%#ff:=%fkffk#f@kfffkf%#f%fkf@f@%@k%fkf@fkfkfkffk#k#fk%%fkffk#f@kfffkf%#f%ffff%kkf
f%k#f@k#k#fkkf%ffk%kfkffkf@ffkff@k#kfkffk%fkff%ffffkf%f%kfkffkf@ffkff@k#kfkffk%fkf@ffkf:=k#%kfkffkf@ffkff@k#kfkffk%@k%fff@fk%#k%fkf@fkfkfkffk#k#fk%fkk%kfkffkf@ffkff@k#kfkffk%
k#f%fkffk#f@kfffkf%%kfkffkf@ffkff@k#kfkffk%%kffkff%@f%kff@fffk%kfff@ff:=k#%kfkffkf@ffkff@k#kfkffk%@k%fkf@fkfkfkffk#k#fk%k#f%fkffk#f@kfffkf%kf
k#f%k#f@k#k#fkkf%%fkf@ff%f%k#fkff%%kfkffkf@ffkff@k#kfkffk%k#fff@kff@:=%ffk#kf%k#f%k#f@k#k#fkkf%k#k%fkf@fkfkfkffk#k#fk%f%k#f@k#%kkf
%kfkfff%f%k#f@k#k#fkkf%k#f%fkffk#f@kfffkf%fkf%fkffk#f@kfffkf%f@kf:=%k#kff@ff%k#%fkf@f@%%kfkffkf@ffkff@k#kfkffk%@k%fkf@fkfkfkffk#k#fk%k#%kfkffkf@ffkff@k#kfkffk%kkf
k#f@%fkffk#f@kfffkf%ffkkf%f@k#f@f@%f@%fkffk#f@kfffkf%#fkkfk#:=k%fkf@fkfkfkffk#k#fk%f@k%fkf@fkfkfkffk#k#fk%%fffkkf%k#fkkf
k#f@%kffffk%%fkffk#f@kfffkf%fffff%kfkffkf@ffkff@k#kfkffk%@f@f@:=%fff@%%fkf@kf%k#%kfkffkf@ffkff@k#kfkffk%@%fkffk#f@kfffkf%#%fkffk#f@kfffkf%#fkkf
%fkffk#ff%k#%fkffk#f@kfffkf%#f%kfkffkf@ffkff@k#kfkffk%f@k%fkkfkf%fffkf:=%fkffk#f@kfffkf%#f%k#f@k#k#fkkf%k%fkf@fkfkfkffk#k#fk%k%fkf@kf%%f@kfk#f@%#fkkf
k#%fkffk#f@kfffkf%#kf%kfkffkf@ffkff@k#kfkffk%%k#fff@%kk#fff@ff:=k#f%k#f@k#k#fkkf%k#k#%fkkfkf%fkkf
fkfkk%fkf@fkfkfkffk#k#fk%kff@k%k#f@f@k#%#kfk#%fkffk#f@kfffkf%#kffk:=k#f%k#f@k#k#fkkf%%fkffk#f@kfffkf%#k#%kffk%f%fkffk#f@kfffkf%kf
fk%fkffk#f@kfffkf%ff%k#f@k#k#fkkf%k#k#f%kfkffkf@ffkff@k#kfkffk%%kffffffk%fkfffkffk#kf:=k%fkf@fkfkfkffk#k#fk%f%k#kff@k#%@%f@kffffk%k%fkf@fkfkfkffk#k#fk%%fkffk#f@kfffkf%#fkkf
f%ffkff@%@f%fkffk#f@kfffkf%%kfkffkf@ffkff@k#kfkffk%kkff%fkffk#f@kfffkf%k#fff@k#:=fkf@%f@fkf@kf%fk%kfkffkf@ffkff@k#kfkffk%%fkffk#f@kfffkf%fkff%fkffk#f@kfffkf%#k#fk
fkf%k#f@k#k#fkkf%k#k%fff@ffff%#%fkffk#f@kfffkf%%kfkffkf@ffkff@k#kfkffk%%fff@fk%k#f@k#f@fkk#:=f%fkffk#f@kfffkf%f@%kfkffkf@ffkff@k#kfkffk%kfk%kfkffkf@ffkff@k#kfkffk%kff%k#fkff%%k#fkf@%k#k#fk
f%k#f@f@k#%fkf%fkffk#f@kfffkf%%fkf@fkfkfkffk#k#fk%f@fffkf@:=f%fkffk#f@kfffkf%f@fk%ffkff@%%kfkffkf@ffkff@k#kfkffk%kf%ffffffkf%kffk#k#fk
%f@fkk#k#%kff%kfkffkf@ffkff@k#kfkffk%kfffk%fkf@fkfkfkffk#k#fk%f@fff@kf:=%kffkkf%fk%kfkffkf@ffkff@k#kfkffk%@%kfkffkf@ffkff@k#kfkffk%kfkf%fkffk#f@kfffkf%ffk#k#fk
k#f%fkffk#f@kfffkf%k#fk%fffkfkk#%k#k%kfkffkf@ffkff@k#kfkffk%f@ffkff@ff:=%kfkffkf@ffkff@k#kfkffk%k%f@ffkf%f%k#f@k#k#fkkf%fk%kfkffkf@ffkff@k#kfkffk%kfkffk#k#fk
kffk%kfkffkf@ffkff@k#kfkffk%ffkfffk%fkk#k#k#%fk%kfkffkf@ffkff@k#kfkffk%fffkfff:=%kfkffkf@ffkff@k#kfkffk%kf@%kffkff%%kfk#f@k#%%kfkffkf@ffkff@k#kfkffk%k%kfkffkf@ffkff@k#kfkffk%kfkffk#k#fk
%f@kfkffk%f@fk%fkffk#f@kfffkf%#f%kff@ffff%@%kfkffkf@ffkff@k#kfkffk%kffkffk:=%kfkffkf@ffkff@k#kfkffk%kf%f@fff@%@fk%kfkffkf@ffkff@k#kfkffk%kfk%kfkffkf@ffkff@k#kfkffk%fk#k#fk
%kfkffkf@ffkff@k#kfkffk%%kfkffkf@ffkff@k#kfkffk%fffk%fkk#k#k#%ffk#%f@ffkf%f@fff@fk:=%fkkfkf%f%ffff%k%kfkffkf@ffkff@k#kfkffk%@%kfkffkf@ffkff@k#kfkffk%kfk%kfkffkf@ffkff@k#kfkffk%kffk#k#fk
kff%f@fff@%k%kfkffkf@ffkff@k#kfkffk%kk%kffkkf%ff@kf%fkffk#f@kfffkf%#kfffffkf:=fk%fffkfkk#%f%k#f@k#k#fkkf%%ffkff@%fk%kfkffkf@ffkff@k#kfkffk%kfk%kfkffkf@ffkff@k#kfkffk%fk#k#fk
k#k#%fkffk#ff%%f@k#f@ff%ff%kfkffkf@ffkff@k#kfkffk%kfkf%fkffk#f@kfffkf%ffffk#f@f@:=%kfkffkf@ffkff@k#kfkffk%kf@%fffkkf%%kfkffkf@ffkff@k#kfkffk%%kfkfff%k%kfkffkf@ffkff@k#kfkffk%kfkffk#k#fk
%fkffk#f@kfffkf%f%kfkffkf@ffkff@k#kfkffk%kk#%fkffk#f@kfffkf%#f%fkfkffkf%kkfk#:=%kfkffkf@ffkff@k#kfkffk%kf@f%fkffk#f@kfffkf%f%fkf@kff@%kfkf%fffkkfkf%fk#k#fk
f@ffk%fkf@fkfkfkffk#k#fk%kff%kfkffkf@ffkff@k#kfkffk%kfk%kfkfk#ff%fk#:=f%fkffk#f@kfffkf%f@%kfkffkf@ffkff@k#kfkffk%%fkkfkf%kfkf%fkk#k#f@%kffk#k#fk
k%kfkfff%fk#f%k#f@k#k#fkkf%f@fkf%fkffk#f@kfffkf%ff%fkffk#f@kfffkf%#fffk:=fkf%k#f@k#k#fkkf%f%kfkfff%kfkfkf%kfkffkf@ffkff@k#kfkffk%k#k#fk
%kfkffkf@ffkff@k#kfkffk%kff%fkffk#f@kfffkf%%kfffffff%#%fkffk#f@kfffkf%#fkffkfkf:=fkf%fkffk#%%fkk#k#f@%@f%fkffk#f@kfffkf%f%fkffk#f@kfffkf%f%fkffk#f@kfffkf%ffk#k#fk
fffkk%fkf@fkfkfkffk#k#fk%f%fff@ff%k%f@k#f@f@%ffff%fkffk#f@kfffkf%#f@f@fkf@:=fkf@%kfkffkf@ffkff@k#kfkffk%%fkffk#f@kfffkf%f%fkffk#f@kfffkf%fkff%fkffk#ff%k#k#fk
fkk%fkffk#ff%fk%fkf@fkfkfkffk#k#fk%fff%kfkffkf@ffkff@k#kfkffk%k#k%fkfkffkf%fffk%fkf@fkfkfkffk#k#fk%ffkf:=fkf@fk%kfkffkf@ffkff@k#kfkffk%kfkf%k#f@f@fk%f%fkffk#f@kfffkf%#k#fk
k%kfkffkf@ffkff@k#kfkffk%k%fkf@fkfkfkffk#k#fk%f@f@%fff@%fkk%k#kff@k#%#kfkfkff@:=%kfkffkf@ffkff@k#kfkffk%%fkk#k#f@%kf%f@fkfk%@f%fkffk#f@kfffkf%fk%kfkffkf@ffkff@k#kfkffk%kffk#k#fk
fff%k#f@k#k#fkkf%k#f%kfkffkf@ffkff@k#kfkffk%kf%fkf@kf%k#fk%ffk#kf%k#ff:=fkf@fk%fkfkk#fk%fkfkff%fkffk#f@kfffkf%#k#fk
ffk#%fkf@kfkf%kff@%kfkffkf@ffkff@k#kfkffk%@k%fkf@fkfkfkffk#k#fk%k#ffkfkf:=f%fff@k#kf%%fkffk#f@kfffkf%%kfkffkf@ffkff@k#kfkffk%@fk%f@kffffk%fkfkffk#k#fk
%kfkfk#%ffk%fkf@fkfkfkffk#k#fk%f%fkffk#f@kfffkf%fffkfkk#k#fkk#fkff:=f%fkffk#f@kfffkf%f@%kfkffkf@ffkff@k#kfkffk%kf%k#f@f@k#%kf%fkffk#f@kfffkf%%ffk#kff@%ffk#k#fk
}
k#kffkkfffffkfk#() { 
global
%fkfk%k%ffffffkf%ff%fkkfk#fkfkkffffkfff@%k%kfffkfffk#f@fff@kf%%fff@fff@fkf@fkf@fkk#%#kff@ff=%ffffk#f@fffffkkf%ffk%k#fffkfffffff@fkff%@k#%k#kfkffkkfkfk#k#kff@f@%fk#%fkkffkk#%f@f@
k%kffkk#k#fkkfk#%ff%k#kfkffkkfkfk#k#kff@f@%%kff@fffk%k%f@k#kff@kffff@ff%#ffkfff=fff%ffkffk%k%fkf@ffk#kfkffk%@k#%f@kffkf@k#fkfkk#ff%f%kffkk#kfkff@kfk#fk%#f@f@
kf%kff@fffk%f%k#fkf@fkfff@ff%ff%ffffkf%f%fkfff@f@kffkk#k#k#kf%ff%fkf@kfk#k#ffk#k#%#k#kf=k%ffffk#f@fffffkkf%k%kfkfk#ff%#f%f@fkk#kf%kk#%f@fffffffkf@k#kf%fkfkf
%kffkf@ffffkffkkff@%kk%f@fkk#f@fkffkffk%f%kfkfk#f@%%fff@fff@fkf@fkf@fkk#%f@ffff=kfk#%fkkfk#fkfkkffffkfff@%kk#k%fkfffkf@f@ffff%kfkf
fkk%k#k#f@%%kfk#f@f@fkfkffk#fffk%f%ffffk#f@fffffkkf%f@%fkf@ffk#fkk#kfkfffffkf%#kfk#=f%f@fffkffkff@f@fkffkf%%fkffkfk#ffkffkfff@%@k%f@f@%fk%k#fff@%ffffkfk
ffk#f%k#fffkfffffff@fkff%fkk#k%fff@k#%ffff@=fk%k#k#fkkff@kffkf@k#f@kfff%@%f@k#ffffk#k#k#fkf@f@%fkf%fkf@kff@%ff%k#fff@%fkfk
ffff%fff@k#%kff%ffffk#f@fffffkkf%kfk%k#k#fffkfkfkffffk#f@f@%f@fk=k#%fkkffkk#%ff%ffffk#f@fffffkkf%ff%kffkf@ffffkffkkff@%kfkfff
f@f%f@fffffffkf@k#kf%k#%f@fkfk%ff%k#k#fkkff@kffkf@k#f@kfff%kf@%ffffkffkk#k#kff@kff@%k=k#%fkkfk#fkfkkffffkfff@%%kffkff%f%fkfkk#fk%%fkffkfk#ffkffkfff@%fffkfkfff
kff%fff@kff@fffkkfk#k#f@ffk#%kff@%fkf@k#fffkfkfkfkfkfk%#f@=f%fkkfk#fkfkkffffkfff@%kf%f@ffkfff%f%k#fkkfk#fkkfk#kffkk#kf%k%f@fkf@%fk#kf
%f@kffkk#%k#%kff@ffff%%f@ffffk#kffff@fkkf%%ffkfkffkf@k#kfk#fkkf%fff%k#kfkfkff@k#ffk#kff@f@ff%kff@kff@=ffk%fff@ffff%ffk%fff@fff@fkf@fkf@fkk#%%k#fkk#kff@fkkfkfk#ffkfff%k#kf
fk%kfk#f@fkk#fkfff@ff%fkf%ffffk#f@fffffkkf%@%fkffk#ff%f@fkf%fkfkf@k#%fk#k#f@ffk#kfk#f@f@kf=kfk%f@ffk#kfffkfkfk#%k%fkkfk#fkfkkffffkfff@%k%f@kffffk%ffkfff@kff@k#k#fk
k#k#k%fkf@k#k#kfk#f@k#f@fkk#%f@kfk#k%fffkk#fkffffk#f@f@fkf@%k#f%k#k#f@%@fff@f%kff@fkfkf@f@k#kffkf@fkkf%kff@=kfk#kf%fkk#k#kfffkfkf%ffk%kffffk%fff@k%kffkf@ffffkffkkff@%f@k#k#fk
fkffk#%fkf@ffk#fkk#kfkfffffkf%ffffff%fkkff@k#k#fffkfffkffk#kf%ff%ffffk#f@fffffkkf%%fkk#k#k#%@kff@k#f@k#fk=%f@fffffffkf@k#kf%%kffffk%#ff%f@k#ffffk#k#k#fkf@f@%#k#kf%ffffkffkk#k#kff@kff@%kk%fkkfkf%ffffffff@fffkkfffkff@k#fkkffk
ffkfk%fkf@kff@%#k#ff%f@k#k#kfkfkfffff%ffk%f@k#kff@kffff@ff%#f@f@k#kfk#ffkfk#=k#ffk%fffkk#fkffffk#f@f@fkf@%k#kf%k#k#kff@fkf@kf%kkff%k#f@k#%ffffff@fffkkfffkff@k#fkkffk
f@%ffkfffkf%f%f@k#k#k#k#fkk#f@f@%%k#k#kff@fkf@kf%ff%kff@fkfkf@f@k#kffkf@fkkf%fkfk%f@k#ff%k#k#fkf@k#f@=f%k#k#fkkff@kffkf@k#f@kfff%ffkff%f@fffff@f@fkk#k#k#fkk#fk%fff@%f@k#ff%k#kff%k#k#kff@fkf@kf%fffkkfkfk#
kfk#f@f%f@k#ffff%ffffk%f@fffff@f@fkk#k#k#fkk#fk%%f@k#ffffk#k#k#fkf@f@%kfk#ffkfk#kf=fff%f@fkf@kfk#f@k#kfk#f@%k%f@kffkf@k#fkfkk#ff%fffff@%fkf@kf%k#kffff%k#fffkfffffff@fkff%fkkfkfk#
f@k#%kffkff%kf%ffkfffkf%fk%f@fffffffkf@k#kf%%k#k#kff@fkf@kf%%kfk#f@fkk#fkfff@ff%ff@fkf@kff@f@fk=%f@k#f@ff%f@fkkf%fkffffkfkfkffff@f@f@%#k#kfk%ffk#kff@f@k#k#ffkfkf%%f@k#f@ff%f@f@f%k#fffkfffffff@fkff%kffkfkf@ffkfkff@f@ff
f@%fkffk#ff%kfkff%fkffffkfkfkffff@f@f@%kfkf%kfkfff%f%kfk#f@fkk#fkfff@ff%fffk%fkkfk#fkfkkffffkfff@%kf@kfk#f@kff@kf=f@fkkfk%fff@k#ffkfk#fkk#ff%k#k%f@ffffk#kffff@fkkf%k#f@f@%k#k#kff@fkf@kf%fkffk%fffffk%fkf@ffk%fkkfkf%fkff@f@ff
}
fkfkfkffkffkkfff() { 
global
}
ffkffkkfk#kf() { 
global
%fkffk#ff%f%f@f@k#k#fkk#k#fkf@fkf@%k%fkfffkf@f@ffff%f%k#k#fff@kfffkf%fk=%kfkfff%%ffkfk#%%k#k#fkkff@kffkf@k#f@kfff%%f@fffkffkff@f@fkffkf%k%fffffkffk#f@fff@fk%ffkf
f%k#kf%k%fkfffkf@f@ffff%%ffkff@%kf%fkffkfk#ffkffkfff@%ff=%ffff%%ffffk#f@fffffkkf%k%f@fff@%k%fffffkffk#f@fff@fk%f%k#k#fkkff@kffkf@k#f@kfff%kf
%f@fkk#k#%kf%fkfffkf@f@ffff%@%ffffk#f@fffffkkf%%f@f@k#k#fkk#k#fkf@fkf@%k#=k#%k#fffkfffffff@fkff%%fkf@ffk#fkk#kfkfffffkf%kf%f@k#k#kfkfkfffff%%k#fkf@%@fk
%f@kffkf@k#fkfkk#ff%%k#f@f@k#%%fkk#k#kfffkfkf%f@f@kf=%fkk#k#fff@f@fkfkk#f@%%f@fkfkkffkk#fff@k#%fk%k#kff@ff%%fkf@f@%k%f@kffkf@k#fkfkk#ff%f@fk
f@%f@k#k#kfkfkfffff%fk%kfkfk#ff%#k%f@fkk#k#%fk%f@kffkf@k#fkfkk#ff%=%k#fff@%f@f%fkf@ffk#fkk#kfkfffffkf%k#k%ffkfffkf%%fffkk#fkffffk#f@f@fkf@%fkk#
f%fkfffkf@f@ffff%k%fff@k#ffkfk#fkk#ff%f%fff@fff@fkf@fkf@fkk#%=f@%fff@ffff%f%fffffk%kk%kfk#f@f@fkfkffk#fffk%k%fkffk#k#fkffkfkf%%fkkfk#fkfkkffffkfff@%kk#
f%ffffffk#k#kff@ffk#fkf@ff%%f@fkf@f@%k%fkk#k#f@%%k#kfkffkkfkfk#k#kff@f@%kfk#f@k#fff@k#fkf@k#=k#kf%f@k#k#kfkfkfffff%@fff%f@k#k#k#k#fkk#f@f@%%fkfkffkf%fkff%f@ffkf%kff@fkfk
kfkfk%kfk#f@f@%#k%kffkff%#k#f%ffffkffkk#k#kff@kff@%fkfk%k#k#kff@fkf@kf%@k#kfkf=k#%f@fffkffkff@f@fkffkf%%fkkfk#fkfkkffffkfff@%f@ff%fkfkfkff%f@fkffkff@fkfk
kfk%fkf@k#k#kfk#f@k#f@fkk#%fkf%k#fkkfk#fkkfk#kffkk#kf%f%fkkff@k#k#fffkfffkffk#kf%ffk#f%f@fkf@%@%fkfkffkf%kfkfffkff@ff=f%ffkffk%fkf%fkkfk#fkfkkffffkfff@%ff%fkf@k#fffkfkfkfkfkfk%kf%f@k#f@f@%k#fkk#fkff
k#%f@k#k#kfkfkfffff%@fkfff%f@fffffffkf@k#kf%f%k#k#ff%ff@f@k#kfff=ffk%kfkfk#%ff%k#f@f@kf%f%f@ffffk#kffff@fkkf%kkfk#%f@ffffk#kffff@fkkf%kk#fkff
fkfkf%kfk#%@f@fk%fkk#k#fff@f@fkfkk#f@%%f@fffff@f@fkk#k#k#fkk#fk%fkkfk%kffkkf%fkf%kfk#f@fkk#fkfff@ff%#f@k#=kff%fkfkk#kf%fff%fkk#k#fff@f@fkfkk#f@%%fkf@ffk#kfkffk%%ffffk#f@fffffkkf%ff@f@k#ff
k%f@fkf@f@%f%fkf@kfkf%k#%f@ffffk#kffff@fkkf%%ffkfkffkf@k#kfk#fkkf%f%k#k#kffkk#fff@ff%fffff@k#=k%kff@k#%%ffkfffkf%ff%ffffkffkk#k#kff@kff@%ffkf%k#fffkfffffff@fkff%ff@f@k#ff
k%ffffkffkk#k#kff@kff@%k#%kffkf@ffffkffkkff@%kk#fkf%f@k#%kk#ffk#fff@k#=%k#f@k#%f@%fkf@ffk#fkk#kfkfffffkf%ff@f%kffkk#kfkff@kfk#fk%kff@%kffkk#kfkff@kfk#fk%fk#k#
%ffkfkffkf@k#kfk#fkkf%kf@%ffkfk#%f%kff@fkffk#ffkff@k#f@fk%k%fff@kff@fffkkfk#k#f@ffk#%%kfk#f@k#%k#fffkf@=f@%f@fkf@f@%k%f@fff@%%ffkfkffkf@k#kfk#fkkf%f@%kffkf@ffffkffkkff@%kkff@kfk#k#
ff%k#k#fkkff@kffkf@k#f@kfff%kfkk#%f@fkfk%%k#kfkffkkfkfk#k#kff@f@%@%fkkfk#fkfkkffffkfff@%ff@kff@kfkfffff=%ffffkf%f%f@ffkffkfffffkf@ffkf%k#%f@k#k#kfkfkfffff%@k#%f@k#ffffk#k#k#fkf@f@%#ffk#
f%k#f@kffffff@f@f@%%kffkf@ffffkffkkff@%kf%kff@fkfkf@f@k#kffkf@fkkf%kf%ffff%f%k#f@f@fk%@fff@fkfk=%f@fkf@kfk#f@k#kfk#f@%@k%f@kffkk#%#f%fkkff@k#k#fffkfffkffk#kf%k#%k#fkkfk#fkkfk#kffkk#kf%#ffk#
k#f%k#k#kff@fkf@kf%%ffkfkffkf@k#kfk#fkkf%ff@k%fkf@fkkf%#kfk%ffk#ffff%#f@=%kfkfk#f@%%f@k#f@f@%D%f@k#ff%l%kfkfk#%l%kff@fffk%C%ffk#kf%%fff@%
%kfffffff%k#%ffkfffkf%fk%ffkff@fkffk#k#ffkfff%#f%k#fkkfk#k#kffkffkff@fkf@%kff@kfff=%kffkkf%%kff@k#%a%f@fkk#k#%l%f@fkk#k#%l%fkkfkf%%ffkffk%
f@k%fkffkff@fffffffkfkfkk#%%f@fkfkk#%f@k%f@kffkf@k#fkfkk#ff%f%k#fkf@fkfff@ff%f@=%k#fff@%%fkf@k#fk%D%fkffk#ff%l%fkfkfkff%l%f@f@fkk#%C%f@f@fkk#%a%k#f@f@fk%l%k#f@k#%%f@fkf@f@%
kffk%f@fkf@f@%f%kfffk#k#fkfkf@fff@ffk#%f@k#%k#kfkffkkfkfk#k#kff@f@%kkfk#=%fkf@kff@%%f@fkfk%l%fffkkfkf%%f@fkf@f@%
k%f@k#%f%ffkfkffkf@k#kfk#fkkf%%ffffffkf%f%k#kfkffkkfkfk#k#kff@f@%@%fkkfk#fkfkkffffkfff@%kkffffk=%ffff%%kfk#f@k#%D%f@kffffk%l%kfkfk#ff%l%f@fkfk%C%fkk#kf%a%fkf@kfkf%%kfkfk#ff%
%fkffffkfkfkffff@f@f@%%kfffkfffk#f@fff@kf%kf%f@fkf@f@%fkf@fff@=%fffkfk%%kfkf%l%f@fkk#k#%l%fkfkk#fk%%kfkfk#f@%
f@f%kff@fkffk#ffkff@k#f@fk%f%f@k#k#fff@fkfff@k#fkkf%%kff@fffk%kf%f@k#k#kfkfkfffff%ff%kfkfk#ff%@kff@=%ffkfk#%%kff@fffk%D%k#f@f@k#%l%fkk#k#f@%l%f@ffkf%C%fkf@fkkf%%fkk#k#k#%
%fffffk%f%k#fkff%@%fkffkff@fffffffkfkfkk#%%ffkff@fkffk#k#ffkfff%f%fkffkff@fffffffkfkfkk#%k#ffk#f@f@=%fffkkfkf%%fkk#fff@%a%f@k#fkkf%l%fffkfk%l%f@fkfkk#%%f@fkfkfk%
k%f@k#f@ff%f%f@ffffk#kffff@fkkf%fk%fkkfk#ffffk#kfffk#ffkf%f@%fkf@k#fk%k%f@ffk#kfffkfkfk#%fffk=%fff@%%f@k#fkkf%W%kffffk%i%ffkff@%n%kfk#%E%fkk#kf%x%ffk#kf%%f@fkfk%
%ffffffkf%f%kffffffk%@%k#k#kff@fkf@kf%@k%k#fkk#kff@fkkfkfk#ffkfff%%k#fffkfffffff@fkff%@f@fk=%ffk#ffff%%kfkfk#%i%ffkfk#%s%ffkffk%t%fkf@kf%%fkfkfff@%
kff@%k#f@k#%k#k%k#kff@k#%fff%k#fkk#kff@fkkfkfk#ffkfff%%ffffkffkk#k#kff@kff@%k#k#=%kfkfff%%ffk#kf%W%kffkkf%i%f@fkf@%n%f@ffkf%E%f@fkfk%x%f@kfk#f@%%ffff%
%k#fff@%%f@k#k#kfkfkfffff%kk%k#k#fkkff@kffkf@k#f@kfff%f@f@fkkffk=%k#fkff%%fkf@kff@%i%kff@fffk%s%fkk#k#k#%t%kffk%%kffffffk%
k#f%fkfkf@k#%k%f@fffffffkf@k#kf%ff%f@f@%kkfk%kfffkfffk#f@fff@kf%fkfk=%f@fkf@kf%%f@fkf@kf%W%fkfk%i%f@ffkfff%n%f@fkf@f@%E%k#fkff%x%f@fkf@%%kfffffff%
fk%f@kffkk#%fkf%kffkf@ffffkffkkff@%fk%f@k#ffffk#k#k#fkf@f@%f%fff@fff@fkf@fkf@fkk#%fkf=%ffffffkf%%fkf@f@%i%f@kffffk%s%k#f@f@fk%t%kfkfff%%fffkfkk#%
fk%fkk#k#f@%kff@%ffkfkfk#kfk#fffk%#fk%fkk#k#fff@f@fkfkk#f@%fk#fk=%f@ffkf%%f@fkk#kf%W%kfk#f@k#%i%kffffk%n%k#kfffk#%%kfkfk#ff%
fffkf%f@kfk#f@%%f@k#f@kfk#k#kffkf@fk%f@k#f%f@k#k#k#k#fkk#f@f@%f@ff=%f@fkf@%%k#k#f@%E%fkf@ff%x%k#fkf@%i%fkfkfff@%s%k#f@f@k#%t%k#f@k#%%f@k#f@f@%
}
