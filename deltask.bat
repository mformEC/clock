@echo off

set taskName=%1

if "%taskName%"=="" (set /p taskName=enter the name of task , default : TomatoClockFromWBF:)
if "%taskName%"=="" (set taskName=TomatoClockFromWBF)

set command1='SCHTASKS /Delete /TN %taskName% /F
set command1=%command1%'

for /f "delims=  tokens=1,*" %%i in (%command1%) do (set result1=%%i %%j)
rem why no return chinese ? 936?
if "%result1%"=="" (set result1=err: see the console , always can't find taskname) 

echo DEL: %DATE%-%TIME% - %taskName% and reuturn = %result1%
echo DEL: %DATE%-%TIME% - %taskName% and reuturn = %result1% >> log
pause
exit