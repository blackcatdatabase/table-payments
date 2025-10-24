-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-10-24T09:46:38Z)
-- engine: postgres
-- table:  payments
CREATE INDEX idx_payments_order ON payments (order_id);

CREATE INDEX idx_payments_provider_event ON payments (provider_event_id);

CREATE INDEX idx_payments_created_at ON payments (created_at);
