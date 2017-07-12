@echo off
:: Prompt for host
set /p "$HOST=[Please insert mysql hostname: ]" || set $HOST=localhost
echo %$HOST%

:: Prompt for user
set /p "$USER=[Please insert username: ]" || set $USER=root
echo %$USER%

:: Prompt for password
set /p "$PASSWD=[Please insert password for user root: ]" || set $PASSWD=NothingChosen
if "%$PASSWD%"=="NothingChosen" goto sub_passwd
echo %$PASSWD%

:: Prompt for database
set /p "$DB=[Please insert db-name for restore: ]" || set $DB=vok
echo %$DB%

for /f %%i in ('dir /b *.sql') do mysql.exe --host=%$HOST% --user=%$USER%  --password=%$PASSWD% --database=%$DB% < %%i

:sub_passwd
exit /b 1

