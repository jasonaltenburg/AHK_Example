#Include <JSON> 										; https://github.com/cocobelgica/AutoHotkey-JSON
#NoEnv  												; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input 											; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  							; Ensures a consistent starting directory.
FileRead, apikey, apikey.txt 							; Store API key in separate text file
s1:= "https://api.openweathermap.org/data/2.5/weather?appid="
s2:= "&lat=42.3314&lon=-83.0458&units=imperial"			; s1 & s2 are portions of openweathermap site
fullsite := s1 . apikey . s2 							; concatenate full site string for GET request
hObject:=ComObjCreate("WinHttp.WinHttpRequest.5.1") 	; Create the Object
ComObjError(false) 										; Don't throw COM errors if encountered
hObject.Open("GET",fullsite)							; Open communication
hObject.Send()											; Send the "get" request
obj := Json.Load( hObject.responseText )				; Load JSON response into object

Jsunset := UnixToUTC(Json.Dump( obj.sys.sunset ))		; Dump and Format Sunset string
Jsunrise := UnixToUTC(Json.Dump( obj.sys.sunrise ))		; Dump and Format Sunrise string

FormatTime, Sunrise, %Jsunrise%, Time 					; Use FormatTime AHK command to format UTC timestring
FormatTime, Sunset, %Jsunset%, Time 					; Use FormatTime AHK command to format UTC timestring

FormatTime, FailSunrise, UnixToUTC( obj.sys.sunrise ), Time 					; Use FormatTime AHK command to format UTC timestring
FormatTime, FailSunset, UnixToUTC( obj.sys.sunset ), Time 						; Use FormatTime AHK command to format UTC timestring

; Create the current weather string with currentweather, temp, sunrise, and sunset
cw1 := "The Current Weather in Detroit, Michigan is:" . "`n" . obj.weather[ 1 ].description . "`n" obj.main.temp . " degrees F`n" . Sunrise . " sunrise`n" . Sunset . " sunset`n" 

^!1::
tooltip % cw1 												; Display currentweather as tooltip
Return

^!2::
clipboard := hObject.responseText 							; Copy responsetext to clipboard
msgbox % hObject.responseText . "`nCopied to Clipboard!!!"	; Display responsetext and message
Return

^!3:: ; Messagebox with string after FormatTime step, and prior to FormatTime step
msgbox % Sunrise . "`n" . Sunset
msgbox % "Sunrise " . UnixtoUtc(obj.sys.sunrise) . "`n" . "Sunset " . UnixtoUtc(obj.sys.sunset)
msgbox % FailSunrise . "`n" . FailSunset
Return

^!4:: ; Messagebox with UnixtoUTC Sunrise Sunset strings
msgbox % JSunrise . "`n" . JSunset
Return

UnixToUTC(unixTime){
	time:=1970
	time+=unixTime, s
	time+= -5, hours 									; -5 for EST
	return time
}