


; Initialize variables
scrollActive := false
scrollStopTimer := 400 ; Stop scrolling after 500 milliseconds of no scroll
featureEnabled := false ; Tracks whether the feature is toggled on


; Scroll Down Hotkey
WheelDown::
HandleScrollDown()
return

; Shift + Scroll Down (Ctrl + Shift + WheelDown)
+WheelDown::  ; ">" represents Shift, "^" represents Ctrl
HandleScrollDown()
return

; Alt + Scroll Down (Alt + WheelDown)
!WheelDown::  ; "!" represents Alt
HandleScrollDown()
return

; Ctrl Right + Scroll Down (Ctrl + Shift + WheelDown)
>^WheelDown::  ; ">" represents Shift, "^" represents Ctrl
HandleScrollDown()
return


<^Esc::
featureEnabled := !featureEnabled
if (featureEnabled) {
    Tooltip, Scroll Cooldown: ON
} else {
    Tooltip, Scroll Cooldown: OFF
}
SetTimer, RemoveTooltip, -2000 ; Tooltip disappears after seconds
return


HandleScrollDown() {
    global featureEnabled

    if (featureEnabled) {
        FeatureScroll()
    } else {
        SendEvent {WheelDown}
    }
}

FeatureScroll() {
    global scrollActive, scrollStopTimer

    if (scrollActive) {
        SetTimer, StopScrollDown, Off

    } else {
        ; Start sending scroll down repeatedly
        scrollActive := true
        SendEvent {c Down}
        SendPlay {WheelDown}
    }
    ; Reset stop timer on each scroll
    SetTimer, StopScrollDown, -%scrollStopTimer%
}

; Function to stop sending WheelDown after 500 ms of no scroll
StopScrollDown:
scrollActive := false
SendEvent {c Up}
return

; Function to remove the tooltip
RemoveTooltip:
Tooltip
return



