@echo off

title Building All
echo Building All

rem echo Compiling files.wxi
rem call createFilesWxi.bat 
rem "%WIX%\bin\candle" files.wxi -nologo -ext WixNetfxExtension -ext WixUtilExtension -ext wixTagExtension -ext WixUiExtension

rem Build all languages
call buildlang cz
call buildlang da
call buildlang de
call buildlang en-gb 	
call buildlang en-us 	
call buildlang es
call buildlang fi 		
call buildlang fr
call buildlang it
call buildlang ko
call buildlang nl 	
call buildlang no
call buildlang pl 	
call buildlang sv 

rem Call buildMSTs through buildlang
rem Only use if you're building a multi-language MSI
call buildlang true
	
echo Finished!
@pause
