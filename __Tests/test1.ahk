

F6:: GoToHealer()

GoToHealer()
{
	WinGetActiveTitle, Title
	InputBox, UserInput, Change Title To..., Please enter new window title
	MsgBox, Your active window is %Title%
	MsgBox, %UserInput%
	WinSetTitle, [color=red]%Title%,,%UserInput%[/color]
}


Shift & 2:: renameWindow()

renameWindow(targetWindow := "A")
{
	WinSetTitle, "HeyHo"
}





