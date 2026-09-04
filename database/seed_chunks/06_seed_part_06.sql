-- Demo seed part 06 of 10. Run files in numeric order.
begin;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1b17890b-4f0c-4c48-8448-ebb3e04f44c4'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80123' and oi.sequential = '10' and oi.material = '224-578'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '40cdd736-579a-4e00-acf6-62d38252f5d7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80123' and oi.sequential = '10' and oi.material = '224-578'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ffc62959-537f-471a-ad46-ba310952cb31'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80123' and oi.sequential = '10' and oi.material = '224-578'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e5b78671-aa2a-4992-93cb-ea38c7aa7b82'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80123' and oi.sequential = '10' and oi.material = '224-578'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-595', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000140', 'SUP-541529', 'B0Z8BNFM4K', 1, 'EA', 306.84, 59.93, 59.93
from public.orders where purchase_order = 'AKDN-80124'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-21'::date, '113-1004588-2004309', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-05-10'::date, 'FedEx Demo', 'DEMO00012501', '2026-04-30'::date, 'RCPT-073139', '2026-05-10'::date, '2026-05-02'::date, 'NX-041139-26',
  '2026-05-12'::date, '2026-05-13'::date, '2026-05-14'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80124' and oi.sequential = '10' and oi.material = '224-595'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5ff4e5da-e968-4cdc-965a-8ebbd8b27e02'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80124' and oi.sequential = '10' and oi.material = '224-595'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4c29b105-b833-43aa-9440-876feb7de9c2'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80124' and oi.sequential = '10' and oi.material = '224-595'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '89e58300-e8f4-413c-8f4f-237cb14aea2a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80124' and oi.sequential = '10' and oi.material = '224-595'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e097e1df-b9ca-4ca8-8648-e0d81432d48f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80124' and oi.sequential = '10' and oi.material = '224-595'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a7aa0fd4-b3cc-43c6-97d7-9cbbb32cf268'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80124' and oi.sequential = '10' and oi.material = '224-595'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-612', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000141', 'SUP-541540', 'B027XWXZHS', 1, 'EA', 265.32, 60.3, 60.3
from public.orders where purchase_order = 'AKDN-80125'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-23'::date, '113-1004625-2004340', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-05-09'::date, 'Global Parcel Demo', 'DEMO00012601', '2026-05-02'::date, 'RCPT-073140', '2026-05-09'::date, '2026-05-05'::date, 'NX-041140-26',
  '2026-05-12'::date, '2026-05-14'::date, '2026-05-16'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80125' and oi.sequential = '10' and oi.material = '224-612'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '9401d8e2-fd2c-4015-969a-e73046b9bcb2'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80125' and oi.sequential = '10' and oi.material = '224-612'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c49e74e9-604b-43dc-b6c1-1d52c55b663f'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80125' and oi.sequential = '10' and oi.material = '224-612'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8ee76bdc-e446-4a64-b8ce-b530738a108d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80125' and oi.sequential = '10' and oi.material = '224-612'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '208eaf3e-cdaf-4190-accf-47f140d46e77'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80125' and oi.sequential = '10' and oi.material = '224-612'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2284bf97-a124-4c4c-9818-c0c8c1369d75'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80125' and oi.sequential = '10' and oi.material = '224-612'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-629', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000142', 'SUP-541551', 'B046K5GCWY', 2, 'EA', 548.46, 60.67, 121.34
from public.orders where purchase_order = 'AKDN-80126'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-21'::date, '113-1004662-2004371', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-05-02'::date, 'UPS Demo', 'DEMO00012701', '2026-04-26'::date, 'RCPT-073141', '2026-05-02'::date, '2026-04-27'::date, 'NX-041141-26',
  '2026-05-03'::date, '2026-05-04'::date, '2026-05-07'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80126' and oi.sequential = '10' and oi.material = '224-629'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '890c7951-71fa-4794-83c8-e9e38f63efce'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80126' and oi.sequential = '10' and oi.material = '224-629'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1d8597c4-9afc-44f0-97c6-e358fbc80030'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80126' and oi.sequential = '10' and oi.material = '224-629'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '18a34727-a0c6-4626-895f-d79548750b93'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80126' and oi.sequential = '10' and oi.material = '224-629'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '70b30619-5323-4c9f-a463-ae96a16dd386'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80126' and oi.sequential = '10' and oi.material = '224-629'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '69a9b78a-8bfb-4aa2-951b-7f8ad107d51c'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80126' and oi.sequential = '10' and oi.material = '224-629'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-646', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000143', 'SUP-541562', 'B0567DYPB7', 1, 'EA', 283.23, 61.04, 61.04
from public.orders where purchase_order = 'AKDN-80127'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-23'::date, '113-1004699-2004402', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-05-06'::date, 'FedEx Demo', 'DEMO00012801', '2026-04-28'::date, 'RCPT-073142', '2026-05-06'::date, '2026-04-30'::date, 'NX-041142-26',
  '2026-05-08'::date, '2026-05-10'::date, '2026-05-14'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80127' and oi.sequential = '10' and oi.material = '224-646'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e138350f-42b5-497f-b082-681ac125ee09'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80127' and oi.sequential = '10' and oi.material = '224-646'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e83ed2f5-89a7-431e-9dfe-79780733a15f'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80127' and oi.sequential = '10' and oi.material = '224-646'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5d098505-87a4-41f8-95d8-4f874373b0ab'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80127' and oi.sequential = '10' and oi.material = '224-646'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '77447c90-d121-4770-9e4f-e401294e2110'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-04-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80127' and oi.sequential = '10' and oi.material = '224-646'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fc2e4926-98a6-4538-8e06-681fe56398fd'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80127' and oi.sequential = '10' and oi.material = '224-646'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-663', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000144', 'SUP-541573', 'B065TMG2QE', 1, 'EA', 292.31, 61.41, 61.41
from public.orders where purchase_order = 'AKDN-80128'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-25'::date, '113-1004736-2004433', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-05-10'::date, 'Global Parcel Demo', 'DEMO00012901', '2026-04-30'::date, 'RCPT-073143', '2026-05-10'::date, '2026-05-03'::date, 'NX-041143-26',
  '2026-05-13'::date, '2026-05-14'::date, '2026-05-15'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80128' and oi.sequential = '10' and oi.material = '224-663'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '679d4da2-3d3f-48f8-821e-4505c1917ff1'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80128' and oi.sequential = '10' and oi.material = '224-663'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd11021bf-e77f-4719-8251-2cda943c21f3'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80128' and oi.sequential = '10' and oi.material = '224-663'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4e927310-d13a-41f0-b685-e169a66dde5b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80128' and oi.sequential = '10' and oi.material = '224-663'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7ccd9afb-288e-47cf-a1ba-41186ac3467b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80128' and oi.sequential = '10' and oi.material = '224-663'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ad664381-a5aa-4280-81fc-b8eb2a7c53d8'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-04-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80128' and oi.sequential = '10' and oi.material = '224-663'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-680', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000145', 'SUP-541584', 'B074FUYD6M', 2, 'EA', 602.97, 61.78, 123.56
from public.orders where purchase_order = 'AKDN-80129'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-24'::date, '113-1004773-2004464', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-05-11'::date, 'UPS Demo', 'DEMO00013001', '2026-05-02'::date, 'RCPT-073144', '2026-05-11'::date, '2026-05-03'::date, 'NX-041144-26',
  '2026-05-12'::date, '2026-05-14'::date, '2026-05-16'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80129' and oi.sequential = '10' and oi.material = '224-680'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '15c366d7-3d08-4905-b259-f4e25c4c1d69'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80129' and oi.sequential = '10' and oi.material = '224-680'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3592f93d-f692-4779-a7d0-8f3aeb7441c0'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80129' and oi.sequential = '10' and oi.material = '224-680'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8519d888-f083-42b6-94d8-f15cfa17ac98'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80129' and oi.sequential = '10' and oi.material = '224-680'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'abf3bdcf-fea8-48f4-9ce3-05fc4c149eaf'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80129' and oi.sequential = '10' and oi.material = '224-680'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '79d2fa65-76c8-46fb-87a8-5d44ecfc8323'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80129' and oi.sequential = '10' and oi.material = '224-680'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-697', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000146', 'SUP-541595', 'B08444HQKU', 1, 'EA', 310.75, 62.15, 62.15
from public.orders where purchase_order = 'AKDN-80130'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-26'::date, '113-1004810-2004495', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-05-10'::date, 'FedEx Demo', 'DEMO00013101', '2026-05-04'::date, 'RCPT-073145', '2026-05-10'::date, '2026-05-06'::date, 'NX-041145-26',
  '2026-05-12'::date, '2026-05-13'::date, '2026-05-16'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80130' and oi.sequential = '10' and oi.material = '224-697'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0a4490a2-e5d9-4e98-8f53-8f0dbce4dd31'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80130' and oi.sequential = '10' and oi.material = '224-697'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fed9373e-a837-44d4-a3be-4be1b1870185'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80130' and oi.sequential = '10' and oi.material = '224-697'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2e3429fb-a35c-47c3-ba01-5f847fb5a643'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-10'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80130' and oi.sequential = '10' and oi.material = '224-697'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b3280cbb-5dad-42ce-8548-94360a8ab8eb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80130' and oi.sequential = '10' and oi.material = '224-697'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fe645736-2b72-421b-a7c4-b7a82e236c18'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80130' and oi.sequential = '10' and oi.material = '224-697'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-714', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000147', 'SUP-541606', 'B0A3QCZ3Y3', 1, 'EA', 320.1, 62.52, 62.52
from public.orders where purchase_order = 'AKDN-80131'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-28'::date, '113-1004847-2004526', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-05-14'::date, 'Global Parcel Demo', 'DEMO00013201', '2026-05-06'::date, 'RCPT-073146', '2026-05-14'::date, '2026-05-09'::date, 'NX-041146-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80131' and oi.sequential = '10' and oi.material = '224-714'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'babdcfc0-c727-423d-aa9d-281f9bc49b63'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80131' and oi.sequential = '10' and oi.material = '224-714'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '19d10b8b-a6d7-4089-b0f8-0ceefc8a67a1'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80131' and oi.sequential = '10' and oi.material = '224-714'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6271b109-5eba-4eaa-962f-09ec2fc685dc'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80131' and oi.sequential = '10' and oi.material = '224-714'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-731', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000148', 'SUP-541617', 'B0B3CKHFD9', 2, 'EA', 553.43, 62.89, 125.78
from public.orders where purchase_order = 'AKDN-80132'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-27'::date, '113-1004884-2004557', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-05-15'::date, 'UPS Demo', 'DEMO00013301', '2026-05-08'::date, 'RCPT-073147', '2026-05-15'::date, '2026-05-09'::date, 'NX-041147-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80132' and oi.sequential = '10' and oi.material = '224-731'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '59ad6418-ab6c-4ab5-8495-45dda158fc02'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80132' and oi.sequential = '10' and oi.material = '224-731'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6e356d6b-c2c7-422b-a116-f6541f1a2e5e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-09'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80132' and oi.sequential = '10' and oi.material = '224-731'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0fea7d42-5c0c-450d-91ec-0dbd43003d31'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80132' and oi.sequential = '10' and oi.material = '224-731'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-748', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000149', 'SUP-541628', 'B0C2YTZSSG', 1, 'EA', 285.94, 63.26, 63.26
from public.orders where purchase_order = 'AKDN-80133'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-28'::date, '113-1004921-2004588', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-05-11'::date, 'FedEx Demo', 'DEMO00013401', '2026-05-02'::date, 'RCPT-073148', '2026-05-11'::date, '2026-05-04'::date, 'NX-041148-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80133' and oi.sequential = '10' and oi.material = '224-748'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4214dcd6-3c0b-4c56-a722-f0565312a7da'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80133' and oi.sequential = '10' and oi.material = '224-748'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1aecef70-675c-49a9-9e52-50de1eca9989'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80133' and oi.sequential = '10' and oi.material = '224-748'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6b10c5a5-c20c-4538-8830-7c25592c784e'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80133' and oi.sequential = '10' and oi.material = '224-748'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-765', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000150', 'SUP-541639', 'B0DZL3J57P', 1, 'EA', 295.24, 63.63, 63.63
from public.orders where purchase_order = 'AKDN-80134'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-30'::date, '113-1004958-2004619', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-05-15'::date, 'Global Parcel Demo', 'DEMO00013501', '2026-05-04'::date, 'RCPT-073149', '2026-05-15'::date, '2026-05-07'::date, 'NX-041149-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80134' and oi.sequential = '10' and oi.material = '224-765'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3e86ee48-9ab3-45d8-9184-a993c32e28cf'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80134' and oi.sequential = '10' and oi.material = '224-765'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a3d1401e-7c57-4685-a112-530844069098'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80134' and oi.sequential = '10' and oi.material = '224-765'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '391f75e5-9923-46b6-a05c-6aefa8d04c2f'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80134' and oi.sequential = '10' and oi.material = '224-765'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-782', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000151', 'SUP-541650', 'B0EZ8A2GLW', 2, 'EA', 609.28, 64, 128
from public.orders where purchase_order = 'AKDN-80135'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-04-29'::date, '113-1004995-2004650', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-05-11'::date, 'UPS Demo', 'DEMO00013601', '2026-05-06'::date, 'RCPT-073150', '2026-05-11'::date, '2026-05-07'::date, 'NX-041150-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80135' and oi.sequential = '10' and oi.material = '224-782'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1c3aff63-f704-4978-9db6-db78738ebeb1'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80135' and oi.sequential = '10' and oi.material = '224-782'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '5a05a7aa-4d75-43f2-9a10-182c2b1d1044'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-07'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80135' and oi.sequential = '10' and oi.material = '224-782'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'caed3cf6-2d25-42b2-b7dd-8fc87f9b04ac'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-06'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80135' and oi.sequential = '10' and oi.material = '224-782'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-799', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000152', 'SUP-541661', 'B0FYUJJTZ5', 1, 'EA', 314.13, 64.37, 64.37
from public.orders where purchase_order = 'AKDN-80136'
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
where o.purchase_order = 'AKDN-80136' and oi.sequential = '10' and oi.material = '224-799'
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
) select id, '10', '224-816', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000153', 'SUP-541672', 'B0HXGS26EC', 1, 'EA', 323.7, 64.74, 64.74
from public.orders where purchase_order = 'AKDN-80137'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-03'::date, '113-1005069-2004712', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80137' and oi.sequential = '10' and oi.material = '224-816'
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
) select id, '10', '224-833', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000154', 'SUP-541683', 'B0JX4ZKJTJ', 2, 'EA', 666.73, 65.11, 130.22
from public.orders where purchase_order = 'AKDN-80138'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-02'::date, '113-1005106-2004743', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80138' and oi.sequential = '10' and oi.material = '224-833'
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
) select id, '10', '224-850', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000155', 'SUP-541694', 'B0KWR93V8R', 1, 'EA', 288.11, 65.48, 65.48
from public.orders where purchase_order = 'AKDN-80139'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-03'::date, '113-1005143-2004774', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80139' and oi.sequential = '10' and oi.material = '224-850'
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
) select id, '10', '224-867', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000156', 'SUP-541705', 'B0LVDHK8NY', 1, 'EA', 297.64, 65.85, 65.85
from public.orders where purchase_order = 'AKDN-80140'
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
where o.purchase_order = 'AKDN-80140' and oi.sequential = '10' and oi.material = '224-867'
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
) select id, '10', '224-884', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000157', 'SUP-541716', 'B0MVZQ3K37', 2, 'EA', 614.52, 66.22, 132.44
from public.orders where purchase_order = 'AKDN-80141'
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
where o.purchase_order = 'AKDN-80141' and oi.sequential = '10' and oi.material = '224-884'
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
) select id, '10', '224-901', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000158', 'SUP-541727', 'B0NUMYKWGE', 1, 'EA', 316.97, 66.59, 66.59
from public.orders where purchase_order = 'AKDN-80142'
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
where o.purchase_order = 'AKDN-80142' and oi.sequential = '10' and oi.material = '224-901'
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
) select id, '10', '224-918', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000159', 'SUP-541738', 'B0QU9849VL', 1, 'EA', 326.76, 66.96, 66.96
from public.orders where purchase_order = 'AKDN-80143'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-08'::date, '113-1005291-2004898', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-05-24'::date, 'Global Parcel Demo', 'DEMO00014401', '2026-05-14'::date, 'RCPT-073158', '2026-05-24'::date, '2026-05-17'::date, 'NX-041158-26',
  '2026-05-27'::date, '2026-05-29'::date, '2026-06-02'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80143' and oi.sequential = '10' and oi.material = '224-918'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '129959f0-b7b3-4ef6-a681-d00e1eb50000'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80143' and oi.sequential = '10' and oi.material = '224-918'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e6010523-d1ad-4d1c-bb7c-23868a5cec3e'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80143' and oi.sequential = '10' and oi.material = '224-918'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '6766d833-c196-4676-909d-94e41d1f265a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80143' and oi.sequential = '10' and oi.material = '224-918'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4f4a546b-2575-4dd7-99d1-e07bfea3964d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80143' and oi.sequential = '10' and oi.material = '224-918'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'e725e5c1-d4d5-448f-b239-9ef718523dac'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80143' and oi.sequential = '10' and oi.material = '224-918'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-935', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000160', 'SUP-541749', 'B0RTVFLLAT', 2, 'EA', 673.3, 67.33, 134.66
from public.orders where purchase_order = 'AKDN-80144'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-07'::date, '113-1005328-2004929', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-05-25'::date, 'UPS Demo', 'DEMO00014501', '2026-05-16'::date, 'RCPT-073159', '2026-05-25'::date, '2026-05-17'::date, 'NX-041159-26',
  '2026-05-26'::date, '2026-05-27'::date, '2026-05-28'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80144' and oi.sequential = '10' and oi.material = '224-935'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b1e8b8e4-aa31-4f02-9b89-ab4ecca90b25'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80144' and oi.sequential = '10' and oi.material = '224-935'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f6e08b30-c19c-471a-9782-6e3a1510b1bc'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80144' and oi.sequential = '10' and oi.material = '224-935'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2c7b718b-2052-4688-9a25-6106aa5bf7d7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80144' and oi.sequential = '10' and oi.material = '224-935'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '679d5641-6d74-477a-80b7-02608c2ec4b7'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80144' and oi.sequential = '10' and oi.material = '224-935'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'da844372-4908-4d4d-b465-d419dcbb1084'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80144' and oi.sequential = '10' and oi.material = '224-935'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-952', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000161', 'SUP-541760', 'B0SSHP4YP2', 1, 'EA', 346.62, 67.7, 67.7
from public.orders where purchase_order = 'AKDN-80145'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-09'::date, '113-1005365-2004960', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-05-24'::date, 'FedEx Demo', 'DEMO00014601', '2026-05-18'::date, 'RCPT-073160', '2026-05-24'::date, '2026-05-20'::date, 'NX-041160-26',
  '2026-05-26'::date, '2026-05-28'::date, '2026-05-30'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80145' and oi.sequential = '10' and oi.material = '224-952'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '44de4b74-7879-41c0-829a-cf08b0efbd3e'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80145' and oi.sequential = '10' and oi.material = '224-952'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '29dccc25-5809-4736-9d94-e5ec068ba7d0'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80145' and oi.sequential = '10' and oi.material = '224-952'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '7c13673d-80a4-4f47-ac3b-c6d9d0994d9b'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80145' and oi.sequential = '10' and oi.material = '224-952'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '71ce96f5-68f8-42a2-b76b-fdac2e1c5385'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80145' and oi.sequential = '10' and oi.material = '224-952'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0d486497-2af5-41d0-b89f-e88b3358f6ad'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80145' and oi.sequential = '10' and oi.material = '224-952'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-969', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000162', 'SUP-541771', 'B0TS5XLB49', 1, 'EA', 299.51, 68.07, 68.07
from public.orders where purchase_order = 'AKDN-80146'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-10'::date, '113-1005402-2004991', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-05-27'::date, 'Global Parcel Demo', 'DEMO00014701', '2026-05-19'::date, 'RCPT-073161', '2026-05-27'::date, '2026-05-22'::date, 'NX-041161-26',
  '2026-05-30'::date, '2026-05-31'::date, '2026-06-03'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80146' and oi.sequential = '10' and oi.material = '224-969'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '09ca63b4-8153-4f99-8503-6c9b23d04942'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80146' and oi.sequential = '10' and oi.material = '224-969'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0b63da21-ddfa-4fd4-bba9-eb342fa6378f'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-31'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80146' and oi.sequential = '10' and oi.material = '224-969'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd3e67f06-3069-49df-af89-ef47e9228beb'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80146' and oi.sequential = '10' and oi.material = '224-969'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2ec132bd-c5a5-462d-a68b-d8dbf693137d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80146' and oi.sequential = '10' and oi.material = '224-969'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '79249879-840e-4f32-a596-c2c22c53d476'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-19'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80146' and oi.sequential = '10' and oi.material = '224-969'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '224-986', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000163', 'SUP-541782', 'B0URR65NHG', 2, 'EA', 618.7, 68.44, 136.88
from public.orders where purchase_order = 'AKDN-80147'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-09'::date, '113-1005439-2005022', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-05-21'::date, 'UPS Demo', 'DEMO00014801', '2026-05-14'::date, 'RCPT-073162', '2026-05-21'::date, '2026-05-15'::date, 'NX-041162-26',
  '2026-05-22'::date, '2026-05-24'::date, '2026-05-28'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80147' and oi.sequential = '10' and oi.material = '224-986'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a04966d4-0bd0-4324-a8b9-f88dede651d8'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80147' and oi.sequential = '10' and oi.material = '224-986'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4542d96a-8dcb-4468-925a-07c62408a1de'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80147' and oi.sequential = '10' and oi.material = '224-986'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '00c7ea32-9e80-4922-9f4d-0c36f5eac34d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80147' and oi.sequential = '10' and oi.material = '224-986'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'ac211def-86f5-4b3d-8f7c-52c6e98836ee'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-15'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80147' and oi.sequential = '10' and oi.material = '224-986'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'aa78ac4b-87a9-474a-be11-e91fa39b2717'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-14'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80147' and oi.sequential = '10' and oi.material = '224-986'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-003', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000164', 'SUP-541793', 'B0WQEEMZWP', 1, 'EA', 319.28, 68.81, 68.81
from public.orders where purchase_order = 'AKDN-80148'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-11'::date, '113-1005476-2005053', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-05-25'::date, 'FedEx Demo', 'DEMO00014901', '2026-05-16'::date, 'RCPT-073163', '2026-05-25'::date, '2026-05-18'::date, 'NX-041163-26',
  '2026-05-27'::date, '2026-05-28'::date, '2026-05-29'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80148' and oi.sequential = '10' and oi.material = '225-003'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f4de7f39-8b71-431a-a869-c6b6c3a3360b'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80148' and oi.sequential = '10' and oi.material = '225-003'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '04aff044-4097-45fa-a12e-dc83b46ea042'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-28'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80148' and oi.sequential = '10' and oi.material = '225-003'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '094002de-e30d-4b6a-9483-c468e5317027'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80148' and oi.sequential = '10' and oi.material = '225-003'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0b9a0de8-0cad-49bb-aaed-b266a5753de8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80148' and oi.sequential = '10' and oi.material = '225-003'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '451f8d74-e853-454f-a770-2892d1986419'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80148' and oi.sequential = '10' and oi.material = '225-003'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-020', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000165', 'SUP-541804', 'B0XQ2N5CBV', 1, 'EA', 329.3, 69.18, 69.18
from public.orders where purchase_order = 'AKDN-80149'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-13'::date, '113-1005513-2005084', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-05-29'::date, 'Global Parcel Demo', 'DEMO00015001', '2026-05-18'::date, 'RCPT-073164', '2026-05-29'::date, '2026-05-21'::date, 'NX-041164-26',
  '2026-06-01'::date, '2026-06-03'::date, '2026-06-05'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80149' and oi.sequential = '10' and oi.material = '225-020'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dd3099dc-1481-4ab2-a2fb-58025a9c7f1b'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-05'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80149' and oi.sequential = '10' and oi.material = '225-020'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '93abb626-45fd-4db6-9d26-30b33da01fea'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-03'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80149' and oi.sequential = '10' and oi.material = '225-020'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '27ad1704-c3f6-4a61-9c9d-01796ea41f79'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80149' and oi.sequential = '10' and oi.material = '225-020'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'bf1ef30d-5b14-447b-bfd4-fa6194ddbdb8'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80149' and oi.sequential = '10' and oi.material = '225-020'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'dcc1afd7-3fd6-4dd1-9217-11a0f43bb9d0'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-18'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80149' and oi.sequential = '10' and oi.material = '225-020'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-037', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000166', 'SUP-541815', 'B0YPNVMPR4', 2, 'EA', 678.81, 69.55, 139.1
from public.orders where purchase_order = 'AKDN-80150'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-12'::date, '113-1005550-2005115', 'Demo Commerce Group', 'Closed', 'Renata Alves',
  'Delivered', '2026-05-25'::date, 'UPS Demo', 'DEMO00015101', '2026-05-20'::date, 'RCPT-073165', '2026-05-25'::date, '2026-05-21'::date, 'NX-041165-26',
  '2026-05-26'::date, '2026-05-27'::date, '2026-05-30'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80150' and oi.sequential = '10' and oi.material = '225-037'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8d48b7ef-888c-4cea-a128-28be5ede00d9'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-05-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80150' and oi.sequential = '10' and oi.material = '225-037'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '59ad38f9-16da-438e-ae2d-7516b445c753'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-05-27'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80150' and oi.sequential = '10' and oi.material = '225-037'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2374388d-b985-4431-980d-0d7a48ee9ad6'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80150' and oi.sequential = '10' and oi.material = '225-037'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '26d72ddd-797f-4122-89da-113291308fe4'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-21'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80150' and oi.sequential = '10' and oi.material = '225-037'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '31ee48e3-2d3d-4908-82c2-0ee1f06e16e3'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80150' and oi.sequential = '10' and oi.material = '225-037'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-054', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000167', 'SUP-541826', 'B0ZPA5636B', 1, 'EA', 349.6, 69.92, 69.92
from public.orders where purchase_order = 'AKDN-80151'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-14'::date, '113-1005587-2005146', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-05-29'::date, 'FedEx Demo', 'DEMO00015201', '2026-05-22'::date, 'RCPT-073166', '2026-05-29'::date, '2026-05-24'::date, 'NX-041166-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80151' and oi.sequential = '10' and oi.material = '225-054'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4688e5a4-0285-455f-b314-ad95a7879d2c'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80151' and oi.sequential = '10' and oi.material = '225-054'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'fbc60e04-12d6-401f-974d-d5bc0167a42d'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-24'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80151' and oi.sequential = '10' and oi.material = '225-054'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c21423ed-2beb-437a-a1cc-b937d6addfc8'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80151' and oi.sequential = '10' and oi.material = '225-054'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-071', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000168', 'SUP-541837', 'B02NWDNEKJ', 1, 'EA', 359.88, 70.29, 70.29
from public.orders where purchase_order = 'AKDN-80152'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-15'::date, '113-1005624-2005177', 'Demo Commerce Group', 'Open', 'Marina Torres',
  'In Transit', '2026-06-01'::date, 'Global Parcel Demo', 'DEMO00015301', '2026-05-23'::date, 'RCPT-073167', '2026-06-01'::date, '2026-05-26'::date, 'NX-041167-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80152' and oi.sequential = '10' and oi.material = '225-071'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f1875a38-95c9-4e69-b9a0-9846da199489'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80152' and oi.sequential = '10' and oi.material = '225-071'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '966e222e-bea6-45b2-b657-ad2c0a5df578'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80152' and oi.sequential = '10' and oi.material = '225-071'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'cb10391e-d264-467d-b7ee-fcd11a8f9dd6'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-23'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80152' and oi.sequential = '10' and oi.material = '225-071'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-088', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000169', 'SUP-541848', 'B03MJL6RYR', 2, 'EA', 621.81, 70.66, 141.32
from public.orders where purchase_order = 'AKDN-80153'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-14'::date, '113-1005661-2005208', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'In Transit', '2026-06-02'::date, 'UPS Demo', 'DEMO00015401', '2026-05-25'::date, 'RCPT-073168', '2026-06-02'::date, '2026-05-26'::date, 'NX-041168-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80153' and oi.sequential = '10' and oi.material = '225-088'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '86ed1d30-7395-40e8-952e-1910b8c47df1'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-02'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80153' and oi.sequential = '10' and oi.material = '225-088'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '35b4456d-8e1c-42ae-a13c-3f8b15e50a90'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-26'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80153' and oi.sequential = '10' and oi.material = '225-088'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f899e821-17b7-4daa-ac80-965d3e189d4e'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80153' and oi.sequential = '10' and oi.material = '225-088'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-105', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000170', 'SUP-541859', 'B05M6UN4DY', 1, 'EA', 321.06, 71.03, 71.03
from public.orders where purchase_order = 'AKDN-80154'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-16'::date, '113-1005698-2005239', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'In Transit', '2026-05-30'::date, 'FedEx Demo', 'DEMO00015501', '2026-05-20'::date, 'RCPT-073169', '2026-05-30'::date, '2026-05-22'::date, 'NX-041169-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80154' and oi.sequential = '10' and oi.material = '225-105'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '2a163975-5a26-4452-bc39-6dc5b37107f0'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80154' and oi.sequential = '10' and oi.material = '225-105'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f74e191e-1bb8-4fd2-b3a9-4658667f54ff'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80154' and oi.sequential = '10' and oi.material = '225-105'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '3b09c1c0-a02f-4fd0-b894-e6501fb44f72'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-20'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80154' and oi.sequential = '10' and oi.material = '225-105'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-122', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000171', 'SUP-541870', 'B06LS47FS6', 1, 'EA', 331.3, 71.4, 71.4
from public.orders where purchase_order = 'AKDN-80155'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-18'::date, '113-1005735-2005270', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'In Transit', '2026-05-29'::date, 'Global Parcel Demo', 'DEMO00015601', '2026-05-22'::date, 'RCPT-073170', '2026-05-29'::date, '2026-05-25'::date, 'NX-041170-26',
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80155' and oi.sequential = '10' and oi.material = '225-122'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '1a6043d8-0874-49f0-ba85-27e5e3cd546c'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-05-29'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80155' and oi.sequential = '10' and oi.material = '225-122'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'b5e172c3-4f67-4b65-8182-c9ad7aa2c989'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-05-25'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80155' and oi.sequential = '10' and oi.material = '225-122'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'a13b36ef-3ee7-4f49-9c7e-4bbd6e150949'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-22'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80155' and oi.sequential = '10' and oi.material = '225-122'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-139', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000172', 'SUP-541881', 'B07KEBPS7D', 2, 'EA', 683.25, 71.77, 143.54
from public.orders where purchase_order = 'AKDN-80156'
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
where o.purchase_order = 'AKDN-80156' and oi.sequential = '10' and oi.material = '225-139'
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
) select id, '10', '225-156', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000173', 'SUP-541892', 'B08K3K75LL', 1, 'EA', 352.04, 72.14, 72.14
from public.orders where purchase_order = 'AKDN-80157'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-19'::date, '113-1005809-2005332', 'Demo Commerce Group', 'Open', 'Caio Nunes',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80157' and oi.sequential = '10' and oi.material = '225-156'
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
) select id, '10', '225-173', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000174', 'SUP-541903', 'B09JPTPHZT', 1, 'EA', 362.55, 72.51, 72.51
from public.orders where purchase_order = 'AKDN-80158'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-21'::date, '113-1005846-2005363', 'Demo Commerce Group', 'Open', 'Renata Alves',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80158' and oi.sequential = '10' and oi.material = '225-173'
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
) select id, '10', '225-190', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000175', 'SUP-541914', 'B0AJB28UE2', 2, 'EA', 746.29, 72.88, 145.76
from public.orders where purchase_order = 'AKDN-80159'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-19'::date, '113-1005883-2005394', 'Demo Commerce Group', 'Open', 'Lucas Monteiro',
  'Preparing', null::date, null, null, null::date, null, null::date, null::date, null,
  null::date, null::date, null::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80159' and oi.sequential = '10' and oi.material = '225-190'
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
) select id, '10', '225-207', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000176', 'SUP-541925', 'B0CHXAQ7T9', 1, 'EA', 322.3, 73.25, 73.25
from public.orders where purchase_order = 'AKDN-80160'
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
where o.purchase_order = 'AKDN-80160' and oi.sequential = '10' and oi.material = '225-207'
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
) select id, '10', '225-224', 'MOTION LABS CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'GM9-000177', 'SUP-541936', 'B0DGKJ8J9F', 1, 'EA', 332.76, 73.62, 73.62
from public.orders where purchase_order = 'AKDN-80161'
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
where o.purchase_order = 'AKDN-80161' and oi.sequential = '10' and oi.material = '225-224'
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
) select id, '10', '225-241', 'NOVAWAVE FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'GM9-000178', 'SUP-541947', 'B0EG7RQVNN', 2, 'EA', 686.63, 73.99, 147.98
from public.orders where purchase_order = 'AKDN-80162'
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
where o.purchase_order = 'AKDN-80162' and oi.sequential = '10' and oi.material = '225-241'
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
) select id, '10', '225-258', 'SOLARIS HOME FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'GM9-000179', 'SUP-541958', 'B0FFTZ983V', 1, 'EA', 353.95, 74.36, 74.36
from public.orders where purchase_order = 'AKDN-80163'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-24'::date, '113-1006031-2005518', 'Demo Commerce Group', 'Closed', 'Lucas Monteiro',
  'Delivered', '2026-06-08'::date, 'FedEx Demo', 'DEMO00016401', '2026-05-30'::date, 'RCPT-073178', '2026-06-08'::date, '2026-06-01'::date, 'NX-041178-26',
  '2026-06-10'::date, '2026-06-12'::date, '2026-06-16'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80163' and oi.sequential = '10' and oi.material = '225-258'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c7507850-4d26-461d-8f11-2cfcdcda635b'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80163' and oi.sequential = '10' and oi.material = '225-258'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '790a871e-a0f9-4201-adf2-4612ad948365'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80163' and oi.sequential = '10' and oi.material = '225-258'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'c344b2a5-7e94-42bd-830b-500831a3547e'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-08'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80163' and oi.sequential = '10' and oi.material = '225-258'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '308aad8f-cbd9-4dbf-9bd7-753b13f1043a'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80163' and oi.sequential = '10' and oi.material = '225-258'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'f8d52d56-d7e6-49c0-a1f1-1dca8e247dad'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-05-30'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80163' and oi.sequential = '10' and oi.material = '225-258'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-275', 'ZENITH HOME ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'GM9-000180', 'SUP-541969', 'B0GEF9RLG4', 1, 'EA', 364.68, 74.73, 74.73
from public.orders where purchase_order = 'AKDN-80164'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-26'::date, '113-1006068-2005549', 'Demo Commerce Group', 'Closed', 'Marina Torres',
  'Delivered', '2026-06-12'::date, 'Global Parcel Demo', 'DEMO00016501', '2026-06-01'::date, 'RCPT-073179', '2026-06-12'::date, '2026-06-04'::date, 'NX-041179-26',
  '2026-06-15'::date, '2026-06-16'::date, '2026-06-17'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80164' and oi.sequential = '10' and oi.material = '225-275'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '51c89b38-df34-451e-8867-e7ef886e7f6a'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-17'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80164' and oi.sequential = '10' and oi.material = '225-275'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '53314236-2067-4563-ae5e-674b59fe85a4'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-16'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80164' and oi.sequential = '10' and oi.material = '225-275'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '0c6b6420-eef4-4903-8da4-0110324cbf4f'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Destination hub', 'Synthetic arrival at destination hub.', '2026-06-12'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80164' and oi.sequential = '10' and oi.material = '225-275'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select 'd5d70bb9-b345-4668-acda-e80a12398ec9'::uuid, o.id, oi.id, 'In Transit', 'In Transit', 'Origin hub', 'Synthetic international dispatch.', '2026-06-04'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80164' and oi.sequential = '10' and oi.material = '225-275'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '185a063d-a4a2-49fa-abf4-1fbd50daf746'::uuid, o.id, oi.id, 'Preparing', 'Preparing', 'Warehouse', 'Synthetic warehouse receipt.', '2026-06-01'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80164' and oi.sequential = '10' and oi.material = '225-275'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_items (
  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
) select id, '10', '225-292', 'VISTA DIGITAL MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'GM9-000181', 'SUP-541980', 'B0JE3G9XVB', 2, 'EA', 751, 75.1, 150.2
from public.orders where purchase_order = 'AKDN-80165'
on conflict (order_id, sequential, material) do update set
  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,
  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,
  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;

insert into public.logistics (
  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,
  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,
  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at
) select oi.id, '2026-05-25'::date, '113-1006105-2005580', 'Demo Commerce Group', 'Closed', 'Caio Nunes',
  'Delivered', '2026-06-08'::date, 'UPS Demo', 'DEMO00016601', '2026-06-03'::date, 'RCPT-073180', '2026-06-08'::date, '2026-06-04'::date, 'NX-041180-26',
  '2026-06-09'::date, '2026-06-11'::date, '2026-06-13'::date, '2026-09-04 09:00:00Z'::timestamptz
from public.order_items oi join public.orders o on o.id = oi.order_id
where o.purchase_order = 'AKDN-80165' and oi.sequential = '10' and oi.material = '225-292'
on conflict (order_item_id) do update set
  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,
  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,
  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,
  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,
  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,
  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,
  last_source_sync_at = excluded.last_source_sync_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '8904fedd-9c5f-484f-81de-c7cac7f5406c'::uuid, o.id, oi.id, 'Delivered', 'Delivered', 'Customer destination', 'Synthetic delivery confirmation.', '2026-06-13'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80165' and oi.sequential = '10' and oi.material = '225-292'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)
select '4f5d11ea-a1d8-4b4c-8e6a-96cd79ba919c'::uuid, o.id, oi.id, 'Out for Delivery', 'Out for Delivery', 'Distribution center', 'Synthetic distribution-center dispatch.', '2026-06-11'::timestamptz
from public.orders o join public.order_items oi on oi.order_id = o.id
where o.purchase_order = 'AKDN-80165' and oi.sequential = '10' and oi.material = '225-292'
on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;

commit;
