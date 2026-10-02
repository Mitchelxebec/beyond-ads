-- Up Migration
CREATE TABLE ads (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    campaign_id UUID NOT NULL REFERENCES campaigns (id) ON DELETE CASCADE,
    image_url TEXT NOT NULL,
    click_url TEXT NOT NULL,
    width INTEGER NOT NULL,
    height INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),

-- DATABASE SECURITY GUARDS (CHECK CONSTRAINTS)
CONSTRAINT check_ad_width CHECK (width >= 1),
    CONSTRAINT check_ad_height CHECK (height >= 1)
);

CREATE TABLE placements (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid (),
    publisher_id UUID NOT NULL REFERENCES publishers (id) ON DELETE RESTRICT,
    name TEXT NOT NULL,
    width INTEGER NOT NULL,
    height INTEGER NOT NULL,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    -- 💡 THE AUDIT TRAIL / SOFT DELETE COLUMN:
    deleted_at TIMESTAMPTZ DEFAULT NULL,

-- DATABASE SECURITY GUARDS (CHECK CONSTRAINTS)
CONSTRAINT check_placement_width CHECK (width >= 1),
    CONSTRAINT check_placement_height CHECK (height >= 1)
);

-- Index for the foreign keys

CREATE INDEX idx_ads_dimensions ON ads (campaign_id, width, height);

CREATE INDEX idx_placements_publisher_id ON placements (publisher_id);

-- Down Migration
DROP IF EXISTS idx_ads_dimensions;

DROP INDEX IF EXISTS idx_placements_publisher_id;

DROP TABLE IF EXISTS placements;

DROP TABLE IF EXISTS ads;