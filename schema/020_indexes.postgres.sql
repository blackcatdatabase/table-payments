-- Auto-generated from schema-map-postgres.psd1 (map@62c9c93)
-- engine: postgres
-- table:  payments
CREATE INDEX IF NOT EXISTS idx_payments_order ON payments (order_id);

CREATE INDEX IF NOT EXISTS idx_payments_provider_event ON payments (provider_event_id);

CREATE INDEX IF NOT EXISTS idx_payments_created_at ON payments (created_at);

CREATE INDEX IF NOT EXISTS gin_payments_details     ON payments      USING GIN (details jsonb_path_ops);

CREATE UNIQUE INDEX IF NOT EXISTS ux_payments_tenant_tx ON payments (tenant_id, transaction_id);

CREATE INDEX IF NOT EXISTS idx_payments_tenant_order ON payments (tenant_id, order_id);

CREATE UNIQUE INDEX IF NOT EXISTS ux_payments_tenant_id ON payments (tenant_id, id);
