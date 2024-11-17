; Enable hidden window detection
DetectHiddenWindows, On

global WindowChosen := false


I_Icon = %A_ScriptDir%\assets\icon_google_translate_1.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%

; Global variable to store the locked window handle
global TargetWindow := ""
global TrayIconHwnd := ""


; Special Keys
!F2::
  ; MsgBox, 64, Alert, Clicked ; TESTING

  ; Detect if window was closed
  if (WindowChosen = True) && !WinExist("ahk_id " . TargetWindow) {
      ; MsgBox, 64, Alert, The chosen window has been closed! ; TESTING
      WindowChosen := False
      TargetWindow := ""
  }

  ; If no window has been locked, lock onto the current window
  if (WindowChosen = False) {
      ; MsgBox, 64, Alert, Locking the current window ; TESTING
      WinGet, Id, Id, A
      disableClosing(Id)
      TargetWindow := WinExist("A")
      WindowChosen := True


      ; Window Across Desktops
      Winget, id, id, A
      WinSet, ExStyle, ^0x80,  ahk_id %id% ; 0x80 is
      if (TargetWindow) {
          MinimizeToTray(TargetWindow)
      }
  } else {
      ; Toggle the target window (minimize/restore)
      ; MsgBox, 64, Alert, Toggling the window ; TESTING
      ToggleWindow(TargetWindow)
  }
return


disableClosing(id) ;By RealityRipple at http://www.xtremevbtalk.com/archive/index.php/t-258725.html
{
  Static isEnabled:=False
  menu:=DllCall("user32\GetSystemMenu","UInt",id,"UInt",0)

  DllCall("user32\DeleteMenu","UInt",menu,"UInt",0xF060,"UInt",0x0)

  WinGetPos,x,y,w,h,ahk_id %id%

  WinMove,ahk_id %id%,,%x%,%y%,%w%,% h-1

  WinMove,ahk_id %id%,,%x%,%y%,%w%,% h+1

}


; Function to minimize the window to the tray
MinimizeToTray(hWnd) {
  WinGetTitle, title, ahk_id %hWnd%

  ; Add the window to the system tray
  hIcon := GetWindowIcon(hWnd)
  Gui, +ToolWindow +AlwaysOnTop +HwndTrayIconHwnd
  Menu, Tray, Add, %title%, RestoreWindow
  Menu, Tray, Icon, %I_Icon%
  Menu, Tray, NoStandard
  WinHide, ahk_id %hWnd%
}

; Function to restore the window from the tray
RestoreWindow() {
  global TargetWindow, TrayIconHwnd
  if (TargetWindow) {
    WinShow, ahk_id %TargetWindow%
    WinActivate, ahk_id %TargetWindow%
    Gui, Destroy
    Menu, Tray, Icon, %I_Icon%
  }
}

; Function to toggle minimize/restore
ToggleWindow(hWnd) {
  if DllCall("IsWindowVisible", "Ptr", hWnd) {
    MinimizeToTray(hWnd)
  } else {
    RestoreWindow()
  }
}

; Function to get the small icon of the window
GetWindowIcon(hWnd) {
  WM_GETICON := 0x007F
  ICON_SMALL := 0
  GCLP_HICONSM := -34
  GetClassLong := "GetClassLong" . (A_PtrSize = 4 ? "" : "Ptr")

  SendMessage, WM_GETICON, ICON_SMALL, 0,, ahk_id %hWnd%
  if !ErrorLevel
    smallIcon := DllCall(GetClassLong, "Ptr", hWnd, "Int", GCLP_HICONSM, "Ptr")
  else
    smallIcon := ErrorLevel
return smallIcon
}

; Ensure all windows are restored when the script exits
OnExit("RestoreWindow")
return

