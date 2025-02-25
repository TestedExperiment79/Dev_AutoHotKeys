; Initialize variables
scrollActive := false
scrollStopTimer := 400 ; Stop scrolling after 400 milliseconds of no scroll
featureEnabled := false ; Tracks whether the feature is toggled on
scrollKey := "n" ; Default key for scrolling

; Shift + Scroll Down (Ctrl + Shift + WheelDown)
+WheelDown::
HandleScrollDown(scrollKey)
return

<^Esc::
featureEnabled := !featureEnabled
if (featureEnabled) {
    Tooltip, Scroll Cooldown: ON
} else {
    Tooltip, Scroll Cooldown: OFF
}
SetTimer, RemoveTooltip, -2000 ; Tooltip disappears after 2 seconds
return

; Function to handle scroll down
HandleScrollDown(key) {
    global featureEnabled

    if (featureEnabled) {
        FeatureScroll(key)
    } else {
        SendEvent {WheelDown}
    }
}

; Function for custom scroll behavior
FeatureScroll(key) {
    global scrollActive, scrollStopTimer

    if (scrollActive) {
        SetTimer, StopScrollDown, Off
    } else {
        ; Start sending the specified key repeatedly
        scrollActive := true
        SendEvent {%key% Down}
    }
    ; Reset stop timer on each scroll
    SetTimer, StopScrollDown, -%scrollStopTimer%
}

; Function to stop sending the specified key after timeout
StopScrollDown:
scrollActive := false
SendEvent {%scrollKey% Up}
return

; Function to remove the tooltip
RemoveTooltip:
Tooltip
return
