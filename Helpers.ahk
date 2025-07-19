
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


  ; cmd_start := ""
  ; cmd_end := ""
  untilLastChar := SubStr(key, 1, -1)
  lastChar := SubStr(key, 0)

  if (InStr(untilLastChar, "c")) {
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

  } else if (InStr(untilLastChar, "s")) {
    ; cmd_start := cmd_start . "{Shift down}"
    ; cmd_end := cmd_end . "{Shift up}"
    ; SendEvent {Shift down}
    if (InStr(key, "👆")) {
      SendEvent, {Shift down}{WheelUp}{Shift up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Shift down}{WheelDown}{Shift up}
    } else {
      SendEvent, {Shift down}{%lastChar%}{Shift up}
    }

  } else if (InStr(untilLastChar, "a")) {
    ; cmd_start := cmd_start . "{Alt down}"
    ; cmd_end := cmd_end . "{Alt up}"
    if (InStr(key, "👆")) {
      SendEvent, {Alt down}{WheelUp}{Alt up}
    } else if (InStr(key, "👇")) {
      SendEvent, {Alt down}{WheelDown}{Alt up}
    } else {
      SendEvent, {Alt down}{%lastChar%}{Alt up}
    }

  }
  ;



  ; command := cmd_start . lastChar . cmd_end
  ; tooltip(command, 2000)
  ; SendEvent % cmd_start . lastChar . cmd_end
}



send_listOf_keystrokes(list_keys) {
  tooltip(list_keys, 2000)
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

