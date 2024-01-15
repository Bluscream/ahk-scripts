#SingleInstance, Force
#NoTrayIcon
#NoEnv
#Persistent
; #Warn

#Include <bluscream>
EnforceAdmin()
global no_ui := false
; https://gist.github.com/Bluscream/119f09441c512ef267ade38bd4a5c9ce#file-winclose-ahk
; Big thanks to Dinenon#8239
; SetBatchLines, -1
SetWorkingDir, % A_ScriptDir
SetTitleMatchMode, 2
DetectHiddenWindows, Off
CoordMode, Mouse, Client
;<=====  Set up our arrays  ===================================================>
titles := []
;titles.push({title:"DF ahk_class #32770 ahk_exe df.exe", text: "", action: "CloseWindow"}
;titles.push({title:"ConEmu [64] ahk_class #32770 ahk_exe ConEmu64.exe", text: "", action: "ClickButton:&Ignore"}
titles.push({title:"ahk_class ClassAdvert",        text: "",action: "CloseWindow"})
titles.push({title:"ahk_class MainFrameInstall",   text: "",action: "CloseWindow"})
titles.push({title:"ahk_class RarReminder",        text: "",action: "CloseWindow"})
titles.push({title:"ahk_exe airdroid.exe",         text: "",action: "CloseWindow"})
titles.push({title:"ahk_exe error_report.exe",     text: "",action: "CloseWindow"})
titles.push({title:"ahk_exe setup_clvupdsp.exe",   text: "",action: "CloseWindow"})
titles.push({title:"ahk_exe wefault.exe",          text: "",action: "CloseWindow"})
titles.push({title:"ahk_exe wermgr.exe",           text: "",action: "CloseWindow"})
titles.push({title:"ahk_exe vsjitdebugger.exe",    text: "",action: "CloseWindow"})
titles.push({title:"Untrusted Server's Certificate",text: "",action: "CloseWindow"})
titles.push({title:"Real Desktop 2.0 - Angebote",  text: "",action: "CloseWindow"})
titles.push({title:"Purchase now",                 text: "",action: "CloseWindow"})
titles.push({title:"Contribute to NetSpeedMonitor",text: "",action: "CloseWindow"})
titles.push({title:"Please restart app",           text: "",action: "CloseWindow"})
titles.push({title:"Proxy Authentication",         text: "",action: "CloseWindow"})
titles.push({title:"Error... ahk_class #32770 ahk_exe MyPhoneExplorer.exe",         text: "",   action: "CloseWindow"}) ; ClickButton:&OK
titles.push({title:"C:\WINDOWS\system32\cmd.exe (Admin) ahk_class #32770 ahk_exe ConEmu64.exe",text: "WaitNamedPipe failed", action: "CloseWindow"})
titles.push({title:"",text: "Error OnTimer", action: "CloseWindow"})
titles.push({title:"",text: "Assertion: ConEmu ", action: "ClickButton:&Ignore"})
titles.push({title:"",text: "Available ConEmu GUI window not found!", action: "ClickButton:&Retry"}) ; ahk_class #32770 ahk_exe ConEmu64.exe
titles.push({title:"",text: "Error on init, details in Debug.txt", action: "CloseWindow"})
titles.push({title:"",text: "DragDrop registration did not succeed.", action: "CloseWindow"})
titles.push({title:"",text: "Steam is not running. Please start Steam then run this tool again.", action: "CloseWindow"})
titles.push({title:"",text: "Network error, please try connection to http://devxdevelopment.com", action: "CloseWindow"})
titles.push({title:"",text: "please let us know about the problem (devxdevelopment@gmail.com),", action: "CloseWindow"})
titles.push({title:"",text: "The trial license has expired. If you wish to continue using all features of this application, then you must buy a license.", action: "CloseWindow"})
titles.push({title:"",text: "System.InvalidOperationException: Starting a second message loop on a single thread is not a valid operation. Use Form.ShowDialog instead.", action: "CloseWindow"})
titles.push({title:"Run In Safe Mode? ahk_class #32770 ahk_exe h1_sp64_ship.exe", text: "", action: "ClickButton:No"})
titles.push({title:"GetISteam ahk_class #32770 ahk_exe h1_sp64_ship.exe", text: "", action: "ClickButton:OK"})
titles.push({title:"Error Applying Security ahk_class #32770 ahk_exe explorer.exe", text: "", action: "ClickButton:&Continue"})
titles.push({title:"Fehler ahk_class TMessageForm ahk_exe yatqa.exe", text: "", action: "ClickButton:&Ignorieren"})
titles.push({title:"Your Windows license will expire soon ahk_class Shell_SystemDialog ahk_exe LicensingUI.exe", text: "", action: "CloseWindow"})
titles.push({title:"Donate to MyPhoneExplorer! ahk_class ThunderRT6FormDC ahk_exe MyPhoneExplorer.exe", text: "", action: "CloseWindow"})
titles.push({title:"Strony nie znaleziono - Gesundheit Real Desktop 3D – Desktop for Windows ahk_class #32770 ahk_exe rdesc.exe", text: "", action: "CloseWindow"})
titles.push({title:"Can’t reach this page (Not Responding) ahk_class Ghost ", text: "", action: "CloseWindow"})
titles.push({title:"TC4Shell ahk_class TTrialForm", text: "", action: "ClickButton:&Continue"})
titles.push({title:"OpenVR Advanced Settings Overlay - Advanced Settings ahk_class Qt5QWindowIcon ahk_exe AdvancedSettings.exe", text: "", action: "CloseWindow"})
titles.push({title:"Allow game launch? ahk_class vguiPopupWindow ahk_exe Steam.exe", text: "", action: "Click:X316 Y197"})
titles.push({title:"Warning ahk_class vguiPopupWindow ahk_exe steam.exe", text: "", action: "Click:X283 Y88"})
titles.push({title:"Error ahk_class #32770 ahk_exe SideQuest.exe", text: "", action: "CloseWindow"})
titles.push({title:"WindowMenuPlus ahk_class #32770 ahk_exe WindowMenuPlus.exe", text: "The configuration is available from TaskTray icon menu.", action: "CloseWindow"})
titles.push({title:"Evaluation Feedback ahk_class SunAwtDialog ahk_exe phpstorm64.exe", text: "", action: "CloseWindow"})
titles.push({title:"Evaluation License Expired ahk_class SunAwtDialog ahk_exe phpstorm64.exe", text: "", action: "CloseWindow"})
titles.push({title:"PhpStorm Evaluation ahk_class SunAwtDialog ahk_exe phpstorm64.exe", text: "", action: "CloseWindow"})
titles.push({title:"7-Zip ahk_class #32770 ahk_exe 7zFM.exe", text: "Unspecified error", action: "CloseWindow"})
titles.push({title:"TC4Shell ahk_class TTrialForm ahk_exe Explorer.EXE", text: "", action: "CloseWindow"})
titles.push({title:"taskkill.exe - Application Error ahk_class #32770", text: "The application was unable to start correctly", action: "CloseWindow"})
titles.push({title:"taskkill.exe - Anwendungsfehler ahk_class #32770", text: "Die Anwendung konnte nicht korrekt gestartet werden", action: "CloseWindow"})
titles.push({title:"Anwendungsfehler ahk_class #32770", text: "", action: "CloseWindow"})
titles.push({title:"Application Error ahk_class #32770", text: "", action: "CloseWindow"})
titles.push({title:"ahk_class CNotificationWindow_Class ahk_exe SUPERANTISPYWARE.EXE", text: "Professional Trial Expires", action: "CloseWindow"} )
titles.push({title:"Connection Error ahk_class vguiPopupWindow ahk_exe steam.exe", text: "", action: "Click:X105 Y234"})
titles.push({title:"Error ahk_class #32770 ahk_exe wallpaper64.exe", text: "Wallpaper Engine was possibly crashed by another application.", action: "CloseWindow"})
titles.push({title:"SUPERAntiSpyware Professional Evaluation Period Expired ahk_class #32770 ahk_exe SUPERANTISPYWARE.EXE", text: "", action: "CloseWindow"})
titles.push({title:"Message ahk_class #32770", text: "Do you want to start in safe mode?", action: "ClickButton:&No"})
titles.push({title:"Croteam crash reporter ahk_class CrashReporterWindowClass", text: "", action: "ClickButton:Exit"})
titles.push({title:"Message ahk_class #32770", text: "The application has malfunctioned and it will now close.", action: "CloseWindow"})
titles.push({title:"Crash Report ahk_class SALFRAME ahk_exe soffice.bin", text: "", action: "Click:X554 Y118"})
titles.push({title:"Upgrade To Pro ahk_class ThunderRT6FormDC ahk_exe Repair_Windows.exe", text: "", action: "CloseWindow"})
titles.push({title:"Tweaking.com - Windows Repair - Thank You! ahk_class ThunderRT6FormDC ahk_exe Repair_Windows.exe", text: "", action: "CloseWindow"})
titles.push({title:"Bluetooth Manager ahk_class #32770 ahk_exe TosBtMng.exe", text: "Thank you for evaluating the Bluetooth Stack for Windows by Toshiba", action: "CloseWindow"})
titles.push({title:"PowerLauncher.exe ahk_class #32770 ahk_exe PowerLauncher.exe", text: "To run this application, you must install .NET Core", action: "ClickButton:&No"})
titles.push({title:"PowerToys Error ahk_class #32770 ahk_exe PowerToys.exe", text: "Could not start PowerToys as an administrator", action: "CloseWindow"})
; titles.push({title:"Windows Security Alert ahk_class #32770 ahk_exe rundll32.exe", text: "Windows Defender Firewall has blocked some features of this app", action: "ClickButton:&Cancel"})
titles.push({title:"Ahk2Exe Error ahk_class #32770 ahk_exe Ahk2Exe.exe", text: "", action: "CloseWindow"})
titles.push({title:"ahk_class #32770 ahk_exe AutoHotkeyU32.exe", text: "Warning in #include file", action: "CloseWindow"})
titles.push({title:"Microsoft Visual C++ Runtime Library ahk_class #32770 ahk_exe TeaClient.exe", text: "", action: "CloseWindow"})
titles.push({title:"Salty Chat ahk_class #32770 ahk_exe ts3client_win64.exe", text: "", action: "ClickButton:&No"})
titles.push({title:"MCEdit Error ahk_class QWidget ahk_exe mcedit2.exe", text: "", action: "CloseWindow"})
titles.push({title:"StartAllBack configuration ahk_class TMain ahk_exe StartAllBackCfg.exe", text: "Activate via web browser", action: "CloseWindow"})
titles.push({title:"Error ahk_class #32770 ahk_exe NVIDIA RTX Voice.exe", text: "Initialization failed (no speaker/mic present?)", action: "KillProcess"})
titles.push({title:"OBS has crashed! ahk_class #32770 ahk_exe obs64.exe", text: "", action: "ClickButton:&No"})
titles.push({title:"Message ahk_class SunAwtDialog ahk_exe BoxToGoRC.exe", text: "", action: "CloseWindow"})
titles.push({title:"Microsoft .NET ahk_exe DllHost.exe", text: "The system cannot find the file specified. (0x80070002)", action: "CloseWindow"})
titles.push({title:b64Decode("TG9nIGluIHRvOiBibHVA") . " ahk_class SunAwtDialog ahk_exe pycharm64.exe", text: "", action: "SendBase64:TTTTT"})
titles.push({title:"Visual Studio Just-In-Time Debugger ahk_class #32770", text: "", action: "CloseWindow"})
; titles.push({title:"Lua Error ahk_class #32770 ahk_exe modest-menu.exe", text: "", action: "CloseWindow"})
titles.push({title:"Lua Callback ahk_class #32770 ahk_exe modest-menu.exe", text: "attempt to call a nil value", action: "CloseWindow"})
; titles.push({title:"OnPlayerChanged Callback ahk_class #32770 ahk_exe modest-menu.exe", text: "autorun.lua:8: attempt to index a nil value (global 'PedConfigFlag')", action: "CloseWindow"})
titles.push({title:"Kiddion's Modest Menu ahk_class #32770 ahk_exe modest-menu.exe", text: "Already running!", action: "CloseWindow"})
titles.push({title:"Kiddion's Modest Menu ahk_class #32770 ahk_exe modest-menu.exe", text: "Warning: Incompatible game version detected!", action: "CloseWindow"})
titles.push({title:"GTA5.exe - System Error ahk_class #32770", text: "", action: "CloseWindow"})
titles.push({title:"Error ahk_class #32770 ahk_exe PlayGTAV.exe", text: "Unable to launch game, please verify your game data.", action: "ClickButton:OK"})
titles.push({title:"Oh Yeah! ahk_class #32770 ahk_exe Launcher.exe", text: "Injection successful", action: "CloseWindow"})
titles.push({title:"Event Viewer ahk_exe mmc.exe", text: "You can save the contents of this log before clearing it.", action: "ClickButton:&Clear"})
titles.push({title:"Oh Noes! ahk_class #32770 ahk_exe Launcher.exe", text: "Make sure Grand Theft Auto V is not running before starting the authenticator.", action: "CloseWindow"})
titles.push({title:"Oh Noes! ahk_class #32770 ahk_exe Launcher.exe", text: "Auth already running.", action: "CloseWindow"})
titles.push({title:"DesktopWindowXamlSource: WindowsTerminal.exe - System Error ahk_class #32770", text: "", action: "CloseWindow"})
titles.push({title:"WindowsTerminal.exe - System Error ahk_class #32770", text: "", action: "CloseWindow"})
titles.push({title:"Print Pictures Error ahk_class #32770 ahk_exe explorer.exe", text: "Windows Photo Viewer can't print this picture  because there's no printer installed, or a service Windows needs isn't running.", action: "CloseWindow"})
titles.push({title:"About EZShellExtensions.Net", text: "", action: "CloseWindow"}) ; Click:X567 Y-18"
titles.push({title:"FileMenu Tools ahk_class #32770 ahk_exe explorer.exe", text: "The operation was canceled by the user.", action: "CloseWindow"})
titles.push({title:"Host message ahk_class Qt5QWindowIcon", text: "", action: "CloseWindow"})
titles.push({title:"Authentication Failure ahk_class Qt631QWindowIcon ahk_exe obs64.exe", text: "", action: "CloseWindow"})
titles.push({title:"Autoruns ahk_class #32770 ahk_exe Autoruns.exe",text:"Are you sure you want to delete Autoruns entry",action: "Sleep:250;ClickButton:OK"}) ; Focus:Button1
titles.push({title:"Confirm ahk_class #32770 ahk_exe ImageMagick-",text:"Overwrite the existing file",action: "ClickButton:&Overwrite the existing file"})
titles.push({title:"DiscordSetup.exe ahk_class #32770 ahk_exe DiscordSetup.exe",text:"",action: "CloseWindow"})
titles.push({title:"Download - ahk_class #32770 ahk_exe sardu_4.exe",text:"",action: "ClickButton:&Yes"})
titles.push({title:"Information ahk_class #32770 ahk_exe sardu_4.exe",text:"",action: "CloseWindow"}) ; ClickButton:&OK
; titles.push({title:"SARDU ahk_class #32770 ahk_exe sardu_4.exe",text:"",action: "ClickButton:&OK"})
titles.push({title:" | PortableApps.com Installer ahk_class #32770",text:"",action: "ClickButton:I &Agree"})
titles.push({title:".ahk ahk_class #32770 ahk_exe AutoHotkey.exe",text:"C:\Program Files\AutoHotkey\Lib\bluscream\json.ahk",action: "ClickButton:&Yes"})
titles.push({title:"Script Error ahk_class Internet Explorer_TridentDlgFrame ahk_exe updatechecker.exe",text:"",action: "CloseWindow"})
; titles.push({title:"ahk_class TMobaXtermForm ahk_exe MobaXterm.exe",ext_title:"MobaXterm Master Password",action:"ClickButton:TsListView1"}) ; ClickButton:Cancel ; Click:X1673 Y1006
titles.push({title:"HASS.Agent ahk_class WindowsForms10.Window.8.app.0.2982bee_r3_ad1 ahk_exe HASS.Agent.exe",text:"Error trying to bind the API to port ",action: "CloseWindow"})
titles.push({title:"Taskbar ahk_class #32770 ahk_exe explorer.exe",text:"",action: "CloseWindow"})
titles.push({title:"RaiDrive ahk_class HwndWrapper[RaiDrive;;4a926fae-babf-4e16-8d32-436648ddf991] ahk_exe RaiDrive.exe",text:"standard 2022.6.92",action: "CloseWindow"})
titles.push({title:"ShareX - Hotkey registration failed ahk_class #32770 ahk_exe ShareX.exe",text:"",action: "CloseWindow"})
; titles.push({title:"Process Lasso ahk_class #32770 ahk_exe processlasso.exe", text: "", action: "ClickButton:Button3"})
titles.push({title:"Message ahk_class #32770 ahk_exe BlackSquadGame.exe",text:"This is application must to run from launcher.",action: "CloseWindow"})
titles.push({title:"BattlEye Launcher ahk_class #32770 ahk_exe BlackSquadGame_BELauncher.exe",text:"",action: "CloseWindow"})
titles.push({title:"RunDLL ahk_class #32770 ahk_exe rundll32.exe",text:"Missing entry: ",action: "CloseWindow"})
titles.push({title:"Error ahk_class #32770 ahk_exe iw4x.exe",text:"Fatal error",action: "ClickButton:No"})
titles.push({title:"Error ahk_class #32770 ahk_exe RestartOnCrash.exe",text:"OK",action: "CloseWindow"})
titles.push({title:"Attention! ahk_class #32770 ahk_exe ADBAppControl.exe",text:"Removing or disabling SYSTEM applications may result in failure of the device and reset to factory settings (with data wipe). Are you sure you want to continue?",action: "ClickButton:&Yes"})
titles.push({title:"Task completed ahk_class #32770 ahk_exe ADBAppControl.exe",text:"OK",action: "CloseWindow"})
titles.push({title:"AirServer® Universal ahk_class NativeHWNDHost ahk_exe AirServer.exe",text:"",action: "ClickButton:Try;CloseWindow"})
titles.push({title:"Invalid License Key • DisplayFusion Pro ahk_exe DisplayFusion.exe",text:"",action: "ClickButton:Maybe Later"})
titles.push({title:"VRCX ahk_class #32770 ahk_exe VRCX.exe",text:"VRCX is already running, start another instance?",action: "ClickButton:No"})
titles.push({title:"Setup ahk_class #32770",text:"Newer or same version already installed. Setup will exit now.",action: "CloseWindow"})



; titles.push({title: "DB Browser for SQLite ahk_class Qt5QWindowIcon ahk_exe DB Browser for SQLite.exe", text: "", action: "Click:X232 Y67"})
; titles.push({title: "ahk_class CabinetWClass ahk_exe Explorer.EXE", text: "UNREGISTERED VERSION", action: "CloseWindow"})
;<=====  Setup our timer  =====================================================>
SetTimer, runChecks, 500 ; Check every 1/8th second
scriptlog("Started")
;<=====  Functions  ===========================================================>

; DllCall("RegisterShellHookWindow", UInt,hWnd)
; MsgNum := DllCall("RegisterWindowMessage", Str,"SHELLHOOK")
; OnMessage(MsgNum, "ShellMessage")
global HSHELL_WINDOWCREATED := 1
return

ShellMessage(wParam,lParam) {
    If ( wParam == HSHELL_WINDOWCREATED ) {
        runChecks(WinExist("ahk_id " . lParam))
    }
}

runChecks(hwnd_ := 0x0){
  Global
  for i, win in titles {
    if (hwnd_ == 0x0) {
        title := win["title"]
        text := win["text"]
        ext_title := win["ext_title"]
        if (ext_title) {
            WinGet, WinList, List
            Loop % WinList
            {   
                WinGetTitle, WinTitle, % "ahk_id " WinList%A_Index%
                if (InStr(WinTitle, cntrl)) {
                    WinGet, hwnd_, ID, % "ahk_id " WinList%A_Index%
                    break
                }
                hwnd_ := 0x0
            }
            ; WinGet, ActiveControlList, ControlList, % title, % text
            ; Loop, Parse, ActiveControlList, `n
            ; {
            ;     ControlGetText, cntrltxt, % A_LoopField, % title, % text
            ;     if (InStr(cntrltxt, cntrl)) {
            ;         MsgBox, 4,, Control #%A_Index% is "%A_LoopField%" "%cntrltxt%". Continue?
            ;         IfMsgBox, No
            ;             break
            ;     }
            ; }
            ; ControlGet, _hwnd, Hwnd,, % cntrl, % title, % text
            ; parent := DllCall("user32\GetAncestor", Ptr,_hwnd, UInt,1, Ptr)
            ; root := DllCall("user32\GetAncestor", Ptr,_hwnd, UInt,2, Ptr) ;GA_ROOT := 2
            ; owner := DllCall("user32\GetWindow", Ptr,_hwnd, UInt,4, Ptr) ;GW_OWNER = 4
            ; WinGetClass, vWinClass, % "ahk_id " _hwnd
            ; MsgBox % "title: " . title . "`ntext: " . text . "`ncntrl: " . cntrl . "`n_hwnd: " . _hwnd . "`nparent: " . parent . "`nroot: " . root . "`nowner: " . owner . "`nclass: " . vWinClass
        } else {
            if (title && text) {
                hwnd_ := WinExist(title, text)
            } else if (title) {
                hwnd_ := WinExist(title)
            } else if (text) {
                hwnd_ := WinExist(,text)
            }
        }
    }
    if (hwnd_) {
      ; MsgBox % title . ":" . text . ":" . action . " = " . hwnd_
      action := win["action"]
      if (action) {
        actions := StrSplit(action, ";")
        WinGet, proc, ProcessName, %title%
        scriptlog("Closing window " . title . " from process " . proc . " with " . action)
        for i, action in actions {
            action := StrSplit(action, ":")
            if (action[1] == "CloseWindow"){
                closeWindow("ahk_id " . hwnd_)
                Continue
            } else if (action[1] == "KillProcess"){
                WinGet, proc, ProcessName, ahk_id %hwnd_%
                Process, Close, % proc
                Continue
            } else if (action[1] == "ClickButton") {
                ControlClick, % action[2], ahk_id %hwnd_%
                Continue
            }  else if (action[1] == "Click"){
                ControlClick, % action[2], ahk_id %hwnd_%
                Continue
            } else if (action[1] == "SendBase64"){
                ControlSend,, % b64Decode(action[2]) . "{Enter}", ahk_id %_hhwnd_wnd%
                Continue
            } else if (action[1] == "Focus"){
                ; SleepS(1)
                ; WinActivate, ahk_id %hwnd_%
                ; WinWaitActive, ahk_id %hwnd_%
                ControlFocus, % action[2], ahk_id %hwnd_%
                Continue
            } else if (action[1] == "Sleep"){
                Sleep, % action[2]
                Continue
            }
        }
      }
    }
  }
}
closeWindow(title){
    ErrorLevel := 0
    ; if not title {
    ;     return
    ; }
    WinClose, %title%
    ; MsgBox, , "ErrorLevel", %ErrorLevel%
    if(ErrorLevel == 0) {
        TrayTip, % "Closed " . title, , .5
    } else {
        TrayTip, "Error while closing " . title, "Hiding it instead", 1
        WinHide, %title%
    }
}