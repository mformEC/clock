@echo off
rem msgg lastWaitTime

set msgg=%1
set lastWaitTime=%2

if "%msgg%"=="" set msgg=Get No MSG
if "%lastWaitTime%"=="" set /a lastWaitTime=0

rem maybe joke from internet

if %lastWaitTime% lss 10 (set /a waitTime=26 & set taskName=TomatoClockFromWBF & set msgg=Is Time To Work)
if %lastWaitTime% geq 10 (set /a waitTime=6 & set taskName=TomatoClockFromWBF & set msgg=Is Time To Relax)

set /p flag=set the next alarm after %waitTime% minutes, (default Y):
if "%flag%"=="" goto callfunc
if "%flag%"=="Y" goto callfunc
if "%flag%"=="y" goto callfunc
set /p waitTime=what you want?????:
if %lastWaitTime% geq 10 (if %waitTime% geq 20 set msgg=Is time To Work)

:callfunc
start %~dp0function.bat %waitTime% %taskName% %msgg%