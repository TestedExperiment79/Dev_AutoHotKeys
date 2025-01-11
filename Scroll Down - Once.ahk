; Initialize variables
scrollCooldown := false
featureEnabled := false ; Tracks whether the feature is toggled on
waitingTime := 500

; Toggle the feature on/off with F1
F1::
featureEnabled := !featureEnabled
if (featureEnabled) {
    Tooltip, Scroll Cooldown: ON
} else {
    Tooltip, Scroll Cooldown: OFF
}
SetTimer, RemoveTooltip, -2000 ; Tooltip disappears after 1 second
return

; Plain Scroll Down Hotkey
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


; Function to handle the scroll down action with cooldown
HandleScrollDown() {
    global scrollCooldown, featureEnabled

    if (featureEnabled && !scrollCooldown) {
        ; Execute the scroll down action
        SendEvent {WheelDown}

        ; Set cooldown to true to block further scrolls
        scrollCooldown := true

        ; Start a timer to reset cooldown after 2 seconds
        SetTimer, ResetScrollCooldown, -%waitingTime%
    } else if (!featureEnabled) {
        ; If the feature is off, scroll normally
        SendEvent {WheelDown}
    }
}


; Function to reset the cooldown
ResetScrollCooldown:
scrollCooldown := false
return

; Function to remove the tooltip
RemoveTooltip:
Tooltip
return
