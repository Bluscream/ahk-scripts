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

randomOBFname(sizemin, sizemax)
{
	global
	
	;the underline is not used in creation of obfuscated names
	;but is included here because this variable is used in the testing of 
	;whether a substring match has allowable variable characters before or after it
	;in which case the match would be evaluated as INVALID
	;TWEAKED DIGIDON ?[] are not authorized so are deleted
	oddvarnameallowedchars = #@$_ 
	; oddvarnameallowedchars = #@$?[]_   
	
	; full list of autohotkey allowable chars for varnames and func names
	; # _ @ $
	; "##########$$$$$$$$$$
	
	; full list of autohotkey allowable chars for varnames and func names
	; # _ @ $ ? [ ]
	; "##########$$$$$$$$$$[[[[[[[[[[]]]]]]]]]]
	
makeobfstarttime = % A_TickCount
	
	;replaceoddchars = % "fk@#"
	
	;DISABLED DIGIDON : 3 below statics SEEMS NOT TO BE USED
	; static obfSTARTchars := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
	; static obfchars 	:= "######@@@@@@$$$$$$######@@@@@@$$$$$$ABCDEFGHIJKLMNOPQRSTUVWXYZ012345678901234567890123456789"
	static numrandstartchars, numrandobfchars
	
	;DIGIDON : TWEAKED CHAR STRINGS MODIFIED SO CHARACTERS SETS ARE INCREASED
	static charset1 := "fk", charset2 := "kf", charset3 := "ff", charset4 := "kk", charset5 := "f@" 
	static charset6 := "@f", charset7 := "k@", charset8 := "@k", charset9 := "f#", charset10 := "#f"
	static charset11 := "k#", charset12 := "#k" 
	; static charset13 := "f$", charset14 := "$f"
	; static charset1 := "fk", charset2 := "kf", charset3 := "ff", charset4 := "f@", charset5 := "k#" 
	; static charset6 := "kk", charset7 := "f$", charset8 := "cu", charset9 := "cc", charset10 := "aa"
	; static charset6 := "f?", charset7 := "f]", charset8 := "cu", charset9 := "cc", charset10 := "aa"
	
	;DIGIDON : TWEAKED NUMBER MODIFIED SO CHARACTERS SET ARE INCREASED
	; static numcharsets = 5
	static numcharsets = 12
	
	;DISABLED DIGIDON : 2 below statics SEEMS NOT TO BE USED
	; numrandstartchars 	= % strlen(obfSTARTchars)
	; numrandobfchars 	= % strlen(obfchars)
	
	;TWEAKED DIGIDON : MOVED BELOW SO THAT LENGTH CAN VARY
	; Random, makelength, % sizemin, % sizemax
	while true {
		OBFstr = 
		Random, makelength, % sizemin, % sizemax
		while strlen(OBFstr) < makelength {
			Random, randcharset, 1, % numcharsets
			OBFstr .= charset%randcharset%
		}
		if find_messedupname(OBFstr) {
			numalreadyused++
			continue		
		} 
		add_messedupname(OBFstr)
		messedupnames_recs++
		;messedupnames_%messedupnames_recs% = % OBFstr
		makeobftime += A_TickCount - makeobfstarttime
		return, % OBFstr		
	}
}