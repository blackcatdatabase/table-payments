-- Auto-generated from schema-views-postgres.psd1 (map@mtime:2025-10-24T09:45:40Z)
-- engine: postgres
-- table:  payments
-- Contract view for [payments]
-- Includes "details" JSON; mask in your app if it can contain sensitive provider payloads.
CREATE OR REPLACE VIEW vw_payments AS
SELECT
  id,
  order_id,
  gateway,
  transaction_id,
  provider_event_id,
  status,
  amount,
  currency,
  details,
  created_at,
  updated_at
FROM payments;
