-- Auto-generated from schema-map-mysql.yaml (map@sha1:0D716345C0228A9FD8972A3D31574000D05317DB)
-- engine: mysql
-- table:  payments

CREATE INDEX idx_payments_created_at ON payments (created_at);

CREATE INDEX idx_payments_order_created ON payments (order_id, created_at);
