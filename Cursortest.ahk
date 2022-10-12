#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^1::
msgbox % a_cursor
Return

^2::
loop {
	Sleep 50
	if a_cursor = Unknown
	msgbox "It's a trap!"
}
Return

^3::
Loop {
Sleep 50
if a_cursor = IBeam
{
	Sleep 50
	Click
	Sleep 50 
	Fileread, JustGonnaSendIt, Gettysburg.txt
	Sleep 50
	SendInput % JustGonnaSendIt
	Sleep 50
	Msgbox Education has been delivered Abe Lincoln would be proud
	break
}
}

^4::
Loop {
Sleep 50
if a_cursor = Unknown
{
	Click
	Break
}
}