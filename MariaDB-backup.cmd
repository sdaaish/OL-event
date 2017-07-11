@echo off

:: Backupscript for databases that use MariaDB or MySQL.
:: Uses mysqldump and 7-Zip.
:: 2016-08-20/SDAA

:: Set variables for backup
:: Change settings for user, password, directory and possible path to EXE-file.
:: If you use another compressing program, change ZIPOPT and ZIPEXT to.
setlocal

set $ZIP="C:\Program Files\7-zip\7z.exe"
set $ZIPOPT=-sdel a
set $ZIPEXT=.7z
set $DIR=C:\local\data
set $USER=root

:: Find out what version of mysqldump to be used
:: MariaDB ver 10.2, 10.1 or MYSQL-version.
if exist "C:\Program Files\MariaDB 10.2\bin\mysqldump.exe" (
   set $BKPCMD="C:\Program Files\MariaDB 10.2\bin\mysqldump.exe"
   goto main
)

if exist "C:\Program Files\MariaDB 10.1\bin\mysqldump.exe" (
   set $BKPCMD="C:\Program Files\MariaDB 10.1\bin\mysqldump.exe"
   goto main
)

if exist "C:\Program Files\MYSQL\bin\mysqldump.exe" (
   set $BKPCMD="C:\Program Files\MYSQL\bin\mysqldump.exe"
   goto main
)

if not defined $BKPCMD (
   echo No program exists for mysqldump
   exit /b 1
)

:: ### Start of program ###
:main

::Welcome text
cls
echo This program backups the MySQL and puts the files in %$DIR%.
echo You need to provide a password for the DB-account used.
echo The program will run until it is stopped with CTRL-C.
echo: 

:: Prompt for password
set /p "$PASSWD=[Please insert password for user root: ]" || set $PASSWD=NothingChosen
if "%$PASSWD%"=="NothingChosen" goto sub_passwd
:: echo %$PASSWD%

:: Prompt for backup interval
set /p "$INTERVAL=[Please insert backup interval in minutes: ]" || set /a "$INTERVAL=0"
call :sub_interval

:: Create the destination directory
mkdir %$DIR% 2>NUL
cd %$DIR%

:begin
call :sub_time

:: Set filename to directory with date and time in name.
set $FILE=%$DIR%\sqldb-backup-%$Datum%-%$Tid%.sql
set $ZIPFILE=%$FILE%%$ZIPEXT%
::echo The file %$FILE%

:: mysqldump has --opt as default option
echo:
echo Do the DB-backup.
%$BKPCMD% --user=%$USER% --password=%$PASSWD% --all-databases --add-drop-database>"%$FILE%"
if %ERRORLEVEL%==1 goto sub_db
echo Done!
echo Backup in file %$FILE%
echo:

:: Compress the file
echo Compressing
%$ZIP% %$ZIPOPT% %$ZIPFILE% %$FILE% >NUL
if not %ERRORLEVEL%==0 call :sub_zip
echo Compressed Backup in file %$ZIPFILE%

:: Loop the script after %$INTERVAL% seconds
echo Sleeping for %$INTERVAL% seconds.
ping -n %$INTERVAL% 127.0.0.1 >NUL
goto begin

:: ### End of main ###

:: ### Start of subs ###
:: No passwd given
:sub_passwd
echo You must provide a password
goto eof

:: If the backup failed
:sub_db
echo Backup failed!!!!!!!
goto eof

:: If z-zip is not installed
:sub_zip
echo No 7-zip detected or error compressing file.
echo The file remains uncompressed
exit /b

:: Date/Time setting
:sub_time
:: Set date
set $Day=%Date:~8,2%
set $Mth=%Date:~5,2%
set $Year=%Date:~0,4%
set $Datum=%$Year%%$Mth%%$Day%

:: Set time
set $Hour=%Time:~0,2%
:: Strip spaces from timma, if any
set $Hour=%$Hour: =%
:: Ensure the hours have a leading zero
if 1%$Hour% LSS 20 Set $Hour=0%$Hour%
set $Minute=%Time:~3,2%
set $Second=%Time:~6,2%
set $Tid=%$Hour%%$Minute%%$Second%
::echo %$Tid%
exit /b

:: set time for backups
:sub_interval
:: Set backup interval in seconds, multiply input with 60
set /a "$INTERVAL*=60"
:: If numeric is zero, use default
if %$INTERVAL% lss 1 (
   	 set /a "$INTERVAL=300"
         echo Using default, 5 minutes.
   )
:: If not a number, use default
if %$INTERVAL%==0 (
      set /a "$INTERVAL=300"
      echo Using default, 5 minutes.
   )
exit /b

:: ### End of subs ###

:eof
endlocal
