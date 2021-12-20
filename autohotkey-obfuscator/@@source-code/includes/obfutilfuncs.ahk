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


FIND_VARROW(OBFvarlistpath, varname) {
	global
	static foundatrow
	foundatrow = 0
	; if (OBFvarlistpath="OBF_CONTEXTCONDITION")
	; msgbox % "_numrows " %OBFvarlistpath%_numrows
	loop, % %OBFvarlistpath%_numrows
		{
		; if (OBFvarlistpath="OBF_CONTEXTCONDITION")
		; msgbox % "name `n" %OBFvarlistpath%_%a_index%_name "`n`nvarname `n" varname
		; if (OBFvarlistpath="OBF_LABEL")
		; msgbox % "name `n" %OBFvarlistpath%_%a_index%_name "`n`nvarname `n" varname
			if (%OBFvarlistpath%_%a_index%_name = varname)
				return, % a_index	
		}
	
; if (OBFvarlistpath="OBF_LABEL")	
	; loop, % %OBFvarlistpath%_numrows
		; {
		; msgbox % "name `n" %OBFvarlistpath%_%a_index%_name "`n`nvarname `n" varname
		; }
	return, % foundatrow
}

createsourcearray(ByRef sourcecode, nameit) {
	global
	
	StringSplit, %nameit%sourcecodeline, sourcecode, `n, `r
	
	%nameit%sourcecodelinenum = 0

	;return the size of the array created
	return, % %nameit%sourcecodeline0	
}

nextsourceline(forname) {
	global
	
	linenum = % ++%forname%sourcecodelinenum	
	if (linenum > %forname%sourcecodeline0) 
		return, % ""
		
	return, % %forname%sourcecodeline%linenum%
}

ENDOFSOURCE(forname) {
	global
	
	if (%forname%sourcecodelinenum > %forname%sourcecodeline0) 
		return, % true
	else
		return, % false
}

getlinebefore(forname) {
	global
	
	prevlinenum = % %forname%sourcecodelinenum - 1
	if (prevlinenum < 1) 
		return, % ""
		
	return, % %forname%sourcecodeline%prevlinenum%
}

getlineafter(forname) {
	global
	
	nextlinenum = % %forname%sourcecodelinenum + 1
	if (nextlinenum > %forname%sourcecodeline0) 
		return, % ""
		
	return, % %forname%sourcecodeline%nextlinenum%
}