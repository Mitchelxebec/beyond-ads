-- Up Migration
-- Enable UUID generation capability in Postgres
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

--Create the advertisers table
CREATE TABLE advertisers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    -- 💡 THE AUDIT TRAIL / SOFT DELETE COLUMN:
    deleted_at TIMESTAMPTZ DEFAULT NULL
);

--Create the publishers table
CREATE TABLE publishers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    name TEXT NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
    -- 💡 THE AUDIT TRAIL / SOFT DELETE COLUMN:
    deleted_at TIMESTAMPTZ DEFAULT NULL 
);

--Down Migration
DROP TABLE IF EXISTS publishers;

DROP TABLE IF EXISTS advertisers;