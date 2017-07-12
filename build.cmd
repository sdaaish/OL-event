@echo off

echo builds a release
7z a .\OL-event.zip check-roc.ps1 example-infile.txt mysqldb-backup.cmd ntp.conf pingloop.cmd LICENSE
