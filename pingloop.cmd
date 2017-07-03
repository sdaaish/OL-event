@echo off

:: Ping tool to check if computers on OL-event are responding in the network.
:: Must supply a infile with ip-addresses as infile.
:: 2016-08-20/SDAA

:: Start over from here
:begin

:: Set date
set $Day=%Date:~8,2%
set $Mth=%Date:~5,2%
set $Year=%Date:~0,4%
set $Datum=%$Year%-%$Mth%-%$Day%

:: Set time
set $Hour=%Time:~0,2%
set $Minute=%Time:~3,2%
set $Second=%Time:~6,2%
set $Tid=%$Hour%:%$Minute%:%$Second%

:: Must supply infile-name
if [%1]==[] goto usage

:: Check for infile
if not exist %1 (
   echo File %1 does not exist!
   exit /b 1
)

:: This file contains the addresses, see supplied example.txt
set $infile=%1

:: Clear screen before pining
cls
echo > NUL
echo Current date: %$Datum% and time: %$Tid%

:: Check localhost
for %%i in (localhost) do (
    echo Pinging host=%%i
    ping -n 3 -w 300 -l 128 %%i| findstr /i /v  "statistics approx minimum"
)

setlocal
:: Check the computers in $infile
for /f "eol=#" %%i in (%$infile%) do (call :pingloop %%i)
endlocal
goto rerun

:pingloop
set $host=%1
echo Pinging host %$host%
ping -n 3 -w 300 -l 128 %$host% | findstr /i /v  "statistics approx minimum"
exit /b

:rerun
:: Start over after 5 secs.
echo > NUL
echo Done!
echo Restarting ping, sleep for a while.....
ping -n 5 ::1 > NUL
goto begin

:usage
echo "Usage: pingsnurra.cmd <filename>"
exit /b 2
