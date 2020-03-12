@echo off
echo.
echo BUILDLANG %1 %2
echo.
title Building MSIs

rem
rem USAGE
rem
rem Call buildlang.bat with the following arguments:
rem 	1 The primary/main language, e.g. "en-gb" or "sv". Use hyphens.

rem Update this to match the program
set ProductName=ScreenRuler
set Version=3.3.1
set ProductAlias=SR

set Date=%date /T%
set VersionHyphens=%Version:.=-%
set BuildPath=".\MSIs\%ProductName%-%VersionHyphens%"

if %1 == true (
    call buildMSTs.py %BuildPath% %Version%
    GOTO:EXITNOW
)

set mainlanguage=%1
set mainlanguagenohyphens=%mainlanguage:-=%
set secondarylanguage=%2
set secondarylanguagenohyphens=%secondarylanguage:-=%
set MSILang=%mainlanguagenohyphens%
set ObjLang=%~1

set i18n=C:\Installers\WiX-Resources\Resources\WiX-I18N
rem Culture is the WiX light.exe -cultures: argument, and WixLang is the Claro wxi and wxl file pair to use.
if %mainlanguage% == en-gb (
	set Culture=en-GB,en-US
	set Loc=-loc "%i18n%\en-GB.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == ca (
	set Culture=ca-ES,es-ES,en-US
	set Loc=-loc "%i18n%\ca-ES.wxl" -loc "%i18n%\es-ES.wxl" -loc "%i18n%\en-us.wxl"
)
if %mainlanguage% == cz (
	set Culture=cs-CZ,en-US
	set Loc=-loc "%i18n%\cs-CZ.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == da (
	set Culture=da-DK,en-US
	set Loc=-loc "%i18n%\da-DK.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == de (
	set Culture=de-DE,en-US
	set Loc=-loc "%i18n%\de-DE.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == en-us (
	set Culture=en-US
	set Loc=-loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == es (
	set Culture=es-ES,en-US
	set Loc=-loc "%i18n%\es-ES.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == es-mx (
	set Culture=es-MX,es-ES,en-US
	set Loc=-loc "%i18n%\es-MX.wxl" -loc "%i18n%\es-ES.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == es-ar (
	set Culture=es-AR,es-ES,en-US
	set Loc=-loc "%i18n%\es-AR.wxl" -loc "%i18n%\es-ES.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == eu (
	set Culture=eu-ES,es-ES,en-US
	set Loc=-loc "%i18n%\eu-ES.wxl" -loc "%i18n%\es-ES.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == fi (
	set Culture=fi-FI,en-US
	set Loc=-loc "%i18n%\fi-FI.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == fr (
	set Culture=fr-FR,en-US
	set Loc=-loc "%i18n%\fr-FR.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == fr-ca (
	set Culture=fr-CA,fr-FR,en-US
	set Loc=-loc "%i18n%\fr-CA.wxl" -loc "%i18n%\fr-FR.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == it (
	set Culture=it-IT,en-US
	set Loc=-loc "%i18n%\it-IT.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == ko (
	set Culture=ko-KR,en-US
	set Loc=-loc "%i18n%\ko-KR.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == nl (
	set Culture=nl-NL,en-US
	set Loc=-loc "%i18n%\nl-NL.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == nl-be (
	set Culture=nl-BE,nl-NL,en-US
	set Loc=-loc "%i18n%\nl-BE.wxl" -loc "%i18n%\nl-NL.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == no (
	set Culture=nb-NO,en-US
	set Loc=-loc "%i18n%\nb-NO.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == pl (
	set Culture=pl-PL,en-US
	set Loc=-loc "%i18n%\pl-PL.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == pt (
	set Culture=pt-PT,en-US
	set Loc=-loc "%i18n%\pt-PT.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == sv (
	set Culture=sv-SE,en-US
	set Loc=-loc "%i18n%\sv-SE.wxl" -loc "%i18n%\en-US.wxl"
)
if %mainlanguage% == ar (
	set Culture=ar-SA,en-US
	set Loc=-loc "%i18n%\ar-SA.wxl" -loc "%i18n%\en-US.wxl"
)
rem Add more languages if needed
if "%mainlanguage%" == "" (
	echo Undefined culture to build: %mainlanguage%
	pause
	exit
)

rem CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE CANDLE

set commoncandle=-nologo %ProductName%.wxs -ext WixNetFxExtension -ext WixUtilExtension -ext WixTagExtension -dLanguage1="%~1" -dLanguage2="%~2" -dDate="%Date%" -dProductVersion="%Version%" -dBuild="%ProductAlias%"

echo Candle Network
"%WIX%\bin\candle.exe" %commoncandle% -out "Temp\%ProductAlias%_%ObjLang%_net.wixobj" -sw1091 -dAuth="no"
echo Candle Authenticated
"%WIX%\bin\candle.exe" %commoncandle% -out "Temp\%ProductAlias%_%ObjLang%_auth.wixobj" -sw1091 -dAuth="yes"
goto:light

:light
set lightcommon=-nologo -ext WixUIExtension -ext WixNetFxExtension -ext wixTagExtension -ext WixUtilExtension -cultures:%Culture% %Loc% -spdb -sw0204 -reusecab

set buildPath=".\MSIs"
set MSIPATH=%buildPath%\%ProductName%-%VersionHyphens%

echo Light Network
set MSI="%MSIPATH%\%ProductName%-%MSILang%-%Version%-net-X.msi"
"%WIX%\bin\light.exe" Temp\%ProductAlias%_%ObjLang%_net.wixobj %lightcommon% -out %MSI% -cc "%MSIPATH%"

echo Light Authenticated
set MSI="%MSIPATH%\%ProductName%-%MSILang%-%Version%-auth-X.msi"
"%WIX%\bin\light.exe" Temp\%ProductAlias%_%ObjLang%_auth.wixobj %lightcommon% -out %MSI% -cc "%MSIPATH%"

goto:EXITNOW

:EXITNOW
echo END OF BUILDLANG