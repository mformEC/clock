@echo off

set taskName=%1

if "%taskName%"=="" (set /p taskName=������Ҫɾ�����������ƣ�Ĭ��Ϊ: TomatoClockFromWBF)
if "%taskName%"=="" (set taskName=TomatoClockFromWBF)

set command1='SCHTASKS /Delete /TN %taskName% /F
set command1=%command1%'

for /f "delims=  tokens=1,*" %%i in (%command1%) do (set result1=%%i %%j)
if "%result1%"=="" (set result1=�������̨���ڻ�ȡ������Ϣ)

echo DEL: %DATE% %TIME% %taskName% %result1%
echo DEL: %DATE% %TIME% %taskName% %result1% >> log
pause
exit