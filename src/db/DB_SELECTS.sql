




-- -------------------------------------------------------------------------------------------------------------------------------------
-- DB: IG 




CREATE TABLE IF NOT EXISTS instagram_accounts (
    account_id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL
);




CREATE TABLE IF NOT EXISTS current_follows (
    account_id INTEGER REFERENCES instagram_accounts(account_id),
    username VARCHAR(255) NOT NULL,
    full_name TEXT,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (account_id, username)
);




CREATE TABLE IF NOT EXISTS follow_history (
    id SERIAL PRIMARY KEY,
    account_id INTEGER REFERENCES instagram_accounts(account_id),
    username VARCHAR(255) NOT NULL,
    full_name TEXT,
    action VARCHAR(10) NOT NULL CHECK (action IN ('follow', 'unfollow')),
    timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


































-------------------------------------------------------------------------------------------------------------------------------------




sudo -u postgres psql
CREATE DATABASE your_database_name;
CREATE USER your_username WITH PASSWORD 'your_password';
ALTER ROLE your_username SET client_encoding TO 'utf8';
ALTER ROLE your_username SET default_transaction_isolation TO 'read committed';
ALTER ROLE your_username SET timezone TO 'UTC';
GRANT ALL PRIVILEGES ON DATABASE your_database_name TO your_username;
\q




psql -h localhost -U your_username -d your_database_name -f schema.sql











-- -------------------------------------------------------------------------------------------------------------------------------------
-- SELECT ABOUT ALL TABLES 




-- Retrieve information about all tables in the 'public' schema
select * from information_schema.tables 
where table_schema = 'public' and table_type = 'BASE TABLE' 
order by tables;





-- all tables
SELECT * FROM public.instagram_accounts;
SELECT * FROM follow_history;
SELECT * FROM current_follows;














-- -------------------------------------------------------------------------------------------------------------------------------------














-- -------------------------------------------------------------------------------------------------------------------------------------



-- Database backup and restore commands

-- Backup the 'finances' database
--"C:\Program Files\PostgreSQL\17\bin\pg_dump.exe" -U postgres -h localhost -p 5432 -F c -b -v -f "C:\PostgreSQL\finances_22042025New.backup" finances;
"C:\Program Files\PostgreSQL\17\bin\pg_dump.exe" -U postgres -h localhost -p 5432 -F p -b -v -f "C:\PostgreSQL\finances_24062025_New.sql" instagram_tracker




-- Create a new database for homologation (testing purposes)
"C:\Program Files\PostgreSQL\17\bin\createdb.exe" -U postgres -h localhost -p 5432 instagram_tracker




-- Restore the backup into the 'finances_Homolog' database
--"C:\Program Files\PostgreSQL\17\bin\pg_restore.exe" -U postgres -h localhost -p 5432 -d finances_Homolog -v "C:\PostgreSQL\finances_22042025New.backup";
"C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -h localhost -p 5432 -d instagram_tracker < "C:\PostgreSQL\finances_24062025_New.sql"




-- AZURE service POSTGRESQL
-- "C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgresadm -h srvpostgresql23062025.postgres.database.azure.com -p 5432 -d finances_Dev < "C:\PostgreSQL\finances_21062025_New.sql"





-- -------------------------------------------------------------------------------------------------------------------------------------




-- Dropping tables in reverse order to avoid foreign key constraint issues
-- DROP TABLE IF EXISTS categories CASCADE;
-- DROP TABLE IF EXISTS categories_income CASCADE;
-- DROP TABLE IF EXISTS companies CASCADE;
-- DROP TABLE IF EXISTS credit_cards CASCADE;
-- DROP TABLE IF EXISTS income CASCADE;
-- DROP TABLE IF EXISTS payment_methods CASCADE;
-- DROP TABLE IF EXISTS transactions CASCADE;
-- DROP TABLE IF EXISTS users CASCADE;
-- DROP TABLE IF EXISTS account CASCADE;
-- DROP TABLE IF EXISTS banks_company CASCADE;

-- Optional: Drop other objects (like functions, types, etc.) if needed
-- You can add commands to drop sequences or indexes if created manually.

-- Optional: Drop constraints if there are any
-- DROP CONSTRAINT IF EXISTS <constraint_name>;












