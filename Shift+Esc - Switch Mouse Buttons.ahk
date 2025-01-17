; Toggle variable
SwapMouse := false

; Alt + Esc toggles the swap
+Esc::
SwapMouse := !SwapMouse
if (SwapMouse) {
    Hotkey, LButton, RightClick, On
    Hotkey, RButton, LeftClick, On
    ToolTip, Mouse Buttons Swap: ON
} else {
    Hotkey, LButton, RightClick, Off
    Hotkey, RButton, LeftClick, Off
    ToolTip, Mouse Buttons Swap: OFF
}
SetTimer, RemoveToolTip, -1000 ; Remove tooltip after 1 second
return

; Swapped functionality
RightClick:
Click Right
return

LeftClick:
Click Left
return

; Remove tooltip after delay
RemoveToolTip:
ToolTip
return
