global currentGame := ""

Alt & F5::
{
    InputBox, userInput, Enter Text, Please enter the text:
    if (!ErrorLevel) ; Check if user didn't cancel the input box
    {
        StringTrimLeft, userInput, userInput, 0
        StringTrimRight, userInput, userInput, 0
        StringLower, userInput, userInput
        currentGame := userInput
        ToolTip, %currentGame%
        SetTimer, RemoveToolTip, -2000 ; Tooltip disappears after 2 seconds
    }
    return
}

F1::
{
    if (currentGame = "warframe")
        SendEvent, y
    else if (currentGame = "warcraft")
        SendEvent, {F1}
    else
        SendEvent, {F1}
    return
}

Alt & U::
{
    if (currentGame = "warframe")
        SendEvent, h
    else
        SendEvent, !u
    return
}

RemoveToolTip:
ToolTip
return
