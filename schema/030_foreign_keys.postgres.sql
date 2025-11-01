-- Auto-generated from schema-map-postgres.psd1 (map@c5e4097)
-- engine: postgres
-- table:  payments
ALTER TABLE payments ADD CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL;

ALTER TABLE payments ADD CONSTRAINT chk_payments_amount CHECK (amount >= 0);
