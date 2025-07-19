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
}
return


Alt & F5::
{
    InputBox, userInput, Enter Text, Please enter the text:
    if (!ErrorLevel) ; Check if user didn't cancel the input box
    {
        StringLower, userInput, userInput
        currentGame := userInput
        tooltip(%currentGame%, 2000)
    }
    Gosub, SwitchMouseButtons
    return
}
return


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


handleKey(key) {
    if (InStr(currentGame, "wow"))
        keys_warcraft(key)
    else
        send_keystroke(key)
}
return


; lastChar := {WheelUp}
; command1 := "{Shift down}" . lastChar . "{Shift up}"
; $+p::
;     Send {Shift down}
;     SendEvent 4
;     Send {Shift up}
;     return

; SendEvent, {WheelUp}
; return

$i:: handleKey("i")  ; Rotation
$+i:: handleKey("si")  ; BIG-Rotation
$o:: handleKey("o")  ; Poison
$p:: handleKey("p")  ; AOE

$4:: handleKey(4)  ; DEFENSE
$+4:: handleKey("s4")  ; BIG-DEFENSE
$5:: handleKey(5)  ; HEAL
$+5:: handleKey("s5")  ; BIG-Heal
$6:: handleKey(6)  ; Enrage

$7:: handleKey(7)  ; Slow/Stun
$8:: handleKey(8)  ; Weaken-Enemy
$9:: handleKey(9)  ; Interrupt/Stun
return

; !+WheelDown::SendEvent {Blind}{WheelDown}
; !+WheelUp::SendEvent {Blind}{WheelUp}


;* WHEN:
;? "Shift + Scroll Down"
; Shift + Scroll Down (Ctrl + Shift + WheelDown)
;
global scrollD_keyActive := false
~+WheelDown::  ; ">" represents Shift, "^" represents Ctrl
if (GetKeyState("Alt", "P")) {
    return  ; Do nothing if Alt is pressed - let Shift+Alt+WheelUp pass through normally
}
if (currentGame = "warframe")
{
    if (scrollD_keyActive)
        SetTimer, sh_scrollD_StopKey, Off
    else {
        scrollD_keyActive := true
        SendEvent {n Down}
    }
    SetTimer, sh_scrollD_StopKey, -400
} else if (SubStr(currentGame, 1, 3) = "wow")
{
    if (!scrollD_keyActive) {
        scrollD_keyActive := true

        SendEvent {Blind}{WheelDown}
        SetTimer, sh_scrollD_StopKey, -400
    }
} else {
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
; Shift + Scroll Up (Ctrl + Shift + Up)
;
global scrollUp_keyActive := false
~+WheelUp::  ; ">" represents Shift, "^" represents Ctrl
if (GetKeyState("Alt", "P")) {
    return  ; Do nothing if Alt is pressed - let Shift+Alt+WheelUp pass through normally
}
if (SubStr(currentGame, 1, 3) = "wow")
{
    if (!scrollUp_keyActive) {
        scrollUp_keyActive := true

        SendEvent {Blind}{WheelUp}
        SetTimer, sh_scrollUp_StopKey, -400
    }
} else {
    SendEvent {Blind}{WheelUp}
}
return
;
;
sh_scrollUp_StopKey:
scrollUp_keyActive := false
SetTimer, sh_scrollUp_StopKey, Off
return


~Shift Up::
if (currentGame = "warframe")
    {
        if (A_PriorHotkey = "~Shift Up" && A_TimeSincePriorHotkey < 300) {
            SendEvent {m}
        }
    }
return

