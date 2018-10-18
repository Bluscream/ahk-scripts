#SingleInstance force

DisabledKeys := ["^d", "^w", "^q"]
#IfWinActive, TeamSpeak 3
Loop % DisabledKeys.MaxIndex()
    Hotkey, % DisabledKeys[A_Index], DoNothing
#IfWinActive
Return ; end of autoexec section

DoNothing:
Return