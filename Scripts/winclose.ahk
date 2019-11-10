#Include <bluscream>
; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-winclose-ahk
; Big thanks to Dinenon#8239
#SingleInstance, Force
; #NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
SetTitleMatchMode, 2
CoordMode, Mouse, Client
;<=====  Set up our arrays  ===================================================>
titles := []
; titles.push({title: "DF ahk_class #32770 ahk_exe df.exe", text: "", action: "CloseWindow"}
; titles.push({title: "ConEmu [64] ahk_class #32770 ahk_exe ConEmu64.exe", text: "", action: "ClickButton:&Ignore"}
titles.push({title: "ahk_class ClassAdvert",        text: "",   action: "CloseWindow"})
titles.push({title: "ahk_class MainFrameInstall",   text: "",   action: "CloseWindow"})
titles.push({title: "ahk_class RarReminder",        text: "",   action: "CloseWindow"})
titles.push({title: "ahk_exe airdroid.exe",         text: "",   action: "CloseWindow"})
titles.push({title: "ahk_exe error_report.exe",     text: "",   action: "CloseWindow"})
titles.push({title: "ahk_exe setup_clvupdsp.exe",   text: "",   action: "CloseWindow"})
titles.push({title: "ahk_exe wefault.exe",          text: "",   action: "CloseWindow"})
titles.push({title: "ahk_exe wermgr.exe",           text: "",   action: "CloseWindow"})
titles.push({title: "ahk_exe vsjitdebugger.exe",    text: "",   action: "CloseWindow"})
titles.push({title: "Untrusted Server's Certificate",text: "",  action: "CloseWindow"})
titles.push({title: "Real Desktop 2.0 - Angebote",  text: "",   action: "CloseWindow"})
titles.push({title: "Purchase now",                 text: "",   action: "CloseWindow"})
titles.push({title: "Contribute to NetSpeedMonitor",text: "",   action: "CloseWindow"})
titles.push({title: "Please restart app",           text: "",   action: "CloseWindow"})
titles.push({title: "Proxy Authentication",         text: "",   action: "CloseWindow"})
titles.push({title: "",                             text: "Error OnTimer", action: "CloseWindow"})
titles.push({title: "",                             text: "Assertion: ConEmu ", action: "ClickButton:&Ignore"})
titles.push({title: "",                             text: "Error on init, details in Debug.txt", action: "CloseWindow"})
titles.push({title: "",                             text: "DragDrop registration did not succeed.", action: "CloseWindow"})
titles.push({title: "",                             text: "Available ConEmu GUI window not found!", action: "ClickButton:&Retry"}) ; ahk_class #32770 ahk_exe ConEmu64.exe
titles.push({title: "",                             text: "Steam is not running. Please start Steam then run this tool again.", action: "CloseWindow"})
titles.push({title: "",                             text: "Network error, please try connection to http://devxdevelopment.com", action: "CloseWindow"})
titles.push({title: "",                             text: "please let us know about the problem (devxdevelopment@gmail.com),", action: "CloseWindow"})
titles.push({title: "",                             text: "The trial license has expired. If you wish to continue using all features of this application, then you must buy a license.", action: "CloseWindow"})
titles.push({title: "",                             text: "System.InvalidOperationException: Starting a second message loop on a single thread is not a valid operation. Use Form.ShowDialog instead.", action: "CloseWindow"})
titles.push({title: "Run In Safe Mode? ahk_class #32770 ahk_exe h1_sp64_ship.exe", text: "", action: "ClickButton:No"})
titles.push({title: "GetISteam ahk_class #32770 ahk_exe h1_sp64_ship.exe", text: "", action: "ClickButton:OK"})
titles.push({title: "Error Applying Security ahk_class #32770 ahk_exe explorer.exe", text: "", action: "ClickButton:&Continue"})
titles.push({title: "Fehler ahk_class TMessageForm ahk_exe yatqa.exe", text: "", action: "ClickButton:&Ignorieren"})
titles.push({title: "Your Windows license will expire soon ahk_class Shell_SystemDialog ahk_exe LicensingUI.exe", text: "", action: "CloseWindow"})

titles.push({title: "Evaluation Feedback ahk_class SunAwtDialog ahk_exe phpstorm64.exe", text: "", action: "CloseWindow"})
titles.push({title: "Evaluation License Expired ahk_class SunAwtDialog ahk_exe phpstorm64.exe", text: "", action: "CloseWindow"})
titles.push({title: "PhpStorm Evaluation ahk_class SunAwtDialog ahk_exe phpstorm64.exe", text: "", action: "CloseWindow"})

titles.push({title: "7-Zip ahk_class #32770 ahk_exe 7zFM.exe", text: "Unspecified error", action: "CloseWindow"})
titles.push({title: "TC4Shell ahk_class TTrialForm ahk_exe Explorer.EXE", text: "", action: "CloseWindow"})
titles.push({title: "taskkill.exe - Application Error ahk_class #32770", text: "The application was unable to start correctly", action: "CloseWindow"})
titles.push({title: "ahk_class CNotificationWindow_Class ahk_exe SUPERANTISPYWARE.EXE", text: "Professional Trial Expires", action: "CloseWindow"} )
titles.push({title: "Connection Error ahk_class vguiPopupWindow ahk_exe steam.exe", text: "", action: "Click:X105 Y234"})
titles.push({title: "Error ahk_class #32770 ahk_exe wallpaper64.exe", text: "Wallpaper Engine was possibly crashed by another application.", action: "CloseWindow"})
titles.push({title: "SUPERAntiSpyware Professional Evaluation Period Expired ahk_class #32770 ahk_exe SUPERANTISPYWARE.EXE", text: "", action: "CloseWindow"})
titles.push({title: "Message ahk_class #32770 ahk_exe Sam2017.exe", text: "Do you want to start in safe mode?", action: "ClickButton:&No"})
titles.push({title: "Croteam crash reporter ahk_class CrashReporterWindowClass ahk_exe Sam2017_Unrestricted.exe", text: "", action: "ClickButton:Exit"})
titles.push({title: "Message ahk_class #32770 ahk_exe Sam2017_Unrestricted.exe", text: "The application has malfunctioned and it will now close.", action: "CloseWindow"})
; titles.push({title: "DB Browser for SQLite ahk_class Qt5QWindowIcon ahk_exe DB Browser for SQLite.exe", text: "", action: "Click:X232 Y67"})
; titles.push({title: "ahk_class CabinetWClass ahk_exe Explorer.EXE", text: "UNREGISTERED VERSION", action: "CloseWindow"})
;<=====  Setup our timer  =====================================================>
SetTimer, runChecks, 500 ; Check every 1/8th second
;<=====  Functions  ===========================================================>
runChecks(){
  Global
  for i, window in titles {
    title := window["title"]
    text := window["text"]
    hwnd := 0x0
    if (title && text) {
        hwnd := WinExist(title, text)
    } else if (title) {
        hwnd := WinExist(title)
    } else if (text) {
        hwnd := WinExist(,text)
    }
    ; MsgBox % title . ":" . text . ":" . action . " = " . hwnd
    if (hwnd) {
      action := window["action"]
      if (action) {
        action := StrSplit(action, ":")
        if (action[1] == "ClickButton") {
            ControlClick, % action[2], ahk_id %hwnd%
            Continue
        } else if (action[1] == "CloseWindow"){
            closeWindow(ahk_id %hwnd%)
            Continue
        } else if (action[1] == "Click"){
            ControlClick, % action[2], ahk_id %hwnd%
        }
      }
    }
  }
}
closeWindow(title){
    WinClose, %title%
    ; MsgBox, , "ErrorLevel", %ErrorLevel%
    if(ErrorLevel == 0) {
        ; TrayTip, Closed %title%, , 1
    } else {
        ; TrayTip, "Error while closing %title%", "Hiding it instead", 1
        WinHide, %title%
    }
}