#SingleInstance, Force ; skips the dialog box and replaces the old instance automatically

#n::Run Notepad 

^!s::
Send Sincerely,{enter}John Smith  ; This line sends keystrokes to the active (foremost) window.
return




^Numpad0::
^Numpad1::
MsgBox Pressing either Control+Numpad0 or Control+Numpad1 will display this message.
return 


; A key or key-combination can be disabled for the entire system by having it do nothing. The following example disables the right-side Win key:
; RWin::return

#IfWinActive, ahk_class Notepad
^a::MsgBox You pressed Ctrl-A while Notepad is active. Pressing Ctrl-A in any other window will pass the Ctrl-A keystroke to that window.
#c::MsgBox You pressed Win-C while Notepad is active.

#IfWinActive
#c::MsgBox You pressed Win-C while any window except Notepad is active.

