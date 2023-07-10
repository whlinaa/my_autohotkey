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


; ;------------------------------------------------------------------

; #noEnv
; #singleInstance, force
; sendMode input

; iniRead, select_after, % a_lineFile, settings, select_after
; iniRead, input_limit,  % a_lineFile, settings, input_limit
; iniRead, delete_limit, % a_lineFile, settings, delete_limit

; iniRead, ini_section, % a_lineFile, wrap list    ; save wraps to variables
; sort, ini_section, F long_lines_first_w
; stringReplace, ini_section, ini_section, % "/``*", % "/*", all    ; remove literals
; stringReplace, ini_section, ini_section, % "*``/", % "*/", all
; loop, parse, % ini_section, `n, `r
;     {
;     occurrence := (inStr(a_loopField, "=", , 1) = 1) ? ("L2") : ("")  ; (if key name is the equals symbol, then L2)
;     stringGetPos, pos, a_loopField, =, % occurrence
;     stringMid, ini_value, a_loopField, pos + 2
;     stringMid, ini_key, a_loopField, pos, , L
;     ini_key   := trim(ini_key)
;     ini_value := trim(ini_value)
;     if (ini_key = "```;") or (ini_key = "``[")    ; remove literals
;         stringTrimLeft, ini_key, ini_key, 1
;     asc := asc(ini_key)    ; convert key character to key number
;     %asc% := ini_value
;     wrap_list .= (wrap_list = "" ? "":"`n") . ini_value
;     }
; ini_section := ""

; return ; end of auto-execute ---------------------------------------------------


; ; #IfWinNotActive ahk_class PX_WINDOW_CLASS
; !w:: goSub, select_wrap
; !+w::goSub, repeat_last_wrap
; ; return 


; select_wrap:
; toolTip, text wrap . . .
; repeat_last_wrap:
; selected := selected_text_w()
; if (a_thisLabel = "select_wrap")
;     {
;     input, key, L%input_limit% T5, {delete}{d}{enter}{esc}
;     key := (key = "") ? strReplace(errorLevel, "EndKey:", "") : key
;     key := (key = "Escape") ? strReplace(key, "Escape", "") : key
;     asc := asc(key)
;     this_wrap := %asc%    ; get wrap stored in key number
;     }

; if (key = "delete") or (key = "d")
;     goSub, remove_wrap
; else if (errorLevel != "Timeout") and if (key != "")
;     {
;     if (this_wrap)
;         split_wrap(this_wrap, l_wrap, r_wrap)
;     else
;         {
;         l_wrap := key
;         r_wrap := key
;         if (strLen(key) > 1)
;             {
;             reversed_string := ""
;             loop, parse, key
;                 reversed_string := a_loopField . reversed_string
;             r_wrap := reversed_string
;             }
;         }
;     paste_text_w(l_wrap . selected . r_wrap)
;     }
; toolTip, ; close
; return


; remove_wrap:
; new_string := ""
; loop, parse, % wrap_list, `n, `r    ; figure out which wrap is being used
;     {
;     split_wrap(a_loopField, l_wrap, r_wrap)
;     if inStr(selected, l_wrap) and inStr(selected, r_wrap)
;         {
;         l_len  := strLen(l_wrap)    ; length of characters
;         r_len  := strLen(r_wrap)
;         l_string := subStr(selected, 1, l_len)    ; take same length from the string
;         r_string := subStr(selected, 1 - r_len, r_len)
;         if (l_wrap = l_string) and (r_wrap = r_string)    ; match found on both sides
;             {
;             new_string := subStr(selected, l_len + 1, strLen(selected) - (l_len + r_len))
;             break
;             }
;         }
;     }
; if (new_string = "")    ; check for matching character on each side
;     {
;     tmp_string := selected
;     loop, % delete_limit
;         {
;         left_char := subStr(tmp_string, 1, 1)
;         right_char := subStr(tmp_string, 0, 1)
;         if (left_char = right_char) and regExMatch(left_char, "[^a-zA-Z0-9]") ; if match and not alphanumeric
;             tmp_string := subStr(tmp_string, 2, strLen(tmp_string) - 2)       ; remove both sides
;         else break
;         }
;     if (tmp_string != selected)    ; if something changed
;         new_string := tmp_string
;     }
; if (new_string)
;     paste_text_w(new_string)
; return


; long_lines_first_w(line_a, line_b, offset) {
;     if strLen(line_b) != strLen(line_a)
;         return strLen(line_b) - strLen(line_a)
;     return -offset
; }


; selected_text_w() {
;     global save_clipboard
;     save_clipboard := clipboardAll
;     clipboard := ""
;     send ^{c}
;     clipWait, 0.1
;     if clipboard is not space
;         return clipboard
; }


; paste_text_w(string) {
;     global
;     clipboard := string
;     send ^{v}
;     sleep 200
;     if (selected = "")
;         send % "{left " strLen(r_wrap) "}"    ; move caret between characters
;     else if (select_after = "true")
;         {
;         if (a_thisLabel = "remove_wrap")      ; select whole string
;             send % "{left " strLen(string) "}+{right " strLen(string) "}"
;         else
;             {
;             stringGetPos, pos, string, % selected    ; select original selection
;             send % "{left " (strLen(string) - pos) "}+{right " strLen(selected) "}"
;             }
;         }
;     sleep 300
;     clipboard := save_clipboard
; }


; split_wrap(wrap_text, byRef l_wrap, byRef r_wrap) {
;     stringGetPos, pos, wrap_text, TXT
;     stringMid, l_wrap, wrap_text, pos, , L
;     stringMid, r_wrap, wrap_text, pos + 4
; }

; /*
; [script info]
; version     = 0.4
; description = wrap selected text in %symbols%
; author      = davebrny
; source      = https://gist.github.com/davebrny/cd98cb10d4c944b065fda67b707cfd0b
; */

; ;-------------------------------------















;#IfWinActive ahk_class Notepad
;#z::
;#IfWinActive ahk_class Chrome
;#z::
;MsgBox You pressed Win+Z in either Notepad or WordPad.
;return



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
^CapsLock::WinMinimize, A ;  ctrl+CapsLock

;  maximize current window
+CapsLock::WinMaximize, A ;  shift+CapsLock



; press f11 (fullscreen using CapsLock)
;#IfWinActive, ahk_class AcrobatSDIWindow
;CapsLock:: Send, ^h

;#IfWinActive
CapsLock:: Send {F11}



;play/pause
Insert::Send {Media_Play_Pause}
return

;open foobar2k
PrintScreen::Run "C:\Program Files (x86)\foobar2000\foobar2000.exe"
return

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

; Open book folder
;^+b::Run "C:\Users\whlin\Desktop\Books" ; ctrl+shift+b
;return

; Open math book folder
;^+m::Run "C:\Users\whlin\Desktop\Books\Math" ; ctrl+shift+m
;return

; Open algorithm book folder
;^+a::Run "C:\Users\whlin\Desktop\Books\Computer ;science\Algorithm" ; ctrl+shift+a
;return

; Open calculus book folder
;^+c::Run "C:\Users\whlin\Desktop\Books\Math\Calculus" ; ;ctrl+shift+c
;return

;this shortcut is in conflict with sublime text
; Open linear algebra book folder
;^+l::Run "C:\Users\whlin\Desktop\Books\Math\Linear algebra" ; ctrl+shift+l
;return

; Open statistics book folder
;^+s::Run "C:\Users\whlin\Desktop\Books\Statistics" ; ctrl+shift+s
;return
;---------open various folders------------








; Press F1 button to move up a folder in Explorer
#IfWinActive, ahk_class CabinetWClass
; #IfWinActive, ahk_class dopus.lister
F1::Send !{Up} 




; #IfWinActive
; ;F1::Run "C:\Program Files\Sublime Text 3\sublime_text.exe"
; return

;Launch Sublime Text
return


; kill current program
; #!Q::WinKill,A 



























; ^#x::
; ^#c::                            ; Text-only cut/copy to ClipBoard
;    Clip0 = %ClipBoardAll%
;    ClipBoard =
;    StringRight x,A_ThisHotKey,1  ; C or X
;    Send ^%x%                     ; For best compatibility: SendPlay
;    ClipWait 2                    ; Wait for text, up to 2s
;    If ErrorLevel
;       ClipBoard = %Clip0%        ; Restore original ClipBoard
;    Else
;       ClipBoard = %ClipBoard%    ; Convert to text
;    VarSetCapacity(Clip0, 0)      ; Free memory 
; Return


; ;remove formatting
; ;https://www.howtogeek.com/186723/ask-htg-how-can-i-paste-text-without-the-formatting/
; $^+v:: ; CTRL+SHIFT+V
; ClipSaved := ClipboardAll ;save original clipboard contents
; clipboard = %clipboard% ;remove formatting
; Send ^v ;send the Ctrl+V command
; Clipboard := ClipSaved ;restore the original clipboard contents
; ClipSaved = ;clear the variable
; Return









;#IfWinNotActive ahk_class PX_WINDOW_CLASS
; :*:hw::Hello World{!}{Left 6}
; :*:\[::\[\]{Left 2}
; :*:(::(){Left 1}
; :*:"::""{Left 1}
; :*:'::''{Left 1}
; :*:$::$${Left 1}
; #IfWinActive

/*
[wrap list]
(  =  (TXT)
`[ =  [TXT]
{  =  {TXT}
<  =  <TXT>
>  =  >TXT<

a  =   /`*TXT*`/
h  = <!-- TXT -->
k  = <kbd>TXT</kbd>
m  =  ``` TXT ```
p  = '''' TXT ''''

[settings]
select_after = true
input_limit  = 1
delete_limit = 2
*/











; ::text1::
; (
; Any text between the top and bottom parentheses is treated literally, including commas and percent signs.
; By default, the hard carriage return (Enter) between the previous line and this one is also preserved.
;     By default, the indentation (tab) to the left of this line is preserved.
; )





; F1::
; ClipSaved := ClipboardAll   ; save the entire clipboard to the variable ClipSaved
; clipboard := ""             ; empty the clipboard (start off empty to allow ClipWait to detect when the text has arrived)
; Send, ^c                    ; copy the selected text
; ClipWait, 1                 ; wait for the clipboard to contain data 
; if (!ErrorLevel)            ; if NOT ErrorLevel, clipwait found data on the clipboard
; clipboard = "%clipboard%"   ; add the quotation marks
; Sleep, 100
;     Send, ^v
; Sleep, 100
; clipboard := ClipSaved      ; restore original clipboard
; return

;F2:: SendInput, [quote][/quote]{Left 8}



; ;$#t::
; $Insert::
; Send, ^c
; ClipWait
; InputBox, MyTag, Tag, Please enter a tag.,, 200, 130
; if ErrorLevel
;     return
; else
; {
;     If (MyTag <> "")
;     {
;       SendTag := MyTag . Clipboard . MyTag 
;       SendInput, %SendTag%
;     }    
; }    
; return


; $#t::
; Send, ^c
; ClipWait
; InputBox, MyTag, Tag, Please enter a tag.,, 200, 130
; if ErrorLevel
;     return
; else
; {
;     If (MyTag <> "")
;     {
;       SendTag := "<" . MyTag . ">" . Clipboard . "</" . MyTag . ">"
;       SendInput, %SendTag%
;     }    
; }    
; return












