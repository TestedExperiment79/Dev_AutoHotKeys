
RemoveToolTip:
ToolTip
return

tooltip(message, time) {
  ToolTip, %message%
  SetTimer, RemoveToolTip, -%time% ; Tooltip disappears after 2 seconds
}


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

  if (key = "👆") {
    ; tooltip("Entered this bitch", 2000)
    SendEvent, {Ctrl up}{Shift up}{Alt up}{LWin up}{RWin up}{WheelUp}

  } else if (key = "👇") {
    SendEvent, {Ctrl up}{Shift up}{Alt up}{LWin up}{RWin up}{WheelDown}

  } else if (hasCtrl and hasShift and hasAlt) {
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
      SendEvent, {Alt down}{Shift down}{WheelUp}{Shift up}{Alt up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Alt down}{Shift down}{WheelDown}{Shift up}{Alt up}
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
    SendEvent, % lastChar
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

