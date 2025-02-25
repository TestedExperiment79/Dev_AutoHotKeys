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
    else if (currentGame = "warcraft")
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
*U::
; else:
; Just Keeps it pressed
if (currentGame = "warframe")
{
    if (GetKeyState("CapsLock", "P") || GetKeyState("RControl", "P"))
        SendEvent, h

    else if (GetKeyState("LControl", "P"))
        SendEvent, j

    else if (u_keyActive == false) {
        u_keyActive := true
        SendEvent, {Blind}{u down}
    }
} else {
    SendEvent, {Blind}{u down}
} ; Otherwise, do nothing and let Windows handle "U" normally
SetTimer, u_StopKey, -%keyTimer%
;
return
;
;
u_StopKey:
if (!GetKeyState("U", "P")) {
    u_keyActive := false
    SendEvent, {u Up}
    SetTimer, u_StopKey, Off

    ; confirm it went down
    Sleep, 50
    SendEvent, {u Up}
}
return



;* WHEN:
;? "Shift + Scroll Down"
; Shift + Scroll Down (Ctrl + Shift + WheelDown)
;
global scrollD_keyActive := false
+WheelDown::  ; ">" represents Shift, "^" represents Ctrl
if (currentGame = "warframe")
{
    if (scrollD_keyActive)
        SetTimer, sh_scrollD_StopKey, Off
    else {
        scrollD_keyActive := true
        SendEvent {n Down}
    }
    SetTimer, sh_scrollD_StopKey, -400
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

