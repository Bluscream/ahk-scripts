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


/*
	**STRUCTURE OF THE OBFUSCATION REPLACEMENTS TABLE CREATED BY THIS PROGRAM**
	
	for vartypes of 'func'
	OBF_%vartype%_%rownum%_classname	
	
	for vartypes of 'sysfunc', 'func' , 'label', 'globvar'
	OBF_%vartype%_numrows ;number of objects of type vartype
	OBF_%vartype%_%rownum%_name ;original object name
	OBF_%vartype%_%rownum%_OBFname ;'straight obfustication value'
	OBF_%vartype%_%rownum%_numfragrows ;dynamic obfuscation rows
	OBF_%vartype%_%rownum%_fragsperrow ;dynamic obfuscation columns
	OBF_%vartype%_%rownum%_frag_%frow%_%fcol%_varname ;
	OBF_%vartype%_%rownum%_frag_%frow%_%fcol%_value ;

	for vartype of 'func' and subtype of 'param' or 'LOSvar' only
	OBF_%vartype%_%rownum%_param_numrows
	OBF_%vartype%_%rownum%_param_%prow%_name
	OBF_%vartype%_%rownum%_param_%prow%_OBFname
	OBF_%vartype%_%rownum%_param_%prow%_numfragrows
	OBF_%vartype%_%rownum%_param_%prow%_fragsperrow
	OBF_%vartype%_%rownum%_param_%prow%_frag_%frow%_%fcol%_varname 
	OBF_%vartype%_%rownum%_param_%prow%_frag_%frow%_%fcol%_value
	OBF_%vartype%_%rownum%_LOSvar_numrows
	OBF_%vartype%_%rownum%_LOSvar_%prow%_name
	OBF_%vartype%_%rownum%_LOSvar_%prow%_OBFname
	OBF_%vartype%_%rownum%_LOSvar_%prow%_numfragrows
	OBF_%vartype%_%rownum%_LOSvar_%prow%_fragsperrow
	OBF_%vartype%_%rownum%_LOSvar_%prow%_frag_%frow%_%fcol%_varname
	OBF_%vartype%_%rownum%_LOSvar_%prow%_frag_%frow%_%fcol%_value

	****USED FOR A SPECIAL CODING IN MY PROGRAM SPEEDY ORANGE PC SHORTCUTS***
	*   THIS CODING USES FUNCTIONS AND LOS VARIABLE NAMES THAT ARE THE SAME
	*   IGNORE REFERENCES TO THESE OBJECTS IN THIS PROGRAM
	
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

;ADDED DIGIDON RESET GLOB SPECIAL COMMS
init_GlobalDefaults() {
	global
	GlobObf_Stop=
	GlobObf_Straight=
	GlobObf_Comment=
	GlobObf_Block=
	OBF_block_numrows=
	CommFlag=`;
	CommFlagRegex=`;
	countlinesprocessed=0
}

obfuscatecode()
{
	global

	writetoOBFfilestr=
	
	;ADDED DIGIDON : timer
	starttime_createTransMESS:=A_Tickcount
	
	initOBFdefaults()
	init_changedefaultsCOMMs()	
		
	;grab the path portion from 'myfileslistfile' and prepend to the output file name
	SplitPath, myfileslistfile,, myDir
	
	;OBFUSCATEDfile
	
	;contains replacement instructions created by the programmer
	VarSetCapacity(myTRANSCOMMS, 120000)
		 
	FileRead, myTRANSCOMMS, % myTRANSCOMMSfile
	;create replacements data object 'tree' in memory
	processTRANSmap(myTRANSCOMMS)

	;ADDED DIGIDON : timer
	endtime_createTransMESS:=A_Tickcount
	timepassed_createTransMESS:=endtime_createTransMESS-starttime_createTransMESS
	timepassed_createTransMESS_totalsc:=ROUND(timepassed_createTransMESS/1000)
	timepassed_createTransMESS_mn:=timepassed_createTransMESS_totalsc // 60
	timepassed_createTransMESS_sc:= Mod(timepassed_createTransMESS_totalsc, 60)
	
	showobfstats()
	
	;ADDED DIGIDON : timer
	starttime_obfuscatetotal:=A_Tickcount - timepassed_obfuscateonly
	
	close_transtablemess()
	
	showobfwindow()
	
	;ADDED DIGIDON : timer
	starttime_obfuscateonly:=A_Tickcount
	
	;ADDED DIGIDON RESET GLOB SPECIAL COMMS
	init_GlobalDefaults()
	;createTRANSMAPmesswin()
	;make copyright info into a form that can survive being compiled
	;namely make it into a string assigned to a variable so it is an actual
	;program statement
	mycopyright = % write_copyright_info()
		
	writetoOBFfile(mycopyright)
	
	;TWEAK DIGIDON : allow also only 1 ahk file
	if (SubStr(myfileslistfile,-3)=".ahk")
		fileslist:=myfileslistfile
	else
	FileRead, fileslist, % myfileslistfile
	
	totalsourcelines = 0
	
	;after label sections and function are 'broken off'
	;this is the function name that will be called to process it
	;this can have 2 different values
	processcodesection = % "OBFcodesection"
	
	;TWEAKED DIGIDON : TURN TO NEW PARSE FCT
	ParseIncludeList(fileslist)
	
	if (custdumporder) {
		usecustcode_dumporder()
		
	;alter the order of the function and label sections in the code
	} else if (scramblefuncs) {
		shuffleandadd_allcode()
	} else {
		;MODIFIED DIGIDON : DISABLED USELESS DEBUG dumpcompiledinfilesize_INCLUDE
		; dumpcompiledinfilesize_INCLUDE()
	}
	
	gui 4:default
	gui, destroy
	
	Tooltip
	;ADDED DIGIDON : timers
	endtime_obfuscateonly:=A_Tickcount
	timepassed_obfuscateonly:=endtime_obfuscateonly - starttime_obfuscateonly
	timepassed_obfuscateonly_totalsc:= ROUND(timepassed_obfuscateonly / 1000)
	timepassed_obfuscateonly_mn:= timepassed_obfuscateonly_totalsc // 60
	timepassed_obfuscateonly_sc:= Mod(timepassed_obfuscateonly_totalsc, 60)
	
	; msgbox % "Obfuscate Done in " timepassed_obfuscateonly " MLS " timepassed_obfuscateonly_mn " mn " timepassed_obfuscateonly_sc " sc "
	
	
	closeOBFfile()
	
	;doclasscleanup()
	
		
	;showmyprocmess("Total source code lines processed: " . totalsourcelines)

}

showobfwindow() {
	global
	gui 4:default
	gui, destroy
	gui, margin, 20, 20	
	
	gui, font, %scl_h1font% bold
	gui, add, text, xm ym Cab7430, Obfuscating Autohotkey Script
	
	gui, font, %scl_basefont% norm
	gui, add, text, xm y+20, 
	(
	Please wait while your program is being obfuscated.
	An 10,000 line program will take about 30 seconds.

	OUTPUT FILE WILL BE:
	%OBFUSCATEDfile%
	)
	gui, add, text, xm y+30, Source code file name being processed
	gui, add, edit, xm y+4 readonly Vshowscodefilename %editwidth% C009900
	gui, show, , Dynamic Obfuscator

}

;ADDED DIGIDON RESTORE GLOBOBF BK
restoreGlobObfMode() {
global
	GlobObf_Stop:=GlobObf_Stop_BK
	GlobObf_Straight:=GlobObf_Straight_BK
}

;ADDED DIGIDON BACKUP GLOBOBF BK
backupGlobObfMode() {
global
	GlobObf_Stop_BK:=GlobObf_Stop
	GlobObf_Straight_BK:=GlobObf_Straight
}


doclasscleanup() {
	global
	
	local mycurclass
	; msgbox, my secure classes: %foundsecclasses%
	
	loop, parse, foundsecclasses, `n
	{
		mycurclass = %a_loopfield%
		if (!mycurclass)
			continue
			
		; msgbox, hello 3: %mycurclass%
		;null class list
		CLASS_%mycurclass% =
	}
}

;---------------------------------------------
;**START OBFUSCATE SECTION**
;---------------------------------------------

OBFcodesection(preLOFlines, LOFheaderline, LOFbodylines, LOFtype, LOFname) {
	;LOCAL
	global writetoOBFfilestr, curSECTCLASS, curFUNCCALLCLASS
	global removeallwhitespace, scramblefuncs
	;ADDED DIGIDON
	global LOFHeaderObf
	global GlobObf_Stop,GlobObf_Straight,GlbObf_Comment,OBF_numrows,Glob_FctLocal,GlobObf_ForceStraight
	global CommFlag
	SetBatchLines -1
	;the function name and the string within the function call
	;the obf replaces in order to 'hide strings' in the obf'ed source code
	;do not move this function
	if (LOFtype = "function" and LOFname = "ihidestr") {
		if (!removeallwhitespace)
			writetoOBFfile("`r`n;SKIPPED MOVING function: 'ihidestr()' to OBF CODE`r`n")
		return
	}
	if (LOFtype = "function" and LOFname = "ihidestrB") {
		if (!removeallwhitespace)
			writetoOBFfile("`r`n;SKIPPED MOVING function: 'ihidestrB()' to OBF CODE`r`n")
		return
	}
	if (LOFtype = "function" and LOFname = "hidestr") {
		if (!removeallwhitespace)
			writetoOBFfile("`r`n;SKIPPED MOVING function: 'hidestr()' to OBF CODE`r`n")
		return
	}
	if (LOFtype = "function" and LOFname = "hidestrfast") {
		if (!removeallwhitespace)
			writetoOBFfile("`r`n;SKIPPED MOVING function: 'hidestrfast()' to OBF CODE`r`n")
		return
	}		
	
	if (!rowstoproc := createsourcearray(LOFbodylines, "LOFbody")) {
		showmyprocmess("**NO PROCESSABLE LINES FOUND IN " LOFtype . ":`r`n    " . LOFheaderline)
		return
	}
	
	;it will 'shift' the opening curly brace on a function section
	;up one line if possible
	if (LOFtype = "function")  
		movecurlybracesUP(LOFheaderline, LOFbodylines, LOFname)	
	
	;take comments out of body so i can search bodies faster without having
	;to worry about comments
	;DIGIDON : STILL LEAVES OBFUSCATOR COMMANDS
	strippedLOFbodylines = % removeBODYcomments(LOFbodylines)
	;DIGIDON ADDED : PROCESS SPECIAL COMMENTS when obfuscating
	findprocessOBFspecialcomms(preLOFlines)
			
	;ADDED DIGIDON OBF LOOP TO BE ABLE TO BREAK
	loop {
		;ADDED DIGIDON BACKUP GLOBOBF BK
		backupGlobObfMode()
		;TWEAKED DIGIDON #IF CONDITION
		if (LOFtype = "label" or LOFtype = "hotkey" or LOFtype = "contextcondition") {
		Glob_FctLocal:=0
		
			;ADDED DIGIDON FORCESTRAIGHT IF GlobObf_Stop
			if (GlobObf_Stop=1)
				{
				GlobObf_ForceStraight=1
				}
			else
				GlobObf_ForceStraight=
			
			replaceHIDESTRcalls(strippedLOFbodylines)
				
			;ADDED DIGIDON
			if (LOFHeaderObf=1)
				replaceHIDESTRcalls(LOFheaderline)
				
			if (LOFtype = "label")
				mysecttype = % "label:global"
			if (LOFtype = "hotkey")
				mysecttype = % "label:hotkey"
			if (LOFtype = "contextcondition")
				mysecttype = % "contextcondition"
			
			LOFHeaderObf=
			;ADDED DIGIDON OBF HEADERS OF LABELS (ALSO NESTED) AND CONDITIONS
			if (LOFtype = "hotkey")
				{
				if (!Regexmatch(LOFheaderline,"^" LOFname "::[\s]*$")) {
					; msgbox LOFname %LOFname% is NOT standard hotkey
					LOFHeaderObf=1
					}
				}
			else if (LOFtype = "contextcondition")
				{
				LOFHeaderObf=1
				}
				
			replaceLABELCALLS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
				; msgbox replaceLABELCALLS DONE `n%LOFtype% %LOFname% `nstrippedLOFbodylines %strippedLOFbodylines%
				
			;check body of label for calls to functions, replace with obf
			replaceFUNCCALLS("OBF_FUNC", preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			replaceFUNCCALLS("OBF_SYSFUNC", preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
				; msgbox replaceFUNCCALLS DONE `n%LOFtype% %LOFname% `nstrippedLOFbodylines %strippedLOFbodylines%
				
			;ADDED DIGIDON : if STOP OBF COMM THEN STOP HERE
			if (GlobObf_Stop=1)
				{
				; MSGBOX STOP OBF LOFheaderline %LOFheaderline%
				GlobObf_ForceStraight=
				break
				}
			
			;do not replace hotkey header with obfuscated string!
			if (LOFtype = "label")
				{
				replaceSECTIONHEADERname("OBF_LABEL", LOFheaderline, LOFtype, LOFname)
				if (Debug_Obf=1 && LOFname="PickIcon_gCons")
					msgbox replaceSECTIONHEADERname DONE `n%LOFtype% %LOFname% `nLOFheaderline %LOFheaderline% `nLOFbodylines %LOFbodylines%
				}
			
			if (LOFtype = "hotkey")
				{
				replaceLABELHeader(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
				if (Debug_Obf=1 && LOFname="PickIcon_gCons")
					msgbox replaceLABELHeader DONE `n%LOFtype% %LOFname% `nLOFheaderline %LOFheaderline% `nstrippedLOFbodylines %strippedLOFbodylines%
				}
			
			replaceNESTEDLABELheaders(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			if (Debug_Obf=1 && LOFname="PickIcon_gCons")
				msgbox replaceNESTEDLABELheaders DONE `n%LOFtype% %LOFname% `nstrippedLOFbodylines %strippedLOFbodylines%
				
			replaceFUNCandVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			if (Debug_Obf=1 && LOFname="PickIcon_gCons")
				msgbox replaceFUNCandVARs DONE `n%LOFtype% %LOFname% `nstrippedLOFbodylines %strippedLOFbodylines%
				
			;ADDED DIGIDON GLOBPARTIALVARS
			replaceGLOBALPARTIALVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			if (Debug_Obf=1 && LOFname="MG_Recognize")
				msgbox replaceGLOBALPARTIALVARs DONE `n%LOFtype% %LOFname% preLOFlines %preLOFlines% LOFheaderline %LOFheaderline% `nstrippedLOFbodylines %strippedLOFbodylines% end OBF
				
			;ADDED DIGIDON SYSPROPERTIES
			replaceSYSPROPERTIES(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			if (Debug_Obf=1 && LOFname="PickIcon_gCons")
				msgbox replaceSYSPROPERTIES DONE `n%LOFtype% %LOFname% preLOFlines %preLOFlines% LOFheaderline %LOFheaderline% `nstrippedLOFbodylines %strippedLOFbodylines% end OBF
				
			;ADDED DIGIDON SYSMETHODS
			replaceSYSMETHODS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			if (Debug_Obf=1 && LOFname="PickIcon_gCons")
				msgbox replaceSYSMETHODS DONE `n%LOFtype% %LOFname% preLOFlines %preLOFlines% LOFheaderline %LOFheaderline% `nstrippedLOFbodylines %strippedLOFbodylines% end OBF
				
			;ADDED DIGIDON SYSVARS
			replaceSYSVARS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			if (Debug_Obf=1 && LOFname="PickIcon_gCons")
				msgbox replaceSYSVARS DONE `n%LOFtype% %LOFname% preLOFlines %preLOFlines% LOFheaderline %LOFheaderline% `nstrippedLOFbodylines %strippedLOFbodylines% end OBF
			
			replaceGLOBALVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			if (Debug_Obf=1 && LOFname="PickIcon_gCons")
				msgbox replaceGLOBALVARs DONE `n%LOFtype% %LOFname% preLOFlines %preLOFlines% LOFheaderline %LOFheaderline% `nstrippedLOFbodylines %strippedLOFbodylines% end OBF
			
		} else 	if (LOFtype = "function")  {
			mysecttype = % "function"
			
			;ADDED DIGIDON FORCESTRAIGHT IF GlobObf_Stop or Glob_FctLocal
			Glob_FctLocal:=IsFctLocal(strippedLOFbodylines)
			if (GlobObf_Stop=1 or Glob_FctLocal=1)
				{
				GlobObf_ForceStraight=1
				}
			else
				GlobObf_ForceStraight=
				
			replaceHIDESTRcalls(strippedLOFbodylines)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceHIDESTRcalls strippedLOFbodylines %strippedLOFbodylines%
				
			replaceLABELCALLS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceLABELCALLS strippedLOFbodylines %strippedLOFbodylines%
				
			;check body of functions for calls to functions, replace with obf
			replaceFUNCCALLS("OBF_FUNC", preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceFUNCCALLS strippedLOFbodylines %strippedLOFbodylines%
				
			replaceSECTIONHEADERname("OBF_FUNC", LOFheaderline, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceSECTIONHEADERname strippedLOFbodylines %strippedLOFbodylines%
			
			;ADDED DIGIDON : if NO OBF COMM THEN STOP HERE
			if (GlobObf_Stop=1)
				{
				GlobObf_ForceStraight=
				break
				}
			
			replaceNESTEDLABELheaders(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceNESTEDLABELheaders strippedLOFbodylines %strippedLOFbodylines%
			
			;ADDED DIGIDON GLOBPARTIALVARS
			replaceGLOBALPARTIALVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceGLOBALPARTIALVARs strippedLOFbodylines %strippedLOFbodylines%
				
			replaceFUNCCALLS("OBF_SYSFUNC", preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceSYSFUNCCALLS strippedLOFbodylines %strippedLOFbodylines%
			
			replacePARAMETERS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replacePARAMETERS strippedLOFbodylines %strippedLOFbodylines%
						
			replaceLOSvars(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceLOSvars strippedLOFbodylines %strippedLOFbodylines%
						
			replaceFUNCandVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceFUNCandVARs strippedLOFbodylines %strippedLOFbodylines%
			
			;ADDED DIGIDON SYSPROPERTIES
			replaceSYSPROPERTIES(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
			; if (LOFname="DragGUI_Create")
				msgbox replaceSYSPROPERTIES strippedLOFbodylines %strippedLOFbodylines%
				
			;ADDED DIGIDON SYSMETHODS
			replaceSYSMETHODS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceSYSMETHODS strippedLOFbodylines %strippedLOFbodylines%
				
			;ADDED DIGIDON SYSVARS
			replaceSYSVARS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceSYSVARS strippedLOFbodylines %strippedLOFbodylines%
				
			replaceGLOBALVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			; if (LOFname="Start_CustomMenuRead")
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceGLOBALVARs strippedLOFbodylines %strippedLOFbodylines%
			
			; TESTING DIGIDON
			; if (LOFname="GUI_RichNoteEditor") 
			; msgbox strippedLOFbodylines %strippedLOFbodylines%
			; if (LOFname="GUI_RichNoteEditor") {
			; FileAppend , %strippedLOFbodylines%, debug.txt
			; msgbox done replaceGLOBALVARs
			; }
			
		;ADDED DIGIDON UNCOMPLETE Classes
		} else 	if (LOFtype = "class")  {
			mysecttype = % "class"
			Glob_FctLocal:=0
			
			;ADDED DIGIDON FORCESTRAIGHT IF GlobObf_Stop or Glob_FctLocal
			;TWEAKED DIGIDON : CLASS ALWAYS GLOBAL
			if (GlobObf_Stop=1 or Glob_FctLocal=1)
				{
				GlobObf_ForceStraight=1
				}
			else
				GlobObf_ForceStraight=
				
			replaceHIDESTRcalls(strippedLOFbodylines)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceHIDESTRcalls strippedLOFbodylines %strippedLOFbodylines%
				
			replaceLABELCALLS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceLABELCALLS strippedLOFbodylines %strippedLOFbodylines%
				
			;check body of functions for calls to functions, replace with obf
			replaceFUNCCALLS("OBF_FUNC", preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceFUNCCALLS strippedLOFbodylines %strippedLOFbodylines%
				
			; DIGIDON UNCOMPLETE Classes : Obf header
			; replaceSECTIONHEADERname("OBF_FUNC", LOFheaderline, LOFtype, LOFname)
			
			;ADDED DIGIDON : if NO OBF COMM THEN STOP HERE
			if (GlobObf_Stop=1)
				{
				GlobObf_ForceStraight=
				break
				}
			
			replaceFUNCCALLS("OBF_SYSFUNC", preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			; DIGIDON UNCOMPLETE Classes : NESTEDLABELheaders
			; replaceNESTEDLABELheaders(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			; if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				; msgbox replaceNESTEDLABELheaders strippedLOFbodylines %strippedLOFbodylines%
			
			;ADDED DIGIDON GLOBPARTIALVARS
			replaceGLOBALPARTIALVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceGLOBALPARTIALVARs strippedLOFbodylines %strippedLOFbodylines%
				
			; DIGIDON UNCOMPLETE Classes : are there parameters?
			; replacePARAMETERS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			; if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				; msgbox replacePARAMETERS strippedLOFbodylines %strippedLOFbodylines%
				
			; DIGIDON UNCOMPLETE Classes : are there los vars?
			; replaceLOSvars(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			; if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				; msgbox replaceLOSvars strippedLOFbodylines %strippedLOFbodylines%
				
			; DIGIDON UNCOMPLETE Classes : should OBF prop / SYSMETHODS : need new func
			; replaceSYSPROPERTIES(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			; if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				; msgbox replaceSYSPROPERTIES strippedLOFbodylines %strippedLOFbodylines%
				
			;ADDED DIGIDON SYSVARS
			replaceSYSVARS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			if (Debug_Obf=1 && LOFname="PickIcon_gCons")
				msgbox replaceSYSVARS DONE `n%LOFtype% %LOFname% preLOFlines %preLOFlines% LOFheaderline %LOFheaderline% `nstrippedLOFbodylines %strippedLOFbodylines% end OBF
			
			replaceGLOBALVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; TESTING DIGIDON
			if (Debug_GlbObf=1 && LOFname="GetWindowInfo")
				msgbox replaceGLOBALVARs strippedLOFbodylines %strippedLOFbodylines%
			
		} else if (LOFtype = "autoexecute") {
			mysecttype = % "label:autoexecute"
			replaceHIDESTRcalls(strippedLOFbodylines)
			
			;check body of autoexecute for calls to functions, replace with obf, ask first
			replaceFUNCCALLS("OBF_FUNC", preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			replaceFUNCCALLS("OBF_SYSFUNC", preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			; msgbox done strippedLOFbodylines %strippedLOFbodylines%
			replaceLABELCALLS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			replaceFUNCandVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			;ADDED DIGIDON GLOBPARTIALVARS
			replaceGLOBALPARTIALVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			;ADDED DIGIDON SYSPROPERTIES
			replaceSYSPROPERTIES(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			;ADDED DIGIDON SYSMETHODS
			replaceSYSMETHODS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
			;ADDED DIGIDON SYSVARS
			replaceSYSVARS(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
				
			replaceGLOBALVARs(preLOFlines, LOFheaderline, strippedLOFbodylines, LOFtype, LOFname)
			
		}
		
	break
	}
	
	;put comments back in body
	LOFbodylines = % mergeBODYcomments(strippedLOFbodylines)

	;spin through body looking for obf commands like dumpvars, unpackvars, 
	;TWEAKED DIGIDON : USE ONLY LOFBODYLINES
	findprocessOBFDUMPcomms(LOFbodylines)
	
	trimbody(LOFbodylines)
	
	;DIGIDON MAYBE : CREATE NEW GLOB VAR TO FORCE NON STRIP OF COMMENTS : e.g. for incl. lib
	if (removeallwhitespace) {
		removeALLCOMMENTSandWHITESPACE(preLOFlines)
		removeALLCOMMENTSandWHITESPACE(LOFbodylines)
		;TWEAKED DIGIDON pass non comment preloflines
		;TWEAKED DIGIDON pass only non-empty vars
		mysectstr = % ListItemsWithLinesIfExist(preLOFlines,LOFheaderline,LOFbodylines)
	} else {
		lookforCommentFlag(preLOFlines)
		lookforCommentFlag(LOFbodylines)
		mysectstr = % preLOFlines . "`r`n"
			. CommFlag . ucase(LOFtype) . " ORIGINAL NAME: " . LOFname . "`r`n"
			. LOFheaderline . "`r`n"
			. LOFbodylines
	}
	;ADDED DIGIDON
	SaveifScrambleOrWriteCode(LOFtype,LOFname,mysectstr)
}

;ADDED DIGIDON
SaveOrAddifScrambleOrWriteCode(SaveOrAdd,LOFtype,LOFname,mysectstr) {
global
	
	if (SaveOrAdd!="Save" and SaveOrAdd!="Add") {
		msgbox error SaveOrAddifScrambleOrWriteCode First param should be Save or Add
	}
	if (scramblefuncs or custdumporder) {
		if !IsLOFtypeknown(LOFtype) {
			msgbox, scramble error LOFtype %LOFtype%
			exitapp
		} else if (LOFtype = "autoexecute") {
			;safer to allways write this to file
			writetoOBFfile(mysectstr)
		} else {
			OBFtype:=IsLOFtypeknown(LOFtype)
			if (foundatrow := FIND_VARROW(OBFtype, LOFname))
				{
				;ADDED DIGIDON BLOCKS
				if (GlobObf_Block)
					{
					%OBFtype%_%foundatrow%_block:=GlobObf_Block
					addtocode("OBF_block" . "_" . GlobObf_Block, mysectstr)
					}
				else
					%SaveOrAdd%code(OBFtype . "_" . foundatrow, mysectstr)
					; if (LOFtype="hotkey")
					; msgbox OBFtype %OBFtype% foundatrow %foundatrow% `nmysectstr %mysectstr%
				;SAVECODE()
				}
			;DigiDon: If Gui special label just add it to the file without warning
			;DEV COULD BE IMPROVED SO THEY ARE CONSIDERED NORMALLY
			; else if (regexmatch(LOFname,"i)^Gui(Close|Escape|Size|ContextMenu|DropFiles)$") or regexmatch(LOFname,"i)\dGui(Close|Escape|Size|ContextMenu|DropFiles)$"))
			else if (regexmatch(LOFname,"i)Gui(Close|Escape|Size|ContextMenu|DropFiles)$"))
				writetoOBFfile(mysectstr)
			else {
				;label not found error condition, fall back to just adding it to the file
				; msgbox did not find row of OBFtype %OBFtype% LOFname %LOFname%
				msgbox did not find OBFtype %OBFtype% LOFtype %LOFtype% LOFname %LOFname%
				writetoOBFfile(";**ERROR** LOOKUP OF " LOFtype " NOT FOUND: " . LOFname)
				writetoOBFfile(mysectstr)
			}
		}
	} else {
		writetoOBFfile(mysectstr)
	}
}

;ADDED DIGIDON
SaveifScrambleOrWriteCode(LOFtype,LOFname,mysectstr) {
global
	SaveOrAddifScrambleOrWriteCode("Save",LOFtype,LOFname,mysectstr)
}

;ADDED DIGIDON
AddifScrambleOrWriteCode(LOFtype,LOFname,mysectstr) {
global
	SaveOrAddifScrambleOrWriteCode("Add",LOFtype,LOFname,mysectstr)
}

;ADDED DIGIDON
IsLOFtypeknown(LOFtype) {
	if (LOFtype = "autoexecute")
		return true
	else if (LOFtype = "label" or LOFtype = "hotkey")
		return "OBF_LABEL"
	else if (LOFtype = "function")
		return "OBF_FUNC"
	else if (LOFtype = "contextcondition")
		return "OBF_CONTEXTCONDITION"
	else if (LOFtype = "class")
		return "OBF_CLASS"
	else
		return false
}

;ADDED DIGIDON
FIND_VARROW_FROMTYPE(LOFtype) {
	if (LOFtype = "autoexecute")
		return true
	else if (LOFtype = "label" or LOFtype = "hotkey")
		return FIND_VARROW("OBF_LABEL", LOFname)
	else if (LOFtype = "function")
		return FIND_VARROW("OBF_FUNC", LOFname)
	else if (LOFtype = "contextcondition")
		return FIND_VARROW("OBF_CONTEXTCONDITION", LOFname)
	else if (LOFtype = "class")
		return FIND_VARROW("OBF_CLASS", LOFname)
	else
		return false
}

;ADDED DIGIDON replaceSYSPROPERTIES
replaceSYSPROPERTIES(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global
	static lookforprop, curOBfrecnum, StartingPos, newline, foundpropat
	;ADDED DIGIDON CONTINUATION SECTION
	local ContinuationSectionStatus
		
	if Glob_FctLocal=1
	return
	
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox BEGIN replaceSYSPROPERTIES
	
	curline = % LOFbodylines
			
	loop, % OBF_SYSPROPERTIES_numrows
	{
		if (!OBF_SYSPROPERTIES_%A_Index%_OBFname or OBF_SYSPROPERTIES_%A_Index%_OBFname = "no/obf")
			continue
			
		lookforprop  = % OBF_SYSPROPERTIES_%A_Index%_name
		curOBfrecnum = % a_index
		StartingPos = 1
		newline =
		;ADDED DIGIDON CONTINUATION SECTION
		ContinuationSectionStatus=
		while true {
			foundpropat = % instr(curline, lookforprop, false, StartingPos)
			if (!foundpropat) {
				newline .= SubStr(curline, StartingPos)
				;ADDED DIGIDON RESTORE GLOBOBF BK
				restoreGlobObfMode()
				break
			}				
				
			;ADDED DIGIDON CONTINUATION SECTION & FINDPROCESSOBFSPECIALCOMMS
			loop 1 {
				;GET NEXT LINE POS
				nextlinepos = % instr(curline, "`n", false, foundpropat)
				if !nextlinepos
					nextlinepos:=StrLen(curline)
				if ContinuationSectionStatusTest:=ContinuationSectionDetect(SubStr(curline, StartingPos, (nextlinepos - StartingPos)))
					ContinuationSectionStatus:=ContinuationSectionStatusTest
				findprocessOBFMODEcomms(SubStr(curline, StartingPos, (foundpropat - StartingPos)))
				}
				
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundpropat - StartingPos))
			
			prevchar = % SubStr(newline, 0)
			nextchar = % SubStr(curline, foundpropat + strlen(lookforprop), 1)
			nextnextchar = % SubStr(curline, foundpropat + strlen(lookforprop)+1, 1)
			
			;ADDED DIGIDON CONTINUATION SECTION : SKIP TRANSLATION
			if (ContinuationSectionStatus="start") {
			newline .= SubStr(curline, foundpropat, strlen(lookforprop))
			; msgbox % "Skipped continuation for " lookforprop "`n" str_getTailLines(newline,10)
			; msgbox % "skipped line " str_getTailf(newline)
			StartingPos = % foundpropat + strlen(lookforprop)
			continue
			}
			
			partialVAR_ERROR = % aretheyvariablecharsPROPCALLS(prevchar,nextchar)
			
			;TESTING DIGIDON
			; if (lookforprop="selectsinglenode")
			; msgbox % "LookForProp " lookforprop "`npartialVAR_ERROR" partialVAR_ERROR "`n" str_getTailLines(newline,10)
			
			;ADDED DIGIDON : Convert [] prop params to ()
			bracketdetected:=0
			
			if (partialVAR_ERROR) {
				;TWEAKED DigiDon
				newline .= SubStr(curline, foundpropat, strlen(lookforprop))	
			
			} else {
				if (prevchar=".") {
					replacewithprop = % "[" oneofmyOBFs("OBF_SYSPROPERTIES" . "_" . curOBfrecnum)  . "]"
					newline := SubStr(newline,1,-1)
					newline .= replacewithprop
					
					;ADDED DIGIDON : Convert [] prop params to ()
					if (nextchar = "[") {
						
						bracketpos = % instr(curline, "]", false, foundpropat + strlen(lookforprop) + 1)
						Parameters := SubStr(curline, foundpropat + strlen(lookforprop) + 1, bracketpos - foundpropat - strlen(lookforprop) - 1)
						
						RegexMatch(Parameters,"P)[$fk@# ]+",RegexMatchLen)
						
						if (RegexMatchLen!=StrLen(Parameters)) {
						bracketdetected:=1
							newline .= "("
							newline .= Parameters
							newline .= ")"
						}
					}
					
				} else if (nextchar=":" and nextnextchar!="=" and prevchar!="`n" and prevchar!="`t") {
					prevprevchar:=SubStr(newline, -1,1)
					if (prevprevchar="," or prevchar="," or prevchar="{" or prevprevchar="{") {
						replacewithprop = % "(" oneofmyOBFs("OBF_SYSPROPERTIES" . "_" . curOBfrecnum)  . ")"
						newline .= replacewithprop
					} 
					else
						newline .= SubStr(curline, foundpropat, strlen(lookforprop))
				}
				 else
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundpropat, strlen(lookforprop))
			}
			
			;ADDED DIGIDON : Convert [] prop params to ()
			if (bracketdetected)
			StartingPos = % bracketpos + 1
			else
			StartingPos = % foundpropat + strlen(lookforprop)							
		}
		curline = % newline					
	}
	LOFbodylines = % curline
	
	;ADDED DIGIDON FINDPROCESSOBFSPECIALCOMMS
	findprocessOBFMODEcomms(curline)
	
	; LOFbodylines = % curline
		
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replaceSYSPROPERTIES LOFbodylines %LOFbodylines%
}

;ADDED DIGIDON SYSMETHODS
replaceSYSMETHODS(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname) {
	global
	static lookformethod, curOBfrecnum, StartingPos, newline, foundmethodat
	;ADDED DIGIDON CONTINUATION SECTION
	local ContinuationSectionStatus
		
	if Glob_FctLocal=1
	return
	
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox BEGIN replaceSYSPROPERTIES
	
	curline = % LOFbodylines
			
	loop, % OBF_SYSMETHODS_numrows
	{
		if (!OBF_SYSMETHODS_%A_Index%_OBFname or OBF_SYSMETHODS_%A_Index%_OBFname = "no/obf")
			continue
			
		lookformethod  = % OBF_SYSMETHODS_%A_Index%_name
		curOBfrecnum = % a_index
		StartingPos = 1
		newline =
		;ADDED DIGIDON CONTINUATION SECTION
		ContinuationSectionStatus=
		while true {
			foundmethodat = % instr(curline, lookformethod, false, StartingPos)
			if (!foundmethodat) {
				newline .= SubStr(curline, StartingPos)
				;ADDED DIGIDON RESTORE GLOBOBF BK
				restoreGlobObfMode()
				break
			}				
				
			;ADDED DIGIDON CONTINUATION SECTION & FINDPROCESSOBFSPECIALCOMMS
			loop 1 {
				;GET NEXT LINE POS
				nextlinepos = % instr(curline, "`n", false, foundmethodat)
				if !nextlinepos
					nextlinepos:=StrLen(curline)
				if ContinuationSectionStatusTest:=ContinuationSectionDetect(SubStr(curline, StartingPos, (nextlinepos - StartingPos)))
					ContinuationSectionStatus:=ContinuationSectionStatusTest
				findprocessOBFMODEcomms(SubStr(curline, StartingPos, (foundmethodat - StartingPos)))
				}
				
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundmethodat - StartingPos))
			
			prevchar = % SubStr(newline, 0)
			nextchar = % SubStr(curline, foundmethodat + strlen(lookformethod), 1)
			
			;ADDED DIGIDON CONTINUATION SECTION : SKIP TRANSLATION
			if (ContinuationSectionStatus="start") {
			newline .= SubStr(curline, foundmethodat, strlen(lookformethod))
			; msgbox % "Skipped continuation for " lookformethod "`n" str_getTailLines(newline,10)
			; msgbox % "skipped line " str_getTailf(newline)
			StartingPos = % foundmethodat + strlen(lookformethod)
			continue
			}
			
			partialVAR_ERROR = % aretheyvariablecharsMETHODCALLS(prevchar,nextchar)
			
			;TESTING DIGIDON
			; if (lookformethod="selectsinglenode")
			; msgbox % "lookformethod " lookformethod "`npartialVAR_ERROR" partialVAR_ERROR "`n" str_getTailLines(newline,10)
			
			if (partialVAR_ERROR) {
				;TWEAKED DigiDon
				newline .= SubStr(curline, foundmethodat, strlen(lookformethod))	
			
			} else {
				replacewithprop = % "[" oneofmyOBFs("OBF_SYSMETHODS" . "_" . curOBfrecnum)  . "]"
				newline:=SubStr(newline,1,-1)
				newline .= replacewithprop
			}
				
			StartingPos = % foundmethodat + strlen(lookformethod)							
		}
		curline = % newline					
	}
	LOFbodylines = % curline
	
	;ADDED DIGIDON FINDPROCESSOBFSPECIALCOMMS
	findprocessOBFMODEcomms(curline)
	
	; LOFbodylines = % curline
		
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replaceSYSPROPERTIES LOFbodylines %LOFbodylines%
}

replaceHIDESTRcalls(ByRef LOFbodylines) {
	global 
	
	curline = % LOFbodylines	
	
	;Tweaked Digidon: simplier to add hidestring functions
	
	StringSplit, lookforfunc_Arr, HideStrFunc_list, `,
	
	loop, % lookforfunc_Arr0
	{
		StartingPos = 1
		newline =
		
		myfuncname := lookforfunc_Arr%a_index%		
		lookforfunc := myfuncname . "("
		
		while true {
			foundfuncat = % instr(curline, lookforfunc, false, StartingPos)
			if (!foundfuncat) {
				newline .= SubStr(curline, StartingPos)
				break
			}				
			
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundfuncat - StartingPos))
			
			prevchar = % SubStr(newline, 0)
			;ADDED BY DIGIDON TO OBFUSCATE NEARLY EVERYWHERE IDESTR
			partialVAR_ERROR = % aretheyvariablechars_hidestr(prevchar)

			if (partialVAR_ERROR) {
				newline .= lookforfunc
				StartingPos = % foundfuncat + strlen(lookforfunc)
				continue
			} 
			foundRparanat = % instr(curline, """)", false, foundfuncat + strlen(lookforfunc) + 2)
			if (!foundRparanat) {
				newline .= lookforfunc
				StartingPos = % foundfuncat + strlen(lookforfunc)
				continue			
			} 
			;get value between '()'
			datavalue = % SubStr(curline, foundfuncat + strlen(lookforfunc), foundRparanat - (foundfuncat + strlen(lookforfunc)) + 1)
			;TWEAKED DIGIDON : DESACTIVATED DELETE SPACES
			
			if (SubStr(datavalue, 1, 1) <> """") {
				newline .= lookforfunc
				StartingPos = % foundfuncat + strlen(lookforfunc)
				continue
			}
			;test last char
			if (SubStr(datavalue, 0) <> """") {
				newline .= lookforfunc
				StartingPos = % foundfuncat + strlen(lookforfunc)
				continue			
			}
			;everything OK
			strtoconvert = % SubStr(datavalue, 2, -1)
			; msgbox % "strtoconvert " strtoconvert " decode_" . myfuncname . "(""" . encode_%myfuncname%(strtoconvert) . """)"
			;replace with call with call to decode function and
			;replace literal string with encoded literal string
			newline .= "decode_" . myfuncname . "(""" . encode_%myfuncname%(strtoconvert) . """)"
			StartingPos = % foundRparanat + 2
		}
		curline = % newline
	}

	LOFbodylines = % curline
}

;ADDED DIGIDON GLOBPARTIALVARS
replaceGLOBALPARTIALVARs(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global
	static myfuncrow
	testobfpartial=
	;ADDED DIGIDON CONTINUATION SECTION
	local ContinuationSectionStatus
	
	myfuncrow = 0	
	if (LOFtype = "function")
		myfuncrow = % FIND_VARROW("OBF_FUNC", LOFname)
	
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1)
		loopnumb=2
	else
		loopnumb=1
	
	; curline = % LOFbodylines
		
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	loop % loopnumb {
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION	
	if (LOFHeaderObf=1 && A_Index=1)
		curline = % LOFheaderline
	else
		curline = % LOFbodylines
			
	loop, % OBF_GLOBPARTIALVAR_numrows
	{
		lookforGLOB  = % OBF_GLOBPARTIALVAR_%A_Index%_name
		
		GLOB_OBFname = % OBF_GLOBPARTIALVAR_%A_Index%_OBFname
		if (!GLOB_OBFname or GLOB_OBFname = "no/obf")
			continue
		
		GLOBrow = % a_index
		StartingPos = 1
		newline =
		;ADDED DIGIDON CONTINUATION SECTION
		ContinuationSectionStatus=
		while true {
			foundGLOBat = % instr(curline, lookforGLOB, false, StartingPos)
			if (!foundGLOBat) {
				newline .= SubStr(curline, StartingPos)
				;ADDED DIGIDON RESTORE GLOBOBF BK
				restoreGlobObfMode()
				break
			}				
				
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundGLOBat - StartingPos))
			prevchar = % SubStr(newline, 0)
			nextchar = % SubStr(curline, foundGLOBat + strlen(lookforGLOB), 1)
			
			;ADDED DIGIDON CONTINUATION SECTION & FINDPROCESSOBFSPECIALCOMMS
			loop 1 {
				;GET NEXT LINE POS
				nextlinepos = % instr(curline, "`n", false, foundGLOBat)
				if !nextlinepos
					nextlinepos:=StrLen(curline)
				if ContinuationSectionStatusTest:=ContinuationSectionDetect(SubStr(curline, StartingPos, (nextlinepos - StartingPos)))
					ContinuationSectionStatus:=ContinuationSectionStatusTest
				findprocessOBFMODEcomms(SubStr(curline, StartingPos, (foundGLOBat - StartingPos)))
				}
				
			;ADDED DIGIDON CONTINUATION SECTION : WE SKIP TRANSLATION
			;DIGIDON MAYBE NOT EXACT, SHOULD THERE BE OTHER CONDITIONS?
			if (ContinuationSectionStatus="start") {
			newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
			; msgbox % "Skipped continuation for " lookforGLOB "`n" str_getTailLines(newline,10)
			; msgbox % "skipped line " str_getTailf(newline)
			StartingPos = % foundGLOBat + strlen(lookforGLOB)
			continue
			}
			
			dotranslation=1
				;DIGIDON DISABLE NULLS IF SURROUNDED BY %'s: WHY WOULD WE HAVE ALREAY %% : SHOULD THEN BE GLOBAL
				if prevchar and IsType(prevchar,"alpha") 
					dotranslation=0
				else if nextchar and IsType(nextchar,"alpha") 
					dotranslation=0
				
				; if (LOFname="RichPrint" or LOFname="RichUndo")
					; msgbox dotranslation %dotranslation% prevchar %prevchar% nextchar %nextchar% lookforGLOB %lookforGLOB% `nnewline %newline%
				;if neither prev nor next char is a % or integer donnot do translation
				else if (prevchar = "%" or IsType(prevchar,"integer") and (nextchar = "%" or IsType(nextchar,"integer")))
					dotranslation=1
				else if (prevchar != "%" and !IsType(prevchar,"integer") and (nextchar != "%" and !IsType(nextchar,"integer")))
					dotranslation=0
				; else if (prevchar = "%" or IsType(prevchar,"integer") and RegExMatch(nextchar, "[@_#$]"))
					; dotranslation=0
				else if (InStrNNull(oddvarnameallowedchars_BIS, prevchar) or InStrNNull(oddvarnameallowedchars_BIS, nextchar))
					dotranslation=0
				; if (LOFname="RichPrint")
					; msgbox dotranslation5 %dotranslation%
				; else if (RegExMatch(prevchar, "\h") and (RegExMatch(nextchar, "\h") or nextchar=","))
					; dotranslation=0
				; else if (RegExMatch(prevchar, "\h") and (nextchar!="%" and !IsType(nextchar,"integer")))
					; dotranslation=0
				;DIGIDON :+ > < - also needed so we will aloow all except instead
				
				; if (LOFname="RichCopy")
				; msgbox % "prevchar " prevchar " nextchar " nextchar " dotranslation " dotranslation
				; else {
					; dotranslation=1
				; }
				; TESTING DIGIDON
				; if (lookforGLOB="_NTBKPath")
				; msgbox dotranslation %dotranslation% prevchar %prevchar% nextchar %nextchar%
				
				; if (LOFname="RichPrint" or LOFname="RichUndo")
					; msgbox dotranslationFin %dotranslation% prevchar %prevchar% nextchar %nextchar% lookforGLOB %lookforGLOB% `nnewline %newline%
				if (dotranslation=1)
					{
					; TESTING DIGIDON
					; testobfpartial=1
					; if (LOFname="MG_Recognize")
					; msgbox do translation prevchar %prevchar% nextchar %nextchar% lookforGLOB %lookforGLOB% newline %newline%
					
					newline .= oneofmyOBFs("OBF_GLOBPARTIALVAR_" . GLOBrow)
					; if (LOFname="MG_Recognize")
					; msgbox % SubStr(curline, foundGLOBat -50, 50 + strlen(lookforGLOB) + 20)
					; msgbox % str_getTailLines(newline,10)
					; testobfpartial=
					}
				else
					{
					;do not do translation
					newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
					}
			StartingPos = % foundGLOBat + strlen(lookforGLOB)
		if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
			msgbox prevchar %prevchar% nextchar %nextchar% lookforGLOB %lookforGLOB% newline %newline%
		}
		curline = % newline			
	}
	
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1 && A_Index=1)
		LOFheaderline = % curline
	else
		LOFbodylines = % curline
	
	;ADDED DIGIDON FINDPROCESSOBFSPECIALCOMMS
	findprocessOBFMODEcomms(curline)
	
		; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replaceGLOBALVARs LOFbodylines %LOFbodylines%
	}
}


replaceSECTIONHEADERname(varlist, ByRef LOFheaderline, ByRef LOFtype, ByRef LOFname)
{
	global
	static foundatrow
	
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox BEGIN replaceSECTIONHEADERname
	
	if (!foundatrow := FIND_VARROW(varlist, LOFname))
		{
		return
		}
		
	
	if (!%varlist%_%foundatrow%_OBFname or %varlist%_%foundatrow%_OBFname = "no/obf")
		{
		return
		}
	
	;only replace with the full obfuscated name for headers like function def header
	;or label section header (label:) - it must have no '%' in what is returned	
	replacestr = % %varlist%_%foundatrow%_OBFname  
	;verifyreplacementwin("FUNCTION HEADER LINE", LOFheaderline, "", (LOFname . "("), (OBF_func_%foundatrow%_OBFname . "("))
	
	if (varlist = "OBF_FUNC")
		replacestr .= "("
	else if (varlist = "OBF_LABEL")
		replacestr .= ":"
	else
		return
	
	LOFheaderline = % replacestr . substr(LOFheaderline, (strlen(LOFname) + 2))
	
	return
}

replaceFUNCCALLS(funclist, ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname) {
	global 
	static lookforfunc, curOBfrecnum, StartingPos, newline, foundfuncat
	; static curbody, curline, trimspaces, newline, newbody, foundatrow, StartingPos
	; static curlabelnum
	;ADDED DIGIDON
	local GLabeldetected,GLabeldetected_case
	;ADDED DIGIDON CONTINUATION SECTION
	local ContinuationSectionStatus
	
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1)
		loopnumb=2
	else
		loopnumb=1
		
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	loop % loopnumb {
		;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION	
		if (LOFHeaderObf=1 && A_Index=1) {
			foundleftparen := InStr(LOFheaderline, "(")
			LOFheaderlineCall = % SubStr(LOFheaderline, foundleftparen + 1)
			curline = % LOFheaderlineCall
			; curline = % LOFheaderline
		} else
			curline = % LOFbodylines

			
		loop, % %funclist%_numrows
		{
			;ADDED BY DIGIDON
			GLOB_OBFname:=%funclist%_%A_Index%_OBFname
			if (!%funclist%_%A_Index%_OBFname or %funclist%_%A_Index%_OBFname = "no/obf")
				continue
				
			lookforfunc  = % %funclist%_%A_Index%_name
			curOBfrecnum = % a_index
			StartingPos = 1
			newline =
			;ADDED DIGIDON CONTINUATION SECTION
			ContinuationSectionStatus=
			while true {
			
				; if (LOFtype = "autoexecute")
					; msgbox lookforfunc %lookforfunc% curline %curline%
				foundfuncat = % instr(curline, lookforfunc, false, StartingPos)
				if (!foundfuncat) {
					newline .= SubStr(curline, StartingPos)
					;ADDED DIGIDON RESTORE GLOBOBF BK
					restoreGlobObfMode()
					break
					}	
				; if (lookforfunc="commonobjfrags")
					; msgbox partialVAR_ERROR %partialVAR_ERROR% prevchar %prevchar% nextchar %nextchar%
				;ADDED DIGIDON CONTINUATION SECTION & FINDPROCESSOBFSPECIALCOMMS
				loop 1 {
					;GET NEXT LINE POS
					nextlinepos = % instr(curline, "`n", false, foundfuncat)
					if !nextlinepos
						nextlinepos:=StrLen(curline)
					if ContinuationSectionStatusTest:=ContinuationSectionDetect(SubStr(curline, StartingPos, (nextlinepos - StartingPos)))
						ContinuationSectionStatus:=ContinuationSectionStatusTest
					findprocessOBFMODEcomms(SubStr(curline, StartingPos, (foundfuncat - StartingPos)))
					}
								
				;add previous part first
				newline .= SubStr(curline, StartingPos, (foundfuncat - StartingPos))
				
				prevchar = % SubStr(newline, 0)
				nextchar = % SubStr(curline, foundfuncat + strlen(lookforfunc), 1)
				
				;ADDED DIGIDON CONTINUATION SECTION
				;DIGIDON MAYBE WE SHOULD ADD FOR OTHER VAR TYPES?
				if (ContinuationSectionStatus="start" and prevchar!="%" and nextchar!="%") {
					newline .= SubStr(curline, foundfuncat, strlen(lookforfunc))
					; msgbox % "Skipped continuation for " lookforGLOB "`n" str_getTailLines(newline,10)
					; msgbox % "skipped line " str_getTailf(newline)
					StartingPos = % foundfuncat + strlen(lookforfunc)
					continue
					}
				
				;ADDED DIGIDON to better detect GFunctions
				if (ucase(prevchar) = "G" && regexmatch(str_getTailf(newline),"i)\s*GUI[\s,]") && !isitvarchar(nextchar)) {
				;ADDED DIGIDON
				GLabeldetected=1
					prevchar = % SubStr(newline, -1, 1)
					partialVAR_ERROR = % aretheyvariablechars_VvarOrGLab(prevchar, nextchar)
					GLabeldetected_case= % partialVAR_ERROR
				} else {
					; partialVAR_ERROR = % aretheyvariablecharsLABELS(prevchar, nextchar)
					partialVAR_ERROR = % aretheyvariablecharsFUNCCALLS(prevchar, nextchar,lookforfunc)
					GLabeldetected=0
				}
				
				; if (lookforfunc="commonobjfrags")
					; msgbox partialVAR_ERROR %partialVAR_ERROR% prevchar %prevchar% nextchar %nextchar%
				
				; ADDED DIGIDON : FCT SHOULD NOT BE AFTER OR BEFORE . or { } or before :
				if (prevchar="." or prevchar="{" or nextchar="." or nextchar="}" or nextchar=":")
					partialVAR_ERROR := true
				
				;FUTURE TWEAK DIGIDON MAYBE : COULD ALERT IF SOME SENSITIVE LIST IS FOUND IN LOCAL FCT
						; if GlobObf_Warn_RecoinLocalFctorStopMode
						; msgbox % "WARNING lookforLABEL " lookforLABEL " was detected in " LOFtype " " LOFname "`nWhich is a local fct and/OR with stop obf activated `nIt will be obfed using straight mode"
						
				;MODIFIED BY DIGIDON
				if (partialVAR_ERROR=1) {
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundfuncat, strlen(lookforfunc))
					
					; msgbox % "Skipped continuation for " lookforfunc "`n" str_getTailLines(newline,10)
					; msgbox % "skipped line " str_getTailf(newline)
				} else {
					if (prevchar="""" and nextchar="""" and GLabeldetected!=1) {
					
						; msgbox % "Replace fct name " lookforfunc " in " LOFname " line `n" str_getTailf(newline)
						replacewithFCT = % GLOB_OBFname
					;ADDED DIGIDON : Simply OBF Name for Nested Label
					; } else if (GLabeldetected!=1 and nextchar=":" and (!IsType(prevchar,"alnum") or !prevchar)) {
						; replacewithFCT = % GLOB_OBFname
					} else if (GLabeldetected=1) {
						;ADDED BY DIGIDON : GLABEL OBF
						if (GLabeldetected_case=3 or GLabeldetected_case=4 or GLabeldetected_case=5) {
							;do the translation
							;TO IMPROVE : should either add dynamic obf of OBF NAME or at least straight obf of OBF NAME
							; replacewithFCT := """ " oneofmyOBFs("OBF_LABEL_" . curlabelnum) " """
							replacewithFCT := GLOB_OBFname
						} else if (GLabeldetected_case=2) {
							;put simple OBF name
							replacewithFCT := GLOB_OBFname
						} else if (GLabeldetected_case=1) {
							;do NOT do translation
							replacewithFCT := SubStr(curline, foundfuncat, strlen(lookforfunc))	
						} else {
							;put simple OBF name
							replacewithFCT := GLOB_OBFname
						}
						
						; msgbox % "Replace GFunction " lookforfunc " in " LOFname " line `n" str_getTailf(newline)
					} else {
					replacewithFCT = % oneofmyOBFs(funclist . "_" . curOBfrecnum)
						; msgbox % "Replace1 " lookforfunc " by " replacewithFCT " in`n" str_getTailLines(newline,10)
					}
						
					if (replacewithFCT) {
						newline .= replacewithFCT
						; msgbox % "Replace " lookforfunc " by " replacewithFCT " in`n" str_getTailLines(newline,10)
						; msgbox % "Replace " lookforfunc " in " LOFname " line `n" str_getTailf(newline)
					} else
						;TWEAKED DigiDon
						newline .= SubStr(curline, foundfuncat, strlen(lookforfunc))
				}
				;ADDED DIGIDON
				StartingPos = % foundfuncat + strlen(lookforfunc)							
			}
			curline = % newline					
		}
		;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
		if (LOFHeaderObf=1 && A_Index=1) {
			LOFheaderline = % SubStr(LOFheaderline,1, foundleftparen) . curline
			; LOFheaderline = % SubStr(LOFheaderline, 1, foundfuncat + strlen(lookforfunc)) . curline
		} else
			LOFbodylines = % curline
		
		;ADDED DIGIDON FINDPROCESSOBFSPECIALCOMMS
		findprocessOBFMODEcomms(curline)
		
		; TESTING DIGIDON	
		if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
			msgbox %LOFname% CM_ChooseNotebook LOFbodylines %LOFbodylines%
	}
}


;ADDED DIGIDON
ContinuationSectionDetect(SearchLines,skippfirst="skip",debug="") {
	; static iscontinuesect
	if (debug)
		msgbox SearchLines %SearchLines%
	loop, parse, SearchLines, `n, `r
	{
	if (skippfirst and A_Index=1)
	continue
	
		curline = % A_Loopfield
		
		if (debug)
		msgbox curline %curline% iscontinuesect %iscontinuesect%
		;'continuation' section has been opened, test for end
			;TWEAKED DIGIDON : allow spaces before match
				if (Regexmatch(curline, "^[\h]*\)")) {
				if (debug)
				msgbox close of continuation section found `ncurline %curline%
				iscontinuesect = stop
				continue
			 }
		
		;test for start of 'continuation' section
		;TWEAKED DIGIDON : allow spaces before match
			if (Regexmatch(curline, "^[\h]*\(") and !Regexmatch(curline, "\)[\s]*(;.*$|$)")) {
				iscontinuesect = start
				if (debug)
				msgbox start of continuation section found `n%curline%
				continue
			}
	}
	return iscontinuesect
}


replaceSYSVARs(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global
	local ContinuationSectionStatus
		
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1)
		loopnumb=2
	else
		loopnumb=1
		
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	loop % loopnumb {
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION	
	if (LOFHeaderObf=1 && A_Index=1)
		curline = % LOFheaderline
	else
		curline = % LOFbodylines
		
	loop, % OBF_SYSVAR_numrows
	{
		lookforSYS  = % OBF_SYSVAR_%A_Index%_name
		
		SYS_OBFname = % OBF_SYSVAR_%A_Index%_OBFname
		if (!SYS_OBFname or SYS_OBFname = "no/obf")
			continue				
		
		SYSrow = % a_index
		StartingPos = 1
		newline =
		newlinecontrol =
		ContinuationSectionStatus=
		while true {
			foundSYSat = % instr(curline, lookforSYS, false, StartingPos)
			if (!foundSYSat) {
				newline .= SubStr(curline, StartingPos)
				newlinecontrol .= SubStr(curline, StartingPos)
				;ADDED DIGIDON RESTORE GLOBOBF BK
				restoreGlobObfMode()
				break
			}
			
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundSYSat - StartingPos))
			
			prevchar = % SubStr(newline, 0)
			nextchar = % SubStr(curline, foundSYSat + strlen(lookforSYS), 1)
			nextnextchar = % SubStr(curline, foundSYSat + strlen(lookforSYS) + 1, 1)
			
			;ADDED DIGIDONTO EXCLUDE PROPS
			if (nextchar=":" and nextnextchar!="=") {
				;DO NOT TRANSLATE
				newline .= SubStr(curline, foundSYSat, strlen(lookforSYS))
				StartingPos = % foundSYSat + strlen(lookforSYS)
				continue
			}
			
			;ADDED DIGIDON CONTINUATION SECTION & findprocessOBFspecialcomms
			loop 1
			{
				;GET NEXT LINE POS
				nextlinepos = % instr(curline, "`n", false, foundSYSat)
				if !nextlinepos
					nextlinepos:=StrLen(curline)
				if ContinuationSectionStatusTest:=ContinuationSectionDetect(SubStr(curline, StartingPos, (nextlinepos - StartingPos)))
					ContinuationSectionStatus:=ContinuationSectionStatusTest
				
				findprocessOBFMODEcomms(SubStr(curline, StartingPos, (foundSYSat - StartingPos)))
			}
			
			;ADDED DIGIDON CONTINUATION SECTION
			;DIGIDON MAYBE WE SHOULD ADD FOR OTHER VAR TYPES?
			if (ContinuationSectionStatus="start" and prevchar!="%" and nextchar!="%") {
			newline .= SubStr(curline, foundSYSat, strlen(lookforSYS))
			; msgbox % "Skipped continuation for " lookforSYS "`n" str_getTailLines(newline,10)
			; msgbox % "skipped line " str_getTailf(newline)
			StartingPos = % foundSYSat + strlen(lookforSYS)
			continue
			}
			
			;msgbox prevchar %prevchar% nextchar %nextchar%
			partialVAR_ERROR = % aretheyvariablechars_BIS(prevchar, nextchar)
			
			if (partialVAR_ERROR) {
				if (nextchar = "[") {
					if (prevchar = "." or isitvarchar(prevchar)) {
					
					;dont do the translation
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundSYSat, strlen(lookforSYS))
					}
					else {
					;do the translation
						newline .= oneofmyOBFs("OBF_SYSVAR_" . SYSrow)
						; if SYSObf_Warn_RecoinLocalFctorStopMode
							; msgbox % "WARNING lookforSYS " lookforSYS " was detected in " LOFtype " " LOFname "`nWhich is a local fct and/OR with stop obf activated `nIt will be obfed using straight mode"
					}
				}
				else {
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundSYSat, strlen(lookforSYS))
				}
			} else {
				;only replace with obf with no '%'s if already surrounded by '%'s
				;TWEAKED DIGIDON : DO NOT OBF PARTIAL OBF obj surrounded by %'s as it is useless : the full obj name will appear anyway
				if (prevchar = "%" and nextchar = "%")
					{
					; newline .= PUT_NULLS_AROUND(SYS_OBFname, "nofirstlastperc")
					; msgbox % "SYS_OBFname " SYS_OBFname "`n" newline
					newline .= SubStr(curline, foundSYSat, strlen(lookforSYS))
					}
					
				;DIGIDON : do not replace global variables surrounded by "/" : WHY? Disabled because was causing issues
				; else if (prevchar = "/" or nextchar = "/") {
					;TWEAKED DigiDon
					; newline .= SubStr(curline, foundSYSat, strlen(lookforSYS))
					; msgbox % str_getTailf(newline)
					; }
				
				;MAYBE CORRECT
				;do not replace variables surrounded by quotes (should it really? Normally no reason to be in quotes so I guess yes)
				else if (prevchar = """" and nextchar = """") {
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundSYSat, strlen(lookforSYS))
					; msgbox % "skipped sys var " lookforGLOB " in quotes " str_getTailf(newline)
					}
					
				;replace with triply ofuscated values
				else 
					{
					newline .= oneofmyOBFs("OBF_SYSVAR_" . SYSrow)
					}
			}
			
			StartingPos = % foundSYSat + strlen(lookforSYS)
		}
		curline = % newline		
	}
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1 && A_Index=1)
		LOFheaderline = % curline
	else
		LOFbodylines = % curline
	
	;ADDED DIGIDON FINDPROCESSOBFSPECIALCOMMS
	findprocessOBFMODEcomms(curline)
	
	; LOFbodylines = % curline
		; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replaceSYSVARs LOFbodylines %LOFbodylines%
	}
}

replaceGLOBALVARs(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global
	static myfuncrow
	local Vvar_case
	local ContinuationSectionStatus
	
	myfuncrow = 0	
	if (LOFtype = "function")
		myfuncrow = % FIND_VARROW("OBF_FUNC", LOFname)
		
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1)
		loopnumb=2
	else
		loopnumb=1
		
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	loop % loopnumb {
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION	
	if (LOFHeaderObf=1 && A_Index=1)
		curline = % LOFheaderline
	else
		curline = % LOFbodylines
		
	;LOOK FOR GLOBAL VARS THAT ARE PRECEEDED BY 'V' FOR USAGE IN CONTROL VARIABLE NAMES		
		
	loop, % OBF_GLOBVAR_numrows
	{
		lookforGLOB  = % OBF_GLOBVAR_%A_Index%_name
		
		GLOB_OBFname = % OBF_GLOBVAR_%A_Index%_OBFname
		if (!GLOB_OBFname or GLOB_OBFname = "no/obf")
			continue	
		
		;check whether a variable by this name exists as a local or static
		;variable or a parameter in this function (if a function called this). 
		;skip this global var translation if it is
		if (myfuncrow) {
			if (OBF_GLOBVAR_%A_Index%_curtransfunc <> LOFname) {
				;set flags for speed
				OBF_GLOBVAR_%A_Index%_curtransfunc = % LOFname
				OBF_GLOBVAR_%A_Index%_replaceme = % true
				
				;test for local or static variable
				if FIND_VARROW("OBF_FUNC_" . myfuncrow . "_LOSVAR", lookforGLOB) 
					OBF_GLOBVAR_%A_Index%_replaceme = % false
				else if FIND_VARROW("OBF_FUNC_" . myfuncrow . "_PARAM", lookforGLOB)
					OBF_GLOBVAR_%A_Index%_replaceme = % false
			}				
		} else 
			OBF_GLOBVAR_%A_Index%_replaceme = % true
			
		if (!OBF_GLOBVAR_%A_Index%_replaceme)
			continue				
		
		GLOBrow = % a_index
		StartingPos = 1
		newline =
		newlinecontrol =
		ContinuationSectionStatus=
		while true {
			foundGLOBat = % instr(curline, lookforGLOB, false, StartingPos)
			if (!foundGLOBat) {
				newline .= SubStr(curline, StartingPos)
				newlinecontrol .= SubStr(curline, StartingPos)
				;ADDED DIGIDON RESTORE GLOBOBF BK
				restoreGlobObfMode()
				break
			}
			
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundGLOBat - StartingPos))
			
			;set prev/next chars
			prevchar = % SubStr(newline, 0)
			nextchar = % SubStr(curline, foundGLOBat + strlen(lookforGLOB), 1)
			nextnextchar = % SubStr(curline, foundGLOBat + strlen(lookforGLOB) + 1, 1)
			
			;ADDED DIGIDONTO EXCLUDE PROPS (forgot what this is exactly...)
			if (nextchar=":" and nextnextchar!="=") {
				;DO NOT TRANSLATE
				
				newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
				StartingPos = % foundGLOBat + strlen(lookforGLOB)
				; msgbox % "skipped line PROPS " str_getTailf(newline)
				continue
				
			}
			
			;ADDED DIGIDON CONTINUATION SECTION & findprocessOBFspecialcomms
			loop 1
			{
				;GET NEXT LINE POS
				nextlinepos = % instr(curline, "`n", false, foundGLOBat)
				if !nextlinepos
					nextlinepos:=StrLen(curline)
				if ContinuationSectionStatusTest:=ContinuationSectionDetect(SubStr(curline, StartingPos, (nextlinepos - StartingPos)))
					ContinuationSectionStatus:=ContinuationSectionStatusTest
				
				findprocessOBFMODEcomms(SubStr(curline, StartingPos, (foundGLOBat - StartingPos)))
			}
			
			;ADDED DIGIDON CONTINUATION SECTION
			;DIGIDON MAYBE WE SHOULD ADD FOR OTHER VAR TYPES?
			if (ContinuationSectionStatus="start" and prevchar!="%" and nextchar!="%") {
			newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
			; msgbox % "Skipped continuation for " lookforGLOB "`n" str_getTailLines(newline,10)
			; msgbox % "skipped line " str_getTailf(newline)
			StartingPos = % foundGLOBat + strlen(lookforGLOB)
			continue
			}
			;msgbox prevchar %prevchar% nextchar %nextchar%
			partialVAR_ERROR = % aretheyvariablechars_BIS(prevchar, nextchar)
			; if (prevchar="_" and lookforGLOB="Node" and LOFname="Start_CustomMenuRead")
			; msgbox % "prevchar " prevchar " partialVAR_ERROR " partialVAR_ERROR "`n" str_getTailf(newline)
			
			if (partialVAR_ERROR) {
				;check for previous char = 'v' which is the format used
				;in controls to define a variable to associate with the control
				;TWEAKED DIGIDON to better detect vVariables (controls)
				if (ucase(prevchar) = "V" && regexmatch(str_getTailf(newline),"i)\s*GUI[\s,]") && !isitvarchar(nextchar)) {
					;ADDED DIGIDON
					vVardetected=1
					;backup one more character and check whether that is valid 
					;as a variable name or not
					prevprevchar = % SubStr(newline, -1, 1)
					;TWEAKED DIGIDON
					partialVAR_ERROR = % aretheyvariablechars_VvarOrGLab(prevprevchar, nextchar)
					Vvar_case= % partialVAR_ERROR
					;ADDED DIGIDON to better handle vVariables (controls)
					;ADDED BY DIGIDON : TRY TO GENERATE AN OBF STRING WITH NO % at beginning or end
					if (Vvar_case=3 or Vvar_case=4 or Vvar_case=5)
						{
						;do the translation
						;TO IMPROVE : should either add dynamic obf of OBF NAME or at least straight obf of OBF NAME
						; newline .= """ " oneofmyOBFs("OBF_GLOBVAR_" . GLOBrow) " """
						newline .= GLOB_OBFname
						}
					else if (Vvar_case=2)
						{
						;put simple OBF name
						newline .= GLOB_OBFname
						}
					else if (Vvar_case=1)
						{
						;do NOT do translation
						newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
						}
					else {
						;put simple OBF name
						newline .= GLOB_OBFname
					}
				} else if (SubStr(newline, -3, 4)="hwnd" && !isitvarchar(SubStr(newline, -4, 1)) && regexmatch(str_getTailf(newline),"i)\s*GUI[\s,]") && !isitvarchar(nextchar)) {
						;put simple OBF name
						newline .= GLOB_OBFname
				} else if (nextchar = "[") {
					if (prevchar = "." or isitvarchar(prevchar)) {
					
					;dont do the translation
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
					}
					else {
					;do the translation
						newline .= oneofmyOBFs("OBF_GLOBVAR_" . GLOBrow)
						; if GlobObf_Warn_RecoinLocalFctorStopMode
							; msgbox % "WARNING lookforGLOB " lookforGLOB " was detected in " LOFtype " " LOFname "`nWhich is a local fct and/OR with stop obf activated `nIt will be obfed using straight mode"
					}
				}
				else {
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
				}
			} else {
				;only replace with obf with no '%'s if already surrounded by '%'s
				if (prevchar = "%" and nextchar = "%")
					{
					newline .= PUT_NULLS_AROUND(GLOB_OBFname, "nofirstlastperc")
					}
					
				;DIGIDON : do not replace global variables surrounded by "/" : WHY? Disabled because was causing issues
				; else if (prevchar = "/" or nextchar = "/") {
					;TWEAKED DigiDon
					; newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
					; msgbox % str_getTailf(newline)
				; }
					
				;do not replace global variables surrounded by quotes!
				;EDIT : YES REPLACE BY REAL OBF NAME
				else if (prevchar = """" and nextchar = """") {
					;TWEAKED DigiDon
					; newline .= SubStr(curline, foundGLOBat, strlen(lookforGLOB))
					; msgbox % "skipped golb var " lookforGLOB " in quotes " str_getTailf(newline)
					newline.=GLOB_OBFname
					}
				
				;only replace with obf with no '%'s if it's a 'guilabel'
				else if (obf_globvar_%GLOBrow%_isguilabel)
					newline .= INSERT_RAND_COMMON_NULL() . GLOB_OBFname . INSERT_RAND_COMMON_NULL()
				
				;ADDED BY DIGIDON : PUT REAL OBF NAME WHEN DECLARING VARS...
				else if ((prevchar = " " or prevchar = ",") and (Instr(str_getTailf(newline),"global ") or Instr(str_getTailf(newline),"local ") or Instr(str_getTailf(newline),"static ")))
					newline.=GLOB_OBFname
					
				;replace with triply ofuscated values
				else 
					{
					newline .= oneofmyOBFs("OBF_GLOBVAR_" . GLOBrow)
					}
			}
			
			StartingPos = % foundGLOBat + strlen(lookforGLOB)
		}
		curline = % newline		
	}
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1 && A_Index=1)
		LOFheaderline = % curline
	else
		LOFbodylines = % curline
	
	;ADDED DIGIDON FINDPROCESSOBFSPECIALCOMMS
	findprocessOBFMODEcomms(curline)
	
	; LOFbodylines = % curline
		; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replaceGLOBALVARs LOFbodylines %LOFbodylines%
	}
}

replaceLOSvars(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global
	;ADDED DIGIDON CONTINUATION SECTION
	local ContinuationSectionStatus
		
	if (!funcatrow := FIND_VARROW("OBF_FUNC", LOFname)) 
		return
	
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox BEGIN replaceLOSvars
		
	curbody = % LOFbodylines
	
	newbody = 
	loop, parse, curbody, `n, `r
	{
		curline = % A_Loopfield
		;MODIFIED DIGIDON : USE LOFbodylines which comes from StripppedLOFbodylines so no need for commment test
		
		;ADDED DIGIDON CONTINUATION SECTION & FINDPROCESSOBFSPECIALCOMMS
			if ContinuationSectionStatusTest:=ContinuationSectionDetect(curline)
			findprocessOBFspecialcomms(curline)
		
		loop, % OBF_FUNC_%funcatrow%_LOSvar_numrows
		{
			LOS_OBFname = % OBF_FUNC_%funcatrow%_LOSvar_%A_Index%_OBFname
			if (!LOS_OBFname or LOS_OBFname = "no/obf")
				continue
			
			LOSrow = % a_index
						
			lookforLOS  = % OBF_FUNC_%funcatrow%_LOSvar_%LOSrow%_name
			
			StartingPos = 1
			newline =
			;ADDED DIGIDON CONTINUATION SECTION
			ContinuationSectionStatus=
			while true {
				foundLOSat = % instr(curline, lookforLOS, false, StartingPos)
				if (!foundLOSat) {
					newline .= SubStr(curline, StartingPos)
					;ADDED DIGIDON RESTORE GLOBOBF BK
					restoreGlobObfMode()
					break
				}
				
				;add previous part first
				newline .= SubStr(curline, StartingPos, (foundLOSat - StartingPos))
				
				prevchar = % SubStr(newline, 0)
				nextchar = % SubStr(curline, foundLOSat + strlen(lookforLOS), 1)
				nextnextchar = % SubStr(curline, foundLOSat + strlen(lookforLOS) + 1, 1)
			
				;ADDED DIGIDONTO EXCLUDE PROPS
				if (nextchar=":" and nextnextchar!="=") {
					;DO NOT TRANSLATE
					newline .= SubStr(curline, foundLOSat, strlen(lookforLOS))
					StartingPos = % foundLOSat + strlen(lookforLOS)
					continue
				}
				
				;ADDED DIGIDON CONTINUATION SECTION : ALLOW ONLY SURROUNDED BY %'s
				if (ContinuationSectionStatus="start" and prevchar!="%" and nextchar!="%") {
				newline .= SubStr(curline, foundLOSat, strlen(lookforLOS))
				; msgbox % "Skipped continuation for " lookforLOS "`n" str_getTailLines(newline,10)
				; msgbox % "skipped line " str_getTailf(newline)
				StartingPos = % foundLOSat + strlen(lookforLOS)
				continue
				}
			
				; TESTING DIGIDON
				if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
					msgbox prevchar %prevchar% lookforLOS %lookforLOS% newline %newline% 
				nextchar = % SubStr(curline, foundLOSat + strlen(lookforLOS), 1)
				partialVAR_ERROR = % aretheyvariablechars_BIS(prevchar, nextchar)
				
				if (partialVAR_ERROR) {
					if (ucase(prevchar) = "V" && regexmatch(str_getTailf(newline),"i)\s*GUI[\s,]") && !isitvarchar(nextchar)) {
						;ADDED DIGIDON
						vVardetected=1
						;backup one more character and check whether that is valid 
						;as a variable name or not
						prevprevchar = % SubStr(newline, -1, 1)
						;TWEAKED DIGIDON
						partialVAR_ERROR = % aretheyvariablechars_VvarOrGLab(prevprevchar, nextchar)
						Vvar_case= % partialVAR_ERROR
						;ADDED DIGIDON to better handle vVariables (controls)
						;ADDED BY DIGIDON : TRY TO GENERATE AN OBF STRING WITH NO % at beginning or end
						if (Vvar_case=3 or Vvar_case=4 or Vvar_case=5)
							{
							;do the translation
							;TO IMPROVE : should either add dynamic obf of OBF NAME or at least straight obf of OBF NAME
							; newline .= """ " oneofmyOBFs("OBF_GLOBVAR_" . GLOBrow) " """
							newline .= LOS_OBFname
							}
						else if (Vvar_case=2)
							{
							;put simple OBF name
							newline .= LOS_OBFname
							}
						else if (Vvar_case=1)
							{
							;do NOT do translation
							newline .= SubStr(curline, foundLOSat, strlen(lookforLOS))
							}
						else {
							;put simple OBF name
							newline .= LOS_OBFname
						}
					} else if (SubStr(newline, -3, 4)="hwnd" && !isitvarchar(SubStr(newline, -4, 1)) && regexmatch(str_getTailf(newline),"i)\s*GUI[\s,]") && !isitvarchar(nextchar)) {
						;put simple OBF name
						newline .= LOS_OBFname
					}
					else {
					;DO NOT TRANSLATE
					newline .= SubStr(curline, foundLOSat, strlen(lookforLOS))	
					}
				} else {
					;DIGIDON TWEAKED : DELETE _replacementsdone PART BECAUSE VARIABLES ARE NOW NOT OBF IF LOCAL/GLOBAL/STATIC
					;if it is the first replacement, replace with only the straight
					;obf with no '%'s
					; replacementsdone = % OBF_FUNC_%funcatrow%_LOSvar_%LOSrow%_replacementsdone
					;TWEAKED BY DIGIDON : Replace with OBF Name no % if declaring
					if ((prevchar = " " or prevchar = ",") and (Instr(str_getTailf(newline),"global ") or Instr(str_getTailf(newline),"local ") or Instr(str_getTailf(newline),"static "))) {
						;DIGIDON TWEAKED : DELETE _replacementsdone PART BECAUSE VARIABLES ARE NOW NOT OBF IF LOCAL/GLOBAL/STATIC
						;create first replacement done flag
						; OBF_FUNC_%funcatrow%_LOSvar_%LOSrow%_replacementsdone = 1
						newline .= LOS_OBFname					
					} else {
						;only replace with obf with no '%'s if already surrounded by '%'s
						if (prevchar = "%" and nextchar = "%")
							newline .= PUT_NULLS_AROUND(LOS_OBFname, "nofirstlastperc")
						else {
							replacewithLOS = % oneofmyOBFs("OBF_FUNC_" . funcatrow . "_LOSvar_" . LOSrow)
							newline .= replacewithLOS
						}										
					}								
				}
					
				StartingPos = % foundLOSat + strlen(lookforLOS)							
			}
			curline = % newline					
		}
		newbody .= curline . "`r`n"
	}
	LOFbodylines = % newbody

}

replaceNESTEDLABELheaders(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global
	static curbody, curline, trimspaces, newline, newbody, foundatrow
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox BEGIN replaceNESTEDLABELheaders
		
	curbody = % LOFbodylines
	newbody = 
	
	loop, parse, curbody, `n, `r
	{
		curline = % A_Loopfield
		;MODIFIED DIGIDON : USE LOFbodylines which comes from StripppedLOFbodylines so no need for commment test
		
		nestedLOFtype =
		nestedLOFname = 		
		if (isLOFheader(curline, nestedLOFtype, nestedLOFname, 1)) {
		
			foundatrow = % FIND_VARROW("OBF_LABEL", nestedLOFname)
			foundNESTEDLABELat = % instr(curline, nestedLOFname)
			
			;TWEAKED DIGIDON : SKIP IF nestedLOFtype!="label"
			if (!foundatrow or !OBF_LABEL_%foundatrow%_OBFname or OBF_LABEL_%foundatrow%_OBFname = "no/obf" or nestedLOFtype!="label"){
				newbody .= curline . "`r`n"
				continue
			}
			
			; TESTING DIGIDON
			if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
				msgbox prevchar %prevchar% nestedLOFtype %nestedLOFtype% nestedLOFname %nestedLOFname% newline %newline%
			
			;only replace with the full obfuscated name for headers like function def header
			;or label section header (label:) - it must have no '%' in what is returned	
			replacestr = % OBF_LABEL_%foundatrow%_OBFname  
			newline = % replacestr . ":" . substr(curline, foundNESTEDLABELat + strlen(nestedLOFname) + 2)
			
			; TESTING DIGIDON
			if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
				msgbox REPLACE NESTED prevchar %prevchar% nestedLOFtype %nestedLOFtype% nestedLOFname %nestedLOFname% newline %newline%			
			
			newbody .= newline . "`r`n"
		} else
			newbody .= curline . "`r`n"		
	}
	
	LOFbodylines = % newbody
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replaceNESTEDLABELheaders LOFbodylines %LOFbodylines%
}

;ADDED BY DIGIDON
replaceLABELHeader(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global
	curline = % LOFheaderline	
	; TESTING DIGIDON
				
	loop, % OBF_LABEL_numrows
	{
		if (!OBF_LABEL_%A_Index%_OBFname or OBF_LABEL_%A_Index%_OBFname = "no/obf")
			continue
			
		
		curlabelnum = % a_index
			
		lookforLABEL  = % OBF_LABEL_%A_Index%_name
		StartingPos = 1
		newline =
			
		while true {
			foundLABELat = % instr(curline, lookforLABEL, false, StartingPos)
			if (!foundLABELat) {
				newline .= SubStr(curline, StartingPos)
				break
			}				
							
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundLABELat - StartingPos))
			
			;get char before and after match				
			prevchar = % SubStr(newline, 0)
			nextchar = % SubStr(curline, foundLABELat + strlen(lookforLABEL), 1)
				
			; TESTING DIGIDON
			if (Debug_HotkeyLabel=1 && LOFname="^Numpad1")
				msgbox prevchar %prevchar% lookforLABEL %lookforLABEL% newline %newline% 
			if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
				msgbox prevchar %prevchar% lookforLABEL %lookforLABEL% newline %newline% 
			
			;DISABLE BY DIGIDON : WHY WOULD IT BE IN HEADER????
			;test for gosub label format used in controls: G%gotolabel%
				
			; ADDED DIGIDON : LABEL SHOULD NOT BE AFTER OR BEFORE . or { }
			if (prevchar="." or prevchar="{" or nextchar="." or nextchar="}")
				partialVAR_ERROR := true
			
			if (partialVAR_ERROR) {
				;TWEAKED DigiDon
					newline .= SubStr(curline, foundLABELat, strlen(lookforLABEL))
			} else {
				replacewithLABEL = % oneofmyOBFs("OBF_LABEL_" . curlabelnum)				
				if (replacewithLABEL) 
					newline .= replacewithLABEL
				 else
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundLABELat, strlen(lookforLABEL))
			}					
			StartingPos = % foundLABELat + strlen(lookforLABEL)							
		}
		curline = % newline					
	}
	LOFheaderline = % curline
			; TESTING DIGIDON
		if (Debug_HotkeyLabel=1 && LOFname="^Numpad1")
			msgbox % "LOFheaderline " LOFheaderline

}

replaceLABELCALLS(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global 
	static curbody, curline, trimspaces, newline, newbody, foundatrow, StartingPos
	static curlabelnum
	;ADDED DIGIDON
	local GLabeldetected=0
	;ADDED DIGIDON CONTINUATION SECTION
	local ContinuationSectionStatus
	
	curline = % LOFbodylines
				
	loop, % OBF_LABEL_numrows
	{
		;ADDED BY DIGIDON
		GLOB_OBFname = % OBF_LABEL_%A_Index%_OBFname
		if (!GLOB_OBFname or GLOB_OBFname = "no/obf")
			continue
			
		
		curlabelnum = % a_index
			
		lookforLABEL  = % OBF_LABEL_%A_Index%_name
		StartingPos = 1
		newline =
		;ADDED DIGIDON CONTINUATION SECTION
		ContinuationSectionStatus=
		while true {
			foundLABELat = % instr(curline, lookforLABEL, false, StartingPos)
			if (!foundLABELat) {
				newline .= SubStr(curline, StartingPos)
				;ADDED DIGIDON RESTORE GLOBOBF BK
				restoreGlobObfMode()
				break
			}
			
			;ADDED DIGIDON CONTINUATION SECTION & FINDPROCESSOBFSPECIALCOMMS
			loop 1 {
				;GET NEXT LINE POS
				nextlinepos = % instr(curline, "`n", false, foundLABELat)
				if !nextlinepos
					nextlinepos:=StrLen(curline)
				if ContinuationSectionStatusTest:=ContinuationSectionDetect(SubStr(curline, StartingPos, (nextlinepos - StartingPos)))
					ContinuationSectionStatus:=ContinuationSectionStatusTest
				findprocessOBFMODEcomms(SubStr(curline, StartingPos, (foundLABELat - StartingPos)))
				}
							
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundLABELat - StartingPos))
			
			;get char before and after match				
			prevchar = % SubStr(newline, 0)
			nextchar = % SubStr(curline, foundLABELat + strlen(lookforLABEL), 1)
			
			;ADDED DIGIDON CONTINUATION SECTION : SKIP TRANSLATION
			if (ContinuationSectionStatus="start") {
			newline .= SubStr(curline, foundLABELat, strlen(lookforLABEL))
			; msgbox % "Skipped continuation for " lookforLABEL "`n" str_getTailLines(newline,10)
			; msgbox % "skipped line " str_getTailf(newline)
			StartingPos = % foundLABELat + strlen(lookforLABEL)
			continue
			}
			
			; TESTING DIGIDON
			if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
				msgbox prevchar %prevchar% lookforLABEL %lookforLABEL% newline %newline% 
			
			;ADDED DIGIDON to better detect GLabels
			if (ucase(prevchar) = "G" && regexmatch(str_getTailf(newline),"i)\s*GUI[\s,]") && !isitvarchar(nextchar)) {
			;ADDED DIGIDON
			GLabeldetected=1
				prevchar = % SubStr(newline, -1, 1)
				partialVAR_ERROR = % aretheyvariablechars_VvarOrGLab(prevchar, nextchar)
				GLabeldetected_case= % partialVAR_ERROR
			} else
				{
				partialVAR_ERROR = % aretheyvariablecharsLABELS(prevchar, nextchar)
				GLabeldetected=0
				}
			
			; ADDED DIGIDON : LABEL SHOULD NOT BE AFTER OR BEFORE . or { } or before (
			if (prevchar="." or prevchar="{" or nextchar="." or nextchar="}" or nextchar="(")
				partialVAR_ERROR := true
			
			;FUTURE TWEAK DIGIDON MAYBE : COULD ALERT IF SOME SENSITIVE LIST IS FOUND IN LOCAL FCT
					; if GlobObf_Warn_RecoinLocalFctorStopMode
					; msgbox % "WARNING lookforLABEL " lookforLABEL " was detected in " LOFtype " " LOFname "`nWhich is a local fct and/OR with stop obf activated `nIt will be obfed using straight mode"
					
			;MODIFIED BY DIGIDON
			if (partialVAR_ERROR=1) {
				;TWEAKED DigiDon
				newline .= SubStr(curline, foundLABELat, strlen(lookforLABEL))
			} else {
				if (prevchar="""" and nextchar="""" and GLabeldetected!=1) {
					replacewithLABEL = % GLOB_OBFname
				;ADDED DIGIDON : Simply OBF Name for Nested Label
				} else if (GLabeldetected!=1 and nextchar=":" and !isitvarchar(prevchar)) {
					replacewithLABEL = % GLOB_OBFname
				} else if (GLabeldetected=1) {
					;ADDED BY DIGIDON : GLABEL OBF
					if (GLabeldetected_case=3 or GLabeldetected_case=4 or GLabeldetected_case=5)
							{
							;do the translation
							;TO IMPROVE : should either add dynamic obf of OBF NAME or at least straight obf of OBF NAME
							; replacewithLABEL := """ " oneofmyOBFs("OBF_LABEL_" . curlabelnum) " """
							replacewithLABEL := GLOB_OBFname
							}
						else if (GLabeldetected_case=2)
							{
							;put simple OBF name
							replacewithLABEL := GLOB_OBFname
							}
						else if (GLabeldetected_case=1)
							{
							;do NOT do translation
							replacewithLABEL := SubStr(curline, foundLABELat, strlen(lookforLABEL))	
							}
						else {
							;put simple OBF name
							replacewithLABEL .= GLOB_OBFname
						}
				} else {
				replacewithLABEL = % oneofmyOBFs("OBF_LABEL_" . curlabelnum)
				}
					
				if (replacewithLABEL) 
					newline .= replacewithLABEL
				 else
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundLABELat, strlen(lookforLABEL))
			}
			;ADDED DIGIDON
			StartingPos = % foundLABELat + strlen(lookforLABEL)							
		}
		curline = % newline					
	}
	LOFbodylines = % curline
	
	;ADDED DIGIDON FINDPROCESSOBFSPECIALCOMMS
	findprocessOBFMODEcomms(curline)
	
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replaceLABELCALLS LOFbodylines %LOFbodylines%
}

;DIGIDON COMMENT I DON'T REALLY KNOW WHAT THIS FUNCandVAR type IS USED FOR. I BELIEVE THIS WAS A CUSTOM TWEAK BY ORIGINAL AUTHOR
;TO OBFUSCATE HIS OWN SOFTWARE. NEEDS FURTHER INVESTIGATION
replaceFUNCandVARs(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global
	
	static curbody, curline, trimspaces, newline, newbody, StartingPos
	static FAVrow, lookforFAV, foundFAVat
	
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox BEGIN replaceFUNCandVARs
		
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1)
		loopnumb=2
	else
		loopnumb=1
	
	; curline = % LOFbodylines
	
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	loop % loopnumb {
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION	
	if (LOFHeaderObf=1 && A_Index=1)
		curline = % LOFheaderline
	else
		curline = % LOFbodylines
		
	loop, % OBF_FUNCandVAR_numrows
	{				
		if (!usefuncatrow := OBF_FUNCandVAR_%A_Index%_funcrow)
			continue
		
		;use only full obf name, no %s
		useOBF = % OBF_FUNC_%usefuncatrow%_OBFname
		
		;no actual translation found in func list
		if (!useOBF or useOBF = "no/obf")
			continue
			
		lookforFAV  = % OBF_FUNCandVAR_%A_Index%_name
		FAVrow = % a_index
		StartingPos = 1
		newline =
		while true {
			foundFAVat = % instr(curline, lookforFAV, false, StartingPos)
			if (!foundFAVat) {
				newline .= SubStr(curline, StartingPos)
				break
			}				
							
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundFAVat - StartingPos))
			
			prevchar = % SubStr(newline, 0)
			
			; TESTING DIGIDON
			if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
				msgbox prevchar %prevchar% lookforFAV %lookforFAV%newline %newline% 
				
			nextchar = % SubStr(curline, foundFAVat + strlen(lookforFAV), 1)				
			partialVAR_ERROR = % aretheyvariablecharsFUNCVARS(prevchar, nextchar)
			
			if (prevchar = "_" and nextchar = "_") {
				;syntax that is used to encode page name into control variable names
				newline .= INSERT_RAND_COMMON_NULL() . useOBF
			} else if (prevchar = """" and nextchar = """") {
				;syntax that is somtimes used to load a specific page
				; ie. showhelpwin("overview")
				newline .= useOBF
			} else {
				;if inside the actual functions that define the funcandvars
				;allow extra translations
				if (LOFtype = "function" and (LOFname = "getconfigwindata" or LOFname = "gethelpwindata")) {
					if (prevchar = "^" and nextchar = """") {
						;syntax that is used to refer to the corresponding
						;help or config page for the current config or help page
						newline .= useOBF
					} else if (prevchar = "^" and nextchar = "/") {
						;syntax that is used to specify the bread crumb trail
						newline .= useOBF
					} else if (prevchar = "/" and nextchar = "^") {
						;syntax that is used to specify the bread crumb trail
						newline .= useOBF	
					} else if (prevchar = "/" and nextchar = """") {
						;syntax that is used to specify the bread crumb trail
						newline .= useOBF	
					} else if (prevchar = "/" and nextchar = "/") {
						;syntax that is used to specify the bread crumb trail
						newline .= useOBF
					} else if (prevchar = "^" and nextchar = "^") {
						;syntax that is used to specify the bread crumb trail
						newline .= useOBF
					} else if (prevchar = "^" and nextchar = """") {
						;syntax that is used to specify the bread crumb trail
						newline .= useOBF
					} else if (!partialVAR_ERROR) {
						;variable definitions or assignments inside property functions
						newline .= useOBF
					} else {
						;msgbox, partialFAVerror LOS: %lookforFAV%`r`nline: %curline%
						;TWEAKED DigiDon
						newline .= SubStr(curline, foundFAVat, strlen(lookforFAV))
					}
				} else {
					;msgbox, partialFAVerror LOS: %lookforFAV%`r`nline: %curline%
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundFAVat, strlen(lookforFAV))						
				}						
			}									
			StartingPos = % foundFAVat + strlen(lookforFAV)							
		}
		curline = % newline					
	}
		
	;ADDED DIGIDON OBF HEADER SINGLE LINE HOTKEYS and #IF CONDITION
	if (LOFHeaderObf=1 && A_Index=1)
		LOFheaderline = % curline
	else
		LOFbodylines = % curline
	
	; LOFbodylines = % curline
	
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replaceFUNCandVARs LOFbodylines %LOFbodylines%
	}
}

replacePARAMETERS(ByRef preLOFlines, ByRef LOFheaderline, ByRef LOFbodylines, LOFtype, LOFname)
{
	global 
	static curbody, curline, trimspaces, newline, newbody, foundFatrow, StartingPos
	Debug_ObfVParam=1
	;ADDED DIGIDON CONTINUATION SECTION
	local ContinuationSectionStatus
		
	CURLOFNAME_TRACK = % LOFname
	;find function
	if (!foundFatrow := FIND_VARROW("OBF_FUNC", LOFname))
		return
	
	curline = % LOFheaderline
	
	;find '('
	if (!foundparenat := instr(curline, "("))
		return
		
	;replace parameter usage in function header line	
	loop, % OBF_FUNC_%foundFatrow%_PARAM_numrows	
	{
		lookforparam 	= % OBF_FUNC_%foundFatrow%_PARAM_%a_index%_name
		curparamOBF 	= % OBF_FUNC_%foundFatrow%_PARAM_%a_index%_OBFname
		
		if (!curparamOBF or curparamOBF = "no/obf")
			continue
			
		newline = % SubStr(curline, 1, foundparenat)
		
		StartingPos = % foundparenat + 1
		while true {
			foundPARAMat = % instr(curline, lookforparam, false, StartingPos)
			if (!foundPARAMat) {
				newline .= SubStr(curline, StartingPos)
				break
			}
							
			;add previous part first
			newline .= SubStr(curline, StartingPos, (foundPARAMat - StartingPos))
			
			;gets char before match
			prevchar = % SubStr(newline, 0)
			prevchar2 = % SubStr(curline, foundPARAMat-1,strlen(lookforparam)+1)
			nextchar = % SubStr(curline, foundPARAMat + strlen(lookforparam), 1)
			
			;//ADDED DIGIDON : Exclude Obf Param when prev char is "." or "{"
			if (!prevchar) ;prevchar is required here
				partialVAR_ERROR = % true
			else {			
				;get char after match
				nextchar = % SubStr(curline, foundPARAMat + strlen(lookforparam), 1)
				partialVAR_ERROR = % aretheyvariablechars_BIS(prevchar, nextchar)
			}

			if (partialVAR_ERROR) {
				;TWEAKED DigiDon
				newline .= SubStr(curline, foundPARAMat, strlen(lookforparam))	
			} else {
				;only replace parameters in the function header line with the full
				;obf name - no '%'s
				replacestr = %  curparamOBF  ;verifyreplacementwin(LOFheaderline, curline, newline, lookforfunc, replacewithfunc . "(")					
				if (replacestr) 
					newline .= curparamOBF
				 else
					;TWEAKED DigiDon
					newline .= SubStr(curline, foundPARAMat, strlen(lookforparam))	
			}					
			StartingPos = % foundPARAMat + strlen(lookforparam)							
		}
		curline = % newline	
	}
	LOFheaderline = % curline
		
	curbody = % LOFbodylines	
	
	newbody = 
	;replace parameter usage in the function body
	loop, parse, curbody, `n, `r
	{
		curline = % A_Loopfield 
		;MODIFIED DIGIDON : USE LOFbodylines which comes from StripppedLOFbodylines so no need for commment test
		;ADDED DIGIDON CONTINUATION SECTION & FINDPROCESSOBFSPECIALCOMMS
		ContinuationSectionStatus:=ContinuationSectionDetect(curline)
		findprocessOBFspecialcomms(curline)	
		
		loop, % OBF_FUNC_%foundFatrow%_PARAM_numrows	
		{
			lookforparam 	= % OBF_FUNC_%foundFatrow%_PARAM_%a_index%_name
			curparamOBF 	= % OBF_FUNC_%foundFatrow%_PARAM_%a_index%_OBFname
				
			if (!curparamOBF or curparamOBF = "no/obf")
				continue
			
			curparamnum = % a_index
					
			StartingPos = 1
			newline =
			while true {
				foundPARAMat = % instr(curline, lookforparam, false, StartingPos)
				if (!foundPARAMat) {
					newline .= SubStr(curline, StartingPos)
					break
				}				
								
				;add previous part first
				newline .= SubStr(curline, StartingPos, (foundPARAMat - StartingPos))
				
				;gets char before match
				prevchar = % SubStr(newline, 0)
				
				;get char after match
				nextchar = % SubStr(curline, foundPARAMat + strlen(lookforparam), 1)
				
				;ADDED DIGIDON CONTINUATION SECTION : PROCESS ONLY IF SURROUNDED BY %'s
				if (ContinuationSectionStatus="start" and prevchar!="%" and nextchar!="%") {
				newline .= SubStr(curline, foundPARAMat, strlen(lookforparam))
				; msgbox % "Skipped continuation for " lookforparam "`n" str_getTailLines(newline,10)
				; msgbox % "skipped line " str_getTailf(newline)
				StartingPos = % foundPARAMat + strlen(lookforparam)
				continue
				}
				
				; //ADDED DIGIDON : Allow []
				partialVAR_ERROR = % aretheyvariablechars_BIS(prevchar, nextchar)
				
				; //ADDED DIGIDON : Exclude Obf Param when prev char is "." or "{"
				if (prevchar="." or prevchar="{") ;prevchar is required here
					partialVAR_ERROR := True
						
				if (partialVAR_ERROR) {
					;TWEAKED DIGIDON to better detect vVariables (controls)
					if (ucase(prevchar) = "V" && regexmatch(str_getTailf(newline),"i)\s*GUI[\s,]") && !isitvarchar(nextchar)) {
						;ADDED DIGIDON
						vVardetected=1
						;backup one more character and check whether that is valid 
						;as a variable name or not
						prevprevchar = % SubStr(newline, -1, 1)
						; if aretheyvariablechars(prevprevchar) {
						;TWEAKED DIGIDON
						partialVAR_ERROR = % aretheyvariablechars_VvarOrGLab(prevprevchar, nextchar)
						Vvar_case= % partialVAR_ERROR
						;ADDED DIGIDON to better handle vVariables (controls)
						;ADDED BY DIGIDON : TRY TO GENERATE AN OBF STRING WITH NO % at beginning or end
						; msgbox lookforparam %lookforparam% Vvar_case %Vvar_case% prevchar %prevchar% nextchar %nextchar%
						if (Vvar_case=3 or Vvar_case=4 or Vvar_case=5)
							{
							;do the translation
							;TO IMPROVE : should either add dynamic obf of OBF NAME or at least straight obf of OBF NAME
							; newline .= """ " oneofmyOBFs("OBF_FUNC_" . foundFatrow . "_PARAM_" . curparamnum) " """
							newline .= curparamOBF
							
							}
						else if (Vvar_case=1)
							{
							;do NOT do translation
							newline .= SubStr(curline, foundPARAMat, strlen(lookforparam))
							}
						else if (Vvar_case=1)
							{
							;do NOT do translation
							newline .= SubStr(curline, foundPARAMat, strlen(lookforparam))
							}
						else {
							;put simple OBF name
							newline .= curparamOBF
						}
							
					} else if (SubStr(newline, -3, 4)="hwnd" && !isitvarchar(SubStr(newline, -4, 1)) && regexmatch(str_getTailf(newline),"i)\s*GUI[\s,]") && !isitvarchar(nextchar)) {
						;put simple OBF name
						newline .= curparamOBF
					} else if (nextchar = "[") {
						if (prevchar = "." or isitvarchar(prevchar)) {
						
						;dont do the translation
							;TWEAKED DigiDon
							newline .= SubStr(curline, foundPARAMat, strlen(lookforparam))	
						}
						else {
						;do the translation
						;TWEAKED DIGDON DELETE getfullOBF because it is anyway not set
							newline .= oneofmyOBFs("OBF_FUNC_" . foundFatrow . "_PARAM_" . curparamnum)
						}
					}
					else {
						;TWEAKED DigiDon
						newline .= SubStr(curline, foundPARAMat, strlen(lookforparam))
						}
				} else {
					;test for whether already surrounded by '%'s
					;if it is just replace with full obf name that has no '%'s
					if (prevchar = "%" and nextchar = "%")
						replacewithPARAM = % PUT_NULLS_AROUND(curparamOBF, "nofirstlastperc")
					else {
						;IF A PARAMETER ONLY HAS SINGLE LEVEL OBF, THEN I ASSUME
						;IT IS A 'BYREF' PARAM AND i DO NO ADD JUNK TO IT (%'S)
						;BECAUSE THAT CAN CAUSE A PROBLEM WITH USEAGE OF BYREF
						;PARAMETERS IN THE COM SECTION
						
						if (OBF_FUNC_%foundFatrow%_PARAM_%curparamnum%_numfragrows < 1)
							replacewithPARAM = % curparamOBF
						else	
							; TWEAKED DIGDON DELETE getfullOBF because it is anyway not set
							replacewithPARAM = % oneofmyOBFs("OBF_FUNC_" . foundFatrow . "_PARAM_" . curparamnum)
					}
					
					if (replacewithPARAM) 
						newline .= replacewithPARAM
					 else
						;TWEAKED DigiDon
						newline .= SubStr(curline, foundPARAMat, strlen(lookforparam))	
				}					
				StartingPos = % foundPARAMat + strlen(lookforPARAM)							
			}
			curline = % newline					
		}
		newbody .= curline . "`r`n"
	}
	LOFbodylines = % newbody
	; TESTING DIGIDON	
	if (Debug_Obf=1 && LOFname="CM_ChooseNotebook")
		msgbox %LOFname% replacePARAMETERS LOFbodylines %LOFbodylines%
}

isitvarchar(char) {
global
if (char="")
	return
if char is alnum
	return 1
if InStr(oddvarnameallowedchars, char)
	return 1
}

;//ADDED BY DIGIDON FOR GLABELS
aretheyvariablechars_VvarOrGLab(charbefore, charafter = "")
{
	global
	local case=0
	if (charbefore!="") {
		if charbefore is alnum
			{
			case=1
			return, case
			}
		if InStr(oddvarnameallowedchars, charbefore)
			{
			case=1
			return, case
			}
	}
				
	if (charafter!="") {
		if charafter is alnum
			{
			case=1
			return, case
			}
		if InStr(oddvarnameallowedchars, charafter)
			{
			case=1
			return, case
			}
	}
		
	;if before or after are ',', evaluate as valid and case 2
	if (charbefore = "," or charafter = ",")
		{
		case=2
		return, case
		}
	;if char before is ' ' and no charafter, evaluate as valid  and case 2
	if (charbefore = " " and isEmptyOrEndLine(charafter))
		{
		case=2
		return, case
		}
	;if both the before and after chars are ' ', evaluate as valid  and case 2
	if (charbefore = " " and charafter = " ")
		{
		case=2
		return, case
		}
		
	;if first is " and the other is ' ' evaluate as valid and case 3
	; "vLabel " -->" v" Label " "
	if (charbefore = """" and charafter = " ")
		{
		case=3
		return, case
		}
		
	;if first is ' ' and the other is a " evaluate as valid and case 4
	; " vLabel" -->" v" Label ""
	if (charbefore = " " and charafter = """")
		{
		case=4
		return, case
		}
	
	;if both the before and after chars are '"', evaluate as valid and case 5
	; "vLabel" -->"v" Label ""
	if (charbefore = """" and charafter = """")
		{
		case=5
		return, case
		}
		
	return, case

}

aretheyvariablecharsFUNCVARS(charbefore, charafter = "")
{
	global
	
	if (charbefore!="") {
		if charbefore is alnum
			return, % true
		if InStr(oddvarnameallowedchars, charbefore)
			return, % true
	}
				
	if (charafter!="") {
		if charafter is alnum
			return, % true
		if InStr(oddvarnameallowedchars, charafter)
			return, % true
	}
		
	;if both the before and after chars are '%', evaluate as valid 
	if (charbefore = "%" and charafter = "%")
		return, % false
		
	;if one but not the other is a '%' evaluate as invalid
	if (charbefore = "%" or charafter = "%")
		return, % true
		
	;if both the before and after chars are '"', evaluate as valid 
	if (charbefore = """" and charafter = """")
		return, % false
		
	;if one but not the other is a '"' evaluate as invalid
	if (charbefore = """" or charafter = """")
		return, % true
		
	;FUTURE TWEAK DIGIDON MAYBE : shouldn't we return true (=WRONG) in other cases?...
	return, % false

}

aretheyvariablecharsLABELS(charbefore, charafter = "")
{
	global
	
	if (charbefore!="") {
		if charbefore is alnum
			return, % true
		if InStr(oddvarnameallowedchars, charbefore)
			return, % true
	}
				
	if (charafter!="") {
		if charafter is alnum
			return, % true
		if InStr(oddvarnameallowedchars, charafter)
			return, % true
	}
		
	;if both the before and after chars are '%', evaluate as valid 
	if (charbefore = "%" and charafter = "%")
		return, % false
		
	;if one but not the other is a '%' evaluate as invalid
	if (charbefore = "%" or charafter = "%")
		return, % true
		
	;if both the before and after chars are '"', evaluate as valid 
	if (charbefore = """" and charafter = """")
		return, % false
		
	;if one but not the other is a '"' evaluate as invalid
	if (charbefore = """" or charafter = """")
		return, % true
		
	;FUTURE TWEAK DIGIDON MAYBE : shouldn't we return true (=WRONG) in other cases?...
	return, % false

}

;ADDED DIGIDON
aretheyvariablecharsPROPCALLS(charbefore, charafter = "") {
	global
	
	if (charbefore!="") {
		if charbefore is alnum
			return, % true
		if InStr(oddvarnameallowedchars_BIS, charbefore)
			return, % true
	}

	if (charafter!="") {
		if charafter is alnum
			return, % true
		if InStr(oddvarnameallowedchars_BIS, charafter)
			return, % true
	}

	if (charafter = "." or charafter = "," or charafter = ")" or charafter = "")
		return, % false

	; msgbox SYSPROPERTIES IS ANYWAY OBF CHAR AFTER %charafter%

	; we return false (=OK) in other cases
	return, % false
}

aretheyvariablecharsMETHODCALLS(charbefore, charafter = "") {
	global
	
	if (charbefore!=".")
	return, % true
	
	if (charafter!="(")
	return, % true

	; we return false (=OK) in other cases
	return, % false
}

aretheyvariablecharsFUNCCALLS(charbefore, charafter = "",funcvar="") {
	global
	
	if (charbefore!="") {
		if charbefore is alnum
			return, % true
		if InStr(oddvarnameallowedchars_BIS, charbefore)
			return, % true
	}
	
	if (charafter!="") {
		if charafter is alnum
			return, % true
		if InStr(oddvarnameallowedchars, charafter)
			return, % true
	}
	
	;TWEAKED DIGIDON
	;if char before is "." this is probably a method
	if (charbefore = ".")
		return, % true
		
	;if both chars are """ evaluate as valid
	if (charbefore = """" and charafter = """")
		return, % false
	
	;if paranthese after evaluate as valid
	if (charafter = "(")
		return, % false
		
	;Tried to recognize function without () : abandonned for now only allow between ""
	; if ((charbefore = "," or charbefore = "(" or RegexMatch(charbefore,"\h+")) and (charafter=")" or charafter="," or RegexMatch(charafter,"\h"))) {
		; RegexMatch(charafter,"\s+(?!\s*,)"))
		; msgbox funcvar %funcvar% charbefore %charbefore% charafter %charafter%
		; if (charafter ="`r" or charafter ="`n" or charafter ="`t")
			; msgbox space after
		; return, % false
		; }
		
	;Otherwise we DENY IT (true)
	return, % true
}

;//ADDED BY DIGIDON ALLOW []
aretheyvariablechars_BIS(charbefore, charafter = "")
{
	global
	oddvarnameallowedchars_BIS:="#@$_"
	if (charbefore!="") {
		;ADDED DIGIDON : DO NOT ALLOW . as prevchar
		if (charbefore=".")
			return, % true
		if charbefore is alnum
			return, % true
		if InStr(oddvarnameallowedchars_BIS, charbefore)
			return, % true
	}
				
	if (charafter!="") {
		if charafter is alnum
			return, % true
		if InStr(oddvarnameallowedchars_BIS, charafter)
			return, % true
	}
	
	;//ADDED BY DIGIDON 
	;DISABLED DIGIDON BECAUSE DIDN'T TAKE INTO ACCOUNT OPERATORS etc
	;if one char is '[' or ']' but not the other, and not blank, evaluate as invalid 
	; if (charbefore = "[" and (charafter != "]" and charafter != " "))
		; return, % true
		
	;//ADDED BY DIGIDON 
	;DISABLED DIGIDON BECAUSE DIDN'T TAKE INTO ACCOUNT OPERATORS etc
	;if one char is '[' or ']' but not the other, and not blank, evaluate as invalid 
	; if (charafter = "]" and (charbefore != "[" and charbefore != " "))
		; return, % true
		
	;if both the before and after chars are '%', evaluate as valid 
	if (charbefore = "%" and charafter = "%")
		return, % false
		
	;if one but not the other is a '%' evaluate as invalid
	if (charbefore = "%" or charafter = "%")
		return, % true
		
	;if both the before and after chars are '"', evaluate as valid 
	if (charbefore = """" and charafter = """")
		return, % false
		
	;if one but not the other is a '"' evaluate as invalid
	if (charbefore = """" or charafter = """")
		return, % true
		
		
	return, % false

}
;//ADDED BY DIGIDON ALLOW []
aretheyvariablechars_hidestr(charbefore, charafter = "")
{
	global
	oddvarnameallowedchars_BIS:="#@$_"
	if (charbefore!="") {
		if charbefore is alnum
			return, % true
		if InStr(oddvarnameallowedchars_BIS, charbefore)
			return, % true
	}
				
	if (charafter!="") {
		if charafter is alnum
			return, % true
		if InStr(oddvarnameallowedchars_BIS, charafter)
			return, % true
	}
		
	;if both the before and after chars are '%', evaluate as valid 
	if (charbefore = "%" and charafter = "%")
		return, % false
		
	;if one but not the other is a '%' evaluate as invalid
	if (charbefore = "%" or charafter = "%")
		return, % true
		
	;if both the before and after chars are '"', evaluate as valid 
	if (charbefore = """" and charafter = """")
		return, % false
		
	;if one but not the other is a '"' evaluate as invalid
	if (charbefore = """" or charafter = """")
		return, % true
		
	return, % false

}

;DIGIDON ADDED : PROCESS SPECIAL COMMENTS
findprocessOBFMODEcomms(LOFlines, skippfirst="") {
	global
	local curline
	; debug_findprocessOBFinsidespecial=1
	loop, parse, LOFlines, `n, `r
	{
		if (skippfirst and A_Index=1)
		continue
		
		curline = % A_Loopfield	
		if IS_OBFCOMM(curline) {
			if (debug_findprocessOBFinsidespecial=1)
			msgbox curline %curline% CUR_OBFCOMM %CUR_OBFCOMM%
			;ADDED DIGIDON : COMMENT TO STOP OBF
			if (CUR_OBFCOMM = "STOP_OBF")
				{
				if (debug_findprocessOBFinsidespecial=1)
				msgbox stop obf
				GlobObf_Stop=1
				}
			else if (CUR_OBFCOMM = "RESUME_OBF")
				{
				if (debug_findprocessOBFinsidespecial=1)
				msgbox resume obf
				GlobObf_Stop=
				}
			;ADDED DIGIDON : COMMENT TO FORCE STRAIGHT OBF
			if (CUR_OBFCOMM = "STRAIGHT_MODE")
				{
				if (debug_findprocessOBFinsidespecial=1)
				msgbox straight obf
				GlobObf_Straight=1
				}
			;ADDED DIGIDON : COMMENT TO FORCE STRAIGHT OBF
			else if (CUR_OBFCOMM = "DYNAMIC_MODE")
				{
				if (debug_findprocessOBFinsidespecial=1)
				msgbox resume dynamic obf
				GlobObf_Straight=
				}
		}
	}
}

;DIGIDON ADDED : PROCESS SPECIAL COMMENTS
findprocessOBFspecialcomms(LOFlines, skippfirst="") {
	global
	local curline
	loop, parse, LOFlines, `n, `r
	{
		if (skippfirst and A_Index=1)
		continue
		
		curline = % A_Loopfield	
		if IS_OBFCOMM(curline) {
		;ADDED DIGIDON : COMMENT TO STOP OBF
		
		;ADDED DIGIDON : BLOCKS COMMENTS
		if (CUR_OBFCOMM = "START_BLOCK")
			{
			OBF_block_numrows++
			;reinit code content
			OBF_block_%OBF_block_numrows%_code=
			; msgbox block %OBF_block_numrows% %curline%
			GlobObf_Block:=OBF_block_numrows
			if (debug_findprocessOBFspecial=1)
			msgbox START BLOCK GlobObf_Block %GlobObf_Block% %LOFlines%
			}
		else if (CUR_OBFCOMM = "END_BLOCK")
			{
			GlobObf_Block=
			if (debug_findprocessOBFspecial=1)
			msgbox END BLOCK GlobObf_Block %GlobObf_Block% %LOFlines%
			}
		;ADDED DIGIDON : COMMENT TO STOP OBF
		if (CUR_OBFCOMM = "STOP_OBF")
			{
			if (debug_findprocessOBFspecial=1)
			msgbox stop obf
			GlobObf_Stop=1
			}
		else if (CUR_OBFCOMM = "RESUME_OBF")
			{
			if (debug_findprocessOBFspecial=1)
			msgbox resume obf
			GlobObf_Stop=
			}
		;ADDED DIGIDON : COMMENT TO FORCE STRAIGHT OBF
		if (CUR_OBFCOMM = "STRAIGHT_MODE")
			{
			if (debug_findprocessOBFspecial=1)
			msgbox straight obf
			GlobObf_Straight=1
			}
		;ADDED DIGIDON : COMMENT TO FORCE STRAIGHT OBF
		else if (CUR_OBFCOMM = "DYNAMIC_MODE")
			{
			if (debug_findprocessOBFspecial=1)
			msgbox resume dynamic obf
			GlobObf_Straight=
			}
		;ADDED DIGIDON : KEEP COMMENT
		if (CUR_OBFCOMM = "START_COMMENT")
			{
			if (debug_findprocessOBFspecial=1)
			msgbox Comment section start
			GlobObf_Comment=1
			}
		;ADDED DIGIDON : COMMENT TO FORCE STRAIGHT OBF
		else if (CUR_OBFCOMM = "END_COMMENT")
			{
			if (debug_findprocessOBFspecial=1)
			msgbox Comment section end
			GlobObf_Comment=
			}
		}
	}
}

;TWEAKED DIGIDON : USE ONLY LOFBODYLINES
findprocessOBFDUMPcomms(ByRef LOFbodylines) {
	global
	
	newbody = 
	loop, parse, LOFbodylines, `n, `r
	{
		curline = % A_Loopfield		
		if IS_OBFCOMM(curline) {
			if (CUR_OBFCOMM = "DUMP_REWIREFUNCPATH") 
				curline = % DUMP_REWIREFUNC(CUR_COMMPARAMS)
				
			else if (CUR_OBFCOMM = "DUMP_REWIRE_STRAIGHT")
				curline = % DUMP_REWIRE_STRAIGHT(CUR_COMMPARAMS)
				
			else if (CUR_OBFCOMM = "DUMP_SECFRAGS_FORCLASSES")
				curline = % DUMP_SECFRAGS_FORCLASSES()
				
			;DigiDon changed DUMPPOISENED to DUMPPOISONED (D Malia typo)
			else if (CUR_OBFCOMM = "DUMPPOISONED_SECFRAGS_FORCLASSES" or CUR_OBFCOMM = "DUMPPOISENED_SECFRAGS_FORCLASSES")
				curline = % DUMPPOISONED_SECFRAGS_FORCLASSES()	
				
			else if (CUR_OBFCOMM = "DUMP_TMESSFRAGS_FORCLASSES")
				curline = % DUMP_TMESSFRAGS_FORCLASSES()
				
			else if (CUR_OBFCOMM = "DUMPFRAGS_FORCLASSES")
				curline = % DUMPFRAGS_FORCLASSES()				
				
			else if (CUR_OBFCOMM = "FUNCFRAGS_DUMPCLASS") 
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_FUNC", CUR_COMMPARAMS)
				
			else if (CUR_OBFCOMM = "ALLFRAGS_DUMPALL") {
				; curline = % DUMPALL_FRAGSETS_FORVARTYPE("ALL")
				curline .=  DUMPALL_FRAGSETS_FORVARTYPE("OBF_SYSVAR") 			"`r`n"
				curline .=  DUMPALL_FRAGSETS_FORVARTYPE("OBF_GLOBPARTIALVAR") 	"`r`n"
				curline .=  DUMPALL_FRAGSETS_FORVARTYPE("OBF_SYSFUNC") 			"`r`n"
				curline .=  DUMPALL_FRAGSETS_FORVARTYPE("OBF_GLOBVAR") 			"`r`n"
				curline .=  DUMPALL_FRAGSETS_FORPARAMS()						"`r`n"
				curline .=  DUMPALL_FRAGSETS_FORLOSVARS()						"`r`n"
				curline .=  DUMPALL_FRAGSETS_FORVARTYPE("OBF_SYSPROPERTIES") 		"`r`n"
				curline .=  DUMPALL_FRAGSETS_FORVARTYPE("OBF_SYSMETHODS") 			"`r`n"
			}
				
			else if (CUR_OBFCOMM = "SYSFUNCFRAGS_DUMPALL")
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_SYSFUNC")
				
			;ADDED DIGIDON SYSPROPERTIES
			else if (CUR_OBFCOMM = "SYSPROPERTIESFRAGS_DUMPALL")
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_SYSPROPERTIES")
				
			;ADDED DIGIDON SYSMETHODS
			else if (CUR_OBFCOMM = "SYSMETHODSFRAGS_DUMPALL")
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_SYSMETHODS")
				
			;ADDED DIGIDON GLOBPARTIALVARS
			else if (CUR_OBFCOMM = "GLOBPARTIALVARSFRAGS_DUMPALL") 
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_GLOBPARTIALVAR")
				
			;ADDED DIGIDON SYSVARS
			else if (CUR_OBFCOMM = "SYSVARFRAGS_DUMPALL") 
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_SYSVAR")
				
			else if (CUR_OBFCOMM = "LABELFRAGS_DUMPALL") 
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_LABEL")
				
			else if (CUR_OBFCOMM = "LABELFRAGS_DUMPCLASS")
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_LABEL", CUR_COMMPARAMS)
				
			else if (CUR_OBFCOMM = "PARAMFRAGS_DUMPALL") 
				curline = % DUMPALL_FRAGSETS_FORPARAMS()
				
			else if (CUR_OBFCOMM = "LOSVARFRAGS_DUMPALL") 
				curline = % DUMPALL_FRAGSETS_FORLOSVARS()
				
			else if (CUR_OBFCOMM = "GLOBVARFRAGS_DUMPALL") 
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_GLOBVAR")
				
			else if (CUR_OBFCOMM = "TRIPLEMESSFRAGS_DUMPALL") 
				curline = % DUMP_TMESSFRAGS_FORCOMMON()
			
			else if (CUR_OBFCOMM = "FUNCFRAGS_DUMPALL")  
				curline = % DUMPALL_FRAGSETS_FORVARTYPE("OBF_FUNC")

		}
		newbody .= curline . "`r`n"		
	}
	LOFbodylines = % newbody

}


;TWEAKED DIGIDON DELETE getfullOBF && addtriplemess because seem never to be used
oneofmyOBFs(currentvariable) {
	global
	static usejunkclass
	;ADDED DIGIDON
	GlobObf_Warn_RecoinLocalFctorStopMode=
	
	if (!%currentvariable%_OBFname or %currentvariable%_OBFname = "no/obf")
		return, %currentvariable%_name
	
	;only use a junk class when obfuscating function or label calls	
	if (substr(currentvariable, 1, 8) = "OBF_FUNC"
			or substr(currentvariable, 1, 9) = "OBF_LABEL")
		usejunkclass = % %currentvariable%_classname
	else
		usejunkclass =
	
	;TWEAKED DIGIDON DELETE getfullOBF && addtriplemess because seem never to be used
	
	;this can only have a non zero value for random replacement if
	;both the '$DUMP_SECFRAGS_FORCLASSES: common'
	;and the ';$OBFUSCATOR: $DUMP_TMESSFRAGS_FORCLASSES: common'
	;have been executed in the autoexecute section before 
	;any function has been called in that section!
	
	;ADDED DIGIDON : FORCE STRAIGHT MODE
	if (%currentvariable%_numfragrows < 1 or GlobObf_Straight=1 or GlobObf_ForceStraight=1) {
		;ADDED DIGIDON GlobObf_Warn_RecoinLocalFctorStopMode
		if GlobObf_ForceStraight=1
			{
			GlobObf_Warn_RecoinLocalFctorStopMode:=1
			}
		;DIGIDON MAYBE SHOULD BE MODIFIED HERE , MIN 3 MAX 5 NULLS ARE STANDARD : WHY ??!!
		;TWEAKED DIGIDON : REDUCE NULLS AND NO NULLS FOR PARTIALS
		;DIGIDON COMMENT : DEFAULT VALUE OF nulls & replacements for globpartialvars straight obfuscation, just obf name
		if(testobfpartial=1) {
			newOBF = % ADD_JUNK(%currentvariable%_OBFname, GLOBPARTIALvar_straightminmaxnulls, "00", usejunkclass)
			; newOBF = % ADD_JUNK(%currentvariable%_OBFname, "12", "00", usejunkclass)
		}
		;DIGIDON COMMENT : DEFAULT VALUE OF nulls for straight obfuscation
		else
			newOBF = % ADD_JUNK(%currentvariable%_OBFname, all_straightminmaxnulls, "00", usejunkclass)
			; newOBF = % ADD_JUNK(%currentvariable%_OBFname, "13", "00", usejunkclass)
		; newOBF = % ADD_JUNK(%currentvariable%_OBFname, "35", "00", usejunkclass)
		return, % newOBF 	
	}
	
	;make it cycle throught all available fragment sets	
	if (!%currentvariable%_lastfragrowused)
		%currentvariable%_lastfragrowused = 0
	%currentvariable%_lastfragrowused++
	if (%currentvariable%_lastfragrowused > %currentvariable%_numfragrows)
		%currentvariable%_lastfragrowused = 1
	
	if (%currentvariable%_fragsperrow = 1) {
		frow = % %currentvariable%_lastfragrowused	
		
		fragvarname = % %currentvariable%_frag_%frow%_1_varname
		fragvalue 	= % %currentvariable%_frag_%frow%_1_value
		
		if (ucase(substr(currentvariable, 1, 11)) = "OBF_SYSFUNC") {
			buildfragstr = % "%" . fragvarname . "%"
		;ADDED DIGIDON SYSPROPERTIES
		;TWEAKED DIGIDON SYSPROPERTIES SPECIAL OBF WITH SPACES BETWEEN FRAGS
		} else if (ucase(substr(currentvariable, 1, 17))="OBF_SYSPROPERTIES") {
			buildfragstr = % " " fragvarname
		;ADDED DIGIDON SYSMETHODS
		;TWEAKED DIGIDON SYSMETHODS SPECIAL OBF WITH SPACES BETWEEN FRAGS
		} else if (ucase(substr(currentvariable, 1, 14))="OBF_SYSMETHODS") {
			buildfragstr = % " " fragvarname
		;ADDED DIGIDON SYSVARS
		} else if (ucase(substr(currentvariable, 1, 10))="OBF_SYSVAR") {
			buildfragstr = % "%" . fragvarname . "%"
			; msgbox fragvarname %fragvarname% fragvalue %fragvalue%
		} else {
			;only use 'fragvarname' if this is a function that is marked as a
			;'isswitchfunc'
			if ((substr(currentvariable, 1, 8) = "OBF_FUNC") and %currentvariable%_isswitchfunc) {
				buildfragstr = % PUT_NULLS_AROUND(fragvarname, "", usejunkclass)
						
			} else {
				if odds_5to1() {
					buildfragstr  = % ADD_JUNK(fragvalue, all_minmaxnulls, all_minmaxreplacements, usejunkclass)
					; buildfragstr  = % ADD_JUNK(fragvalue, "12", "12", usejunkclass)
					;DIGIDON MAYBE THAT COULD BE USED TO OBF LOCAL FCT WITH SOME SUPERGLOBALS REPLACEMENTS CHARS
					; buildfragstr  = % ADD_JUNK(%currentvariable%_OBFname, "23", "12", usejunkclass)
				} else {
					buildfragstr = % PUT_NULLS_AROUND(fragvarname, "", usejunkclass)
					;DIGIDON MAYBE THAT COULD BE USED TO OBF LOCAL FCT WITH SOME SUPERGLOBALS REPLACEMENTS CHARS
					; buildfragstr = % PUT_NULLS_AROUND(%currentvariable%_OBFname, "", usejunkclass)
				}
			}
		}
		
		if (strlen(buildfragstr) > 253) {
			msgbox, 
(join`s
INSIDE SINGLE COLUMN OBF NAME`n
The triple messed obfuscated variable name that was generated by this progam
has exceeded the
autohotkey limit of up to 253 characters for a variable name:`n`n
%buildfragstr%

`n`nUse less null or replacement insertions or make your obf names shorter
or make your null or replacement names shorter. autohotkey will not be able
to compile or run the obfuscated code generated.
)
		}
				
		return, buildfragstr	
	}
	
	randomset = % %currentvariable%_lastfragrowused	
	
	buildfragstr =
	loop, % %currentvariable%_fragsperrow
	{
	;DIGIDON COMMENT : Without classes seems to be used for SYS_FUNC only but then will only add nulls...
	
		if (ucase(substr(currentvariable, 1, 11)) = "OBF_SYSFUNC") {
			buildfragstr .= PUT_NULLS_AROUND(%currentvariable%_frag_%randomset%_%a_index%_varname,"")
			continue		
		}
		
		;ADDED DIGIDON SYSPROPERTIES, SYSMETHODS
		if (ucase(substr(currentvariable, 1, 17))="OBF_SYSPROPERTIES" or ucase(substr(currentvariable, 1, 14))="OBF_SYSMETHODS") {
		;TWEAKED DIGIDON SYSPROPERTIES/SYSMETHODS SPECIAL OBF WITH SPACES BETWEEN FRAGS
			buildfragstr .= PUT_NULLS_AROUND(%currentvariable%_frag_%randomset%_%a_index%_varname,"nopercatall") . " "
			continue		
		}
		
		;ADDED DIGIDON SYSVARS
		if (ucase(substr(currentvariable, 1, 10))="OBF_SYSVAR") {
			buildfragstr .= PUT_NULLS_AROUND(%currentvariable%_frag_%randomset%_%a_index%_varname,"")
			; msgbox %currentvariable%_frag_%randomset%_%a_index%_varname
			; msgbox % "_varname " %currentvariable%_frag_%randomset%_%a_index%_varname
			; msgbox % "buildfragstr " buildfragstr
			continue		
		}
		
		if ((ucase(substr(currentvariable, 1, 8)) = "OBF_FUNC") and %currentvariable%_isswitchfunc) {
			buildfragstr .= PUT_NULLS_AROUND(%currentvariable%_frag_%randomset%_%a_index%_varname, "", usejunkclass)
			continue
		}
		
		;DIGIDON COMMENT : SEEMS NOT TO HAPPEN?
		if (a_index = 1) {
			buildfragstr .= ADD_JUNK(%currentvariable%_frag_%randomset%_%a_index%_value, "11", "12", usejunkclass)
			continue
		}
		
		if flipcoin() { 
			buildfragstr .= ADD_JUNK(%currentvariable%_frag_%randomset%_%a_index%_value, "11", "12", usejunkclass)
		} else {
			buildfragstr .= PUT_NULLS_AROUND(%currentvariable%_frag_%randomset%_%a_index%_varname, "", usejunkclass)
		}
	}
	
	if (strlen(buildfragstr) > 253) {
		msgbox, 
(join`s
INSIDE MULTIPLE COLUMN OBF NAME`n
The triple messed obfuscated variable name that was generated by this progam
has exceeded the
autohotkey limit of up to 253 characters for a variable name:`n`n
%buildfragstr%

`n`nUse less null or replacement insertions or make your obf names shorter
or make your null or replacement names shorter. autohotkey will not be able
to compile or run the obfuscated code generated. 
)
	}
	
	return, % buildfragstr
}

PUT_NULLS_AROUND(fragvarname, nobeginlastperc="", forclass="") {
	global
	static OBFstring
	
	;get the first NULL from the specified CLASS
	if (forclass and forclass <> "common" and CLASS_%forclass%_numnulls) {
		firstnull = % INSERT_RAND_NULL_FORCLASS(forclass)
	;OR get the first NULL from the generics list	
	
	} else {		
		firstnull = % INSERT_RAND_COMMON_NULL()
	}
	
	;TWEAKED DIGIDON nopercatall
	if (nobeginlastperc="nopercatall")
		firstnull = % substr(firstnull, 2, (strlen(firstnull) - 2))
	
	;get the second null from the generics list
	;TWEAKED DIGIDON nopercatall
	secondnull = % INSERT_RAND_COMMON_NULL()	
	if (nobeginlastperc="nopercatall")
	secondnull = % substr(secondnull, 2, (strlen(secondnull) - 2))
	
	if (nobeginlastperc="nofirstlastperc") {
		if (SubStr(fragvarname,1,1)="%")
			fragvarname:=SubStr(fragvarname,2)
		if (SubStr(fragvarname,0,1)="%")
			fragvarname:=SubStr(fragvarname,1,-1)
	}
	
	;TWEAKED DIGIDON nopercatall
	if (nobeginlastperc="nopercatall")
		OBFstring = % fragvarname
	else
		OBFstring = % "%" . fragvarname . "%"
	
	;TWEAKED DIGIDON nopercatall
	if flipcoin() {
		;put the first null at the BEGINNING of the string
		if (nobeginlastperc="nopercatall")
		OBFstring = % firstnull . " " . OBFstring
		else
		OBFstring = % firstnull . OBFstring
	} else {
		;put the first null at the END of the string
		if (nobeginlastperc="nopercatall")
		OBFstring = %  OBFstring . " " . firstnull
		else
		OBFstring = %  OBFstring . firstnull
	}
	if flipcoin() {
		;put the SECOND null at the BEGINNING of the string
		if (nobeginlastperc="nopercatall")
		OBFstring = % secondnull . " " . OBFstring
		else
		OBFstring = % secondnull . OBFstring
	} else {
		;put the SECOND null at the END of the string
		;TWEAKED DIGIDON nobeginlastperc should specify value
		if (nobeginlastperc="nopercatall")
		OBFstring = % OBFstring . " " . secondnull
		else
		OBFstring = % OBFstring . secondnull
	}
	
	;take out the beginning and last percents. used where the original
	;variable usage already has percents around it, so this will 'normalize' it	
	
	;TWEAKED DIGIDON nobeginlastperc should specify value
	if (nobeginlastperc="nofirstlastperc") {
		;take out first '%'
		OBFstring = % substr(OBFstring, 2)
		;take out the last '%'
		OBFstring = % substr(OBFstring, 1, (strlen(OBFstring) - 1))
	}
	
	
	return, OBFstring
}


;ADDED DIGIDON : DETECT CHANGE COMMENT FLAG EVEN IF NOT REMOVING SPACE
lookforCommentFlag(ByRef LOFbodylines) {
	global
	
	loop, parse, LOFbodylines, `n, `r
	{
		curline = % A_Loopfield
		If FoundPos:=Instr(curline,"#CommentFlag")
			{
			CommFlag:=Trim(SubStr(curline,FoundPos + StrLen("#CommentFlag")))
			NewStartingPos:=1
			
			CommFlagRegex:=RegexReplace(CommFlag, "(\\|\/|\.|\*|\?|\+|\[|\{|\||\(|\)|\^|\$)","\$1", , ,1)
			}
		continue
	}
}
	

;TWEAKED BYDIGIDON : BETTER DETECTION OF COMMENTS
removeALLCOMMENTSandWHITESPACE(ByRef LOFbodylines) {
	global
	static newbody, curline, trimspaces, KeepComment
	;variables were added as global at start of procedure !
	; global CommFlag=";",CommFlagRegex=";"
	; static CommFlag=";",CommFlagRegex=";"
	static EschapeChar="``",EschapeCharRegex="``"
	local iscontinuesect = 0
	local iscommentsect = 0
	
	newbody = 
	loop, parse, LOFbodylines, `n, `r
	{
		curline = % A_Loopfield
		
		trimspaces = %curline%
		
		if (KeepComment=1) {
			If Instr(curline,"$END_COMMENT:") {
				KeepComment=
				continue
			}
			newbody .= "`r`n" . curline
			continue
		}
		
		;'continuation' section has been opened, test for end
		if (iscontinuesect) {
			;close of continuation section found
			;TWEAKED DIGIDON : allow spaces before match
			if (substr(trimspaces, 1, 1) = ")") {
				iscontinuesect = 0
				newbody .= "`r`n" . trimspaces
				continue
			;still waiting for end of continuation section
			} else {
				newbody .= "`r`n" . trimspaces
				continue
			}
		}
		
		;TWEAKED DIGIDON : allow spaces before match
		;comment section has been opened, test for end
		if (iscommentsect) {
			;close of comment section found
			if (substr(trimspaces, 1, 2) = "*/") {
				iscommentsect = 0
				continue
			;still waiting for end of comment section
			} else {
				continue
			}
		}
		
		if IsType(trimspaces,"space")
			continue
		
		
		If Instr(trimspaces,"$START_COMMENT:")
			{
			KeepComment=1
			continue
			}
		
		If (SubStr(trimspaces,1,StrLen("#CommentFlag"))="#CommentFlag")
			{
			CommFlag:=Trim(SubStr(trimspaces,1 + StrLen("#CommentFlag")))
			CommFlagRegex:=RegexReplace(CommFlag, "(\\|\/|\.|\*|\?|\+|\[|\{|\||\(|\)|\^|\$)","\$1", , ,1)
			newbody .= "`r`n" . trimspaces
			continue
			}
			
		If (SubStr(trimspaces,1,StrLen("#EschapeChar"))="#EschapeChar")
			{
			EschapeChar:=Trim(SubStr(trimspaces,FoundPos + StrLen("#CommentFlag"),1))
			EschapeCharRegex:=RegexReplace(CommFlag, "(\\|\/|\.|\*|\?|\+|\[|\{|\||\(|\)|\^|\$)","\$1", , ,1)
			newbody .= "`r`n" . trimspaces
			continue
			}
		
		;TWEAKED DIGIDON : allow spaces before match
		;test for start of comment section
		if (substr(trimspaces, 1, 2) = "/*") {
			iscommentsect = 1
			continue		
		}
		
		;test for start of 'continuation' section
		;TWEAKED DIGIDON : allow spaces before match
		if (substr(trimspaces, 1, 1) = "(") {
			iscontinuesect = 1
			newbody .= "`r`n" . trimspaces
			continue		
		}
		
		;test for ';' first char
		if (!trimspaces)
			continue
		if substr(trimspaces, 1, StrLen(CommFlag)) = CommFlag
			continue
		
		;replace inline comms (must have whitespace before)
		If InStr(trimspaces,CommFlag) {
		trimspaces:=RegExReplace(trimspaces, "^([^\r\n]*?)[\h]" CommFlagRegex ".*?$", "$1")
		if (!trimspaces)
			continue
		}
		
		;test for the first instance of this concatenation
		if (newbody)
			newbody .= "`r`n" . trimspaces
		else
			newbody .= trimspaces
	}

	LOFbodylines:=newbody
}

removeBODYcomments(ByRef LOFbodylines) {
	global
	static newbody, curline, trimspaces, commentlinenum
	local doskipline,commentsection
	numcommentlines = 0
	; msgbox reset
	
	newbody = 
	loop, parse, LOFbodylines, `n, `r
	{
		doskipline=
		curline = % A_Loopfield 
		trimspaces = %curline%
		
		;test for ';' first char
		;comment line found, store it in array
		;TWEAKED DIGIDON COMMFLAG & LEAVE $OBFUSCATOR: COMMANDS
		;DIGIDON MAYBE COMMFLAG SHOULD ALSO BE PARSED HERE FOR NEW ??
		if (!trimspaces or (substr(trimspaces, 1, 1) = CommFlag and substr(trimspaces, 2, 12)!="$OBFUSCATOR:")) 
		doskipline=1
		
		if (commentsection=1 and SubStr(Trim(curline), 1, 2) = "*/") {
			commentsection=
			doskipline=1
		} 
		else if (commentsection=1)
			doskipline=1
		else if (SubStr(Trim(curline), 1, 2) = "/*") {
			commentsection=1
			doskipline=1
			; msgbox comment section detected
		}
		
		if (doskipline) {	
			commentlinenum = % a_index 
			;TWEAKED DIGIDON : LIFT LIMITATION OF 100 comment lines by adding # char
			
			numcommentlines++
			;put the original line # for the body at the beginning of the line	followed by #		
			commentline%numcommentlines% = % commentlinenum . "#" . curline
			; msgbox % "skipp line " numcommentlines " content `n" commentlinenum . "#" . curline
			continue
		}
		
		;test for the first instance of this concatenation
		if (newbody)
			newbody .= "`r`n" . curline
		else
			newbody .= curline
	}

	return, newbody

}

mergeBODYcomments(byref strippedBODY) {
		global
	static newbody, curline, curcommentline, newbodyline, curcommentline_originline
	local foundpos
	
	curcommentline = 1
	newbodyline = 0
	
	newbody = 
	loop, parse, strippedBODY, `n, `r
	{
		curline = % A_Loopfield 
		newbodyline++
		
		;TWEAKED DIGIDON : LIFT LIMITATION OF 100 comment lines by adding # char
		if foundpos:=Instr(commentline%curcommentline%,"#") {
		curcommentline_originline:=substr(commentline%curcommentline%, 1, foundpos-1)
		}
		
		while (curcommentline <= numcommentlines and substr(commentline%curcommentline%, 1, foundpos-1) = newbodyline) {
			newbody .= substr(commentline%curcommentline%, foundpos+1) . "`r`n"
			curcommentline++
			newbodyline++
			foundpos:=Instr(commentline%curcommentline%,"#")			
		}
			
		newbody .= curline . "`r`n"	
		
	}

	return, newbody

}


savecode(varpath, byref mysectstr) {
	global
	;ex: OBF_FUNC11 -->OBF_FUNC11_code
	%varpath%_code = % mysectstr	
}

;ADDED DIGIDON
;WARNING CONTENT SHOULD BE EMPTIED THE FIRST TIME
;Only used for blocks right now
addtocode(varpath, byref mysectstr) {
	global
	
	%varpath%_code .= mysectstr
}

movecurlybracesUP(ByRef LOFheaderline, ByRef LOFbodylines, LOFname)	{
	global
	static canmoveit
	
	canmoveit = % false
	loop, parse, LOFbodylines, `n, `r
	{
		curline = %A_Loopfield%
		if (substr(curline, 1, 1) = "{") 
			canmoveit = % true
		break
	}
	if (!canmoveit)
		return
	
	;get location of closing parenthesis
	if (!foundparen := instr(LOFheaderline, ")"))
		return
	
	;check for an extra closing parenthesis, if found do not move '{'	
	if (instr(LOFheaderline, ")", false, foundparen+1)) {
		msgbox, 
(
found extra closing ')' on function header
for function: %LOFname%
complete header line:
%LOFheaderline%
MOVE OF '{' CANCELLED
)
		return		
	}
	
	;new header line with added '{'
	LOFheaderline = % substr(LOFheaderline, 1, foundparen) . " { " 
					. substr(LOFheaderline, foundparen+1)	
	
	newbody = 
	loop, parse, LOFbodylines, `n, `r
	{
		if (a_index = 1)
			continue
		
		newbody .= A_Loopfield . "`r`n"
	}
	LOFbodylines = % newbody
}


trimbody(byref LOFbodylines) {
	global 
	
	StringSplit, curbody, LOFbodylines, `n, `r

	uselastline = % curbody0
	loop, % curbody0
	{
		lastline = % curbody0 - a_index + 1 
		
		trimme = % curbody%lastline%
		trimme = %trimme%
		;if something left
		if (trimme)
			break
			
		uselastline = % lastline
	}
	
	LOFbodylines = 
	loop, % uselastline
	{
		if (a_index > 1)
			LOFbodylines .= "`r`n"
			
		LOFbodylines .= curbody%a_index%	
	}
	
	return
}

usecustcode_dumporder() {
	global
	
	loop, % dumpcode_numrows
	{
		curdumprow = % a_index
		
		shuffle_numrows = 0
		
		loop, % dumpcode_%curdumprow%_numrows
		{
			oneobjclass = % dumpcode_%curdumprow%_%a_index%
			oneobjclass = %oneobjclass%
			
			;split the string by ':'
			;the first parameter will be the object type which can be
			;'func', or 'label', or 'fandl'
			dumpcode_comm0 = 0			
			StringSplit, dumpcode_comm, oneobjclass, :, %a_space%%a_tab%
			
			if (dumpcode_comm0 < 2)
				continue
			
			;MODIFIED DIGIDON : DISABLED USELESS DEBUG dumpcompiledinfilesize_INCLUDE
			; if (dumpcode_comm1 = "INCLUDE" and dumpcode_comm2 = "compiledinfilesize") {
				; dumpcompiledinfilesize_INCLUDE()
				; continue			
			; }
			
			;MODIFIED DIGIDON : SIMPLIFIED ADDING CLASS CODE : ALL ADDED no need to specify type
			loop 1 {
			addtoshufflelist("func", dumpcode_comm2)
			addtoshufflelist("label", dumpcode_comm2)
			addtoshufflelist("block")
			addtoshufflelist("contextcondition", dumpcode_comm2)
			addtoshufflelist("class", dumpcode_comm2)
			}
				
			; if (dumpcode_comm1 = "func") {
				; addtoshufflelist("func", dumpcode_comm2)
				; continue			
			; }
			
			; if (dumpcode_comm1 = "label") {
				; addtoshufflelist("label", dumpcode_comm2)
				; continue			
			; }
			
			; if (dumpcode_comm1 = "fandl") {
				; addtoshufflelist("func", dumpcode_comm2)
				; addtoshufflelist("label", dumpcode_comm2)
				; continue			
			; }		
		}
	
		if (scramblefuncs)
			shufflemylist(1)
			
		printshuffledlist()
	}
	
}


;MODIFIED DIGIDON : DISABLED USELESS DEBUG dumpcompiledinfilesize_INCLUDE
;CAN STILL LOOK BEFORE WHAT THIS DEBUG 'MYFILESIZE-autogenerated.ahk' file is
; dumpcompiledinfilesize_INCLUDE() {
	;writetoOBFfile("#INCLUDE s:\includes\MYFILESIZE-autogenerated.ahk")
; }

shuffleandadd_allcode()	{
	global	
	
	shuffle_numrows = 0
	addtoshufflelist("func")
	addtoshufflelist("label")
	;ADDED DIGIDON BLOCKS
	addtoshufflelist("block")
	;ADDED DIGIDON #IF CONTEXT CONDITION shuffle
	addtoshufflelist("contextcondition")
	;ADDED DIGIDON Classes shuffle
	addtoshufflelist("class")
	shufflemylist(1)
	printshuffledlist()
}

addtoshufflelist(objtype, forclass="") {
	global
	loop, % OBF_%objtype%_numrows
	{
		;if i specified 'unclassed' but it has a class, then skip
		;if 'unclassed' is specified as the class, then items that 
		;have a class will be skipped
		if (forclass = "unclassed") {
			if (OBF_%objtype%_%a_index%_classname)
				continue			
		} else if (!forclass) {
		
		} else {
			;if a class is specified then items that do not have that
			;class name will be skipped
			if (OBF_%objtype%_%a_index%_classname <> forclass)
				continue
		}
		
		;TWEAKED DIGIDON BLOCKS
		if (OBF_%objtype%_%a_index%_code and !OBF_%objtype%_%a_index%_block) {
			newrow = % ++shuffle_numrows
			shuffle_%newrow%_objtype = % objtype
			shuffle_%newrow%_objrow = % a_index
		}
	}
}

shufflemylist(numpasses = 1)
{
	global
	
	loop, % numpasses
	{
		loop, % shuffle_numrows
		{
			curtoprow = % shuffle_numrows - a_index + 1
			if (curtoprow < 2)
				break
			
			Random, randomrow, 1, % curtoprow
			
			;switch the 'randomrow' and the current top row	
			
			;save the current top row		
			temp_objtype = % shuffle_%curtoprow%_objtype
			temp_objrow  = % shuffle_%curtoprow%_objrow
			
			;move the 'random row' to the current top row
			shuffle_%curtoprow%_objtype = % shuffle_%randomrow%_objtype
			shuffle_%curtoprow%_objrow = % shuffle_%randomrow%_objrow
			
			;move the saved current top row to the 'random row'
			shuffle_%randomrow%_objtype = % temp_objtype
			shuffle_%randomrow%_objrow = % temp_objrow
		}
	}
}

printshuffledlist()
{
	global
	;MODIFIED DIGIDON: COMMENTED OUT = DISABLED USELESS dumpcompiledinfilesize_INCLUDE DEBUG
	
	;print them out
	loop, % shuffle_numrows
	{
		myobjtype = % shuffle_%a_index%_objtype
		myobjrow = % shuffle_%a_index%_objrow
		
		writetoOBFfile(OBF_%myobjtype%_%myobjrow%_code)
	}
}

writetoOBFfile(writethis)
{
	global 
	
	if (!writetoOBFfilestr)
		 VarSetCapacity(writetoOBFfilestr, 3000000)
		 
	writetoOBFfilestr .= writethis . "`r`n"
}
closeOBFfile() {
;TWEAKED DIGIDON : added timer
	global	
	
	outputsize := strlen(writetoOBFfilestr)	
	
	msgbox, 
(
Obfuscation of your script has completed in %timepassed_obfuscateonly_mn% mn %timepassed_obfuscateonly_sc% sc
Your output file will now be written to.

OUTPUT FILE NAME:
%OBFUSCATEDfile%

SIZE OF OBFUSCATED SCRIPT:
%outputsize%
)
	
	;delete if already exists
	FileDelete, % OBFUSCATEDfile		
	;ADDED DIGIDON : UT8 -  -->RAW ENCODING?
	FileAppend, % writetoOBFfilestr, % OBFUSCATEDfile, UTF-8
}

;make copyright info into a form that can survive being compiled
;namely make it into a string assigned to a variable so it is an actual
;program statement
write_copyright_info()
{
	global
	
	OBFfile_startstr =
(
Date: %currenttime%

THE FOLLOWING AUTOHOTKEY SCRIPT WAS OBFUSCATED 
BY DYNAMIC OBFUSCATOR L FOR AUTOHOTKEY
By DigiDon

Based on DYNAMIC OBFUSCATOR
Copyright (C) 2011-2013  David Malia
DYNAMIC OBFUSCATOR is released under
the Open Source GPL License
)
	
	;find the longest line
	longest = 0
	loop, parse, OBFfile_startstr, `n, `r
		if (strlen(a_loopfield) > longest)
			longest = % strlen(a_loopfield)
	
	;add extra space 
	longest++

	spaces = % "                                                          "	
	buildstartstr =
	loop, parse, OBFfile_startstr, `n, `r
		buildstartstr .= "obf_copyright := "" " . a_loopfield . substr(spaces, 1, longest - strlen(a_loopfield)) . """`r`n"	

	return, buildstartstr 
}


verifyreplacementwin(LOFheaderline, programline, partialline, lookforfunc, replacewithfunc, CURSECTBODY="", NEWSECTBODY="")
{
	global
	
	vr_h1font 		= % "s22"
	vr_h2font 		= % "s18"
	vr_basefont 	= % "s14"
	vr_smallfont 	= % "s12"
	
	userresponse = % false
	doreplacement = % false
	
	if (vrguinum = 10) {
		vrguinum = 11
		oldvrguinum = 10
	} else {
		vrguinum = 10
		oldvrguinum = 11
	}
		
	gui, %vrguinum%:default
	gui, +Labelverifywin
	gui, margin, 20, 20
	
	gui, font, %vr_basefont%  norm
	gui, add, text, xm  y+4 Vgetspacewidth, % " "
	GuiControlGet, spacewidth, Pos, getspacewidth
	
	standcontwidth = % spacewidthW * 200
	
	gui, font, %vr_h1font% bold
	gui, add, text, xp yp, REPLACEMENT VERIFICATION WINDOW
	
	gui, font, %vr_h2font%	
	gui, add, text, xm y+10, Label or Function Header line:
	gui, font, %vr_basefont% norm
	Gui, Add, Edit, xm y+2 W%standcontwidth% readonly, % LOFheaderline
	
	gui, font, %vr_h2font%	
	gui, add, text, xm y+10, CURRENT SECTION BODY:
	gui, font, %vr_basefont% norm
	Gui, Add, Edit, xm y+2 R6 W%standcontwidth% readonly, % CURSECTBODY
	
	gui, font, %vr_h2font%	
	gui, add, text, xm y+10, NEW SECTION BODY IN CREATION:
	gui, font, %vr_basefont% norm
	Gui, Add, Edit, xm y+2 R6 W%standcontwidth% readonly, % NEWSECTBODY
	
	gui, font, %vr_h2font%
	gui, add, text, xm y+10, Full source code line:
	gui, font, %vr_basefont% norm
	gui, add, text, xm y+2, % programline
	
	gui, font, %vr_h2font%
	gui, add, text, xm y+4, REPLACE Colored?
	gui, font, %vr_basefont% norm
	gui, add, text, xm y+4, % partialline
	
	gui, add, text, x+2 yp Cred, % lookforfunc	
	
	gui, add, button, xm y+10 GreplacementOK, REPLACE With:
	gui, font, %vr_h2font%
	gui, add, text, x+10 yp+4 C009900, % replacewithfunc
	
	gui, add, button, xm y+10 GreplacementCAN, Do NOT Replace
	
	gui, add, button, xm y+20 GreplacementQUITALL, Quit all and write	
	
	
	gui, show
	
	gui, %oldvrguinum%:destroy
	
	while !userresponse 
		sleep, 120
		
	if (!doreplacement)
		return, % ""
		
	return, % replacewithfunc
	
replacementOK:
	doreplacement 	= % true
	userresponse 	= % true
return
replacementCAN:
	doreplacement 	= % false
	userresponse 	= % true
return
verifywinClose:
replacementQUITALL:
	closeOBFfile()
	exitapp
return

}

isEmptyOrEndLine(char) {
	if (char="" or char="`r" or char="`n")
		return 1
}