-- Demo seed part 09 of 10. Run files in numeric order.
begin;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '51982437-3b59-4ae2-b591-46f95bdb44c4'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80249' and oi.sequential = '10' and oi.material = '226-720'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-737', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000266', 'SUP-542915', 'B0NQHUEKNF', 1, 'EA', 120.58, 23.55, 23.55
from public.orders where purchase_order = 'AKDN-80250'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-06'::date, '113-1009250-2008215', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-08-21'::date, 'FedEx Demo', 'DEMO00025101', '2026-08-15'::date, 'RCPT-073265', '2026-08-21'::date, '2026-08-17'::date, 'NX-041265-26',
  '2026-08-23'::date, '2026-08-24'::date, '2026-08-27'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80250' and oi.sequential = '10' and oi.material = '226-737'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '744cabf1-ebb2-484a-9725-3f6e8edc9f6e'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-08-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80250' and oi.sequential = '10' and oi.material = '226-737'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f6a2a211-936c-4498-9bfd-47d068020a2c'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-08-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80250' and oi.sequential = '10' and oi.material = '226-737'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9dded471-0bc7-4564-b2f3-b15a84c4a844'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-08-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80250' and oi.sequential = '10' and oi.material = '226-737'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e6580edd-4def-4d6c-a2e6-e195a2207ec3'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80250' and oi.sequential = '10' and oi.material = '226-737'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b0f50a1d-3a7f-46b0-ae17-60c3f1aa8968'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80250' and oi.sequential = '10' and oi.material = '226-737'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-754', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000267', 'SUP-542926', 'B0PQ54WW3N', 1, 'EA', 105.25, 23.92, 23.92
from public.orders where purchase_order = 'AKDN-80251'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-07'::date, '113-1009287-2008246', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-08-24'::date, 'Global Parcel Demo', 'DEMO00025201', '2026-08-16'::date, 'RCPT-073266', '2026-08-24'::date, '2026-08-19'::date, 'NX-041266-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80251' and oi.sequential = '10' and oi.material = '226-754'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a3c4c93b-9a9b-4066-9de4-246eb90cfe98'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-08-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80251' and oi.sequential = '10' and oi.material = '226-754'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '228afbe9-188b-4ab7-9edd-2ed4da001f00'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80251' and oi.sequential = '10' and oi.material = '226-754'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '80c265f7-2a91-4f77-a92a-04689e43f15f'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80251' and oi.sequential = '10' and oi.material = '226-754'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-771', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000268', 'SUP-542937', 'B0QPRCE9GV', 2, 'EA', 219.58, 24.29, 48.58
from public.orders where purchase_order = 'AKDN-80252'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-06'::date, '113-1009324-2008277', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-08-18'::date, 'UPS Demo', 'DEMO00025301', '2026-08-11'::date, 'RCPT-073267', '2026-08-18'::date, '2026-08-12'::date, 'NX-041267-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80252' and oi.sequential = '10' and oi.material = '226-771'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a4b0acb4-218f-4444-86cb-512d94949faf'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-08-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80252' and oi.sequential = '10' and oi.material = '226-771'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '16051ad0-1665-4015-8072-bf580cb32e19'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80252' and oi.sequential = '10' and oi.material = '226-771'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8c373f11-39f1-470c-8e24-154938052f0d'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80252' and oi.sequential = '10' and oi.material = '226-771'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-788', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000269', 'SUP-542948', 'B0RPDKWLV4', 1, 'EA', 114.42, 24.66, 24.66
from public.orders where purchase_order = 'AKDN-80253'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-08'::date, '113-1009361-2008308', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-08-22'::date, 'FedEx Demo', 'DEMO00025401', '2026-08-13'::date, 'RCPT-073268', '2026-08-22'::date, '2026-08-15'::date, 'NX-041268-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80253' and oi.sequential = '10' and oi.material = '226-788'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dee362da-f85b-4ee5-9460-0650de2898ae'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-08-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80253' and oi.sequential = '10' and oi.material = '226-788'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3a5190af-12b5-48ce-ae84-8bfd4f5b0ed9'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80253' and oi.sequential = '10' and oi.material = '226-788'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8de8dd04-d2ed-4c13-8c73-8c513a6dc9fe'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80253' and oi.sequential = '10' and oi.material = '226-788'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-805', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000270', 'SUP-542959', 'B0SNZTEXAA', 1, 'EA', 119.14, 25.03, 25.03
from public.orders where purchase_order = 'AKDN-80254'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-10'::date, '113-1009398-2008339', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-08-26'::date, 'Global Parcel Demo', 'DEMO00025501', '2026-08-15'::date, 'RCPT-073269', '2026-08-26'::date, '2026-08-18'::date, 'NX-041269-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80254' and oi.sequential = '10' and oi.material = '226-805'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7d37b081-9f55-4648-98ca-f1b2a3711aba'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-08-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80254' and oi.sequential = '10' and oi.material = '226-805'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '89c4a721-a0fc-4ac5-805f-5be2f5b6ca82'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80254' and oi.sequential = '10' and oi.material = '226-805'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ac7749d7-a166-42d7-b62e-ace3b5841b63'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80254' and oi.sequential = '10' and oi.material = '226-805'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-822', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000271', 'SUP-542970', 'B0UMM3XAPH', 2, 'EA', 247.9, 25.4, 50.8
from public.orders where purchase_order = 'AKDN-80255'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-09'::date, '113-1009435-2008370', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-08-22'::date, 'UPS Demo', 'DEMO00025601', '2026-08-17'::date, 'RCPT-073270', '2026-08-22'::date, '2026-08-18'::date, 'NX-041270-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80255' and oi.sequential = '10' and oi.material = '226-822'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '496b76bd-eb1e-4c39-9b8e-1ee8ad7599b5'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-08-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80255' and oi.sequential = '10' and oi.material = '226-822'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '356ed5ed-1985-4770-8c09-d3c2cdfe4c5f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80255' and oi.sequential = '10' and oi.material = '226-822'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3c48e17a-6314-4e5e-ac8f-b4f6a0f19e0f'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80255' and oi.sequential = '10' and oi.material = '226-822'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-839', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000272', 'SUP-542981', 'B0VMAAFN4Q', 1, 'EA', 128.85, 25.77, 25.77
from public.orders where purchase_order = 'AKDN-80256'
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
where o.purchase_order = 'AKDN-80256' and oi.sequential = '10' and oi.material = '226-839'
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
) select id, '10', '226-856', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000273', 'SUP-542992', 'B0WLWJXZJX', 1, 'EA', 133.84, 26.14, 26.14
from public.orders where purchase_order = 'AKDN-80257'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-13'::date, '113-1009509-2008432', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80257' and oi.sequential = '10' and oi.material = '226-856'
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
) select id, '10', '226-873', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000274', 'SUP-543003', 'B0XKJSFCX6', 2, 'EA', 233.29, 26.51, 53.02
from public.orders where purchase_order = 'AKDN-80258'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-11'::date, '113-1009546-2008463', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80258' and oi.sequential = '10' and oi.material = '226-873'
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
) select id, '10', '226-890', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000275', 'SUP-543014', 'B0YK6ZYPCD', 1, 'EA', 121.5, 26.88, 26.88
from public.orders where purchase_order = 'AKDN-80259'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-13'::date, '113-1009583-2008494', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80259' and oi.sequential = '10' and oi.material = '226-890'
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
) select id, '10', '226-907', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000276', 'SUP-543025', 'B0ZJS9G2RK', 1, 'EA', 126.44, 27.25, 27.25
from public.orders where purchase_order = 'AKDN-80260'
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
where o.purchase_order = 'AKDN-80260' and oi.sequential = '10' and oi.material = '226-907'
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
) select id, '10', '226-924', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000277', 'SUP-543036', 'B03HEHYD6S', 2, 'EA', 262.94, 27.62, 55.24
from public.orders where purchase_order = 'AKDN-80261'
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
where o.purchase_order = 'AKDN-80261' and oi.sequential = '10' and oi.material = '226-924'
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
) select id, '10', '226-941', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000278', 'SUP-543047', 'B04H2QGRKZ', 1, 'EA', 136.59, 27.99, 27.99
from public.orders where purchase_order = 'AKDN-80262'
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
where o.purchase_order = 'AKDN-80262' and oi.sequential = '10' and oi.material = '226-941'
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
) select id, '10', '226-958', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000279', 'SUP-543058', 'B05GNYZ4Y8', 1, 'EA', 141.8, 28.36, 28.36
from public.orders where purchase_order = 'AKDN-80263'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-18'::date, '113-1009731-2008618', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-09-03'::date, 'Global Parcel Demo', 'DEMO00026401', '2026-08-25'::date, 'RCPT-073278', '2026-09-03'::date, '2026-08-28'::date, 'NX-041278-26',
  '2026-09-03'::date, '2026-09-03'::date, '2026-09-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80263' and oi.sequential = '10' and oi.material = '226-958'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4e326b19-72d0-4938-8f4c-24120272d4d7'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80263' and oi.sequential = '10' and oi.material = '226-958'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'cd23a7a8-fdb3-4182-957d-84a427fbd43e'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80263' and oi.sequential = '10' and oi.material = '226-958'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e86a5486-29ae-4a2f-ac54-89bc72efa934'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80263' and oi.sequential = '10' and oi.material = '226-958'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e02972fc-c90c-479c-a807-999156b7f841'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80263' and oi.sequential = '10' and oi.material = '226-958'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1011b35f-2880-412f-a9be-658cb937a2f5'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80263' and oi.sequential = '10' and oi.material = '226-958'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-975', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000280', 'SUP-543069', 'B06GA8HFDF', 2, 'EA', 294.2, 28.73, 57.46
from public.orders where purchase_order = 'AKDN-80264'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-17'::date, '113-1009768-2008649', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-09-03'::date, 'UPS Demo', 'DEMO00026501', '2026-08-27'::date, 'RCPT-073279', '2026-09-03'::date, '2026-08-28'::date, 'NX-041279-26',
  '2026-09-03'::date, '2026-09-03'::date, '2026-09-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80264' and oi.sequential = '10' and oi.material = '226-975'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '19362b5d-8a96-4db6-ae4e-59c4e09f98aa'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80264' and oi.sequential = '10' and oi.material = '226-975'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5930b440-0815-4416-a4d2-4a012ad1dec4'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80264' and oi.sequential = '10' and oi.material = '226-975'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '838b95c8-362c-4674-8959-ac5fc2b7818b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80264' and oi.sequential = '10' and oi.material = '226-975'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f2855c97-d8be-4f75-bb6c-4976849e3935'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80264' and oi.sequential = '10' and oi.material = '226-975'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0a99f107-d829-4ad1-a267-f5c631f1bf3a'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80264' and oi.sequential = '10' and oi.material = '226-975'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '226-992', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000281', 'SUP-543080', 'B07FXFZSSN', 1, 'EA', 128.04, 29.1, 29.1
from public.orders where purchase_order = 'AKDN-80265'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-18'::date, '113-1009805-2008680', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-09-03'::date, 'FedEx Demo', 'DEMO00026601', '2026-08-28'::date, 'RCPT-073280', '2026-09-03'::date, '2026-08-30'::date, 'NX-041280-26',
  '2026-09-03'::date, '2026-09-03'::date, '2026-09-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80265' and oi.sequential = '10' and oi.material = '226-992'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd7b4e4a9-4769-4a52-bc06-dab08eb2e911'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80265' and oi.sequential = '10' and oi.material = '226-992'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '88501d3d-65eb-4f78-810e-af67bc586d51'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80265' and oi.sequential = '10' and oi.material = '226-992'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1490aede-6f4e-4144-b249-a3df429865b8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80265' and oi.sequential = '10' and oi.material = '226-992'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '11aecb4c-b013-4324-a43e-e373c70a35d3'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80265' and oi.sequential = '10' and oi.material = '226-992'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '454b81b6-73a0-4aa7-9e43-f7e0564b948a'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80265' and oi.sequential = '10' and oi.material = '226-992'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-009', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000282', 'SUP-543091', 'B09EKPH57U', 1, 'EA', 133.2, 29.47, 29.47
from public.orders where purchase_order = 'AKDN-80266'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-20'::date, '113-1009842-2008711', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-08-31'::date, 'Global Parcel Demo', 'DEMO00026701', '2026-08-23'::date, 'RCPT-073281', '2026-08-31'::date, '2026-08-26'::date, 'NX-041281-26',
  '2026-09-03'::date, '2026-09-03'::date, '2026-09-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80266' and oi.sequential = '10' and oi.material = '227-009'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '67021446-374c-4503-8168-8bdd82a8067b'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80266' and oi.sequential = '10' and oi.material = '227-009'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9907e051-7cd2-4811-b2da-cddc4606f617'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80266' and oi.sequential = '10' and oi.material = '227-009'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'df0ee2fd-eeed-4ed2-a553-19c13d27f726'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-08-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80266' and oi.sequential = '10' and oi.material = '227-009'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8743e644-5833-43e2-a870-ca33eb926da8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80266' and oi.sequential = '10' and oi.material = '227-009'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8accf7bc-7fd8-4011-abe3-93774afb4482'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80266' and oi.sequential = '10' and oi.material = '227-009'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-026', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000283', 'SUP-543102', 'B0AE7X2GL3', 2, 'EA', 276.92, 29.84, 59.68
from public.orders where purchase_order = 'AKDN-80267'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-19'::date, '113-1009879-2008742', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-09-01'::date, 'UPS Demo', 'DEMO00026801', '2026-08-25'::date, 'RCPT-073282', '2026-09-01'::date, '2026-08-26'::date, 'NX-041282-26',
  '2026-09-02'::date, '2026-09-03'::date, '2026-09-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80267' and oi.sequential = '10' and oi.material = '227-026'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '34e36288-c8f9-4d5f-952a-d26ffa088b1e'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80267' and oi.sequential = '10' and oi.material = '227-026'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2066b883-4a6d-44eb-97fb-3280b0d81bac'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80267' and oi.sequential = '10' and oi.material = '227-026'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '09ecb838-22ff-4c27-ad8e-3562df8ec5f0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80267' and oi.sequential = '10' and oi.material = '227-026'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b9885265-0b2b-4d98-90b1-840159fd5bd8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80267' and oi.sequential = '10' and oi.material = '227-026'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1c12792b-0e63-428e-a060-38af603f99b9'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80267' and oi.sequential = '10' and oi.material = '227-026'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-043', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000284', 'SUP-543113', 'B0BDT6JT2A', 1, 'EA', 143.8, 30.21, 30.21
from public.orders where purchase_order = 'AKDN-80268'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-21'::date, '113-1009916-2008773', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-09-03'::date, 'FedEx Demo', 'DEMO00026901', '2026-08-27'::date, 'RCPT-073283', '2026-09-03'::date, '2026-08-29'::date, 'NX-041283-26',
  '2026-09-03'::date, '2026-09-03'::date, '2026-09-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80268' and oi.sequential = '10' and oi.material = '227-043'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '86e0760d-f3a9-4b24-b82d-23498cc60439'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80268' and oi.sequential = '10' and oi.material = '227-043'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a657c97e-594f-49ae-a9a9-79965c3ab51e'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80268' and oi.sequential = '10' and oi.material = '227-043'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a178fda8-98b8-4eaa-8c23-c6472d6403b0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80268' and oi.sequential = '10' and oi.material = '227-043'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9908fbd2-905c-40b6-80f6-f325ddaf0502'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80268' and oi.sequential = '10' and oi.material = '227-043'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '223d39c4-d8b6-4e73-952a-c91bf4e78da6'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80268' and oi.sequential = '10' and oi.material = '227-043'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-060', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000285', 'SUP-543124', 'B0CCFE27FH', 1, 'EA', 149.23, 30.58, 30.58
from public.orders where purchase_order = 'AKDN-80269'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-23'::date, '113-1009953-2008804', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-09-03'::date, 'Global Parcel Demo', 'DEMO00027001', '2026-08-29'::date, 'RCPT-073284', '2026-09-03'::date, '2026-09-01'::date, 'NX-041284-26',
  '2026-09-03'::date, '2026-09-03'::date, '2026-09-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80269' and oi.sequential = '10' and oi.material = '227-060'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '71786be2-4eb5-465b-8956-984bae22c564'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80269' and oi.sequential = '10' and oi.material = '227-060'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7696c37c-79b1-4c79-b26a-8542da54e121'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80269' and oi.sequential = '10' and oi.material = '227-060'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '63c7d7f9-07c4-4b7d-9e14-ca7794e365a3'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80269' and oi.sequential = '10' and oi.material = '227-060'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '32aa2bd9-b079-454e-869d-68f2a03fa327'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-09-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80269' and oi.sequential = '10' and oi.material = '227-060'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b9ba2933-e7a9-4e82-9210-4746f70948c8'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80269' and oi.sequential = '10' and oi.material = '227-060'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-077', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000286', 'SUP-543135', 'B0DC3NJJUQ', 2, 'EA', 309.5, 30.95, 61.9
from public.orders where purchase_order = 'AKDN-80270'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-22'::date, '113-1009990-2008835', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-09-03'::date, 'UPS Demo', 'DEMO00027101', '2026-08-31'::date, 'RCPT-073285', '2026-09-03'::date, '2026-09-01'::date, 'NX-041285-26',
  '2026-09-03'::date, '2026-09-03'::date, '2026-09-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80270' and oi.sequential = '10' and oi.material = '227-077'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2b565ec4-55fe-4111-a824-951111b33303'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80270' and oi.sequential = '10' and oi.material = '227-077'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '67dde1a5-2828-4a0b-ae55-48c46de24521'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80270' and oi.sequential = '10' and oi.material = '227-077'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '77ced10d-3025-49ce-90bf-94e0b1aa304f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80270' and oi.sequential = '10' and oi.material = '227-077'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ddc74873-550c-431b-a638-1f65290874c1'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-09-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80270' and oi.sequential = '10' and oi.material = '227-077'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8cf3009c-1d76-4150-b19d-1b378f9090e5'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80270' and oi.sequential = '10' and oi.material = '227-077'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-094', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000287', 'SUP-543146', 'B0EBPV3V9X', 1, 'EA', 160.36, 31.32, 31.32
from public.orders where purchase_order = 'AKDN-80271'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-23'::date, '113-1010027-2008866', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-09-03'::date, 'FedEx Demo', 'DEMO00027201', '2026-09-01'::date, 'RCPT-073286', '2026-09-03'::date, '2026-09-03'::date, 'NX-041286-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80271' and oi.sequential = '10' and oi.material = '227-094'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '04728365-4906-4a96-9ff8-0e04d3951570'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80271' and oi.sequential = '10' and oi.material = '227-094'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5df849ec-7c97-4f5a-9dc1-cf952e74a491'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80271' and oi.sequential = '10' and oi.material = '227-094'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '026a0fd9-e01d-43b2-80c1-f20a60f324fe'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-09-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80271' and oi.sequential = '10' and oi.material = '227-094'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-111', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000288', 'SUP-543157', 'B0GBB5K8N5', 1, 'EA', 139.44, 31.69, 31.69
from public.orders where purchase_order = 'AKDN-80272'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-25'::date, '113-1010064-2008897', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-09-03'::date, 'Global Parcel Demo', 'DEMO00027301', '2026-09-03'::date, 'RCPT-073287', '2026-09-03'::date, '2026-09-03'::date, 'NX-041287-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80272' and oi.sequential = '10' and oi.material = '227-111'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '61a4f7e2-7a2f-4f52-8954-d3a99e2e2096'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80272' and oi.sequential = '10' and oi.material = '227-111'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '85b19b27-78df-4b9e-a495-7f39fc3975de'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80272' and oi.sequential = '10' and oi.material = '227-111'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '331a7c92-eb0d-4a1b-9b16-7bbcd88b6f60'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80272' and oi.sequential = '10' and oi.material = '227-111'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-128', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000289', 'SUP-543168', 'B0HAXD3K3C', 2, 'EA', 289.82, 32.06, 64.12
from public.orders where purchase_order = 'AKDN-80273'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-24'::date, '113-1010101-2008928', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-09-03'::date, 'UPS Demo', 'DEMO00027401', '2026-08-29'::date, 'RCPT-073288', '2026-09-03'::date, '2026-08-30'::date, 'NX-041288-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80273' and oi.sequential = '10' and oi.material = '227-128'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f4266d8f-daf8-45de-90cc-acc1dd72e7c1'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80273' and oi.sequential = '10' and oi.material = '227-128'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '858dd8aa-a184-41ef-822b-dc78113b5954'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-08-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80273' and oi.sequential = '10' and oi.material = '227-128'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ad0f71c4-a56f-4068-bd0a-3af4cf98a3f4'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80273' and oi.sequential = '10' and oi.material = '227-128'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-145', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000290', 'SUP-543179', 'B0J9LLKWGK', 1, 'EA', 150.48, 32.43, 32.43
from public.orders where purchase_order = 'AKDN-80274'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-26'::date, '113-1010138-2008959', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-09-03'::date, 'FedEx Demo', 'DEMO00027501', '2026-08-31'::date, 'RCPT-073289', '2026-09-03'::date, '2026-09-02'::date, 'NX-041289-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80274' and oi.sequential = '10' and oi.material = '227-145'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '03613694-cfda-443d-a67c-3dc2195b8fa9'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80274' and oi.sequential = '10' and oi.material = '227-145'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c59f72d0-2879-4552-bd70-f82f792fb269'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-09-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80274' and oi.sequential = '10' and oi.material = '227-145'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9cb25463-2b0e-4d59-9e3a-62f8d03c23b1'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-08-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80274' and oi.sequential = '10' and oi.material = '227-145'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-162', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000291', 'SUP-543190', 'B0K98U4AVS', 1, 'EA', 156.13, 32.8, 32.8
from public.orders where purchase_order = 'AKDN-80275'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-28'::date, '113-1010175-2008990', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-09-03'::date, 'Global Parcel Demo', 'DEMO00027601', '2026-09-02'::date, 'RCPT-073290', '2026-09-03'::date, '2026-09-03'::date, 'NX-041290-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80275' and oi.sequential = '10' and oi.material = '227-162'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2cc57278-b203-4e38-9826-abbec962469a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80275' and oi.sequential = '10' and oi.material = '227-162'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fe1a3570-a410-4a8e-86c4-e428cfd87bed'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80275' and oi.sequential = '10' and oi.material = '227-162'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd330ab58-05a5-4be7-bbfb-55813847e77a'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-09-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80275' and oi.sequential = '10' and oi.material = '227-162'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-179', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000292', 'SUP-543201', 'B0L8U4LMAZ', 2, 'EA', 323.74, 33.17, 66.34
from public.orders where purchase_order = 'AKDN-80276'
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
where o.purchase_order = 'AKDN-80276' and oi.sequential = '10' and oi.material = '227-179'
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
) select id, '10', '227-196', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000293', 'SUP-543212', 'B0N7GB4YP7', 1, 'EA', 167.7, 33.54, 33.54
from public.orders where purchase_order = 'AKDN-80277'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-29'::date, '113-1010249-2009052', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80277' and oi.sequential = '10' and oi.material = '227-196'
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
) select id, '10', '227-213', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000294', 'SUP-543223', 'B0P74KLB5E', 1, 'EA', 173.62, 33.91, 33.91
from public.orders where purchase_order = 'AKDN-80278'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-30'::date, '113-1010286-2009083', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80278' and oi.sequential = '10' and oi.material = '227-213'
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
) select id, '10', '227-230', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000295', 'SUP-543234', 'B0Q6QT5NJM', 2, 'EA', 301.66, 34.28, 68.56
from public.orders where purchase_order = 'AKDN-80279'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-08-29'::date, '113-1010323-2009114', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80279' and oi.sequential = '10' and oi.material = '227-230'
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
) select id, '10', '227-247', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000296', 'SUP-543245', 'B0R6C2MZXU', 1, 'EA', 156.62, 34.65, 34.65
from public.orders where purchase_order = 'AKDN-80280'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, null::date, null, 'Demo Commerce Group', 'Open', 'Marina Torres',
  'Preparing', null::date, null, null, '2026-09-03'::date, 'RCPT-073295', null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80280' and oi.sequential = '10' and oi.material = '227-247'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e1fc96dc-7794-415d-9097-1b333c7dea3e'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80280' and oi.sequential = '10' and oi.material = '227-247'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-264', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000297', 'SUP-543256', 'B0S5YA5CC3', 1, 'EA', 162.49, 35.02, 35.02
from public.orders where purchase_order = 'AKDN-80281'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-09-02'::date, '113-1010397-2009176', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80281' and oi.sequential = '10' and oi.material = '227-264'
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
) select id, '10', '227-281', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000298', 'SUP-543267', 'B0T4LJMQRA', 2, 'EA', 336.91, 35.39, 70.78
from public.orders where purchase_order = 'AKDN-80282'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-09-01'::date, '113-1010434-2009207', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-09-03'::date, 'UPS Demo', 'DEMO00028301', '2026-09-03'::date, 'RCPT-073297', '2026-09-03'::date, '2026-09-03'::date, 'NX-041297-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80282' and oi.sequential = '10' and oi.material = '227-281'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f0db2277-7b2b-46d0-b313-c0f3647390f0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80282' and oi.sequential = '10' and oi.material = '227-281'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '429cc787-c384-46d8-b48c-5e6acb6dc5eb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80282' and oi.sequential = '10' and oi.material = '227-281'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '08c101b1-c2ec-4db5-b166-d66335b73a98'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-09-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80282' and oi.sequential = '10' and oi.material = '227-281'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '227-298', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000299', 'SUP-543278', 'B0V49R536G', 1, 'EA', 174.51, 35.76, 35.76
from public.orders where purchase_order = 'AKDN-80283'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-09-03'::date, '113-1010471-2009238', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80283' and oi.sequential = '10' and oi.material = '227-298'
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
) select id, '10', '227-315', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000300', 'SUP-543289', 'B0W3VZNEKP', 1, 'EA', 180.65, 36.13, 36.13
from public.orders where purchase_order = 'AKDN-80284'
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
where o.purchase_order = 'AKDN-80284' and oi.sequential = '10' and oi.material = '227-315'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'aa835a4f-e2f8-4413-a859-4a4840f26a96'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-01-06'::timestamptz from public.orders where purchase_order = 'AKDN-80000'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'bc9910ab-4888-4698-999b-d5b2abf14435'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-01-07'::timestamptz from public.orders where purchase_order = 'AKDN-80001'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'a1882756-ac0e-4069-acd9-a7911b5e5e29'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-01-09'::timestamptz from public.orders where purchase_order = 'AKDN-80002'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '202acc83-c99b-44f7-ae78-35d7456d52fb'::uuid, id, true, 'Lucas Monteiro', '2026-01-07'::timestamptz from public.orders where purchase_order = 'AKDN-80003'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c021b24a-7ff3-46b8-b50f-2298e1221470'::uuid, id, true, 'Marina Torres', '2026-01-09'::timestamptz from public.orders where purchase_order = 'AKDN-80004'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '43baf7a4-8300-40ea-b8bf-790217c9720e'::uuid, id, true, 'Caio Nunes', '2026-01-11'::timestamptz from public.orders where purchase_order = 'AKDN-80005'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '95842982-28b1-411f-81a0-d4cb234932ea'::uuid, id, true, 'Renata Alves', '2026-01-10'::timestamptz from public.orders where purchase_order = 'AKDN-80006'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '89d6d3cd-b259-431a-9cbe-80307b9c31a3'::uuid, id, true, 'Lucas Monteiro', '2026-01-11'::timestamptz from public.orders where purchase_order = 'AKDN-80007'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '84e76a3d-1f41-4d2d-a3d3-001a5f9dad75'::uuid, id, true, 'Marina Torres', '2026-01-13'::timestamptz from public.orders where purchase_order = 'AKDN-80008'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'a8eca143-708b-40cc-8c64-283f01514313'::uuid, id, true, 'Caio Nunes', '2026-01-12'::timestamptz from public.orders where purchase_order = 'AKDN-80009'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '3a8015fe-497f-4afd-9b0d-4338e3541ab4'::uuid, id, true, 'Renata Alves', '2026-01-14'::timestamptz from public.orders where purchase_order = 'AKDN-80010'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'dbcbd8ea-19c3-4461-aad8-2529316d8a1d'::uuid, id, true, 'Lucas Monteiro', '2026-01-16'::timestamptz from public.orders where purchase_order = 'AKDN-80011'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '34fd6346-7e45-4ab5-8490-7a68343b43d3'::uuid, id, true, 'Marina Torres', '2026-01-15'::timestamptz from public.orders where purchase_order = 'AKDN-80012'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8744a86b-08b3-436c-b7c1-4599ade88506'::uuid, id, true, 'Caio Nunes', '2026-01-17'::timestamptz from public.orders where purchase_order = 'AKDN-80013'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b7904ba9-24e8-46af-9def-66505c4a49b8'::uuid, id, true, 'Renata Alves', '2026-01-18'::timestamptz from public.orders where purchase_order = 'AKDN-80014'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f4d74d8f-baee-4cd1-a1a9-a8a1ef7c633b'::uuid, id, true, 'Lucas Monteiro', '2026-01-17'::timestamptz from public.orders where purchase_order = 'AKDN-80015'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'a67d0a6f-4873-4196-8135-cf66305bfa74'::uuid, id, true, 'Caio Nunes', '2026-01-21'::timestamptz from public.orders where purchase_order = 'AKDN-80017'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6f247ce7-c216-49b6-8971-af45df6d80f0'::uuid, id, true, 'Renata Alves', '2026-01-20'::timestamptz from public.orders where purchase_order = 'AKDN-80018'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'ea1e6cf9-7f94-4695-9ae6-d1f1a98ec652'::uuid, id, true, 'Lucas Monteiro', '2026-01-22'::timestamptz from public.orders where purchase_order = 'AKDN-80019'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'a38082e0-36f8-4cf3-979f-e81b21e6d679'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-01-22'::timestamptz from public.orders where purchase_order = 'AKDN-80020'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '9a83dc96-a22e-46ef-a1d4-97c8f24d80af'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-01-24'::timestamptz from public.orders where purchase_order = 'AKDN-80021'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '1d117776-f047-45d5-937d-4c93725e013d'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-01-26'::timestamptz from public.orders where purchase_order = 'AKDN-80022'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '878abeaa-84e0-419f-80cf-f150c6793c92'::uuid, id, true, 'Lucas Monteiro', '2026-01-26'::timestamptz from public.orders where purchase_order = 'AKDN-80023'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '18c953c1-5b95-46b6-8ccf-d29f30752ccf'::uuid, id, true, 'Marina Torres', '2026-01-25'::timestamptz from public.orders where purchase_order = 'AKDN-80024'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '9e56d12c-a2d5-4978-a5bf-c7b7043a8d8f'::uuid, id, true, 'Caio Nunes', '2026-01-27'::timestamptz from public.orders where purchase_order = 'AKDN-80025'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c962124b-1e01-45cd-bf2e-21fdeeae9731'::uuid, id, true, 'Renata Alves', '2026-01-29'::timestamptz from public.orders where purchase_order = 'AKDN-80026'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '38e27279-66fe-43d2-9f5e-4755706aab91'::uuid, id, true, 'Lucas Monteiro', '2026-01-27'::timestamptz from public.orders where purchase_order = 'AKDN-80027'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '89e42a63-7e57-4772-a7f9-9538dadfa0aa'::uuid, id, true, 'Marina Torres', '2026-01-29'::timestamptz from public.orders where purchase_order = 'AKDN-80028'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'edd4b703-eb6f-4589-819e-454040f27fb5'::uuid, id, true, 'Caio Nunes', '2026-01-31'::timestamptz from public.orders where purchase_order = 'AKDN-80029'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '0651ddf5-f072-4806-9692-158399d78bf5'::uuid, id, true, 'Renata Alves', '2026-01-30'::timestamptz from public.orders where purchase_order = 'AKDN-80030'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '48dab299-f8cb-4b95-b73d-93a9fd9cb3e5'::uuid, id, true, 'Lucas Monteiro', '2026-02-01'::timestamptz from public.orders where purchase_order = 'AKDN-80031'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'efab7c48-5d58-4a25-9cb9-7f63a2757660'::uuid, id, true, 'Marina Torres', '2026-02-03'::timestamptz from public.orders where purchase_order = 'AKDN-80032'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '09b19cbe-a0de-4c24-837a-74dca601e5dd'::uuid, id, true, 'Caio Nunes', '2026-02-02'::timestamptz from public.orders where purchase_order = 'AKDN-80033'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c0452a91-76d6-4906-b9d5-fbb5262c6922'::uuid, id, true, 'Renata Alves', '2026-02-03'::timestamptz from public.orders where purchase_order = 'AKDN-80034'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '5ad1ce52-48c6-44c8-9edb-27f598a97630'::uuid, id, true, 'Lucas Monteiro', '2026-02-05'::timestamptz from public.orders where purchase_order = 'AKDN-80035'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'd1d23923-170c-4598-b799-a393efc5e6ef'::uuid, id, true, 'Caio Nunes', '2026-02-06'::timestamptz from public.orders where purchase_order = 'AKDN-80037'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '09feb868-073d-461d-b934-f31f8936128f'::uuid, id, true, 'Renata Alves', '2026-02-08'::timestamptz from public.orders where purchase_order = 'AKDN-80038'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '1b228958-c0d3-4385-a3ff-e2c48c18f697'::uuid, id, true, 'Lucas Monteiro', '2026-02-07'::timestamptz from public.orders where purchase_order = 'AKDN-80039'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '25a4a56e-a29e-4e7f-9bb8-6482b0a9dae8'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-02-08'::timestamptz from public.orders where purchase_order = 'AKDN-80040'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '55329dc4-1c0c-4338-97ce-837f1c6dcf8e'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-02-10'::timestamptz from public.orders where purchase_order = 'AKDN-80041'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'a696d367-c533-46b6-b7d2-e82a9a651b80'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-02-12'::timestamptz from public.orders where purchase_order = 'AKDN-80042'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'bac6752c-19f2-4d80-8ecf-0e5f1b1285d0'::uuid, id, true, 'Lucas Monteiro', '2026-02-11'::timestamptz from public.orders where purchase_order = 'AKDN-80043'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '154610f9-95b8-4e61-9edc-c477983a2705'::uuid, id, true, 'Marina Torres', '2026-02-13'::timestamptz from public.orders where purchase_order = 'AKDN-80044'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6464d73f-510e-43f9-b1b0-3c04969ce06c'::uuid, id, true, 'Caio Nunes', '2026-02-12'::timestamptz from public.orders where purchase_order = 'AKDN-80045'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '9db76b77-0049-4dc7-a758-392381a5b760'::uuid, id, true, 'Renata Alves', '2026-02-14'::timestamptz from public.orders where purchase_order = 'AKDN-80046'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '664e8c28-8539-4cfa-9f28-d6915dc1cc3f'::uuid, id, true, 'Lucas Monteiro', '2026-02-15'::timestamptz from public.orders where purchase_order = 'AKDN-80047'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b20a1379-6a14-4a44-93da-b230b8f787c2'::uuid, id, true, 'Marina Torres', '2026-02-14'::timestamptz from public.orders where purchase_order = 'AKDN-80048'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '9d476994-f6d4-44a9-a6f0-8bdeb9a7101a'::uuid, id, true, 'Caio Nunes', '2026-02-16'::timestamptz from public.orders where purchase_order = 'AKDN-80049'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '5ed2d37b-eac5-47c5-b9de-ef5739eca1c5'::uuid, id, true, 'Renata Alves', '2026-02-18'::timestamptz from public.orders where purchase_order = 'AKDN-80050'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c5ca1b8b-1d04-462e-bdbb-0d15e7d81ba8'::uuid, id, true, 'Lucas Monteiro', '2026-02-17'::timestamptz from public.orders where purchase_order = 'AKDN-80051'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '0b15aefc-5d29-46a7-ba26-493324e2e3c1'::uuid, id, true, 'Marina Torres', '2026-02-19'::timestamptz from public.orders where purchase_order = 'AKDN-80052'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '97d85b77-d3e7-4151-8cf2-c591a2bd8276'::uuid, id, true, 'Caio Nunes', '2026-02-20'::timestamptz from public.orders where purchase_order = 'AKDN-80053'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'e098b49b-84b5-44ea-a8eb-c0d5ba4a11ad'::uuid, id, true, 'Renata Alves', '2026-02-19'::timestamptz from public.orders where purchase_order = 'AKDN-80054'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '821cbc53-bea4-4202-bdf4-ba4efe1aa8ac'::uuid, id, true, 'Lucas Monteiro', '2026-02-21'::timestamptz from public.orders where purchase_order = 'AKDN-80055'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '5fcfa5a9-2c1d-4d2e-bd8d-43d9a482c801'::uuid, id, true, 'Caio Nunes', '2026-02-22'::timestamptz from public.orders where purchase_order = 'AKDN-80057'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'a6e15e86-8c1a-4deb-b85f-b571944912e0'::uuid, id, true, 'Renata Alves', '2026-02-24'::timestamptz from public.orders where purchase_order = 'AKDN-80058'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '7224c3e8-2416-4faa-ba33-3c60eca5fa20'::uuid, id, true, 'Lucas Monteiro', '2026-02-26'::timestamptz from public.orders where purchase_order = 'AKDN-80059'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '8b3e1b25-09bf-4682-b778-15387c00defa'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-02-25'::timestamptz from public.orders where purchase_order = 'AKDN-80060'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'c93e0fcd-574b-4b67-89ca-6f53a67246b3'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-02-27'::timestamptz from public.orders where purchase_order = 'AKDN-80061'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '4417cdfc-cf92-4587-a9a8-55e334a4cfc9'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-03-01'::timestamptz from public.orders where purchase_order = 'AKDN-80062'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '58910434-9420-4148-ae29-da0e4c28e3a3'::uuid, id, true, 'Lucas Monteiro', '2026-02-27'::timestamptz from public.orders where purchase_order = 'AKDN-80063'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'be1b3697-cdc7-452d-b549-eaf52528130a'::uuid, id, true, 'Marina Torres', '2026-03-01'::timestamptz from public.orders where purchase_order = 'AKDN-80064'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '7fab4fc2-ab0f-4e3d-ab6a-2fd00c55a5d1'::uuid, id, true, 'Caio Nunes', '2026-03-03'::timestamptz from public.orders where purchase_order = 'AKDN-80065'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '9c321efb-92b2-47db-ba73-a732a7299a95'::uuid, id, true, 'Renata Alves', '2026-03-02'::timestamptz from public.orders where purchase_order = 'AKDN-80066'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '0a035b6e-392f-4062-bad9-b87c2e3b0c42'::uuid, id, true, 'Lucas Monteiro', '2026-03-03'::timestamptz from public.orders where purchase_order = 'AKDN-80067'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f744b6d0-33d8-43cd-a327-27b54a79cafe'::uuid, id, true, 'Marina Torres', '2026-03-05'::timestamptz from public.orders where purchase_order = 'AKDN-80068'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'e142b6a2-58e6-43fb-ad4b-e48a03e6fe24'::uuid, id, true, 'Caio Nunes', '2026-03-04'::timestamptz from public.orders where purchase_order = 'AKDN-80069'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '918c760d-7a83-4a9d-a748-eca619ee02fa'::uuid, id, true, 'Renata Alves', '2026-03-06'::timestamptz from public.orders where purchase_order = 'AKDN-80070'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'a9e902f9-b518-4473-a4a6-58a46074e4de'::uuid, id, true, 'Lucas Monteiro', '2026-03-08'::timestamptz from public.orders where purchase_order = 'AKDN-80071'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '3f4fd1f9-634d-4c71-a5ab-11dd5e499086'::uuid, id, true, 'Marina Torres', '2026-03-07'::timestamptz from public.orders where purchase_order = 'AKDN-80072'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '34dfdacb-5f4a-400e-89ca-009bc61d262e'::uuid, id, true, 'Caio Nunes', '2026-03-08'::timestamptz from public.orders where purchase_order = 'AKDN-80073'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'a2dec205-3a74-4bad-928a-76c96510076c'::uuid, id, true, 'Renata Alves', '2026-03-10'::timestamptz from public.orders where purchase_order = 'AKDN-80074'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6ddca9ee-e48b-40a5-9425-c99f0a466d30'::uuid, id, true, 'Lucas Monteiro', '2026-03-09'::timestamptz from public.orders where purchase_order = 'AKDN-80075'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'cfd0b58c-c403-47e0-a7f8-eddd12f3584a'::uuid, id, true, 'Caio Nunes', '2026-03-13'::timestamptz from public.orders where purchase_order = 'AKDN-80077'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f606d08b-d1d3-4b33-9ced-bcb5f4dcd4b3'::uuid, id, true, 'Renata Alves', '2026-03-12'::timestamptz from public.orders where purchase_order = 'AKDN-80078'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '754bb557-6cb6-4598-9ae9-321bc8d7925d'::uuid, id, true, 'Lucas Monteiro', '2026-03-14'::timestamptz from public.orders where purchase_order = 'AKDN-80079'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'e6fec09b-577d-4764-be3b-19a118bc80d1'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-03-14'::timestamptz from public.orders where purchase_order = 'AKDN-80080'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '10e76f35-bee2-40c6-b125-77126f65db7d'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-03-16'::timestamptz from public.orders where purchase_order = 'AKDN-80081'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '22f4eb76-426f-4e31-b5dc-302f88695940'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-03-18'::timestamptz from public.orders where purchase_order = 'AKDN-80082'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '2aee4d6f-7148-4eef-9f1f-e53659549d50'::uuid, id, true, 'Lucas Monteiro', '2026-03-18'::timestamptz from public.orders where purchase_order = 'AKDN-80083'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'cfe88196-bc9c-4fff-9c9c-af627825471f'::uuid, id, true, 'Marina Torres', '2026-03-17'::timestamptz from public.orders where purchase_order = 'AKDN-80084'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '56f5800a-e2c8-47dc-b0d6-62a59bbfe6e8'::uuid, id, true, 'Caio Nunes', '2026-03-19'::timestamptz from public.orders where purchase_order = 'AKDN-80085'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '812e074b-4c20-42d1-9b3c-422d39db4ce5'::uuid, id, true, 'Renata Alves', '2026-03-20'::timestamptz from public.orders where purchase_order = 'AKDN-80086'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '02c6abd4-cb85-4506-a84e-455db53dc24a'::uuid, id, true, 'Lucas Monteiro', '2026-03-19'::timestamptz from public.orders where purchase_order = 'AKDN-80087'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'c0d6a460-d32a-478d-b241-f77c80f2791d'::uuid, id, true, 'Marina Torres', '2026-03-21'::timestamptz from public.orders where purchase_order = 'AKDN-80088'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '67b84f4e-7f90-4b3e-8672-feaf3762fdaf'::uuid, id, true, 'Caio Nunes', '2026-03-23'::timestamptz from public.orders where purchase_order = 'AKDN-80089'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'cb1f0081-588e-4f7a-8c3b-23a98d047777'::uuid, id, true, 'Renata Alves', '2026-03-22'::timestamptz from public.orders where purchase_order = 'AKDN-80090'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '04b43d81-654b-4a10-9be6-b3ffde837c20'::uuid, id, true, 'Lucas Monteiro', '2026-03-24'::timestamptz from public.orders where purchase_order = 'AKDN-80091'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '4159d8ff-a1a0-4890-965b-67fd51ca97c8'::uuid, id, true, 'Marina Torres', '2026-03-26'::timestamptz from public.orders where purchase_order = 'AKDN-80092'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'e5ec5a4b-b548-436c-9164-ef79fe7c9d69'::uuid, id, true, 'Caio Nunes', '2026-03-24'::timestamptz from public.orders where purchase_order = 'AKDN-80093'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6b9aeba7-4551-4e3a-8ccc-7abc43affb33'::uuid, id, true, 'Renata Alves', '2026-03-26'::timestamptz from public.orders where purchase_order = 'AKDN-80094'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '5eab011a-609e-46b8-ac5c-b56251299798'::uuid, id, true, 'Lucas Monteiro', '2026-03-28'::timestamptz from public.orders where purchase_order = 'AKDN-80095'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b2e5a7ce-295f-4397-be16-7e41f4b11054'::uuid, id, true, 'Caio Nunes', '2026-03-29'::timestamptz from public.orders where purchase_order = 'AKDN-80097'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f97e31e1-61d4-4521-8b44-57ff0eeeccb4'::uuid, id, true, 'Renata Alves', '2026-03-31'::timestamptz from public.orders where purchase_order = 'AKDN-80098'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '696ab442-678e-4af6-8263-55c7254113d3'::uuid, id, true, 'Lucas Monteiro', '2026-03-30'::timestamptz from public.orders where purchase_order = 'AKDN-80099'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'dcf9343d-d757-4b23-9411-f3cc86b13fcb'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-03-31'::timestamptz from public.orders where purchase_order = 'AKDN-80100'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '6e00400b-dc18-48c0-ab28-2186b59de1d7'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-04-02'::timestamptz from public.orders where purchase_order = 'AKDN-80101'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'ce045a18-37d9-4310-9ec8-ce13baed3c36'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-04-04'::timestamptz from public.orders where purchase_order = 'AKDN-80102'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'b32c7d5a-02b6-4328-b2cb-4d70dc858f73'::uuid, id, true, 'Lucas Monteiro', '2026-04-03'::timestamptz from public.orders where purchase_order = 'AKDN-80103'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '0be7ac07-0dda-49c2-bb54-dfdbcd310527'::uuid, id, true, 'Marina Torres', '2026-04-05'::timestamptz from public.orders where purchase_order = 'AKDN-80104'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'e8eb5367-b6bb-4eae-bd82-14a5442f4f2b'::uuid, id, true, 'Caio Nunes', '2026-04-04'::timestamptz from public.orders where purchase_order = 'AKDN-80105'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '19537f56-fbb1-4946-a47b-8d32874d3627'::uuid, id, true, 'Renata Alves', '2026-04-05'::timestamptz from public.orders where purchase_order = 'AKDN-80106'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '977bd94b-4025-46a1-9718-b974044c076e'::uuid, id, true, 'Lucas Monteiro', '2026-04-07'::timestamptz from public.orders where purchase_order = 'AKDN-80107'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'cea75d95-c76a-434b-a8b7-bd40b98392b6'::uuid, id, true, 'Marina Torres', '2026-04-06'::timestamptz from public.orders where purchase_order = 'AKDN-80108'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'a96f1d78-78d8-42e7-8927-99c3a6c65728'::uuid, id, true, 'Caio Nunes', '2026-04-08'::timestamptz from public.orders where purchase_order = 'AKDN-80109'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'ad476b9b-0fcb-4e42-b138-7aaf0b5628d5'::uuid, id, true, 'Renata Alves', '2026-04-10'::timestamptz from public.orders where purchase_order = 'AKDN-80110'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '069276e2-590f-49b0-8380-62f1ba446a2e'::uuid, id, true, 'Lucas Monteiro', '2026-04-09'::timestamptz from public.orders where purchase_order = 'AKDN-80111'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '4e164f32-24c9-418c-9a72-a9997a42e179'::uuid, id, true, 'Marina Torres', '2026-04-11'::timestamptz from public.orders where purchase_order = 'AKDN-80112'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '10453cfe-a34f-466c-9f3e-5dc1460e1c1a'::uuid, id, true, 'Caio Nunes', '2026-04-12'::timestamptz from public.orders where purchase_order = 'AKDN-80113'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'ae7e178b-2fdb-443e-8446-a47f801cf3cc'::uuid, id, true, 'Renata Alves', '2026-04-11'::timestamptz from public.orders where purchase_order = 'AKDN-80114'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '4c87ff93-cdde-498a-a7b0-d85737c147b6'::uuid, id, true, 'Lucas Monteiro', '2026-04-13'::timestamptz from public.orders where purchase_order = 'AKDN-80115'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'cb037fb0-56c0-4502-b89c-98de91826889'::uuid, id, true, 'Caio Nunes', '2026-04-14'::timestamptz from public.orders where purchase_order = 'AKDN-80117'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'e16351f6-fa95-4462-90ce-fb29c3edc36c'::uuid, id, true, 'Renata Alves', '2026-04-16'::timestamptz from public.orders where purchase_order = 'AKDN-80118'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'd7322972-fb8f-49f5-8161-c433191d0866'::uuid, id, true, 'Lucas Monteiro', '2026-04-17'::timestamptz from public.orders where purchase_order = 'AKDN-80119'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '71a43f8f-02cb-4d3c-bd27-8722640798c0'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-04-17'::timestamptz from public.orders where purchase_order = 'AKDN-80120'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select 'b44b1b8f-16d1-4664-8124-3e294a4fc35c'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-04-19'::timestamptz from public.orders where purchase_order = 'AKDN-80121'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '9e9656b1-b1ee-496c-909f-39214b02e461'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-04-21'::timestamptz from public.orders where purchase_order = 'AKDN-80122'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '30db9fd4-69be-4130-9900-f13d06a91b9f'::uuid, id, true, 'Lucas Monteiro', '2026-04-19'::timestamptz from public.orders where purchase_order = 'AKDN-80123'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6b72ad4f-44a2-4d85-9189-6775bb5cbaf6'::uuid, id, true, 'Marina Torres', '2026-04-21'::timestamptz from public.orders where purchase_order = 'AKDN-80124'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8fbbc0fe-9e8e-442c-9fec-be4d01a14042'::uuid, id, true, 'Caio Nunes', '2026-04-23'::timestamptz from public.orders where purchase_order = 'AKDN-80125'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'd01784ad-cc58-4b0d-b16e-682ed92e656a'::uuid, id, true, 'Renata Alves', '2026-04-21'::timestamptz from public.orders where purchase_order = 'AKDN-80126'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '57e28683-57a3-4f93-a66f-d4c5bd8c19cf'::uuid, id, true, 'Lucas Monteiro', '2026-04-23'::timestamptz from public.orders where purchase_order = 'AKDN-80127'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f5fd93ab-6d4a-41ef-b31e-0d34118646f2'::uuid, id, true, 'Marina Torres', '2026-04-25'::timestamptz from public.orders where purchase_order = 'AKDN-80128'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '048ae117-589f-4986-b439-d7ca7f820756'::uuid, id, true, 'Caio Nunes', '2026-04-24'::timestamptz from public.orders where purchase_order = 'AKDN-80129'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8d697d28-3971-43ce-bfa1-1f49d8b32ea1'::uuid, id, true, 'Renata Alves', '2026-04-26'::timestamptz from public.orders where purchase_order = 'AKDN-80130'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '089fe2c9-22cb-4af2-8a81-07277ed02725'::uuid, id, true, 'Lucas Monteiro', '2026-04-28'::timestamptz from public.orders where purchase_order = 'AKDN-80131'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'fed52f42-88aa-4acf-b11f-05d49ed6b6f5'::uuid, id, true, 'Marina Torres', '2026-04-27'::timestamptz from public.orders where purchase_order = 'AKDN-80132'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'fd9a2000-c03f-48d9-a072-57283aaf37a9'::uuid, id, true, 'Caio Nunes', '2026-04-28'::timestamptz from public.orders where purchase_order = 'AKDN-80133'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '7f075d88-654f-4a52-8257-4bf331268bbc'::uuid, id, true, 'Renata Alves', '2026-04-30'::timestamptz from public.orders where purchase_order = 'AKDN-80134'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '6bbc4879-ee31-476f-8194-6af797d89c42'::uuid, id, true, 'Lucas Monteiro', '2026-04-29'::timestamptz from public.orders where purchase_order = 'AKDN-80135'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'f2dadd82-51ba-4a31-837a-841293d0857d'::uuid, id, true, 'Caio Nunes', '2026-05-03'::timestamptz from public.orders where purchase_order = 'AKDN-80137'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '43788a21-0aa8-4d86-bd17-2d6e750f9613'::uuid, id, true, 'Renata Alves', '2026-05-02'::timestamptz from public.orders where purchase_order = 'AKDN-80138'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '56f35920-132f-49d1-9711-ba30e1070036'::uuid, id, true, 'Lucas Monteiro', '2026-05-03'::timestamptz from public.orders where purchase_order = 'AKDN-80139'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '88d190d4-0744-4130-b230-b27553ace1e9'::uuid, id, 'Cancelled by demo store', 'seed', 'Marina Torres', '2026-05-04'::timestamptz from public.orders where purchase_order = 'AKDN-80140'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '3d7ec115-0f73-46b9-a07c-c9dfa7436056'::uuid, id, 'Cancelled by demo customer', 'seed', 'Caio Nunes', '2026-05-06'::timestamptz from public.orders where purchase_order = 'AKDN-80141'
on conflict (id) do nothing;

insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)
select '37f69d87-07af-482a-806c-001fbe09811a'::uuid, id, 'Cancelled by demo store', 'seed', 'Renata Alves', '2026-05-08'::timestamptz from public.orders where purchase_order = 'AKDN-80142'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '8a33017f-4409-4872-a559-3536a38a184e'::uuid, id, true, 'Lucas Monteiro', '2026-05-08'::timestamptz from public.orders where purchase_order = 'AKDN-80143'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '72c2c3fb-d8fb-438a-a26f-f10b85642e68'::uuid, id, true, 'Marina Torres', '2026-05-07'::timestamptz from public.orders where purchase_order = 'AKDN-80144'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '611008cc-6108-404b-8a59-22faaa65c311'::uuid, id, true, 'Caio Nunes', '2026-05-09'::timestamptz from public.orders where purchase_order = 'AKDN-80145'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '962ef595-f11c-454c-8af9-dbaca6637488'::uuid, id, true, 'Renata Alves', '2026-05-10'::timestamptz from public.orders where purchase_order = 'AKDN-80146'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '9f13bc5f-2a97-4122-85b3-d8b5bb535544'::uuid, id, true, 'Lucas Monteiro', '2026-05-09'::timestamptz from public.orders where purchase_order = 'AKDN-80147'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'e1856284-0fa5-4017-b4c6-72bc447fb0db'::uuid, id, true, 'Marina Torres', '2026-05-11'::timestamptz from public.orders where purchase_order = 'AKDN-80148'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'da9dfa38-64ce-4f01-ac8a-1bd2baf70b99'::uuid, id, true, 'Caio Nunes', '2026-05-13'::timestamptz from public.orders where purchase_order = 'AKDN-80149'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'dec0e4ad-ddf0-4207-82e5-0b3ea93473b6'::uuid, id, true, 'Renata Alves', '2026-05-12'::timestamptz from public.orders where purchase_order = 'AKDN-80150'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '629d95f1-8414-4491-9627-c4873fb64776'::uuid, id, true, 'Lucas Monteiro', '2026-05-14'::timestamptz from public.orders where purchase_order = 'AKDN-80151'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select 'e1ee671b-da49-4d00-90e4-eff2de89e7b7'::uuid, id, true, 'Marina Torres', '2026-05-15'::timestamptz from public.orders where purchase_order = 'AKDN-80152'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '4b262f85-23b5-4ad2-a20c-63fbe2d5332b'::uuid, id, true, 'Caio Nunes', '2026-05-14'::timestamptz from public.orders where purchase_order = 'AKDN-80153'
on conflict (id) do nothing;

insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)
select '291f8814-17ae-4210-92c5-bef6199746b9'::uuid, id, true, 'Renata Alves', '2026-05-16'::timestamptz from public.orders where purchase_order = 'AKDN-80154'
on conflict (id) do nothing;

commit;
