^a:: ; Strg + A
; Methode 1: Send
Send, IhrTextHier
if (MsgBox, "Hat die Methode Send funktioniert?") = "Yes"
{
    MsgBox, 0x40000, "Send", % "Send, IhrTextHier"
    ExitApp
}
; Methode 2: SendInput
SendInput, IhrTextHier
if (MsgBox, "Hat die Methode SendInput funktioniert?") = "Yes"
{
    MsgBox, 0x40000, "SendInput", % "SendInput, IhrTextHier"
    ExitApp
}
; Methode 3: ControlSend
WinGet, active_id, ID, A
ControlSend,, IhrTextHier, ahk_id %active_id%
if (MsgBox, "Hat die Methode ControlSend funktioniert?") = "Yes"
{
    MsgBox, 0x40000, "ControlSend", % "ControlSend,, IhrTextHier, ahk_id %active_id%"
}
; Methode 4: SendMessage
SendMessage, 0x0102, 0, IhrTextHier,, A ; WM_SETTEXT = 0x0102
if (MsgBox, "Hat die Methode SendMessage funktioniert?") = "Yes"
{
    MsgBox, 0x40000, "SendMessage", % "SendMessage, 0x0102, 0, IhrTextHier,, A"
    ExitApp
}
; Methode 5: PostMessage
PostMessage, 0x0102, 0, IhrTextHier,, A ; WM_SETTEXT = 0x0102
if (MsgBox, "Hat die Methode PostMessage funktioniert?") = "Yes"
{
    MsgBox, 0x40000, "PostMessage", % "PostMessage, 0x0102, 0, IhrTextHier,, A"
    ExitApp
}
if not A_IsAdmin
{
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp
}
return
