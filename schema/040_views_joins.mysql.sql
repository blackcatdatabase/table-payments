-- Auto-generated from core\joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   payments_anomalies

CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_payments_anomalies AS
SELECT
  p.*
FROM payments p
WHERE
  (status IN ('paid','authorized') AND amount < 0)
  OR (status = 'paid' AND (transaction_id IS NULL OR transaction_id = ''))
  OR (status = 'failed' AND amount > 0);

-- Auto-generated from core\joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   payments_recent_failures

CREATE OR REPLACE ALGORITHM=MERGE SQL SECURITY INVOKER VIEW vw_payments_recent_failures AS
SELECT
  p.*,
  TIMESTAMPDIFF(SECOND, p.created_at, NOW()) AS age_sec
FROM payments p
WHERE p.status = 'failed'
  AND p.created_at > NOW() - INTERVAL 24 HOUR;


-- Auto-generated from core\joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   payments_status_summary

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_payments_status_summary AS
SELECT
  gateway,
  status,
  COUNT(*) AS total,
  SUM(CASE WHEN status IN ('authorized','paid','partially_refunded','refunded') THEN amount ELSE 0 END) AS sum_amount
FROM payments
GROUP BY gateway, status;


-- Auto-generated from core\joins-mysql.yaml (map@sha1:DA70105A5B799F72A56FEAB71A5171F946A770D2)
-- engine: mysql
-- view:   payments_with_logs

CREATE OR REPLACE ALGORITHM=TEMPTABLE SQL SECURITY INVOKER VIEW vw_payments_with_logs AS
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

