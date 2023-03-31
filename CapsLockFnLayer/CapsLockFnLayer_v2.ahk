; Functionality:
; - Deactivates CapsLock for normal use. You can turn CapsLock back on & suspend the script by pressing Win + CapsLock.
; - Access the following functions when pressing CapsLock:
;     Cursor keys             - J, K, L, I
;     Enter                   - Space
;     Home, End, PgDn, PgUp   - H, E, D, U
;     Backspace, Insert, Del  - B, N, M
;     Tab                     - T
;     Undo, redo              - , and .
;     Num row                 - Esc and F keys
;     Win Key                 - W
;     Ctrl                    - Q

SendMode "Input"

; Ensures a consistent starting directory.
SetWorkingDir A_ScriptDir

; This script will not exit automatically, even though it has nothing to do.
; However, you can use its tray icon to open the script in an editor, or to launch Window Spy or the Help file.
; Taken from https://lexikos.github.io/v2/docs/commands/Persistent.htm
Persistent
SetCapsLockState "AlwaysOff"
SetScrollLockState "AlwaysOff"

; Explicitly set global variables for clarity
global IsSuspended := false
global IsCzLayerOn := false
return

; CapsLock + Q => Ctrl
CapsLock & q:: Send "{Blind}{Ctrl Down}"
CapsLock & q up:: Send "{Blind}{Ctrl Up}"

; CapsLock + , => Undo
CapsLock & ,:: Send "{Blind}{Ctrl Down}{z}{Ctrl Up}"

; CapsLock + . => Redo
CapsLock & .:: Send "{Blind}{Ctrl Down}{y}{Ctrl Up}"

; CapsLock + J, K, L, I => Left, Down, Right, Up
CapsLock & j:: Send "{Blind}{Left Down}"
CapsLock & k:: Send "{Blind}{Down Down}"
CapsLock & l:: Send "{Blind}{Right Down}"
CapsLock & i:: Send "{Blind}{Up Down}"

; CapsLock + O, U, H, E => Pg Down, Pg Up, Home, End
CapsLock & h:: Send "{Blind}{Home}"
CapsLock & e:: Send "{Blind}{End}"
CapsLock & u:: Send "{Blind}{PgUp}"
CapsLock & o:: Send "{Blind}{PgDn}"

; CapsLock + B, N, M => Backspace, Insert, Delete
CapsLock & b:: Send "{Blind}{BS}"
CapsLock & n:: Send "{Blind}{Insert}"
CapsLock & m:: Send "{Blind}{Del}"

; Fn + P -> PrintScreen
CapsLock & p:: Send "{PrintScreen}"

; CapsLock + T => Tab
CapsLock & t:: Send "{Blind}{Tab}"

; CapsLock + Tab => Previous tab
CapsLock & Tab::Send "{Blind}{Ctrl Down}{Shift Down}{Tab Down}"

; CapsLock + W => Win key
CapsLock & w:: Send "{Blind}{LWin Down}"
CapsLock & w up:: Send "{Blind}{LWin Up}"

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
      MsgBox "Hotkeys have been suspended. CapsLock state is set to `"on`"."
   }
   Else {
      SetCapsLockState "AlwaysOff"
      MsgBox "Hotkeys have been enabled. CapsLock state is set to `"always off`"."
   }
}
#SuspendExempt False

; Turn on/off a layer with CZ letters with diacritics. If it is off then the num row can be used as Esc & F keys.
CapsLock & c:: {
   global IsCzLayerOn := !IsCzLayerOn
}

; Function to handle the key events for the number row
CapsLockNumberRowHandler(key, unicodeShifted, unicodeUnshifted, functionKey) {
   global IsCzLayerOn
   If IsCzLayerOn {
      If GetKeyState("Shift", "P")
         Send "{Blind}{U+" unicodeShifted "}"
      Else
         Send "{Blind}{U+" unicodeUnshifted "}"
      return
   }
   Else {
      If functionKey != ""
         Send "{Blind}{" functionKey "}"
      return
   }
}

; CapsLock + 1 => Latin letter "o" with an acute accent or F1 (if IsCzLayerOn is false)
CapsLock & 1:: CapsLockNumberRowHandler("1", "00D3", "00F3", "F1")

; CapsLock + 2 => Latin letter "e" with a caron or F2 (if IsCzLayerOn is false)
CapsLock & 2:: CapsLockNumberRowHandler("2", "011A", "011B", "F2")

; CapsLock + 3 => Latin letter "s" with a caron or F3 (if IsCzLayerOn is false)
CapsLock & 3:: CapsLockNumberRowHandler("3", "0160", "0161", "F3")

; CapsLock + 4 => Latin letter "c" with a caron or F4 (if IsCzLayerOn is false)
CapsLock & 4:: CapsLockNumberRowHandler("4", "010C", "010D", "F4")

; CapsLock + 5 => Latin letter "r" with a caron or F5 (if IsCzLayerOn is false)
CapsLock & 5:: CapsLockNumberRowHandler("5", "0158", "0159", "F5")

; CapsLock + 6 => Latin letter "z" with a caron or F6 (if IsCzLayerOn is false)
CapsLock & 6:: CapsLockNumberRowHandler("6", "017D", "017E", "F6")

; CapsLock + 7 => Latin letter "y" with an acute accent or F7 (if IsCzLayerOn is false)
CapsLock & 7:: CapsLockNumberRowHandler("7", "00DD", "00FD", "F7")

; CapsLock + 8 => Latin letter "a" with an acute accent or F8 (if IsCzLayerOn is false)
CapsLock & 8:: CapsLockNumberRowHandler("8", "00C1", "00E1", "F8")

; CapsLock + 9 => Latin letter "i" with an acute accent or F9 (if IsCzLayerOn is false)
CapsLock & 9:: CapsLockNumberRowHandler("9", "00CD", "00ED", "F9")

; CapsLock + 0 => Latin letter "e" with an acute accent or F10 (if IsCzLayerOn is false)
CapsLock & 0:: CapsLockNumberRowHandler("0", "00C9", "00E9", "F10")

; CapsLock + -_ => Latin letter "d" with a caron or F11 (if IsCzLayerOn is false)
CapsLock & SC00C:: CapsLockNumberRowHandler("SC00C", "010E", "010F", "F11")

; CapsLock + =+ => Latin letter "t" with a caron or F12 (if IsCzLayerOn is false)
CapsLock & SC00D:: CapsLockNumberRowHandler("SC00D", "0164", "0165", "F12")

; CapsLock + =+ => Latin letter "n" with a caron or do nothing (if IsCzLayerOn is false)
CapsLock & SC01B:: CapsLockNumberRowHandler("SC01B", "0147", "0148", "")

; CapsLock + [{ => Latin letter "u" with an acute accent or do nothing (if IsCzLayerOn is false)
CapsLock & SC01A:: CapsLockNumberRowHandler("SC01A", "00DA", "00FA", "")

; CapsLock + ;: => Latin letter "u" with a ring or do nothing (if IsCzLayerOn is false)
CapsLock & SC027:: CapsLockNumberRowHandler("SC027", "016E", "016F", "")