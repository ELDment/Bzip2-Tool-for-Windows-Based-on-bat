@echo off
SetLocal EnableDelayedExpansion
title Windows Bzip2 - Tool
set Cur=%cd%
ping -n 2 127.0.0.1>nul
set InPath=%~1
if "%InPath%"=="" (
	echo 请把要压缩的文件夹拖拽到本程序上，而不是直接打开本程序。 && pause>nul && exit
)
if not exist %Cur%\bzip2.exe ( 
	echo 请先把要压缩的文件夹复制到本程序所在目录。 && pause>nul && exit
)
:KeepCheck
cls
echo 压缩目标路径[%InPath%]
echo.
echo.
echo 压缩后是否删除源文件（Y=删除，N=保留）
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
echo 压缩目标路径[%InPath%]
echo.
echo.
echo 压缩程度（范围1-9，1压缩比最小，速度最快；9压缩比最大，速度最慢）
set /p SizeIn=[1 - 9 (整数)]: 
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
echo 压缩目标路径[%InPath%]
echo.
echo.
echo 正在压缩...
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
echo 压缩目标路径[%InPath%]
echo.
echo.
echo 马上完成...
cd /d %InPath%
copy /y *.*.bz2 %Cur%\Completed
ping -n 2 127.0.0.1>nul
del /f /s /q *.*.bz2
cls
echo 压缩目标路径[%InPath%]
echo.
echo.
echo 压缩完成...正在打开文件夹...
start %Cur%\Completed
pause>nul && exit