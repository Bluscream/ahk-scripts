; The function JavaControlDoAction searches for the <occurrence>-instance of a Java-control that fits in <name>, <role> and <description> and performs <action> <count>-times
; actions can be all actions provided by the control itself or:
; - focus: attempts to focus the control and left clicks it if focussing fails
; - left/double/right/middle click; wheel up/down: performs the respective mouse action in the center of the control

JavaControlDoAction(hwnd=0, name="", role="", description="", occurrence="", action="", times=1)
{
    global JABVariables
    if (!JABVariables["JABInitialised"])
        InitJavaAccessBridge()
    if (JABVariables["JABInitialised"])
    {
        if (hwnd=0)
        {
            hwnd:=WinExist("A")
            if (!IsJavaWindow(hwnd))
            {
                ControlGetFocus, currctrl, ahk_id %hwnd%
                ControlGet, currwin, Hwnd, , %currctrl%, ahk_id %hwnd%
            }
            else currwin:=hwnd
        }
        else currwin:=hwnd
        if (IsJavaWindow(currwin))
        {
            Loop, 2
            {
                vmID:=0
                ac:=0
                Info:=
                getAccessibleContextFromHWND(currwin, vmID, ac)
                If (JABVariables["CachedHWND"]=currwin)
                {
                    Children:=JABVariables["CachedChildren"]
                }
                else
                {
                    Children:=GetVisibleChildrenFromTree(vmID, ac)
                    JABVariables["CachedChildren"] :=Children
                    JABVariables["CachedHWND"] :=currwin
                }
                occurcnt:=0
                For index, value in Children
                {
                    Info:=getAccessibleContextInfo(vmID, value)
                    if ((name="" or Instr(Info["Name"],name))
                        and (role="" or Instr(Info["Role"],role))
                        and (description="" or Instr(Info["Description"],description)))
                    {
                        occurcnt++
                        if (Occurrence=occurcnt or Occurrence=0 or Occurrence="")  
                        {
                            Loop, %times%
                            {
                                if (action="focus")
                                {
                                    If (Instr(Info["States"],"focusable"))
                                    {
                                        failure:= RequestFocus(vmID, value)
                                        if (failure<>0)
                                        {
                                            MouseClickJControl(Info)
                                        }
                                        return, 0
                                    }
                                    else return, -2
                                }
                                else if (action="left click")
                                {
                                    MouseClickJControl(Info)
                                }
                                else if (action="double click")
                                {
                                    MouseClickJControl(Info,"left",2)
                                }
                                else if (action="right click")
                                {
                                    MouseClickJControl(Info,"right")
                                }
                                else if (action="middle click")
                                {
                                    MouseClickJControl(Info,"middle")
                                }
                                else if (action="wheel up")
                                {
                                    MouseClickJControl(Info,"wheelup")
                                }
                                else if (action="wheel down")
                                {
                                    MouseClickJControl(Info,"wheeldown")
                                }
                                else
                                {
                                    DoAccessibleActions(vmID, value, action)
                                }
                            }
                            If (times>A_Index)
                                Sleep, 50
                          return, 0
                        }
                    }
                }
                JABVariables["CachedHWND"] :=0
            }
            return, -3
        }
    }
    else
    {
        return, -1
    }
}

; used to retrieve an object with all visible children of the input control
GetVisibleChildrenFromTree(vmID, ac)
{
    global JABVariables
    Children:=Object()
    if (JABVariables["JABInitialised"])
    {
        RecurseVisibleChildren(vmID, ac, Children)
    }
    Return, Children
}

RecurseVisibleChildren(vmID, ac, byref Children)
{
    global JABVariables
    Info:=getAccessibleContextInfo(vmID,ac)
    If (Instr(Info["States"],"visible"))
    {
        If (Children.MaxIndex()="")
            Children[1]:=ac
        else
            Children[Children.MaxIndex()+1]:=ac
        Loop, % Info["Children count"]
        {
            rac:=GetAccessibleChildFromContext(vmID, ac, A_Index-1)
        RecurseVisibleChildren(vmID, rac, Children)
        }
    }
}

; used to retrieve an object with all children of the input control
GetAllChildrenFromTree(vmID, ac)
{
    global JABVariables
    Children:=Object()
    if (JABVariables["JABInitialised"])
    {
        RecurseAllChildren(vmID, ac, Children)
    }
    Return, Children
}

RecurseAllChildren(vmID, ac, byref Children)
{
    global JABVariables
    Info:=getAccessibleContextInfo(vmID,ac)
    If (Children.MaxIndex()="")
        Children[1]:=ac
    else
        Children[Children.MaxIndex()+1]:=ac
    Loop, % Info["Children count"]
    {
        rac:=GetAccessibleChildFromContext(vmID, ac, A_Index-1)
        RecurseAllChildren(vmID, rac, Children)
    }
}

; performs mouse clicks in the center of the specified control
MouseClickJControl(byref Info, action="left", count=1)
{
         xp:=Floor(Info["X"]+Info["Width"]/2)
         yp:=Floor(Info["Y"]+Info["Height"]/2)
         CoordMode, Mouse, Screen
         SetMouseDelay, 0
         SetDefaultMouseSpeed, 0
         BlockInput On
         MouseGetPos, MouseX, MouseY
         sleep, 1000
         MouseClick, %action%, %xp%, %yp%, %count%
         sleep, 1000
         MouseMove, %MouseX%, %MouseY%
         BlockInput Off
}

; Java Access Bridge functions; see Access Bridge documentation for details

; Initialises the bridge access
InitJavaAccessBridge()
{
    global JABVariables
    JABVariables:= Object()
    JABVariables["JABInitialised"]:=False
    JABVariables["JAB_DLLVersion"] :=""
    JABVariables["JAB_DLL"] :=""
    JABVariables["acType"] :="Int64"
    JABVariables["acPType"] :="Int64*"
    JABVariables["acSize"] :=8

    JABVariables["MAX_BUFFER_SIZE"] := 10240
    JABVariables["MAX_STRING_SIZE"] := 1024
    JABVariables["SHORT_STRING_SIZE"] := 256

    JABVariables["ACCESSIBLE_ALERT"] := "alert"
    JABVariables["ACCESSIBLE_COLUMN_HEADER"] := "column header"
    JABVariables["ACCESSIBLE_CANVAS"] := "canvas"
    JABVariables["ACCESSIBLE_COMBO_BOX"] := "combo box"
    JABVariables["ACCESSIBLE_DESKTOP_ICON"] := "desktop icon"
    JABVariables["ACCESSIBLE_INTERNAL_FRAME"] := "internal frame"
    JABVariables["ACCESSIBLE_DESKTOP_PANE"] := "desktop pane"
    JABVariables["ACCESSIBLE_OPTION_PANE"] := "option pane"
    JABVariables["ACCESSIBLE_WINDOW"] := "window"
    JABVariables["ACCESSIBLE_FRAME"] := "frame"
    JABVariables["ACCESSIBLE_DIALOG"] := "dialog"
    JABVariables["ACCESSIBLE_COLOR_CHOOSER"] := "color chooser"
    JABVariables["ACCESSIBLE_DIRECTORY_PANE"] := "directory pane"
    JABVariables["ACCESSIBLE_FILE_CHOOSER"] := "file chooser"
    JABVariables["ACCESSIBLE_FILLER"] := "filler"
    JABVariables["ACCESSIBLE_HYPERLINK"] := "hyperlink"
    JABVariables["ACCESSIBLE_ICON"] := "icon"
    JABVariables["ACCESSIBLE_LABEL"] := "label"
    JABVariables["ACCESSIBLE_ROOT_PANE"] := "root pane"
    JABVariables["ACCESSIBLE_GLASS_PANE"] := "glass pane"
    JABVariables["ACCESSIBLE_LAYERED_PANE"] := "layered pane"
    JABVariables["ACCESSIBLE_LIST"] := "list"
    JABVariables["ACCESSIBLE_LIST_ITEM"] := "list item"
    JABVariables["ACCESSIBLE_MENU_BAR"] := "menu bar"
    JABVariables["ACCESSIBLE_POPUP_MENU"] := "popup menu"
    JABVariables["ACCESSIBLE_MENU"] := "menu"
    JABVariables["ACCESSIBLE_MENU_ITEM"] := "menu item"
    JABVariables["ACCESSIBLE_SEPARATOR"] := "separator"
    JABVariables["ACCESSIBLE_PAGE_TAB_LIST"] := "page tab list"
    JABVariables["ACCESSIBLE_PAGE_TAB"] := "page tab"
    JABVariables["ACCESSIBLE_PANEL"] := "panel"
    JABVariables["ACCESSIBLE_PROGRESS_BAR"] := "progress bar"
    JABVariables["ACCESSIBLE_PASSWORD_TEXT"] := "password text"
    JABVariables["ACCESSIBLE_PUSH_BUTTON"] := "push button"
    JABVariables["ACCESSIBLE_TOGGLE_BUTTON"] := "toggle button"
    JABVariables["ACCESSIBLE_CHECK_BOX"] := "check box"
    JABVariables["ACCESSIBLE_RADIO_BUTTON"] := "radio button"
    JABVariables["ACCESSIBLE_ROW_HEADER"] := "row header"
    JABVariables["ACCESSIBLE_SCROLL_PANE"] := "scroll pane"
    JABVariables["ACCESSIBLE_SCROLL_BAR"] := "scroll bar"
    JABVariables["ACCESSIBLE_VIEWPORT"] := "viewport"
    JABVariables["ACCESSIBLE_SLIDER"] := "slider"
    JABVariables["ACCESSIBLE_SPLIT_PANE"] := "split pane"
    JABVariables["ACCESSIBLE_TABLE"] := "table"
    JABVariables["ACCESSIBLE_TEXT"] := "text"
    JABVariables["ACCESSIBLE_TREE"] := "tree"
    JABVariables["ACCESSIBLE_TOOL_BAR"] := "tool bar"
    JABVariables["ACCESSIBLE_TOOL_TIP"] := "tool tip"
    JABVariables["ACCESSIBLE_AWT_COMPONENT"] := "awt component"
    JABVariables["ACCESSIBLE_SWING_COMPONENT"] := "swing component"
    JABVariables["ACCESSIBLE_UNKNOWN"] := "unknown"
    JABVariables["ACCESSIBLE_STATUS_BAR"] := "status bar"
    JABVariables["ACCESSIBLE_DATE_EDITOR"] := "date editor"
    JABVariables["ACCESSIBLE_SPIN_BOX"] := "spin box"
    JABVariables["ACCESSIBLE_FONT_CHOOSER"] := "font chooser"
    JABVariables["ACCESSIBLE_GROUP_BOX"] := "group box"
    JABVariables["ACCESSIBLE_HEADER"] := "header"
    JABVariables["ACCESSIBLE_FOOTER"] := "footer"
    JABVariables["ACCESSIBLE_PARAGRAPH"] := "paragraph"
    JABVariables["ACCESSIBLE_RULER"] := "ruler"
    JABVariables["ACCESSIBLE_EDITBAR"] := "editbar"
    JABVariables["PROGRESS_MONITOR"] := "progress monitor"
    JABVariables["CachedHWND"] :=0
    JABVariables["CachedChildren"] :=
    if (A_PtrSize=8)
    {
        JABVariables["JAB_DLLVersion"]:="WindowsAccessBridge-64"
        JABVariables["JAB_DLL"]:=DllCall("LoadLibrary", "Str", JABVariables["JAB_DLLVersion"] ".dll")
    }
    else
    {
        JABVariables["JAB_DLLVersion"]:="WindowsAccessBridge-32"
        JABVariables["JAB_DLL"]:=DllCall("LoadLibrary", "Str", JABVariables["JAB_DLLVersion"] ".dll")
        if (JABVariables["JAB_DLL"]=0)
        {
            JABVariables["JAB_DLLVersion"]:="WindowsAccessBridge"
            JABVariables["JAB_DLL"]:=DllCall("LoadLibrary", "Str", JABVariables["JAB_DLLVersion"] ".dll")
            JABVariables["acType"]:="Int"
            JABVariables["acPType"]:="Int*"
            JABVariables["acSize"]:=4
        }
    }
    ; it is necessary to preload the DLL
    ; otherwise none of the calls suceed

    ; start up the access bridge
    JABVariables["JABInitialised"]:=DllCall(JABVariables["JAB_DLLVersion"] "\Windows_run", "Cdecl Int")
    ; it is necessary to give the application a few message cycles time before calling access bridge function
    ; otherwise all calls will fail
    Sleep, 200 ; minimum 100 for all machines?
    Return, JABVariables["JABInitialised"]
}

; shuts down the access bridge
ExitJavaAccessBridge()
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall("FreeLibrary", "Ptr", JABVariables["JAB_DLL"])
    }
}

IsJavaWindow(hwnd)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        Return DllCall(JABVariables["JAB_DLLVersion"] "\isJavaWindow", "Int", hWnd, "Cdecl Int")
    }
    else
    {
        Return 0
    }
}

; returns JAB version information as object containing the keys: VMversion, bridgeJavaClassVersion, bridgeJavaDLLVersion, bridgeWinDLLVersion
GetVersionInfo(vmID)
{
    global JABVariables
    Info:=Object()
    if (JABVariables["JABInitialised"])
    {
        VarSetCapacity(TempInfo, 2048,0)
        if (DllCall(JABVariables["JAB_DLLVersion"] "\getVersionInfo", "Int", vmID, "UInt", &TempInfo, "Cdecl Int"))
        {
            verstr:=""
            Loop, % JABVariables["SHORT_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2
                jver:=Chr(NumGet(&TempInfo,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            Info["VMversion"]:=verstr
            verstr:=""
            Loop, % JABVariables["SHORT_STRING_SIZE"]
            {
                offset:=((A_Index-1)*2)+JABVariables["SHORT_STRING_SIZE"]*2
                jver:=Chr(NumGet(&TempInfo,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            Info["bridgeJavaClassVersion"]:=verstr
            verstr:=""
            Loop, % JABVariables["SHORT_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2+JABVariables["SHORT_STRING_SIZE"]*4
                jver:=Chr(NumGet(&TempInfo,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            Info["bridgeJavaDLLVersion"]:=verstr
            verstr:=""
            Loop, % JABVariables["SHORT_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2+JABVariables["SHORT_STRING_SIZE"]*6
                jver:=Chr(NumGet(&TempInfo,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            Info["bridgeWinDLLVersion"]:=verstr
        }
    }
    Return Info
}

ReleaseJavaObject(vmID, ac)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\ReleaseJavaObject", "Int", vmID, JABVariables["acType"], ac, "Cdecl")
    }
}

IsSameObject(vmID, ac1, ac2)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        Return DllCall(JABVariables["JAB_DLLVersion"] "\isSameObject", "Int", vmID, JABVariables["acType"], ac1, JABVariables["acType"], ac2, "Cdecl Int")
    }
    else
    {
        Return 0
    }
}

; retrieves the root element from a window
GetAccessibleContextFromHWND(hwnd, ByRef vmID, ByRef ac)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        Return DllCall(JABVariables["JAB_DLLVersion"] "\getAccessibleContextFromHWND", "Int", hWnd, "Int*", vmID, JABVariables["acPType"], ac, "Cdecl Int")
    }
    else
    {
        Return 0
    }
}

GetHWNDFromAccessibleContext(vmID, ac)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        Return DllCall(JABVariables["JAB_DLLVersion"] "\getHWNDFromAccessibleContext", "Int", vmID, JABVariables["acType"], ac, "Cdecl UInt")
    }
    else
    {
        Return 0
    }
}

GetAccessibleContextAt(vmID, acParent, x, y, ByRef ac)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        Return DllCall(JABVariables["JAB_DLLVersion"] "\getAccessibleContextAt", "Int", vmID, JABVariables["acType"], acParent, "Int", x, "Int", y, JABVariables["acPType"], ac, "Cdecl Int")
    }
    else
    {
        Return 0
    }
}

GetAccessibleContextWithFocus(hwnd, ByRef vmID, ByRef ac)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        vmid:=0
        ac:=0
        Return DllCall(JABVariables["JAB_DLLVersion"] "\getAccessibleContextWithFocus", "Int", hwnd, "Int*", vmID, JABVariables["acPType"], ac, "Cdecl Int")
    }
    else
    {
        Return 0
    }
}

GetObjectDepth(vmID, ac)
{
    global JABVariables
    depth:=0
    if (JABVariables["JABInitialised"])
    {
        depth:=DllCall(JABVariables["JAB_DLLVersion"] "\getObjectDepth", "Int", vmID, JABVariables["acType"], ac, "Cdecl Int")
    }
    Return depth
}

GetAccessibleParentFromContext(vmID, ac)
{
    global JABVariables
    acparent:=0
    if (JABVariables["JABInitialised"])
    {
        acparent:=DllCall(JABVariables["JAB_DLLVersion"] "\getAccessibleParentFromContext", "Int", vmID, JABVariables["acType"], ac, "Cdecl "JABVariables["acType"])  
    }
    Return, acparent
}

GetAccessibleChildFromContext(vmID, ac, index)
{
    global JABVariables
    acchild:=0
    if (JABVariables["JABInitialised"])
    {
        acchild:=DllCall(JABVariables["JAB_DLLVersion"] "\getAccessibleChildFromContext", "Int", vmID, JABVariables["acType"], ac, "Int", index, "Cdecl "JABVariables["acType"])  
    }
    Return, acchild
}

; retrieves information about a certain element as an object with the keys:
; Name, Description, Role_local, Role, States_local, States, Index in parent,
; Children count, X, Y, Width, Height, Accessible component, Accessible action,
; Accessible selection, Accessible text, Accessible value interface,
; Accessible action interface, Accessible component interface,
; Accessible selection interface, Accessible table interface,
; Accessible text interface, Accessible hypertext interface
GetAccessibleContextInfo(vmID, ac)
{
    global JABVariables
    TempInfo:=Object()
    if (JABVariables["JABInitialised"])
    {
        VarSetCapacity(Info, 6188,0)
        if (DllCall(JABVariables["JAB_DLLVersion"] "\getAccessibleContextInfo", "Int", vmID, JABVariables["acType"], ac, "Ptr", &Info, "Cdecl Int"))
        {
            verstr:=""
            Loop, % JABVariables["MAX_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2
                jver:=Chr(NumGet(&Info,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr.= jver
            }
            TempInfo["Name"]:=verstr
            verstr:=""
            Loop, % JABVariables["MAX_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2+JABVariables["MAX_STRING_SIZE"]*2
                jver:=Chr(NumGet(&Info,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            TempInfo["Description"]:=verstr
            verstr:=""
            Loop, % JABVariables["SHORT_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2+JABVariables["MAX_STRING_SIZE"]*4
                jver:=Chr(NumGet(&Info,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            TempInfo["Role_local"]:=verstr
            verstr:=""
            Loop, % JABVariables["SHORT_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2+JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*2
                jver:=Chr(NumGet(&Info,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            TempInfo["Role"]:=verstr
            verstr:=""
            Loop, % JABVariables["SHORT_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2+JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*4
                jver:=Chr(NumGet(&Info,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            TempInfo["States_local"]:=verstr
            verstr:=""
            Loop, % JABVariables["SHORT_STRING_SIZE"]
            {
                offset:=(A_Index-1)*2+JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*6
                jver:=Chr(NumGet(&Info,offset,"UChar"))
                if (jver=Chr(0))
                {
                    break
                }
                verstr:=verstr jver
            }
            TempInfo["States"]:=verstr
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Index in parent"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+4
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Children count"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+8
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["X"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+12
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Y"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+16
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Width"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+20
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Height"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+24
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Accessible component"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+28
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Accessible action"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+32
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Accessible selection"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+36
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Accessible text"]:=jver
            offset:=JABVariables["MAX_STRING_SIZE"]*4+JABVariables["SHORT_STRING_SIZE"]*8+40
            jver:=NumGet(&Info,offset,"Int")
            TempInfo["Accessible value interface"]:=jver & 1
            TempInfo["Accessible action interface"]:=jver & 2
            TempInfo["Accessible component interface"]:=jver & 4
            TempInfo["Accessible selection interface"]:=jver & 8
            TempInfo["Accessible table interface"]:=jver & 16
            TempInfo["Accessible text interface"]:=jver & 32
            TempInfo["Accessible hypertext interface"]:=jver & 64
        }
        else
        {
            msgbox, Error in GetAccessibleContextInfo vmID: %vmID% ac: %ac%
        }
    }
    Return TempInfo
}

GetVisibleChildrenCount(vmID, ac)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        Return DllCall(JABVariables["JAB_DLLVersion"] "\getVisibleChildrenCount", "Int", vmID, JABVariables["acType"], ac, "Cdecl Int")
    }
    else
    {
        Return 0
    }
}

; this function seems to be unreliable under Win7 64bit
; works fine under WinXP
GetVisibleChildren(vmID, ac)
{
    global JABVariables
    Children:=Object()
    if (JABVariables["JABInitialised"])
    {
        NumChild:=getVisibleChildrenCount(vmID, ac)
        StartChild:=0
        cnt:=0
        VarSetCapacity(TempChildren, 257*JABVariables["acSize"],0)
        Loop
        {
            if (DllCall(JABVariables["JAB_DLLVersion"] "\getVisibleChildren", "Int", vmID, JABVariables["acType"], ac, "Int", StartChild, "Ptr", &TempChildren, "Cdecl Int"))
            {
                retchild:=NumGet(&TempChildren,0,"Int")
                str:=retchild ";;"
                Loop, %retchild%
                {
                    Children[++cnt]:=Numget(&TempChildren, JABVariables["acSize"]*(A_Index), JABVariables["acType"])
                }
                StartChild:=StartChild+retchild
            }
            else break
        } Until StartChild>=NumChild
    }
    Return Children
}

GetAccessibleActions(vmID, ac)
{
    global JABVariables
    Actret:=Object()
    if (JABVariables["JABInitialised"])
    {
        VarSetCapacity(Actions, 256*256*2+A_PtrSize,0)
        if DllCall(JABVariables["JAB_DLLVersion"] "\getAccessibleActions", "Int", vmID, JABVariables["acType"], ac, "Ptr", &Actions, "Cdecl Int")
        {
            retact:=NumGet(&Actions,0,"Int")
            Loop, % retact
            {
                verstr:=""
                lind:=A_Index
                Loop, % JABVariables["SHORT_STRING_SIZE"]
                {
                    offset:=(A_Index-1)*2+JABVariables["SHORT_STRING_SIZE"]*2*(lind-1)+A_PtrSize
                    jver:=Chr(NumGet(&Actions,offset,"UChar"))
                    if (jver=Chr(0))
                    {
                        break
                    }
                    verstr.= jver
                }
                Actret[A_Index]:=verstr
            }
        }
    }
    Return Actret  
}

DoAccessibleActions(vmID, ac, ByRef actionsToDo)
; actionsToDo : comma separated list of actions
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        VarSetCapacity(Actions, 256*256*2+A_PtrSize,0)
        Loop, Parse, actionsToDo, `,, %A_Space%
        {
            NumPut(A_Index,&Actions,0,"Int")
            lind:=A_Index
            Loop, Parse, A_LoopField
            {
                offset:=(A_Index-1)*2+JABVariables["SHORT_STRING_SIZE"]*2*(lind-1)+A_PtrSize
                NumPut(Asc(A_LoopField),&Actions,offset,"UChar")
            }
        }
        failure:=0
        DllCall( JABVariables["JAB_DLLVersion"] "\doAccessibleActions", "Int", vmID , JABVariables["acType"], ac , "Ptr", &Actions , "Int", failure, "Cdecl Int")
        return, failure
    }
}

RequestFocus(vmID, ac)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        return DllCall(JABVariables["JAB_DLLVersion"] "\requestFocus", "Int", vmID, JABVariables["acType"], ac, "Cdecl Int")
    }
}


; callback set routines
; see access bridge documentation for definitions of callback funtions
;
; usage:
;
; if InitJavaAccessBridge()
; {
;   Address := RegisterCallback("FocusGained","CDecl")
;   setFocusGainedFP(Address)
; }
; ...
; Return
;
; FocusGained(vmID, event, source)
; {
;   DoSomething(vmID, source)
;   ReleaseJavaObject(vmID,event)
;   ReleaseJavaObject(vmID,source)
; }


setFocusGainedFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setFocusGainedFP", "UInt", fp, "Cdecl")
    }
}

setFocusLostFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setFocusLostFP", "UInt", fp, "Cdecl")
    }
}

setJavaShutdownFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setJavaShutdownFP", "UInt", fp, "Cdecl")
    }
}

setCaretUpdateFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setCaretUpdateFP", "UInt", fp, "Cdecl")
    }
}

setMouseClickedFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setMouseClickedFP", "UInt", fp, "Cdecl")
    }
}

setMouseEnteredFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setMouseEnteredFP", "UInt", fp, "Cdecl")
    }
}

setMouseExitedFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setMouseExitedFP", "UInt", fp, "Cdecl")
    }
}

setMousePressedFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setMousePressedFP", "UInt", fp, "Cdecl")
    }
}

setMouseReleasedFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setMouseReleasedFP", "UInt", fp, "Cdecl")
    }
}

setMenuCanceledFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setMenuCanceledFP", "UInt", fp, "Cdecl")
    }
}

setMenuDeselectedFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setMenuDeselectedFP", "UInt", fp, "Cdecl")
    }
}

setMenuSelectedFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setMenuSelectedFP", "UInt", fp, "Cdecl")
    }
}

setPopupMenuCanceledFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPopupMenuCanceledFP", "UInt", fp, "Cdecl")
    }
}

setPopupMenuWillBecomeInvisibleFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPopupMenuWillBecomeInvisibleFP", "UInt", fp, "Cdecl")
    }
}

setPopupMenuWillBecomeVisibleFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPopupMenuWillBecomeVisibleFP", "UInt", fp, "Cdecl")
    }
}

setPropertyNameChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyNameChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyDescriptionChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyDescriptionChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyStateChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyStateChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyValueChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyValueChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertySelectionChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertySelectionChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyTextChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyTextChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyCaretChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyCaretChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyVisibleDataChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyVisibleDataChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyChildChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyChildChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyActiveDescendentChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyActiveDescendentChangeFP", "UInt", fp, "Cdecl")
    }
}

setPropertyTableModelChangeFP(fp)
{
    global JABVariables
    if (JABVariables["JABInitialised"])
    {
        DllCall(JABVariables["JAB_DLLVersion"] "\setPropertyTableModelChangeFP", "UInt", fp, "Cdecl")
    }
}


/*
functions that have not been ported yet

{ exported user functions of the Java Access Bridge }

{ AccessibleTable }
function getAccessibleTableInfo(vmID: longint; ac: AccessibleContext; tableinfo: PAccessibleTableInfo):JBool;
function getAccessibleTableCellInfo(vmID: longint; at: AccessibleTable; row: jint; column: jint; tableCellInfo: PAccessibleTableCellInfo):JBool;
function getAccessibleTableRowHeader(vmID: longint; acParent: AccessibleContext; tableInfo: PAccessibleTableInfo):JBool;
function getAccessibleTableColumnHeader(vmID: longint; acParent: AccessibleContext; tableinfo: PAccessibleTableInfo):JBool;
function getAccessibleTableRowDescription(vmID: longint; acParent: AccessibleContext; row: jint):AccessibleContext;
function getAccessibleTableColumnDescription(vmID: longint; acParent: AccessibleContext; column: jint):AccessibleContext;
function getAccessibleTableRowSelectionCount(vmID: longint; table: AccessibleTable):jint;
function isAccessibleTableRowSelected(vmID: longint; table: AccessibleTable; row: jint):Jbool;
function getAccessibleTableRowSelections(vmID: longint; table: AccessibleTable; count: jint; selections: pjint):JBool;
function getAccessibleTableColumnSelectionCount(vmID: longint; table: AccessibleTable):Jint;
function isAccessibleTableColumnSelected(vmID: longint; table: AccessibleTable; column: jint):JBool;
function getAccessibleTableColumnSelections(vmID: longint; table: AccessibleTable; count: jint; selections: pjint):JBool;
function getAccessibleTableRow(vmID: longint; table: AccessibleTable; index: jint):jint;
function getAccessibleTableColumn(vmID: longint; table: AccessibleTable; index: jint):jint;
function getAccessibleTableIndex(vmID: longint; table: AccessibleTable; row: jint; column: jint):jint;

{ AccessibleRelationSet }
function getAccessibleRelationSet(vmID: longint; ac: AccessibleContext; relationSetInfo: PAccessibleRelationSetInfo):JBool;

{ AccessibleHypertext }
function getAccessibleHypertext(vmID: longint; ac: AccessibleContext; hypertextInfo: PAccessibleHypertextInfo):JBool;
function activateAccessibleHyperlink(vmID: longint; ac: AccessibleContext; aH: AccessibleHyperlink):JBool;
function getAccessibleHyperlinkCount(vmID: longint; ac: AccessibleContext):Jint;
function getAccessibleHypertextExt(vmID: longint; ac: AccessibleContext; nStartIndex: jint; hypertextInfo: PAccessibleHypertextInfo):JBool;
function getAccessibleHypertextLinkIndex(vmID: longint; ah: AccessibleHypertext; nIndex: jint):jint;
function getAccessibleHyperlink(vmID: longint; ah: AccessibleHypertext; nIndex: jint; hyperlinkInfo: PAccessibleHyperlinkInfo):JBool;

{ Accessible KeyBindings, Icons and Actions }
function getAccessibleKeyBindings(vmID: longint; ac: AccessibleContext; keyBindings: PAccessibleKeyBindings):JBool;
function getAccessibleIcons(vmID: longint; ac: AccessibleContext; icons: PAccessibleIcons):JBool;

{ AccessibleText }
function GetAccessibleTextInfo(vmID: longint; at: AccessibleText; textInfo: PAccessibleTextInfo; x: jint; y: jint):JBool;
function GetAccessibleTextItems(vmID: longint; at: AccessibleText; textitems: PAccessibleTextItemsInfo; index: jint):JBool;
function GetAccessibleTextSelectionInfo(vmID: longint; at: AccessibleText; textselection: PAccessibleTextSelectionInfo):JBool;
function GetAccessibleTextAttributes(vmID: longint; at: AccessibleText; index: jint; attributes: PAccessibleTextAttributesInfo):JBool;
function GetAccessibleTextRect(vmID: longint; at: AccessibleText; rectinfo: PAccessibleTextRectInfo; index: jint):JBool;
function GetAccessibleTextLineBounds(vmID: longint; at: AccessibleText; index: jint; startindex: Pjint; endIndex: pjint):JBool;
function GetAccessibleTextRange(vmID: longint; at: AccessibleText; startr: jint; endr: jint; textr: pwidechar; len: jshort):JBool;
function GetCurrentAccessibleValueFromContext(vmID: longint; av: AccessibleValue; value: pwidechar; len: jshort):JBool;
function GetMaximumAccessibleValueFromContext(vmID: longint; av: AccessibleValue; value: pwidechar; len: jshort):JBool;
function GetMinimumAccessibleValueFromContext(vmID: longint; av: AccessibleValue; value: pwidechar; len: jshort):JBool;

procedure AddAccessibleSelectionFromContext(vmID: longint; acsel: AccessibleSelection; i: Jint);
procedure ClearAccessibleSelectionFromContext(vmID: longint; acsel: AccessibleSelection);
function GetAccessibleSelectionFromContext(vmID: longint; acsel: AccessibleSelection; i: jint):JObject;
function GetAccessibleSelectionCountFromContext(vmID: longint; acsel: AccessibleSelection):Jint;
function IsAccessibleChildSelectedFromContext(vmID: longint; acsel: AccessibleSelection; i: Jint):Jbool;
procedure RemoveAccessibleSelectionFromContext(vmID: longint; acsel: AccessibleSelection; i: Jint);
procedure SelectAllAccessibleSelectionFromContext(vmID: longint; acsel: AccessibleSelection);

{ Utility methods }

function setTextContents(vmID: longint; ac: AccessibleContext; test: pwidechar):JBool;
function getParentWithRole(vmID: longint; ac: AccessibleContext; role: pwidechar):AccessibleContext;
function getParentWithRoleElseRoot(vmID: longint; ac: AccessibleContext; role: pwidechar):AccessibleContext;
function getTopLevelObject(vmID: longint; ac: AccessibleContext):AccessibleContext;
function getActiveDescendent(vmID: longint; ac: AccessibleContext):AccessibleContext;
function getVirtualAccessibleName(vmID: longint; ac: AccessibleContext; name: pwidechar; len: integer):JBool;
function requestFocus(vmID: longint; ac: AccessibleContext):JBool;
function selectTextRange(vmID: longint; ac: AccessibleContext; startIndex: integer; endIndex: integer):JBool;
function getTextAttributesInRange(vmID: longint; ac: AccessibleContext; startIndex: integer; endIndex: integer; attributes: PAccessibleTextAttributesInfo; len: Jshort): JBool;
function setCaretPosition(vmID: longint; ac: AccessibleContext; position: Jint):JBool;
function getCaretLocation(vmID: longint; ac: AccessibleContext; rectInfo: PAccessibleTextRectInfo; index: JInt):JBool;
function getEventsWaiting():Jint;