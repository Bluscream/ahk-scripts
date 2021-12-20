/* (COMMENTS ADDED BY DIGIDON)

HOW THIS HIDE STRING FUNCTIONALITY WORKS AND HOW CAN IT BE MODIFIED?

Basically these encode functions will convert the desired string at time of obfuscation into an hidden string.
The hidden string will be >2 times longer than original string.
It will be decode by the decode functions at runtime so that the real values will be correctly used or displayed.

Technically this uses a variant of the Vigenere cipher (have a look on internet).
TO ENCODE:
It converts each character of a desired string into its ascii number and then into 2 positions in a new alphabet by using modulo and rest of the alphabet length.
Then it shifts the positions by some random numbers, which together are called the random key.
The string can have some transformation done (moving some parts arounds).
This random key is stuffed into the new string at a specific position.
TO DECODE:
It grabs the stuffed random key at the specific position.
It reverts the transformation done (moving some parts arounds) to the string.
It gets 2 positions by 2 positions shifting them using the random numbers.
It grabs back the ascii number and convert it into actual characters.
Finally it renders back the decoded string.


YOU CAN AND YOU SHOULD MODIFY and/or create new encode/decode functions so that they will be harder to locate and decrypt.
I HAVE ADDED MANY COMMENTS IN THE BELOW SCRPIT so that it will be easier to understand/modify.

SOME PRECAUTIONS FOR MODIFICATION AND USE :
! DO NOT FORGET TO APPLY THE CHANGES BOTH TO THE ENCODE AND DECODE FUNCTIONS !
! DO NOT FORGET TO NOT LEAVE ANY COMMENT IN YOUR TWEAKED OBFhidestr.ahk file !
! DO NOT FORGET TO COPY THE DECODE FUNCTIONS AND THE DUMMY IHIDESTR FUNCTION TO YOUR ACTUAL SCRIPT !
! DO NOT COPY THE ENCODE FUNCTIONS TO YOUR ACTUAL SCRIPT !

SOME IDEAS OF MODIFICATIONS:

Change decodekey and ishexchar string values : put some fk#@ and 1 or 2, 1's in it

Try not to use the exact same style of coding here: 
--Rewrite the functions differently and split functions differently.

Try to have as much obfuscated as you can:
-Replace standard commands and operators by new functions : the "//" by a floor_divide function random by a randomize() fct etc. so that their calls will be obfuscated.
-Obfuscate standard autohotkey functions such as chr() and asc().
-Ofuscate any new variable you will use in these functions.
-Replace numbers by obfuscated variables that contain the numbers!

Try to modify the encode/decode procedure:
--You can modify the alphabet it is converting the string to, namely hedxdigits: You can modify and add (must be lenght of 15 min) some letters but modify the lenght numbers used in the code accordingly (15 and 16 to StrLen and StrLen+1)
--Instead of reversing the string you can split it, turn some blocks around etc.
--You can modify the current 4 digits key hidden at pos 2 to be longer or length variable and not hidden in the same position. Be carefull that several parts will have to be changed accordingly : the 4 to key length , and parts at ";grab encoded data" // ";stuff the key values", the %decodekey%%ishexchar%s variable number in decode_hexshiftkeys(startstr) need to be adjusted to the new number.
*/

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

;created ihidestr for public open source project!
encode_ihidestr(startstr)
{
	global
	static onechar, newstr, secstartstr, hexdigits 
	
	;This is the alphabet that will be used to encode the string. It must be >15 in length because 16*16=256 which is >Ascii (255 chars)
	hexdigits = 0123456789abcdef

	createhexshiftkeys()
		
	newstr = 
	;convert to hexidecimal
	
	;for each char
	loop, % strlen(startstr)
	{
		;convert each character into an ascii number
		strascii = % asc(substr(startstr, a_index, 1))
		;get 2 unique values made of the hexdigits alphabet that hide the values and will allow to get back the ascii value later
		;hinibble = modulo of length
		hinibble = % strascii // 16
		;lownibble = rest of the division
		lownibble = % strascii - (hinibble * 16)
		
		;shift the hex digits by the random key in order to encrypt them
		hinibble := encode_shifthexdigit(hinibble)
		lownibble := encode_shifthexdigit(lownibble)
		
		;we then add the 2 generated nibbles in the new string
		newstr .= substr(hexdigits, hinibble + 1, 1) . substr(hexdigits, lownibble + 1, 1)
		
		;and we continue for the next character
	}
	
	startstr := newstr
	;now i'll reverse the hex string
	newstr = 
	loop, % strlen(startstr) 
		newstr = % substr(startstr, a_index, 1) . newstr
	
	;convert key value to hex values. i can convert directly to
	;single hex digits because my keys only range from 1-15
	allhexkeys =
	loop, 4
		allhexkeys .=  substr(hexdigits, key%a_index% + 1, 1)
	
	;stuff the random key value into the string starting at character 2
	newstr := substr(newstr, 1, 1) . allhexkeys . substr(newstr, 2)
	
	return, newstr
}

encode_shifthexdigit(hexvalue)
{
	global
	
	;each time i enter this routine i will use the next key value
	;to shift the hexvalue
	;the random key is 4 digits long in this case
	useshiftkey++
	if (useshiftkey > 4)
		useshiftkey = 1	
	
	;add the shift key to the hexvalue 
	hexvalue += key%useshiftkey%
	
	;if i go over the alphabet length-1, just substract 16 to simulate a circle of hex
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

;put this function in your source code and then surround the literal ;strings you wish to be obfuscated with it
ihidestr(thisstr)
{
	return thisstr
}

;put this function in your source code. it will actually be called
;by the obfuscated code to 'decode' the obfuscated strings.
;this function and all calls to it will also be obfuscated in
;the output obfuscated program
decode_ihidestr(startstr) 
{
	global	
;$OBFUSCATOR: $DEFGLOBVARS: hexdigits
	
	static newstr, startstrlen, charnum, hinibble, lownibble, mybinary
;$OBFUSCATOR: $DEFLOSVARS: newstr, startstrlen, charnum, hinibble, lownibble, mybinary

	hexdigits = % "0123456789abcdef"
		
	;will get the encoded key hidden in the obfuscated literal string
	decode_hexshiftkeys(startstr)
	
	;grab encoded data : all without the random key : 1st char and from 6th char
	startstr = % substr(startstr, 1, 1) . substr(startstr, 6)
	startstrlen = % strlen(startstr)
		
	newstr = 
	;reverse the hex string
	loop, % strlen(startstr) 
		newstr = % substr(startstr, a_index, 1) . newstr
	
	startstr = % newstr
	newstr = 
	charnum = 1
	;convert from hexidecimal to binary	
	while true
	{
		if (charnum > startstrlen)
			break
		
		;take the two next chars separately : hinibble and then lownibble
		
		;first hinibble
		hinibble = % substr(startstr, charnum, 1)
		;find it in hexdigits and convert to decimal number
		hinibble = % instr(hexdigits, hinibble) - 1
		
		;then lownibble
		lownibble = % substr(startstr, charnum + 1, 1)
		;find it in hexdigits and convert to decimal number
		lownibble = % instr(hexdigits, lownibble) - 1
		
		;unshift the hex
		hinibble := decode_shifthexdigit(hinibble)
		lownibble := decode_shifthexdigit(lownibble)
		
		;get back the ascii number
		mybinary = % hinibble * 16 + lownibble
		;convert back to actual character
		newstr .= chr(mybinary)
		
		;we move 2 chars to the right
		charnum += 2		
	}
		
	newstr = % fixescapes(newstr)
		
	return, newstr	
}

decode_hexshiftkeys(startstr)
{
	global
;$OBFUSCATOR: $DEFGLOBVARS: decodekey, ishexchar, useshiftkey
	
	;these have '1's in them so that they will not corresponds to any actual obfuscated variable but will still ressemble them
	decodekey := "fff@kkf1ffkfkfkfff#k1fk@kf#@fffk@#kk"
	ishexchar := "fff@f1ff@kffkk#f1fffffkf"
	
	;grab randomly created encrypt key
	;i hid it in the obfuscated literal string, 2 characters in
	%decodekey%%ishexchar%1 = % substr(startstr, 2, 1)
	%decodekey%%ishexchar%2 = % substr(startstr, 3, 1)
	%decodekey%%ishexchar%3 = % substr(startstr, 4, 1)
	%decodekey%%ishexchar%4 = % substr(startstr, 5, 1)
	
	;convert key values to actual numbers
	loop, 4
		%decodekey%%a_index% = % instr(hexdigits, %decodekey%%ishexchar%%a_index%) - 1
			
	useshiftkey = 0
}	

decode_shifthexdigit(hexvalue)
{
	global
	
	;each time i enter this routine i will use the next key value
	;to shift the hexvalue
	useshiftkey++
	if (useshiftkey > 4)
		useshiftkey = 1	
	
	;subtract the shift key from the hexvalue 
	hexvalue -= %decodekey%%useshiftkey%
	
	;if i go under zero, just add 16
	if (hexvalue < 0) 
		hexvalue += 16
		
	return hexvalue	
}

;we eschape any needed character so there will be no ahk misinterpretation
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


