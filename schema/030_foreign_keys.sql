-- Auto-generated from schema-map.psd1 (map@1e83bb6)
-- table: payments
ALTER TABLE payments ADD CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL;
