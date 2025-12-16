-- Auto-generated from schema-map-mysql.yaml (map@sha1:B9D3BE28A74392B9B389FDAFB493BD80FA1F6FA4)
-- engine: mysql
-- table:  payments

CREATE INDEX idx_payments_created_at ON payments (created_at);

CREATE INDEX idx_payments_order_created ON payments (order_id, created_at);
