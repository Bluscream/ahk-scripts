#Include <bluscream>
#Include <asf>
#SingleInstance, Force
#Warn

_asf := new ASF()
txt := [ _asf.getBotByNickname("blu").data.botname]
; txt.Push(_asf.getBotByNickname("red").data.botname)
; txt.Push(_asf.getBotById(76561198022446661).cfg.password)
; txt.Push(_asf.getBotById(76561198022446661).get2FACode())
; txt.Push(_asf.customCommand("playnite_licensedates"))
; txt.Push(_asf.customCommand("addlicense asf 486740"))
txt.Push(toJson(_asf.addLicense([1, 486740])))
txt.Push(toJson(_asf.addLicense(486740)))
MsgBox % "`n".join(txt) 
ExitApp
MsgBox % toJson(asf.get2FACode())
MsgBox % asf.get2FACode(asf.logins.accounts[1].botname)
MsgBox % toJson(asf.getRedeemedKeys())
MsgBox % toJson(asf.getRedeemedKeysRaw())

Return

void=
(
run, Notepad.exe,,, notePadPID
WinWait, ahk_pid %notepadPID%
WinActivate, ahk_pid %notepadPID%
paste("`n".join(GuessSteamKey("1?B2C-D3FGH-456I?")))
ExitApp
Get2FACodes() {

}
)