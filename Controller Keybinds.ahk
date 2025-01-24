#Persistent
SetTimer, CheckTriggers, 100
Return

CheckTriggers:
    GetKeyState, Z, JoyZ  ; Check the Z-axis value (adjust if needed)
    
    if (Z < 40) ; R2 pressed
    {
        ; ToolTip, R2 Trigger Pressed! (Value: %Z%)
        SendEvent {x}
    }
    ; else if (Z > 60) ; L2 pressed
    ; {
    ;     ToolTip, L2 Trigger Pressed! (Value: %Z%)
    ; }
    ; else
    ; {
    ;     ToolTip  ; Clear tooltip (nothing pressed)
    ; }
Return
