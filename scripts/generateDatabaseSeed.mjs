import fs from 'node:fs';
import crypto from 'node:crypto';

const sourcePath = new URL('../src/data/seededOrders.ts', import.meta.url);
const outputPath = new URL('../database/002_seed_demo.sql', import.meta.url);
const source = fs.readFileSync(sourcePath, 'utf8');
const records = JSON.parse(source.slice(source.indexOf(' = [') + 3, source.lastIndexOf(']') + 1));

const q = (value) => value === undefined || value === null || value === ''
  ? 'null'
  : `'${String(value).replaceAll("'", "''")}'`;
const n = (value) => Number.isFinite(Number(value)) ? String(Number(value)) : '0';
const b = (value) => value ? 'true' : 'false';
const uuid = (key) => {
  const hex = crypto.createHash('sha256').update(`marketops-demo:${key}`).digest('hex').slice(0, 32).split('');
  hex[12] = '4';
  hex[16] = ['8', '9', 'a', 'b'][Number.parseInt(hex[16], 16) % 4];
  return `${hex.slice(0, 8).join('')}-${hex.slice(8, 12).join('')}-${hex.slice(12, 16).join('')}-${hex.slice(16, 20).join('')}-${hex.slice(20).join('')}`;
};

const byPurchaseOrder = new Map();
for (const record of records) {
  const existing = byPurchaseOrder.get(record.purchase_order);
  if (!existing) byPurchaseOrder.set(record.purchase_order, record);
}

const sql = [
  '-- Fully synthetic portfolio dataset: 285 orders / 300 items.',
  '-- Safe to run again: records are updated by their stable synthetic keys.',
  'begin;',
  '',
];

for (const order of byPurchaseOrder.values()) {
  sql.push(`insert into public.orders (`);
  sql.push(`  purchase_order, customer_order_id, customer_name, purchase_date, seller, seller_country, status, status_text,`);
  sql.push(`  delivery_limit_days, purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at, created_at, updated_at`);
  sql.push(`) values (`);
  sql.push(`  ${q(order.purchase_order)}, ${q(order.customer_order_id)}, ${q(order.customer_name)}, ${q(order.date_order)}::date, ${q(order.marketplace)}, ${q(order.seller_country)}, ${q(order.status)}, ${q(order.status_text)},`);
  sql.push(`  ${n(order.delivery_limit_days || 25)}, ${b(order.marketplace_purchase_confirmed)}, ${q(order.marketplace_purchase_confirmed_at)}::timestamptz, ${q(order.cancellation_reason)}, ${q(order.cancellation_updated_at)}::timestamptz, ${q(order.created_at)}::timestamptz, ${q(order.updated_at)}::timestamptz`);
  sql.push(`) on conflict (purchase_order) do update set`);
  sql.push(`  customer_order_id = excluded.customer_order_id, customer_name = excluded.customer_name, purchase_date = excluded.purchase_date,`);
  sql.push(`  seller = excluded.seller, seller_country = excluded.seller_country, status = excluded.status, status_text = excluded.status_text,`);
  sql.push(`  delivery_limit_days = excluded.delivery_limit_days, purchase_confirmed = excluded.purchase_confirmed,`);
  sql.push(`  purchase_confirmed_at = excluded.purchase_confirmed_at, cancellation_reason = excluded.cancellation_reason, cancelled_at = excluded.cancelled_at;`);
  sql.push('');
}

for (const item of records) {
  sql.push(`insert into public.order_items (`);
  sql.push(`  order_id, sequential, material, description, gm9, supplier_material, asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd`);
  sql.push(`) select id, ${q(item.sequencial)}, ${q(item.sku)}, ${q(item.product_name)}, ${q(`GM9-${String(records.indexOf(item) + 1).padStart(6, '0')}`)}, ${q(`SUP-${540000 + records.indexOf(item) * 11}`)}, ${q(item.asin)}, ${n(item.quantity)}, ${q(item.unit_measure)}, ${n(item.vkp2_price)}, ${n(item.price_unit)}, ${n(item.seller_usd_total)}`);
  sql.push(`from public.orders where purchase_order = ${q(item.purchase_order)}`);
  sql.push(`on conflict (order_id, sequential, material) do update set`);
  sql.push(`  description = excluded.description, gm9 = excluded.gm9, supplier_material = excluded.supplier_material, asin = excluded.asin,`);
  sql.push(`  quantity = excluded.quantity, unit_measure = excluded.unit_measure, vkp2_brl = excluded.vkp2_brl,`);
  sql.push(`  seller_unit_usd = excluded.seller_unit_usd, seller_total_usd = excluded.seller_total_usd;`);
  sql.push('');

  sql.push(`insert into public.logistics (`);
  sql.push(`  order_item_id, marketplace_order_date, marketplace_order_id, account_group, account_order_status, account_user,`);
  sql.push(`  delivery_status, expected_delivery_date, carrier, carrier_tracking, wr_date, warehouse_receipt, eta, etd, invoice,`);
  sql.push(`  di_date, entry_cd_date, customer_delivery_date, last_source_sync_at`);
  sql.push(`) select oi.id, ${q(item.marketplace_order_date)}::date, ${q(item.marketplace_order_id)}, ${q(item.account_group)}, ${q(item.account_order_status)}, ${q(item.account_user)},`);
  sql.push(`  ${q(item.shipment?.shipment_status)}, ${q(item.shipment?.estimated_delivery?.slice(0, 10))}::date, ${q(item.shipment?.carrier)}, ${q(item.shipment?.tracking_number)}, ${q(item.wr_date)}::date, ${q(item.magaya_wr)}, ${q(item.eta)}::date, ${q(item.etd)}::date, ${q(item.invoice)},`);
  sql.push(`  ${q(item.di_date)}::date, ${q(item.entry_cd_date)}::date, ${q(item.delivery_client_date)}::date, ${q(item.shipment?.databricks_sync_time)}::timestamptz`);
  sql.push(`from public.order_items oi join public.orders o on o.id = oi.order_id`);
  sql.push(`where o.purchase_order = ${q(item.purchase_order)} and oi.sequential = ${q(item.sequencial)} and oi.material = ${q(item.sku)}`);
  sql.push(`on conflict (order_item_id) do update set`);
  sql.push(`  marketplace_order_date = excluded.marketplace_order_date, marketplace_order_id = excluded.marketplace_order_id,`);
  sql.push(`  account_group = excluded.account_group, account_order_status = excluded.account_order_status, account_user = excluded.account_user,`);
  sql.push(`  delivery_status = excluded.delivery_status, expected_delivery_date = excluded.expected_delivery_date, carrier = excluded.carrier,`);
  sql.push(`  carrier_tracking = excluded.carrier_tracking, wr_date = excluded.wr_date, warehouse_receipt = excluded.warehouse_receipt,`);
  sql.push(`  eta = excluded.eta, etd = excluded.etd, invoice = excluded.invoice, di_date = excluded.di_date,`);
  sql.push(`  entry_cd_date = excluded.entry_cd_date, customer_delivery_date = excluded.customer_delivery_date,`);
  sql.push(`  last_source_sync_at = excluded.last_source_sync_at;`);
  sql.push('');

  for (const event of item.shipment?.events || []) {
    const eventId = uuid(event.id);
    sql.push(`insert into public.order_events (id, order_id, order_item_id, event_type, event_status, event_location, description, occurred_at)`);
    sql.push(`select ${q(eventId)}::uuid, o.id, oi.id, ${q(event.status)}, ${q(event.status)}, ${q(event.location)}, ${q(event.description)}, ${q(event.timestamp)}::timestamptz`);
    sql.push(`from public.orders o join public.order_items oi on oi.order_id = o.id`);
    sql.push(`where o.purchase_order = ${q(item.purchase_order)} and oi.sequential = ${q(item.sequencial)} and oi.material = ${q(item.sku)}`);
    sql.push(`on conflict (id) do update set event_status = excluded.event_status, event_location = excluded.event_location, description = excluded.description, occurred_at = excluded.occurred_at;`);
    sql.push('');
  }
}

for (const order of byPurchaseOrder.values()) {
  if (order.marketplace_purchase_confirmed) {
    sql.push(`insert into public.purchase_confirmation_history (id, order_id, confirmed, confirmed_by, confirmed_at)`);
    sql.push(`select ${q(uuid(`confirmation:${order.purchase_order}`))}::uuid, id, true, ${q(order.account_user)}, ${q(order.marketplace_purchase_confirmed_at)}::timestamptz from public.orders where purchase_order = ${q(order.purchase_order)}`);
    sql.push(`on conflict (id) do nothing;`);
    sql.push('');
  }
  if (order.status === 'Cancelled') {
    sql.push(`insert into public.cancellation_history (id, order_id, reason, source, cancelled_by, cancelled_at)`);
    sql.push(`select ${q(uuid(`cancellation:${order.purchase_order}`))}::uuid, id, ${q(order.cancellation_reason || 'Synthetic cancellation')}, 'seed', ${q(order.account_user)}, ${q(order.cancellation_updated_at)}::timestamptz from public.orders where purchase_order = ${q(order.purchase_order)}`);
    sql.push(`on conflict (id) do nothing;`);
    sql.push('');
  }
}

sql.push('commit;');
sql.push('');
sql.push('-- Expected validation result: 285 orders, 300 items, 300 logistics rows.');
sql.push(`select`);
sql.push(`  (select count(*) from public.orders) as orders,`);
sql.push(`  (select count(*) from public.order_items) as order_items,`);
sql.push(`  (select count(*) from public.logistics) as logistics;`);

fs.writeFileSync(outputPath, `${sql.join('\n')}\n`, 'utf8');
console.log(`Generated ${outputPath.pathname} with ${byPurchaseOrder.size} orders and ${records.length} items.`);
