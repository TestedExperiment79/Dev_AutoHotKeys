; Start as ADMIN
if not A_IsAdmin
{
    ; Run the script again as admin
    Run *RunAs "%A_ScriptFullPath%"
    ExitApp ; Exit the current instance
}

; --- ---


global currentGame := ""
global keyTimer := 100

RemoveToolTip:
ToolTip
return

; Basic Window in Black
^+z::SendEvent, ^{y}


Alt & F5::
{
    InputBox, userInput, Enter Text, Please enter the text:
    if (!ErrorLevel) ; Check if user didn't cancel the input box
    {
        StringLower, userInput, userInput
        currentGame := userInput
        ToolTip, %currentGame%
        SetTimer, RemoveToolTip, -2000 ; Tooltip disappears after 2 seconds
    }
    Gosub, MakeChanges
    return
}


MakeChanges:
if (currentGame = "poe") {
    ; Path OF Exiles
    Hotkey, LButton, RightClick, On
    Hotkey, RButton, LeftClick, On
} else {
    Hotkey, LButton, RightClick, Off
    Hotkey, RButton, LeftClick, Off
}

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
    return
}


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
;
global u_keyActive := false
~*U::
; else:
; Just Keeps it pressed
if (currentGame = "warframe")
{
    if (GetKeyState("CapsLock", "P") || GetKeyState("RControl", "P"))
        SendEvent, h

    else if (GetKeyState("LControl", "P"))
        SendEvent, j

    else if (GetKeyState("LWin", "P") || GetKeyState("RControl", "P"))
        SendEvent, b

    else if (u_keyActive == false) {
        u_keyActive := true
        SendEvent, {Blind}{u down}
        ; SetTimer, u_StopKey, Off
    }
} else if (SubStr(currentGame, 1, 3) = "wow") {
    return
} else {
    if (u_keyActive == false) {
        u_keyActive := true
        SendEvent, {Blind}{u down}
        ; SetTimer, u_StopKey, Off
    }
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


;* WHEN:
$i:: ; ATTACK
if (SubStr(currentGame, 1, 3) = "wow")
{
    if (currentGame = "wow-dh") {
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
} else {
    SendEvent {i}
}
return

;* WHEN:
$4:: ;
if (SubStr(currentGame, 1, 3) = "wow")
{
    if (currentGame = "wow-dh") {
        ; 45s - Fiery Brand
        SendEvent {Ctrl down}4{Ctrl up}
        ; 20s - Demon Spikes
        SendEvent {4}
    }
} else {
    SendEvent {Blind}{4}
}
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

