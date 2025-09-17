#Persistent
#InstallKeybdHook
SetTimer, RemoveToolTip, -2000  ; Auto-remove tooltip after 2 seconds

~*WheelUp::ShowPressedKeys()  ; Detect "U" with any combination

ShowPressedKeys() {
    keys := GetPressedKeys()
    ToolTip, % keys
    return
}

GetPressedKeys() {
    pressed := "U"

    if GetKeyState("LControl", "P") || GetKeyState("RControl", "P")
        pressed := "Ctrl + " . pressed
    if GetKeyState("LAlt", "P") || GetKeyState("RAlt", "P")
        pressed := "Alt + " . pressed
    if GetKeyState("LShift", "P") || GetKeyState("RShift", "P")
        pressed := "Shift + " . pressed
    if GetKeyState("CapsLock", "P")
        pressed := "CapsLock + " . pressed
    if GetKeyState("LWin", "P") || GetKeyState("RWin", "P")
        pressed := "Win + " . pressed


    SetTimer, RemoveToolTip, -500
    return pressed
}

RemoveToolTip:
ToolTip
return
