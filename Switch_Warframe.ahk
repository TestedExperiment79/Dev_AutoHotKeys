


#Include %A_ScriptDir%\Helpers.ahk


; Receive - Close THIS script from Another Script:
OnMessage(0x5555, "ExitSelf")

ExitSelf(wParam, lParam, msg, hwnd) {
    ExitApp
}


; --- ---

F3::tooltip("hello there", 2000)

; --- ---


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
*U::
; Good for "Warcraft"
; ~*U::
; `~` (don't block the native key event)
; `*` (fire the hotkey even if extra modifiers are held)
; `$` (block script-loops of this key / block script from triggering itself)
; `U` (the u key)
; Remove individual modifier hotkeys and handle everything in main U hotkey
if (GetKeyState("CapsLock", "P") || GetKeyState("RAlt", "P") || GetKeyState("RAlt", "P")) {
    ; SendEvent, {CapsLock up}
    ; SendEvent, {RControl up}
    SendEvent, h

} else if (GetKeyState("LControl", "P")) {
    ; SendEvent, {LControl up}
    SendEvent, j

} else if (GetKeyState("LWin", "P") || GetKeyState("RControl", "P")) {
    ; SendEvent, {LWin up}
    ; SendEvent, {RControl up}
    SendEvent, b

} else if (u_keyActive == false) {
    u_keyActive := true
    SendEvent, {Blind}{u down}
    ; SetTimer, u_StopKey, Off
}
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

