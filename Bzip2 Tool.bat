@echo off
SetLocal EnableDelayedExpansion
title Windows Bzip2 - Tool
set Cur=%cd%
ping -n 2 127.0.0.1>nul
set InPath=%~1
if "%InPath%"=="" (
	echo ���Ҫѹ�����ļ�����ק���������ϣ�������ֱ�Ӵ򿪱����� && pause>nul && exit
)
if not exist %Cur%\bzip2.exe ( 
	echo ���Ȱ�Ҫѹ�����ļ��и��Ƶ�����������Ŀ¼�� && pause>nul && exit
)
:KeepCheck
cls
echo ѹ��Ŀ��·��[%InPath%]
echo.
echo.
echo ѹ�����Ƿ�ɾ��Դ�ļ���Y=ɾ����N=������
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
echo ѹ��Ŀ��·��[%InPath%]
echo.
echo.
echo ѹ���̶ȣ���Χ1-9��1ѹ������С���ٶ���죻9ѹ��������ٶ�������
set /p SizeIn=[1 - 9 (����)]: 
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
echo ѹ��Ŀ��·��[%InPath%]
echo.
echo.
echo ����ѹ��...
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
echo ѹ��Ŀ��·��[%InPath%]
echo.
echo.
echo �������...
cd /d %InPath%
copy /y *.*.bz2 %Cur%\Completed
ping -n 2 127.0.0.1>nul
del /f /s /q *.*.bz2
cls
echo ѹ��Ŀ��·��[%InPath%]
echo.
echo.
echo ѹ�����...���ڴ��ļ���...
start %Cur%\Completed
pause>nul && exit