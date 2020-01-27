@ECHO OFF
REM =============================================================================
REM =============================================================================
REM ======                                                              =========
REM ====== This script will drop the DB specified, then create the DB  =========
REM ====== specified, and then load all .sql tables from its run dir to =========
REM ====== the the DB.                                                  =========
REM ======                                                              =========
REM ====== File needs to be run from within the \dsp\sql folder (same   =========
REM ====== folder with all the .sql files. Please edit as needed. By    =========
REM ====== default it WILL DROP the standard dspdb DB, losing all       =========
REM ====== accounts and characters. If this is not desired, then update =========
REM ====== the file to load the new DB into a new DB name.              =========
REM ======                                                              =========
REM ====== Update -p with MySQL password. If you password is 'foo',     =========
REM ====== then change '-pMYSQLPASS' to '-pfoo' (3 places).             =========
REM ======                                                              =========
REM ====== If you want to use a different database name, change 'dspdb' =========
REM ====== with a database name of your choosing.                       =========
REM ======                                                              =========
REM =============================================================================
REM =============================================================================

ECHO Creating Database dspdb
"C:\Program Files (x86)\MySQL\MySQL Server 5.7\bin\mysqladmin" -h localhost -u root -pPromyvion! DROP dspdb

ECHO Creating Database dspdb
"C:\Program Files (x86)\MySQL\MySQL Server 5.7\bin\mysqladmin" -h localhost -u root -pPromyvion! CREATE dspdb

ECHO Loading dspdb tables into the database
cd "C:\FINAL FANTASY XI - Dawnbreak\darkstar\sql"
FOR %%X IN (*.sql) DO ECHO Importing %%X & "C:\Program Files (x86)\MySQL\MySQL Server 5.7\bin\mysql" dspdb -h localhost -u root -pPromyvion! < %%X

ECHO Finished!