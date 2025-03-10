#Persistent
#NoEnv
#SingleInstance Force

!F3::
    InputBox, timeUntil, Set Timer, Enter the time (in seconds) before pinning the window:
    if (timeUntil = "" || timeUntil <= 0)  ; Ensure valid input
        return

    WinGet, activeWindow, ID, A  ; Get the current active window
    SetTimer, PinWindow, % timeUntil * 1000  ; Start the timer
    return

PinWindow:
    SetTimer, PinWindow, Off
    WinSet, AlwaysOnTop, On, ahk_id %activeWindow%  ; Pin the window (Always on Top)
    return
