@echo off

rem Pingsnurra f�r datorer p� OL,t�vling
rem 2016-08-20/SDAA

rem Vi b�rjar om h�r
:begin

rem pingar Gof-datorer i n�tet
rem Kolla att localhost och gateway fungerar
for %%i in (localhost 192.168.1.1) do ping -n 3 -w 300 %%i

rem Kolla de olika Gofarna
for /L %%i in (11,1,17) do ping -n 3 -w 300 192.168.1.%%i

rem B�rja om igen, l�t detta f�nster snurra
goto begin

