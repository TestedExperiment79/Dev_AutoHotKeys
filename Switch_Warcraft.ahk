

keys_warcraft(key) {

  ; In Case -Of- General "WOW"
  if (currentGame = "wow") {
    SendEvent {%key%}
  } if (currentGame = "wow-dh") {
    to_execute := Func("wow_dh_" . key)
    to_execute.Call()

  } else if (currentGame = "wow-war") {
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
  return
}

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
