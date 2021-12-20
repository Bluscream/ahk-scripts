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


#SingleInstance force
Glb_VersionNum := 2.14

OnExit, savelastfiles

initvartypes()

getlastobffiles()

chooseOBFfunc()
;Added DigiDon : Automatic selection
GuiControl, +default, createTRANSMAPfilenames_v
	
;return from AUTOEXECUTE
return

2GuiClose:
2GuiEscape:
	exitapp
return
;---------------------------------------------
;**START CHOOSE OBF FUNCTION SECTION**
;---------------------------------------------

chooseOBFfunc:
	gui, destroy
	chooseOBFfunc()
	;Added DigiDon : Automatic selection
	GuiControl, +default, getOBFfilenames_v
return

chooseOBFfunc() {
	global
	
	scl_h1font 		= % "s22"
	scl_h2font 		= % "s18"
	scl_basefont 	= % "s14"
	scl_smallfont 	= % "s12"
	scl_small2font 	= % "s10"
	
	gui 2:default
	gui, destroy
	gui, margin, 40, 40
	
	gui, font, %scl_basefont%  norm
	gui, add, text, xm  y+4 Vgetspacewidth, % " "
	GuiControlGet, spacewidth, Pos, getspacewidth	
	
	gui, font, %scl_h1font% bold
	gui, add, text, xp yp+10 Cab7430, % "DYNAMIC OBFUSCATOR L v" Glb_VersionNum
	
	gui, font, %scl_basefont%  norm underline
	gui, add, text, x+120 yp+4 cblue Gshowabout, About
	
	gui, font, %scl_basefont%  norm 
	gui, add, text, xm y+2, Obfuscator for Autohotkey Scripts written in Autohotkey
		
	gui, font, %scl_h2font% norm
	gui, add, text, xm y+28, Choose Obfuscator Function	
	
	gui, font, %scl_basefont%  norm
	gui, add, button, xm y+40 GcreateTRANSMAPfilenames vcreateTRANSMAPfilenames_v, Create Translations Map
	gui, add, text, x+30, This will create a 'map' file of the objects in your`nsource code files. This must be run before the`nobfuscate function below
	
	gui, add, button, xm y+30 GgetOBFfilenames vgetOBFfilenames_v, % "Obfuscate Source Code"
	gui, add, text, x+30, Will create the output obfuscated file
	
	gui, add, button, xm y+60 G2GuiClose, Cancel program
	gui, show
}

showabout:
	; Gui 2:+Disabled
	
	gui 5:default
	gui, destroy
	; Gui, +Owner2
	gui, margin, 40, 20
	
	gui, font, %scl_basefont%  norm
	gui, add, text, xm  y+4 Vgetspacewidth, % " "
	GuiControlGet, spacewidth, Pos, getspacewidth	
	
	gui, font, %scl_h1font% bold
	gui, add, text, xp yp+10 Cab7430, % "DYNAMIC OBFUSCATOR L v" Glb_VersionNum
	
	; gui, font, %scl_basefont%  norm underline
	; gui, add, text, x+120 yp+4 cblue Gshowabout, About
	
	gui, font, %scl_basefont%  norm 
	gui, add, text, xm y+2, Obfuscator for Autohotkey Scripts written in Autohotkey
		
	gui, font, %scl_basefont% norm
	gui, add, text, xm y+28,	
	(Ltrim
	DYNAMIC OBFUSCATOR L 2.0
	Released under Open Source GPL License
	)
	
	gui, font, %scl_smallfont% norm
	
	gui, add, text, xm y+5, by DigiDon
	
	Gui, Add, Link,x+5 yp, <a href="https://autohotkey.com/boards/memberlist.php?mode=viewprofile&u=59397">AHK Forum profile</a>
	
	gui, add, text, xm y+28, 
	(Ltrim
	BASED ON
	DYNAMIC OBFUSCATOR 1.01
	By David Malia
	)
	
	gui, font, %scl_small2font% norm
	
	gui, add, text, xm y+5,	
	(Ltrim
	(Contact details and website seem to be down at time of update)
	DYNAMIC OBFUSCATOR 1.01
	Obfuscator for Autohotkey Scripts written in Autohotkey
	http://dynamicobfuscator.org
	Released under Open Source GPL License
	Author:
	David Malia, 11 Cedar Ct, Augusta ME, USA
	dave@dynamicobfuscator.org
	http://davidmalia.com

	DYNAMIC OBFUSCATOR is an obfuscator for autohotkey scripts that
	can obfuscate functions, autohotkey functions, labels,
	parameters, and variables. It can automatically use the dynamic
	variable creation features of autohotkey to create breakable
	code sections and function path rewiring.
	)
	
	gui, font, %scl_basefont%  norm
	gui, add, button, xm y+28 G5GuiClose, OK
	
	gui, show
return

5GuiClose:
Gui, destroy
return

4GuiClose:
4GuiEscape:
	CancelObfuscation=1
	gui, destroy
	chooseOBFfunc()
	tooltip
exit

;---------------------------------------------
;**START CREATE TRANSLATIONS MAP FILE SECTION**
;---------------------------------------------

createTRANSMAPfilenames:
	gui, destroy
	createTRANSMAPfilenames()
return

createTRANSMAPfilenames() {	
	global
	
	gui 4:default
	gui, destroy
	gui, margin, 20, 20
	
	gui, font, %scl_basefont%  norm
	gui, add, text, xm  y+4 Vgetspacewidth, % " "
	GuiControlGet, spacewidth, Pos, getspacewidth
	
	gui, font, %scl_h1font% bold
	gui, add, text, xp yp, Create Translations Map File
	
	gui, font, %scl_h2font%  bold
	gui, add, text, xm y+16, Source Code Files
	gui, font, %scl_basefont%  norm
	gui, add, text, xm y+2, Choose the 'include map' file that contains your list `nof source code files to process OR a single AHK file to obfuscate
	
	editwidth = % "W" . (spacewidthW * 100)
	gui, add, edit, xm y+2 Vfileslistfile %editwidth% r3, % lastincludemap 
	gui, add, button, xm y+2 Gchoosesourcecodefile vchoosesourcecodefile_v, Choose file
	
	gui, font, %scl_h2font%  bold
	gui, add, text,, Obfuscator Translation Map File
	gui, font, %scl_basefont%  norm
	gui, add, text, xm y+2, Obfuscater output 'translations map' file name, may use`na path relative to the file above
	gui, add, edit, xm y+2 Voutfilename %editwidth%, % lasttransmap
	
	gui, add, button, GcreateTRANSMAP vcreateTRANSMAP_v Default, Create Translations Map
	gui, add, button, x+20 yp GchooseOBFfunc, Cancel
	
	gui, show
	
	GuiControl, Focus, createTRANSMAP_v
}

createTRANSMAP:
	gui, submit
	myfileslistfile = % fileslistfile
	myMAPfilename = % outfilename
	gui, destroy
	;make the directory of the include map file the working directory
	;so the user can use relative paths for output files
	SplitPath, myfileslistfile, , obfDir	
	SetWorkingDir, % obfDir	
	
	;save in case changed
	lastincludemap:= myfileslistfile
	lasttransmap:= myMAPfilename
	
	if (lastoutobffile_BK!="")
		lastoutobffile:=lastoutobffile_BK
	
	
	createTRANSMAP()
	;gui 10:destroy
	;TWEAKED DIGIDON : reload to make sure all var reset
	reload
	; Gosub, chooseOBFfunc

	
return

;---------------------------------------------
;**START PROCESS TRANSLATIONS MAP AND OBFUSCATE SECTION**
;---------------------------------------------

getOBFfilenames:
	gui, destroy
	getOBFfilenames()
return

getOBFfilenames() {
	global
	;ADDED DIGIDON : AUTO NAME NOCOMMENT FILE
	AutoNameObfFile_RemovesuffixLast()
	
	gui 4:default
	gui, destroy
	gui, margin, 20, 20
	
	gui, font, %scl_basefont%  norm
	gui, add, text, xm  y+4 vgetspacewidth, % " "
	GuiControlGet, spacewidth, Pos, getspacewidth
	gui, font, %scl_h1font% bold
	gui, add, text, xp yp, Create Obfuscated File
	
	removeallwhitespace = 0
	scramblefuncs 		= 0
	custdumporder		= 0	
	
	gui, font, %scl_basefont%  norm
	gui, add, checkbox, xm y+4 Vstripmywhitespace Gtogglestripwhitespace Checked%removeallwhitespace%
		, Strip all comment lines, blank lines, and tabs?
	gui, add, checkbox, xm y+2 Vrandomizefuncs Gtogglerandorder Checked%scramblefuncs%
		, Randomize order of function and label sections?
	
	gui, add, checkbox, xm y+2 Vcustorderfuncs Gtogglecustfuncorder Checked%custdumporder%
		, Use custom function and label randomization order?
	
	gui, font, %scl_h2font%  bold
	gui, add, text, xm y+8, Source Code Files
	gui, font, %scl_basefont%  norm
	gui, add, text, xm y+4, Choose the 'include map' file that contains your list `nof source code files to process OR the single AHK file to obfuscate
	editwidth = % "W" . (spacewidthW * 100)
	gui, add, edit, xm y+4 Vfileslistfile %editwidth%
		, % lastincludemap
	gui, add, button, xm y+4 Gchoosesourcecodefile, Choose file
	
	gui, font, %scl_h2font%  bold
	gui, add, text,, Obfuscator Translation Map File
	gui, font, %scl_basefont%  norm
	gui, add, text,xm y+4, Obfuscater input 'translations map' file name, may use`na path relative to the file above
	editwidth = % "W" . (spacewidthW * 100)
	gui, add, edit, xm y+4 VOBFtranscommsfile %editwidth%
		, % lasttransmap
	gui, add, button, xm y+4 GchooseOBFcommfile, Choose file
	
	gui, font, %scl_h2font%  bold
	gui, add, text,, Output Obfuscated File
	gui, font, %scl_basefont%  norm
	gui, add, text, xm y+4, Output file name for the Obfuscated file, may may use`na path relative to the first file above
	gui, add, edit, xm y+4 Vobf_outfilename %editwidth%, % lastoutobffile
	
	gui, add, button, Gobfuscatecode Default, Obfuscate Program
	gui, add, button, x+20 yp GchooseOBFfunc, Cancel
	
	gui, show	

}
togglestripwhitespace:
	GuiControlGet, removeallwhitespace,, stripmywhitespace
	;ADDED DIGIDON : AUTO NAME NOCOMMENT FILE
	GuiControlGet, obf_outfilename
	AutoNameObfFile()
return

togglerandorder:
	GuiControlGet, scramblefuncs,, randomizefuncs
	;ADDED DIGIDON : AUTO NAME OBF FILE
	GuiControl,, custorderfuncs, 0
	GuiControlGet, obf_outfilename
	AutoNameObfFile()
return

togglecustfuncorder:
	GuiControlGet, custdumporder,, custorderfuncs
	;ADDED DIGIDON : AUTO NAME OBF FILE
	GuiControl,, randomizefuncs, 0
	AutoNameObfFile()
return

;ADDED DIGIDON : AUTO NAME OBF FILE
AutoNameObfFile_RemovesuffixLast() {
global
StringReplace,lastoutobffile,lastoutobffile, % "_NC"
StringReplace,lastoutobffile,lastoutobffile, % "_RO"
StringReplace,lastoutobffile,lastoutobffile, % "_CO"
}

;ADDED DIGIDON : AUTO NAME OBF FILE
AutoNameObfFile_Removesuffix() {
global
StringReplace,obf_outfilename,obf_outfilename, % "_NC"
StringReplace,obf_outfilename,obf_outfilename, % "_RO"
StringReplace,obf_outfilename,obf_outfilename, % "_CO"
}

;ADDED DIGIDON : AUTO NAME OBF FILE
AutoNameObfFile() {
global
local newname,newname_Suffix
GuiControlGet, obf_outfilename
AutoNameObfFile_Removesuffix()
StringReplace,obf_outfilename,obf_outfilename, % ".ahk"
GuiControlGet, removeallwhitespace,, stripmywhitespace
if removeallwhitespace
	newname_Suffix := "_NC"
GuiControlGet, scramblefuncs,, randomizefuncs
if scramblefuncs
	newname_Suffix .= "_RO"
GuiControlGet, custdumporder,, custorderfuncs
if custdumporder
	newname_Suffix .= "_CO"
GuiControl,, obf_outfilename, % obf_outfilename . newname_Suffix . ".ahk"
}

chooseOBFcommfile:
	Gui +OwnDialogs 
	
	FileSelectFile, filechoosen, 35, c:\, Choose the file that contains`nyour list of source code files
	
	if (filechoosen = "")
		return
		
	GuiControl,, OBFtranscommsfile, % filechoosen
return
obfuscatecode:
	gui, submit
	myfileslistfile = % fileslistfile
	myTRANSCOMMSfile 	= % OBFtranscommsfile
	OBFUSCATEDfile 	= % obf_outfilename
	gui, destroy
	
	;make the directory of the include map file the working directory
	;so the user can use relative paths for output files
	SplitPath, myfileslistfile, , obfDir	
	SetWorkingDir, % obfDir	
	
	;save in case changed by user
	lastincludemap:= myfileslistfile
	lasttransmap:= myTRANSCOMMSfile
	;ADDED DIGIDON : AUTO NAME OBF FILE
	lastoutobffile:= OBFUSCATEDfile
	
	obfuscatecode()
	
	; Gosub, chooseOBFfunc
	;TWEAKED DIGIDON : reload to make sure all vars are reinit
	reload
return


;---------------------------------------------
;**GENERIC STUFF**
;---------------------------------------------

choosesourcecodefile:
	Gui +OwnDialogs 
	
	FileSelectFile, filechoosen, 35, , Choose the file that contains`nyour list of source code files
	
	if (filechoosen = "")
		return
	
	GuiControl,, fileslistfile, % filechoosen
	
	; SplitPath, filechoosen,, , , filechoosenBase_NameNoExt
	SplitPath, filechoosen, filechoosenBase_FileName, filechoosenBase_Dir, filechoosenBase_Ext, filechoosenBase_NameNoExt
	; SplitPath, filechoosenBase, filechoosenBase_FileName, filechoosenBase_Dir, filechoosenBase_Ext, filechoosenBase_NameNoExt
	
	;ADDED DIGIDON : AUTO NAME OBF & TRANSMAP FILE
	; msgbox filechoosenBase_NameNoExt %filechoosenBase_NameNoExt%
	if !InStr(filechoosenBase_NameNoExt, "_")
		filechoosenBase_NameNoExt.= "_"
	
	FoundPos := InStr(filechoosenBase_NameNoExt, "_", false, 0)
	filechoosenBase_NameNoExt:=SubStr(filechoosenBase_NameNoExt,1,FoundPos)
		
	; msgbox filechoosenBase_NameNoExt %filechoosenBase_NameNoExt%
	
	try
	GuiControl,, outfilename, % filechoosenBase_NameNoExt . "TransMAP.txt"
	try
	GuiControl,, OBFtranscommsfile, % filechoosenBase_NameNoExt . "TransMAP.txt"
	try
	GuiControl,, obf_outfilename, % filechoosenBase_NameNoExt . "obfuscated.ahk"
	
	lastoutobffile_BK:=filechoosenBase_NameNoExt . "obfuscated.ahk"
	
	;Added DigiDon : Automatic selection
	GuiControl,-default, choosesourcecodefile_v
	GuiControl,+default, createTRANSMAP_v
return

getlastobffiles()
{
	global
	
	;storing in windows specified place for modifiable files
	obffiles_dir:= A_AppData . "\dynamicobfuscator"
	
	IfNotExist, % obffiles_dir
		FileCreateDir, % obffiles_dir
	
	;create default values
	lastincludemap:= obffiles_dir
		. "\exampleprograms\example_1_includemap.txt"
	lasttransmap:= obffiles_dir 
		. "\exampleprograms\example_1_transMAP1.txt"
	lastoutobffile:= obffiles_dir 
		. "\exampleprograms\example_1_obfuscated.ahk"		
	
	lastobffiles_default:= lastincludemap . "`r`n"
		. lasttransmap . "`r`n"
		. lastoutobffile . "`r`n"
		
	lastobffiles_name:= obffiles_dir . "\lastobffiles.txt"
		
	if !FileExist(lastobffiles_name) 
		FileAppend, % lastobffiles_default, % lastobffiles_name

	FileRead, lastobffiles_str, % lastobffiles_name
	
	StringSplit, lastobffiles_lines, lastobffiles_str, `n, `r

	if (lastobffiles_lines0 > 2) {
		lastincludemap:= lastobffiles_lines1
		lasttransmap:= lastobffiles_lines2
		lastoutobffile:= lastobffiles_lines3
	}	
}

;called on program exit
savelastfiles:
	lastobffiles_settings:= lastincludemap . "`r`n"
		. lasttransmap . "`r`n"
		. lastoutobffile . "`r`n"
	FileDelete, % lastobffiles_name
	FileAppend, % lastobffiles_settings, % lastobffiles_name
	ExitApp 
return

startswithfragtype(obscomm)
{
	global
	
	loop, % numfragtypes
	{
		if (substr(obscomm, 1, strlen(fragtype%a_index%) + 1) = fragtype%a_index% . "_")
			return, % a_index
	}
	return, 0

}

/*	
	for vartypes of 'sysfunc', 'func' , 'label', 'globvar'
	; + vartype 'globpartialvar', 'SYSPROPERTIES', 'SYSMETHODS', 'sysvar' ?
	OBF_%vartype%_numrows
	OBF_%vartype%_%rownum%_name
	OBF_%vartype%_%rownum%_OBFname
	OBF_%vartype%_%rownum%_numfragrows
	OBF_%vartype%_%rownum%_fragsperrow
	OBF_%vartype%_%rownum%_frag_%frow%_%fcol%_varname
	OBF_%vartype%_%rownum%_frag_%frow%_%fcol%_value

	for vartype of 'funcandvar' only
	OBF_%vartype%_numrows
	OBF_%vartype%_%rownum%_name
	OBF_%vartype%_%rownum%_OBFname = no/obf
	;create after obfuscation translations data object is done creation for faster lookup
	OBF_%vartype%_%rownum%_funcrow 
	
	for vartype of 'func' and subtype of 'param' or 'LOS' only
	OBF_%vartype%_%rownum%_param_numrows
	OBF_%vartype%_%rownum%_param_%prow%_name
	OBF_%vartype%_%rownum%_param_%prow%_OBFname
	OBF_%vartype%_%rownum%_param_%prow%_numfragrows
	OBF_%vartype%_%rownum%_param_%prow%_fragsperrow
	OBF_%vartype%_%rownum%_param_%prow%_frag_%frow%_%fcol%_varname 
	OBF_%vartype%_%rownum%_param_%prow%_frag_%frow%_%fcol%_value
	OBF_%vartype%_%rownum%_LOS_numrows
	OBF_%vartype%_%rownum%_LOS_%prow%_name
	OBF_%vartype%_%rownum%_LOS_%prow%_OBFname
	OBF_%vartype%_%rownum%_LOS_%prow%_numfragrows
	OBF_%vartype%_%rownum%_LOS_%prow%_fragsperrow
	OBF_%vartype%_%rownum%_LOS_%prow%_frag_%frow%_%fcol%_varname
	OBF_%vartype%_%rownum%_LOS_%prow%_frag_%frow%_%fcol%_value
	
	;ADDED DIGIDON Classes
	for vartype of 'class'
	;DIGIDON MAYBE should these parameters be added also somewhere else like funcandvars?
	;ADDED DIGIDON IndentPos to better allow indented func declaration
	OBF_%vartype%_%rownum%_IndentPos
	
	for vartype of 'func' and subtype of 'FUNCandVAR' only
	OBF_%vartype%_%rownum%_FUNCandVAR_numrows
	OBF_%vartype%_%rownum%_FUNCandVAR_%fvrow%_name
	OBF_%vartype%_%rownum%_FUNCandVAR_%fvrow%_OBFname = no/obf
	
*/	


#Include %A_ScriptDir%/includes
#Include OBFchangedefaults.ahk
#Include OBFinit.ahk
#Include OBFutilfuncs.ahk
#Include OBFusefulfuncs.ahk
#Include OBFcreatetransMAP.ahk
#Include OBFprocesstransMAP.ahk
#Include OBFparsesource.ahk
#Include OBFobfuscate.ahk
#Include OBFrandomOBFname.ahk
#Include OBFvardumps.ahk

#Include OBFhidestr.ahk
;TWEAKED DIGIDON : You can then either replace with your own hidestr version
; #Include OBFhidestr_DIGIDON.ahk
;TWEAKED DIGIDON : OR you can optinally add your own ihidestr include, but function names should not be the same as in original though
#Include *i OBFhidestr_DIGIDON.ahk