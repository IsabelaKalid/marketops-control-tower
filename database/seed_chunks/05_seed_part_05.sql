-- Demo seed part 05 of 10. Run files in numeric order.
begin;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-14'::date, '113-1002923-2002914', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80079' and oi.sequential = '10' and oi.material = '223-830'
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
) select id, '10', '223-847', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000096', 'SUP-541045', 'B0D3N55B46', 1, 'EA', 213.01, 43.65, 43.65
from public.orders where purchase_order = 'AKDN-80080'
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
where o.purchase_order = 'AKDN-80080' and oi.sequential = '10' and oi.material = '223-847'
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
) select id, '10', '223-864', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000097', 'SUP-541056', 'B0F3ACMNHD', 2, 'EA', 440.2, 44.02, 88.04
from public.orders where purchase_order = 'AKDN-80081'
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
where o.purchase_order = 'AKDN-80081' and oi.sequential = '10' and oi.material = '223-864'
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
) select id, '10', '223-881', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000098', 'SUP-541067', 'B0G2WL5ZWL', 1, 'EA', 227.28, 44.39, 44.39
from public.orders where purchase_order = 'AKDN-80082'
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
where o.purchase_order = 'AKDN-80082' and oi.sequential = '10' and oi.material = '223-881'
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
) select id, '10', '223-898', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000099', 'SUP-541078', 'B0HZJUMCBT', 1, 'EA', 196.94, 44.76, 44.76
from public.orders where purchase_order = 'AKDN-80083'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-18'::date, '113-1003071-2003038', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-04-06'::date, 'Global Parcel Demo', 'DEMO00008401', '2026-03-27'::date, 'RCPT-073098', '2026-04-06'::date, '2026-03-30'::date, 'NX-041098-26',
  '2026-04-09'::date, '2026-04-11'::date, '2026-04-15'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80083' and oi.sequential = '10' and oi.material = '223-898'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4b295141-c7f6-45d1-8db4-0d85589582f7'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80083' and oi.sequential = '10' and oi.material = '223-898'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '211b23de-4cda-4e44-87a9-201a5d35339c'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80083' and oi.sequential = '10' and oi.material = '223-898'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b4135ecd-3d84-4670-b8f5-3007c827a343'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80083' and oi.sequential = '10' and oi.material = '223-898'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7dd1dc27-a783-4bb7-9c9b-dfc91e226433'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80083' and oi.sequential = '10' and oi.material = '223-898'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c7fc7758-baf5-4851-acd8-1d90202770f6'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80083' and oi.sequential = '10' and oi.material = '223-898'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-915', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000100', 'SUP-541089', 'B0JZ635PQ2', 2, 'EA', 407.98, 45.13, 90.26
from public.orders where purchase_order = 'AKDN-80084'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-17'::date, '113-1003108-2003069', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-03-31'::date, 'UPS Demo', 'DEMO00008501', '2026-03-22'::date, 'RCPT-073099', '2026-03-31'::date, '2026-03-23'::date, 'NX-041099-26',
  '2026-04-01'::date, '2026-04-02'::date, '2026-04-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80084' and oi.sequential = '10' and oi.material = '223-915'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '78443ca6-8c3b-48de-b974-50cfba199ed5'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80084' and oi.sequential = '10' and oi.material = '223-915'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e905da15-3772-4bcc-b7b4-b5593afd1259'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80084' and oi.sequential = '10' and oi.material = '223-915'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1f8a1b66-6be3-44af-9873-b84a62667d7c'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80084' and oi.sequential = '10' and oi.material = '223-915'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '67fc9c42-4c84-4652-8cd8-8149568d5fee'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80084' and oi.sequential = '10' and oi.material = '223-915'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '15c3522e-f677-4bf9-bf95-c5ae01724e19'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80084' and oi.sequential = '10' and oi.material = '223-915'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-932', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000101', 'SUP-541100', 'B0KYTBN258', 1, 'EA', 211.12, 45.5, 45.5
from public.orders where purchase_order = 'AKDN-80085'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-19'::date, '113-1003145-2003100', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-03-30'::date, 'FedEx Demo', 'DEMO00008601', '2026-03-24'::date, 'RCPT-073100', '2026-03-30'::date, '2026-03-26'::date, 'NX-041100-26',
  '2026-04-01'::date, '2026-04-03'::date, '2026-04-05'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80085' and oi.sequential = '10' and oi.material = '223-932'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7d70db18-4c91-479d-a9ad-4953b2e532a3'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80085' and oi.sequential = '10' and oi.material = '223-932'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd7406544-11f2-47f7-9b2c-c54f3d99dbc1'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80085' and oi.sequential = '10' and oi.material = '223-932'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b988529a-91c1-41c4-8d57-a23b3066f040'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-03-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80085' and oi.sequential = '10' and oi.material = '223-932'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3091f798-3363-4ef5-828a-8a2c70f1aa06'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80085' and oi.sequential = '10' and oi.material = '223-932'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '18afd0e4-a55b-4680-b012-1af8cf3d99dd'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80085' and oi.sequential = '10' and oi.material = '223-932'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-949', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000102', 'SUP-541111', 'B0MXFK6EKF', 1, 'EA', 218.34, 45.87, 45.87
from public.orders where purchase_order = 'AKDN-80086'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-20'::date, '113-1003182-2003131', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-04-02'::date, 'Global Parcel Demo', 'DEMO00008701', '2026-03-25'::date, 'RCPT-073101', '2026-04-02'::date, '2026-03-28'::date, 'NX-041101-26',
  '2026-04-05'::date, '2026-04-06'::date, '2026-04-09'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80086' and oi.sequential = '10' and oi.material = '223-949'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e2a6302b-c531-4430-a493-9d15a0ec2d93'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80086' and oi.sequential = '10' and oi.material = '223-949'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7a2d4917-3a58-4242-a4c6-1334b056449f'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80086' and oi.sequential = '10' and oi.material = '223-949'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2238800c-df45-4ed6-9821-0e1318dfbd47'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80086' and oi.sequential = '10' and oi.material = '223-949'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '90da0293-f8f6-4fdc-b935-eb9719f9f239'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80086' and oi.sequential = '10' and oi.material = '223-949'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9b7d3852-0c7f-466b-9133-e4f105809226'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80086' and oi.sequential = '10' and oi.material = '223-949'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-966', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000103', 'SUP-541122', 'B0NX3SNRYN', 2, 'EA', 451.3, 46.24, 92.48
from public.orders where purchase_order = 'AKDN-80087'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-19'::date, '113-1003219-2003162', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-04-03'::date, 'UPS Demo', 'DEMO00008801', '2026-03-27'::date, 'RCPT-073102', '2026-04-03'::date, '2026-03-28'::date, 'NX-041102-26',
  '2026-04-04'::date, '2026-04-06'::date, '2026-04-10'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80087' and oi.sequential = '10' and oi.material = '223-966'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7c480603-d841-4c67-b524-0971a5a5ec4c'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80087' and oi.sequential = '10' and oi.material = '223-966'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b86c18e4-0876-43ab-b74f-7bd07f49afbe'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80087' and oi.sequential = '10' and oi.material = '223-966'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'bdab84f3-0fdf-47e8-bcc3-c3c1babfa5af'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80087' and oi.sequential = '10' and oi.material = '223-966'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ae0a23c8-33a6-4617-bee5-15bf56b4f55f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80087' and oi.sequential = '10' and oi.material = '223-966'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5c66a95c-aaf9-49ae-97cf-43390f757c8a'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80087' and oi.sequential = '10' and oi.material = '223-966'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '223-983', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000104', 'SUP-541133', 'B0PWP264DV', 1, 'EA', 233.05, 46.61, 46.61
from public.orders where purchase_order = 'AKDN-80088'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-21'::date, '113-1003256-2003193', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-04-07'::date, 'FedEx Demo', 'DEMO00008901', '2026-03-29'::date, 'RCPT-073103', '2026-04-07'::date, '2026-03-31'::date, 'NX-041103-26',
  '2026-04-09'::date, '2026-04-10'::date, '2026-04-11'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80088' and oi.sequential = '10' and oi.material = '223-983'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '522dd5ae-0862-4a87-92c6-e50aae76a27b'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80088' and oi.sequential = '10' and oi.material = '223-983'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7a9b6500-2f35-4a69-9954-cd12628e5595'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80088' and oi.sequential = '10' and oi.material = '223-983'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ff3cfda2-bc0d-4125-98a0-951b367d47c2'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80088' and oi.sequential = '10' and oi.material = '223-983'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '201567ec-85af-4443-960e-9778b4e0d6d6'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80088' and oi.sequential = '10' and oi.material = '223-983'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '682cb880-85db-4c74-93a2-cfc262766e54'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80088' and oi.sequential = '10' and oi.material = '223-983'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-000', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000105', 'SUP-541144', 'B0QWBAPFS4', 1, 'EA', 240.54, 46.98, 46.98
from public.orders where purchase_order = 'AKDN-80089'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-23'::date, '113-1003293-2003224', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-04-11'::date, 'Global Parcel Demo', 'DEMO00009001', '2026-03-31'::date, 'RCPT-073104', '2026-04-11'::date, '2026-04-03'::date, 'NX-041104-26',
  '2026-04-14'::date, '2026-04-16'::date, '2026-04-18'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80089' and oi.sequential = '10' and oi.material = '224-000'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '456b6f44-b4c9-493e-b905-7b219f94df48'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80089' and oi.sequential = '10' and oi.material = '224-000'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '66756cdc-28ed-4772-839b-98aad7af5e79'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80089' and oi.sequential = '10' and oi.material = '224-000'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e7a44f2c-f981-4253-af96-3d3946214d25'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80089' and oi.sequential = '10' and oi.material = '224-000'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a9e2ac5a-960e-41c0-a71f-314650d15796'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80089' and oi.sequential = '10' and oi.material = '224-000'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9e5bcea9-8820-4214-b442-424f5c3d7efc'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80089' and oi.sequential = '10' and oi.material = '224-000'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-017', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000106', 'SUP-541155', 'B0RVXH7S7B', 2, 'EA', 416.68, 47.35, 94.7
from public.orders where purchase_order = 'AKDN-80090'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-22'::date, '113-1003330-2003255', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-04-07'::date, 'UPS Demo', 'DEMO00009101', '2026-04-02'::date, 'RCPT-073105', '2026-04-07'::date, '2026-04-03'::date, 'NX-041105-26',
  '2026-04-08'::date, '2026-04-09'::date, '2026-04-12'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80090' and oi.sequential = '10' and oi.material = '224-017'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '86e1e2d5-6ed0-4151-94e8-a01ca365b22b'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80090' and oi.sequential = '10' and oi.material = '224-017'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3d822dec-2528-4bd8-aafc-2f4d72093478'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80090' and oi.sequential = '10' and oi.material = '224-017'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e6630571-8484-4743-8c7f-cb205b71fe36'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80090' and oi.sequential = '10' and oi.material = '224-017'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '09115fe5-9e75-49a4-a4ce-cf908dd2cb5e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80090' and oi.sequential = '10' and oi.material = '224-017'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dcc8d044-b05f-4182-ba5f-f95a9ad0f829'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80090' and oi.sequential = '10' and oi.material = '224-017'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-034', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000107', 'SUP-541166', 'B0SUKRP5LH', 1, 'EA', 215.69, 47.72, 47.72
from public.orders where purchase_order = 'AKDN-80091'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-24'::date, '113-1003367-2003286', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-04-04'::date, 'FedEx Demo', 'DEMO00009201', '2026-03-28'::date, 'RCPT-073106', '2026-04-04'::date, '2026-03-30'::date, 'NX-041106-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80091' and oi.sequential = '10' and oi.material = '224-034'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a7e5e6c3-150a-4d63-bc61-0322d577cff0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80091' and oi.sequential = '10' and oi.material = '224-034'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4f84a8ea-da81-41b5-bf1c-fc9aff8f84b9'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-03-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80091' and oi.sequential = '10' and oi.material = '224-034'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '761c57a6-234c-436b-911e-b27b2e6602be'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80091' and oi.sequential = '10' and oi.material = '224-034'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-051', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000108', 'SUP-541177', 'B0UU7Z7HZQ', 1, 'EA', 223.14, 48.09, 48.09
from public.orders where purchase_order = 'AKDN-80092'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-26'::date, '113-1003404-2003317', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-04-08'::date, 'Global Parcel Demo', 'DEMO00009301', '2026-03-30'::date, 'RCPT-073107', '2026-04-08'::date, '2026-04-02'::date, 'NX-041107-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80092' and oi.sequential = '10' and oi.material = '224-051'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '48e6ae43-f3a5-4c62-be0c-c0d59897a1b4'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80092' and oi.sequential = '10' and oi.material = '224-051'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fdaf0373-b935-4751-9ff2-e323e9e97042'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80092' and oi.sequential = '10' and oi.material = '224-051'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1477818c-269a-4727-bbef-51b53ed39910'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80092' and oi.sequential = '10' and oi.material = '224-051'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-068', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000109', 'SUP-541188', 'B0VTT8QUEX', 2, 'EA', 461.34, 48.46, 96.92
from public.orders where purchase_order = 'AKDN-80093'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-24'::date, '113-1003441-2003348', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-04-08'::date, 'UPS Demo', 'DEMO00009401', '2026-03-31'::date, 'RCPT-073108', '2026-04-08'::date, '2026-04-01'::date, 'NX-041108-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80093' and oi.sequential = '10' and oi.material = '224-068'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '15feef88-6535-4f3f-9da3-c9c155f90173'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80093' and oi.sequential = '10' and oi.material = '224-068'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '59a54471-52bb-4bce-84a0-789fa4963727'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80093' and oi.sequential = '10' and oi.material = '224-068'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b7945d2e-ca19-4868-a0f2-4cdc816c1cf2'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-03-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80093' and oi.sequential = '10' and oi.material = '224-068'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-085', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000110', 'SUP-541199', 'B0WSGG87T6', 1, 'EA', 238.29, 48.83, 48.83
from public.orders where purchase_order = 'AKDN-80094'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-26'::date, '113-1003478-2003379', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-04-12'::date, 'FedEx Demo', 'DEMO00009501', '2026-04-02'::date, 'RCPT-073109', '2026-04-12'::date, '2026-04-04'::date, 'NX-041109-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80094' and oi.sequential = '10' and oi.material = '224-085'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4cc5ebd5-102a-4741-a9b6-03d84cb666c6'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80094' and oi.sequential = '10' and oi.material = '224-085'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6a02c43c-4026-4233-9a2b-9d39f0ff14da'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80094' and oi.sequential = '10' and oi.material = '224-085'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3eeaddc0-eda3-4180-9fc3-dd9b3e567c4e'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80094' and oi.sequential = '10' and oi.material = '224-085'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-102', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000111', 'SUP-541210', 'B0XS4QQJ8D', 1, 'EA', 246, 49.2, 49.2
from public.orders where purchase_order = 'AKDN-80095'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-28'::date, '113-1003515-2003410', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-04-11'::date, 'Global Parcel Demo', 'DEMO00009601', '2026-04-04'::date, 'RCPT-073110', '2026-04-11'::date, '2026-04-07'::date, 'NX-041110-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80095' and oi.sequential = '10' and oi.material = '224-102'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '23147bd0-6610-40f3-8a1d-c8460b822394'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80095' and oi.sequential = '10' and oi.material = '224-102'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b0bc6062-cd85-40ee-aeae-66e52b3b94c1'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80095' and oi.sequential = '10' and oi.material = '224-102'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a1203ac1-f372-4768-84fc-234e73893331'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80095' and oi.sequential = '10' and oi.material = '224-102'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-119', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000112', 'SUP-541221', 'B0YRQX8VML', 2, 'EA', 507.6, 49.57, 99.14
from public.orders where purchase_order = 'AKDN-80096'
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
where o.purchase_order = 'AKDN-80096' and oi.sequential = '10' and oi.material = '224-119'
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
) select id, '10', '224-136', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000113', 'SUP-541232', 'B0ZQC7R83S', 1, 'EA', 219.74, 49.94, 49.94
from public.orders where purchase_order = 'AKDN-80097'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-29'::date, '113-1003589-2003472', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80097' and oi.sequential = '10' and oi.material = '224-136'
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
) select id, '10', '224-153', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000114', 'SUP-541243', 'B03QYF9KGZ', 1, 'EA', 227.4, 50.31, 50.31
from public.orders where purchase_order = 'AKDN-80098'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-31'::date, '113-1003626-2003503', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80098' and oi.sequential = '10' and oi.material = '224-153'
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
) select id, '10', '224-170', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000115', 'SUP-541254', 'B04PLNRXV8', 2, 'EA', 470.31, 50.68, 101.36
from public.orders where purchase_order = 'AKDN-80099'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-03-30'::date, '113-1003663-2003534', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80099' and oi.sequential = '10' and oi.material = '224-170'
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
) select id, '10', '224-187', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000116', 'SUP-541265', 'B05P8W9AAF', 1, 'EA', 243, 51.05, 51.05
from public.orders where purchase_order = 'AKDN-80100'
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
where o.purchase_order = 'AKDN-80100' and oi.sequential = '10' and oi.material = '224-187'
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
) select id, '10', '224-204', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000117', 'SUP-541276', 'B06NU6SMPN', 1, 'EA', 250.93, 51.42, 51.42
from public.orders where purchase_order = 'AKDN-80101'
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
where o.purchase_order = 'AKDN-80101' and oi.sequential = '10' and oi.material = '224-204'
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
) select id, '10', '224-221', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000118', 'SUP-541287', 'B07MGDAY4V', 2, 'EA', 517.9, 51.79, 103.58
from public.orders where purchase_order = 'AKDN-80102'
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
where o.purchase_order = 'AKDN-80102' and oi.sequential = '10' and oi.material = '224-221'
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
) select id, '10', '224-238', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000119', 'SUP-541298', 'B09M5MSBH3', 1, 'EA', 267.06, 52.16, 52.16
from public.orders where purchase_order = 'AKDN-80103'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-03'::date, '113-1003811-2003658', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-04-21'::date, 'FedEx Demo', 'DEMO00010401', '2026-04-12'::date, 'RCPT-073118', '2026-04-21'::date, '2026-04-14'::date, 'NX-041118-26',
  '2026-04-23'::date, '2026-04-25'::date, '2026-04-29'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80103' and oi.sequential = '10' and oi.material = '224-238'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b03811e5-4e9c-40f8-bf59-5be7b44292a8'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80103' and oi.sequential = '10' and oi.material = '224-238'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd30816ab-af05-4ba0-a6af-bb07b575320b'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80103' and oi.sequential = '10' and oi.material = '224-238'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '40f3a4c9-5df8-4d7a-a49a-3846ffac2d86'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80103' and oi.sequential = '10' and oi.material = '224-238'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dee918c8-777a-463e-be3d-67332798b9bb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80103' and oi.sequential = '10' and oi.material = '224-238'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e7d5533d-9211-4a90-a9f9-1a154de7799d'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80103' and oi.sequential = '10' and oi.material = '224-238'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-255', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000120', 'SUP-541309', 'B0ALRVANWA', 1, 'EA', 231.13, 52.53, 52.53
from public.orders where purchase_order = 'AKDN-80104'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-05'::date, '113-1003848-2003689', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-04-25'::date, 'Global Parcel Demo', 'DEMO00010501', '2026-04-14'::date, 'RCPT-073119', '2026-04-25'::date, '2026-04-17'::date, 'NX-041119-26',
  '2026-04-28'::date, '2026-04-29'::date, '2026-04-30'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80104' and oi.sequential = '10' and oi.material = '224-255'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '23ffb8ca-8fd5-4675-8ad5-85ecc116d7f7'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80104' and oi.sequential = '10' and oi.material = '224-255'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f2929139-ef77-43b4-a5fa-3c31d2623108'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80104' and oi.sequential = '10' and oi.material = '224-255'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd242535a-8398-4479-b69c-1b8e2f0e9e5c'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80104' and oi.sequential = '10' and oi.material = '224-255'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '83045738-8528-4cee-871e-ad2dbab14bec'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80104' and oi.sequential = '10' and oi.material = '224-255'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '826a3edd-127f-42dd-93ba-cd309e132bde'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80104' and oi.sequential = '10' and oi.material = '224-255'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-272', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000121', 'SUP-541320', 'B0BKD4T2BH', 2, 'EA', 478.22, 52.9, 105.8
from public.orders where purchase_order = 'AKDN-80105'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-04'::date, '113-1003885-2003720', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-04-14'::date, 'UPS Demo', 'DEMO00010601', '2026-04-09'::date, 'RCPT-073120', '2026-04-14'::date, '2026-04-10'::date, 'NX-041120-26',
  '2026-04-15'::date, '2026-04-17'::date, '2026-04-19'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80105' and oi.sequential = '10' and oi.material = '224-272'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd49e8172-25e5-4ca5-a7dc-d9efa341b5f6'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80105' and oi.sequential = '10' and oi.material = '224-272'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '90cf4219-0f79-4af0-a844-b3c3781997c0'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80105' and oi.sequential = '10' and oi.material = '224-272'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '54beac8c-ec26-4392-8898-91b665edd3fb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80105' and oi.sequential = '10' and oi.material = '224-272'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b68718ae-9002-4ab7-b98a-18f11b064df5'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80105' and oi.sequential = '10' and oi.material = '224-272'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'bb0cd638-136c-474f-9ba5-18bfafd65d62'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80105' and oi.sequential = '10' and oi.material = '224-272'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-289', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000122', 'SUP-541331', 'B0CKZCBDQQ', 1, 'EA', 247.17, 53.27, 53.27
from public.orders where purchase_order = 'AKDN-80106'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-05'::date, '113-1003922-2003751', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-04-17'::date, 'FedEx Demo', 'DEMO00010701', '2026-04-10'::date, 'RCPT-073121', '2026-04-17'::date, '2026-04-12'::date, 'NX-041121-26',
  '2026-04-19'::date, '2026-04-20'::date, '2026-04-23'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80106' and oi.sequential = '10' and oi.material = '224-289'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f3753071-bd91-4104-bdc4-fe4f4a5cb7f4'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80106' and oi.sequential = '10' and oi.material = '224-289'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd30cca21-2df5-4d80-b2ed-409919231ff3'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80106' and oi.sequential = '10' and oi.material = '224-289'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '320b8308-f756-4084-a5bf-586d02f28273'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80106' and oi.sequential = '10' and oi.material = '224-289'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '23203d2b-d0c8-435d-b80d-363e40e4e042'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80106' and oi.sequential = '10' and oi.material = '224-289'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4d27be91-2331-4634-9ae2-bdfd7b7df890'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80106' and oi.sequential = '10' and oi.material = '224-289'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-306', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000123', 'SUP-541342', 'B0DJMLTQ6X', 1, 'EA', 255.33, 53.64, 53.64
from public.orders where purchase_order = 'AKDN-80107'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-07'::date, '113-1003959-2003782', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-04-21'::date, 'Global Parcel Demo', 'DEMO00010801', '2026-04-12'::date, 'RCPT-073122', '2026-04-21'::date, '2026-04-15'::date, 'NX-041122-26',
  '2026-04-24'::date, '2026-04-26'::date, '2026-04-30'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80107' and oi.sequential = '10' and oi.material = '224-306'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1b09658e-e839-43cf-a361-860d053d0343'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80107' and oi.sequential = '10' and oi.material = '224-306'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '51c7cbeb-aacb-4d16-9230-93ce6dd8cf3e'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80107' and oi.sequential = '10' and oi.material = '224-306'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '84273f6b-6a4d-41b2-895c-69dad4e90474'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80107' and oi.sequential = '10' and oi.material = '224-306'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '447619a5-308e-4e49-9612-628e76daa151'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80107' and oi.sequential = '10' and oi.material = '224-306'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f54b5f28-588d-4086-9adf-f73cec73ace0'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80107' and oi.sequential = '10' and oi.material = '224-306'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-323', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000124', 'SUP-541353', 'B0EJ9TB3K5', 2, 'EA', 527.14, 54.01, 108.02
from public.orders where purchase_order = 'AKDN-80108'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-06'::date, '113-1003996-2003813', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-04-22'::date, 'UPS Demo', 'DEMO00010901', '2026-04-14'::date, 'RCPT-073123', '2026-04-22'::date, '2026-04-15'::date, 'NX-041123-26',
  '2026-04-23'::date, '2026-04-24'::date, '2026-04-25'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80108' and oi.sequential = '10' and oi.material = '224-323'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c6cb51c8-9951-43b7-8152-7d7e8e265e17'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-04-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80108' and oi.sequential = '10' and oi.material = '224-323'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'da4ad54f-2f76-434f-9ed4-d4153e1bac06'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80108' and oi.sequential = '10' and oi.material = '224-323'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fde92e1d-9781-4bc3-8bbc-7567fd20a0bc'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80108' and oi.sequential = '10' and oi.material = '224-323'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4e1bbbe9-4cb9-4982-8f4d-9a3043701412'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80108' and oi.sequential = '10' and oi.material = '224-323'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '742caeb1-0576-4976-869f-0fe5fb361158'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80108' and oi.sequential = '10' and oi.material = '224-323'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-340', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000125', 'SUP-541364', 'B0GHV3UEYC', 1, 'EA', 271.9, 54.38, 54.38
from public.orders where purchase_order = 'AKDN-80109'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-08'::date, '113-1004033-2003844', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-04-26'::date, 'FedEx Demo', 'DEMO00011001', '2026-04-16'::date, 'RCPT-073124', '2026-04-26'::date, '2026-04-18'::date, 'NX-041124-26',
  '2026-04-28'::date, '2026-04-30'::date, '2026-05-02'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80109' and oi.sequential = '10' and oi.material = '224-340'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0ad7c1cd-4d9d-47a7-9bf6-fe2a431a4791'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80109' and oi.sequential = '10' and oi.material = '224-340'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '27b9c826-aa55-4440-b592-26a7b8a9fe09'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80109' and oi.sequential = '10' and oi.material = '224-340'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f1aa5c1d-7cc1-4231-b150-97bec34b0ea0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80109' and oi.sequential = '10' and oi.material = '224-340'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4e21555a-ce09-46c0-abf3-afcb42ded76a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80109' and oi.sequential = '10' and oi.material = '224-340'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '97389681-e3de-4c52-920b-cdde4b269336'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80109' and oi.sequential = '10' and oi.material = '224-340'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-357', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000126', 'SUP-541375', 'B0HGHBCRDK', 1, 'EA', 280.32, 54.75, 54.75
from public.orders where purchase_order = 'AKDN-80110'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-10'::date, '113-1004070-2003875', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-04-25'::date, 'Global Parcel Demo', 'DEMO00011101', '2026-04-18'::date, 'RCPT-073125', '2026-04-25'::date, '2026-04-21'::date, 'NX-041125-26',
  '2026-04-28'::date, '2026-04-29'::date, '2026-05-02'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80110' and oi.sequential = '10' and oi.material = '224-357'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fe521548-980d-4b93-9e14-e4c31ea5211d'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80110' and oi.sequential = '10' and oi.material = '224-357'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3fa76b81-62c6-4053-826e-cd5094444408'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-04-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80110' and oi.sequential = '10' and oi.material = '224-357'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '547ff850-908d-4dbb-92fa-6f8a58af5874'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80110' and oi.sequential = '10' and oi.material = '224-357'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b3eabddf-1fcc-41b5-9a02-40ddabf8bbce'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80110' and oi.sequential = '10' and oi.material = '224-357'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '423281ff-8a16-4f9a-a97a-5700b51c58f4'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80110' and oi.sequential = '10' and oi.material = '224-357'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-374', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000127', 'SUP-541386', 'B0JG5JU4SS', 2, 'EA', 485.06, 55.12, 110.24
from public.orders where purchase_order = 'AKDN-80111'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-09'::date, '113-1004107-2003906', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-04-26'::date, 'UPS Demo', 'DEMO00011201', '2026-04-20'::date, 'RCPT-073126', '2026-04-26'::date, '2026-04-21'::date, 'NX-041126-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80111' and oi.sequential = '10' and oi.material = '224-374'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e622846b-9ae8-4d0c-a0bd-48fc605d9175'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80111' and oi.sequential = '10' and oi.material = '224-374'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '69df4f4e-f7b0-4de3-b1b8-fe3a22de671e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80111' and oi.sequential = '10' and oi.material = '224-374'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ccd3af18-0b66-4e8d-bd61-1782104405b5'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80111' and oi.sequential = '10' and oi.material = '224-374'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-391', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000128', 'SUP-541397', 'B0KFSSCG7Z', 1, 'EA', 250.81, 55.49, 55.49
from public.orders where purchase_order = 'AKDN-80112'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-11'::date, '113-1004144-2003937', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-04-23'::date, 'FedEx Demo', 'DEMO00011301', '2026-04-15'::date, 'RCPT-073127', '2026-04-23'::date, '2026-04-17'::date, 'NX-041127-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80112' and oi.sequential = '10' and oi.material = '224-391'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '08991b2b-f4a9-49f5-af17-af812fda605b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80112' and oi.sequential = '10' and oi.material = '224-391'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '31a1031d-8a74-4ca2-b5f5-93d882956b70'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80112' and oi.sequential = '10' and oi.material = '224-391'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3c65797d-bdd9-4710-a1b2-f3f7f28bec2d'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80112' and oi.sequential = '10' and oi.material = '224-391'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-408', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000129', 'SUP-541408', 'B0LEE2UTL8', 1, 'EA', 259.19, 55.86, 55.86
from public.orders where purchase_order = 'AKDN-80113'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-12'::date, '113-1004181-2003968', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-04-26'::date, 'Global Parcel Demo', 'DEMO00011401', '2026-04-16'::date, 'RCPT-073128', '2026-04-26'::date, '2026-04-19'::date, 'NX-041128-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80113' and oi.sequential = '10' and oi.material = '224-408'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7b3bbd5d-d083-47f9-9672-94ee77d1c6eb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80113' and oi.sequential = '10' and oi.material = '224-408'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c5eb7a4a-2d80-4c7d-85e0-14f5d13c928b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80113' and oi.sequential = '10' and oi.material = '224-408'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f2883216-5174-4a95-a16a-5e48141c3f84'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80113' and oi.sequential = '10' and oi.material = '224-408'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-425', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000130', 'SUP-541419', 'B0ME29D6ZE', 2, 'EA', 535.31, 56.23, 112.46
from public.orders where purchase_order = 'AKDN-80114'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-11'::date, '113-1004218-2003999', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-04-27'::date, 'UPS Demo', 'DEMO00011501', '2026-04-18'::date, 'RCPT-073129', '2026-04-27'::date, '2026-04-19'::date, 'NX-041129-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80114' and oi.sequential = '10' and oi.material = '224-425'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a0f9876d-4d94-488a-92fe-45210c5f7507'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80114' and oi.sequential = '10' and oi.material = '224-425'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '879bd760-990d-4c86-9549-d96170eed24e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80114' and oi.sequential = '10' and oi.material = '224-425'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '42e6cc43-a31a-4e2f-95ad-2db52a0b1bb9'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80114' and oi.sequential = '10' and oi.material = '224-425'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-442', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000131', 'SUP-541430', 'B0PDNHVHEM', 1, 'EA', 276.21, 56.6, 56.6
from public.orders where purchase_order = 'AKDN-80115'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-13'::date, '113-1004255-2004030', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-04-26'::date, 'FedEx Demo', 'DEMO00011601', '2026-04-20'::date, 'RCPT-073130', '2026-04-26'::date, '2026-04-22'::date, 'NX-041130-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80115' and oi.sequential = '10' and oi.material = '224-442'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '26794457-d702-462d-b804-16bcb7bc23a8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-04-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80115' and oi.sequential = '10' and oi.material = '224-442'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fcd5bd9f-5f89-4f28-979a-3532638d91f2'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80115' and oi.sequential = '10' and oi.material = '224-442'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '586a9a08-9d40-49cb-9b8b-28c00319b2a2'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80115' and oi.sequential = '10' and oi.material = '224-442'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-459', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000132', 'SUP-541441', 'B0QDARDUTU', 1, 'EA', 284.85, 56.97, 56.97
from public.orders where purchase_order = 'AKDN-80116'
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
where o.purchase_order = 'AKDN-80116' and oi.sequential = '10' and oi.material = '224-459'
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
) select id, '10', '224-476', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000133', 'SUP-541452', 'B0RCWYV783', 2, 'EA', 587.16, 57.34, 114.68
from public.orders where purchase_order = 'AKDN-80117'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-14'::date, '113-1004329-2004092', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80117' and oi.sequential = '10' and oi.material = '224-476'
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
) select id, '10', '224-493', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000134', 'SUP-541463', 'B0SBJ8EJNA', 1, 'EA', 253.92, 57.71, 57.71
from public.orders where purchase_order = 'AKDN-80118'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-16'::date, '113-1004366-2004123', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80118' and oi.sequential = '10' and oi.material = '224-493'
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
) select id, '10', '224-510', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000135', 'SUP-541474', 'B0TB6GWW3H', 1, 'EA', 262.52, 58.08, 58.08
from public.orders where purchase_order = 'AKDN-80119'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-17'::date, '113-1004403-2004154', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80119' and oi.sequential = '10' and oi.material = '224-510'
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
) select id, '10', '224-527', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000136', 'SUP-541485', 'B0VASPE9GP', 2, 'EA', 542.42, 58.45, 116.9
from public.orders where purchase_order = 'AKDN-80120'
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
where o.purchase_order = 'AKDN-80120' and oi.sequential = '10' and oi.material = '224-527'
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
) select id, '10', '224-544', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000137', 'SUP-541496', 'B0W9FXWLVW', 1, 'EA', 279.98, 58.82, 58.82
from public.orders where purchase_order = 'AKDN-80121'
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
where o.purchase_order = 'AKDN-80121' and oi.sequential = '10' and oi.material = '224-544'
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
) select id, '10', '224-561', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000138', 'SUP-541507', 'B0X937FXA5', 1, 'EA', 288.85, 59.19, 59.19
from public.orders where purchase_order = 'AKDN-80122'
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
where o.purchase_order = 'AKDN-80122' and oi.sequential = '10' and oi.material = '224-561'
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
) select id, '10', '224-578', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000139', 'SUP-541518', 'B0Y8PEXAPC', 2, 'EA', 595.6, 59.56, 119.12
from public.orders where purchase_order = 'AKDN-80123'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-19'::date, '113-1004551-2004278', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-05-06'::date, 'UPS Demo', 'DEMO00012401', '2026-04-28'::date, 'RCPT-073138', '2026-05-06'::date, '2026-04-29'::date, 'NX-041138-26',
  '2026-05-07'::date, '2026-05-09'::date, '2026-05-13'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80123' and oi.sequential = '10' and oi.material = '224-578'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '397ef410-92da-4715-b4dc-55b335dda615'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80123' and oi.sequential = '10' and oi.material = '224-578'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

commit;
