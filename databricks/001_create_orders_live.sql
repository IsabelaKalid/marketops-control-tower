-- Optional schema-first setup for the MarketOps Delta table.
-- If you create the table using Databricks "Add or upload data", use the same column names/types.

-- Troque `main` abaixo se a empresa usar outro catálogo do Unity Catalog.
CREATE SCHEMA IF NOT EXISTS main.marketops;

CREATE TABLE IF NOT EXISTS main.marketops.orders_live (
  date_order DATE,
  sku STRING,
  product_name STRING,
  asin STRING,
  marketplace STRING,
  seller_country STRING,
  customer_order_id STRING,
  purchase_order STRING,
  quantity BIGINT,
  vkp2_price DECIMAL(18,2),
  seller_total_usd DECIMAL(18,2),
  status STRING,
  customer_name STRING,
  customer_email STRING,
  customer_phone STRING,
  invoice STRING,
  magaya_wr STRING,
  carrier STRING,
  tracking_number STRING,
  marketplace_purchase_confirmed BOOLEAN,
  marketplace_purchase_confirmed_at TIMESTAMP,
  shipment_status STRING,
  estimated_delivery DATE,
  actual_delivery_date DATE,
  wr_date DATE,
  eta DATE,
  di_date DATE,
  entry_cd_date DATE,
  delivery_client_date DATE,
  origin_hub STRING,
  destination STRING,
  databricks_sync_time TIMESTAMP,
  cancellation_reason STRING,
  cancellation_updated_at TIMESTAMP,
  events_text STRING,
  customer_cpf STRING,
  etd DATE,
  billing_date DATE
)
USING DELTA
TBLPROPERTIES (delta.enableChangeDataFeed = true);
