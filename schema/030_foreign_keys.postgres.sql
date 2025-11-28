-- Auto-generated from schema-map-postgres.psd1 (map@mtime:2025-11-21T00:25:46Z)
-- engine: postgres
-- table:  payments

ALTER TABLE payments ADD CONSTRAINT fk_payments_tenant FOREIGN KEY (tenant_id) REFERENCES tenants(id) ON DELETE RESTRICT;

ALTER TABLE payments ADD CONSTRAINT fk_payments_order FOREIGN KEY (tenant_id, order_id) REFERENCES orders(tenant_id, id) ON DELETE SET NULL;

ALTER TABLE payments ADD CONSTRAINT chk_payments_amount CHECK (amount >= 0);
