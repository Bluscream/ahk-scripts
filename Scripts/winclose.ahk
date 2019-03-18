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
titles := ["Real Desktop 2.0 - Angebote"]
classes := ["ClassAdvert", "MainFrameInstall", "RarReminder"]
binaries := ["airdroid.exe", "error_report.exe", "setup_clvupdsp.exe", "wefault.exe", "wermgr.exe", "vsjitdebugger.exe"]
texts := ["Purchase now", "The trial license has expired. If you wish to continue using all features of this application, then you must buy a license.","Contribute to NetSpeedMonitor","Steam is not running. Please start Steam then run this tool again.", "Network error, please try connection to http://devxdevelopment.com","DragDrop registration did not succeed.","please let us know about the problem (devxdevelopment@gmail.com),","System.InvalidOperationException: Starting a second message loop on a single thread is not a valid operation. Use Form.ShowDialog instead.","Error on init, details in Debug.txt","Please restart app","Proxy Authentication"]
;<=====  Setup our timer  =====================================================>
SetTimer, runChecks, 500 ; Check every 1/8th second
;<=====  Functions  ===========================================================>
runChecks(){
  Global
  for each, item in titles {
    if WinExist(item) {
      closeWindow(item,"")
      return
    }
  }
  for each, item in classes {
    if WinExist("ahk_class "item) {
      closeWindow("ahk_class "item, "")
      return
    }
  }
  for each, item in binaries {
    if WinExist("ahk_exe "item) {
      closeWindow( "ahk_exe " item, "")
      return
    }
  }
  for each, item in texts {
    if WinExist(, item) {
      closeWindow("", item)
      return
    }
  }
}
closeWindow(title, text){
    WinClose, %title%, %text%
    ; MsgBox, , "ErrorLevel", %ErrorLevel%
    if(ErrorLevel == 0) {
        TrayTip, Closed %title%, , 1
    } else {
        TrayTip, "Error while closing %title%", "Hiding it instead", 1
        WinHide, %title%, %text%
    }
}