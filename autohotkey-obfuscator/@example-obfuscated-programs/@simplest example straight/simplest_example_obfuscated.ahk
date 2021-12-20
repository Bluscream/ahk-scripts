obf_copyright := " Date: 18:17 lundi 19 mars 2018                 "
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
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;[!! IMPORTANT !!] use this statement to set obfuscation to straight obfuscation!
;$OBFUSCATOR: $STRAIGHT_MODE:


;[!! IMPORTANT !!] You CAN ask to obfuscate your global variables 
;You CAN also use this command for local variables if you wish to put them all on top, and do not want to specify them each time inside the function
;$OBFUSCATOR: $DEFGLOBVARS: k#fk%kkf@@kf@%@f,k#@fk%k@fkk#%@k@@%f@@fk#%kkf

k#fk@%@kfkkkff%f:="The value of global is:"
k#%#fkf@f%%#fff%@fk@k@@kkf:="This is a test"

;test obfuscation of function call
@%kk#f@kkk%fkff#%#k@k%k#k#kkkff#()

return

;[!! IMPORTANT !!] RESPECT THE FUNCTION CONVENTIONS
;only the end bracket is at character 1 of the line
;FUNCTION ORIGINAL NAME: testfunction
@fkff#k#k#kkkff#(k@#f#f#k#fk@f#k#="params are automatically obfuscated") {
global
local f#fkkfkk@f@f@kkkk@,@kk#f@f@kfkfk##k@f@kf#
;[!! IMPORTANT !!] You CAN ask to obfuscate the local variables by listing them INSIDE the function
;$OBFUSCATOR: $DEFLOSVARS: f#fkk%ffkfkk%fkk@f@f@kkkk@,@kk#f@%@f@k%f@kfkf%@k#f%k##k@f@kf#

f#fkk%@f@ffkfk%fkk@f@f@kkkk@:="The value of local is:"
@kk%#fff%#%k#@kkk%f@f@kfkfk##k@f@kf#:="This is a test"
msgbox % f#f%k##k#f%kkfkk@%kk#f%f@f@kkkk@ "`n" @kk#f%kk#f@kkk%@f@kfkfk##k@f@kf# "`n" k#%k@fff@%%k@@ff#k@%fk@f "`n" k#@fk%f#fkkk#k%@k@@k%k@f@kk%kf "`n" k@#f#%f##k%f#k#fk@f#k#

}

