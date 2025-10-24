-- Auto-generated from schema-map-mysql.psd1 (map@mtime:2025-10-24T09:13:35Z)
-- engine: mysql
-- table:  payments
CREATE TABLE IF NOT EXISTS payments (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  order_id BIGINT UNSIGNED NULL,
  gateway VARCHAR(100) NOT NULL,
  transaction_id VARCHAR(255) NULL,
  provider_event_id VARCHAR(255) NULL,
  status ENUM('initiated','pending','authorized','paid','cancelled','partially_refunded','refunded','failed') NOT NULL,
  amount DECIMAL(12,2) NOT NULL,
  currency CHAR(3) NOT NULL,
  details JSON NULL,
  created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
  UNIQUE KEY uq_payments_transaction_id (transaction_id),
  INDEX idx_payments_order (order_id),
  INDEX idx_payments_provider_event (provider_event_id),
  CONSTRAINT chk_payments_currency CHECK (currency REGEXP '^[A-Z]{3}$')
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
