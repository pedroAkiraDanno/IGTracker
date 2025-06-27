




-- -------------------------------------------------------------------------------------------------------------------------------------
-- DB: IG 





-- MY MULTIPLE ACCOUNTS (e.g. Instagram A, Instagram B, Twitter A)
CREATE TABLE my_accounts (
    id SERIAL PRIMARY KEY,
    platform VARCHAR(50) NOT NULL, -- e.g. 'Instagram', 'Twitter'
    username VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    email VARCHAR(255),
    is_verified BOOLEAN DEFAULT FALSE,
    is_business BOOLEAN DEFAULT FALSE,
    profile_picture_url TEXT,
    bio TEXT,
    followers_count INTEGER,
    following_count INTEGER,
    posts_count INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    UNIQUE (platform, username)
);




-- EXTERNAL PEOPLE (followers and following)
CREATE TABLE external_users (
    id SERIAL PRIMARY KEY,
    platform VARCHAR(50),
    username VARCHAR(100),
    full_name VARCHAR(255),    
    is_verified BOOLEAN DEFAULT FALSE,
    is_private BOOLEAN DEFAULT FALSE,    
    profile_url TEXT,    
    is_famous BOOLEAN DEFAULT FALSE,   
    gender VARCHAR(10),     
    followers_count INTEGER,
    following_count INTEGER,
    posts_count INTEGER,        
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,    
    UNIQUE (platform, username)
);






-- WHO I FOLLOW
CREATE TABLE account_following (
    id SERIAL PRIMARY KEY,
    account_id INT REFERENCES my_accounts(id) ON DELETE CASCADE,
    external_user_id INT REFERENCES external_users(id) ON DELETE CASCADE,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    UNIQUE (account_id, external_user_id)
);






-- WHO FOLLOWS ME
CREATE TABLE account_followers (
    id SERIAL PRIMARY KEY,
    account_id INT REFERENCES my_accounts(id) ON DELETE CASCADE,
    external_user_id INT REFERENCES external_users(id) ON DELETE CASCADE,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    notes TEXT,
    UNIQUE (account_id, external_user_id)
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
SELECT * FROM "account";
SELECT * FROM "account_type";
SELECT * FROM "banks_company";
SELECT * FROM "categories";
SELECT * FROM "categories_income";
SELECT * FROM "companies";
SELECT * FROM "credit_cards";
SELECT * FROM "income";
SELECT * FROM "invoices";
SELECT * FROM "payment_methods";
SELECT * FROM "spending_limits";
SELECT * FROM "subcategories";
SELECT * FROM "transactions";
SELECT * FROM "transf_account";
SELECT * FROM "user_activity";
SELECT * FROM "users";






-- -------------------------------------------------------------------------------------------------------------------------------------














-- -------------------------------------------------------------------------------------------------------------------------------------



-- Database backup and restore commands

-- Backup the 'finances' database
--"C:\Program Files\PostgreSQL\17\bin\pg_dump.exe" -U postgres -h localhost -p 5432 -F c -b -v -f "C:\PostgreSQL\finances_22042025New.backup" finances;
"C:\Program Files\PostgreSQL\17\bin\pg_dump.exe" -U postgres -h localhost -p 5432 -F p -b -v -f "C:\PostgreSQL\finances_24062025_New.sql" IG




-- Create a new database for homologation (testing purposes)
"C:\Program Files\PostgreSQL\17\bin\createdb.exe" -U postgres -h localhost -p 5432 IG




-- Restore the backup into the 'finances_Homolog' database
--"C:\Program Files\PostgreSQL\17\bin\pg_restore.exe" -U postgres -h localhost -p 5432 -d finances_Homolog -v "C:\PostgreSQL\finances_22042025New.backup";
"C:\Program Files\PostgreSQL\17\bin\psql.exe" -U postgres -h localhost -p 5432 -d IG < "C:\PostgreSQL\finances_24062025_New.sql"




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












