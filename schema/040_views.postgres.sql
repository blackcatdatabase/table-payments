-- Auto-generated from schema-views-postgres.psd1 (map@38d5403)
-- engine: postgres
-- table:  payments
-- Contract view for [payments]
-- Includes "details" JSON; mask in your app if needed.
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
