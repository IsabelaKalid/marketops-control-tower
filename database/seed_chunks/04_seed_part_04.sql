-- Demo seed part 04 of 10. Run files in numeric order.
begin;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-05'::date, '113-1001295-2001550', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-02-15'::date, 'Global Parcel Demo', 'DEMO00003601', '2026-02-08'::date, 'RCPT-073050', '2026-02-15'::date, '2026-02-11'::date, 'NX-041050-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80035' and oi.sequential = '10' and oi.material = '223-082'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6b53b5b2-7677-4075-b8ad-e527c09383f2'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-02-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80035' and oi.sequential = '10' and oi.material = '223-082'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '623861ef-3d08-4a11-b0b3-fff18a03c97b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80035' and oi.sequential = '10' and oi.material = '223-082'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '59577853-2697-4157-889b-7920a05a5c3e'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80035' and oi.sequential = '10' and oi.material = '223-082'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-099', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000052', 'SUP-540561', 'B0SXZKSY4S', 2, 'EA', 253.99, 27.37, 54.74
from public.orders where purchase_order = 'AKDN-80036'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Open', 'Marina Torres',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80036' and oi.sequential = '10' and oi.material = '223-099'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-116', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000053', 'SUP-540572', 'B0TWMTABHZ', 1, 'EA', 132.04, 27.74, 27.74
from public.orders where purchase_order = 'AKDN-80037'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-06'::date, '113-1001369-2001612', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80037' and oi.sequential = '10' and oi.material = '223-116'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-133', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000054', 'SUP-540583', 'B0UW92SNW7', 1, 'EA', 137.18, 28.11, 28.11
from public.orders where purchase_order = 'AKDN-80038'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-08'::date, '113-1001406-2001643', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80038' and oi.sequential = '10' and oi.material = '223-133'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-150', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000055', 'SUP-540594', 'B0VVVABZBE', 2, 'EA', 284.8, 28.48, 56.96
from public.orders where purchase_order = 'AKDN-80039'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-07'::date, '113-1001443-2001674', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80039' and oi.sequential = '10' and oi.material = '223-150'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-167', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000056', 'SUP-540605', 'B0WUJJTDQM', 1, 'EA', 147.71, 28.85, 28.85
from public.orders where purchase_order = 'AKDN-80040'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Marina Torres',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80040' and oi.sequential = '10' and oi.material = '223-167'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-184', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000057', 'SUP-540616', 'B0XU6RBQ5U', 1, 'EA', 128.57, 29.22, 29.22
from public.orders where purchase_order = 'AKDN-80041'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Caio Nunes',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80041' and oi.sequential = '10' and oi.material = '223-184'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-201', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000058', 'SUP-540627', 'B0ZTSZT3J3', 2, 'EA', 267.49, 29.59, 59.18
from public.orders where purchase_order = 'AKDN-80042'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Renata Alves',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80042' and oi.sequential = '10' and oi.material = '223-201'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-218', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000059', 'SUP-540638', 'B02SE9CEYA', 1, 'EA', 139.01, 29.96, 29.96
from public.orders where purchase_order = 'AKDN-80043'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-11'::date, '113-1001591-2001798', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-02-25'::date, 'FedEx Demo', 'DEMO00004401', '2026-02-16'::date, 'RCPT-073058', '2026-02-25'::date, '2026-02-18'::date, 'NX-041058-26',
  '2026-02-27'::date, '2026-03-01'::date, '2026-03-05'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80043' and oi.sequential = '10' and oi.material = '223-218'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd115bec6-591a-4e2b-ab3d-5e0d27d35deb'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80043' and oi.sequential = '10' and oi.material = '223-218'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '426b9e95-031a-44c5-be5e-6b1655b01b74'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80043' and oi.sequential = '10' and oi.material = '223-218'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '96d690a8-5d6c-4086-9a90-d549d1384b20'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-02-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80043' and oi.sequential = '10' and oi.material = '223-218'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9a3b4a35-6fa2-41fe-b759-3162850258be'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80043' and oi.sequential = '10' and oi.material = '223-218'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2f9ebd83-aca2-40c8-867b-d2eea937b3cf'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80043' and oi.sequential = '10' and oi.material = '223-218'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-235', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000060', 'SUP-540649', 'B03S2GURDG', 1, 'EA', 144.37, 30.33, 30.33
from public.orders where purchase_order = 'AKDN-80044'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-13'::date, '113-1001628-2001829', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-03-01'::date, 'Global Parcel Demo', 'DEMO00004501', '2026-02-18'::date, 'RCPT-073059', '2026-03-01'::date, '2026-02-21'::date, 'NX-041059-26',
  '2026-03-04'::date, '2026-03-05'::date, '2026-03-06'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80044' and oi.sequential = '10' and oi.material = '223-235'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd06e3e91-3d8c-40b3-843e-11176881520e'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80044' and oi.sequential = '10' and oi.material = '223-235'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0502277a-a458-413a-9066-260539238b71'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80044' and oi.sequential = '10' and oi.material = '223-235'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7d649b58-5696-49b5-8547-f75b3e9487ba'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80044' and oi.sequential = '10' and oi.material = '223-235'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b77350e1-0d40-4986-a5d5-87f45ef5689f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80044' and oi.sequential = '10' and oi.material = '223-235'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '88dc214f-f8b2-49be-b38a-f4e4442aa7b2'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80044' and oi.sequential = '10' and oi.material = '223-235'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-252', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000061', 'SUP-540660', 'B04RNQC4SP', 2, 'EA', 299.63, 30.7, 61.4
from public.orders where purchase_order = 'AKDN-80045'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-12'::date, '113-1001665-2001860', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-02-25'::date, 'UPS Demo', 'DEMO00004601', '2026-02-20'::date, 'RCPT-073060', '2026-02-25'::date, '2026-02-21'::date, 'NX-041060-26',
  '2026-02-26'::date, '2026-02-28'::date, '2026-03-02'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80045' and oi.sequential = '10' and oi.material = '223-252'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ccfc6c4d-0ab6-41a9-95ab-f3f18e87cd34'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80045' and oi.sequential = '10' and oi.material = '223-252'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5ee09322-b7ac-449e-8df4-3e922e8aaa1b'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-02-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80045' and oi.sequential = '10' and oi.material = '223-252'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5c3f3bed-27a8-4dfb-a74a-b6cbb60283d0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-02-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80045' and oi.sequential = '10' and oi.material = '223-252'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c13e7a32-b164-4ff7-8c10-e341a7456fca'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80045' and oi.sequential = '10' and oi.material = '223-252'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '769cb3c6-63d9-48db-a646-23304632c101'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80045' and oi.sequential = '10' and oi.material = '223-252'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-269', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000062', 'SUP-540671', 'B05RAYUF7W', 1, 'EA', 155.35, 31.07, 31.07
from public.orders where purchase_order = 'AKDN-80046'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-14'::date, '113-1001702-2001891', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-03-01'::date, 'FedEx Demo', 'DEMO00004701', '2026-02-22'::date, 'RCPT-073061', '2026-03-01'::date, '2026-02-24'::date, 'NX-041061-26',
  '2026-03-03'::date, '2026-03-04'::date, '2026-03-07'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80046' and oi.sequential = '10' and oi.material = '223-269'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0206678d-d881-4ecc-a32b-f9ccf1952708'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80046' and oi.sequential = '10' and oi.material = '223-269'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'acb0ea51-9493-4d73-8d77-908158688175'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80046' and oi.sequential = '10' and oi.material = '223-269'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '84b25570-01a6-4918-b454-0663d926e500'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80046' and oi.sequential = '10' and oi.material = '223-269'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9cab3d38-9795-487f-80cb-c2aa9a81e33a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80046' and oi.sequential = '10' and oi.material = '223-269'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f818a2a9-19da-4cc7-8b1a-b17b2712d79c'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80046' and oi.sequential = '10' and oi.material = '223-269'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-286', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000063', 'SUP-540682', 'B07QW7DTL5', 1, 'EA', 160.97, 31.44, 31.44
from public.orders where purchase_order = 'AKDN-80047'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-15'::date, '113-1001739-2001922', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-03-04'::date, 'Global Parcel Demo', 'DEMO00004801', '2026-02-23'::date, 'RCPT-073062', '2026-03-04'::date, '2026-02-26'::date, 'NX-041062-26',
  '2026-03-07'::date, '2026-03-09'::date, '2026-03-13'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80047' and oi.sequential = '10' and oi.material = '223-286'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fcb16494-14c2-4079-acf2-cbe192736f4f'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80047' and oi.sequential = '10' and oi.material = '223-286'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e98ac5b8-525f-468b-b634-728e408ca259'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80047' and oi.sequential = '10' and oi.material = '223-286'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b455855f-334a-40b9-91a8-aef34406dcc5'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80047' and oi.sequential = '10' and oi.material = '223-286'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0f7ce44f-3c63-46c6-b84d-fbfac2253591'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80047' and oi.sequential = '10' and oi.material = '223-286'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '53eaced7-1ff3-4766-bfdc-d32cb81b8ff8'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80047' and oi.sequential = '10' and oi.material = '223-286'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-303', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000064', 'SUP-540693', 'B08PJFV6ZC', 2, 'EA', 279.93, 31.81, 63.62
from public.orders where purchase_order = 'AKDN-80048'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-14'::date, '113-1001776-2001953', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-03-05'::date, 'UPS Demo', 'DEMO00004901', '2026-02-25'::date, 'RCPT-073063', '2026-03-05'::date, '2026-02-26'::date, 'NX-041063-26',
  '2026-03-06'::date, '2026-03-07'::date, '2026-03-08'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80048' and oi.sequential = '10' and oi.material = '223-303'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f8347ae2-dc4e-4345-9d06-51f9cd5a0324'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80048' and oi.sequential = '10' and oi.material = '223-303'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e72491ff-04d6-478b-8d18-27cf48ee3e8d'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80048' and oi.sequential = '10' and oi.material = '223-303'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e4b9b69b-7200-44ea-b73e-a6619908078a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80048' and oi.sequential = '10' and oi.material = '223-303'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'afa6e093-69d0-4326-8a81-858ed29f6ab7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80048' and oi.sequential = '10' and oi.material = '223-303'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd2641235-bc61-42db-8144-3f86af38b1ed'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80048' and oi.sequential = '10' and oi.material = '223-303'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-320', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000065', 'SUP-540704', 'B09P7PDHEK', 1, 'EA', 145.45, 32.18, 32.18
from public.orders where purchase_order = 'AKDN-80049'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-16'::date, '113-1001813-2001984', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-03-02'::date, 'FedEx Demo', 'DEMO00005001', '2026-02-20'::date, 'RCPT-073064', '2026-03-02'::date, '2026-02-22'::date, 'NX-041064-26',
  '2026-03-04'::date, '2026-03-06'::date, '2026-03-08'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80049' and oi.sequential = '10' and oi.material = '223-320'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '347a93bd-150f-400e-9d98-e6d313a72c6f'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80049' and oi.sequential = '10' and oi.material = '223-320'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2ff8bcdc-8f88-4395-ae49-abe5aef6f32a'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80049' and oi.sequential = '10' and oi.material = '223-320'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7ac53609-8be2-4d16-9707-b587c6fb4b54'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80049' and oi.sequential = '10' and oi.material = '223-320'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '57c184e2-9808-46c2-8d43-4d74103ccefb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80049' and oi.sequential = '10' and oi.material = '223-320'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '969cde67-9be6-4669-bc58-4a1c01ee0fb5'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80049' and oi.sequential = '10' and oi.material = '223-320'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-337', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000066', 'SUP-540715', 'B0ANTWVUTR', 1, 'EA', 151.03, 32.55, 32.55
from public.orders where purchase_order = 'AKDN-80050'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-18'::date, '113-1001850-2002015', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-03-01'::date, 'Global Parcel Demo', 'DEMO00005101', '2026-02-22'::date, 'RCPT-073065', '2026-03-01'::date, '2026-02-25'::date, 'NX-041065-26',
  '2026-03-04'::date, '2026-03-05'::date, '2026-03-08'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80050' and oi.sequential = '10' and oi.material = '223-337'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd1d2ebe9-2bf9-4e96-ba7e-5e048b0d1d89'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80050' and oi.sequential = '10' and oi.material = '223-337'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6292ac7d-02b7-4c50-bb9c-9896b857074c'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80050' and oi.sequential = '10' and oi.material = '223-337'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dbb1c37f-40d5-4d05-bcec-883313afc87b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80050' and oi.sequential = '10' and oi.material = '223-337'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dc0098e8-dcb2-45b5-87ae-16b855163366'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80050' and oi.sequential = '10' and oi.material = '223-337'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5413f650-099d-4e05-af25-ab687560bbc9'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80050' and oi.sequential = '10' and oi.material = '223-337'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-354', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000067', 'SUP-540726', 'B0BMF6E78Y', 2, 'EA', 313.4, 32.92, 65.84
from public.orders where purchase_order = 'AKDN-80051'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-17'::date, '113-1001887-2002046', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-03-02'::date, 'UPS Demo', 'DEMO00005201', '2026-02-24'::date, 'RCPT-073066', '2026-03-02'::date, '2026-02-25'::date, 'NX-041066-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80051' and oi.sequential = '10' and oi.material = '223-354'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6c490666-2fb4-4b5f-a422-ab2e03ac7040'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80051' and oi.sequential = '10' and oi.material = '223-354'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f929b4ee-eff4-4caa-af57-748ea2afc9a2'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80051' and oi.sequential = '10' and oi.material = '223-354'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'aded8ca2-2ac1-4f13-8fa4-789bdd590779'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80051' and oi.sequential = '10' and oi.material = '223-354'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-371', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000068', 'SUP-540737', 'B0CM3EWJM7', 1, 'EA', 162.46, 33.29, 33.29
from public.orders where purchase_order = 'AKDN-80052'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-19'::date, '113-1001924-2002077', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-03-06'::date, 'FedEx Demo', 'DEMO00005301', '2026-02-26'::date, 'RCPT-073067', '2026-03-06'::date, '2026-02-28'::date, 'NX-041067-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80052' and oi.sequential = '10' and oi.material = '223-371'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4b123a72-03e1-4653-b457-3b18dfed970e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80052' and oi.sequential = '10' and oi.material = '223-371'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f6b255c5-4e15-4c14-8a3f-4ffbae4d8935'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-02-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80052' and oi.sequential = '10' and oi.material = '223-371'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b774229a-97ef-42bc-8b95-abfa75fdd4a2'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80052' and oi.sequential = '10' and oi.material = '223-371'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-388', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000069', 'SUP-540748', 'B0ELPMEW2E', 1, 'EA', 168.3, 33.66, 33.66
from public.orders where purchase_order = 'AKDN-80053'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-20'::date, '113-1001961-2002108', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-03-09'::date, 'Global Parcel Demo', 'DEMO00005401', '2026-02-27'::date, 'RCPT-073068', '2026-03-09'::date, '2026-03-02'::date, 'NX-041068-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80053' and oi.sequential = '10' and oi.material = '223-388'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '91603fe7-1e67-4bcd-9c09-564b9532df4e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80053' and oi.sequential = '10' and oi.material = '223-388'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6de18997-de89-479c-806b-373880779bd0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80053' and oi.sequential = '10' and oi.material = '223-388'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd6170b91-a58f-4266-900e-23ac275d2a4d'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-02-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80053' and oi.sequential = '10' and oi.material = '223-388'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-405', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000070', 'SUP-540759', 'B0FKBVW9GM', 2, 'EA', 348.47, 34.03, 68.06
from public.orders where purchase_order = 'AKDN-80054'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-19'::date, '113-1001998-2002139', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-03-10'::date, 'UPS Demo', 'DEMO00005501', '2026-03-01'::date, 'RCPT-073069', '2026-03-10'::date, '2026-03-02'::date, 'NX-041069-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80054' and oi.sequential = '10' and oi.material = '223-405'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c7811457-f76b-4fed-b080-c64b73e16386'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80054' and oi.sequential = '10' and oi.material = '223-405'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'efa2cf41-8b1e-40f6-80ae-27ca7225cc1c'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80054' and oi.sequential = '10' and oi.material = '223-405'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c2261d9d-29aa-48ae-8342-6af12634649d'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80054' and oi.sequential = '10' and oi.material = '223-405'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-422', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000071', 'SUP-540770', 'B0GKX5ELVU', 1, 'EA', 151.36, 34.4, 34.4
from public.orders where purchase_order = 'AKDN-80055'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-21'::date, '113-1002035-2002170', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-03-09'::date, 'FedEx Demo', 'DEMO00005601', '2026-03-03'::date, 'RCPT-073070', '2026-03-09'::date, '2026-03-05'::date, 'NX-041070-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80055' and oi.sequential = '10' and oi.material = '223-422'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1a7d6677-9b85-4d2b-b5e3-996a76ebcaf3'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80055' and oi.sequential = '10' and oi.material = '223-422'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'beb779da-de37-4ca7-9ba2-5cef1cbcbb8e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80055' and oi.sequential = '10' and oi.material = '223-422'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b3b19a24-d353-45cd-b446-1f5f9ce7528f'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80055' and oi.sequential = '10' and oi.material = '223-422'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-439', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000072', 'SUP-540781', 'B0HJKCXXA2', 1, 'EA', 157.16, 34.77, 34.77
from public.orders where purchase_order = 'AKDN-80056'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Open', 'Marina Torres',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80056' and oi.sequential = '10' and oi.material = '223-439'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-456', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000073', 'SUP-540792', 'B0JJ7LFAP9', 2, 'EA', 326.1, 35.14, 70.28
from public.orders where purchase_order = 'AKDN-80057'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-22'::date, '113-1002109-2002232', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80057' and oi.sequential = '10' and oi.material = '223-456'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-473', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000074', 'SUP-540803', 'B0LHUUXM4G', 1, 'EA', 169.03, 35.51, 35.51
from public.orders where purchase_order = 'AKDN-80058'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-24'::date, '113-1002146-2002263', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80058' and oi.sequential = '10' and oi.material = '223-473'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-490', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000075', 'SUP-540814', 'B0MGG3FYHP', 1, 'EA', 175.09, 35.88, 35.88
from public.orders where purchase_order = 'AKDN-80059'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-26'::date, '113-1002183-2002294', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80059' and oi.sequential = '10' and oi.material = '223-490'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-507', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000076', 'SUP-540825', 'B0NG4BYCWW', 2, 'EA', 362.5, 36.25, 72.5
from public.orders where purchase_order = 'AKDN-80060'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Marina Torres',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80060' and oi.sequential = '10' and oi.material = '223-507'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-524', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000077', 'SUP-540836', 'B0PFQKGPB5', 1, 'EA', 187.49, 36.62, 36.62
from public.orders where purchase_order = 'AKDN-80061'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Caio Nunes',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80061' and oi.sequential = '10' and oi.material = '223-524'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-541', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000078', 'SUP-540847', 'B0QECSY2QB', 1, 'EA', 162.76, 36.99, 36.99
from public.orders where purchase_order = 'AKDN-80062'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Cancelled', 'Renata Alves',
  'Cancelled', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80062' and oi.sequential = '10' and oi.material = '223-541'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-558', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000079', 'SUP-540858', 'B0REY2GD5J', 2, 'EA', 337.73, 37.36, 74.72
from public.orders where purchase_order = 'AKDN-80063'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-02-27'::date, '113-1002331-2002418', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-03-12'::date, 'UPS Demo', 'DEMO00006401', '2026-03-04'::date, 'RCPT-073078', '2026-03-12'::date, '2026-03-05'::date, 'NX-041078-26',
  '2026-03-13'::date, '2026-03-15'::date, '2026-03-19'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80063' and oi.sequential = '10' and oi.material = '223-558'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3e68ca1e-45ff-4e83-8f1c-eaa134275703'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80063' and oi.sequential = '10' and oi.material = '223-558'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '66d873cd-eafc-4b6e-97da-ed33bf330d8b'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80063' and oi.sequential = '10' and oi.material = '223-558'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c2fb6ee2-7d9f-474f-939a-a3f15a7f962f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80063' and oi.sequential = '10' and oi.material = '223-558'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b0d49708-50f6-48d9-9f6b-b50d189f162f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80063' and oi.sequential = '10' and oi.material = '223-558'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '580913b1-96a5-45a2-bbec-3458af1f3114'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80063' and oi.sequential = '10' and oi.material = '223-558'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-575', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000080', 'SUP-540869', 'B0TDLAZQJR', 1, 'EA', 175.07, 37.73, 37.73
from public.orders where purchase_order = 'AKDN-80064'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-01'::date, '113-1002368-2002449', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-03-16'::date, 'FedEx Demo', 'DEMO00006501', '2026-03-06'::date, 'RCPT-073079', '2026-03-16'::date, '2026-03-08'::date, 'NX-041079-26',
  '2026-03-18'::date, '2026-03-19'::date, '2026-03-20'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80064' and oi.sequential = '10' and oi.material = '223-575'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fb3727c6-9f18-46f0-ba3b-e211e395e638'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80064' and oi.sequential = '10' and oi.material = '223-575'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '61ee3bbc-7eb2-4e3e-b95c-d485a2c6a706'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80064' and oi.sequential = '10' and oi.material = '223-575'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '43d657ed-bc2a-45c3-848e-81e7f4dc9cc8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80064' and oi.sequential = '10' and oi.material = '223-575'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9405ddf3-eae3-4897-bf01-6229ec80fec9'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80064' and oi.sequential = '10' and oi.material = '223-575'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2c30092c-9227-44c5-993a-26060ccbf3e5'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80064' and oi.sequential = '10' and oi.material = '223-575'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-592', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000081', 'SUP-540880', 'B0UD8HH3YY', 1, 'EA', 181.36, 38.1, 38.1
from public.orders where purchase_order = 'AKDN-80065'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-03'::date, '113-1002405-2002480', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-03-15'::date, 'Global Parcel Demo', 'DEMO00006601', '2026-03-08'::date, 'RCPT-073080', '2026-03-15'::date, '2026-03-11'::date, 'NX-041080-26',
  '2026-03-18'::date, '2026-03-20'::date, '2026-03-22'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80065' and oi.sequential = '10' and oi.material = '223-592'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9922a14c-19d6-49c8-b729-4d628fdb9b85'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80065' and oi.sequential = '10' and oi.material = '223-592'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '513fb95a-5dba-4a57-ad15-4292660e1263'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80065' and oi.sequential = '10' and oi.material = '223-592'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c12cb0eb-3f8d-4b27-9459-c5edaa82611f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80065' and oi.sequential = '10' and oi.material = '223-592'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0a2b71af-0746-4e1f-9ff6-b8f1217f5779'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80065' and oi.sequential = '10' and oi.material = '223-592'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a7570a98-61f2-45f3-8b98-38c8fc52ff07'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80065' and oi.sequential = '10' and oi.material = '223-592'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-609', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000082', 'SUP-540891', 'B0VCURZFD7', 2, 'EA', 375.47, 38.47, 76.94
from public.orders where purchase_order = 'AKDN-80066'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-02'::date, '113-1002442-2002511', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-03-16'::date, 'UPS Demo', 'DEMO00006701', '2026-03-10'::date, 'RCPT-073081', '2026-03-16'::date, '2026-03-11'::date, 'NX-041081-26',
  '2026-03-17'::date, '2026-03-18'::date, '2026-03-21'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80066' and oi.sequential = '10' and oi.material = '223-609'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5db26de7-47c7-4319-be71-9d517f6dac5f'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80066' and oi.sequential = '10' and oi.material = '223-609'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '061b6064-c174-40b8-9e9c-9c05d2b84143'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80066' and oi.sequential = '10' and oi.material = '223-609'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8d8d0922-49f1-4104-a6af-3b08a344998b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80066' and oi.sequential = '10' and oi.material = '223-609'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c3f3f36c-8a24-428a-9c18-1c5ef25ca132'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80066' and oi.sequential = '10' and oi.material = '223-609'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a28d661c-968c-42ce-8fd7-71d8376bc383'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80066' and oi.sequential = '10' and oi.material = '223-609'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-626', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000083', 'SUP-540902', 'B0WBHZHSSE', 1, 'EA', 194.2, 38.84, 38.84
from public.orders where purchase_order = 'AKDN-80067'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-03'::date, '113-1002479-2002542', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-03-19'::date, 'FedEx Demo', 'DEMO00006801', '2026-03-11'::date, 'RCPT-073082', '2026-03-19'::date, '2026-03-13'::date, 'NX-041082-26',
  '2026-03-21'::date, '2026-03-23'::date, '2026-03-27'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80067' and oi.sequential = '10' and oi.material = '223-626'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f116c540-534e-4c88-bf0d-e0ff21aaca51'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80067' and oi.sequential = '10' and oi.material = '223-626'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5e205f3f-7e4a-49dc-94f5-ad605bf69ca7'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80067' and oi.sequential = '10' and oi.material = '223-626'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '91403100-1717-4734-ad19-573692c6db45'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80067' and oi.sequential = '10' and oi.material = '223-626'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7a085db5-9568-4548-ab54-c84e884b41aa'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80067' and oi.sequential = '10' and oi.material = '223-626'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c95ea896-dc7c-406d-ae32-7d2e49bfd6e1'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80067' and oi.sequential = '10' and oi.material = '223-626'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-643', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000084', 'SUP-540913', 'B0XB58257L', 1, 'EA', 200.76, 39.21, 39.21
from public.orders where purchase_order = 'AKDN-80068'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-05'::date, '113-1002516-2002573', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-03-23'::date, 'Global Parcel Demo', 'DEMO00006901', '2026-03-13'::date, 'RCPT-073083', '2026-03-23'::date, '2026-03-16'::date, 'NX-041083-26',
  '2026-03-26'::date, '2026-03-27'::date, '2026-03-28'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80068' and oi.sequential = '10' and oi.material = '223-643'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fd8f0a5e-c245-4e7f-8a12-ba3adf612a18'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80068' and oi.sequential = '10' and oi.material = '223-643'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fa8026d4-c0b5-441a-9fed-5960fbae1b68'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80068' and oi.sequential = '10' and oi.material = '223-643'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b81a8a48-aeca-4b64-b6d4-a0b0cfc8441a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80068' and oi.sequential = '10' and oi.material = '223-643'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a9285dc0-4242-4f77-acb8-1c5f53251f41'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80068' and oi.sequential = '10' and oi.material = '223-643'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5b6b9eab-a847-4f39-a020-e2304b04c63b'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80068' and oi.sequential = '10' and oi.material = '223-643'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-660', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000085', 'SUP-540924', 'B0YARGJGLT', 2, 'EA', 348.3, 39.58, 79.16
from public.orders where purchase_order = 'AKDN-80069'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-04'::date, '113-1002553-2002604', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-03-24'::date, 'UPS Demo', 'DEMO00007001', '2026-03-15'::date, 'RCPT-073084', '2026-03-24'::date, '2026-03-16'::date, 'NX-041084-26',
  '2026-03-25'::date, '2026-03-27'::date, '2026-03-29'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80069' and oi.sequential = '10' and oi.material = '223-660'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7961cfbd-b473-4a61-aed6-42cc02e144f9'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80069' and oi.sequential = '10' and oi.material = '223-660'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ed8bfb4f-8378-4c88-83c5-b8f7d06aa2f2'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80069' and oi.sequential = '10' and oi.material = '223-660'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd3e018fd-8054-4fb0-b804-cb2ac5e8f651'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80069' and oi.sequential = '10' and oi.material = '223-660'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9fe44ea7-f0d2-480e-917f-c32788fa9c39'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80069' and oi.sequential = '10' and oi.material = '223-660'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '471442c5-d1b5-43e7-bd20-959330f02524'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80069' and oi.sequential = '10' and oi.material = '223-660'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-677', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000086', 'SUP-540935', 'B029DQ2TZ2', 1, 'EA', 180.57, 39.95, 39.95
from public.orders where purchase_order = 'AKDN-80070'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-06'::date, '113-1002590-2002635', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-03-16'::date, 'FedEx Demo', 'DEMO00007101', '2026-03-10'::date, 'RCPT-073085', '2026-03-16'::date, '2026-03-12'::date, 'NX-041085-26',
  '2026-03-18'::date, '2026-03-19'::date, '2026-03-22'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80070' and oi.sequential = '10' and oi.material = '223-677'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b6045f47-6140-407c-b07a-694ae3230159'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-03-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80070' and oi.sequential = '10' and oi.material = '223-677'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b6f52f2f-b6eb-4cbe-802e-6148e3c400af'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-03-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80070' and oi.sequential = '10' and oi.material = '223-677'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2d629dff-8396-4e71-bb82-eebe1a971b87'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80070' and oi.sequential = '10' and oi.material = '223-677'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '90fdb19c-95ea-4f95-b6ea-30b7fffc755b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80070' and oi.sequential = '10' and oi.material = '223-677'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3b924abc-401c-405d-b07d-85f8c08c8de2'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80070' and oi.sequential = '10' and oi.material = '223-677'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-694', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000087', 'SUP-540946', 'B039ZXJ6E9', 1, 'EA', 187.08, 40.32, 40.32
from public.orders where purchase_order = 'AKDN-80071'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-08'::date, '113-1002627-2002666', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-03-20'::date, 'Global Parcel Demo', 'DEMO00007201', '2026-03-12'::date, 'RCPT-073086', '2026-03-20'::date, '2026-03-15'::date, 'NX-041086-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80071' and oi.sequential = '10' and oi.material = '223-694'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'cbdda1c8-c482-4d6c-b4e5-0b7075498d44'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80071' and oi.sequential = '10' and oi.material = '223-694'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e0aca14f-dd3d-46cb-8618-013f2464c7e8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80071' and oi.sequential = '10' and oi.material = '223-694'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '433b5508-f46e-4c2a-98c6-2bf4875c180b'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80071' and oi.sequential = '10' and oi.material = '223-694'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-711', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000088', 'SUP-540957', 'B048M73HTG', 2, 'EA', 387.37, 40.69, 81.38
from public.orders where purchase_order = 'AKDN-80072'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-07'::date, '113-1002664-2002697', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-03-21'::date, 'UPS Demo', 'DEMO00007301', '2026-03-14'::date, 'RCPT-073087', '2026-03-21'::date, '2026-03-15'::date, 'NX-041087-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80072' and oi.sequential = '10' and oi.material = '223-711'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '28c99e9a-d56b-40db-b017-3762da7f36e5'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80072' and oi.sequential = '10' and oi.material = '223-711'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '923428a9-83f7-43ce-84e6-d8c351570e8e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80072' and oi.sequential = '10' and oi.material = '223-711'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '614d114c-06ee-44d7-84f7-c39dc58b645c'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80072' and oi.sequential = '10' and oi.material = '223-711'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-728', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000089', 'SUP-540968', 'B0589FKV8N', 1, 'EA', 200.37, 41.06, 41.06
from public.orders where purchase_order = 'AKDN-80073'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-08'::date, '113-1002701-2002728', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-03-24'::date, 'FedEx Demo', 'DEMO00007401', '2026-03-15'::date, 'RCPT-073088', '2026-03-24'::date, '2026-03-17'::date, 'NX-041088-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80073' and oi.sequential = '10' and oi.material = '223-728'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8856f484-e3d0-42fb-8cc2-cd2f41187402'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80073' and oi.sequential = '10' and oi.material = '223-728'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3452d49f-b79e-464e-a9b3-49f644b58582'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80073' and oi.sequential = '10' and oi.material = '223-728'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'cb74fc9f-ff28-4235-b1fe-692a016afc16'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80073' and oi.sequential = '10' and oi.material = '223-728'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-745', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000090', 'SUP-540979', 'B067VN38MV', 1, 'EA', 207.15, 41.43, 41.43
from public.orders where purchase_order = 'AKDN-80074'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-10'::date, '113-1002738-2002759', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-03-28'::date, 'Global Parcel Demo', 'DEMO00007501', '2026-03-17'::date, 'RCPT-073089', '2026-03-28'::date, '2026-03-20'::date, 'NX-041089-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80074' and oi.sequential = '10' and oi.material = '223-745'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '32f00b43-4ec5-44c5-8a99-e0c583fd231b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80074' and oi.sequential = '10' and oi.material = '223-745'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a5d88491-0c4c-4e91-9a62-4281a3c9bd3e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80074' and oi.sequential = '10' and oi.material = '223-745'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '08534e49-825b-42cc-9347-dd60fb1cda0b'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80074' and oi.sequential = '10' and oi.material = '223-745'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-762', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000091', 'SUP-540990', 'B086HWKK34', 2, 'EA', 428.03, 41.8, 83.6
from public.orders where purchase_order = 'AKDN-80075'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-09'::date, '113-1002775-2002790', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-03-24'::date, 'UPS Demo', 'DEMO00007601', '2026-03-19'::date, 'RCPT-073090', '2026-03-24'::date, '2026-03-20'::date, 'NX-041090-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80075' and oi.sequential = '10' and oi.material = '223-762'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5bd1cb70-cde4-4973-a39c-ef6e81c15644'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80075' and oi.sequential = '10' and oi.material = '223-762'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '35b0c372-f689-4d8d-b895-1c6937b4f36c'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80075' and oi.sequential = '10' and oi.material = '223-762'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a1d87cd3-8794-415f-9f57-93e0689841eb'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80075' and oi.sequential = '10' and oi.material = '223-762'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-779', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000092', 'SUP-541001', 'B096664WGB', 1, 'EA', 185.55, 42.17, 42.17
from public.orders where purchase_order = 'AKDN-80076'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Open', 'Marina Torres',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80076' and oi.sequential = '10' and oi.material = '223-779'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-796', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000093', 'SUP-541012', 'B0A5SDL9VJ', 1, 'EA', 192.28, 42.54, 42.54
from public.orders where purchase_order = 'AKDN-80077'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-13'::date, '113-1002849-2002852', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80077' and oi.sequential = '10' and oi.material = '223-796'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-813', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000094', 'SUP-541023', 'B0B4EM4LAR', 2, 'EA', 398.2, 42.91, 85.82
from public.orders where purchase_order = 'AKDN-80078'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-12'::date, '113-1002886-2002883', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80078' and oi.sequential = '10' and oi.material = '223-813'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-830', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000095', 'SUP-541034', 'B0C42VLYPX', 1, 'EA', 206.01, 43.28, 43.28
from public.orders where purchase_order = 'AKDN-80079'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

commit;
