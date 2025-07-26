

global on_global_cooldown := false
global time_gcd := 650


; --- ---


global shadow := {}
shadow["i"] := "ai;o;i"
; shadow["i"] := "ai;a;b;c"
shadow["o"] := "si"
shadow["p"] := "s9;sp"

shadow[4] := "4"
shadow["s4"] := "s4;a4"
shadow[5] := "c5;5;s5;a5"
shadow["s5"] := "s5;a5"
shadow[6] := "c6;a6;6"

shadow[8] := "8;c8;7;c7"
shadow[9] := "9;c9;8;c8;s4;a4;4"

; Needs "shadow[6]" to be created first
shadow["si"] := shadow[6] . ";0;" . shadow["i"]



global havoc := {}
havoc["i"] := "co;ci;p;o;i"

havoc[4] := "c4;4"
havoc[5] := "5;c5"
havoc[6] := "6"

havoc["si"] := havoc[6] . ";" . havoc["i"]


global fury := {}
; fury["i"] := "si;cp;co;ci;p;5;i;o"
fury["i"] := "p;5;o;👆;i"
fury["👆"] := fury["i"]


fury[4] := "4;c4"
fury[5] := "c5;5"
fury[6] := "5;c6"

fury[7] := "7;c7"
fury[8] := "8;c8"
fury[9] := "9;c9"


global frost_dk := {}
frost_dk["i"] := "p;o;i;co"
frost_dk["o"] := "👆"


global shaman := {}
; shaman["i"] := "p;o;i;co"
shaman["👆"] := "ci;p;i;7;o"


global warlock := {}
; shaman["i"] := "p;o;i;co"
; warlock["👆"] := "ci;p;i;7;o"
warlock["👆"] := "sp;ci;6;o;i"

warlock["i"] := "p"
warlock["o"] := "si"

warlock["4"] := "4"
warlock["5"] := "a5"
warlock["6"] := "co"

warlock["si"] := warlock["6"] . ";" . warlock["👆"]

; --- ---


keys_warcraft(key) {
  ; ignore key, if ON global cooldown
  ; tooltip(key, 2000)
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


  ; tooltip(StrLen(key), 2000)
  ; tooltip(key, 2000)

  if (InStr(currentGame, "shadow")) {
    temp_listKeystrokes := shadow[key]

  } else if (InStr(currentGame, "havoc")) {
    temp_listKeystrokes := havoc[key]

  } else if (InStr(currentGame, "fury")) {
    temp_listKeystrokes := fury[key]

  } else if (InStr(currentGame, "frost_dk")) {
    temp_listKeystrokes := frost_dk[key]

  } else if (InStr(currentGame, "shaman")) {
    temp_listKeystrokes := shaman[key]

  } else if (InStr(currentGame, "warlock")) {
    temp_listKeystrokes := warlock[key]

  }  else {
    send_keystroke(key)
    return
  }

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

