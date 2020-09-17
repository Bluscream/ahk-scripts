#SingleInstance Force
#NoEnv

#Include <bluscream>
global window := new Window("TeaClient", "Chrome_WidgetWin_1", "TeaClient.exe")
window.process.file := new File("C:\Program Files (x86)\TeaSpeak\Client\TeaClient.exe")

servers := {"46.20.46.241": 10244,"185.194.236.158": 9170}
RunServer("212.224.121.13", 2022)
WinWait, % window.str()
Sleep, 13000
for ip, port in servers {
    RunServer(ip, port)
    sleep, 1000
}

RunServer(ip, port:=9987) {
    uri := "teaclient://" . ip . "/?port=" . port . "&connect_default=1"
    ; SplashScreen(server, "Connecting...")
    ; Run % "start """" """ . uri . """"
    _path := window.process.file.path . " " . uri
    Run, % _path, window.process.file.directory, Min, pid
}
ExitApp