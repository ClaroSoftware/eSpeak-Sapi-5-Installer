@echo off
set ProductName=eSpeakVoices
set Version=1.0.0
set Date=%date /T%
set VersionHyphens=%Version:.=-%
set BuildPath=".\MSIs\%ProductName%-%VersionHyphens%"
rem I18N stuff here
rem CANDLE
set commoncandle=-nologo %ProductName%.wxs -ext WixNetFxExtension -ext WixUtilExtension -ext WixTagExtension -dDate="%Date%" -dProductVersion="%Version%"
echo Candle x86
"%WIX%\bin\candle.exe" %commoncandle% -out "Temp\%ProductName%_x86.wixobj" -sw1091 -dBuild="x86"
echo Candle x64
"%WIX%\bin\candle.exe" %commoncandle% -out "Temp\%ProductName%_x86.wixobj" -sw1091 -dBuild="x64"
rem LIGHT
set lightcommon=-nologo -ext WixUIExtension -ext WixNetFxExtension -ext wixTagExtension -ext WixUtilExtension -spdb -sw0204
set MSI="%BuildPath%-x86.msi"
"%WIX%\bin\light.exe" "Temp\%ProductName%_x86.wixobj" %lightcommon% -out "%MSI%" -cc "%BuildPath%"
set MSI="%BuildPath%-x64.msi"
"%WIX%\bin\light.exe" "Temp\%ProductName%_x64.wixobj" %lightcommon% -out "%MSI%" -cc "%BuildPath%"
echo END OF BUILD
pause