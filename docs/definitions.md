# payments

Payment attempts and final captures for orders.

## Columns
| Column | Type | Null | Default | Description | Crypto |
| --- | --- | --- | --- | --- | --- |
| id | BIGINT | NO |  | Surrogate primary key. |  |
| tenant_id | BIGINT | NO |  | Owning tenant (FK tenants.id). |  |
| order_id | BIGINT | YES |  | Order (FK orders.id). |  |
| gateway | VARCHAR(100) | NO |  | Payment gateway key (e.g., stripe, gopay). |  |
| transaction_id | VARCHAR(255) | YES |  | Provider transaction id (unique if provided). |  |
| provider_event_id | VARCHAR(255) | YES |  | Provider event id (optional). |  |
| status | mysql: ENUM('initiated','pending','authorized','paid','cancelled','partially_refunded','refunded','failed') / postgres: TEXT | NO |  | Payment state. (enum: initiated, pending, authorized, paid, cancelled, partially_refunded, refunded, failed) |  |
| amount | mysql: DECIMAL(12,2) / postgres: NUMERIC(12,2) | NO |  | Payment amount. Must be >= 0. |  |
| currency | CHAR(3) | NO |  | ISO 4217 currency code. |  |
| details | mysql: JSON / postgres: JSONB | YES |  | JSON with provider details/receipts. |  |
| created_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |  |
| updated_at | mysql: DATETIME(6) / postgres: TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Update timestamp (UTC). |  |
| version | mysql: INT / postgres: INTEGER | NO | 0 | Optimistic locking version counter. |  |

## Engine Details

### mysql

Unique keys:
| Name | Columns |
| --- | --- |
| ux_payments_tenant_id | tenant_id, id |
| ux_payments_tenant_tx | tenant_id, transaction_id |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| idx_payments_created_at | created_at | CREATE INDEX idx_payments_created_at ON payments (created_at) |
| idx_payments_order | order_id | INDEX idx_payments_order (order_id) |
| idx_payments_order_created | order_id,created_at | CREATE INDEX idx_payments_order_created ON payments (order_id, created_at) |
| idx_payments_provider_event | provider_event_id | INDEX idx_payments_provider_event (provider_event_id) |
| idx_payments_tenant | tenant_id | INDEX idx_payments_tenant (tenant_id) |
| idx_payments_tenant_order | tenant_id,order_id | INDEX idx_payments_tenant_order (tenant_id, order_id) |
| ux_payments_tenant_id | tenant_id,id | UNIQUE KEY ux_payments_tenant_id (tenant_id, id) |
| ux_payments_tenant_tx | tenant_id,transaction_id | UNIQUE KEY ux_payments_tenant_tx (tenant_id, transaction_id) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_payments_order | tenant_id,order_id | orders(tenant_id,id) | ON DELETE CASCADE |
| fk_payments_tenant | tenant_id | tenants(id) | ON DELETE RESTRICT |

### postgres

Unique keys:
| Name | Columns |
| --- | --- |
| ux_payments_tenant_id | tenant_id, id |
| ux_payments_tenant_tx | tenant_id, transaction_id |

Indexes:
| Name | Columns | SQL |
| --- | --- | --- |
| gin_payments_details | detailsjsonb_path_ops | CREATE INDEX IF NOT EXISTS gin_payments_details     ON payments      USING GIN (details jsonb_path_ops) |
| idx_payments_created_at | created_at | CREATE INDEX IF NOT EXISTS idx_payments_created_at ON payments (created_at) |
| idx_payments_order | order_id | CREATE INDEX IF NOT EXISTS idx_payments_order ON payments (order_id) |
| idx_payments_order_created | order_id,created_at | CREATE INDEX IF NOT EXISTS idx_payments_order_created ON payments (order_id, created_at) |
| idx_payments_provider_event | provider_event_id | CREATE INDEX IF NOT EXISTS idx_payments_provider_event ON payments (provider_event_id) |
| idx_payments_tenant | tenant_id | CREATE INDEX IF NOT EXISTS idx_payments_tenant ON payments (tenant_id) |
| idx_payments_tenant_order | tenant_id,order_id | CREATE INDEX IF NOT EXISTS idx_payments_tenant_order ON payments (tenant_id, order_id) |
| ux_payments_tenant_id | tenant_id,id | CREATE UNIQUE INDEX IF NOT EXISTS ux_payments_tenant_id ON payments (tenant_id, id) |
| ux_payments_tenant_tx | tenant_id,transaction_id | CREATE UNIQUE INDEX IF NOT EXISTS ux_payments_tenant_tx ON payments (tenant_id, transaction_id) |

Foreign keys:
| Name | Columns | References | Actions |
| --- | --- | --- | --- |
| fk_payments_order | tenant_id,order_id | orders(tenant_id,id) | ON DELETE CASCADE |
| fk_payments_tenant | tenant_id | tenants(id) | ON DELETE RESTRICT |

## Engine differences

## Views
| View | Engine | Flags | File |
| --- | --- | --- | --- |
| vw_payments | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views.mysql.sql](../schema/040_views.mysql.sql) |
| vw_payments_anomalies | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_payments_recent_failures | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_payments_status_summary | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_payments_with_logs | mysql | algorithm=MERGE, security=INVOKER | [../schema/040_views_joins.mysql.sql](../schema/040_views_joins.mysql.sql) |
| vw_payments | postgres |  | [../schema/040_views.postgres.sql](../schema/040_views.postgres.sql) |
| vw_payments_anomalies | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
| vw_payments_recent_failures | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
| vw_payments_status_summary | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
| vw_payments_with_logs | postgres |  | [../schema/040_views_joins.postgres.sql](../schema/040_views_joins.postgres.sql) |
