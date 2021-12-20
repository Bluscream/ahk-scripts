/*
	DYNAMIC OBFUSCATOR L FOR AUTOHOTKEY
	By DigiDon
	Based on DYNAMIC OBFUSCATOR - Copyright (C) 2011-2013 David Malia
	
	DYNAMIC OBFUSCATOR is an obfuscator for autohotkey scripts that
	can obfuscate functions, autohotkey functions, labels,
	parameters, and variables. It can automatically use the dynamic
	variable creation features of autohotkey to create breakable
	code sections and function path rewiring.

	This program is free software: you can redistribute it and/or 
	modify it under the terms of the GNU General Public License as
	published by the Free Software Foundation, either version 3 of
	the License, or (at your option) any later version.

	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.

	You should have received a copy of the GNU General Public License
	along with this program.  If not, see
	<http://www.gnu.org/licenses/>.

	David Malia, 11 Cedar Ct, Augusta ME, USA
	dave@dynamicobfuscator.org
	http://davidmalia.com
	
	Modified by DigiDon
	https://autohotkey.com/boards/memberlist.php?mode=viewprofile&u=59397
	http://www.EverFastAccess.com
	
	See online doc at:
	http://EverFastAccess.com/AHK-Obfuscator/
*/


;---------------------------------------------
;**START PROCESS TRANSLATIONS MAP SECTION**
;---------------------------------------------

processTRANSmap(ByRef replacemap)	;$OBF_StartDefault
{
	global
	
	;zero class array if exists
	if (numclassesfound) {
		loop, % numclassesfound
		{
			mycurclass := foundclassname_%a_index%
			foundclass_%mycurclass% =
		}
	}
			
	messedupnames_recs = 0
	numalreadyused 	   = 0
	;ADDED DIGIDON REINIT messedupnamelist
	messedupnamelist =
	
	CLASS_numclasses	= 0
	;ADDED DIGIDON OBF_numrows
	OBF_numrows = 0
	dumpcode_numrows	= 0
	numswitchedfuncs	= 0
	
	OBF_SYSFUNC_numrows 	= 0
	OBF_FUNC_numrows 		= 0	
	OBF_LABEL_numrows 		= 0
	OBF_GUILABEL_numrows	= 0
	OBF_PARAM_numrows 		= 0
	OBF_LOSVAR_numrows 		= 0
	OBF_GLOBVAR_numrows 	= 0
	;ADDED DIGIDON GLOBPARTIALVARS
	OBF_GLOBPARTIALVAR_numrows 	= 0
	;ADDED DIGIDON SYSVARS
	OBF_SYSVAR_numrows 	= 0
	;ADDED DIGIDON SYSPROPERTIES
	OBF_SYSPROPERTIES_numrows 	= 0
	;ADDED DIGIDON SYSMETHODS
	OBF_SYSMETHODS_numrows 	= 0
	;ADDED DIGIDON #IF CONTEXT CONDITION
	OBF_CONTEXTCONDITION_numrows = 0
	;ADDED DIGIDON Classes
	OBF_CLASS_numrows = 0
	;ADDED DIGIDON Blocks
	OBF_block_numrows = 0
	OBF_FUNCandVAR_numrows 	= 0
	OBF_NULL_numrows 		= 0
	
	SYSFUNC_time 	= 0
	;ADDED DIGIDON SYSPROPERTIES
	SYSPROPERTIES_time = 0
	;ADDED DIGIDON SYSVARS
	SYSVAR_time		= 0
	FUNC_time 		= 0	
	LABEL_time 		= 0
	PARAM_time 		= 0
	LOSVAR_time 	= 0
	GLOBVAR_time 	= 0
	;ADDED DIGIDON GLOBPARTIALVARS
	GLOBPARTIALVAR_time 	= 0
	FUNCandVAR_time 	= 0
	changeorrestoretime = 0
	obfcreatetime = 0
	intofragstime = 0
	makeobftime = 0
	;ADDED DIGIDON counttotalMAPlines
	counttotalMAPlines=0
	countMAPlines=0
	prevpercentcountlinesprocessed=0
	newpercentcountlinesprocessed=0
	;DIGIDON MAYBE STOP OBF SHOULD ALSO BE TREATED IN TRANSMAP SO THAT NEW NAMES WON'T BE GENERATED
	GlobObf_Stop=
	GlobObf_Straight=
	
	
	FormatTime, currenttime

	writetranstablemessheader()
	; msgbox myTRANSCOMMSfile %myTRANSCOMMSfile%
	; msgbox replacemapfile %replacemapfile% replacemap %replacemap%
	if !createsourcearray(replacemap, "replacemap") {
		write_transtablemess("*THE TRANSLATIONS COMMANDS FILE IS EMPTY*")
		write_transtablemess("*File Name: " . replacemapfile)
		return false	
	}
	
	;ADDED DIGIDON counttotalMAPlines,countTOTALlines
	counttotalMAPlines:=Trim(SubStr(str_getTail(replacemap,3),18))
	countTOTALlines   :=Trim(SubStr(str_getTail(replacemap,2),21))
	
	While !ENDOFSOURCE("replacemap") {
	;ADDED DIGIDON counttotalMAPlines
	countMAPlines++
	newpercentcountlinesprocessed:=round(countMAPlines/counttotalMAPlines * 100,0)
		if (newpercentcountlinesprocessed!=prevpercentcountlinesprocessed)
			{
			prevpercentcountlinesprocessed:=newpercentcountlinesprocessed
			tooltip % "please wait OBF COMM " newpercentcountlinesprocessed "%"
			}
			
		curline = %	nextsourceline("replacemap")
		if ENDOFSOURCE("replacemap")
			break
			
		if !IS_OBFTRANSCOMM(curline)  
			continue
	
		if (changedefaultnum := ischangedefaultsCOMM(CUR_OBFTRANSCOMM)) {
			timestart = % A_TickCount
			if (changeorrestoreCOMM = "change") 				
				changeOBFdefaults(changedefaultnum)
			else if (changeorrestoreCOMM = "restore")
				restoreOBFdefaults(changedefaultnum)
			changeorrestoretime += A_TickCount - timestart
			continue		
		}
		
		;ADDED DIGIDON : COMMENT TO CHANGE OBF MODE
		if (isobfmodeCOMM(CUR_OBFTRANSCOMM)) {
			timestart = % A_TickCount
			if (stoporresumeCOMM = "straight") 				
				straightOBF()
			else if (stoporresumeCOMM = "dynamic")
				dynamicOBF()
			changeobfmodetime += A_TickCount - timestart
			continue					
		}
		
		;ADDED DIGIDON : COMMENT TO STOP OBF
		if (isstopobfCOMM(CUR_OBFTRANSCOMM)) {
			timestart = % A_TickCount
			if (stoporresumeCOMM = "stop") 				
				stopOBF()
			else if (stoporresumeCOMM = "resume")
				resumeOBF()
			stoporresumetime += A_TickCount - timestart
			continue					
		}
		
		
		if (CUR_OBFTRANSCOMM = create_objsCLASS) {
			timestart = % A_TickCount
			create_objCLASS() 
			continue					
		}

		if (CUR_OBFTRANSCOMM = add_followingtoCLASS) {
			timestart = % A_TickCount
			add_followingtoCLASS() 
			continue					
		}
		
		if (CUR_OBFTRANSCOMM = def_SYSFUNCS) {
			timestart = % A_TickCount
			add_sysfunc_OBFentry() 
			SYSFUNC_time += A_TickCount - timestart
			continue					
		}		
		if (CUR_OBFTRANSCOMM = def_FUNCS) {
			; msgbox def_FUNCS obfcreate_varname1 %obfcreate_varname1%
			timestart = % A_TickCount
			add_func_OBFentry() 
			FUNC_time += A_TickCount - timestart
			continue					
		}		
		;ADDED DIGIDON CLASS AND #IF CONTEXT CONDITIONS
		if (CUR_OBFTRANSCOMM = def_CLASS) {
			timestart = % A_TickCount
			add_class_OBFentry()
			FUNC_time += A_TickCount - timestart
			continue
		}
		if (CUR_OBFTRANSCOMM = def_COND) {
			; msgbox defcond obfcreate_varname1 %obfcreate_varname1%
			timestart = % A_TickCount
			add_cond_OBFentry()
			FUNC_time += A_TickCount - timestart
			continue
		}
		if (CUR_OBFTRANSCOMM = def_LABELS) {
			timestart = % A_TickCount
			add_label_OBFentry()
			label_time += A_TickCount - timestart
			continue
		}
		;ADDED DIGIDON: hotkeys
		if (CUR_OBFTRANSCOMM = def_HOTKEYS) {
			timestart = % A_TickCount
			add_hotkey_OBFentry()
			label_time += A_TickCount - timestart
			continue
		}
		
		;USED TO SPECIFY THE ORDER IN WHICH FUNCTION AND LABEL
		;CODE SECTIONS ARE TO BE DUMPED
		if (CUR_OBFTRANSCOMM = "DUMP_CLASSCODE") {
			add_dumpcode_entry()
			continue	
		}
		
		;used to 'rewire' functions so that they can call other functions
		;instead any time i want
		if (CUR_OBFTRANSCOMM = "DUMP_REWIREFUNCPATH") {
			add_rewirefunc_entry()
			continue	
		}
		
		;SPECIAL CASE when the gui, +Label????? is used with a gui
		if (CUR_OBFTRANSCOMM 	= "DEFGUILAB") {
			add_GUIlabel_entry()
			continue	
		}
		if (CUR_OBFTRANSCOMM = def_PARAMS) {
			timestart = % A_TickCount
			add_param_OBFentry()
			param_time += A_TickCount - timestart
			continue					
		}
		if (CUR_OBFTRANSCOMM = def_LOSVARS) {
			timestart = % A_TickCount
			add_LOSvar_OBFentry()
			LOSvar_time += A_TickCount - timestart
			continue					
		}
			
		if (CUR_OBFTRANSCOMM = def_FUNCandVARS) {
			timestart = % A_TickCount
			add_funcandvar_OBFentry()
			FUNCandvar_time += A_TickCount - timestart
			continue					
		} 
		
		if (CUR_OBFTRANSCOMM = def_GLOBVARS) {
			timestart = % A_TickCount
			add_GLOBALvar_OBFentry()
			GLOBVAR_time += A_TickCount - timestart
			continue					
		}
		
		;ADDED DIGIDON SYSVARS
		if (CUR_OBFTRANSCOMM = def_SYSVARS) {
			timestart = % A_TickCount
			add_SYSvar_OBFentry()
			SYSVAR_time += A_TickCount - timestart
			continue					
		}
		
		;ADDED DIGIDON GLOBPARTIALVARS
		if (CUR_OBFTRANSCOMM = def_GLOBPARTIALVARS) {
			timestart = % A_TickCount
			add_GLOBALPARTIALvar_OBFentry()
			GLOBPARTIALVAR_time += A_TickCount - timestart
			continue					
		}
		;ADDED DIGIDON SYSPROPERTIES
		if (CUR_OBFTRANSCOMM = def_SYSPROPERTIES) {
			timestart = % A_TickCount
			add_SYSPROPERTIES_OBFentry()
			SYSPROPERTIES_time += A_TickCount - timestart
			continue					
		}
		;ADDED DIGIDON SYSMETHODS
		if (CUR_OBFTRANSCOMM = def_SYSMETHODS) {
			timestart = % A_TickCount
			add_SYSMETHODS_OBFentry()
			SYSMETHODS_time += A_TickCount - timestart
			continue					
		}
	}
	tooltip please wait setup_switchedfuncs
	setup_switchedfuncs()
	; msgbox setup_switchedfuncs
	tooltip please wait createNULLSlist
	createNULLSlist()
	; msgbox createNULLSlist
	tooltip please wait createREPLACEMENTSlist
	createREPLACEMENTSlist()
	
	; msgbox createREPLACEMENTSlist
	tooltip please wait markFUNCANDVARwithfuncrow
	markFUNCANDVARwithfuncrow()
	tooltip
	; msgbox markFUNCANDVARwithfuncrow
}

add_followingtoCLASS()
{
	global
	
	;set it to null class name
	if (transCOMMparam0 < 1) {
		USE_CLASS_NAME =
		return
	}
	
	transCOMMparam1 = %transCOMMparam1%
	
	USE_CLASS_NAME = % transCOMMparam1
}

create_objCLASS()
{
	global
	static newclassname, classfoundat, newclassrow
	
	if !set_CLASSCREATE_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, CLASS name, is required ")
		return
	}	
	
	set_CLASSCREATE_params()

	loop, % obfcreate_CLASSname0
	{
		newclassname = % obfcreate_CLASSname%a_index%
		
		if (CLASS_%newclassname%) {
			write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
				. " found but CLASS NAME: " . newclassname . " already exists ")
			continue
		}			
	
		CLASS_%newclassname% = 1
		
		createCLASSNULLSlist(newclassname, obfCLASS_makenumnulls, obfCLASS_nullnameminsize, obfCLASS_nullnamemaxsize)

		createCLASSreplacementslist(newclassname, obfCLASS_replacementsperchar, obfCLASS_replacenameminsize, obfCLASS_replacenamemaxsize)
	}
	
}

createCLASSNULLSlist(forclass, makenumnulls, nullnameminsize,nullnamemaxsize)
{
	global
	
	CLASS_%forclass%__NULL_MASTvarname	
		= % randomOBFname(nullnameminsize, nullnamemaxsize)
		
	if (makenumnulls < 1) {
		CLASS_%forclass%_numnulls = 0
		return
	}
	
	loop, % makenumnulls
	{		
		CLASS_%forclass%_NULL_%a_index%_varname
			= % randomOBFname(nullnameminsize, nullnamemaxsize)
	}
	
	CLASS_%forclass%_numnulls = % makenumnulls
}

createCLASSreplacementslist(forclass, replacementsperchar, replacenameminsize, replacenamemaxsize)
{
	global
	local replaceoddchars, curoddchar
	
	replaceoddchars = % "fk@#" 
	
	if (replacementsperchar < 1) {
		CLASS_%forclass%_numreplacements = % 0
		return
	}
	
	loop, % strlen(replaceoddchars)
	{
		curoddchar = % substr(replaceoddchars, a_index, 1)
		
		CLASS_%forclass%_replace%curoddchar%_MASTvarname
			= % randomOBFname(replacenameminsize, replacenamemaxsize)
		
		loop, % replacementsperchar
		{
			CLASS_%forclass%_replace%curoddchar%_%a_index%_varname
				= % randomOBFname(replacenameminsize, replacenamemaxsize)			
		}
	}
	
	CLASS_%forclass%_numreplacements = % replacementsperchar
}


set_CLASSCREATE_names()
{
	global
	
	if (transCOMMparam0 < 1) 
		return, % false
		
	obfcreate_CLASSname0 = 0
	;the first parameter set will be the CLAS names
	StringSplit, obfcreate_CLASSname, transCOMMparam1, `,, %a_space%%a_tab%
	
	if (!obfcreate_CLASSname0)
		return, % false
		
	return, % true
}

set_CLASSCREATE_params()
{
	global
	static curproperty	
	
	;the first parameter set will be the CLASS names
	;the second set will be the optional CLASS TRIPLEMESS obfuscation parameters
	obfcreateCLASS_param0 = 0
	if (transCOMMparam0 >= 2) 
		StringSplit, obfcreateCLASS_param, transCOMMparam2, `,, %a_space%%a_tab%
			
	loop, % numdefaultCLASSprop
	{
		curproperty = % defaultCLASSprop%a_index%
		
		;if no parameter was specified in the translations command
		;then use the current 'default' one for CLASSES
		if (a_index > obfcreateCLASS_param0 or obfcreateCLASS_param%a_index% = "") {
			obfCLASS_%curproperty% = % defaultCLASS_%curproperty%
			continue		
		}
		;use the passed parameter
		obfCLASS_%curproperty% = % obfcreateCLASS_param%a_index%	
	}
}

;*********NOT NEEDED??

findclass(classname)
{
	global
	
	if (!CLASS_numclasses)
		return, % false
	
	classname = % ucase(classname)		
	loop, % CLASS_numclasses
		if (ucase(CLASS_%a_index%_name) = classname) 
			return, % a_index
	
	return, % false
}

;ADDED DIGIDON SYSVARS
add_SYSVAR_OBFentry() {
	global
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters, 1 parameter, system var name, is required ")
		return
	}	
	set_obfcreate_params(12)	
	OBFclass = % SYSVAR_class
	addnew_OBFentry("OBF_SYSVAR") 
}

;ADDED DIGIDON SYSPROPERTIES
add_SYSPROPERTIES_OBFentry() {
	global
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters, 1 parameter, property var name, is required ")
		return
	}	
	set_obfcreate_params(10)	
	OBFclass = % SYSPROPERTIES_class
	addnew_OBFentry("OBF_SYSPROPERTIES") 
}

;ADDED DIGIDON SYSPROPERTIES
add_SYSMETHODS_OBFentry() {
	global
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters, 1 parameter, property var name, is required ")
		return
	}
	set_obfcreate_params(11)	
	OBFclass = % SYSMETHODS_class
	addnew_OBFentry("OBF_SYSMETHODS") 
}

add_sysfunc_OBFentry() 
{
	global
	
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, function name, is required ")
		return
	}	
	
	;'1' stands for vartype of 'SYSFUNC'
	set_obfcreate_params(1)
	
	OBFclass = % SYSFUNC_class	
	addnew_OBFentry("OBF_SYSFUNC") 
}

setup_switchedfuncs() {
	global
	
	loop, % numswitchedfuncs
	{
		switchfrom 	= % switched_%a_index%_switchfrom
		switchto	= % switched_%a_index%_switchto
		
		if (!switchfromfuncrow := FIND_VARROW("OBF_FUNC", switchfrom)) {
			msgbox, 4096,, ERROR: switchfromfunc not found in func list`nswitchfrom: %switchfrom% switchto: %switchto%
			continue
		}
		
		if (!switchtofuncrow := FIND_VARROW("OBF_FUNC", switchto)) {
			msgbox, 4096,,  ERROR: switchtofunc not found in func list`nswitchfrom: %switchfrom% switchto: %switchto%
			continue
		}
		
		;check that they have the same class name
		if (OBF_FUNC_%switchfromfuncrow%_classname <> OBF_FUNC_%switchtofuncrow%_classname) {
			switchfromclass = % OBF_FUNC_%switchfromfuncrow%_classname
			switchtoclass = % OBF_FUNC_%switchtofuncrow%_classname
			msgbox, 4096,,  
(join`s
ERROR: switchfromfunc and switchtofunc do not have the same class name
switchfrom: %switchfrom% classname: %switchfromclass% switchto: %switchto% classname: %switchtoclass%
)
			continue
		}
		
		;check that they both have obf's and that they have 'double' level obf's
		if (!OBF_FUNC_%switchfromfuncrow%_OBFname) {
			msgbox, 4096,, ERROR: switchedfromfunc does not have OBFname`nswitchfrom: %switchfrom% switchto: %switchto%
		}
		
		if (!OBF_FUNC_%switchtofuncrow%_OBFname) {
			msgbox, 4096,, ERROR: switchedtofunc does not have OBFname`nswitchfrom: %switchfrom% switchto: %switchto%
		}
		
		;check that they have the same number of fragment rows and columns
		
		if (OBF_FUNC_%switchfromfuncrow%_numfragrows <> OBF_FUNC_%switchtofuncrow%_numfragrows) {
			msgbox, 4096,, ERROR: switchfromfunc and switchtofunc have different number of frag rows`nwitchfrom: %switchfrom% switchto: %switchto%
		}
		
		if (OBF_FUNC_%switchfromfuncrow%_fragsperrow <> OBF_FUNC_%switchtofuncrow%_fragsperrow) {
			msgbox, 4096,, ERROR: switchfromfunc and switchtofunc have different number of frags per row`nwitchfrom: %switchfrom% switchto: %switchto%
		}
		
		;PUT A FLAG ON BOTH THE SWITCHFROM AND THE SWITCHTO FUNC SO THAT
		;THEY ARE NOT DUMPED WITH THE OTHER FUNCTIONS OF THEIR CLASS OR 'UNCLASSED'
		;OR 'UNSECCLASSES'
		;ALSO THE FUNCTIONS MUST BE PREVENTED FROM BEING CALLED USING THE
		;SINGLE LEVEL 'OBFNAME' STRING OR USING SOMETHING LIKE:
		;%obfname1%straightfrag(), the straightfrag part would be the problem
		;THE ABOVE SHOULD ONLY BE CALLED LIKE THIS %obfname1%%obfname2%()
	
		OBF_FUNC_%switchfromfuncrow%_isswitchfunc = true
		OBF_FUNC_%switchtofuncrow%_isswitchfunc = true
	}

}

add_rewirefunc_entry()
{
	GLOBAL
	
	if (!set_obfcreate_names() or obfcreate_varname0 < 2) {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but less than the 2 required parameters (switchfuncfrom, switchfuncto) were found")
		return
	}

	;DO NOT DUPLICATE ENTRIES!
	if (numswitchedfuncs) { 
		loop, % numswitchedfuncs
			if (switched_%a_index%_switchfrom = obfcreate_varname1)
				return	
	}
	
	numswitchedfuncs++
	
	switched_%numswitchedfuncs%_switchfrom	= % obfcreate_varname1
	switched_%numswitchedfuncs%_switchto	= % obfcreate_varname2
}

;ADDED DIGIDON : Add #if Context Condition name and row
; add_CONTEXTCONDITION()
add_cond_OBFentry()
{
global
	; OBF_CONTEXTCONDITION_numrows++
	; OBF_CONTEXTCONDITION_%OBF_CONTEXTCONDITION_numrows%_name:=OBF_CONTEXTCONDITION_numrows
	; return OBF_CONTEXTCONDITION_numrows
	
	if !set_obfcreate_names("OBF_CONTEXTCONDITION") {
	write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
		. " command found but no parameters - 1 parameter, COND name, is required ")
	return
	}	
	
	varlistname = % "OBF_CONTEXTCONDITION"
	
	OBF_numrows++
	newrow = % ++%varlistname%_numrows
	%varlistname%_%newrow%_name = % obfcreate_varname1
	; msgbox % "cond name " %varlistname%_%newrow%_name
	
}

;DIGIDON : UNCOMPLETE : No call and no name here!
;ADDED DIGIDON : Add #if Class name and row
add_class_OBFentry()
{
global
	; OBF_CLASS_numrows++
	; OBF_CLASS_%OBF_CLASS_numrows%_name:=
	
	if !set_obfcreate_names() {
	write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
		. " command found but no parameters - 1 parameter, COND name, is required ")
	return
	}	
	
	varlistname = % "OBF_CLASS"

	OBF_numrows++
	newrow = % ++%varlistname%_numrows
	%varlistname%_%newrow%_name = % obfcreate_varname1
}

add_func_OBFentry() {
	GLOBAL
	
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, function name, is required ")
		return
	}	
	
	;'2' stands for vartype of 'FUNC'
	set_obfcreate_params(2)
	
	OBFclass = % FUNC_class
	addnew_OBFentry("OBF_FUNC") 
}

add_label_OBFentry() {
	GLOBAL 
	
	if !set_obfcreate_names("OBF_LABEL") {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, LABEL name, is required ")
		return
	}	
	
	;'3' stands for vartype of 'LABEL'
	set_obfcreate_params(3)
	
	OBFclass = % LABEL_class
	addnew_OBFentry("OBF_LABEL") 
	
}

add_hotkey_OBFentry() {
	GLOBAL 
	
	if !set_obfcreate_names("OBF_LABEL") {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, LABEL name, is required ")
		return
	}	
	
	varlistname = % "OBF_LABEL"
	
	OBF_numrows++
	newrow = % ++%varlistname%_numrows
	%varlistname%_%newrow%_name = % obfcreate_varname1
	
}

	
;DIGIDON TWEAKED: CREATE ALL SPECIAL GUI LABELS FUNCTIONS OR LABELS
add_GUIlabel_entry() {
	GLOBAL 
	
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, GUILABEL name, is required ")
		return
	}	
	
	;'8' stands for vartype of 'LABEL'
	set_obfcreate_params(8)
	
	;SHOUD IT REALLY BE EMPTY? AND NOT LABEL_class/FUNC_class?
	OBFclass = % "" ;
	
	if (!OBF_GUILABEL_numrows)
		OBF_GUILABEL_numrows = 0
		
	;loop thru the list of names to create
	
	loop, % obfcreate_varname0
	{			
		AA_Index:=A_Index
		temp2 = % obfcreate_varname%a_index%
		obfcreate_varname%a_index% = %temp2%
		if (!obfcreate_varname%a_index%)
			continue
		SpecialLabels_List:="Close|Escape|Size|ContextMenu|DropFiles"
		Loop, parse, SpecialLabels_List, |
		gui%A_Loopfield%Label= % obfcreate_varname%AA_Index% . A_Loopfield
		; guiCLOSElabel 	= % obfcreate_varname%a_index% . "Close"
		; guiESCAPElabel 	= % obfcreate_varname%a_index% . "Escape"
		guilabellabel 	= % "Label" . obfcreate_varname%a_index%
		;ADDED DIGIDON HWND
		; guilabelhwnd 	= % "Hwnd" . obfcreate_varname%a_index%
		
		; msgbox % guilabellabel
		;check for dup definition of this guilabel var in the globvar section		
		if FIND_VARROW("OBF_GLOBVAR", guilabellabel) {
			msgbox, 4096,, % "GUILABEL def duplication: '" . obfcreate_varname%a_index% . "'"
			continue
		}
		;check for dup definition of this guilabel var in the label section		
		;TWEAKED BY DIGIDON : AND ONE FOR 'ESCAPE' AND ONE FOR THE OTHERS
		if (FIND_VARROW("OBF_LABEL", guiCLOSElabel) or FIND_VARROW("OBF_LABEL", guiESCAPElabel) or FIND_VARROW("OBF_LABEL", guiSIZElabel) or FIND_VARROW("OBF_LABEL", guiCONTEXTMENUlabel) or FIND_VARROW("OBF_LABEL", guiDROPFILESlabel)) {
			msgbox, 4096,, % "GUILABEL LABEL duplication: '" . obfcreate_varname%a_index% . "'"
			continue
		}		
		if (FIND_VARROW("OBF_FUNC", guiCLOSElabel) or FIND_VARROW("OBF_FUNC", guiESCAPElabel) or FIND_VARROW("OBF_FUNC", guiSIZElabel) or FIND_VARROW("OBF_FUNC", guiCONTEXTMENUlabel) or FIND_VARROW("OBF_FUNC", guiDROPFILESlabel)) {
			msgbox, 4096,, % "GUILABEL FUNC duplication: '" . obfcreate_varname%a_index% . "'"
			continue
		}		
		if (obf_sizemax < obf_sizemin)
			obf_sizemax = % obf_sizemin	
		guilabelOBF = % randomOBFname(obf_sizemin, obf_sizemax)
		;CREATE NEW ROW IN 'GLOBVAR' +Label
		newrow = % ++obf_globvar_numrows
		;ADDED DIGIDON OBF_numrows
		OBF_numrows++
		obf_globvar_%newrow%_name = % "Label" . obfcreate_varname%a_index%
		; msgbox % "name " obf_globvar_%newrow%_name
		obf_globvar_%newrow%_OBFname = % "Label" . guilabelOBF
		;necessary hack so that the 'NEW_replaceGLOBALVARs(' function
		;will not add extra %s
		obf_globvar_%newrow%_isguilabel = % true
		obf_globvar_%newrow%_classname = % OBFclass
		obf_globvar_%newrow%_numfragrows = 0
		
		;CREATE NEW ROWS IN LABEL SECTION, ONE FOR 'CLOSE' 
		;TWEAKED BY DIGIDON : AND ONE FOR 'ESCAPE' AND ONE FOR THE OTHERS
		SpecialLabels_List:="Close|Escape|Size|ContextMenu|DropFiles"
		Loop, parse, SpecialLabels_List, |
			{
			newrow = % ++obf_label_numrows
			newrow = % ++obf_func_numrows
			;ADDED DIGIDON OBF_numrows
			OBF_numrows++
			OBF_numrows++
			
			obf_label_%newrow%_name = % obfcreate_varname%AA_index% . A_LoopField
			obf_func_%newrow%_name = % obfcreate_varname%AA_index% . A_LoopField
			obf_label_%newrow%_OBFname = % guilabelOBF . A_LoopField
			obf_func_%newrow%_OBFname = % guilabelOBF . A_LoopField
			obf_label_%newrow%_classname = % OBFclass
			obf_func_%newrow%_classname = % OBFclass
			obf_label_%newrow%_numfragrows = 0
			obf_func_%newrow%_numfragrows = 0
			; msgbox % "obf_label_" newrow "_name = " obf_label_%newrow%_name " obf_label_" newrow "_OBFname = " obf_label_%newrow%_OBFname
			}
		
		; newrow = % ++obf_label_numrows
		; obf_label_%newrow%_name = % obfcreate_varname%a_index% . "Close"
		; obf_label_%newrow%_OBFname = % guilabelOBF . "Close"
		; obf_label_%newrow%_classname = % OBFclass
		; obf_label_%newrow%_numfragrows = 0
		
		; newrow = % ++obf_label_numrows
		; obf_label_%newrow%_name = % obfcreate_varname%a_index% . "Escape"
		; obf_label_%newrow%_OBFname = % guilabelOBF . "Escape"
		; obf_label_%newrow%_classname = % OBFclass
		; obf_label_%newrow%_numfragrows = 0		
		
		write_transtablemess("`r`n#FOUND: " . CUR_OBFTRANSCOMM 
			. " Name: " . obfcreate_varname%a_index% 
			. "`r`n    Created obfuscated name: " . guilabelOBF)
	}
	
}

add_param_OBFentry()
{
	GLOBAL
	
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, parameter name, is required ")
		return
	}	
	
	;'4' stands for vartype of 'PARAM'
	set_obfcreate_params(4)
	
	;assume these parameters belong to the last function created
	funcnum = % OBF_FUNC_numrows
	
	OBFclass = % PARAM_class
	addnew_OBFentry("OBF_FUNC_" . funcnum . "_PARAM") 
	
}

add_LOSvar_OBFentry()
{
	GLOBAL
	
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, parameter name, is required ")
		return
	}	
	
	;'5' stands for vartype of 'LOS'
	set_obfcreate_params(5)
	
	;assume these parameters belong to the last function created
	funcnum = % OBF_FUNC_numrows
	
	OBFclass = % LOSvar_class
	addnew_OBFentry("OBF_FUNC_" . funcnum . "_LOSvar") 
	
}

add_dumpcode_entry()
{
	global
	local newrow
	
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters found, 1 parameter, 'objtype:objclass' is required")
		return
	}	
	
	dumpcode_numrows++
	newrow = % dumpcode_numrows
	
	loop, % obfcreate_varname0
	{
		dumpcode_%newrow%_%a_index% = % obfcreate_varname%a_index%
		dumpcode_%newrow%_numrows = % a_index	
	}	
	
}

add_GLOBALvar_OBFentry() {
	global
	
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters, 1 parameter, global var name, is required ")
		return
	}	
	
	;'6' stands for vartype of 'globvar'
	set_obfcreate_params(6)	
	
	OBFclass = % GLOBVAR_class
	addnew_OBFentry("OBF_GLOBVAR") 
}

;ADDED DIGIDON GLOBPARTIALVARS
add_GLOBALPARTIALvar_OBFentry() {
	global
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters, 1 parameter, partial global var name, is required ")
		return
	}	
	;'9' stands for vartype of 'globvar'
	set_obfcreate_params(9)	
	OBFclass = % GLOBPARTIALVAR_class
	addnew_OBFentry("OBF_GLOBPARTIALVAR") 
}

add_funcandvar_OBFentry() {
	GLOBAL 
	
	if !set_obfcreate_names() {
		write_transtablemess("`r`n#ERROR: " . CUR_OBFTRANSCOMM 
			. " command found but no parameters - 1 parameter, parameter name, is required ")
		return
	}	
	
	;'6' stands for vartype of 'FUNCANDVAR'
	set_obfcreate_params(6)
	
	;assume these items belong to the last function created
	funcnum = % OBF_FUNC_numrows
	
	OBFclass = 
	;add the items to this specific function
	addnew_OBFentry("OBF_FUNC_" . funcnum . "_FUNCandVAR")
	
	;add the items to the generic funcandvar array	
	addnew_OBFentry("OBF_FUNCandVAR") 

}

addnew_OBFentry(varlistname) {
	global
	
	if (!%varlistname%_numrows)
		%varlistname%_numrows = 0
	
	;loop thru the list of names to create
	loop, % obfcreate_varname0
	{
		temp2 = % obfcreate_varname%a_index%
		obfcreate_varname%a_index% = %temp2%
		
		;DigiDon: 2.013: We skip functions and labels that look like GUI labels/functions
		;DEV COULD BE IMPROVED SO THEY ARE CONSIDERED NORMALLY
		if (varlistname="OBF_FUNC" or varlistname="OBF_LABEL") {
			; if (regexmatch(obfcreate_varname%a_index%,"i)^Gui(Close|Escape|Size|ContextMenu|DropFiles)$") or regexmatch(obfcreate_varname%a_index%,"i)\dGui(Close|Escape|Size|ContextMenu|DropFiles)$")) {
			if (regexmatch(obfcreate_varname%a_index%,"i)Gui(Close|Escape|Size|ContextMenu|DropFiles)$")) {
				continue
			}
		}

		if (!obfcreate_varname%a_index%)
			continue
			
		;check for dup definition of this global var
		if (varlistname = "OBF_GLOBVAR") {
			if FIND_VARROW(varlistname, obfcreate_varname%a_index%) {
				msgbox, 4096,, % "global var def duplication2: '" . obfcreate_varname%a_index% . "'"
				continue
			}
		}
		
		;ADDED DIGIDON GLOBPARTIALVARS
		;check for dup definition of this global var
		if (varlistname = "OBF_GLOBPARTIALVAR") {
			if FIND_VARROW(varlistname, obfcreate_varname%a_index%) {
				msgbox, 4096,, % "global partial var def duplication2: '" . obfcreate_varname%a_index% . "'"
				continue
			}
		}
		
		;ADDED DIGIDON SYSVARS
		;check for dup definition of this system var
		if (varlistname = "OBF_SYSVAR") {
			if FIND_VARROW(varlistname, obfcreate_varname%a_index%) {
				msgbox, 4096,, % "system var def duplication2: '" . obfcreate_varname%a_index% . "'"
				continue
			}
		}
		
		;ADDED DIGIDON SYSPROPERTIES
		;check for dup definition of this property var
		if (varlistname = "OBF_SYSPROPERTIES") {
			if FIND_VARROW(varlistname, obfcreate_varname%a_index%) {
				msgbox, 4096,, % "property var def duplication2: '" . obfcreate_varname%a_index% . "'"
				continue
			}
		}
		
		;ADDED DIGIDON SYSMETHODS
		;check for dup definition of this property var
		if (varlistname = "OBF_SYSMETHODS") {
			if FIND_VARROW(varlistname, obfcreate_varname%a_index%) {
				;Tweaked DigiDon : disabled duplication warning for SYSMETHODS because happens frequently with __Call etc.
				msgbox, 4096,, % "method var def duplication2: '" . obfcreate_varname%a_index% . "'"
				continue
			}
		}
		newrow = % ++%varlistname%_numrows
		
		;TESTING DIGIDON
		; if (varlistname="OBF_GLOBPARTIALVAR")
		; msgbox % "OBF_GLOBPARTIALVAR newrow " newrow " = " obfcreate_varname%a_index%
		
		if (varlistname = "OBF_FUNC" or varlistname = "OBF_LABEL") {
			if FIND_VARROW(varlistname, obfcreate_varname%a_index%) {
				if (SubStr(obfcreate_varname%a_index%,-3)="Size" or SubStr(obfcreate_varname%a_index%,-4)="Close" or SubStr(obfcreate_varname%a_index%,-8)="DropFiles" or SubStr(obfcreate_varname%a_index%,-10)="ContextMenu")
				; if (regexmatch(obfcreate_varname%a_index%,"i)Gui(Close|Escape|Size|ContextMenu|DropFiles)$"))
				continue
				msgbox, 4096,, % "func or label var duplication2: '" . obfcreate_varname%a_index% . "'"
				continue
			}
		}
		;ADDED DIGIDON OBF_numrows
		;DIGIDON : UNCOMPLETE : SHOULD PROBABLY ADD #IF CONTEXT CONDITIONS & CLASS
		if (varlistname = "OBF_FUNC" or varlistname = "OBF_LABEL")
		OBF_numrows++
		
		%varlistname%_%newrow%_name = % obfcreate_varname%a_index%
		
		;set these values to zero for newly created function entries
		if (varlistname = "OBF_FUNC") {
			%varlistname%_%newrow%_param_numrows := 0
			%varlistname%_%newrow%_LOSvar_numrows := 0
		}
		
		;DIGIDON TWEAKED : DELETE _replacementsdone PART BECAUSE VARIABLES ARE NOW NOT OBF IF LOCAL/GLOBAL/STATIC
		;a flag used so that the first LOSvar in a function will not
		;have %'s in it
		; if (substr(varlistname, -5) = "LOSvar") {
			; %varlistname%_%newrow%_replacementsdone = 0
		; }
		;set a class name marker for functions and labels
		if (varlistname = "OBF_FUNC" or varlistname = "OBF_LABEL") {
			%varlistname%_%newrow%_classname = % USE_CLASS_NAME
			;msgbox, my class name: %USE_CLASS_NAME%
		}
		;TWEAKED DIGIDON SYSPROPERTIES & SYSVARS & SYSMETHODS
		if (varlistname = "OBF_SYSFUNC" or varlistname = "OBF_SYSPROPERTIES" or varlistname = "OBF_SYSMETHODS" or varlistname = "OBF_SYSVAR") {
			;set 'obfname' = 'name' for sysfuncs
			%varlistname%_%newrow%_OBFname = % %varlistname%_%newrow%_name
		} else {
			if (obf_sizemax < obf_sizemin)
				obf_sizemax = % obf_sizemin
				
			;request to create unobfuscated, 'stub' entry
			if (obf_sizemin < 1 or obf_sizemax < 1) {
				%varlistname%_%newrow%_OBFname = no/obf			
				%varlistname%_%newrow%_numfragrows = 0
				continue		
			}
			;DIGIDON COMMENT : CREATE OBF NAME !
			%varlistname%_%newrow%_OBFname = % randomOBFname(obf_sizemin, obf_sizemax)
		}
		
		write_transtablemess("`r`n#FOUND: " . CUR_OBFTRANSCOMM 
			. " funcname: " . %varlistname%_%newrow%_name 
			. "`r`n    Created obfuscated name: " . %varlistname%_%newrow%_OBFname)
		
		;DIGIDON COMMENT : CREATE OBF FRAGMENTS
		;DIGIDON MAYBE ADD HERE IF STRAIGHT MODE
		
		if (obf_makefragsets > 0 and obf_fragsperset > 0 and !GlobObf_Straight) {
			%varlistname%_%newrow%_numfragrows = % divideintofrags(varlistname . "_" . newrow) 	
		} else 
			%varlistname%_%newrow%_numfragrows = 0
				
		%varlistname%_%newrow%_addnullfrags = % obf_addnullfrags		
	}
}

createREPLACEMENTSlist() {
	global
	
	replaceoddchars = % "fk@#" 
	
	replacementsperoddchar = 20
	replacewithOBF_replacementsperoddchar = % replacementsperoddchar
	
	loop, % strlen(replaceoddchars)
	{
		curoddchar = % substr(replaceoddchars, a_index, 1)
	
		;master 'security' variable name
		replace%curoddchar%withOBF_MASTvarname = % randomOBFname(12, 24)
		
		loop, % replacementsperoddchar
			replace%curoddchar%withOBF_%a_index% = % randomOBFname(14, 24)		
	}
	
	;template
	;replace#withOBF_MASTvarname = obfname	
	;replace#withOBF_1 = replace#withOBF_MASTvarname
	;replace#withOBF_2 = replace#withOBF_MASTvarname
	;replace#withOBF_3 = replace#withOBF_MASTvarname
	
	;replace@withOBF_MASTvarname = obfname	
	;replace@withOBF_1 = replace@withOBF_MASTvarname
	;replace@withOBF_2 = replace@withOBF_MASTvarname
	;replace@withOBF_3 = replace@withOBF_MASTvarname
}

createNULLSlist() {
	global
	
	while OBF_NULL_numrows < 100
	{
		newrow = % ++OBF_NULL_numrows
		; tooltip OBF_NULL_MinSize %OBF_NULL_MinSize% OBF_NULL_MaxSize %OBF_NULL_MaxSize%
		OBF_NULL_%newrow% = % randomOBFname(OBF_NULL_MinSize, OBF_NULL_MaxSize)
	}
}

divideintofrags(varloc) 
{
	global

	intofragsstarttime = % A_TickCount	
	
	if (!%varloc%_OBFname or  %varloc%_OBFname = "no/obf")
		return, 0
	
	%varloc%_numfragrows = 0
	%varloc%_fragsperrow = % obf_fragsperset
	
	
	if (obf_makefragsets < 1 or obf_fragsperset < 1) 		
		return, 0
		
	newrec = 0
	;just the case where i divide it into only one 'frag'
	if (obf_fragsperset = 1) {
		loop, % obf_makefragsets
		{
			newfragname = % randomOBFname(obf_fragvarsizemin, obf_fragvarsizemax)
			newrec++
			%varloc%_frag_%newrec%_1_varname = % newfragname
			%varloc%_frag_%newrec%_1_value 	 = % %varloc%_OBFname			
		}
		%varloc%_numfragrows = % newrec	
intofragstime += A_TickCount - intofragsstarttime		
		return, % newrec
	}
	
	OBFnamelen = % strlen(%varloc%_OBFname)
	newrec = 0
	if (obf_fragsperset = 2) {
		loop, % obf_makefragsets
		{			
			qpart = % OBFnamelen // 4
			if (!qpart)
				qpart = 1
				
			;randomly divide the full obfuscated name into 2 parts
			;so i have at least 4 characters per string
						
			Random, randdivide, % qpart, % OBFnamelen - qpart
			
			leftstr = % substr(%varloc%_OBFname, 1, randdivide)
			rightstr = % substr(%varloc%_OBFname, randdivide + 1)
			
			newfragname1 = % randomOBFname(obf_fragvarsizemin, obf_fragvarsizemax)
			newfragname2 = % randomOBFname(obf_fragvarsizemin, obf_fragvarsizemax)
			
			newrec++
			%varloc%_frag_%newrec%_1_varname = % newfragname1
			%varloc%_frag_%newrec%_1_value 	 = % leftstr
			%varloc%_frag_%newrec%_2_varname = % newfragname2
			%varloc%_frag_%newrec%_2_value 	 = % rightstr			
		}
		%varloc%_numfragrows = % newrec
intofragstime += A_TickCount - intofragsstarttime			
		return, % newrec
	}
	
	%varloc%_numfragrows = 0
	%varloc%_fragsperrow = 0

intofragstime += A_TickCount - intofragsstarttime		
	return, 0
}

;DIGIDON TWEAKED no "," split for contextcondition
set_obfcreate_names(OBFType="") {
	global
	
	if (transCOMMparam0 < 1) 
		{
		return, % false
		}
		
	obfcreate_varname0 = 0
	;the first parameter set will be the object names
	if (OBFType="OBF_CONTEXTCONDITION") {
	; msgbox transCOMMparam1 %transCOMMparam1%
	obfcreate_varname1:=Trim(transCOMMparam1)
	obfcreate_varname0:=1
	} else
	StringSplit, obfcreate_varname, transCOMMparam1, `,, %a_space%%a_tab%
	
	; if (OBFType="OBF_LABEL")
	; if InStr(transCOMMparam1,"!^c")
	; msgbox obfcreate_varname1 %obfcreate_varname1%
	
	if (!obfcreate_varname0)
		{
		return, % false
		}
		
	return, % true
}

set_obfcreate_params(vartypenum) {
	global
	static curvartype, curproperty
	
	obfcreatestarttime = % A_TickCount
	
	;convert to something like 'SYSFUNC'
	curvartype = % vartype%vartypenum%
	
	;the first parameter set will be the object names
	;the second set will be the optional obfuscation parameters
	obfcreate_param0 = 0
	;DIGIDON MAYBE : DELETE THAT PART BECAUSE RARELY USED : SOME COMMANDS WITH "\" INSIDE
	if (transCOMMparam0 >= 2) 
		{
		StringSplit, obfcreate_param, transCOMMparam2, `,, %a_space%%a_tab%
		}
			
	loop, % numdefaultprop
	{
		curproperty = % defaultprop%a_index%
		
		;if no parameter was specified in the translations command
		;then use the current 'default' one for that vartype
		if (a_index > obfcreate_param0 or obfcreate_param%a_index% = "") {
			obf_%curproperty% = % %curvartype%_%curproperty%
			continue		
		}
		;use the passed parameter
		obf_%curproperty% = % obfcreate_param%a_index%
	
	}
	
	obfcreatetime += A_TickCount - obfcreatestarttime
}

IS_OBFTRANSCOMM(ByRef programline)
{
	;early return test
	if (SubStr(programline, 1, 1) <> "$")
		return, % false
	
	return, % getobfTRANScomm(programline)
	
}

getobfTRANScomm(ByRef programline)
{
	global 
	local endTRANScomm, TRANScommparams
	
	transCOMMparam0 = 0
	
	
	
	if (!endTRANScomm := InStr(programline, ":", false, 2))
		return, % false
			
	CUR_OBFTRANSCOMM = % SubStr(programline, 2, (endTRANScomm - 2))	
	
	if !strlen(CUR_OBFTRANSCOMM)
		return, % false
		
	transCOMMparams = % SubStr(programline, (endTRANScomm + 1))
	
	;TWEAKED DIGIDON : DISABLED BECAUSE COMMAND WITH \ PROBLEM WITH IF CONTEXT CONDITION
	;break into command/parameters/../
	; StringSplit, transCOMMparam, TRANScommparams, /, %A_Tab%%A_Space%
	
	; if InStr(programline,"!^c")
	; msgbox programline %programline% TRANScommparams %TRANScommparams%
	
	transCOMMparam1:=TRANScommparams
	transCOMMparam0:=1
	; if transCOMMparam0!=1
	; msgbox TRANScommparams %TRANScommparams% transCOMMparam0 %transCOMMparam0%
	return, % true			
}

add_messedupname(messedupname)
{
	global
	
	if (!messedupnamelist) {
		VarSetCapacity(messedupnamelist, 2000000)
		messedupnamelist = % "`n"	
	}
	
	messedupnamelist .= messedupname . "`n"
}

find_messedupname(messedupname) {
	global
	
	findstr = % "`n" . messedupname . "`n"
	
	if instr(messedupnamelist, findstr)
		return, true
	else
		return, false
}

markFUNCANDVARwithfuncrow() {
	global
	local myfuncname, usefuncatrow
	
	loop, % OBF_FUNCandVAR_numrows
	{			
		myfuncname = % OBF_FUNCandVAR_%A_Index%_name
		
		;no actual translation found in func list
		if (usefuncatrow := FIND_VARROW("OBF_FUNC", myfuncname))  
			OBF_FUNCandVAR_%A_Index%_funcrow = % usefuncatrow			
		else
			OBF_FUNCandVAR_%A_Index%_funcrow = 0
		
	}
}

writetranstablemessheader() {
	global
	local headerstr
	
	headerstr =
(

	OBFUSCATOR TRANSLATION TABLE CREATION MESSAGES FILE
	Date: %currenttime%

	#FILE IN WHICH THE TRANSLATION COMMANDS WERE FOUND:
	%replacemapfile%

)
	write_transtablemess(headerstr)
}

write_transtablemess(writethis){
	GLOBAL transtablemessstr
	
	;decided not to create this file!
	; return
	
	if (!transtablemessstr)
		 VarSetCapacity(transtablemessstr, 160000)
		 
	transtablemessstr .=  "`r`n" . writethis
}

close_transtablemess() {
	global
	;MODIFIED DIGIDON : REACTIVATED THIS FILE USEFULL FOR DEBUGGING AND UNDERSTANDING
	
	;messages concerning the translation table created will be written here
	replacemapfile:=SubStr(myTRANSCOMMSfile,1,-4)
	transtable_messfile = % replacemapfile . "_RMESS.txt"
	;delete if already exists
	FileDelete, % transtable_messfile	
	FileAppend, % transtablemessstr, % transtable_messfile	
}

countparamsandLOSvars() {
	global
	
	totalparams = 0
	totalLOSvars = 0
	loop, % OBF_FUNC_NUMROWS
	{
		if (OBF_FUNC_%a_index%_PARAM_numrows > 0)
			totalparams += OBF_FUNC_%a_index%_PARAM_numrows
		if (OBF_FUNC_%a_index%_LOSvar_numrows > 0)
			totalLOSvars += OBF_FUNC_%a_index%_LOSvar_numrows
	}
}

showclassesfound() {
	global
	local mycurclass, numreplacements
	
	numclassesfound = 0
	unclassedfuncsfound = 0
	unclassedlabelsfound = 0
	
	;accumulate function class statistics 
	loop, % OBF_FUNC_numrows
	{
		;no class name found
		if (!mycurclass := OBF_FUNC_%a_index%_classname) {
			unclassedfuncsfound++
			continue			
		}		
		
		;found the first one for this class
		if(!foundclass_%mycurclass%) {
			foundclass_%mycurclass% = 1
			foundclass_%mycurclass%_numfuncfound = 0
			foundclass_%mycurclass%_numlabfound = 0
			numclassesfound++
			foundclassname_%numclassesfound% = % mycurclass
		} 
		
		foundclass_%mycurclass%_numfuncfound++		
	}	
		
	;accumulate label statistics 
	loop, % OBF_LABEL_numrows
	{
		;no class name found
		if (!mycurclass := OBF_LABEL_%a_index%_classname) {
			unclassedlabelsfound++
			continue
		}
		
		;found the first one for this class
		if(!foundclass_%mycurclass%) {
			foundclass_%mycurclass% = 1
			foundclass_%mycurclass%_numfuncfound = 0
			foundclass_%mycurclass%_numlabfound = 0
			numclassesfound++
			foundclassname_%numclassesfound% = % mycurclass
		} 
		
		foundclass_%mycurclass%_numlabfound++		
	}	

	foundsecclasses=
	
	;find the 'secure' classes and build a list
	loop, % numclassesfound
	{
		mycurclass = % foundclassname_%a_index%
		numnulls = % CLASS_%mycurclass%_numnulls
		numreplacements = % CLASS_%mycurclass%_numreplacements
		
		if (!numnulls and !numreplacements)
			continue
			
		foundsecclasses .= mycurclass . "`n"			
	}
	
	;sort the list
	Sort, foundsecclasses	
	
	foundclasses = **SECURED CLASSES FOUND**
	
	;print them out
	loop, parse, foundsecclasses, `n
	{
		mycurclass = % a_loopfield
		mycurclass = %mycurclass%
		if (!mycurclass)
			continue
			
		numnulls = % CLASS_%mycurclass%_numnulls
		numreplacements = % CLASS_%mycurclass%_numreplacements
		
		foundclasses .=  "`n" . mycurclass . addtabs(mycurclass) 
			. foundclass_%mycurclass%_numfuncfound 
			. ", " . foundclass_%mycurclass%_numlabfound 
			
		foundclasses .= "`n" . a_tab . "num NULLS: " . numnulls 
			. "     replacements: " . numreplacements 
	
	}
	
	foundnonsecclasses=
	
	;find the non'secure' classes and build a list
	loop, % numclassesfound
	{
		mycurclass = % foundclassname_%a_index%
		numnulls = % CLASS_%mycurclass%_numnulls
		numreplacements = % CLASS_%mycurclass%_numreplacements
		
		if (numnulls or numreplacements)
			continue
			
		foundnonsecclasses .= mycurclass . "`n"			
	}
	
	;sort the list
	Sort, foundnonsecclasses	
	
	foundclasses .= "`n`n**NON SECURED CLASSES FOUND**"		
			
	;print them out
	loop, parse, foundnonsecclasses, `n
	{
		mycurclass = % a_loopfield
		mycurclass = %mycurclass%
		if (!mycurclass)
			continue
			
		foundclasses .=  "`n" . mycurclass . addtabs(mycurclass) 
			. foundclass_%mycurclass%_numfuncfound 
			. ", " . foundclass_%mycurclass%_numlabfound 
	
	}

	foundclasses .= "`n`n**'UNCLASSED' funcs: " . unclassedfuncsfound 
	foundclasses .= "  labels: " . unclassedlabelsfound . "`n"
	
	return, foundclasses	
}

addtabs(mycurclass)
{
	if (strlen(mycurclass) > 18)
		return a_tab
		
	if (strlen(mycurclass) > 9)
		return a_tab . a_tab
		
	return a_tab . a_tab . a_tab
}
show_switched_funcs() {
	global
	
	foundswitched= **SWITCHED FUNCS**`n
	loop, % numswitchedfuncs
	{
		foundswitched .= switched_%a_index%_switchfrom . " -> " 
			. switched_%a_index%_switchto . "`n"		
	}
	return, foundswitched
}
	
showobfstats() {
	global
	
	countparamsandLOSvars()
	
	myshowclasses = % showclassesfound()
	myshowswitched = % show_switched_funcs()
	
	;TWEAKED DIGIDON : DISABLED FUNCANDVAR LINE BEACAUSE SEEMS TO BE FOR SPECIFIC UNDOCUMENTED USED
	; FUNCandVARs: %OBF_FUNCANDVAR_numrows%
	
	msgbox, 4097,, 
	;ADDED DIGIDON counttotalMAPlines,countTOTALlines
	(LTrim
	counttotalMAPlines (approx): %counttotalMAPlines%
	messedupnames_recs: %messedupnames_recs%   already used: %numalreadyused%
	*****************************
	Total lines of code: %countTOTALlines%
	*****************************
	HERE IS WHAT WAS FOUND:
	FUNCTIONS: %OBF_FUNC_numrows%
	LABEL HEADERS: %OBF_LABEL_numrows%
	PARAMETERS: %totalparams%
	*****************************
	HERE IS WHAT WAS DECLARED:
	LOS vars: %totalLOSvars%
	GLOBAL vars: %OBF_GLOBVAR_numrows%
	GLOBALPARTIAL vars: %OBF_GLOBPARTIALVAR_numrows%
	SYSTEM vars: %OBF_SYSVAR_numrows%
	SYSPROPERTIES vars: %OBF_SYSPROPERTIES_numrows%
	SYSMETHODS vars: %OBF_SYSMETHODS_numrows%
	SYSTEM FUNCTIONS: %OBF_SYSFUNC_numrows%
	*****************************
	DUMP CLASSES: %dumpcode_numrows%
	
	%myshowswitched%
	%myshowclasses%
	)
	;TWEAKED DIGIDON Can Cancel
	IfMsgBox Cancel
	{
	getOBFfilenames()
	exit
	}
}
