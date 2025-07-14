#Persistent
#NoEnv
#SingleInstance Force


!F3::
    InputBox, targetTime, Set Timer, Enter the time to pin the window (e.g., 6:17pm or 2:56am):
    if (targetTime = "")  ; Ensure valid input
        return

    ; Convert input to a timestamp
    targetTimestamp := ConvertToTimestamp(targetTime)
    if (targetTimestamp = "") {
        MsgBox, Invalid time format. Use HH:MMam/pm (e.g., 6:17pm)
        return
    }

    ; Get the current time and calculate the delay
    currentTimestamp := A_Now
    currentTimestamp := ConvertToTimestamp(A_Hour ":" A_Min A_Space (A_Hour < 12 ? "am" : "pm"))

    ; If the target time is earlier than the current time, schedule for the next day
    if (targetTimestamp <= currentTimestamp)
        targetTimestamp += 86400  ; Add 24 hours in seconds

    delay := targetTimestamp - currentTimestamp

    ; Get the active window
    WinGet, activeWindow, ID, A
    SetTimer, PinWindow, % delay * 1000  ; Start the timer
    return

PinWindow:
    SetTimer, PinWindow, Off
    WinSet, AlwaysOnTop, On, ahk_id %activeWindow%  ; Pin the window (Always on Top)
    return

ConvertToTimestamp(timeStr) {
    FormatTime, nowDate, , yyyyMMdd
    DateTimeString := nowDate " " timeStr
    ParseTime, DateTimeString, OutputVar
    return OutputVar
}
