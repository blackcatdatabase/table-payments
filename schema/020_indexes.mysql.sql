-- Auto-generated from schema-map-mysql.yaml (map@sha1:09DF9CA612D1573E058190CC207FA257C05AEC1F)
-- engine: mysql
-- table:  payments

CREATE INDEX idx_payments_created_at ON payments (created_at);

CREATE INDEX idx_payments_order_created ON payments (order_id, created_at);
