-- Basic checks after loading marketops_databricks_orders.csv.
SELECT count(*) AS product_lines, count(DISTINCT purchase_order) AS orders
FROM main.marketops.orders_live;

-- Orders already inside the distribution center but not yet billed or delivered.
SELECT purchase_order, customer_name, destination, entry_cd_date, billing_date, delivery_client_date
FROM main.marketops.orders_live
WHERE entry_cd_date IS NOT NULL
  AND billing_date IS NULL
  AND delivery_client_date IS NULL
  AND lower(coalesce(status, '')) NOT LIKE '%cancel%'
ORDER BY entry_cd_date DESC;

-- The system's "Em trânsito" filter is invoice-driven.
SELECT purchase_order, invoice, shipment_status, destination
FROM main.marketops.orders_live
WHERE invoice IS NOT NULL
  AND trim(invoice) <> ''
  AND delivery_client_date IS NULL
  AND lower(coalesce(status, '')) NOT LIKE '%cancel%';
