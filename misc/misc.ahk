!x::Suspend
LButton::
Loop
{
SetMouseDelay 1
Click
If (GetKeyState("LButton","P")=0)
Break
}



;move mouse
;^Space::
;  CoordMode, Mouse, Screen ; mouse coordinates relative to the screen
;  MouseGetPos, MouseX, MouseY
;  if (MouseX > A_ScreenWidth) {
;    MouseMove, -A_ScreenWidth, 0, 0, R
;  } else {
;    MouseMove, A_ScreenWidth, 0, 0, R
;  }
;return







; make Insert key to hide (minimize) current window
;$Insert::WinMinimize, A





;^SPACE::  Winset, Alwaysontop, , A












;#F20::!Tab
;return




;#F20::Send {LWin}
;return




   
;#F20::Run Onenote ; Single click, Open OneNote
;#F19::Send, {Shift down}{LWin down}s{Shift up}{LWin up} ; Double click, Take a screenshot into onenote (hotkey created by onenote)
;#F18::Send, {Control down}{Shift down}{Alt down}x{Control up}{Shift up}{Alt up} ; Hold button to trigger snippet tool (hotkey created within Windows)

