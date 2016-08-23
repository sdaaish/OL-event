@echo off

rem Backupscript for databases that use MariaDB.
rem Uses mysqldump and 7-Zip.
rem 2016-08-20/SDAA

rem Set variables for backup

rem Change settings for user, password, directory and possible path to EXE-file.
set $BKPCMD="C:\Program Files\MariaDB 10.1\bin\mysqldump.exe"
set $ZIP="C:\Program Files\7-zip\7z.exe"
set $DIR=C:\local\data
set $USER=root
rem Prompt for password
set /p "$PASSWD=[Please insert password for user root: ]" || set $PASSWD=NothingChosen
if "%$PASSWD%"=="NothingChosen" goto sub_passwd
echo %$PASSWD%

rem Set date
set $Day=%Date:~8,2%
set $Mth=%Date:~5,2%
set $Year=%Date:~0,4%
set $Datum=%$Year%%$Mth%%$Day%

rem Set time
set $Timma=%Time:~0,2%
set $Minut=%Time:~3,2%
set $Sekund=%Time:~6,2%
set $Tid=%$Timma%%$Minut%%$Sekund%

rem Create the destination directory
mkdir %$DIR% 2>NUL
cd %$DIR%

rem Set filename to directory with date and time in name.
set $FILE=%$DIR%\mariadb-backup-%$Datum%-%$Tid%.sql

rem mysqldump has --opt as default option
echo Do the backup
echo %$BKPCMD% --user=%$USER% --password=%$PASSWD% --all-databases --add-drop-database>"%$FILE%"
if %ERRORLEVEL%==1 goto sub_db
echo Done!
echo Backup in file "%$FILE%"

echo Compressing
echo %$ZIP% -sdel a "%$FILE%.7z" "%$FILE%"
echo Compressed Backup in file "%$FILE%"
if %ERRORLEVEL%==1 goto sub_zip
goto eof

:sub_passwd
echo You must provide a password
goto eof

:sub_db
echo Backup failed!!!!!!!
goto eof

:sub_zip
echo No 7-zip detected or error compressing file

:eof
