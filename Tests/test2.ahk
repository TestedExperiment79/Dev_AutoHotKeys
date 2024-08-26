Shift & x:: switchWindow()

switchWindow()
{
	WinGet, wowid, List, World of Warcraft
	ControlSend,, 3, % "wowid " . WinExist("World")
	ControlSend,, 3, ahk_id %wowid1%
	ControlSend, ahk_id, {3}, WORLD OF WARCRAFT
	; Send, {ALT DOWN}{TAB}{ALT UP}
	ControlSend,, 3, % "wowid " . WinExist("World")
}

Shift & o:: switchWindow2()

switchWindow2()
{
	ControlSend,, 3, ahk_id %wowid1%
	ControlSend, ahk_id, {3}, WORLD OF WARCRAFT
	Send, {ALT DOWN}{TAB}{ALT UP}
}


WinGet, wowid, list, World of Warcraft

Shift & f::
KeyWait, 2, D
	ControlSend,, 3, ahk_id %wowid1%
	ControlSend,, 3, ahk_id %wowid2%
Return
