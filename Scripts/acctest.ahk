#SingleInstance, force
#Include <bluscream>
EnforceAdmin() 
global noui := false
#INCLUDE <Acc>
global mytitle := new Window("SteamVR Status", "Qt5QWindowIcon", "vrmonitor.exe").str()
scriptlog(mytitle)
loops := 5
Loop, %loops% {
    i := A_Index-1
    printName(i, mytitle)
    Loop, %loops/2% {
        ii := i "." . A_Index-1
        printName(ii, mytitle)
        Loop, %loops/3% {
            iii := ii "." . A_Index-1
            printName(iii, mytitle)
            Loop, %loops/4% {
                iiii := iii "." . A_Index-1
                printName(iiii, mytitle)
            }
        }
    }
}
return
printName(index, mytitle) {
    name := Acc_Get("Name", index, 0, mytitle)
    if (name != "") {
        role := Acc_Get("Role", index, 0, mytitle)
        scriptlog(index . " | name: " . name . " | role: " . role . " | error: " . ErrorLevel . " | title: " . mytitle)
    }
}