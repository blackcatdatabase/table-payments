<!-- Auto-generated from schema-map.psd1 @ 1e83bb6 (2025-10-21T10:18:36+02:00) -->
# Definition – payments

Payment attempts and final captures for orders.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT UNSIGNED | — | — | Surrogate primary key. |  |
| order_id | BIGINT UNSIGNED | YES | — | Order (FK orders.id). |  |
| gateway | VARCHAR(100) | NO | — | Payment gateway key (e.g., stripe, gopay). |  |
| transaction_id | VARCHAR(255) | YES | — | Provider transaction id (unique if provided). |  |
| provider_event_id | VARCHAR(255) | YES | — | Provider event id (optional). |  |
| status | ENUM('initiated','pending','authorized','paid','cancelled','partially_refunded','refunded','failed') | NO | — | Payment state. | enum: initiated, pending, authorized, paid, cancelled, partially_refunded, refunded, failed |
| amount | DECIMAL(12,2) | NO | — | Payment amount. |  |
| currency | CHAR(3) | NO | — | ISO 4217 currency code. |  |
| details | JSON | YES | — | JSON with provider details/receipts. |  |
| created_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |  |
| updated_at | DATETIME(6) | NO | CURRENT_TIMESTAMP(6) | Update timestamp (UTC). |  |