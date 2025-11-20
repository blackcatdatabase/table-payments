-- Auto-generated from schema-map-mysql.psd1 (map@62c9c93)
-- engine: mysql
-- table:  payments
CREATE TABLE IF NOT EXISTS payments (
  id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  tenant_id BIGINT UNSIGNED NOT NULL,
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
  version INT UNSIGNED NOT NULL DEFAULT 0,
  UNIQUE KEY ux_payments_tenant_tx (tenant_id, transaction_id),
  UNIQUE KEY ux_payments_tenant_id (tenant_id, id),
  INDEX idx_payments_tenant (tenant_id),
  INDEX idx_payments_tenant_order (tenant_id, order_id),
  INDEX idx_payments_order (order_id),
  INDEX idx_payments_provider_event (provider_event_id),
  CONSTRAINT chk_payments_currency CHECK (currency REGEXP '^[A-Z]{3}$'),
  CONSTRAINT chk_payments_version CHECK (version >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci ROW_FORMAT=DYNAMIC;
