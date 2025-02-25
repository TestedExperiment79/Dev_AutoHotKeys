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
    return
}

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
;* Whenever "U" is Pressed
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

return
;
;
u_StopKey:
if (!GetKeyState("U", "P")) {
    u_keyActive := false
    SendEvent, {u Up}
    SetTimer, u_StopKey, Off
}
return

