WinGet, wowid, List, i)\QWow\E


~2::
KeyWait 2
IfWinActive, i)\QWow\E
{
  ControlSend,, 2, ahk_id %wowid1%
  ControlSend,, 2, ahk_id %wowid2%
  Return
}
