-- Auto-generated from schema-map.psd1 on 2025-10-21T02:32:05
-- table: payments
ALTER TABLE payments ADD CONSTRAINT fk_payments_order FOREIGN KEY (order_id) REFERENCES orders(id) ON DELETE SET NULL;
