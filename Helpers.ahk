
RemoveToolTip:
ToolTip
return

tooltip(message, time) {
  ToolTip, %message%
  SetTimer, RemoveToolTip, -%time% ; Tooltip disappears after 2 seconds
}


; --- ---


send_keystroke(key) {
  if (StrLen(key) < 2) {
    SendEvent {%key%}
  }

  lastChar := SubStr(key, 0)
  untilLastChar := SubStr(key, 1, -1)


  if (InStr(untilLastChar, "c")) {
    SendEvent {Ctrl down}{%lastChar%}{Ctrl up}

  } else if (InStr(untilLastChar, "s")) {
    SendEvent {Shift down}{%lastChar%}{Shift up}

  } else if (InStr(untilLastChar, "a")) {
    SendEvent {Alt down}{%lastChar%}{Alt up}

  }
}

send_listOf_keystrokes(list_keys) {
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

