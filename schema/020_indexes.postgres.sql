-- Auto-generated from schema-map-postgres.psd1 (map@38d5403)
-- engine: postgres
-- table:  payments
CREATE INDEX IF NOT EXISTS idx_payments_order ON payments (order_id);

CREATE INDEX IF NOT EXISTS idx_payments_provider_event ON payments (provider_event_id);

CREATE INDEX IF NOT EXISTS idx_payments_created_at ON payments (created_at);
