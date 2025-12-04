-- Auto-generated from joins-postgres.yaml (map@85230ed)
-- engine: postgres
-- view:   payments_anomalies

-- Potential anomalies in payments
CREATE OR REPLACE VIEW vw_payments_anomalies AS
SELECT
  p.*
FROM payments p
WHERE
  (status IN ($$paid$$,$$authorized$$) AND amount < 0)
  OR (status = $$paid$$ AND (transaction_id IS NULL OR transaction_id = ''))
  OR (status = $$failed$$ AND amount > 0);

-- Auto-generated from joins-postgres.yaml (map@85230ed)
-- engine: postgres
-- view:   payments_recent_failures

-- Recent failed payments (24h)
CREATE OR REPLACE VIEW vw_payments_recent_failures AS
SELECT
  p.*,
  EXTRACT(EPOCH FROM (now() - p.created_at)) AS age_sec
FROM payments p
WHERE p.status = $$failed$$
  AND p.created_at > now() - interval $$24 hours$$
ORDER BY p.created_at DESC;


-- Auto-generated from joins-postgres.yaml (map@85230ed)
-- engine: postgres
-- view:   payments_status_summary

-- Payment status summary by gateway
CREATE OR REPLACE VIEW vw_payments_status_summary AS
SELECT
  gateway,
  status,
  COUNT(*) AS total,
  SUM(CASE WHEN status IN ($$authorized$$,$$paid$$,$$partially_refunded$$,$$refunded$$) THEN amount ELSE 0 END) AS sum_amount
FROM payments
GROUP BY gateway, status
ORDER BY gateway, status;


-- Auto-generated from joins-postgres.yaml (map@85230ed)
-- engine: postgres
-- view:   payments_with_logs

-- Payments with last log entry and log count
CREATE OR REPLACE VIEW vw_payments_with_logs AS
WITH ranked_logs AS (
  SELECT
    pl.*,
    ROW_NUMBER() OVER (PARTITION BY pl.payment_id ORDER BY pl.log_at DESC, pl.id DESC) AS rn
  FROM payment_logs pl
)
SELECT
  p.*,
  rl.message   AS last_log_message,
  rl.log_at    AS last_log_at,
  (SELECT COUNT(*) FROM payment_logs x WHERE x.payment_id = p.id) AS logs_count
FROM payments p
LEFT JOIN ranked_logs rl ON rl.payment_id = p.id AND rl.rn = 1;

