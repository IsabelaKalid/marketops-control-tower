-- Demo seed part 07 of 10. Run files in numeric order.
begin;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'add88cee-6f17-41f9-899b-84646a8f8053'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80165' and oi.sequential = '10' and oi.material = '225-292'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd4fece17-ecb5-412e-8544-060542a4209d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80165' and oi.sequential = '10' and oi.material = '225-292'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b2559d35-0bba-4834-92ed-7c56259f59ca'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80165' and oi.sequential = '10' and oi.material = '225-292'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-309', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000182', 'SUP-541991', 'B0KDQQRAAJ', 1, 'EA', 386.41, 75.47, 75.47
from public.orders where purchase_order = 'AKDN-80166'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-26'::date, '113-1006142-2005611', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-06-11'::date, 'FedEx Demo', 'DEMO00016701', '2026-06-04'::date, 'RCPT-073181', '2026-06-11'::date, '2026-06-06'::date, 'NX-041181-26',
  '2026-06-13'::date, '2026-06-14'::date, '2026-06-17'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80166' and oi.sequential = '10' and oi.material = '225-309'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '347f7237-69c2-4eb2-b50b-65b8879de6c2'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80166' and oi.sequential = '10' and oi.material = '225-309'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6c19c49a-aabf-4b89-9831-d88895550eff'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80166' and oi.sequential = '10' and oi.material = '225-309'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a6571dbf-83d3-46b9-83b4-a8897648605d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80166' and oi.sequential = '10' and oi.material = '225-309'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6ff6510a-0aa5-4c0e-9708-fd098024df80'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80166' and oi.sequential = '10' and oi.material = '225-309'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '292990d3-6226-4e97-9187-3732066b7864'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80166' and oi.sequential = '10' and oi.material = '225-309'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-326', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000183', 'SUP-542002', 'B0LDCY9MPQ', 1, 'EA', 333.7, 75.84, 75.84
from public.orders where purchase_order = 'AKDN-80167'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-28'::date, '113-1006179-2005642', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-06-15'::date, 'Global Parcel Demo', 'DEMO00016801', '2026-06-06'::date, 'RCPT-073182', '2026-06-15'::date, '2026-06-09'::date, 'NX-041182-26',
  '2026-06-18'::date, '2026-06-20'::date, '2026-06-24'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80167' and oi.sequential = '10' and oi.material = '225-326'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '40694c97-8b02-46b4-8809-203cdfce20c3'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80167' and oi.sequential = '10' and oi.material = '225-326'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'de7b9ac5-2e3f-431b-888b-16488c27da29'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80167' and oi.sequential = '10' and oi.material = '225-326'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '382cf71a-87b6-4b7a-9534-cb67dcf84bd6'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80167' and oi.sequential = '10' and oi.material = '225-326'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1ff010f7-5006-448b-8e3a-f89ae8a4c22d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80167' and oi.sequential = '10' and oi.material = '225-326'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b1900cab-f946-4f23-b6ae-bf83fa7611b5'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80167' and oi.sequential = '10' and oi.material = '225-326'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-343', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000184', 'SUP-542013', 'B0MCY7SY4X', 2, 'EA', 688.94, 76.21, 152.42
from public.orders where purchase_order = 'AKDN-80168'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-27'::date, '113-1006216-2005673', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-06-09'::date, 'UPS Demo', 'DEMO00016901', '2026-06-01'::date, 'RCPT-073183', '2026-06-09'::date, '2026-06-02'::date, 'NX-041183-26',
  '2026-06-10'::date, '2026-06-11'::date, '2026-06-12'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80168' and oi.sequential = '10' and oi.material = '225-343'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c2aba944-a7d7-4b1a-ae9e-9d68164397b0'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80168' and oi.sequential = '10' and oi.material = '225-343'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '073f4a38-7d40-41a6-969d-040969147eb6'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80168' and oi.sequential = '10' and oi.material = '225-343'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b41321c5-2df9-4d06-ba5d-f6fa7234e2d9'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80168' and oi.sequential = '10' and oi.material = '225-343'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a5ab6b6a-7a17-40fe-b0b4-c44f31bd1b60'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80168' and oi.sequential = '10' and oi.material = '225-343'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2c407867-ce7d-470e-8b62-40ab40c9bfe8'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80168' and oi.sequential = '10' and oi.material = '225-343'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-360', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000185', 'SUP-542024', 'B0NBLFABH6', 1, 'EA', 355.33, 76.58, 76.58
from public.orders where purchase_order = 'AKDN-80169'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-29'::date, '113-1006253-2005704', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-06-13'::date, 'FedEx Demo', 'DEMO00017001', '2026-06-03'::date, 'RCPT-073184', '2026-06-13'::date, '2026-06-05'::date, 'NX-041184-26',
  '2026-06-15'::date, '2026-06-17'::date, '2026-06-19'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80169' and oi.sequential = '10' and oi.material = '225-360'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5dd952c0-e693-4fc8-94b9-55457630cf6a'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80169' and oi.sequential = '10' and oi.material = '225-360'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f1086926-0d71-4ce7-a1a2-75ff683de1e7'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80169' and oi.sequential = '10' and oi.material = '225-360'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9375a62f-917f-4071-885a-2b440827606b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80169' and oi.sequential = '10' and oi.material = '225-360'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0cbe0d50-c601-4740-9bec-ca92deae0887'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80169' and oi.sequential = '10' and oi.material = '225-360'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b820067b-d94e-4bf1-bc03-3eae8477b76e'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80169' and oi.sequential = '10' and oi.material = '225-360'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-377', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000186', 'SUP-542035', 'B0PB8PSNWD', 1, 'EA', 366.28, 76.95, 76.95
from public.orders where purchase_order = 'AKDN-80170'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-31'::date, '113-1006290-2005735', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-06-12'::date, 'Global Parcel Demo', 'DEMO00017101', '2026-06-05'::date, 'RCPT-073185', '2026-06-12'::date, '2026-06-08'::date, 'NX-041185-26',
  '2026-06-15'::date, '2026-06-16'::date, '2026-06-19'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80170' and oi.sequential = '10' and oi.material = '225-377'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f30b05aa-5b39-45df-82e2-8f0a49a90456'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80170' and oi.sequential = '10' and oi.material = '225-377'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4fa14049-6544-4d6a-8f69-36a1acc8c9d0'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80170' and oi.sequential = '10' and oi.material = '225-377'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e6b20b5b-dd97-4949-9f05-afaecd313062'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80170' and oi.sequential = '10' and oi.material = '225-377'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e50a9428-2b71-468c-8913-96197dea3aec'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80170' and oi.sequential = '10' and oi.material = '225-377'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'df03ca79-c524-4451-96b8-7536ccc7d1a6'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80170' and oi.sequential = '10' and oi.material = '225-377'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-394', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000187', 'SUP-542046', 'B0RAUWA2BL', 2, 'EA', 754.64, 77.32, 154.64
from public.orders where purchase_order = 'AKDN-80171'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-30'::date, '113-1006327-2005766', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-06-13'::date, 'UPS Demo', 'DEMO00017201', '2026-06-07'::date, 'RCPT-073186', '2026-06-13'::date, '2026-06-08'::date, 'NX-041186-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80171' and oi.sequential = '10' and oi.material = '225-394'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'de025a2e-fda5-49e8-9e1d-30e55ee44ff4'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80171' and oi.sequential = '10' and oi.material = '225-394'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1e14d4f9-ce2f-4b40-8fde-f5d12a68d490'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80171' and oi.sequential = '10' and oi.material = '225-394'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f35cc708-f033-41f4-b4bf-e12f6d599027'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80171' and oi.sequential = '10' and oi.material = '225-394'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-411', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000188', 'SUP-542057', 'B0S9G6TDRS', 1, 'EA', 388.45, 77.69, 77.69
from public.orders where purchase_order = 'AKDN-80172'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-31'::date, '113-1006364-2005797', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-06-16'::date, 'FedEx Demo', 'DEMO00017301', '2026-06-08'::date, 'RCPT-073187', '2026-06-16'::date, '2026-06-10'::date, 'NX-041187-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80172' and oi.sequential = '10' and oi.material = '225-411'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '477b3b9b-ed2d-4786-9a4c-33c9e72b5f3b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80172' and oi.sequential = '10' and oi.material = '225-411'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '08c6abc8-498b-4e7f-a4c9-13b4efed89eb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80172' and oi.sequential = '10' and oi.material = '225-411'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9eb6853b-f422-4842-a0b2-f20160d664e6'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80172' and oi.sequential = '10' and oi.material = '225-411'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-428', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000189', 'SUP-542068', 'B0T94EBQ6Z', 1, 'EA', 399.67, 78.06, 78.06
from public.orders where purchase_order = 'AKDN-80173'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-02'::date, '113-1006401-2005828', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-06-20'::date, 'Global Parcel Demo', 'DEMO00017401', '2026-06-10'::date, 'RCPT-073188', '2026-06-20'::date, '2026-06-13'::date, 'NX-041188-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80173' and oi.sequential = '10' and oi.material = '225-428'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '85cce180-ef21-4e80-b97d-0d3457337ee7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80173' and oi.sequential = '10' and oi.material = '225-428'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '37e8f627-e3e2-451b-8c2b-8d9d97963b1a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80173' and oi.sequential = '10' and oi.material = '225-428'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '96b7fb62-ac9b-4267-bc06-b5b86655f6d8'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80173' and oi.sequential = '10' and oi.material = '225-428'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-445', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000190', 'SUP-542079', 'B0U8QMT3K8', 2, 'EA', 690.18, 78.43, 156.86
from public.orders where purchase_order = 'AKDN-80174'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-01'::date, '113-1006438-2005859', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-06-21'::date, 'UPS Demo', 'DEMO00017501', '2026-06-12'::date, 'RCPT-073189', '2026-06-21'::date, '2026-06-13'::date, 'NX-041189-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80174' and oi.sequential = '10' and oi.material = '225-445'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3852585d-b121-4864-96a0-51792bcff3b2'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80174' and oi.sequential = '10' and oi.material = '225-445'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '057f950f-bfce-455e-80a7-f0498dca72bb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80174' and oi.sequential = '10' and oi.material = '225-445'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f5ba280e-1489-4864-b960-76eb6732ff74'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80174' and oi.sequential = '10' and oi.material = '225-445'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-462', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000191', 'SUP-542090', 'B0V7DVBEYF', 1, 'EA', 356.18, 78.8, 78.8
from public.orders where purchase_order = 'AKDN-80175'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-03'::date, '113-1006475-2005890', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-06-13'::date, 'FedEx Demo', 'DEMO00017601', '2026-06-07'::date, 'RCPT-073190', '2026-06-13'::date, '2026-06-09'::date, 'NX-041190-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80175' and oi.sequential = '10' and oi.material = '225-462'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '22127e0b-ff0e-4274-bf26-81d6c130c644'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80175' and oi.sequential = '10' and oi.material = '225-462'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e047762e-590b-4b5e-a507-2c04af5c0c2e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80175' and oi.sequential = '10' and oi.material = '225-462'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'cd837ff0-3911-4f87-81f5-de2379cf3e66'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80175' and oi.sequential = '10' and oi.material = '225-462'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-479', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000192', 'SUP-542101', 'B0X7Z5URDN', 1, 'EA', 367.35, 79.17, 79.17
from public.orders where purchase_order = 'AKDN-80176'
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
where o.purchase_order = 'AKDN-80176' and oi.sequential = '10' and oi.material = '225-479'
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
) select id, '10', '225-496', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000193', 'SUP-542112', 'B0Y6MCC5SV', 2, 'EA', 757.22, 79.54, 159.08
from public.orders where purchase_order = 'AKDN-80177'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-04'::date, '113-1006549-2005952', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80177' and oi.sequential = '10' and oi.material = '225-496'
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
) select id, '10', '225-513', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000194', 'SUP-542123', 'B0Z69LUG73', 1, 'EA', 389.96, 79.91, 79.91
from public.orders where purchase_order = 'AKDN-80178'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-06'::date, '113-1006586-2005983', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80178' and oi.sequential = '10' and oi.material = '225-513'
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
) select id, '10', '225-530', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000195', 'SUP-542134', 'B025VUCTLA', 1, 'EA', 401.4, 80.28, 80.28
from public.orders where purchase_order = 'AKDN-80179'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-07'::date, '113-1006623-2006014', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80179' and oi.sequential = '10' and oi.material = '225-530'
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
) select id, '10', '225-547', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000196', 'SUP-542145', 'B034H3V6ZH', 2, 'EA', 825.86, 80.65, 161.3
from public.orders where purchase_order = 'AKDN-80180'
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
where o.purchase_order = 'AKDN-80180' and oi.sequential = '10' and oi.material = '225-547'
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
) select id, '10', '225-564', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000197', 'SUP-542156', 'B0445BDHEQ', 1, 'EA', 356.49, 81.02, 81.02
from public.orders where purchase_order = 'AKDN-80181'
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
where o.purchase_order = 'AKDN-80181' and oi.sequential = '10' and oi.material = '225-564'
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
) select id, '10', '225-581', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000198', 'SUP-542167', 'B063RKVUUX', 1, 'EA', 367.88, 81.39, 81.39
from public.orders where purchase_order = 'AKDN-80182'
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
where o.purchase_order = 'AKDN-80182' and oi.sequential = '10' and oi.material = '225-581'
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
) select id, '10', '225-598', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000199', 'SUP-542178', 'B072DSD796', 2, 'EA', 758.73, 81.76, 163.52
from public.orders where purchase_order = 'AKDN-80183'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-09'::date, '113-1006771-2006138', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-06-23'::date, 'UPS Demo', 'DEMO00018401', '2026-06-15'::date, 'RCPT-073198', '2026-06-23'::date, '2026-06-16'::date, 'NX-041198-26',
  '2026-06-24'::date, '2026-06-26'::date, '2026-06-30'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80183' and oi.sequential = '10' and oi.material = '225-598'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8c867880-0a30-4e91-aa41-fc3dce844d58'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80183' and oi.sequential = '10' and oi.material = '225-598'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'cc9c1c34-f9d9-4ead-b191-515e01d47fe5'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80183' and oi.sequential = '10' and oi.material = '225-598'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7366665d-a5f7-47d3-8cc0-af9a9befe64b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80183' and oi.sequential = '10' and oi.material = '225-598'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6aac4a0e-155b-4be8-89bf-f38cb749c040'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80183' and oi.sequential = '10' and oi.material = '225-598'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '27721653-4649-4ee5-8723-0075b21b3ebc'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80183' and oi.sequential = '10' and oi.material = '225-598'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-615', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000200', 'SUP-542189', 'B08222WKNC', 1, 'EA', 390.94, 82.13, 82.13
from public.orders where purchase_order = 'AKDN-80184'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-11'::date, '113-1006808-2006169', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-06-27'::date, 'FedEx Demo', 'DEMO00018501', '2026-06-17'::date, 'RCPT-073199', '2026-06-27'::date, '2026-06-19'::date, 'NX-041199-26',
  '2026-06-29'::date, '2026-06-30'::date, '2026-07-01'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80184' and oi.sequential = '10' and oi.material = '225-615'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2f9a14bc-4e8d-4d7e-b0c6-a341aab4818d'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80184' and oi.sequential = '10' and oi.material = '225-615'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0442b823-f5c0-4be1-abad-0f4002c75136'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80184' and oi.sequential = '10' and oi.material = '225-615'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '79f3e877-c363-40ef-add7-964b34018c75'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80184' and oi.sequential = '10' and oi.material = '225-615'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c58a859b-144d-46f2-aab0-453721a3878a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80184' and oi.sequential = '10' and oi.material = '225-615'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0fcd4a49-0a25-45d1-b06c-9f9694b6b803'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80184' and oi.sequential = '10' and oi.material = '225-615'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-632', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000201', 'SUP-542200', 'B09ZNAEW3K', 1, 'EA', 402.6, 82.5, 82.5
from public.orders where purchase_order = 'AKDN-80185'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-12'::date, '113-1006845-2006200', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-06-25'::date, 'Global Parcel Demo', 'DEMO00018601', '2026-06-18'::date, 'RCPT-073200', '2026-06-25'::date, '2026-06-21'::date, 'NX-041200-26',
  '2026-06-28'::date, '2026-06-30'::date, '2026-07-02'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80185' and oi.sequential = '10' and oi.material = '225-632'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b5d16b53-e87f-42ce-9aaf-2d87ee743de5'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80185' and oi.sequential = '10' and oi.material = '225-632'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0f01b8e1-08a8-4793-9b56-dd82e7c521f8'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80185' and oi.sequential = '10' and oi.material = '225-632'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '71d3f41a-8078-492a-b833-8221132c01e7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80185' and oi.sequential = '10' and oi.material = '225-632'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '549d7f2f-e8bd-4ff0-9f06-e2624480ee1d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80185' and oi.sequential = '10' and oi.material = '225-632'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c8c74226-3000-472a-936e-f54bdbdd72d5'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80185' and oi.sequential = '10' and oi.material = '225-632'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-649', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000202', 'SUP-542211', 'B0AZAHW9GS', 2, 'EA', 828.7, 82.87, 165.74
from public.orders where purchase_order = 'AKDN-80186'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-11'::date, '113-1006882-2006231', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-06-26'::date, 'UPS Demo', 'DEMO00018701', '2026-06-20'::date, 'RCPT-073201', '2026-06-26'::date, '2026-06-21'::date, 'NX-041201-26',
  '2026-06-27'::date, '2026-06-28'::date, '2026-07-01'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80186' and oi.sequential = '10' and oi.material = '225-649'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '46f24f3b-d0ad-4206-aa75-00331ad2039d'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80186' and oi.sequential = '10' and oi.material = '225-649'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'bb3981c1-d1b8-4df6-afcc-8b55e205a737'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80186' and oi.sequential = '10' and oi.material = '225-649'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '23ab2d8b-9e56-4d28-90b0-24e896e61020'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80186' and oi.sequential = '10' and oi.material = '225-649'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7edf80d7-8c9a-49b7-b4ca-d7b0e472ed10'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80186' and oi.sequential = '10' and oi.material = '225-649'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6225ae70-96e0-42fa-a39b-8f603b604549'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80186' and oi.sequential = '10' and oi.material = '225-649'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-666', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000203', 'SUP-542222', 'B0BYWRELVZ', 1, 'EA', 426.19, 83.24, 83.24
from public.orders where purchase_order = 'AKDN-80187'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-13'::date, '113-1006919-2006262', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-06-30'::date, 'FedEx Demo', 'DEMO00018801', '2026-06-22'::date, 'RCPT-073202', '2026-06-30'::date, '2026-06-24'::date, 'NX-041202-26',
  '2026-07-02'::date, '2026-07-04'::date, '2026-07-08'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80187' and oi.sequential = '10' and oi.material = '225-666'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '725cfde7-a7e5-4689-8938-7db1447b5d63'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80187' and oi.sequential = '10' and oi.material = '225-666'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '98a2c406-be60-4019-bbac-08c18eb88069'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-07-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80187' and oi.sequential = '10' and oi.material = '225-666'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0e07389a-ecc7-48f4-897c-673df628f54b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80187' and oi.sequential = '10' and oi.material = '225-666'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ca03e6a0-a7a1-4c6c-909c-c44e3f249ca3'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80187' and oi.sequential = '10' and oi.material = '225-666'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c76262a1-6e29-4b7e-a82e-4978ea9a0bbb'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80187' and oi.sequential = '10' and oi.material = '225-666'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-683', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000204', 'SUP-542233', 'B0DXJZXXA8', 1, 'EA', 367.88, 83.61, 83.61
from public.orders where purchase_order = 'AKDN-80188'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-15'::date, '113-1006956-2006293', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-07-04'::date, 'Global Parcel Demo', 'DEMO00018901', '2026-06-24'::date, 'RCPT-073203', '2026-07-04'::date, '2026-06-27'::date, 'NX-041203-26',
  '2026-07-07'::date, '2026-07-08'::date, '2026-07-09'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80188' and oi.sequential = '10' and oi.material = '225-683'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9d0355d0-e97c-4100-a52e-eaae707294fc'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80188' and oi.sequential = '10' and oi.material = '225-683'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dddbb9ee-8ffe-463c-bb9c-946f928b6d87'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-07-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80188' and oi.sequential = '10' and oi.material = '225-683'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b20ba059-259c-4213-94db-d79e355ded21'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80188' and oi.sequential = '10' and oi.material = '225-683'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '424624d8-7a2a-46c2-8bf8-4b1ce6da5371'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80188' and oi.sequential = '10' and oi.material = '225-683'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '577b79df-d58a-4636-82bb-6459b5a6a8aa'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80188' and oi.sequential = '10' and oi.material = '225-683'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-700', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000205', 'SUP-542244', 'B0EX69FAPF', 2, 'EA', 759.18, 83.98, 167.96
from public.orders where purchase_order = 'AKDN-80189'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-14'::date, '113-1006993-2006324', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-06-28'::date, 'UPS Demo', 'DEMO00019001', '2026-06-19'::date, 'RCPT-073204', '2026-06-28'::date, '2026-06-20'::date, 'NX-041204-26',
  '2026-06-29'::date, '2026-07-01'::date, '2026-07-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80189' and oi.sequential = '10' and oi.material = '225-700'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '56cf3850-0bd4-4c62-905f-73601dfe47f1'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80189' and oi.sequential = '10' and oi.material = '225-700'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3b249a7d-f0a6-447a-8d63-d7d6147c5663'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-07-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80189' and oi.sequential = '10' and oi.material = '225-700'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c4949d89-c80a-4a8f-8779-67401e319a57'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80189' and oi.sequential = '10' and oi.material = '225-700'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f7adb3dc-b8a1-4e74-9adf-aa5dc4a4b418'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80189' and oi.sequential = '10' and oi.material = '225-700'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8abc3143-55e0-4604-bbd7-f192a41da5b1'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80189' and oi.sequential = '10' and oi.material = '225-700'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-717', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000206', 'SUP-542255', 'B0FWSGXN4M', 1, 'EA', 391.38, 84.35, 84.35
from public.orders where purchase_order = 'AKDN-80190'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-16'::date, '113-1007030-2006355', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-06-27'::date, 'FedEx Demo', 'DEMO00019101', '2026-06-21'::date, 'RCPT-073205', '2026-06-27'::date, '2026-06-23'::date, 'NX-041205-26',
  '2026-06-29'::date, '2026-06-30'::date, '2026-07-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80190' and oi.sequential = '10' and oi.material = '225-717'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5b9c951f-48be-4b7d-862b-5d1d43b83151'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80190' and oi.sequential = '10' and oi.material = '225-717'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '364becd7-52e9-43f9-806e-e86431e7a064'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80190' and oi.sequential = '10' and oi.material = '225-717'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f6a483fb-d863-4c59-867f-3961c505dc35'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80190' and oi.sequential = '10' and oi.material = '225-717'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '799fdea5-1c5a-4ad8-8e8c-18b3917c564c'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80190' and oi.sequential = '10' and oi.material = '225-717'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f0c5d68e-8cfd-40a2-9999-e0c01346c286'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80190' and oi.sequential = '10' and oi.material = '225-717'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-734', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000207', 'SUP-542266', 'B0GVEQFZHU', 1, 'EA', 403.27, 84.72, 84.72
from public.orders where purchase_order = 'AKDN-80191'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-18'::date, '113-1007067-2006386', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-07-01'::date, 'Global Parcel Demo', 'DEMO00019201', '2026-06-23'::date, 'RCPT-073206', '2026-07-01'::date, '2026-06-26'::date, 'NX-041206-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80191' and oi.sequential = '10' and oi.material = '225-734'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c547b337-f207-47b5-9bf4-4a627bc98d41'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80191' and oi.sequential = '10' and oi.material = '225-734'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'eded61bf-8037-4368-b3f4-e03104fba2d3'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80191' and oi.sequential = '10' and oi.material = '225-734'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '14328c77-ad6f-41ab-b1ba-7ca0fd3bc4dd'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80191' and oi.sequential = '10' and oi.material = '225-734'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-751', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000208', 'SUP-542277', 'B0HV2YYCW3', 2, 'EA', 830.48, 85.09, 170.18
from public.orders where purchase_order = 'AKDN-80192'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-16'::date, '113-1007104-2006417', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-07-01'::date, 'UPS Demo', 'DEMO00019301', '2026-06-24'::date, 'RCPT-073207', '2026-07-01'::date, '2026-06-25'::date, 'NX-041207-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80192' and oi.sequential = '10' and oi.material = '225-751'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6d6785e2-7970-4ec2-8431-adcfead58dd6'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80192' and oi.sequential = '10' and oi.material = '225-751'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3edd6a57-4c9b-4e4d-b23c-b1a15f29d9a7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80192' and oi.sequential = '10' and oi.material = '225-751'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '10c24e07-515b-4181-9a22-1ce2a8c10e32'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80192' and oi.sequential = '10' and oi.material = '225-751'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-768', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000209', 'SUP-542288', 'B0KUP7GPCA', 1, 'EA', 427.3, 85.46, 85.46
from public.orders where purchase_order = 'AKDN-80193'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-18'::date, '113-1007141-2006448', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-07-05'::date, 'FedEx Demo', 'DEMO00019401', '2026-06-26'::date, 'RCPT-073208', '2026-07-05'::date, '2026-06-28'::date, 'NX-041208-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80193' and oi.sequential = '10' and oi.material = '225-768'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4b8e3920-aa4b-41ec-a91d-517c0cf04b6f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80193' and oi.sequential = '10' and oi.material = '225-768'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e96924f1-66e2-4abc-b4b2-1f84037f7126'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80193' and oi.sequential = '10' and oi.material = '225-768'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7735f116-6d94-499b-a740-3a8346f0be59'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80193' and oi.sequential = '10' and oi.material = '225-768'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-785', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000210', 'SUP-542299', 'B0LUBFY2RH', 1, 'EA', 439.45, 85.83, 85.83
from public.orders where purchase_order = 'AKDN-80194'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-20'::date, '113-1007178-2006479', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-07-09'::date, 'Global Parcel Demo', 'DEMO00019501', '2026-06-28'::date, 'RCPT-073209', '2026-07-09'::date, '2026-07-01'::date, 'NX-041209-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80194' and oi.sequential = '10' and oi.material = '225-785'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '49c6b472-1ab1-4c91-9d1f-c9075527f118'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80194' and oi.sequential = '10' and oi.material = '225-785'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '09792c4e-7829-44a4-8e98-eafd86035f5e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-07-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80194' and oi.sequential = '10' and oi.material = '225-785'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd4b2b6c3-631a-4a2e-b99a-67bd929c8e60'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80194' and oi.sequential = '10' and oi.material = '225-785'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-802', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000211', 'SUP-542310', 'B0MTXPGD6Q', 2, 'EA', 758.56, 86.2, 172.4
from public.orders where purchase_order = 'AKDN-80195'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-19'::date, '113-1007215-2006510', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-07-05'::date, 'UPS Demo', 'DEMO00019601', '2026-06-30'::date, 'RCPT-073210', '2026-07-05'::date, '2026-07-01'::date, 'NX-041210-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80195' and oi.sequential = '10' and oi.material = '225-802'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a6e97d8b-3286-49c4-9bfe-b0197b6951f7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80195' and oi.sequential = '10' and oi.material = '225-802'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7cc791d1-8419-4faf-9e20-a479c627d2c8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-07-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80195' and oi.sequential = '10' and oi.material = '225-802'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '523aac76-eb1e-44dd-abdd-e547bc21cdd2'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80195' and oi.sequential = '10' and oi.material = '225-802'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-819', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000212', 'SUP-542321', 'B0NSKWYQKW', 1, 'EA', 391.3, 86.57, 86.57
from public.orders where purchase_order = 'AKDN-80196'
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
where o.purchase_order = 'AKDN-80196' and oi.sequential = '10' and oi.material = '225-819'
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
) select id, '10', '225-836', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000213', 'SUP-542332', 'B0PS76H4Y5', 1, 'EA', 403.4, 86.94, 86.94
from public.orders where purchase_order = 'AKDN-80197'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-23'::date, '113-1007289-2006572', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80197' and oi.sequential = '10' and oi.material = '225-836'
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
) select id, '10', '225-853', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000214', 'SUP-542343', 'B0QRTEZFDC', 2, 'EA', 831.19, 87.31, 174.62
from public.orders where purchase_order = 'AKDN-80198'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-22'::date, '113-1007326-2006603', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80198' and oi.sequential = '10' and oi.material = '225-853'
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
) select id, '10', '225-870', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000215', 'SUP-542354', 'B0SQFMHSSK', 1, 'EA', 427.88, 87.68, 87.68
from public.orders where purchase_order = 'AKDN-80199'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-23'::date, '113-1007363-2006634', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80199' and oi.sequential = '10' and oi.material = '225-870'
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
) select id, '10', '225-887', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000216', 'SUP-542365', 'B0TQ3VZ57S', 1, 'EA', 440.25, 88.05, 88.05
from public.orders where purchase_order = 'AKDN-80200'
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
where o.purchase_order = 'AKDN-80200' and oi.sequential = '10' and oi.material = '225-887'
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
) select id, '10', '225-904', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000217', 'SUP-542376', 'B0UPP5JGLZ', 2, 'EA', 905.42, 88.42, 176.84
from public.orders where purchase_order = 'AKDN-80201'
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
where o.purchase_order = 'AKDN-80201' and oi.sequential = '10' and oi.material = '225-904'
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
) select id, '10', '225-921', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000218', 'SUP-542387', 'B0VPCC2TZ7', 1, 'EA', 390.68, 88.79, 88.79
from public.orders where purchase_order = 'AKDN-80202'
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
where o.purchase_order = 'AKDN-80202' and oi.sequential = '10' and oi.material = '225-921'
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
) select id, '10', '225-938', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000219', 'SUP-542398', 'B0WNYLJ7EE', 1, 'EA', 403, 89.16, 89.16
from public.orders where purchase_order = 'AKDN-80203'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-28'::date, '113-1007511-2006758', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-07-11'::date, 'Global Parcel Demo', 'DEMO00020401', '2026-07-01'::date, 'RCPT-073218', '2026-07-11'::date, '2026-07-04'::date, 'NX-041218-26',
  '2026-07-14'::date, '2026-07-16'::date, '2026-07-20'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80203' and oi.sequential = '10' and oi.material = '225-938'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '300e6f80-96b4-4f20-b73c-a023dfdee257'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80203' and oi.sequential = '10' and oi.material = '225-938'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dfe2bf02-3d7d-464c-a5c1-b6a5a48885f0'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-07-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80203' and oi.sequential = '10' and oi.material = '225-938'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '485324fa-1b10-4fb7-a33c-f7a58b5640c3'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80203' and oi.sequential = '10' and oi.material = '225-938'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2432e725-c7ea-4116-bfb4-305a717067b7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-07-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80203' and oi.sequential = '10' and oi.material = '225-938'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5565040f-fab2-4589-982d-e30d576fcf95'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-07-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80203' and oi.sequential = '10' and oi.material = '225-938'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-955', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000220', 'SUP-542409', 'B0YMLU2JUM', 2, 'EA', 830.84, 89.53, 179.06
from public.orders where purchase_order = 'AKDN-80204'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-27'::date, '113-1007548-2006789', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-07-12'::date, 'UPS Demo', 'DEMO00020501', '2026-07-03'::date, 'RCPT-073219', '2026-07-12'::date, '2026-07-04'::date, 'NX-041219-26',
  '2026-07-13'::date, '2026-07-14'::date, '2026-07-15'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80204' and oi.sequential = '10' and oi.material = '225-955'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f153f79a-3275-4281-b8f8-b1c7f65747ca'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80204' and oi.sequential = '10' and oi.material = '225-955'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b0e8f019-3c6a-4fb8-8adb-7069d6e2b4c1'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-07-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80204' and oi.sequential = '10' and oi.material = '225-955'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7c6abbdb-477a-46d7-809f-040bda0e2db1'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80204' and oi.sequential = '10' and oi.material = '225-955'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '501dfd01-1b6e-4129-a41a-d980734a765d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-07-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80204' and oi.sequential = '10' and oi.material = '225-955'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b3bb1f46-10bd-4b1e-b1dc-c92ebddf60fd'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-07-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80204' and oi.sequential = '10' and oi.material = '225-955'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-972', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000221', 'SUP-542420', 'B0ZM83KV9U', 1, 'EA', 427.92, 89.9, 89.9
from public.orders where purchase_order = 'AKDN-80205'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-28'::date, '113-1007585-2006820', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-07-10'::date, 'FedEx Demo', 'DEMO00020601', '2026-07-04'::date, 'RCPT-073220', '2026-07-10'::date, '2026-07-06'::date, 'NX-041220-26',
  '2026-07-12'::date, '2026-07-14'::date, '2026-07-16'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80205' and oi.sequential = '10' and oi.material = '225-972'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'db4243a7-32bf-462c-9523-30a845111895'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80205' and oi.sequential = '10' and oi.material = '225-972'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ce46aaad-aa1f-4ee6-a9d4-b2d6149cb9ba'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-07-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80205' and oi.sequential = '10' and oi.material = '225-972'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '74d5e07b-abeb-457c-826a-1e7944f3ce3a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80205' and oi.sequential = '10' and oi.material = '225-972'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ebf63bd4-c339-4884-abec-88dbf2e34342'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-07-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80205' and oi.sequential = '10' and oi.material = '225-972'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '15b7bda0-7d6f-4dae-b87a-695da965ac8c'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-07-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80205' and oi.sequential = '10' and oi.material = '225-972'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-989', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000222', 'SUP-542431', 'B02LUB38N3', 1, 'EA', 440.52, 90.27, 90.27
from public.orders where purchase_order = 'AKDN-80206'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-30'::date, '113-1007622-2006851', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-07-14'::date, 'Global Parcel Demo', 'DEMO00020701', '2026-07-06'::date, 'RCPT-073221', '2026-07-14'::date, '2026-07-09'::date, 'NX-041221-26',
  '2026-07-17'::date, '2026-07-18'::date, '2026-07-21'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80206' and oi.sequential = '10' and oi.material = '225-989'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '52d8f9ca-1b01-4024-b61b-0bbe635b8825'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80206' and oi.sequential = '10' and oi.material = '225-989'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1da2a299-578d-48c6-aa87-9f27dfd6b1cd'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-07-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80206' and oi.sequential = '10' and oi.material = '225-989'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '661144c9-50ce-44fb-ab82-a1b1277c1f1e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80206' and oi.sequential = '10' and oi.material = '225-989'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4028cdd8-3dbb-498b-8290-f84100dcd397'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-07-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80206' and oi.sequential = '10' and oi.material = '225-989'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '93963b87-7b84-46e5-b646-642697981ad6'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-07-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80206' and oi.sequential = '10' and oi.material = '225-989'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-006', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000223', 'SUP-542442', 'B03KGKKK39', 2, 'EA', 906.4, 90.64, 181.28
from public.orders where purchase_order = 'AKDN-80207'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-06-29'::date, '113-1007659-2006882', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-07-15'::date, 'UPS Demo', 'DEMO00020801', '2026-07-08'::date, 'RCPT-073222', '2026-07-15'::date, '2026-07-09'::date, 'NX-041222-26',
  '2026-07-16'::date, '2026-07-18'::date, '2026-07-22'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80207' and oi.sequential = '10' and oi.material = '226-006'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '566370a4-6667-45e7-b0f3-d2aa8ea6ca02'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-07-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80207' and oi.sequential = '10' and oi.material = '226-006'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd6b5da9f-73b1-4aa8-9270-93414b513b8a'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-07-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80207' and oi.sequential = '10' and oi.material = '226-006'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1afd5409-3bfe-443f-b747-83b9b3e1bc79'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-07-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80207' and oi.sequential = '10' and oi.material = '226-006'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

commit;
