<!-- Auto-generated from schema-map-postgres.psd1 @ 62c9c93 (2025-11-20T21:38:11+01:00) -->
# Definition – payments

Payment attempts and final captures for orders.

## Columns
| Column | Type | Null | Default | Description | Notes |
|-------:|:-----|:----:|:--------|:------------|:------|
| id | BIGINT | — | AS | Surrogate primary key. |  |
| tenant_id | BIGINT | NO | — |  |  |
| order_id | BIGINT | YES | — | Order (FK orders.id). |  |
| gateway | VARCHAR(100) | NO | — | Payment gateway key (e.g., stripe, gopay). |  |
| transaction_id | VARCHAR(255) | YES | — | Provider transaction id (unique if provided). |  |
| provider_event_id | VARCHAR(255) | YES | — | Provider event id (optional). |  |
| status | TEXT | NO | — | Payment state. | enum: initiated, pending, authorized, paid, cancelled, partially_refunded, refunded, failed |
| amount | NUMERIC(12,2) | NO | — | Payment amount. Must be >= 0. |  |
| currency | CHAR(3) | NO | — | ISO 4217 currency code. |  |
| details | JSONB | YES | — | JSON with provider details/receipts. |  |
| created_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |  |
| updated_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Update timestamp (UTC). |  |
| version | INTEGER | NO | 0 |  |  |