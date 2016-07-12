@echo off
set mySqlPath=C:\Program Files\MySQL\MySQL Server 5.6
set dbUser=root
set dbPassword=xxxx
set dbName=silvaleague
set file=%dbName%_%DATE%_-_%time:~0,2%%time:~3,2%%time:~6,2%.sql
set path=C:\T\Silva League\Backup

echo Kör backup på %dbName% ^> ^%path%\%file%
"%mySqlPath%\bin\mysqldump.exe" -u %dbUser% -p%dbPassword% --max_allowed_packet=1G --host=localhost --port=3306 --default-character-set=utf8 --single-transaction=TRUE --result-file="%path%\%file%" --databases %dbName%
echo Kopiera till USB-disk
copy "%path%\%file%" E:\SilvaLeague
echo Klar med Silva League
