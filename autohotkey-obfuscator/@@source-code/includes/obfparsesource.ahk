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

;used to parse the source code both for the translations map creation phase
;and the obfuscation phase

countlines(var) {
  loop, parse, var, `n, `r
  max:=a_index
  return max
}

parse_onefile(sourcecodefile, filenumber) {
	global processcodesection, CUR_OBFCOMM, totalsourcelines, counttotalMAPLines
	global prevpercentcountlinesprocessed,newpercentcountlinesprocessed,countlinesprocessed,countTOTALlines
	global scramblefuncs, custdumporder,GLobObf_Block,GlobObf_Comment,removeallwhitespace
	static LOFtypeBK,LOFnameBK,commentsection=0
	;write file name to window that shows 'running' info		
	GuiControl,, showscodefilename, % sourcecodefile
			
	FileRead, sourcecode, % sourcecodefile
	trimmedsourcecode =
	;look for IGNORE_BEFORE_THIS and IGNORE_AFTER_THIS tags
	Loop, parse, sourcecode, `n, `r
	{				
		if IS_OBFCOMM(A_LoopField) {
			if (CUR_OBFCOMM = "IGNORE_BEFORE_THIS") {
				showmyprocmess("found - '" . CUR_OBFCOMM . "'")
				trimmedsourcecode =
				continue					
			} else if (CUR_OBFCOMM = "IGNORE_AFTER_THIS") {
				showmyprocmess("found - '" . CUR_OBFCOMM . "'")
				break					
			}				
		}
		;build it line by line
		trimmedsourcecode .= A_LoopField . "`r`n"
	}
	
	;break into an array of lines for easier processing	
	
	if (!rowstoproc := createsourcearray(trimmedsourcecode, "includefile")) {
		showmyprocmess("**NO PROCESSABLE LINES FOUND IN FILE:`n" . sourcecodefile)
		return
	}
	
	;add into running count of lines processed
	totalsourcelines += rowstoproc	
	showmyprocmess("Source code lines to process: " . rowstoproc)
	
	codesection =
	;look for "END_AUTOEXECUTE" first if it is the first file
	if (filenumber = 1) {
		while true {
		;ADDED DIGIDON countlinesprocessed
		if (processcodesection = "OBFcodesection") {
		countlinesprocessed++
		newpercentcountlinesprocessed:=round(countlinesprocessed / countTOTALlines * 100,0)
		if (newpercentcountlinesprocessed!=prevpercentcountlinesprocessed)
			{
			prevpercentcountlinesprocessed:=newpercentcountlinesprocessed
			tooltip % newpercentcountlinesprocessed "%"
			}
		}
			curline = % nextsourceline("includefile")
			if ENDOFSOURCE("includefile") {
				; break
				msgbox,
				(LTrim
				There was an error : The ";$OBFUSCATOR: $END_AUTOEXECUTE:" command was not found in the first file listed in your include-map file.
				
				You MUST add it into your main script just after the auto-execute section ends (by a return, exit, exitapp,...)
				)
				gui,10:destroy
				chooseOBFfunc()
				exit
				}
				
			if (IS_OBFCOMM(curline) and CUR_OBFCOMM = "END_AUTOEXECUTE") 
				break
						
			codesection .= curline . "`r`n"
		}
		myheader = % ";autoexecute"
		%processcodesection%("", myheader, codesection, "autoexecute", "autoexecute")
	}
	
	;ADDED DIGIDON WRITE CURRENT FILE IN TRANSMAP
	if (processcodesection = "MAPcodesection") {
	writetoMAPfile("`n;**********************************************************`n#PROCESSING FILE: " sourcecodefile "`n;**********************************************************")
	}
					
	preLOFlines =
	
	while !ENDOFSOURCE("includefile") {
		curline = % nextsourceline("includefile")
		if ENDOFSOURCE("includefile")
			break		
		
		
		;obfuscater commands should not be outside of functions or label sections
		;unless function 'mapping'is taken place
		if (IS_OBFCOMM(curline) and processcodesection = "MAPcodesection") {
			if (CUR_OBFCOMM="START_COMMENT")
				GlobObf_Comment=1
			else if (CUR_OBFCOMM="END_COMMENT")
				GlobObf_Comment=
			passthruCOMM()
			continue
		}
		
		if (processcodesection = "MAPcodesection") {
			if (commentsection=1 and SubStr(Trim(curline), 1, 2) = "*/")
				{
				commentsection=
				if !(GlobObf_Comment)
				continue
				}
			else if (commentsection=1)
				if !(GlobObf_Comment)
				continue
			;DIGIDON MAYBE SHOULD TAKE INTO ACCOUNT COMMFLAG?
			if (SubStr(Trim(curline),1,1)=";")
				{
				if !(GlobObf_Comment)
				continue
				}
			if (SubStr(Trim(curline), 1, 2) = "/*") {
				commentsection=1
				if !(GlobObf_Comment)
				continue
			}
		}
		
		;checks whether this line starts a function definition
		;or a label section start or a conditional start. if it is then it will 'consume' the rest of
		;the function or label or condition
		
		LOFtype =
		LOFname = 
		
		if isLOFheader(curline, LOFtype, LOFname) {
			LOFheaderline = % curline
			
			LOFbodylines = % consumebodyLOF(LOFtype)
			%processcodesection%(preLOFlines, LOFheaderline, LOFbodylines, LOFtype, LOFname)
			;ADDED DIGIDON countlinesprocessed
			if (processcodesection = "OBFcodesection") {
			countlinesprocessed+=countlines(LOFbodylines)+1
			newpercentcountlinesprocessed:=round(countlinesprocessed / countTOTALlines * 100,0)
			if (newpercentcountlinesprocessed!=prevpercentcountlinesprocessed)
				{
				prevpercentcountlinesprocessed:=newpercentcountlinesprocessed
				tooltip % newpercentcountlinesprocessed "%"
				}
			}
			preLOFlines =
			;ADDED DIGIDON : BK LAST LOFtype and LOFName
			LOFtypeBK = % LOFtype
			LOFnameBK = % LOFname
		} else {
			;if there are comment lines before the label or function
			;they will be preserved
			;stores comment that are 'pre' the function header of label section start
			if preLOFlines
			preLOFlines .= "`r`n"
			preLOFlines .= curline	
			;ADDED DIGIDON countlinesprocessed
			if (processcodesection = "OBFcodesection") {
			countlinesprocessed++
			newpercentcountlinesprocessed:=round(countlinesprocessed / countTOTALlines * 100,0)
			if (newpercentcountlinesprocessed!=prevpercentcountlinesprocessed)
				{
				prevpercentcountlinesprocessed:=newpercentcountlinesprocessed
				tooltip % newpercentcountlinesprocessed "%"
				}
			}
		}
	}
	
	;DIGIDON COMMENT : END OF FILE
	
	;ADDED DIGIDON ADD REST OF FILE
	;UNCOMPLETE DIGIDON : Process REMAINING will cause errors TO BE CORRECTED
	if preLOFlines is not space 
	{
		; msgbox REMAINING lines in file after functions and others `n%preLOFlines%
				Loop, parse, preLOFlines, `n, `r
				{
					if (processcodesection = "MAPcodesection") {
						if IS_OBFCOMM(A_Loopfield) {
						;DIGIDON MAYBE SHOULD BE SWITCHED TO LINE BY LINE ABOVE
							passthruCOMM(LOFtypeBK)
						}
					}
					;DIGIDON ADDED : PROCESS SPECIAL COMMENTS when obfuscating
					findprocessOBFspecialcomms(A_Loopfield)
					
					if (processcodesection = "OBFcodesection") {
						;DIGIDON UNCOMPLETE : SHOULD DIFFER IF BLOCK SECTION
						;DIGIDON : MAYBE SHOULD TAKE INTO ACCOUNT COMMFLAG?
						if (scramblefuncs or custdumporder)
							if (Substr(trim(A_LoopField),1,1)!=";" and Substr(trim(A_LoopField),1,1)!="")
								if !GlobObf_Block
								msgbox WARNING : Non-comment line was found outside of function and at end of a file and will thus be added to last function/class/... BUT will probably lead to mistakes when scrambled if not in block section `n%A_LoopField% `nLOFtypeBK %LOFtypeBK% LOFnameBK %LOFnameBK%
					
					AA_Loopfield:=A_Loopfield
					if (removeallwhitespace) {
						removeALLCOMMENTSandWHITESPACE(AA_Loopfield)
					}
					else
						lookforCommentFlag(AA_Loopfield)
					; msgbox out of scope lines will be added to %LOFtypeBK% %LOFnameBK% : `n%preLOFlines%
					; msgbox out of scope line will be added to %LOFtypeBK% %LOFnameBK% : `n%A_Loopfield%
					if (AA_Loopfield!="")
					AddifScrambleOrWriteCode(LOFtypeBK,LOFnameBK,AA_Loopfield . "`n")
					}
				}
			preLOFlines=
	}
}

GetNestedFctLines(programlines, ByRef  LOFtype, ByRef LOFsnames) {
	foundfunc=1
	LOFsLinePos=
	LOFsnames=
	Loop, parse, programlines, `n, `r
	if RegexMatch(A_Loopfield, "mO)^\h+(\w+)\([^\r\n]*\)\s*(\{\h*(;[^\r\n]*)?$|;[^\r\n]*(\s*\{\s*|\{\h)$)",Match)
	LOFsLinePos.=A_Index . "|"
	;Apparently was so reliable. Sometimes double line numbers: is it because same are found just below in another nested method for example and then not showing up for the second in transmap?
	; while foundfunc := RegexMatch(programlines, "mO)^\h+(\w+)\([^\r\n]*\)\s*(\{\h*(;[^\r\n]*)?$|;[^\r\n]*(\s*\{\s*|\{\h)$)",Match,foundfunc) {
	; ; ADDED DIGIDON Functions
			; LOFsnames .= Match.Value(1) . "|"
			; LOFsLinePos .= Line_GetPos(programlines, List_LineFromPos(programlines,Match.Pos(1))) . "|"
			; foundfunc+=Match.Len(1)
	; }
	return LOFsLinePos
}

isLOFheader(programline, ByRef  LOFtype, ByRef LOFname, nestedlabelsonly = 0, nestedclassandfunconly = 0) {
;DIGIDON UNCOMPLETE : SHOULD TAKE INTO ACCOUNT CURRENT #COMMFLAG COMMENTFLAG
;ADDED DIGIDON nestedclassandfunconly

	;static lastime := 0
	;static lastline := 0
	;scanning for label or function header line in this code
	;ADDED DIGIDON
	static commentsection, iscontinuesect
	NestedPreDetected=
	NestedDetected=
	
	timepassed := A_TickCount - lastime
	
	;DEBUG DIGIDON
	; if InStr(programline, "Building_ChooseIconMenu")
	; msgbox programline %programline% `ncommentsection %commentsection% iscontinuesect %iscontinuesect% nestedlabelsonly %nestedlabelsonly% nestedclassandfunconly %nestedclassandfunconly%
	
	;ADDED DIGIDON : SKIP COMMENTS AND CONTINUATION SECTION DIRECTLY
	if (commentsection and foundcommentsection := Regexmatch(programline, "^[\s]*\*\/"))
			{
			LOFname =
			LOFtype = % "commentsection_end"
			commentsection=
			return, false
			}
	else if (iscontinuesect and foundcontinuationsection := Regexmatch(programline, "^[\s]*\)"))
			{
			LOFname =
			LOFtype = % "continuationsection_end"
			iscontinuesect=
			return, false
			}
	else if (iscontinuesect)
		return, false
	else if (commentsection)
		return, false
	else if (foundcommentsection := Regexmatch(programline, "^[\s]*\/\*"))
		{
		LOFname =
		LOFtype = % "commentsection_start"
		commentsection=1
		return, false
		}
	else if (foundcontinuationsection := Regexmatch(programline, "^[\s]*\(") and !Regexmatch(programline, "\)[\s]*(;.*$|$)"))
		{
		; msgbox continuation section %programline%
		LOFname =
		LOFtype = % "continuationsection_start"
		iscontinuesect=1
		return, false
		}
	else if (foundcomment := Regexmatch(programline, "^[\s]*;"))
		{
		return, false
		} 
	;ADDED DIGIDON DETECT #IF CONTEXT CONDITIONS
	else if (InStr(programline,"#IF") && foundcontextcondition := Regexmatch(programline, "i)^[\s]*(#IF|#IFWINACTIVE|#IFWINEXIST|#IFWINNOTACTIVE|#IFWINNOTEXIST)(?!\h*;)(?!\h*$)(?!$)(?!\w).*$")) 
		{
		;assume it is a valid context condition!
		
		;DISABLED ADDED DIGIDON TO SCRAMBLE #IF CONTEXT CONDITIONS
		LOFname = % programline
		LOFtype = % "contextcondition"
		return, true	
		}
	
	;TWEAKED DIGIDON : PUT IT HERE FOR ALL
	;DIGIDON MAYBE : SHOULD TAKE INTO ACCOUNT COMMFLAG?
	if (foundsemi := InStr(programline, ";")) 
		{
		beforesemi := SubStr(programline, (foundsemi - 1), 1)
		aftersemi := SubStr(programline, (foundsemi + 1), 1)
		}
	validbeforesemi := "#!^+$*<>~"
	LOFtype = % ""

	
	;TWEAKED DIGIDON NESTED HOTKEY
	if (nestedlabelsonly or nestedclassandfunconly) {
		;ADDED DIGIDON Classes
		; if foundclass
		; msgbox foundclass programline %programline%
		foundclass := RegexMatch(programline, "Oi)^\h*class\h+(\w+)\h*(\{|;)?",Match)
		; if !foundclass
		; foundclass := RegexMatch(programline, "Oi)^\h*class\h+(\w+)\h+extends\h+\w+\h*(\{|;)?",Match)
		found1colon := InStr(programline, ":")
		found2colons := InStr(programline, "::")
		
		LOFname =
		if (!found1colon and !found2colons and !foundclass)
			return, false
			
		;ADDED DIGIDON Classes
		if (foundclass)
			NestedPreDetected = % "class"
		else if (found1colon and !found2colons)
			NestedPreDetected = % "label"
		else if (!found1colon and found2colons)
			NestedPreDetected = % "hotkey"
		else if (found2colons and found2colons <= found1colon) 
			NestedPreDetected = % "hotkey"
		else if (found2colons and found2colons > found1colon)  
			NestedPreDetected = % "label"
		
		;ADDED DIGIDON Classes
		if (NestedPreDetected="class") {
			;ADDED DIGIDON exclude if after comment
			if (foundsemi and foundsemi < foundclass)
				{
				LOFname =
				NestedDetected =
				return, false
				}
			LOFname = % Match.Value(1)
			LOFtype = % "class"
		}
		else if (NestedPreDetected="hotkey" and !nestedclassandfunconly) {
			if (foundsemi and foundsemi < found2colons) {
				;a semicolon can be a valid hotkey only if certain characters are
				;found before them. if none of these characters are found
				;then assume that the double colons are part of a comment
				;and it is not a hotkey!
				
				if !InStr(validbeforesemi, beforesemi)
					NestedDetected=
				if !IsType(aftersemi,"alnum") and !IsType(aftersemi,"space")
					NestedDetected=
				else
					NestedDetected= % "hotkey"
			}
			else if (!foundsemi)
				NestedDetected= % "hotkey"
			;added digidon
			else
				NestedDetected= % "hotkey"
			
			if (NestedDetected)
				{
				LOFname = % SubStr(programline, 1, (found2colons - 1))
				if (Trim(LOFname)="")
					{
					LOFname=
					return, false
					}
				
				LOFtype = % "hotkey"
				}
			else
				return, false
				
		}
		else if (NestedPreDetected="label") {
			;get the next character
			mynextchr := SubStr(programline, found1colon + 1, 1)	
			
			;ADDED DIGIDON exclude if after comment
			if (foundsemi and foundsemi < found1colon)
				{
				LOFname =
				NestedDetected =
				return, false
				}
			
			;if the character after the ':' is a '=" then this is NOT A LABEL HEADER
			if (mynextchr = "=")
				{
				LOFname =
				NestedDetected =
				return, false
				}
				
			LOFname = % Trim(SubStr(programline, 1, (found1colon - 1)))
			
			;ADDED DIGIDON
			if (Trim(LOFname)="")
					{
					; msgbox NOT nested Label programline %programline%
					LOFname=
					return, false
					}
			; msgbox LOFname %LOFname%
			if !validfuncorlabelchars(LOFname) {
				LOFname =
				NestedDetected =
				return, false	
			}
			NestedDetected = % "label"
			;assume it is a valid label combo!
			; msgbox % "found label `nline" programline "`nnext char=" SubStr(programline, found1colon + 1, 1)
			LOFtype = % "label"
		}
		
		return, true		
	}
	
	;ADDED DIGIDON Classes
		;TO BE IMPROVED : SUB CLASSES : CLASS EXTENDS
		; foundclass := RegexMatch(programline, "Oi)^\h*class\h+(\w+)",Match)
	if (foundclass := RegexMatch(programline, "Oi)^class\h+(\w+)\h*",Match)) {
		LOFname = % Match.Value(1)
		LOFtype = % "class"
		; msgbox % "found class " LOFname
		return, true
	}
	
	;TWEAKED DIGIDON : BETTER DETECTION OF WHICH FIRST
	foundleftparen := InStr(programline, "(")
	found2colons := InStr(programline, "::")
	found1colon := InStr(programline, ":")
	MinFound:=min(0,foundleftparen,found2colons,found1colon)
	;DEBUG DIGIDON
	; if InStr(programline, "Building_ChooseIconMenu")
	; msgbox programline %programline% `nfoundleftparen %foundleftparen% found2colons %found2colons% found1colon %found1colon% MinFound %MinFound%
	
	if (MinFound=9223372036854775807)
		return, false
	
	
	if (MinFound = InStr(programline, "::")) {
		;a semicolon can be a hotkey! which complicates things!
		; msgbox programline %programline%
		after2colons:=SubStr(programline,MinFound+2,1)
		if (foundsemi and foundsemi < found2colons) {
			;a semicolon can be a valid hotkey only if certain characters are
			;found before them. if none of these characters are found
			;then assume that the double colons are part of a comment
			;and it is not a hotkey!
			; msgbox 1 programline %programline%
			if !InStr(validbeforesemi, beforesemi)
				return, false
				
			;TWEAKED DIGIDON : MODIFIED
			; if !IsType(aftersemi,"alnum") and !IsType(aftersemi,"space")
			if !IsType(after2colons,"alnum") and !IsType(after2colons,"space")
				{
				return, false
				}
		}	
		
		;assume it is a valid hotkey combo!
		LOFname = % SubStr(programline, 1, (found2colons - 1))	
		LOFtype = % "hotkey"
		return, true	
	}
	
	if (MinFound = InStr(programline, ":")) {
		;get the next character
		mynextchr := SubStr(programline, found1colon + 1, 1)					
		;if the character after the ':' is a '=" then this is NOT A LABEL HEADER
		if (mynextchr = "=")
			return, false
		;TWEAKED DIGIDON 
		if !IsType(mynextchr,"alnum") and !IsType(mynextchr,"space")
				return, false
				
		LOFname = % SubStr(programline, 1, (found1colon - 1))
		if !validfuncorlabelchars(LOFname) {
			LOFname =
			return, false	
		}
		
		; msgbox found label
		;assume it is a valid label combo!
		LOFtype = % "label"
		return, true	
	}
			
	if (MinFound = InStr(programline, "(")) {
		;assume colon is part of a comment!
			
		if (foundsemi and foundsemi < foundleftparen) 
			return, false
			
		;assume it is a valid function (if only valid chars are between pos 1 and "(") !
		LOFname = % SubStr(programline, 1, (foundleftparen - 1))
		; msgbox programline %programline%
		;DEBUG DIGIDON
		; if InStr(programline, "Building_ChooseIconMenu")
			; msgbox LOFname %LOFname%
		
		; if (LOFname="Building_ChooseIconMenu")
		; msgbox go Building_ChooseIconMenu
		if !validfuncorlabelchars(LOFname) {
			; if (LOFname="")
		; msgbox wrong
			LOFname =
			return, false	
		}
		
		; msgbox found function
		LOFtype = % "function"
		return, true	
	}
	
	return, false	
}


validfuncorlabelchars(forstr) 
{

	static varspecchars := "#_@$"
	
	loop, % strlen(forstr)
	{
		curchar = % SubStr(forstr, a_index, 1)	
					
		if curchar is alnum
			continue
			
		;allowable special characters in function and label headers
		if InStr(varspecchars, curchar) 
			continue

		return, false
	}
	
	return, true
}

consumebodyLOF(labelorfunctype)
{
	;FIND THE REST OF THE BODY OF THE FUNCTION OR LABEL
		
	funcorlabelbody = % ""
	
	while !ENDOFSOURCE("includefile") {
		curline = % nextsourceline("includefile")
		if ENDOFSOURCE("includefile")
			break
	
		funcorlabelbody .= curline . "`r`n"	
		; if (labelorfunctype = "contextcondition")
		; msgbox contextcondition curline %curline%
		;ADDED DIGIDON #IF CONDITION
		if (labelorfunctype = "contextcondition")
			{
			; LOFname =
			; LOFtype = % "commentsection_end"
			; msgbox commentsection_end found
			; commentsection=
			; return, false
			;Regex finds non case sensitive begin spaces #IF followed by ((spaces) or (;) and whatever) until end of line
			; if (foundcontextcondition := Regexmatch(curline, "i)^[\s]*#IF[\s]*?(?=(;.*|\s*)$)"))
			if (InStr(curline,"#IF") && foundcontextcondition := Regexmatch(curline, "i)^[\s]*(#IF|#IFWINACTIVE|#IFWINEXIST|#IFWINNOTACTIVE|#IFWINNOTEXIST)(\h*;.*?$|\h*?$)"))
				{
				; msgbox end curline %curline%
				; msgbox end if section curline %curline%
				break
				}
			}
		else if (labelorfunctype = "label" or labelorfunctype = "hotkey") { ;test for label section found
			;test for the end of gosub type label
			if (labelorfunctype = "hotkey" and Regexmatch(curline,"^[\s]*$"))
			break
			first6chars = % SubStr(curline, 1, 6)
			if (ucase(first6chars) = "RETURN") ;implies end of label section
				break				
		
		} else if (labelorfunctype = "function") { ;test for function section found
			;test for end of function body definition
			if (SubStr(curline, 1, 1) = "}") ;implies end of function section
				break	
					
		} else if (labelorfunctype = "class") { ;test for function section found
			;test for end of function body definition
			if (SubStr(curline, 1, 1) = "}") ;implies end of class section
				break	
					
		} else { ;ERROR
			showmyprocmess("FUNC OR LABEL FIND BODY END ERROR")
			return, % ""
		}
	}
	
	return, % funcorlabelbody

}

;DIGIDON : MAYBE CREATE SIMILAR FOR SPECIAL COMMS WHICH CAN BE ANYWHERE
IS_OBFCOMM(programline) {
	global CUR_OBFCOMM
	if SubStr(programline, 1, 13) = ";$OBFUSCATOR:" {
	; msgbox % "isobfcomm " getobfcomm(programline) "`n" programline
		return, % getobfcomm(programline)
	} else {
		CUR_OBFCOMM = % ""
		return, % false
	}
}

getobfcomm(ByRef programline)
{
	global 
	static obfcomm, endcomm
	
	;get the part after ';$OBFUSCATOR:'
	obfcomm = % SubStr(programline, 14)
	;remove spaces
	obfcomm = %obfcomm%
	
	if (SubStr(obfcomm, 1, 1) <> "$") {
		CUR_OBFCOMM = % ""
		return, % false
	}
	
	;find end of command
	if (!endcomm := instr(obfcomm, ":", CaseSensitive = false, 2)) {
		CUR_OBFCOMM = % ""
		return, % false	
	}
	CUR_OBFCOMM = % SubStr(obfcomm, 2, endcomm - 2)
	myparams = %  SubStr(obfcomm, endcomm + 1)
	;remove spaces
	myparams = %myparams%
	
	CUR_COMMPARAMS = % myparams	
	
	return, % true		
}


