-- Auto-generated from schema-map-mysql.psd1 (map@mtime:2025-11-27T15:13:14Z)
-- engine: mysql
-- table:  payments

CREATE INDEX idx_payments_created_at ON payments (created_at);

CREATE INDEX idx_payments_order_created ON payments (order_id, created_at);
