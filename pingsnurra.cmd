@echo off

rem Pingsnurra för datorer på OL,tävling
rem 2016-08-20/SDAA

rem Vi börjar om här
:begin

rem pingar Gof-datorer i nätet
rem Kolla att localhost och gateway fungerar
for %%i in (localhost 192.168.1.1) do ping -n 3 -w 300 %%i

rem Kolla de olika Gofarna
for /L %%i in (11,1,17) do ping -n 3 -w 300 192.168.1.%%i

rem Börja om igen, låt detta fönster snurra
goto begin

