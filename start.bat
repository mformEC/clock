@echo off
set /p waitTime=set time for alarm clock(default 26):
if "%waitTime%"=="" set waitTime=26
start function.bat %waitTime% TomatoClockFromWBF IsTimeToRelax
exit