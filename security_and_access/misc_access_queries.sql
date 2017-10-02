-----------
-- MISC SQL 
-----------
select current_database();
select current_user;    -- select user; also works
select version();
select current_schema();
select session_user;

select * from pg_catalog.pg_user;     -- can drop the schemaname since pg_user is unique
select * from pg_database;            -- select datname, datdba, usename from pg_database pgd join pg_user pgu on pgu.usesysid = pgd.datdba;
select * from pg_catalog.pg_tables;     
