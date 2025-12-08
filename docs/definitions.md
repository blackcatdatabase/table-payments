# payments

Payment attempts and final captures for orders.

## Columns
| Column | Type | Null | Default | Description |
| --- | --- | --- | --- | --- |
| amount | NUMERIC(12,2) | NO |  | Payment amount. Must be >= 0. |
| created_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Creation timestamp (UTC). |
| currency | CHAR(3) | NO |  | ISO 4217 currency code. |
| details | JSONB | YES |  | JSON with provider details/receipts. |
| gateway | VARCHAR(100) | NO |  | Payment gateway key (e.g., stripe, gopay). |
| id | BIGINT | NO |  | Surrogate primary key. |
| order_id | BIGINT | YES |  | Order (FK orders.id). |
| provider_event_id | VARCHAR(255) | YES |  | Provider event id (optional). |
| status | TEXT | NO |  | Payment state. (enum: initiated, pending, authorized, paid, cancelled, partially_refunded, refunded, failed) |
| transaction_id | VARCHAR(255) | YES |  | Provider transaction id (unique if provided). |
| updated_at | TIMESTAMPTZ(6) | NO | CURRENT_TIMESTAMP(6) | Update timestamp (UTC). |

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
| vw_payments | mysql | algorithm=MERGE, security=INVOKER | [packages\payments\schema\040_views.mysql.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views.mysql.sql) |
| vw_payments_anomalies | mysql | algorithm=MERGE, security=INVOKER | [packages\payments\schema\040_views_joins.mysql.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views_joins.mysql.sql) |
| vw_payments_recent_failures | mysql | algorithm=MERGE, security=INVOKER | [packages\payments\schema\040_views_joins.mysql.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views_joins.mysql.sql) |
| vw_payments_status_summary | mysql | algorithm=MERGE, security=INVOKER | [packages\payments\schema\040_views_joins.mysql.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views_joins.mysql.sql) |
| vw_payments_with_logs | mysql | algorithm=MERGE, security=INVOKER | [packages\payments\schema\040_views_joins.mysql.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views_joins.mysql.sql) |
| vw_payments | postgres |  | [packages\payments\schema\040_views.postgres.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views.postgres.sql) |
| vw_payments_anomalies | postgres |  | [packages\payments\schema\040_views_joins.postgres.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views_joins.postgres.sql) |
| vw_payments_recent_failures | postgres |  | [packages\payments\schema\040_views_joins.postgres.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views_joins.postgres.sql) |
| vw_payments_status_summary | postgres |  | [packages\payments\schema\040_views_joins.postgres.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views_joins.postgres.sql) |
| vw_payments_with_logs | postgres |  | [packages\payments\schema\040_views_joins.postgres.sql](https://github.com/blackcatacademy/blackcat-database/packages/payments/schema/040_views_joins.postgres.sql) |
