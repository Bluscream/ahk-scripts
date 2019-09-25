
#Include <bluscream>
; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-winclose-ahk
; Big thanks to Dinenon#8239
#SingleInstance, Force
#NoTrayIcon
#NoEnv
#Persistent
SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
SetTitleMatchMode, 2
;<=====  Set up our arrays  ===================================================>
titles := Array()
; titles["DF ahk_class #32770 ahk_exe df.exe"] := 0
titles["Run In Safe Mode? ahk_class #32770 ahk_exe h1_sp64_ship.exe"] := "Button::Click::No"
titles["GetISteam ahk_class #32770 ahk_exe h1_sp64_ship.exe"] := "Button::Click::OK"
titles["Error Applying Security ahk_class #32770 ahk_exe explorer.exe"] := "Button::Click::&Continue"
titles["Fehler ahk_class TMessageForm ahk_exe yatqa.exe"] := "Button::Click::&Ignorieren"
titles["Your Windows license will expire soon ahk_class Shell_SystemDialog ahk_exe LicensingUI.exe"] := 0
; titles["Evaluation License Expired ahk_class SunAwtDialog ahk_exe phpstorm64.exe"] := 0


; classes
titles["ahk_class ClassAdvert"] := 0
titles["ahk_class MainFrameInstall"] := 0
titles["ahk_class RarReminder"] := 0
; binaries
titles["ahk_exe airdroid.exe"] := 0
titles["ahk_exe error_report.exe"] := 0
titles["ahk_exe setup_clvupdsp.exe"] := 0
titles["ahk_exe wefault.exe"] := 0
titles["ahk_exe wermgr.exe"] := 0
titles["ahk_exe vsjitdebugger.exe"] := 0
; titles
titles["Untrusted Server's Certificate"] := 0
titles["Real Desktop 2.0 - Angebote"] := 0
titles["Purchase now"] := 0
titles["The trial license has expired. If you wish to continue using all features of this application, then you must buy a license."] := 0
titles["Contribute to NetSpeedMonitor"] := 0
titles["Steam is not running. Please start Steam then run this tool again."] := 0
titles["Network error, please try connection to http://devxdevelopment.com"] := 0
titles["DragDrop registration did not succeed."] := 0
titles["please let us know about the problem (devxdevelopment@gmail.com),"] := 0
titles["System.InvalidOperationException: Starting a second message loop on a single thread is not a valid operation. Use Form.ShowDialog instead."] := 0
titles["Error on init, details in Debug.txt"] := 0
titles["Please restart app"] := 0
titles["Proxy Authentication"] := 0
titles[""] := 0
;<=====  Setup our timer  =====================================================>
SetTimer, runChecks, 500 ; Check every 1/8th second
;<=====  Functions  ===========================================================>
runChecks(){
  Global
  for title, action in titles {
    if WinExist(title) {
      if (action == 0) {
        closeWindow(title,"")
      } else {
        action := StrSplit(action, "::")
        if (action[1] == "Button") {
            if (action[2] == "Click"){
                ControlClick, % action[3], % title
            }
        }
      }
    }
  }
}
closeWindow(title, text){
    WinClose, %title%, %text%
    ; MsgBox, , "ErrorLevel", %ErrorLevel%
    if(ErrorLevel == 0) {
        ; TrayTip, Closed %title%, , 1
    } else {
        ; TrayTip, "Error while closing %title%", "Hiding it instead", 1
        WinHide, %title%, %text%
    }
}