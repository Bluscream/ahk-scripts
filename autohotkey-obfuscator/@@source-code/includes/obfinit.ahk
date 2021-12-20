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


;used for multiple things throughout the program
initvartypes()
{
	global
	;MODIFIED DIGIDON
	numvartypes = 12
	; numvartypes = 8
	
	vartype1 = SYSFUNC
	vartype2 = FUNC
	vartype3 = LABEL
	vartype4 = PARAM
	vartype5 = LOSVAR
	vartype6 = GLOBVAR
	vartype7 = FUNCANDVAR
	;DIGIDON: should we add GUIFUNTCIONS?
	vartype8 = GUILABEL
	;ADDED DIGIDON GLOBPARTIALVARS
	vartype9 = GLOBPARTIALVAR
	;ADDED DIGIDON SYSPROPERTIES
	vartype10 = SYSPROPERTIES
	;ADDED DIGIDON SYSMETHODS
	vartype11 = SYSMETHODS
	;ADDED DIGIDON SYSVAR
	vartype12 = SYSVAR
}


initOBFdefaults() {
	global
	
	;Tweaked Digidon: simplier to add hidestring functions : just add the function name to the list
	;DIGIDON COMMENT : i_hidestr and i_hidestr_B are custom hidestring functions I use myself. Replace by yours
	HideStrFunc_list := "hidestr,i_hidestr,i_hidestrB"
	
	; ADDED UNCOMPLETE DIGIDON MINMAXNULLS & MINMAXREPLACEMENTS , +per row ? : SHOULD BE ABLE TO BE MODIFIED LIKE
	; sysfunc_straightminmaxnulls = 13
	; sysfunc_minmaxnulls 		= 12
	; sysfunc_minmaxreplacements 	= 12
	
	;DIGIDON : FOR TIME BEING MINMAXNULLS ARE SET HERE FOR ALL EXCEPT GLOBPARTIAL
	all_straightminmaxnulls = 12 ;except Globpartial
	all_minmaxnulls 		= 12
	all_minmaxreplacements 	= 12
	
	;ADDED UNCOMPLETE DIGIDON : SHOULD BE ABLE TO BE MODIFIED OR AUTOMATIC?, MUST BE MULTIPLE OF 2
	;DIGIDON : FOR TIME BEING NULL MIN/MAX SIZE ARE SET HERE FOR ALL 
	OBF_NULL_MinSize = 4
	OBF_NULL_MaxSize = 8
	
	defaultprop1  = sizemin
	defaultprop2  = sizemax
	defaultprop3  = makefragsets
	defaultprop4  = fragsperset
	defaultprop5  = fragvarsizemin
	defaultprop6  = fragvarsizemax	
	defaultprop7  = addnullfrags
	; UNCOMPLETE DIGIDON MINMAXNULLS & MINMAXREPLACEMENTS
	; defaultprop8  = strminmaxnulls
	; defaultprop9  = minmaxnulls
	; defaultprop10 = minmaxreplacements
	
	numdefaultprop = 7
	; UNCOMPLETE DIGIDON MINMAXNULLS & MINMAXREPLACEMENTS
	; numdefaultprop = 10
	
	;definition of initial defaults
	
	sysfunc_sizemin 			= 12
	sysfunc_sizemax 			= 16
	sysfunc_makefragsets		= 4
	sysfunc_fragsperset			= 2	
	sysfunc_fragvarsizemin  	= 12
	sysfunc_fragvarsizemax		= 16
	sysfunc_addnullfrags 		= 1
	
	func_sizemin 		= 12
	func_sizemax 		= 16
	func_makefragsets	= 2
	func_fragsperset	= 1	
	func_fragvarsizemin = 12
	func_fragvarsizemax	= 16
	func_addnullfrags 	= 1
	
	label_sizemin		 = 22
	label_sizemax		 = 42
	label_makefragsets	 = 2
	label_fragsperset	 = 1	
	label_fragvarsizemin = 22
	label_fragvarsizemax = 35
	label_addnullfrags	 = 1
	
	param_sizemin		 = 12
	param_sizemax		 = 16
	param_makefragsets	 = 2
	param_fragsperset	 = 1	
	param_fragvarsizemin = 14
	param_fragvarsizemax = 26
	param_addnullfrags	 = 1
	
	LOSvar_sizemin		  = 12
	LOSvar_sizemax		  = 22
	LOSvar_makefragsets	  = 2
	LOSvar_fragsperset	  = 1	
	LOSvar_fragvarsizemin = 14
	LOSvar_fragvarsizemax = 28
	LOSvar_addnullfrags	  = 1
	
	;TWEAKED DIGIDON : CHANGED DEFAULTS
	GLOBvar_sizemin		   = 6
	GLOBvar_sizemax		   = 12
	GLOBvar_makefragsets   = 2
	GLOBvar_fragsperset    = 1
	GLOBvar_fragvarsizemin = 6
	GLOBvar_fragvarsizemax = 12
	GLOBvar_addnullfrags   = 1
	
	;ADDED DIGIDON SYSPROPERTIES
	SYSPROPERTIES_sizemin 		= 10
	SYSPROPERTIES_sizemax 		= 16
	SYSPROPERTIES_makefragsets	= 2
	SYSPROPERTIES_fragsperset		= 2
	SYSPROPERTIES_fragvarsizemin  = 8
	SYSPROPERTIES_fragvarsizemax	= 12
	SYSPROPERTIES_addnullfrags 	= 1
	
	;ADDED DIGIDON SYSMETHODS
	SYSMETHODS_sizemin 		= 10
	SYSMETHODS_sizemax 		= 16
	SYSMETHODS_makefragsets	= 2
	SYSMETHODS_fragsperset		= 2
	SYSMETHODS_fragvarsizemin  = 8
	SYSMETHODS_fragvarsizemax	= 12
	SYSMETHODS_addnullfrags 	= 1
	
	;ADDED DIGIDON SYSVARS
	SYSvar_sizemin 		= 12
	SYSvar_sizemax 		= 16
	SYSvar_makefragsets	= 2
	SYSvar_fragsperset		= 2	
	SYSvar_fragvarsizemin  = 12
	SYSvar_fragvarsizemax	= 16
	SYSvar_addnullfrags 	= 1
	
	;ADDED DIGIDON GLOBPARTIALVARS
	GLOBPARTIALvar_sizemin		  = 4
	GLOBPARTIALvar_sizemax		  = 8
	GLOBPARTIALvar_makefragsets   = -1
	GLOBPARTIALvar_fragsperset    = 1
	GLOBPARTIALvar_fragvarsizemin = 0
	GLOBPARTIALvar_fragvarsizemax = 0
	GLOBPARTIALvar_addnullfrags   = -1
	;ADDED DIGIDON straightminmaxnulls special for globpartial
	GLOBPARTIALvar_straightminmaxnulls 	= 23
	
	FUNCandVAR_sizemin		  = -1
	FUNCandVAR_sizemax		  = -1
	FUNCandVAR_makefragsets   = -1
	FUNCandVAR_fragsperset    = 2
	FUNCandVAR_fragvarsizemin = 14
	FUNCandVAR_fragvarsizemax = 20
	FUNCandVAR_addnullfrags   = 1
	
	guilabel_sizemin		 = 16
	guilabel_sizemax		 = 26
	guilabel_makefragsets	 = -1
	guilabel_fragsperset	 = 1	
	guilabel_fragvarsizemin = 12
	guilabel_fragvarsizemax = 15
	guilabel_addnullfrags	 = 1
	
	;CREATION OF CLASSES FOR FUNCTIONS
	;these are the 'start' defaults
	defaultCLASS_makenumnulls			= 40
	defaultCLASS_nullnameminsize		= 14
	defaultCLASS_nullnamemaxsize		= 26
	defaultCLASS_replacementsperchar	= 10
	defaultCLASS_replacenameminsize		= 14
	defaultCLASS_replacenamemaxsize		= 26
	
	defaultCLASSprop1 = makenumnulls
	defaultCLASSprop2 = nullnameminsize
	defaultCLASSprop3 = nullnamemaxsize
	defaultCLASSprop4 = replacementsperchar	
	defaultCLASSprop5 = replacenameminsize	
	defaultCLASSprop6 = replacenamemaxsize
	
	numdefaultCLASSprop = 6
	
}