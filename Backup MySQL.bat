@echo off

Rem Ange databasnamn nedan.
Rem
set database=garnm2015

Rem Ange användarnamn i MySQL nedan.
Rem
set username=root

Rem Ange lösenord till ovanstående användare nedan.
Rem
set password=HemligtLösenord

Rem Ange sökväg till backuperna nedan. En avslutande \ på sökvägen.
Rem
set backuppath=E:\backup\

Rem Ange antal sekunder det ska gå mellan varje backup
Rem
set sleeptime=300


:igen
set tempvar=%TIME:~0,2%
If %tempvar% geq 10 (
   set hour=%tempvar%
) Else (
   set hour=0%tempvar:~1,1%%
)
set tempvar=%TIME:~3,2%
If %tempvar% geq 10 (
   set minute=%tempvar%
) Else (
   set minute=0%tempvar:~1,1%%
)
set backupname=Backup-Database_%database%-%DATE:~0,4%-%DATE:~5,2%-%DATE:~8,2%--%hour%-%minute%.sql
echo Running dump of database %database% to
echo %backuppath%%backupname%
"C:\Program Files\MySQL\MySQL Server 5.6\bin\mysqldump" -u%username% -p%password% --no-create-info=FALSE --order-by-primary=FALSE --default-character-set=utf8 --force=FALSE --no-data=FALSE --tz-utc=TRUE --flush-privileges=FALSE --compress=FALSE --replace=TRUE --host=localhost --extended-insert=TRUE --quote-names=TRUE --hex-blob=FALSE --complete-insert=FALSE --port=3306 --disable-keys=TRUE --delayed-insert=FALSE --delete-master-logs=FALSE --comments=TRUE --max_allowed_packet=1G --insert-ignore=FALSE --flush-logs=FALSE --dump-date=TRUE --allow-keywords=FALSE --create-options=TRUE --events=FALSE --routines --databases --result-file="%backuppath%%backupname%" "%database%"
"c:\Program Files\WinRAR\RAR.exe" a "%backuppath%%backupname%.rar" "%backuppath%%backupname%"
del "%backuppath%%backupname%"
echo Done!
echo.
echo Waiting %sleeptime% seconds to make new backup... Press Ctrl-C to end backups...
echo.
Sleep.exe %sleeptime%
Goto igen:
