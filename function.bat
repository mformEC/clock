@echo off

set waitTime=%1
set taskName=%2
set strToShow=%3

if "%waitTime%"=="" set /a waitTime=26 & set taskName=TomatoClockFromWBF
if "%taskName%"=="" set taskName=TomatoClockFromWBF
if "%strToShow%"=="" set strToShow=defaultMsg

set strToShow="%~dp0letmeknow.bat %3 %waitTime%
set strToShow=%strToShow%"

set var=%TIME%
set hour=%var:~0,2%
if %var:~3,1% equ 0 (set /a min=%var:~4,1% + %waitTime%) else (set /a min=%var:~3,2% + %waitTime%)

if %min% geq 60 (set /a min=%min% - 60 & set /a hour=%hour% + 1)
if %hour% geq 24 (set /a hour=%hour% - 24)
if %min% lss 10 (set min=0%min%)

set command1='schtasks /Create /SC ONCE /TN %taskName% /TR %strToShow% /ST %hour%:%min% /F
set command1=%command1%'
rem schtasks /Create /SC ONCE /TN %taskName% /TR %strToShow% /ST %hour%:%min% /F

for /f "delims=  tokens=1,*" %%i in (%command1%) do (set result1=%%i %%j)
if "%result1%"=="" (set result1=check on console can't get any msg back??) 

echo INSERT: %DATE%-%TIME% - %taskName% and reuturn = %result1% >> log
schtasks /Query /FO csv /TN %taskName% >> log

schtasks /Query /FO csv /TN %taskName%
pause
exit