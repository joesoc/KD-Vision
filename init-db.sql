CREATE TABLE IF NOT EXISTS search_analytics (
    id SERIAL PRIMARY KEY,
    timestamp TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    user_id TEXT,
    session_id TEXT,
    query TEXT,
    clicked_item TEXT,
    source TEXT, -- e.g., 'ui', 'log', 'nifi'
    response_time_ms INTEGER,
    metadata JSONB
);
