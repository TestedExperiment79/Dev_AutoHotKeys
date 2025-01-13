; Initialize variables
scrollActive := false
scrollCooldown := false
scrollStopTimer := 500 ; Stop scrolling after 500 milliseconds of no scroll

; Scroll Down Hotkey
WheelDown::
if (!scrollActive && !scrollCooldown) {
    ; Start holding scroll down (simulate pressing it)
    scrollActive := true
    Send {WheelDown down} ; Hold WheelDown
}
; Reset stop timer on each scroll
SetTimer, StopScrollDown, -%scrollStopTimer%
return

; Function to stop holding WheelDown after 500 ms of no scroll
StopScrollDown:
if (scrollActive) {
    Send {WheelDown up} ; Release WheelDown when no scroll occurs for 500ms
    scrollActive := false
}
return
