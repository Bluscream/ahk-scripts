#SingleInstance, Force
;refer to the readme in the same directory as this for
;information on this file

myfalse = 0
mytrue = 1

unobfuscated_1:= "hello world, autohotkey rocks"

;first try a simple test and see how it can handle that
;the statement below will have obfuscated literal text
;in the 'OUTPUT_ahkprogram_with_hidestr.ahk' program
decoded_1:= decode_ihidestr("dcac9342d282c39e33e252d3921292d3f3a2ae5ee252c382139e925262e222")

unobfuscated_2:= "`a```t`ts`n `%`,""hello`n`tworld"""

;now i'll try one with all kinds of special characters in the
;string to give it a TORTURE TEST
;the statement below will have obfuscated literal text
;in the 'OUTPUT_ahkprogram_with_hidestr.ahk' program
decoded_2:= decode_ihidestr("7914563b9adf7b0fcb505aff5a0f1adfaa9f763b161fa61f56ff5a409b1f9b1f5a1f6a1f")

msgbox, THESE 2 SHOULD BE THE SAME:`n`nunobfuscated_1: %unobfuscated_1%`n`ndecoded_1: %decoded_1%`n`nSPECIAL CHARACTER TORTURE TEST`nTHESE 2 SHOULD BE THE SAME:`n`nunobfuscated_2: %unobfuscated_2%`n`ndecoded_2: %decoded_2%

;return from autoexecute section 
return 


;******************************************
;	!! IN YOUR ACTUAL FILES YOU MUST DELETE THIS COMMENT SECTION !!!
;	PUT THESE FUNCTIONS IN YOUR ACTUAL AUTOHOTKEY SCRIPT FILE
;FOR MORE SECURITY DO NOT LEAVE COMMENTS DIRECLTY IN YOUR CODE !
;SO THAT NOBODY CAN LOOK FOR THEM DIRECTLY EVEN IF YOU DO NOT USE THE STIP COMMENT FUNCTIONALITY
;COMMENTS EXPLAINING HOW THE ENCODING/DECODING WORKS AND HOW IT CAN BE MODIFIED ARE IN
;		ORIGINAL OBFhidestr - Commented.ahk ----> HAVE A LOOK !
;******************************************

ihidestr(thisstr)
{
	return thisstr
}


decode_ihidestr(startstr) 
{
	global	
;$OBFUSCATOR: $DEFGLOBVARS: hexdigits
	
	static newstr, startstrlen, charnum, hinibble, lownibble, mybinary
;$OBFUSCATOR: $DEFLOSVARS: newstr, startstrlen, charnum, hinibble, lownibble, mybinary

	hexdigits = % "0123456789abcdef"
		
	decode_hexshiftkeys(startstr)
	
	startstr = % substr(startstr, 1, 1) . substr(startstr, 6)
	startstrlen = % strlen(startstr)
		
	newstr = 
	loop, % strlen(startstr) 
		newstr = % substr(startstr, a_index, 1) . newstr
	
	startstr = % newstr
	newstr = 
	charnum = 1
	while true
	{
		if (charnum >startstrlen)
			break
			
		hinibble = % substr(startstr, charnum, 1)
		hinibble = % instr(hexdigits, hinibble) - 1
		
		lownibble = % substr(startstr, charnum + 1, 1)
		lownibble = % instr(hexdigits, lownibble) - 1
		
		hinibble := decode_shifthexdigit(hinibble)
		lownibble := decode_shifthexdigit(lownibble)
		
		mybinary = % hinibble * 16 + lownibble
		newstr .= chr(mybinary)
		
		charnum += 2		
	}
		
	newstr = % fixescapes(newstr)
		
	return, newstr	
}
decode_hexshiftkeys(startstr)
{
	global
;$OBFUSCATOR: $DEFGLOBVARS: decodekey, ishexchar, useshiftkey
	
	decodekey := "fff@kkf1ffkfkfkfff#k1fk@kf#@fffk@#kk"
	ishexchar := "fff@f1ff@kffkk#f1fffffkf"
	
	%decodekey%%ishexchar%1 = % substr(startstr, 2, 1)
	%decodekey%%ishexchar%2 = % substr(startstr, 3, 1)
	%decodekey%%ishexchar%3 = % substr(startstr, 4, 1)
	%decodekey%%ishexchar%4 = % substr(startstr, 5, 1)
	
	loop, 4
		%decodekey%%a_index% = % instr(hexdigits, %decodekey%%ishexchar%%a_index%) - 1
			
	useshiftkey = 0
}	

decode_shifthexdigit(hexvalue)
{
	global
	
	useshiftkey++
	if (useshiftkey > 4)
		useshiftkey = 1	
	
	hexvalue -= %decodekey%%useshiftkey%
	
	if (hexvalue < 0) 
		hexvalue += 16
		
	return hexvalue	
}

fixescapes(forstr)
{
	global
	
	StringReplace, forstr, forstr, % "````", % "``", all
	StringReplace, forstr, forstr, % "``n", % "`n", all
	StringReplace, forstr, forstr, % "``r", % "`r", all
	StringReplace, forstr, forstr, % "``,", % "`,", all
	StringReplace, forstr, forstr, % "``%", % "`%", all	
	StringReplace, forstr, forstr, % "``;", % "`;", all	
	StringReplace, forstr, forstr, % "``t", % "`t", all
	StringReplace, forstr, forstr, % "``b", % "`b", all
	StringReplace, forstr, forstr, % "``v", % "`v", all
	StringReplace, forstr, forstr, % "``a", % "`a", all
	
	StringReplace, forstr, forstr, % """""", % """", all
	
	return forstr
}
