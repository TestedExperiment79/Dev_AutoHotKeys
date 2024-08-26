Alt & F5:: openObs()

openObs()
{
	IfWinExist ahk_class Qt643QWindowIcon
		Send {LAlt Down}{f5 Down} {LAlt Up}{f5 Up}
		; winactivate ahk_class Qt643QWindowIcon
	else
		Run, "C:\Program Files\obs-studio\bin\64bit\obs64.exe" , C:\Program Files\obs-studio\bin\64bit
	WinWaitActive ahk_class Qt643QWindowIcon
}
