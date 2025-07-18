

global on_global_cooldown := false
global time_gcd := 650



global priest := {}
priest["i"] := "ai;o;i"
priest["o"] := "s9;si"

priest[4] := "4"
priest["s4"] := "s4;a4"
priest[5] := "c5;5;s5;a5"
priest["s5"] := "s5;a5"
priest[6] := "ai;o;i"

priest[8] := "8;c8;7;c7"
priest[9] := "9;c9;8;c8;s4;a4;4"


keys_warcraft(key) {
  ; ignore key, if ON global cooldown
  if (on_global_cooldown) {
    return
  } else {
    ; start global cooldown
    on_global_cooldown := true
  }


  ; ; In Case -Of- General "WOW"
  ; if (currentGame = "wow") {
  ;   send_keystroke(key)
  ; } else { ; In Case -Of- Class/Spec "WOW"
  ; wow_dh_i()
  ; wow_war_i()


  ; tooltip(StrLen(key), 2000)
  ; tooltip(key, 2000)
  temp1 := priest[key]
  tooltip(temp1, 2000)

  if (InStr(currentGame, "priest")) {
    send_listOf_keystrokes(priest[key])
  } else {
    send_keystroke(key)
  }


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


  ; Sync - Wait-for - Global Cooldown
  SetTimer, timer_global_cooldown, -%time_gcd%
}
;
;
timer_global_cooldown:
on_global_cooldown := false
SetTimer, timer_global_cooldown, Off
return



; --- ---


; ✅ - [ PRIEST - Shadow ]

  ; ROTATION
  wow_priest_i() {
    SendEvent {Alt down}i{Alt up}
    SendEvent {o}
    SendEvent {i}
  }

  ; BIG-DICK - ROTATION
  wow_priest_si() {
    ; NO-STOP-Casting
    ; --- Empower
    wow_priest_6()
    ; --- Actual BIG-DICK - ROTATION ---
    SendEvent 0
    SendEvent 6
    ; --- basic rotation ---
    wow_priest_i()
  }

  ; POISON
  wow_priest_o() {
    SendEvent {Shift down}9{Shift up}
    SendEvent {Shift down}i{Shift up}
  }

  ; AOE
  ; wow_priest_p() {
  ;   SendEvent 8
  ; }

  ; DEFEND
  wow_priest_4() {
    ; 6s - Defense 1
    SendEvent {4}
  }

  ; HEAL
  wow_priest_5() {
    ; 15s - Heal 2
    SendEvent {Ctrl down}5{Ctrl up}
    ; 0s - Heal 1
    SendEvent 5
    ; 15s - Heal 2
    SendEvent {Shift down}5{Shift up}
    SendEvent {Alt down}5{Alt up}
  }

  ; ENRAGE
  wow_priest_6() {
    SendEvent {Ctrl down}6{Ctrl up}
    SendEvent {Shift down}6{Shift up}
  }

  ; Weaken Enemy
  wow_priest_7() {
    ; Helper 1
    SendEvent {0}
  }

  ; SLOW/STUN
  wow_priest_8() {
    ; Slow 1
    SendEvent {8}
    ; Slow 2
    SendEvent {Ctrl down}8{Ctrl up}
    ; Stun 1
    SendEvent {7}
    ; Stun 2
    SendEvent {Ctrl down}7{Ctrl up}
  }

  ; INTERRUPT/STUN
  wow_priest_9() {
    ; Interrupt 1
    SendEvent {9}
    ; Interrupt 2
    SendEvent {Ctrl down}9{Ctrl up}
    ; Stun 1
    SendEvent 8
    ; Stun 2
    SendEvent {Ctrl down}8{Ctrl up}
    ; Magic-Defense 1
    SendEvent {Shift down}4{Shift up}
    ; Magic-Defense 2
    SendEvent {Alt down}4{Alt up}
    ; Defense 1
    SendEvent 4
  }

; 🏁 - [ DH - Havoc ]

; ✅ - [ DH - Havoc ]

  wow_dh_i() {
    ; 1.5m - The Hunt
    SendEvent {Ctrl down}{WheelUp}{Ctrl up}
    ; 1m - Elysian Decree
    SendEvent {p}
    ; 30s - Sigil of Flame
    SendEvent {Ctrl down}i{Ctrl up}
    ; 14s - Immolation Aura
    SendEvent {o}
    ; 4.3s - Fracture
    SendEvent {i}
    ; 0s - Soul Cleave - (Life Steal)
    SendEvent {5}
  }

  wow_dh_4() {
    ; 45s - Fiery Brand
    SendEvent {Ctrl down}4{Ctrl up}
    ; 20s - Demon Spikes
    SendEvent {4}
  }

; 🏁 - [ DH - Havoc ]


; ✅ - [ Warrior - Fury ]

  wow_war_i() {
    ; 1.5m - Champion's Spear
    SendEvent {Shift down}{i}{Shift up}
    ; 1.5m - Ravager
    SendEvent {Ctrl down}{p}{Ctrl up}
    ; 45s - Odyn's Fury
    SendEvent {Ctrl down}{o}{Ctrl up}
    ; 4s-Spend - Execute
    SendEvent {Ctrl down}{i}{Ctrl up}
    ; 4s-Spend - Rampage
    SendEvent {p}
    ; 4s - Bloodthirst
    SendEvent {5}
    ; 6s - Raging Blow
    SendEvent {i}
    ; 0s - Whirlwind
    SendEvent {o}
  }

; 🏁 - [ Warrior - Fury ]
