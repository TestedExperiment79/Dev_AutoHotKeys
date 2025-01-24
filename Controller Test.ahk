#Persistent
SetTimer, CheckJoystick, 10
Return

CheckJoystick:
    Loop, 32  ; Check up to 32 joystick buttons
    {
        GetKeyState, state, Joy%a_index%
        if (state = "D") ; "D" means the button is pressed down
        {
            ToolTip, Button %a_index% Pressed
            Return
        }
    }
    ToolTip  ; Clear the tooltip when no button is pressed
Return
