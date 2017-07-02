@echo off

:: Pingsnurra för datorer på OL,tävling
:: 2016-08-20/SDAA

:: Vi börjar om här
:begin

:: Set date
set $Day=%Date:~8,2%
set $Mth=%Date:~5,2%
set $Year=%Date:~0,4%
set $Datum=%$Year%-%$Mth%-%$Day%

:: Set time
set $Timma=%Time:~0,2%
set $Minut=%Time:~3,2%
set $Sekund=%Time:~6,2%
set $Tid=%$Timma%:%$Minut%:%$Sekund%

cls
echo > NUL
echo Aktuellt datum: %$Datum% och tid: %$Tid%

:: pingar Gof-datorer i nätet
:: Kolla att localhost och gateway fungerar
for %%i in (localhost 192.168.1.1) do (
    echo Pinging host=%%i
    ping -n 3 -w 300 -l 128 %%i| findstr /i /v  "statistics approx minimum"
)

setlocal
:: Kolla de olika Gofarna
for /L %%i in (11,1,17) do (call :pingloop %%i)
endlocal
goto rerun

:pingloop
set $host=192.168.1.%1
echo Pinging host %$host%
ping -n 3 -w 300 -l 128 %$host% | findstr /i /v  "statistics approx minimum"
exit /b

:rerun
:: Börja om igen, låt detta fönster snurra
echo > NUL
echo Done!
echo Restarting ping, sleep for a while.....
ping -n 5 ::1 > NUL
goto begin
