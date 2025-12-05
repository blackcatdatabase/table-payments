-- Auto-generated from schema-map-mysql.yaml (map@sha1:5E62933580349BE7C623D119AC9D1301A62F03EF)
-- engine: mysql
-- table:  payments

CREATE INDEX idx_payments_created_at ON payments (created_at);

CREATE INDEX idx_payments_order_created ON payments (order_id, created_at);
