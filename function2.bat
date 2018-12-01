@echo off
rem �������� ��ֹ�Ժ�仯
set /a TOMATO_TIME=30
set /a WORK_TIME=25
set /a BREAK_TIME=%TOMATO_TIME% - %WORK_TIME%
rem RELAX_TIME ������ڹ���ʱ��������
set /a RELAX_TIME=30

rem �����ڷ����Ӹ���
set /a count=%1
rem ��һ������ʼʱ��
set lastBeginTime=%2
rem Ĭ��������
set taskName=TomatoClockFromWBF

rem �� count �ж���һ���� breka or work
set /a flag =%count% %% 2
set /a tcount=(%count% + 1) / 2

rem �ж��´�ʱ�Ӽ��
if %flag% equ 0 (set /a nextWaitTime=%WORK_TIME%) else set /a nextWaitTime=%BREAK_TIME%
rem ��ʾ��Ϣ �� �����´η���ʱ��
if %flag% equ 1 (echo �Ѿ�����ѧϰ%tcount%�����ѣ���ʱ����Ϣ��Ŷ) else echo �Ѿ�����ѧϰ��%tcount%�����ѣ���Ҫ���Ͱ���
rem ���� nextWaitTime
if %count% equ 7 (set /a count=0 & set /a nextWaitTime=%RELAX_TIME%) else set /a count=%count% + 1
set /p nextWaitTime=�����´�����ʱ�䣬Ĭ��%nextWaitTime%���ӣ�
if "%nextWaitTime%"=="" set nextWaitTime=%nextWaitTime%


rem ����ʱ��
set var=%TIME%
set hour=%var:~0,2%
if %var:~3,1% equ 0 (set /a min=%var:~4,1% + %nextWaitTime%) else (set /a min=%var:~3,2% + %nextWaitTime%)
if %min% geq 60 (set /a min=%min% - 60 & set /a hour=%hour% + 1)
if %hour% geq 24 (set /a hour=%hour% - 24)
if %min% lss 10 (set min=0%min%)
if %hour% lss 10 (set hour=0%TIME:~1,1%)

rem ��������ƻ����
set strToShow="%~dp0function2.bat %count% %var%
set strToShow=%strToShow%"

set command1='schtasks /Create /SC ONCE /TN %taskName% /TR %strToShow% /ST %hour%:%min% /F
set command1=%command1%'

echo %command1%

for /f "delims=  tokens=1,*" %%i in (%command1%) do (set result1=%%i %%j)
if "%result1%"=="" (set result1=�������̨���ڻ�ȡ������Ϣ)
schtasks /Query /FO csv /TN %taskName%

rem ��¼����־ �������ͳ�� ��ɾ����Ӧ
rem ���ڵڶ��������� ���ڵ�ַ �Ǵ˴� ���Բ���Ҫָ��log �ļ��ĵ�ַ ֻ��¼ WORK_TIME ��ʱ��
rem if %flag% equ 1 echo DONE: %count% %tcount% %DATE% %var% %taskName% %result1% >> %~dp0log
if %flag% equ 1 echo DONE: %count% %tcount% %DATE% %var% %taskName% %result1% >> %~dp0log

pause
exit