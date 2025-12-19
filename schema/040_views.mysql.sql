-- Auto-generated from schema-views-mysql.yaml (map@sha1:39CF23914A48753BF55EEB1F38DDBA21AB1DBBB7)
-- engine: mysql
-- table:  payments

-- Contract view for [payments]
-- Includes "details" JSON; mask in your app if needed.
CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_payments AS
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
