## Utilities for MeOS, OLA and Eventor, used for orienteering.
- Backup of MariaDB/MySQL-database.
- Ping-checker for connectivity testing/verifying.
- Config for NTP
- For utilities regarding OL events, OLA and MeOS see INSTALL.md


## Backup and restore tips
### Making a Copy of a Database

    shell> mysqldump db1 > dump.sql
    shell> mysqladmin create db2
    shell> mysql db2 < dump.sql

You can load the dump file back into the server like this:

    shell> mysqldump db_name > backup-file.sql
    shell> mysql db_name < backup-file.sql

### backup all databases in one file (eventually add the option --add-locks):

    mysqldump -u username -p -–all-databases > file.sql

### backup all databases in one gzipped file:

    mysqldump -u username -p -–all-databases | gzip > file.sql.gz

### restore all databases:

    mysql -u username -p < file.sql
