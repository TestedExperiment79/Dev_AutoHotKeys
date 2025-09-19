; Enable hidden window detection
DetectHiddenWindows, On


I_Icon = %A_ScriptDir%\__Assets\Icons\icon_google_translate_1.ico
IfExist, %I_Icon%
Menu, Tray, Icon, %I_Icon%

; Global variable to store the locked window handle
global TargetWindow := ""
global TrayIconHwnd := ""

; Special Keys
>^F1::
  ; If no window has been locked yet, lock onto the current window
  if (TargetWindow = "") {
    TargetWindow := WinExist("A")
    if (TargetWindow) {
      MinimizeToTray(TargetWindow)
    }
  }
  ; If a window has been locked, always toggle the same window
  else {
    ToggleWindow(TargetWindow)
  }
return

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

