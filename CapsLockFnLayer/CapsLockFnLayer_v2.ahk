; Functionality:
; - Deactivates CapsLock for normal use. You can turn CapsLock back on & suspend the script by pressing Win + CapsLock.
; - Access the following functions when pressing CapsLock:
;     Cursor keys               - J, K, L, I
;     Enter                     - Space
;     Home, End, PgDn, PgUp     - H, E, D, U
;     Backspace, Insert, Del    - B, N, M
;     Tab                       - T
;     Undo, redo                - , and .
;     Num row                   - Esc and F keys
;     Win Key                   - W
;     Ctrl, Shift, Alt          - Q, S, A

SendMode "Input"

; Ensures a consistent starting directory.
SetWorkingDir A_ScriptDir

; This script will not exit automatically, even though it has nothing to do.
; However, you can use its tray icon to open the script in an editor, or to
;  launch Window Spy or the Help file.
; Taken from https://lexikos.github.io/v2/docs/commands/Persistent.htm
Persistent
SetCapsLockState "AlwaysOff"
SetScrollLockState "AlwaysOff"

; Explicitly set global variables for clarity
global IsSuspended := false
global IsCzLayerOn := false
retur

; CapsLock + Q, S, A => Ctrl, Shift, Alt
CapsLock & q:: Send "{Blind}{Ctrl Down}"
CapsLock & q up:: Send "{Blind}{Ctrl Up}"
;CapsLock & s::Send {Blind}{Shift Down}
;CapsLock & s up::Send {Blind}{Shift Up}
;CapsLock & a::Send {Blind}{Alt Down}
;CapsLock & a up::Send {Blind}{Alt Up}

; CapsLock + , => Undo
CapsLock & ,:: Send "{Blind}{Ctrl Down}{z}{Ctrl Up}"
;CapsLock & , up::Send {Ctrl Up}{z Up}

; CapsLock + . => Redo
CapsLock & .:: Send "{Blind}{Ctrl Down}{y}{Ctrl Up}"
;CapsLock & . up::Send {Ctrl Up}{y Up}

; CapsLock + J, K, L, I => Left, Down, Right, Up
CapsLock & j:: Send "{Blind}{Left Down}"
;CapsLock & j up::Send {Blind}{Left Up}
CapsLock & k:: Send "{Blind}{Down Down}"
;CapsLock & k up::Send {Blind}{Down Up}
CapsLock & l:: Send "{Blind}{Right Down}"
;CapsLock & l up::Send {Blind}{Right Up}
CapsLock & i:: Send "{Blind}{Up Down}"
;CapsLock & i up::Send {Blind}{Up Up}

; CapsLock + O, U, H, E => Pg Down, Pg Up, Home, End
CapsLock & h:: Send "{Blind}{Home}"
;CapsLock & h up::Send {Blind}{Home Up}
CapsLock & e:: Send "{Blind}{End}"
;CapsLock & e up::Send {Blind}{End Up}
CapsLock & u:: Send "{Blind}{PgUp}"
;CapsLock & u up::Send {Blind}{PgUp Up}
CapsLock & o:: Send "{Blind}{PgDn}"
;CapsLock & d up::Send {Blind}{PgDn Up}

; CapsLock + B, N, M => Backspace, Insert, Delete
CapsLock & b:: Send "{Blind}{BS}"
CapsLock & n:: Send "{Blind}{Insert}"
CapsLock & m:: Send "{Blind}{Del}"

; Fn + P -> PrintScreen
CapsLock & p:: Send "{PrintScreen}"

; CapsLock + T => Tab
CapsLock & t:: Send "{Blind}{Tab}"
;CapsLock & t up::Send {Blind}{Tab Up}

; CapsLock + W => Win key
CapsLock & w:: Send "{Blind}{LWin Down}"
CapsLock & w up:: Send "{Blind}{LWin Up}"

; CapsLock + Tab => Previous tab
;CapsLock & Tab::Send {Ctrl Down}{Shift Down}{Tab Down}
;CapsLock & Tab up::Send {Ctrl Up}{Shift Up}{Tab Up}

; CapsLock + Space => Enter
CapsLock & Space:: Send "{Enter}"

; Capsloc + ~` => Esc
CapsLock & SC029:: Send "{Blind}{Esc}"   ; SC029 = ~`
CapsLock & SC029 up:: Send "{Blind}{Esc Up}"

; Win key + CapsLock => Suspend hotkeys and return the normal CapsLock on/off functionality
#SuspendExempt
#CapsLock:: {
   Suspend

   global IsSuspended := !IsSuspended
   If IsSuspended {
      SetCapsLockState "On"
      MsgBox "Hotkeys have been suspended. CapsLock state is set to 'on'."
   }
   Else {
      SetCapsLockState "AlwaysOff"
      MsgBox "Hotkeys have been enabled. CapsLock state is set to 'always off'."
   }
}
#SuspendExempt False

; Turn on/off a layer with CZ letters with diacritics. If it's off then the num row can be used as Esc & F keys.
CapsLock & c:: {
   global IsCzLayerOn := !IsCzLayerOn
}

; CapsLock + 1 => Latin letter 'o' with acute or F1 (if IsCzLayerOn is false)
CapsLock & 1:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+00D3}"
      Else
         Send "{Blind}{U+00F3}"
      Return
   }
   Else {
      Send "{Blind}{F1}"
   }
}

; CapsLock + 2 => Latin letter 'e' with caron or F2 (if IsCzLayerOn is false)
CapsLock & 2:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+011A}"
      Else
         Send "{Blind}{U+011B}"
      Return
   }
   Else {
      Send "{Blind}{F2}"
   }
}

; CapsLock + 3 => Latin letter 's' with caron or F3 (if IsCzLayerOn is false)
CapsLock & 3:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+0160}"
      Else
         Send "{Blind}{U+0161}"
      Return
   }
   Else {
      Send "{Blind}{F3}"
   }
}

; CapsLock + 4 =>  Latin letter 'c' with caron or F4 (if IsCzLayerOn is false)
CapsLock & 4:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+010C}"
      Else
         Send "{Blind}{U+010D}"
      Return
   }
   Else {
      Send "{Blind}{F4}"
   }
}

; CapsLock + 5 => Latin letter 'r' with caron or F5 (if IsCzLayerOn is false)
CapsLock & 5:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+0158}"
      Else
         Send "{Blind}{U+0159}"
      Return
   }
   Else {
      Send "{Blind}{F5}"
   }
}

; CapsLock + 6 => Latin letter 'z' with caron or F6 (if IsCzLayerOn is false)
CapsLock & 6:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+017D}"
      Else
         Send "{Blind}{U+017E}"
      Return
   }
   Else {
      Send "{Blind}{F6}"
   }
}

; CapsLock + 7 => Latin letter 'y' with acute or F7 (if IsCzLayerOn is false)
CapsLock & 7:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+00DD}"
      Else
         Send "{Blind}{U+00FD}"
      Return
   }
   Else {
      Send "{Blind}{F7}"
   }
}

; CapsLock + 8 => Latin letter 'a' with acute or F8 (if IsCzLayerOn is false)
CapsLock & 8:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+00C1}"
      Else
         Send "{Blind}{U+00E1}"
      Return
   }
   Else {
      Send "{Blind}{F8}"
   }
}

; CapsLock + 9 => Latin letter 'i' acute or F9 (if IsCzLayerOn is false)
CapsLock & 9:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+00CD}"
      Else
         Send "{Blind}{U+00ED}"
      Return
   }
   Else {
      Send "{Blind}{F9}"
   }
}

; CapsLock + 0 => Latin letter 'e' with acute or F10 (if IsCzLayerOn is false)
CapsLock & 0:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+00C9}"
      Else
         Send "{Blind}{U+00E9}"
      Return
   }
   Else {
      Send "{Blind}{F10}"
   }
}

; CapsLock + -_ => Latin letter 'd' with caron or F11 (if IsCzLayerOn is false)
CapsLock & SC00C:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+010E}"
      Else
         Send "{Blind}{U+010F}"
      Return
   }
   Else {
      Send "{Blind}{F11}"
   }
}

; CapsLock + =+ => Latin letter 't' with caron or F12 (if IsCzLayerOn is false)
CapsLock & SC00D:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+0164}"
      Else
         Send "{Blind}{U+0165}"
      Return
   }
   Else {
      Send "{Blind}{F12}"
   }
}

; CapsLock + =+ => Latin letter 'n' with carton or do nothing (if IsCzLayerOn is false)
CapsLock & SC01B:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+0147}"
      Else
         Send "{Blind}{U+0148}"
      Return
   }
   Else {
   }
}

; CapsLock + [{ => Latin letter 'u' with acute or do nothing (if IsCzLayerOn is false)
CapsLock & SC01A:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+00DA}"
      Else
         Send "{Blind}{U+00FA}"
      Return
   }
   Else {
   }
}

; CapsLock + ;: => Latin letter 'u' with a ring or do nothing (if IsCzLayerOn is false)
CapsLock & SC027:: {
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+016E}"
      Else
         Send "{Blind}{U+016F}"
      Return
   }
   Else {
   }
}