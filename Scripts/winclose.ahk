
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
;<=====  Set up our arrays  ===================================================>
titles := [ { title: "", text: "Available ConEmu GUI window not found!", action: "ClickButton:&Retry"} ; ahk_class #32770 ahk_exe ConEmu64.exe
    ;,{title: "DF ahk_class #32770 ahk_exe df.exe", text: "", action: "CloseWindow"}
    , {title: "ConEmu [64] ahk_class #32770 ahk_exe ConEmu64.exe", text: "", action: "ClickButton:&Ignore"}
    , {title: "Run In Safe Mode? ahk_class #32770 ahk_exe h1_sp64_ship.exe", text: "", action: "ClickButton:No"}
    , {title: "GetISteam ahk_class #32770 ahk_exe h1_sp64_ship.exe", text: "", action: "ClickButton:OK"}
    , {title: "Error Applying Security ahk_class #32770 ahk_exe explorer.exe", text: "", action: "ClickButton:&Continue"}
    , {title: "Fehler ahk_class TMessageForm ahk_exe yatqa.exe", text: "", action: "ClickButton:&Ignorieren"}
    , {title: "Your Windows license will expire soon ahk_class Shell_SystemDialog ahk_exe LicensingUI.exe", text: "", action: "CloseWindow"}
    , {title: "ahk_class ClassAdvert", text: "", action: "CloseWindow"}
    ;,{title: "Evaluation License Expired ahk_class SunAwtDialog ahk_exe phpstorm64.exe", text: "", action: "CloseWindow"}
    , {title: "ahk_class MainFrameInstall", text: "", action: "CloseWindow"}
    , {title: "ahk_class RarReminder", text: "", action: "CloseWindow"}
    , {title: "ahk_exe airdroid.exe", text: "", action: "CloseWindow"}
    , {title: "ahk_exe error_report.exe", text: "", action: "CloseWindow"}
    , {title: "ahk_exe setup_clvupdsp.exe", text: "", action: "CloseWindow"}
    , {title: "ahk_exe wefault.exe", text: "", action: "CloseWindow"}
    , {title: "ahk_exe wermgr.exe", text: "", action: "CloseWindow"}
    , {title: "ahk_exe vsjitdebugger.exe", text: "", action: "CloseWindow"}
    , {title: "Untrusted Server's Certificate", text: "", action: "CloseWindow"}
    , {title: "Real Desktop 2.0 - Angebote", text: "", action: "CloseWindow"}
    , {title: "Purchase now", text: "", action: "CloseWindow"}
    , {title: "", text: "The trial license has expired. If you wish to continue using all features of this application, then you must buy a license.", action: "CloseWindow"}
    , {title: "Contribute to NetSpeedMonitor", text: "", action: "CloseWindow"}
    , {title: "", text: "Steam is not running. Please start Steam then run this tool again.", action: "CloseWindow"}
    , {title: "", text: "Network error, please try connection to http://devxdevelopment.com", action: "CloseWindow"}
    , {title: "", text: "DragDrop registration did not succeed.", action: "CloseWindow"}
    , {title: "", text: "please let us know about the problem (devxdevelopment@gmail.com),", action: "CloseWindow"}
    , {title: "", text: "System.InvalidOperationException: Starting a second message loop on a single thread is not a valid operation. Use Form.ShowDialog instead.", action: "CloseWindow"}
    , {title: "", text: "Error on init, details in Debug.txt", action: "CloseWindow"}
    , {title: "Please restart app", text: "", action: "CloseWindow"}
    , {title: "Proxy Authentication", text: "", action: "CloseWindow"}
    , {title: "7-Zip ahk_class #32770 ahk_exe 7zFM.exe", text: "Unspecified error", action: "CloseWindow"}] 
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