@echo off

rem Pingsnurra f�r datorer p� OL,t�vling
rem 2016-08-20/SDAA

rem Vi b�rjar om h�r
:begin

rem Set date
set $Day=%Date:~8,2%
set $Mth=%Date:~5,2%
set $Year=%Date:~0,4%
set $Datum=%$Year%-%$Mth%-%$Day%

rem Set time
set $Timma=%Time:~0,2%
set $Minut=%Time:~3,2%
set $Sekund=%Time:~6,2%
set $Tid=%$Timma%:%$Minut%:%$Sekund%

cls
echo > NUL
echo Aktuellt datum: %$Datum% och tid: %$Tid%

rem pingar Gof-datorer i n�tet
rem Kolla att localhost och gateway fungerar
for %%i in (localhost 192.168.1.1) do ping -n 3 -w 300 %%i

rem Kolla de olika Gofarna
for /L %%i in (11,1,17) do ping -n 3 -w 300 192.168.1.%%i

rem B�rja om igen, l�t detta f�nster snurra
echo > NUL
echo Done!
echo Restarting ping.....
sleep 5
goto begin

