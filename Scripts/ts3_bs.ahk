#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%
#Include <bluscream>
window := new Window("TeamSpeak 3", "Qt5QWindowIcon", "ts3client_win64.exe")
binary := new File("C:\Program Files\TeamSpeak 3 Client\ts3client_win64.exe")

servers := []
servers.Push("ts3server://Ufta-gaming.teamspeak.me?password=Baumhaus&channel=~%20AFK%20~")
servers.Push("ts3server://wwb?password=1012&channel=Anderer%20Teamspeak")
servers.Push("ts3server://pflegef%C3%A4lle?password=gold1234&channel=%5Bcspacer4%5D%20%E2%96%81%20%E2%96%82%20%E2%96%83%20AFK-Lounge%20%E2%96%83%20%E2%96%82%20_%2F%E2%95%A0%E2%95%90%E2%96%BA%20Lang%20%28%3E%2030%20Min%29")
servers.Push("ts3server://tsw?password=tsw2018&channel=%5Bcspacer0%5D%E2%80%A2%E2%97%8F%E2%97%8F%20Away%20from%20Keybord%20%E2%97%8F%E2%97%8F%E2%80%A2%2FL%C3%A4nger%20AFK%20%28%3E%2010%20Min.%29")
servers.Push("ts3server://ts3-voice.de?port=9048&password=gold1234&channel=%5Blspacer%5DAnderer%20Ts3")
servers.Push("ts3server://173.212.248.123?channel=%5B%E2%99%A6cspacer%5D%E2%95%9A%E2%95%90%E2%95%90%E2%95%90%E2%AB%B8%20%20Lang%20Weg%20%E2%9C%88")
servers.Push("ts3server://ts3.destroyerclangermany.de?port=9170&channel=%5BlspacerM3%5D%E2%95%94%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%96%8C%20%20%20AFK%20%20%E2%96%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%90%E2%95%97")

if (!window.exists()) {
    binary.run()
    WinWait, % window.str()
}
if (!window.isActive()) {
    window.activate(true)
}
sleep, 1000
for i, v in servers {
    Run, % v
    sleep, 500
}