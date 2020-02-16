@ECHO OFF
cd ..\sql
ECHO Before using this you must first edit this file to use the database name,
ECHO MySQL user and MySQL password to match what your server actually uses.
ECHO Please try NOT to accidently commit that information to your repository.
ECHO ---------------------------------
ECHO Do not add tables to batch unless certain no character/account data will be harmed!
ECHO ------------------------------------------------------------------
PAUSE
set mysqlExec="C:\Program Files\MySQL\MySQL Server 8.0\bin\mysql.exe"
set sqlPass="gamecube"
ECHO ---------------------------------
ECHO Importing system data tables...
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < augments.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < status_effects.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < synth_recipes.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < zone_settings.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < treasure_spawn_points.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < transport.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < exp_table.sql
ECHO ---------------------------------
ECHO Importing ability/trait/ws/merit tables...
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < abilities.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < abilities_charges.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < traits.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < weapon_skills.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < merits.sql
ECHO ---------------------------------
ECHO Importing spell tables...
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < spell_list.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < blue_spell_list.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < blue_spell_mods.sql
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < blue_traits.sql
ECHO ---------------------------------
ECHO Importing bcnm and instance tables...
FOR %%X IN (bcnm*.sql) DO ECHO Importing %%X & %mysqlExec% dspdb -h localhost -u root -p%sqlPass% < %%X
FOR %%X IN (instance*.sql) DO ECHO Importing %%X & %mysqlExec% dspdb -h localhost -u root -p%sqlPass% < %%X
ECHO ---------------------------------
ECHO Importing guild tables...
FOR %%X IN (guild*.sql) DO ECHO Importing %%X & %mysqlExec% dspdb -h localhost -u root -p%sqlPass% < %%X
ECHO ------------------------------------------------------------------
ECHO Importing item tables...
FOR %%X IN (item*.sql) DO ECHO Importing %%X & %mysqlExec% dspdb -h localhost -u root -p%sqlPass% < %%X
FOR %%X IN (fishing*.sql) DO ECHO Importing %%X & %mysqlExec% dspdb -h localhost -u root -p%sqlPass% < %%X
ECHO ---------------------------------
ECHO importing mob and npc tables...
FOR %%X IN (mob*.sql) DO ECHO Importing %%X & %mysqlExec% dspdb -h localhost -u root -p%sqlPass% < %%X
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < nm_spawn_points.sql
FOR %%X IN (npc*.sql) DO ECHO Importing %%X & %mysqlExec% dspdb -h localhost -u root -p%sqlPass% < %%X
ECHO ---------------------------------
ECHO Importing custom tables...
cd custom
FOR %%X IN (*.sql) DO ECHO Importing %%X & %mysqlExec% dspdb -h localhost -u root -p%sqlPass% < %%X
cd ..
ECHO ---------------------------------
ECHO Resetting triggers.
%mysqlExec% dspdb -h localhost -u root -p%sqlPass% < triggers.sql
set %mysqlExec%=""
ECHO Finished!
PAUSE
PAUSE