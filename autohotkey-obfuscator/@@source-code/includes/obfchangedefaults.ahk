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

;ADDED DIGIDON : BLOCKS COMMENTS
isblockCOMM(obfCOMM) {
	global
	startorendCOMM=
		if (obfCOMM = "START_BLOCK") {
			startorendCOMM = start
		}
		if (obfCOMM = "END_BLOCK") {
			startorendCOMM = end
		}
	return startorendCOMM
}

;ADDED DIGIDON : KEEP COMMENTS
iskeepcommCOMM(obfCOMM) {
	global
	startorendCOMM=
		if (obfCOMM = "START_COMMENT") {
			startorendCOMM = start
		}
		if (obfCOMM = "END_COMMENT") {
			startorendCOMM = end
		}
	return startorendCOMM
}

;ADDED DIGIDON : COMMENT TO STOP OBF
isstopobfCOMM(obfCOMM) {
	global
	stoporresumeCOMM=
		if (obfCOMM = "STOP_OBF") {
			stoporresumeCOMM = stop
		}
		if (obfCOMM = "RESUME_OBF") {
			stoporresumeCOMM = resume
		}
	return stoporresumeCOMM
}

;ADDED DIGIDON : COMMENT TO FORCE STRAIGHT OBF
isobfmodeCOMM(obfCOMM) {
	global
	obfmodeCOMM=
		if (obfCOMM = "STRAIGHT") {
			obfmodeCOMM = straight
		}
		if (obfCOMM = "DYNAMIC") {
			obfmodeCOMM = dynamic
		}
	return obfmodeCOMM
}

ischangedefaultsCOMM(obfCOMM)
{
	global
	static legalchangeCOMM, legalrestoreCOMM
	
	;the template for the change and restore commands as found in the original
	;source code or translations map will be:
	;%vartype%S_CHANGE_DEFAULTS
	;%vartype%S_RESTORE_DEFAULTS
	
	loop, % numvartypes
	{
		legalchangeCOMM = % vartype%a_index% . "S_CHANGE_DEFAULTS"
		if (obfCOMM = legalchangeCOMM) {
			changeorrestoreCOMM = change
			return, % a_index		
		}		
		
		legalrestoreCOMM = % vartype%a_index% . "S_RESTORE_DEFAULTS"
		if (obfCOMM = legalrestoreCOMM) {
			changeorrestoreCOMM = restore
			return, % a_index		
		}		
	}
	return, % false
}


;ADDED DIGIDON : COMMENT TO STOP OBF
stopOBF()
{
	global
	GlobObf_Stop=1
}
;ADDED DIGIDON : COMMENT TO STOP OBF
resumeOBF()
{
	global
	GlobObf_Stop=
}

;ADDED DIGIDON : COMMENT TO STOP OBF
straightOBF()
{
	global
	GlobObf_Straight=1
}
;ADDED DIGIDON : COMMENT TO STOP OBF
dynamicOBF()
{
	global
	GlobObf_Straight=
}

changeOBFdefaults(defaultsnum)
{
	global
	static curvartype, curproperty
	
	saveOBFdefaults(defaultsnum)
	
	;convert to something like 'SYSFUNC'
	curvartype = % vartype%defaultsnum%
	
	;the first parameter set Will be the CHANGE obfuscation parameters
	
	obfcreate_param0 = 0
	if (transCOMMparam0 >= 1) 
		StringSplit, obfCHANGE_param, transCOMMparam1, `,, %a_space%%a_tab%	
			
	loop, % numdefaultprop
	{
		;if no parameter was specified in the CHANGE command
		;then do not change the  current 'default' one
		if (a_index > obfCHANGE_param0 or obfCHANGE_param%a_index% = "") 
			continue		
				
		curproperty = % defaultprop%a_index%
		
		;use the passed parameter
		%curvartype%_%curproperty% = % obfCHANGE_param%a_index%	
	}
}


restoreOBFdefaults(defaultsnum)
{
	global	
	static vartype
	
	vartype = % vartype%defaultsnum%
	
	%vartype%_sizemin 		 = % saved_%vartype%_sizemin
	%vartype%_sizemax 		 = % saved_%vartype%_sizemax 
	%vartype%_makefragsets 	 = % saved_%vartype%_makefragsets
	%vartype%_fragsperset 	 = % saved_%vartype%_fragsperset 
	%vartype%_fragvarsizemin = % saved_%vartype%_fragvarsizemin
	%vartype%_fragvarsizemin = % saved_%vartype%_fragvarsizemin
	%vartype%_addnullfrags 	 = % saved_%vartype%_addnullfrags 
}

restoreall_OBFdefaults()
{
	global	
	
	loop, % numvartypes
		restoreOBFdefaults(a_index)
}
saveOBFdefaults(defaultsnum)
{
	global	
	static vartype
	
	vartype = % vartype%defaultsnum%	
		
	saved_%vartype%_sizemin 		= % %vartype%_sizemin
	saved_%vartype%_sizemax 		= % %vartype%_sizemax
	saved_%vartype%_makefragsets 	= % %vartype%_makefragsets
	saved_%vartype%_fragsperset		= % %vartype%_fragsperset
	saved_%vartype%_fragvarsizemin 	= % %vartype%_fragvarsizemin
	saved_%vartype%_fragvarsizemin 	= % %vartype%_fragvarsizemin
	saved_%vartype%_addnullfrags 	= % %vartype%_addnullfrags
}

init_changedefaultsCOMMs()
{
	global
	
	;these are the definitions neccesary in order to decode obfuscater commands
	;to _CHANGE_DEFAULTS or _RESTORE_DEFAULTS for a specific vartype
	
	;the template for the change and restore commands as found in the original
	;source code or translations map will be:
	;%vartype%S_CHANGE_DEFAULTS
	;%vartype%S_RESTORE_DEFAULTS
	
	restoreallCOM 	= RESTOREALL_DEFAULTS
	
	def_SYSFUNCS	= DEFSYSFUNCS
	def_FUNCS		= DEFFUNCS
	def_LABELS		= DEFLABELS
	def_PARAMS		= DEFPARAMS
	def_LOSVARS 	= DEFLOSVARS
	def_GLOBVARS	= DEFGLOBVARS
	;ADDED DIGIDON GLOBPARTIALVARS, SYSPROPERTIES, SYSMETHODS, SYSVARS
	def_GLOBPARTIALVARS	= DEFGLOBPARTIALVARS
	def_SYSPROPERTIES	= DEFSYSPROPERTIES
	def_SYSMETHODS	= DEFSYSMETHODS
	def_SYSVARS	= DEFSYSVARS
	; TWEAKED DIGIDON HOTKEY : SEPARATE FROM LABEL : NO OBF : need to look better if csq !!
	def_HOTKEYS	= DEFHOTKEYS
	;ADDED DIGIDON CLASS AND #IF CONTEXT CONDITIONS
	def_CLASS	= DEFCLASS
	def_COND	= DEFCOND
		
	;Only allowed inside a function
	;DEFINE LOCAL OR STATIC OR DEFINE FUNCandVAR
	def_FUNCandVARS = DEFFUNCANDVARS	
	
	;create_funcsCLASS 	= CREATEFUNCSCLASS
	
	create_objsCLASS	= CREATEOBJCLASS
	
	add_funcstoCLASS	= ADDFUNCSTOCLASS
	
	add_followingtoCLASS = ADDFOLLOWING_TOCLASS
}

/*

;---------------------------------------------------------------
;		PARAMETERS PASSED TO THE CLASS CREATE FUNCTION

makenumnulls
nullnameminsize
nullnamemaxsize

replacementsperchar
replacenameminsize
replacenamemaxsize

;---------------------------------------------------------------
;	VARIABLES CREATED BY THIS PROGRAM

CLASS_%classname% = 1

CLASS_%classname%_numnulls
CLASS_%classname%_NULL_MASTvarname
CLASS_%classname%_NULL_%curnullrow%_varname

CLASS_%classname%_numreplacements
CLASS_%classname%_replace%char%_MASTvarname
CLASS_%classname%_replace%char%_%curRnum%_varname
CLASS_%classname%_replace%char%_%curRnum%_value = % char

*/


/*
	for vartypes of 'func' and 'label'
	OBF_%vartype%_%rownum%_classname
	
	for vartypes of 'sysfunc', 'func' , 'label', 'globvar'
	OBF_%vartype%_numrows
	OBF_%vartype%_%rownum%_name
	OBF_%vartype%_%rownum%_OBFname
	OBF_%vartype%_%rownum%_numfragrows
	OBF_%vartype%_%rownum%_fragsperrow
	OBF_%vartype%_%rownum%_lastfragrowused
	OBF_%vartype%_%rownum%_frag_%frow%_%fcol%_varname
	OBF_%vartype%_%rownum%_frag_%frow%_%fcol%_value

	for vartype of 'func' and subtype of 'param' or 'LOSvar' only
	OBF_%vartype%_%rownum%_param_numrows
	OBF_%vartype%_%rownum%_param_%prow%_name
	OBF_%vartype%_%rownum%_param_%prow%_OBFname
	OBF_%vartype%_%rownum%_param_%prow%_numfragrows
	OBF_%vartype%_%rownum%_param_%prow%_fragsperrow
	OBF_%vartype%_%rownum%_param_%prow%_lastfragrowused
	OBF_%vartype%_%rownum%_param_%prow%_frag_%frow%_%fcol%_varname 
	OBF_%vartype%_%rownum%_param_%prow%_frag_%frow%_%fcol%_value
	OBF_%vartype%_%rownum%_LOSvar_numrows
	OBF_%vartype%_%rownum%_LOSvar_%lrow%_name
	OBF_%vartype%_%rownum%_LOSvar_%lrow%_OBFname
	;DIGIDON TWEAKED : DELETE _replacementsdone PART BECAUSE VARIABLES ARE NOW NOT OBF IF LOCAL/GLOBAL/STATIC
	; OBF_%vartype%_%rownum%_LOSvar_%lrow%_replacementsdone
	OBF_%vartype%_%rownum%_LOSvar_%lrow%_numfragrows
	OBF_%vartype%_%rownum%_LOSvar_%lrow%_fragsperrow
	OBF_%vartype%_%rownum%_LOSvar_%lrow%_lastfragrowused
	OBF_%vartype%_%rownum%_LOSvar_%lrow%_frag_%frow%_%fcol%_varname
	OBF_%vartype%_%rownum%_LOSvar_%lrow%_frag_%frow%_%fcol%_value
	
	for vartype of 'funcandvar' only
	OBF_%vartype%_numrows
	OBF_%vartype%_%rownum%_name
	OBF_%vartype%_%rownum%_OBFname = no/obf
	;create after obfuscation translations data object is done creation for faster lookup
	OBF_%vartype%_%rownum%_funcrow 
		
	for vartype of 'func' and subtype of 'FUNCandVAR' only
	OBF_%vartype%_%rownum%_FUNCandVAR_numrows
	OBF_%vartype%_%rownum%_FUNCandVAR_%fvrow%_name
	OBF_%vartype%_%rownum%_FUNCandVAR_%fvrow%_OBFname = no/obf
	
*/	


