-- Create a new postgres user named `has_many_user`
CREATE user has_many_user;

-- Create a new database named `has_many_blogs` owned by `has_many_user`
CREATE DATABASE has_many_blogs;

-- Before each create table statement, add a drop table if exists statement.
-- In `has_many_blogs.sql` Create the tables (including any PKs, Indexes, and Constraints that you may need) to fulfill the requirements of the **has_many_blogs schema** below.
-- Create the necessary FKs needed to relate the tables according to the **relationship table** below.

DROP TABLE IF EXISTS users;
-- 207ms 1row

CREATE TABLE users (
  id SERIAL PRIMARY KEY NOT NULL,
  username character varying(90) NOT NULL,
  first_name character varying(90) NULL default NULL,
  last_name character varying(90) NULL default NULL,
  created_at TIMESTAMP with time zone NOT NULL default now(),
  updated_at TIMESTAMP with time zone NOT NULL default now()
);
-- 137ms 1row without foreign keys
-- 324ms 1row 
ALTER TABLE users ALTER COLUMN updated_at set DEFAULT current_timestamp;
ALTER TABLE users ALTER COLUMN created_at set DEFAULT current_timestamp;

DROP TABLE IF EXISTS posts
-- 42ms 1row

CREATE TABLE posts (
  id SERIAL PRIMARY KEY NOT NULL,
  title character varying(180) NULL default NULL,
  url character varying(510) NULL default NULL,
  content text NULL default NULL,
  created_at TIMESTAMP with time zone NOT NULL DEFAULT current_timestamp,
  updated_at TIMESTAMP with time zone NOT NULL DEFAULT current_timestamp,
  user_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id)
);
-- 88ms 1row without foreign keys
-- 316ms 1row

-- delete all content in table along with references to other tables
TRUNCATE TABLE posts CASCADE;

DROP TABLE IF EXISTS comments
-- 35ms 1row

CREATE TABLE comments (
  id SERIAL PRIMARY KEY NOT NULL,
  body character varying(510) NULL default NULL,
  created_at TIMESTAMP with time zone NOT NULL DEFAULT current_timestamp,
  updated_at TIMESTAMP with time zone NOT NULL DEFAULT current_timestamp,
  user_id INTEGER NOT NULL,
  post_id INTEGER NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users (id),
  FOREIGN KEY (post_id) REFERENCES posts (id)
);
-- 87ms 1row without foreign keys
-- 513ms 1row

-- ADD if does not exist, from Wymin
-- ALTER TABLE posts ADD user_id INTEGER NOT NULL;
-- ALTER TABLE posts ADD FOREIGN KEY (user_id) REFERENCES users(id);
-- ALTER TABLE comments ADD user_id INTEGER NOT NULL;
-- ALTER TABLE comments ADD post_id INTEGER NOT NULL;
-- ALTER TABLE comments ADD FOREIGN KEY (user_id) REFERENCES users(id);
-- ALTER TABLE comments ADD FOREIGN KEY (post_id) REFERENCES posts(id);

-- unless running manually in the Terminal, delete `\c has_many_blogs` in `scripts/blog_data.sql`, that is only used for a manual insert into tables when in the Terminal
-- For Ubuntu users, download TeamSql to INSERT INTO tables, DBeaver hangs and does not respond, 
-- to run TeamSql, search in browser on how to run AppImages: 
-- open a Terminal, cd to Downloads, then `chmod a+x TeamSQL-4.0.341-x86_64.AppImage`, then `./TeamSQL-4.0.341-x86_64.AppImage` 
-- Run the provided `scripts/blog_data.sql`
