@echo off
SetLocal EnableDelayedExpansion
title Windows Bzip2 - Tool
set Cur=%cd%
ping -n 2 127.0.0.1>nul
set InPath=%~1
if "%InPath%"=="" (
	echo Please drag and drop the folder you want to compress to this program instead of opening this program directly. && pause>nul && exit
)
if not exist %Cur%\bzip2.exe ( 
	echo Please first copy the folder to be compressed to the directory where the program is located. && pause>nul && exit
)
:KeepCheck
cls
echo Compress target path[%InPath%]
echo.
echo.
echo Whether to delete source files after compression（Y=删除，N=保留）
set /p KeepIn=[Y / N]: 
if /i "%KeepIn%"=="Y" (
	set Keep=false
	goto Next
) 
if /i "%KeepIn%"=="N" (
	set Keep=true
	goto Next
) 
goto KeepCheck
:Next
cls
echo Compress target path[%InPath%]
echo.
echo.
echo degree of compression（scope1-9，1Minimum compression ratio，the fastest；9Maximum compression ratio，slowest）
set /p SizeIn=[1 - 9 (integer)]: 
if %SizeIn% geq 1 (
	if %SizeIn% leq 9 (
		for /l %%i in (1,1,9) do (
			if %SizeIn%==%%i (
				goto Bzip
			)
		)
		goto Next
	) else (
		goto Next
	)
) else (
	goto Next
)
:Bzip
cls
echo Compress target path[%InPath%]
echo.
echo.
echo compressing...
cd /d %Cur%
ping -n 2 127.0.0.1>nul
if not exist Completed ( 
	cd /d %Cur%
    	md Completed
)
ping -n 2 127.0.0.1>nul
if "%Keep%"=="false" (
	echo.
	bzip2 -v -f -%SizeIn% %InPath%\*.*
	goto CopyOut
) else (
	echo.
	bzip2 -k -v -f -%SizeIn% %InPath%\*.*
	goto CopyOut
)
:CopyOut
cls
echo Compress target path[%InPath%]
echo.
echo.
echo finish immediately...
cd /d %InPath%
copy /y *.*.bz2 %Cur%\Completed
ping -n 2 127.0.0.1>nul
del /f /s /q *.*.bz2
cls
echo Compress target path[%InPath%]
echo.
echo.
echo Compression complete...opening folder...
start %Cur%\Completed
pause>nul && exit
