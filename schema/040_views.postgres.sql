-- Auto-generated from schema-views-postgres.yaml (map@sha1:EDC13878AE5F346E7EAD2CF0A484FEB7E68F6CDD)
-- engine: postgres
-- table:  payments

-- Contract view for [payments]
-- Includes "details" JSON; mask in your app if needed.
CREATE OR REPLACE VIEW vw_payments AS
SELECT
  id,
  tenant_id,
  order_id,
  gateway,
  transaction_id,
  provider_event_id,
  status,
  amount,
  currency,
  details,
  created_at,
  updated_at,
  version
FROM payments;

-- Auto-generated from schema-views-postgres.psd1 (map@62c9c93)
-- engine: postgres
-- table:  payments_anomalies
-- Potential anomalies in payments
CREATE OR REPLACE VIEW vw_payments_anomalies AS
SELECT
  p.*
FROM payments p
WHERE
  (status IN (''paid'',''authorized'') AND amount < 0)
  OR (status = ''paid'' AND (transaction_id IS NULL OR transaction_id = ''''))
  OR (status = ''failed'' AND amount > 0);


-- Auto-generated from schema-views-postgres.psd1 (map@62c9c93)
-- engine: postgres
-- table:  payments_status_summary
-- Payment status summary by gateway
CREATE OR REPLACE VIEW vw_payments_status_summary AS
SELECT
  gateway,
  status,
  COUNT(*) AS total,
  SUM(amount) FILTER (WHERE status IN (''authorized'',''paid'',''partially_refunded'',''refunded'')) AS sum_amount
FROM payments
GROUP BY gateway, status
ORDER BY gateway, status;

