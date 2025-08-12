#Include %A_ScriptDir%\Switch_Wow_Variables.ahk


; global on_debug := false
global on_debug := true


global on_global_cooldown := false
global time_gcd := 700

global stance := "human"

; --- ---

global counter_druidCat_rotation := 0

; --- ---

handle_druid_keystroke(key) {
  timing := 700
  tooltip(stance, timing, on_debug)


  if (key = "👆") {
    if (stance = "bear") {
      ; tooltip("A-bear", timing, on_debug)
      return druid_bear_👆

    } else if (stance = "cat") {
      ; counter_druidCat_rotation := counter_druidCat_rotation + 1
      counter_druidCat_rotation++
      if (counter_druidCat_rotation < 3) {
        return druid_cat_👆
      } else {
        return druid_cat_👆_spender
      }
      ; tooltip(counter_druidCat_rotation, timing)
      ; tooltip("A-cat", timing, on_debug)

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


handle_rogue_stance(key) {
  ; -Stance- Single-Target
  if ("ci" = key) {
    rogue["i"] := rogue_i_single
  } ; -Stance- Poison
  else if ("co" = key) {
    rogue["i"] := rogue_i_poison
  } ; -Stance- AOE
  else if ("cp" = key) {
    rogue["i"] := rogue_i_aoe
  }
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

  ;! MAXed Classes HAVE TO BE AT THE TOP
  ; because if they are lower then the others, the other's will be picked up first
  if (InStr(currentGame, "max_fury")) {
    temp_listKeystrokes := max_fury[key]

  }
  ; ---------------------------------------------------
  else if (InStr(currentGame, "wow_shadow")) {
    temp_listKeystrokes := shadow[key]

  } else if (InStr(currentGame, "wow_havoc")) {
    temp_listKeystrokes := havoc[key]

  } else if (InStr(currentGame, "wow_fury")
            or InStr(currentGame, "wow_horserider_death")) {
    temp_listKeystrokes := fury[key]

  } else if (InStr(currentGame, "wow_frost_dk")) {
    temp_listKeystrokes := frost_dk[key]

  } else if (InStr(currentGame, "wow_shaman")) {
    temp_listKeystrokes := shaman[key]

  } else if (InStr(currentGame, "wow_warlock")) {
    temp_listKeystrokes := warlock[key]

  } else if (InStr(currentGame, "wow_druid"
            or InStr(currentGame, "wow_odin"))) {
    ; Check Stance Change
    handle_druid_stance(key)
    temp_listKeystrokes := handle_druid_keystroke(key)
    ; tooltip(stance, 1000, true)

  } else if (InStr(currentGame, "wow_rogue")) {
    ; Check Stance Change
    handle_rogue_stance(key)
    temp_listKeystrokes := rogue[key]

  } else {
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

