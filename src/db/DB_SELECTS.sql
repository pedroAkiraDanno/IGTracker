




-- -------------------------------------------------------------------------------------------------------------------------------------
-- DB: IG 









-- Table 1: Your Instagram accounts
CREATE TABLE accounts (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    email VARCHAR(255),
    is_verified BOOLEAN DEFAULT FALSE,
    is_business BOOLEAN DEFAULT FALSE,
    profile_url TEXT,
    bio TEXT,
    followers_count INTEGER,
    following_count INTEGER,
    posts_count INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);










-- Table 2: People you follow (followers)
CREATE TABLE followed_users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(255) UNIQUE NOT NULL,
    full_name VARCHAR(255),
    is_verified BOOLEAN DEFAULT FALSE,
    is_private BOOLEAN DEFAULT FALSE,
    profile_picture_url TEXT,
    bio TEXT,
    external_url TEXT,
    followers_count INTEGER,
    following_count INTEGER,
    posts_count INTEGER,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);








-- Table 3: Follow relationships (link between your accounts and followed users)
CREATE TABLE follows (
    id SERIAL PRIMARY KEY,
    account_id INTEGER NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
    followed_user_id INTEGER NOT NULL REFERENCES followed_users(id) ON DELETE CASCADE,
    followed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    unfollowed_at TIMESTAMP,                   -- Optional: if user is unfollowed
    is_active BOOLEAN DEFAULT TRUE,            -- Still following = true
    notes TEXT,                                -- Optional user notes
    UNIQUE (account_id, followed_user_id)      -- Prevent duplicate relationships
);

























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












