@echo off
rem Set variables for backup

rem Change settings for user, password, directory and possible path to EXE-file.
set BKPCMD="c:\Program Files\MySQL\MySQL Server 5.6\bin\mysqldump.exe"
set DIR=C:\local\data
set USER=root
set PASSWD=qwerty
set DB=OLA

rem Set date
set Day=%Date:~8,2%
set Mth=%Date:~5,2%
set Year=%Date:~0,4%
set Datum=%Year%%Mth%%Day%

rem Set time
set Timma=%Time:~0,2%
set Minut=%Time:~3,2%
set Sekund=%Time:~6,2%
set Tid=%Timma%%Minut%%Sekund%

rem Set filename to directory with date and time in name.
set FILE=%DIR%\OLA-backup-%Datum%-%Tid%.sql

echo Do the backup
%BKPCMD% --user=%USER% --password=%PASSWD% %DB% >%FILE%
echo Done!
echo Backup in file %FILE%
