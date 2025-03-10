; region HELPERS
EndsWith(haystack, needle) {
    return SubStr(haystack, -StrLen(needle) + 1) = needle
}
A_Args_Contains(val) {
    for _, param in A_Args {
        if (param = val)
            return true
    }
    return false
}
StrJoin(arr, delim) {
    str := ""
    for i, v in arr
        str .= (i=1 ? "" : delim) v
    return str
}
; endregion HELPERS

class PowerProfile {
    id := ""
    name := "Unknown"
    description := "Unknown Power Plan"
    icon := A_WinDir . "\System32\SHELL32.dll,235"
    
    static RegKey = "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes"

    __New(id := "", name := "", description := "", icon := "") {
        this.id := id
        this.name := name 
        this.description := description
        this.icon := icon
    }

    SetActive() {
        if (this.id) {
            RunWait, % "powercfg.exe /s " . this.id,, Hide
            return true
        }
        return false
    }

    IsActive() {
        RegRead, active, % this.RegKey, ActivePowerScheme
        ; OutputDebug, % "Checking if profile is active: " . this.id . " = " . active
        return (active = this.id)
    }

    GetIcon() {
        if (InStr(this.icon, ",")) {
            return StrSplit(this.icon, ",")
        }
        return [this.icon]
    }
}

class PowerProfiles {
    static profiles := {}
    RegKeys := ["HKLM\SYSTEM\CurrentControlSet\Control\Power\User\PowerSchemes"] ; "HKLM\SYSTEM\CurrentControlSet\Control\Power\User\Default\PowerSchemes"
    Ignored := ["e9a42b02-d5df-448d-aa00-03f14749eb61"]
    
    __New() {
        this.load()
    }

    Load() {
        this.profiles := {}
        for _, RegKey in this.RegKeys {
            this.LoadFromRegistry(RegKey)
        }
    }
    
    LoadFromRegistry(RegKey) {
        OutputDebug, % "Loading power profiles from " . RegKey
        
        Loop, Reg, % RegKey, K
        {
            id := A_LoopRegName
            key := RegKey . "\" . id
            
            RegRead, name, % key, FriendlyName
            if (Endswith(name, "Overlay") || this.Ignored[id]) {
                Continue
            }
            
            RegRead, description, % key, Description
            
            if (!ErrorLevel && RegExMatch(name, "^[^\x00-\x1F\x7F]+$")) {
                if (InStr(name, ",")) {
                    split := StrSplit(name, ",")
                    icon := RegExReplace(split[1], "^@", "") . "," . (split[2] + 0)
                    icon := StrReplace(icon, "%SystemRoot%", A_WinDir)
                    name := split[3]
                }
                if (InStr(description, ",")) {
                    description := StrSplit(description, ",")[3]
                }
                
            } else {
                RunWait, % "powercfg /n " id,, Hide
                name := A_LoopRegName
            }
            
            this.profiles[id] := new PowerProfile(id, name, description, icon)

            OutputDebug, % "Found profile: " . name . " (" . id . ")"
        }
    }
    
    GetActive() {
        RegRead, active, % this.RegKey, ActivePowerScheme
        return this.profiles[active]
    }
    
    GetByID(id) {
        return this.profiles[id]
    }
    
    GetByName(name) {
        for id, profile in this.profiles {
            if (profile.name = name)
                return profile
        }
        return false
    }
}