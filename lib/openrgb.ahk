#Include <bluscream>
; #Include <JSON>
; #Include <AHKsock>

; global AHKSock_iSocket := 0

class OpenRGBServer {
    gui := False
    startminimized := False
    client := "" ; [IP]:[Port]
    server := False
    server_port := False
    list_devices := False
    device := False ; [0-9]
    zone := False ; [0-9]
    color := "" ; random | FFFFF,00AAFF
    mode := "" ; breathing | static
    size := 0 ; 0-N
    version := False
    profile := "" ; filename[.orp]
    save_profile := "" ; filename.orp
    i2c_tools := False
    localconfig := False
    config := ""
    nodetect := False
    noautoconnect := False
    loglevel := "" ; 0-6 | error | warning ...
    print_source := False
    verbose := False
    very_verbose := False
    autostart_check := False
    autostart_disable := False
    autostart_enable := False

    get() {
        args := ""
        if (server) args := args . " --server"
        return args
    }
}

class OpenRGB {
    bin := ""
    proc := ""
    ip := ""
    port := 0
    ; iSocket := 0

    __New(ip := "127.0.0.1", port := 6742) {
        this.bin := new File("C:\Program Files\OpenRGB\OpenRGB.exe")
        this.proc := new Process.fromFile(this.bin)
        ; OnExit, CloseAHKsock
        ; Menu, Tray, Add
        ; Menu, Tray, Add, Exit Gracefully, CloseAHKsock
        ; AHKsock_ErrorHandler("AHKsockErrors")
        ; If (i := AHKsock_Connect(ip, port, "Recv")) {
        ;     MsgBox, % "AHKsock_Connect() failed with return value = " i " and ErrorLevel = " ErrorLevel
        ;     ExitApp
        ; }
        ; AHKSock_iSocket++
        ; this.iSocket := AHKSock_iSocket
        scriptlog("Created new OpenRGB instance")
    }

    start() {
        this.proc.Start()
        scriptlog("Started OpenRGB server")
    }

    running() {
        return this.proc.exists()
    }

    load_profile(profile_path, wait := false) {
        scriptlog("Loading profile: " . profile_path)
        if (this.bin.exists()) {
            this.bin.run(wait, "", "--profile " . profile_path)
        }
    }

    color(color := "BBBBB") {
        scriptlog("Setting color: #" . color)
        if (this.bin.exists()) {
            this.bin.run(wait, "", "--color " . color)
        }
    }

    Recv(sEvent, iSocket = 0, sName = 0, sAddr = 0, sPort = 0, ByRef bData = 0, iLength = 0) {
        If (sEvent = "CONNECTED") {
            If (iSocket = -1) {
                MsgBox, % "Client - AHKsock_Connect() failed. Exiting..."
                ExitApp
            } Else MsgBox, % "Client - AHKsock_Connect() successfully connected!"
        } Else If (sEvent = "DISCONNECTED") {
            MsgBox, % "Client - The server closed the connection. Exiting..."
            ExitApp
        } Else If (sEvent = "RECEIVED") {
            MsgBox, % "Client - We received " iLength " bytes."
            MsgBox, % "Client - Data: " this.Bin2Hex(&bData, iLength)
        }
    }
    AHKsockErrors(iError, iSocket) {
        MsgBox, % "Client - Error " iError " with error code = " ErrorLevel ((iSocket <> -1) ? " on socket " iSocket : "")
    }
    Bin2Hex(addr,len) {
        Static fun, ptr 
        If (fun = "") {
            If A_IsUnicode
                If (A_PtrSize = 8)
                    h=4533c94c8bd14585c07e63458bd86690440fb60248ffc2418bc9410fb6c0c0e8043c090fb6c00f97c14180e00f66f7d96683e1076603c8410fb6c06683c1304180f8096641890a418bc90f97c166f7d94983c2046683e1076603c86683c13049ffcb6641894afe75a76645890ac366448909c3
                Else h=558B6C241085ED7E5F568B74240C578B7C24148A078AC8C0E90447BA090000003AD11BD2F7DA66F7DA0FB6C96683E2076603D16683C230668916240FB2093AD01BC9F7D966F7D96683E1070FB6D06603CA6683C13066894E0283C6044D75B433C05F6689065E5DC38B54240833C966890A5DC3
            Else h=558B6C241085ED7E45568B74240C578B7C24148A078AC8C0E9044780F9090F97C2F6DA80E20702D1240F80C2303C090F97C1F6D980E10702C880C1308816884E0183C6024D75CC5FC606005E5DC38B542408C602005DC3
            VarSetCapacity(fun, StrLen(h) // 2)
            Loop % StrLen(h) // 2
                NumPut("0x" . SubStr(h, 2 * A_Index - 1, 2), fun, A_Index - 1, "Char")
            ptr := A_PtrSize ? "Ptr" : "UInt"
            DllCall("VirtualProtect", ptr, &fun, ptr, VarSetCapacity(fun), "UInt", 0x40, "UInt*", 0)
        }
        VarSetCapacity(hex, A_IsUnicode ? 4 * len + 2 : 2 * len + 1)
        DllCall(&fun, ptr, &hex, ptr, addr, "UInt", len, "CDecl")
        VarSetCapacity(hex, -1) ; update StrLen
        Return hex
    }
}

; Return

; CloseAHKsock:
;     AHKsock_Close()
;     ExitApp


; --gui                                    Shows the GUI. GUI also appears when not passing any parameters
; --startminimized                         Starts the GUI minimized to tray. Implies --gui, even if not specified
; --client [IP]:[Port]                     Starts an SDK client on the given IP:Port (assumes port 6742 if not specified)
; --server                                 Starts the SDK's server
; --server-port                            Sets the SDK's server port. Default: 6742 (1024-65535)
; -l,  --list-devices                      Lists every compatible device with their number
; -d,  --device [0-9]                      Selects device to apply colors and/or effect to, or applies to all devices if omitted
;                                            Can be specified multiple times with different modes and colors
; -z,  --zone [0-9]                        Selects zone to apply colors and/or sizes to, or applies to all zones in device if omitted
;                                            Must be specified after specifying a device
; -c,  --color [random | FFFFF,00AAFF ...] Sets colors on each device directly if no effect is specified, and sets the effect color if an effect is specified
;                                            If there are more LEDs than colors given, the last color will be applied to the remaining LEDs
; -m,  --mode [breathing | static | ...]   Sets the mode to be applied, check --list-devices to see which modes are supported on your device
; -s,  --size [0-N]                        Sets the new size of the specified device zone.
;                                            Must be specified after specifying a zone.
;                                            If the specified size is out of range, or the zone does not offer resizing capability, the size will not be changed
; -V,  --version                           Display version and software build information
; -p,  --profile filename[.orp]            Load the profile from filename/filename.orp
; -sp, --save-profile filename.orp         Save the given settings to profile filename.orp
; --i2c-tools                              Shows the I2C/SMBus Tools page in the GUI. Implies --gui, even if not specified.
;                                            USE I2C TOOLS AT YOUR OWN RISK! Don't use this option if you don't know what you're doing!
;                                            There is a risk of bricking your motherboard, RGB controller, and RAM if you send invalid SMBus/I2C transactions.
; --localconfig                            Use the current working directory instead of the global configuration directory.
; --config path                            Use a custom path instead of the global configuration directory.
; --nodetect                               Do not try to detect hardware at startup.
; --noautoconnect                          Do not try to autoconnect to a local server at startup.
; --loglevel [0-6 | error | warning ...]   Set the log level (0: fatal to 6: trace).
; --print-source                           Print the source code file and line number for each log entry.
; -v,  --verbose                           Print log messages to stdout.
; -vv, --very-verbose                      Print debug messages and log messages to stdout.
; --autostart-check                        Check if OpenRGB starting at login is enabled.
; --autostart-disable                      Disable OpenRGB starting at login.
; --autostart-enable arguments             Enable OpenRGB to start at login. Requires arguments to give to OpenRGB at login.