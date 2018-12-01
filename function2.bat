@echo off
rem 几个常量 防止以后变化
set /a TOMATO_TIME=30
set /a WORK_TIME=25
set /a BREAK_TIME=%TOMATO_TIME% - %WORK_TIME%
rem RELAX_TIME 假如等于工作时间会出问题
set /a RELAX_TIME=30

rem 周期内番茄钟个数
set /a count=%1
rem 上一个任务开始时间
set lastBeginTime=%2
rem 默认任务名
set taskName=TomatoClockFromWBF

rem 用 count 判断上一次是 breka or work
set /a flag =%count% %% 2
set /a tcount=(%count% + 1) / 2

rem 判断下次时钟间隔
if %flag% equ 0 (set /a nextWaitTime=%WORK_TIME%) else set /a nextWaitTime=%BREAK_TIME%
rem 显示信息 和 调整下次番茄时钟
if %flag% equ 1 (echo 已经连续学习%tcount%个番茄，是时候休息了哦) else echo 已经连续学习了%tcount%个番茄！还要加油啊！
rem 更新 nextWaitTime
if %count% equ 7 (set /a count=0 & set /a nextWaitTime=%RELAX_TIME%) else set /a count=%count% + 1
set /p nextWaitTime=设置下次闹钟时间，默认%nextWaitTime%分钟：
if "%nextWaitTime%"=="" set nextWaitTime=%nextWaitTime%


rem 计算时间
set var=%TIME%
set hour=%var:~0,2%
if %var:~3,1% equ 0 (set /a min=%var:~4,1% + %nextWaitTime%) else (set /a min=%var:~3,2% + %nextWaitTime%)
if %min% geq 60 (set /a min=%min% - 60 & set /a hour=%hour% + 1)
if %hour% geq 24 (set /a hour=%hour% - 24)
if %min% lss 10 (set min=0%min%)
if %hour% lss 10 (set hour=0%TIME:~1,1%)

rem 生成任务计划语句
set strToShow="%~dp0function2.bat %count% %var%
set strToShow=%strToShow%"

set command1='schtasks /Create /SC ONCE /TN %taskName% /TR %strToShow% /ST %hour%:%min% /F
set command1=%command1%'

echo %command1%

for /f "delims=  tokens=1,*" %%i in (%command1%) do (set result1=%%i %%j)
if "%result1%"=="" (set result1=请检查控制台窗口获取错误信息)
schtasks /Query /FO csv /TN %taskName%

rem 记录到日志 方便后续统计 与删除对应
rem 由于第二次启动后 所在地址 非此处 所以才需要指明log 文件的地址 只记录 WORK_TIME 的时钟
rem if %flag% equ 1 echo DONE: %count% %tcount% %DATE% %var% %taskName% %result1% >> %~dp0log
if %flag% equ 1 echo DONE: %count% %tcount% %DATE% %var% %taskName% %result1% >> %~dp0log

pause
exit