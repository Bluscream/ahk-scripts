#Persistent
#SingleInstance, Force

global title := "ahk_class OperationStatusWindow ahk_exe explorer.exe"

Loop {
    WinWait, % title
    OperationStarted("File Operation") ; The window is open, so call the function
    WinWaitClose, % title
    OperationCompleted("File Operation") ; The window is closed, so call the function
    Sleep, 1000 ; Wait a second before checking again
}
return

; f1 hotkey for testing
f1::OperationCompleted("Test")

OperationStarted(title) {
    WinNotify(title . " started", title . " has started.") ; Show a Windows 11 notification
}
OperationCompleted(title) {
    WinNotify(title . " complete", title . " has finished.") ; Show a Windows 11 notification
    Sleep, 300
    SoundBeep ; Sound a beep
    Sleep, 250
    SoundBeep ; Sound a beep
    Sleep, 200
    SoundBeep ; Sound a beep
}

WinNotify(title, text) {
    ; This function uses PowerShell to show a Windows 11 notification
    ; You might need to adjust the PowerShell script according to your specific requirements
    Run, % "toast """ . title . """ """ . text . """", , Hide
    ; Run, % "powershell -Command `[Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime]; [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom, ContentType = WindowsRuntime]; $ToastXml = [Windows.Data.Xml.Dom.XmlDocument]::new(); $ToastXml.LoadXml('<toast launch=`\"app-defined-string`\" duration=`\"short`\"><visual><binding template=`\"ToastGeneric`\"><text>" . Text . "</text></binding></visual></toast>'); $Toast = [Windows.UI.Notifications.ToastNotification]::new($ToastXml); [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier().Show($Toast);", , Hide
}
