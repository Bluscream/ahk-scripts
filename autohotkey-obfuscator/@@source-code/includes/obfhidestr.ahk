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

;created hidestr for public open source project!
encode_hidestr(startstr)
{
	global
	static onechar, newstr, secstartstr, hexdigits 
	
	hexdigits = 0123456789abcdef

	createhexshiftkeys()
		
	newstr = 
	;convert to hexidecimal
	loop, % strlen(startstr)
	{
		strascii = % asc(substr(startstr, a_index, 1))
		hinibble = % strascii // 16
		lownibble = % strascii - (hinibble * 16)
		
		;shift the hex digits in order to encrypt them
		hinibble := encode_shifthexdigit(hinibble)
		lownibble := encode_shifthexdigit(lownibble)
		
		newstr .= substr(hexdigits, hinibble + 1, 1) . substr(hexdigits, lownibble + 1, 1)
	}
	
	startstr := newstr
	;now i'll reverse the hex string
	newstr = 
	loop, % strlen(startstr) 
		newstr = % substr(startstr, a_index, 1) . newstr
	
	;convert key values to hex values. i can convert directly to
	;single hex digits because my keys only range from 1-15
	allhexkeys =
	loop, 4
		allhexkeys .=  substr(hexdigits, key%a_index% + 1, 1)
	
	;stuff the key values into the string starting at character 2
	newstr := substr(newstr, 1, 1) . allhexkeys . substr(newstr, 2)
	
	return, newstr
}

encode_shifthexdigit(hexvalue)
{
	global
	
	;each time i enter this routine i will use the next key value
	;to shift the hexvalue
	useshiftkey++
	if (useshiftkey > 4)
		useshiftkey = 1	
	
	;add the shift key to the hexvalue 
	hexvalue += key%useshiftkey%
	
	;if i go over, just substract 16 to simulate a circle of hex
	if (hexvalue > 15) 
		hexvalue -= 16
		
	return hexvalue
	
}

createhexshiftkeys()
{
	global
	
	;create random 4 entry 'encrypt' key, each entry can be 1-15
	loop, 4
		random, key%a_index%, 1, 15
		
	useshiftkey = 0
}

;******************************************
;	PUT THESE FUNCTIONS IN YOUR ACTUAL AUTOHOTKEY SCRIPT FILE

hidestr(thisstr)
{
	return thisstr
}


decode_hidestr(startstr) 
{
	global	
;$OBFUSCATOR: $DEFGLOBVARS: hexdigits
	critical
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
	loop
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


