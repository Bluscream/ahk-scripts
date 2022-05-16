GetPowerProfileName() {
    if (DllCall("powrprof\PowerGetActiveScheme", "Ptr", 0, "Ptr*", pguid) == 0) {
        VarSetCapacity(desc, (szdesc := 256) + 2)
        if (DllCall("powrprof\PowerReadFriendlyName", "Ptr", 0, "Ptr", pguid, "Ptr", 0, "Ptr", 0, "Ptr", &desc, "UInt*", szdesc) == 0, DllCall("LocalFree", "Ptr", pguid, "Ptr")) {
            activeProfileName := StrGet(&desc, "UTF-16")
            return activeProfileName
        }
    }
}