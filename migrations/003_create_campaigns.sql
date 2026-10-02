--Up Migration
CREATE TABLE campaigns (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    advertiser_id UUID NOT NULL REFERENCES advertisers (id) ON DELETE RESTRICT,
    name TEXT NOT NULL,
    --Exact financial decimals (up to 15 digits total, 4 for fraction of a cent)
    total_budget NUMERIC(15, 4) NOT NULL,
    spent NUMERIC(15, 4) NOT NULL DEFAULT 0.0000,
    start_date TIMESTAMPTZ NOT NULL,
    end_date TIMESTAMPTZ NOT NULL,
    status TEXT NOT NULL DEFAULT 'paused' CHECK (
        status IN ('active', 'paused', 'ended')
    ),
    target_countries TEXT [] NOT NULL DEFAULT '{}',
    target_devices TEXT [] NOT NULL DEFAULT '{}',
    min_age INTEGER NOT NULL DEFAULT 0,
    max_age INTEGER NOT NULL DEFAULT 100,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

-- 💡 THE AUDIT TRAIL / SOFT DELETE COLUMN:
deleted_at TIMESTAMPTZ DEFAULT NULL,

-- DATABASE SECURITY GUARDS (CHECK CONSTRAINTS)
CONSTRAINT check_budget_limit CHECK (spent <= total_budget),
    CONSTRAINT check_valid_dates CHECK (end_date >= start_date),
    CONSTRAINT check_valid_ages CHECK (max_age >= min_age)
);

-- Normal Index
CREATE INDEX idx_campaigns_performance ON campaigns (status, start_date, end_date);

CREATE INDEX idx_campaigns_advertiser_id ON campaigns (advertiser_id);

-- GIN for target countries and devices
CREATE INDEX idx_campaigns_target_countries ON campaigns USING GIN (target_countries);

CREATE INDEX idx_campaigns_target_devices ON campaigns USING GIN (target_devices);

-- Down Migration
DROP INDEX IF EXISTS idx_campaigns_performance;

DROP INDEX IF EXISTS idx_campaigns_advertiser_id;

DROP INDEX IF EXISTS idx_campaigns_target_devices;

DROP INDEX IF EXISTS idx_campaigns_target_countries;

DROP TABLE IF EXISTS campaigns;