; Start as ADMIN
if not A_IsAdmin
{
    ; Run the script again as admin
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp ; Exit the current instance
}

; --- ---

#Include %A_ScriptDir%\Switch_Warcraft.ahk
#Include %A_ScriptDir%\Helpers.ahk

; --- ---

global currentGame := ""
global keyTimer := 100

; Basic Window in Black
^+z::SendEvent, ^{y}


~F4::  ; RESET Keyboard State
{
    ; Release modifiers
    Send, {Ctrl up}{Shift up}{Alt up}{LWin up}{RWin up}
    ; Add other keys that get stuck (e.g., CapsLock, Enter, Space)
    Send, {CapsLock up}{Enter up}{Space up}

    ; Release all other keys (VK 1-254)
    Loop 254 {
        vk := Format("VK{:02X}", A_Index)
        if GetKeyState(vk)  ; Key is logically down
        {
            Send, {%vk% up}  ; Release it
        }
    }
    TrayTip, Keyboard Reset, All keys released., 1, 17
    tooltip("KEYS have been reset", 1000)

    ;$ Reloads the ENTIRE Script
    Reload
}
return


; Alt & F5::
Alt & Delete::
{
    InputBox, userInput, Enter Text, Please enter the text:
    if (!ErrorLevel) ; Check if user didn't cancel the input box
    {
        StringLower, userInput, userInput
        currentGame := userInput
        tooltip(%currentGame%, 2000)
        basic_settings()
    }
    Gosub, SwitchMouseButtons
    return
}
return
; F3::
;     popup_image("bottomLeft", "death_horseman_1.png")
;     popup_image("bottomRight", "death_horseman_2.png")
; Return


basic_settings() {
    if (InStr(currentGame, "wow")) {
        if (InStr(currentGame, "druid")) {
            stance := "human"
            counter_druidCat_rotation := 0

        } else if (InStr(currentGame, "rogue")) {
            stance := "visible"

        }
    }

    if (InStr(currentGame, "wow_horserider_death")) {
        popup_image("topLeft", "death_horseman_4.jpg", "w-1 h520")
        popup_image("bottomLeft", "death_horseman_1.png")
        popup_image("bottomRight", "death_horseman_2.png")
        popup_image("center", "death_horseman_5.png", "w-1 h520")
        ; SoundPlay, FilePath [, Wait]
        ; popup_image("topRight", "death_horseman_2.png")
        ; popup_image("center", "death_horseman_1.png")
    } else if (InStr(currentGame, "odin")) {
        play_audio("odin_4_i_am.mp3")

        popup_image("bottomLeft", "odin_1_american_gods_s1.png", time = 2000)
        popup_image("bottomRight", "odin_2.jpeg", "w620 h-1", 2000)
    }
}


; F2::
; Menu, MySubmenu, Add, Item1
; Menu, Tray, Add, This menu item is a submenu, :MySubmenu
; return


SwitchMouseButtons:
if (currentGame = "poe") {
    ; Path OF Exiles
    Hotkey, LButton, RightClick, On
    Hotkey, RButton, LeftClick, On
} else {
    Hotkey, LButton, RightClick, Off
    Hotkey, RButton, LeftClick, Off
}
return

; Swapped functionality
RightClick:
Click Right
return

LeftClick:
Click Left
return



F1::
{
    if (currentGame = "warframe")
        SendEvent, y
    else if (SubStr(currentGame, 1, 3) = "wow")
        SendEvent, {F1}
    else
        SendEvent, {F1}
}
return


;! Possible Key Detection:
; the "P" in GetKeyState("LControl", "P") or whatever
; is not the "P" key, is just part of the command
; ---
; GetKeyState("LControl", "P") || GetKeyState("RControl", "P")
; GetKeyState("LAlt", "P") || GetKeyState("RAlt", "P")
; GetKeyState("LShift", "P") || GetKeyState("RShift", "P")
; GetKeyState("CapsLock", "P")
; GetKeyState("LWin", "P") || GetKeyState("RWin", "P")
;
;
;* WHEN:
;? "U"
global u_keyActive := false
; ???
; *$U::
; $*U::

; Good for "Warframe" + "General"
; *U::
; Good for "Warcraft"
~*U::
; `~` (don't block the native key event)
; `*` (fire the hotkey even if extra modifiers are held)
; `$` (block script-loops of this key / block script from triggering itself)
; `U` (the u key)
; Remove individual modifier hotkeys and handle everything in main U hotkey
if (currentGame = "warframe")
{
    if (GetKeyState("CapsLock", "P") || GetKeyState("RAlt", "P")) {
        SendEvent, {CapsLock up}
        SendEvent, {RControl up}
        SendEvent, h

    } else if (GetKeyState("LControl", "P")) {
        SendEvent, {LControl up}
        SendEvent, j

    } else if (GetKeyState("LWin", "P") || GetKeyState("RControl", "P")) {
        SendEvent, {LWin up}
        SendEvent, {RControl up}
        SendEvent, b

    } else if (u_keyActive == false) {
        u_keyActive := true
        SendEvent, {Blind}{u down}
        ; SetTimer, u_StopKey, Off
    }
} else if (SubStr(currentGame, 1, 3) = "wow") {
    return
} else {
    ; if (u_keyActive == false) {
    ;     u_keyActive := true
    ;     SendEvent, {Blind}{u down}
    ;     ; SetTimer, u_StopKey, Off
    ; }
    return
    ; SetTimer, u_StopKey, Off
} ; Otherwise, do nothing and let Windows handle "U" normally
; SetTimer, u_StopKey, -%keyTimer%
;
return
;
;

; u_StopKey:
; if (!GetKeyState("U", "P")) {
;     u_keyActive := false
;     SendEvent, {u Up}
;     SetTimer, u_StopKey, Off
; }
*u up::
    SendEvent, {u Up}
    ; SendEvent, {Blind}{u Up}
    u_keyActive := false
return



; ----------



; lastChar := {WheelUp}
; command1 := "{Shift down}" . lastChar . "{Shift up}"
; $+p::
;     Send {Shift down}
;     SendEvent 4
;     Send {Shift up}
;     return

; SendEvent, {WheelUp}
; return


handleKey(key) {
    if (InStr(currentGame, "wow"))
        keys_warcraft(key)

    else ; Writing Normally

        ; Shift + Number
        if (InStr(key, "s") and RegExMatch(key, "\d")) {
            lastChar := SubStr(key, 0)
            SendEvent {Blind}{%lastChar%}

        } ; Number
        else if (RegExMatch(key, "\d")) {
            SendEvent {Blind}{%key%}

        } ; Shift + CapsLock
        else if (InStr(key, "s") and GetKeyState("CapsLock", "T")) {
            lastChar := SubStr(key, 0)
            SendEvent {%lastChar%}


        } ; Shift + NO-CapsLock
        else if (GetKeyState("CapsLock", "T")) {
            lastChar := SubStr(key, 0)
            SendEvent {LShift down}{%lastChar%}{LShift up}

        } ; Shift + Letter
        else if (InStr(key, "s")) {
            lastChar := SubStr(key, 0)
            SendEvent {Blind}{%lastChar%}

        } ; Default - just send the key
        else {
            send_keystroke(key)
        }
}
return


$i:: handleKey("i")  ; Roller
$+i:: handleKey("si")  ; Stance - Single-target
; $^i:: handleKey("ci")  ; BIG-Rotation

$o:: handleKey("o")  ; Poison
$+o:: handleKey("so")  ; Weaken-Enemy - (Place Debuffs)
; $^o:: handleKey("co")  ; Stance - Poison

; !o:: handleKey("ao")  ; Remove-Strengths-of-Enemy (Remove Buffs)
; !o:: tooltip("hello",2000)  ; Remove-Strengths-of-Enemy (Remove Buffs)
$p:: handleKey("p")  ; AOE
; $^p:: handleKey("cp")  ; Stance - AOE


$4:: handleKey(4)  ; DEFENSE
$+4:: handleKey("s4")  ; BIG-DEFENSE
$5:: handleKey(5)  ; HEAL
$+5:: handleKey("s5")  ; BIG-Heal
$^5:: handleKey("c5")
$6:: handleKey(6)  ; Enrage

$7:: handleKey(7)  ; Slow/Stun
$+7:: handleKey("s7")  ; Slow/Stun
$8:: handleKey(8)  ; Weaken-Enemy
$+8:: handleKey("s8")  ; Weaken-Enemy
$9:: handleKey(9)  ; Interrupt/Stun
$+9:: handleKey("s9")  ; Interrupt/Stun

$j:: handleKey("j")  ; Go to Target
$k:: handleKey("k")  ; Taunt Target

$0:: handleKey(0)  ; Interrupt/Stun
XButton1:: handleKey("👈") ; This is mouse button 4 (usually back)
XButton2:: handleKey("👉") ; This is mouse button 5 (usually forth)

; !+WheelDown::SendEvent {Blind}{WheelDown}
; !+WheelUp::SendEvent {Blind}{WheelUp}


;* WHEN:
;? "Shift + Scroll Down"
; Shift + Scroll Down (Ctrl + Shift + WheelDown)
;
global scrollD_keyActive := false
; `~` (don't block the native key event)
; $~+WheelDown::  ; ">" represents Shift, "^" represents Ctrl

$+WheelDown::  ; ">" represents Shift, "^" represents Ctrl
; if (!GetKeyState("Ctrl", "P") and (GetKeyState("Alt", "P") or GetKeyState("CapsLock", "P"))) {
;     ; SendEvent {Alt}{Shift}{WheelUp}
;     ; SendInput !+WheelUp
;     tooltip("Down", 2000)
;     SendEvent {Alt down}{Shift down}{WheelDown}{Shift up}{Alt up}
;     ; SendEvent {Shift Alt down}{WheelUp}{Shift Alt up}
;     return  ; Do nothing if Alt is pressed - let Shift+Alt+WheelUp pass through normally
; }
if (currentGame = "warframe")
{
    if (scrollD_keyActive)
        SetTimer, sh_scrollD_StopKey, Off
    else {
        scrollD_keyActive := true
        SendEvent {n Down}
    }
    SetTimer, sh_scrollD_StopKey, -400
} else if (InStr(currentGame, "wow"))
{
    if ((GetKeyState("CapsLock", "P") or GetKeyState("Alt", "P")) and GetKeyState("Shift", "P")) {
        SendEvent {Blind}{WheelDown}
    } else {
        handleKey("s👇")
    }
} else {
    ; tooltip("shift used", 2000)
    SendEvent {Blind}{WheelDown}
}
return
;
;
sh_scrollD_StopKey:
scrollD_keyActive := false
SendEvent, {n Up}
SetTimer, sh_scrollD_StopKey, Off
return



;* WHEN:
;? "Shift + Scroll Up"
$+WheelUp::  ; "+" represents Shift, "^" represents Ctrl
if (InStr(currentGame, "wow"))
{
    if ((GetKeyState("CapsLock", "P") or GetKeyState("Alt", "P")) and GetKeyState("Shift", "P")) {
        SendEvent {Blind}{WheelUp}
    } else {
        handleKey("s👆")
    }
} else {
    SendEvent {Blind}{WheelUp}
}
return


;* WHEN:
;? "Scroll Up"
;
$WheelUp::  ; ">" represents Shift, "^" represents Ctrl
; if (GetKeyState("Alt", "P")) {
;     return  ; Do nothing if Alt is pressed - let Shift+Alt+WheelUp pass through normally
; }
if (GetKeyState("Alt", "P") or GetKeyState("CapsLock", "P")) {
    ; SendEvent {Alt}{WheelUp}
    handleKey("a👆")
    return  ; Do nothing if Alt is pressed - let Shift+Alt+WheelUp pass through normally
}
if (InStr(currentGame, "wow"))
{
    handleKey("👆")
} else {
    ; tooltip("Hello", 2000)
    SendEvent {Blind}{WheelUp}
}
return


;* WHEN:
;? "Scroll Down"
;
$WheelDown::  ; ">" represents Shift, "^" represents Ctrl
; if (GetKeyState("Alt", "P")) {
;     return  ; Do nothing if Alt is pressed - let Shift+Alt+WheelDown pass through normally
; }
if (GetKeyState("Alt", "P") or GetKeyState("CapsLock", "P")) {
    ; SendEvent {Alt}{WheelDown}
    handleKey("a👇")
    return  ; Do nothing if Alt is pressed - let Shift+Alt+WheelDown pass through normally
}
if (InStr(currentGame, "wow"))
{
    handleKey("👇")
} else {
    ; tooltip("Hello", 2000)
    SendEvent {Blind}{WheelDown}
}
return



~Shift Up::
if (currentGame = "warframe")
    {
        if (A_PriorHotkey = "~Shift Up" && A_TimeSincePriorHotkey < 300) {
            SendEvent {m}
        }
    }
return

