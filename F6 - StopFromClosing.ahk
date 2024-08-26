; #NoTrayIcon
global isEnabled:=False

return


F6::

WinGet, Id, Id, A

execute(id)

Return

!F4::
WinGet, Id, Id, A
closeWindow(A)
Return



execute(id) {
  isEnabled:=!isEnabled

  if (isEnabled = False)
  {
    enableClosing(id)
  } else {
    disableClosing(id)
  }
}

closeWindow(A) {
  if (isEnabled = False)
  {
    WinClose A
  }
}



disableClosing(id) ;By RealityRipple at http://www.xtremevbtalk.com/archive/index.php/t-258725.html
{
  Static isEnabled:=False
  menu:=DllCall("user32\GetSystemMenu","UInt",id,"UInt",0)

  DllCall("user32\DeleteMenu","UInt",menu,"UInt",0xF060,"UInt",0x0)

  WinGetPos,x,y,w,h,ahk_id %id%

  WinMove,ahk_id %id%,,%x%,%y%,%w%,% h-1

  WinMove,ahk_id %id%,,%x%,%y%,%w%,% h+1

}



enableClosing(id) ;By Mosaic1 at http://www.xtremevbtalk.com/archive/index.php/t-258725.html

{

  Static isEnabled:=True
  menu:=DllCall("user32\GetSystemMenu","UInt",id,"UInt",1)

  DllCall("user32\DrawMenuBar","UInt",id)

}