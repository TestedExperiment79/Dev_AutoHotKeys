
RemoveToolTip:
ToolTip
return

tooltip(message, time, debug := true) {
  if (debug) {
    ToolTip, %message%
    SetTimer, RemoveToolTip, -%time% ; Tooltip disappears after 2 seconds
  }
}


InArray(haystack, needle) {
  for _, value in haystack {
    if (value = needle)  ; Case-insensitive
      return true
  }
  return false
}


play_audio(file_name = "odin_3_ravens_wolves.mp3"
, location = "C:\Users\RJ\Development\Utils\AutoHotkeys\game_assets\sounds\") {
    sound_url := location . file_name

    ; Waits for audio to finish
    ; SoundPlay, %sound_url%, WAIT

    ; Does NOT Wait for Audio to Finish
    SoundPlay, %sound_url%
}


popup_image(position = "bottomLeft"
, file_name = "death_horseman_1.png"
, img_size = "w1000 h-1"
, time = 1600
, location = "C:\Users\RJ\Development\Utils\AutoHotkeys\game_assets\images\")
{
    img_url := location . file_name

    gui_name := "img_" . position
    Gui, %gui_name%:New  ; Create a new GUI window
    Gui, +AlwaysOnTop -Caption -Border +LastFound  ; +LastFound for WinSet commands
    ; Remove Image white-borders
    Gui, Margin, 0, 0
    ; Shape Size of Image
    Gui, Add, Picture, %img_size%, %img_url%  ; Adjust width/height as needed
    ; Gui, Show, Center, Image Popup  ; Show centered with title

    ; img_show("topLeft")
    ; img_show("bottomLeft")
    ; img_show("bottomRight")
    ; img_show("topRight")
    ; -------
    img_show(position)
    img_show_transparent(200)
    img_show_clickThrough()


    func_closePopup := "ClosePopup_" . position
    ; SetTimer, ClosePopup, % -time  ; Negative runs once; Set self-destruct timer
    ; SetTimer, % Func("ClosePopup").Bind(gui_name), % -time
    ; SetTimer, % Func("ClosePopup"), % -time
    SetTimer, %func_closePopup%, % -time
}

; NEW FUNCTION FOR ROUNDED CORNERS
RoundWindow(Width, Height, CornerRadius := 15) {
    ; Create a rounded rectangle region
    hRgn := DllCall("CreateRoundRectRgn", "Int", 0, "Int", 0, "Int", Width, "Int", Height, "Int", CornerRadius, "Int", CornerRadius)

    ; Apply it to the window
    DllCall("SetWindowRgn", "Ptr", WinExist(), "Ptr", hRgn, "Int", 1)
}

; Close the GUI with Escape
; ClosePopup(gui_name = "hey") {
;   ; SetTimer, ClosePopup, Off
;   Gui, %gui_name%:Destroy
; }

; Close the GUI with Escape
ClosePopup_center() {
  Gui, img_center:Destroy
}
ClosePopup_bottomLeft() {
  Gui, img_bottomLeft:Destroy
}
ClosePopup_bottomRight() {
  Gui, img_bottomRight:Destroy
}
ClosePopup_topLeft() {
  Gui, img_topLeft:Destroy
}
ClosePopup_topRight() {
  Gui, img_topRight:Destroy
}



img_show_transparent(transparent = 200) {
  ; 0-255 - Alpha of Transparency - Image
  WinSet, Transparent, 200
}

img_show_clickThrough() {
    ; Add click-through AFTER setting transparency
    WinSet, ExStyle, +0x20  ; Make click-through after transparency is applied
}

img_show_center() {
    Gui, Show, Center NoActivate, Image NoActivate  ; Show centered with title
}


img_show(location) {
  ; Default TOP position
  posX := 0
  ; Default RIGHT position
  posY := 0


  ; Show hidden to get dimensions
  Gui, Show, Hide, NoActivate
  ; Get image dimensions while hidden
  WinGetPos,,, width, height
  ; Adjust 15 for more/less rounding
  RoundWindow(Width, Height, 15)
  ; Screen dimensions (excludes taskbar)
  SysGet, screen, MonitorWorkArea


  ; CENTER
  if (InStr(location, "center")) {
    Gui, Show, Center NoActivate, Image NoActivate  ; Show centered with title
    return
  }

  ; Calculate BOTTOM position
  if (InStr(location, "bottom"))
    posY := screenBottom - height

  ; Calculate RIGHT position
  if (InStr(location, "Right"))
    posX := screenRight - width


  ; Show at final position
  Gui, Show, x%posX% y%posY% NoActivate
}

; img_show_bottomLeft() {
;     Gui, Show, Hide  ; Show hidden to get dimensions
;     WinGetPos,,, width, height  ; Get image dimensions while hidden

;     ; Calculate bottom-left position
;     SysGet, screen, MonitorWorkArea  ; Screen dimensions (excludes taskbar)
;     posX := 0
;     posY := screenBottom - height

;     ; Show at final position
;     Gui, Show, x%posX% y%posY% NoActivate
; }


; --- ---


send_keystroke(key) {
  ; Send - key with NO Modifier
  if (StrLen(key) < 2) {
    SendEvent, % key
    return
  }
  ; tooltip(key, 2000)


  ; cmd_start := ""
  ; cmd_end := ""
  untilLastChar := SubStr(key, 1, -1)
  lastChar := SubStr(key, 0)

  ; Release modifiers
  Send, {Ctrl up}{Shift up}{Alt up}{LWin up}{RWin up}
  ; Add other keys that get stuck (e.g., CapsLock, Enter, Space)
  Send, {CapsLock up}

  hasCtrl := InStr(untilLastChar, "c")
  hasShift := InStr(untilLastChar, "s")
  hasAlt := InStr(untilLastChar, "a")

  if (hasCtrl and hasShift and hasAlt) {
    ; cmd_start := cmd_start . "{Ctrl down}"
    ; cmd_end := cmd_end . "{Ctrl up}"
    ; SendEvent {Ctrl down}
    if (InStr(key, "👆")) {
      SendEvent, {Ctrl down}{Alt down}{Shift down}{WheelUp}{Shift up}{Alt up}{Ctrl up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Ctrl down}{Alt down}{Shift down}{WheelDown}{Shift up}{Alt up}{Ctrl up}
    } else {
      SendEvent, {Ctrl down}{Alt down}{Shift down}{%lastChar%}{Shift up}{Alt up}{Ctrl up}
    }

  } else if (hasShift and hasAlt) {
    ; cmd_start := cmd_start . "{Ctrl down}"
    ; cmd_end := cmd_end . "{Ctrl up}"
    ; SendEvent {Ctrl down}
    if (InStr(key, "👆")) {
      SendInput !+WheelUp
      ; SendEvent, {Alt down}{Shift down}{WheelUp}{Shift up}{Alt up}
    } else if (InStr(key, "👇")) {
      SendInput !+WheelDown
      ; SendEvent, {Alt down}{Shift down}{WheelDown}{Shift up}{Alt up}
    } else {
      SendEvent, {Alt down}{Shift down}{%lastChar%}{Shift up}{Alt up}
    }

  } else if (hasCtrl and hasShift) {
    ; cmd_start := cmd_start . "{Ctrl down}"
    ; cmd_end := cmd_end . "{Ctrl up}"
    ; SendEvent {Ctrl down}
    if (InStr(key, "👆")) {
      SendEvent, {Shift down}{Ctrl down}{WheelUp}{Ctrl up}{Shift up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Shift down}{Ctrl down}{WheelDown}{Ctrl up}{Shift up}
    } else {
      SendEvent, {Shift down}{Ctrl down}{%lastChar%}{Ctrl up}{Shift up}
    }

  } else if (hasCtrl and hasAlt) {
    ; cmd_start := cmd_start . "{Ctrl down}"
    ; cmd_end := cmd_end . "{Ctrl up}"
    ; SendEvent {Ctrl down}
    if (InStr(key, "👆")) {
      SendEvent, {Ctrl down}{Alt down}{WheelUp}{Alt up}{Ctrl up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Ctrl down}{Alt down}{WheelDown}{Alt up}{Ctrl up}
    } else {
      SendEvent, {Ctrl down}{Alt down}{%lastChar%}{Alt up}{Ctrl up}
    }

  } else if (hasCtrl) {
    ; cmd_start := cmd_start . "{Ctrl down}"
    ; cmd_end := cmd_end . "{Ctrl up}"
    ; SendEvent {Ctrl down}
    if (InStr(key, "👆")) {
      SendEvent, {Ctrl down}{WheelUp}{Ctrl up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Ctrl down}{WheelDown}{Ctrl up}
    } else {
      SendEvent, {Ctrl down}{%lastChar%}{Ctrl up}
    }

  } else if (hasShift) {
    ; cmd_start := cmd_start . "{Shift down}"
    ; cmd_end := cmd_end . "{Shift up}"
    ; SendEvent {Shift down}
    if (InStr(key, "👆")) {
      ; tooltip("Entered this bitch", 2000)
      SendEvent, {Shift down}{WheelUp}{Shift up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Shift down}{WheelDown}{Shift up}
    } else {
      SendEvent, {Shift down}{%lastChar%}{Shift up}
    }

  } else if (hasAlt) {
    ; cmd_start := cmd_start . "{Alt down}"
    ; cmd_end := cmd_end . "{Alt up}"
    if (InStr(key, "👆")) {
      SendEvent, {Alt down}{WheelUp}{Alt up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Alt down}{WheelDown}{Alt up}
    } else {
      SendEvent, {Alt down}{%lastChar%}{Alt up}
    }

  } else {
    if (key = "👆") {
    ; tooltip("Entered this bitch", 2000)
    SendEvent, {Ctrl up}{Shift up}{Alt up}{LWin up}{RWin up}{WheelUp}

    } else if (key = "👇") {
      SendEvent, {Ctrl up}{Shift up}{Alt up}{LWin up}{RWin up}{WheelDown}

    } else if (key = "👈") {
      SendEvent, {XButton1}

    }  else if (key = "👉") {
      SendEvent, {XButton2}

    } else {
      SendEvent, % lastChar
    }
  }
  ;



  ; command := cmd_start . lastChar . cmd_end
  ; tooltip(command, 2000)
  ; SendEvent % cmd_start . lastChar . cmd_end
}



send_listOf_keystrokes(list_keys) {
  ; tooltip(list_keys, 2000)

  ; Check if Only one Keystroke
  if (!InStr(list_keys, ";")) {
    send_keystroke(list_keys)
    return
  }
  ; Split Keystrokes
  keystrokes := StrSplit(list_keys, ";")

  ; Cycle through Keystrokes
  Loop, % keystrokes.Length() {
      singleKeystroke := keystrokes[A_Index]

      send_keystroke(singleKeystroke)
  }
}

