#Include %A_ScriptDir%\Switch_Wow_Variables.ahk


; global on_debug := false
global on_debug := true


global on_global_cooldown := false
global time_gcd := 700

global stance := "human"

; --- ---

handle_druid_keystroke(key) {
  timing := 700
  tooltip(stance, timing, on_debug)


  if (key = "👆") {
    if (stance = "bear") {
      ; tooltip("A-bear", timing, on_debug)
      return druid_bear_👆

    } else if (stance = "cat") {
      ; tooltip("A-cat", timing, on_debug)
      return druid_cat_👆

    } else { ; Human Form
      ; tooltip("A-basic", timing, on_debug)
      return druid["👆"]
    }
  } else {
    ; tooltip("A-basic-2", timing, on_debug)
    return druid[key]
  }
}

handle_druid_stance(key) {
  ; -NEUTRAL- Keys - can't change stance
  ; if (InArray(["a👆", "4", "s0"], key)) {
  ;   return
  ; }

  ; ---
  timing := 700

  ; -BEAR- Form
  if (InArray(["0", "s5"], key)) {
    stance := "bear"
    ; tooltip("bear", timing, on_debug)

  } ; -CAT- Form
  else if (InArray(["👉", "s👆", "👇"], key)) {
    stance := "cat"
    ; tooltip("cat", timing, on_debug)

  } ; -HUMAN- Form
  else if (InArray(["👈", "5", "c5", "ai", "aci", "o"], key)) {
    stance := "human"
    ; tooltip("human", timing, on_debug)

  } ; Assume -"HUMAN"- - by Default in Keys
  ; else if (not InStr(key, "👆") and not InStr(key, "i") and not InStr(key, "o") and not InStr(key, "p")) {
  ;   stance := "human"
  ;   ; tooltip("human", 1000, on_debug)
  ; }
}


keys_warcraft(key) {
  ; ignore key, if ON global cooldown
  ; tooltip(key, 2000, on_debug)
  if (on_global_cooldown) {
    return
  } else {
    ; start global cooldown
    on_global_cooldown := true
    ; Sync - Wait-for - Global Cooldown
    SetTimer, timer_global_cooldown, -%time_gcd%
  }


  ; ; In Case -Of- General "WOW"
  ; if (currentGame = "wow") {
  ;   send_keystroke(key)
  ; } else { ; In Case -Of- Class/Spec "WOW"
  ; wow_dh_i()
  ; wow_war_i()


  ; tooltip(StrLen(key), 2000, on_debug)
  ; tooltip(key, 2000, on_debug)

  if (InStr(currentGame, "shadow")) {
    temp_listKeystrokes := shadow[key]

  } else if (InStr(currentGame, "havoc")) {
    temp_listKeystrokes := havoc[key]

  } else if (InStr(currentGame, "fury")) {
    temp_listKeystrokes := fury[key]

  } else if (InStr(currentGame, "frost_dk")) {
    tPOemp_listKeystrokes := frost_dk[key]

  } else if (InStr(currentGame, "shaman")) {
    temp_listKeystrokes := shaman[key]

  } else if (InStr(currentGame, "warlock")) {
    temp_listKeystrokes := warlock[key]

  } else if (InStr(currentGame, "druid")) {
    ; Check Stance Change
    handle_druid_stance(key)
    temp_listKeystrokes := handle_druid_keystroke(key)
    ; tooltip(stance, 1000, true)

  }  else {
    send_keystroke(key)
    return
  }

  ; ---

  if (temp_listKeystrokes = "") {
    temp_listKeystrokes := key
  }
  send_listOf_keystrokes(temp_listKeystrokes)

  ; func_name := currentGame . "_" . key
  ; func_to_execute := Func(func_name)

  ; ; Check Exists + Execute()
  ; if (func_to_execute) {
  ;   ; Execute function_key()
  ;   func_to_execute.Call()  ; Call without parameters
  ; } else {
  ;   ; Default to "Original Keystroke" since function does not Exist
  ;   ; MsgBox Function '%func_name%' not found!
  ;   send_keystroke(key)
  ; }
}
;
;
timer_global_cooldown:
on_global_cooldown := false
SetTimer, timer_global_cooldown, Off
return

