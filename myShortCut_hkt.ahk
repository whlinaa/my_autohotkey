#SingleInstance, Force ; skips the dialog box and replaces the old instance automatically

; useful command. Disabled because of crash with vscode


; ;^#v  (ctrl+shift+v)
; ;https://autohotkey.com/board/topic/10412-paste-plain-text-and-copycut/page-1
; #IfWinNotActive ahk_class PX_WINDOW_CLASS
; ^+v::                            ; Text–only paste from ClipBoard
;    Clip0 = %ClipBoardAll%
;    ClipBoard = %ClipBoard%       ; Convert to text
;    Send ^v                       ; For best compatibility: SendPlay
;    Sleep 100                      ; Don't change clipboard while it is pasted! (Sleep > 0)
;    ClipBoard = %Clip0%           ; Restore original ClipBoard
;    VarSetCapacity(Clip0, 0)      ; Free memory
; ;#IfWinActive

; # = win
; + = shift
; != alt
; ^= ctrl
; $Insert =Insert key
; CapsLock = capslock key

; #IfWinNotActive 

;--------search highlighted words in various engines------------
;Amazon selected text
#+a::   ;Win+shift+I
   Send, ^c
   Sleep 100
   Run, https://www.amazon.com/s/?field-keywords=%Clipboard%
Return

;Google Image selected text
#+i::   ;Win+shift+I
   Send, ^c
   Sleep 100
   Run, http://www.google.com/images?q=%Clipboard%
Return


;Google Maps selected text
#+m::  ;Win+shift+m
   Send, ^c
   Sleep 100
   Run, https://www.google.com/maps?q=%Clipboard%
Return

;Baidu selected text
#+b::  ;Win+shift+b
   Send, ^c
   Sleep 100
   Run, http://www.baidu.com/s?wd=%Clipboard%
Return

;Google selected text
#+g::  ;Win+shift+g
   Send, ^c
   Sleep 100
   Run, http://www.google.com/search?q=%Clipboard%
Return

;Economist selected text
#+e::  ;Win+shift+g
   Send, ^c
   Sleep 100
   Run, http://www.google.com/search?q=%Clipboard% site:https://www.economist.com
Return

;Google Chinese selected text
#+h::  ;Win+shift+g
   Send, ^c
   Sleep 100
   Run, http://www.google.com/search?q=%Clipboard% Chinese
Return


;Longman selected text
;Win+shift+L
#+l::  
  Send, ^c
  Clipboard := StrReplace(Clipboard, " ", "-")
   Sleep 100
   Run, https://www.ldoceonline.com/dictionary/%Clipboard%
Return

;Farlex selected text
;Win+shift+F
#+f::  
   Send, ^c
   Sleep 100
   Run, https://www.thefreedictionary.com/%Clipboard%
Return

;Cambridge selected text
;Win+shift+C
#+C::  
   Send, ^c
   Sleep 100
   ;clipwait
   Run, https://dictionary.cambridge.org/dictionary/english-chinese-traditional/%Clipboard%
Return

;thesaurus selected text
;Win+shift+C
#+t::  
   Send, ^c
   Sleep 100
   Run, https://www.thesaurus.com/browse/%Clipboard%?s=t
Return

;Youtube selected text
;Win+Y
#+y::  
   Send, ^c
   Sleep 100
   Run, https://www.youtube.com/results?search_query=%Clipboard%
Return

;Scholar selected text
;Win+R
#+r::  
   Send, ^c
   Sleep 100
   Run, http://scholar.google.ch/scholar?hl=en&q=%Clipboard%
Return

;webster selected text
;Win+R
#+w::  
   Send, ^c
   Sleep 100
   Run, https://www.merriam-webster.com/dictionary/%Clipboard%
Return

;dictionary selected text
;Win+R
#+d::  
   Send, ^c
   Sleep 100
   Run, https://www.dictionary.com/browse/%Clipboard%?s=t
Return


#+n::  
   Send, ^c
   Sleep 100
   Run, https://numpy.org/doc/stable/search.html?q=%Clipboard%&check_keywords=yes&area=default
Return


;--------search highlighted words in various engines------------



; Custom volume buttons
; +NumpadAdd:: Send {Volume_Up} ;shift + numpad plus
; +NumpadSub:: Send {Volume_Down} ;shift + numpad minus
NumpadAdd:: Send {Volume_Up} ;shift + numpad plus
NumpadSub:: Send {Volume_Down} ;shift + numpad minus
; break::Send {Volume_Mute} ; Break key mutes


; Hide (minimize) current window
; ^CapsLock::WinMinimize, A ;  ctrl+CapsLock

;  maximize current window
; +CapsLock::WinMaximize, A ;  shift+CapsLock



; press f11 (fullscreen using CapsLock)
;#IfWinActive, ahk_class AcrobatSDIWindow
;CapsLock:: Send, ^h

;#IfWinActive
CapsLock:: Send {F11}



;play/pause
Insert::Send {Media_Play_Pause}
return

;open foobar2k
; PrintScreen::Run "C:\Program Files (x86)\foobar2000\foobar2000.exe"
; return

;open mail app
; Scrolllock::Run "C:\Users\whlin\Documents\AutoHotKey\app\Mail.lnk"
Scrolllock::Run "D:\Documents\AutoHotKey\app\Mail.lnk"
return

; ; open mail app. This shortcut is used when an full-sized keyboard isn't available. Also, 
; #q::
; If WinExist("Mail ahk_class ApplicationFrameWindow", "Mail")
; {
; 	WinActivate
; 	WinMaximize
; }
; else
;    Run "C:\Users\whlin\Documents\AutoHotKey\app\Mail.lnk"
; return

; ;open foobar2k
; #c::
; if WinExist("ahk_exe foobar2000.exe")
; {
; 	WinActivate
; 	WinMaximize
; }
; else
;    Run "C:\Program Files (x86)\foobar2000\foobar2000.exe"
; return

;open adobe acrobat
; Pause::Run "C:\Program Files\Sublime Text 3\sublime_text.exe"
#Esc::Run "C:\Program Files (x86)\Adobe\Acrobat DC\Acrobat\Acrobat.exe"
return


;open sublime 
#F2::Run "C:\Program Files\Sublime Text 3\sublime_text.exe"
; #`::Run "C:\Program Files\Sublime Text 3\sublime_text.exe"
return

#F1:: 
if WinExist("ahk_exe Code.exe") ; https://autohotkey.com/board/topic/7129-run-a-program-or-switch-to-an-already-running-instance/page-2
{
	WinActivate
	WinMaximize
}
else
    Run "C:\Program Files\Microsoft VS Code\Code.exe"
   ;  Run "C:\Users\whlin\AppData\Local\Programs\Microsoft VS Code\Code.exe"
return








; ;open opus
; #Esc:: WinActivate, ahk_class dopus.lister

; ^#e:: WinActivate, ahk_class dopus.lister
; #e:: WinActivate, ahk_class dopus.lister


; !+e:: WinActivate, ahk_class dopus.lister

; !+e::


; IfWinExist, ahk_class dopus.lister
;             ; WinActivate, ahk_class dopus.lister
; ; else
;       Run "C:\Users\whlin\Desktop"
; ; return


;---------open various folders------------
; Open Downloads folder
!+d::Run "C:\Users\whlin\Downloads" ; alt+shift+d
; !+d::Run "C:\Users\whlin\Downloads" ; alt+shift+d

; ; Open desktop folder
#e::Run "C:\Users\whlin\Desktop" ; ctrl+shift+d
; !+e::Run "C:\Users\whlin\Desktop" ; ctrl+shift+d
; !+e::Run "C:\Users\whlin\Documents\folder shortcut" ; ctrl+shift+d
!+e::Run, D:\Documents\folder shortcut, max ; ctrl+shift+d
; ; ^#e::Run "C:\Users\whlin\Desktop" ; ctrl+shift+d

;---------open various folders------------


; Press F1 button to move up a folder in Explorer
#IfWinActive, ahk_class CabinetWClass
; #IfWinActive, ahk_class dopus.lister
F1::Send !{Up} 


return










