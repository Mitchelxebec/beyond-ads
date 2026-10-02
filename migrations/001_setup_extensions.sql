-- Up Migration
-- Safely enable UUID generation system-wide
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

--- Down Migration
-- We leave this BLANK or commented out!
-- Once an extension is running in a live database, we almost never want to drop it.
-- -- DROP EXTENSION IF EXISTS "pgcrypto";