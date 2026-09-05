import pg from 'pg';
import type { Order, OrderStatus, ShipmentStatus } from '../src/types';

const { Pool } = pg;

let pool: pg.Pool | null = null;

const iso = (value: unknown): string | undefined => {
  if (!value) return undefined;
  if (value instanceof Date) return value.toISOString();
  return String(value);
};

const dateOnly = (value: unknown): string | undefined => iso(value)?.slice(0, 10);

export const postgresEnabled = () =>
  String(process.env.DATA_SOURCE || '').toLowerCase() === 'postgres' && Boolean(process.env.DATABASE_URL);

export async function loadOrdersFromPostgres(): Promise<Order[]> {
  if (!postgresEnabled()) return [];

  pool = new Pool({
    connectionString: process.env.DATABASE_URL,
    ssl: String(process.env.DATABASE_SSL || 'true').toLowerCase() === 'true'
      ? { rejectUnauthorized: false }
      : undefined,
    max: 5,
    idleTimeoutMillis: 30_000,
    connectionTimeoutMillis: 10_000,
  });

  const client = await pool.connect();
  try {
    await client.query('select 1');
    const result = await client.query(`
      select
        o.id as database_order_id,
        o.purchase_order,
        o.customer_order_id,
        o.customer_name,
        o.purchase_date,
        o.seller,
        o.seller_country,
        o.status,
        o.status_text,
        o.delivery_limit_days,
        o.purchase_confirmed,
        o.purchase_confirmed_at,
        o.cancellation_reason,
        o.cancelled_at,
        o.created_at as order_created_at,
        o.updated_at as order_updated_at,
        oi.id as database_item_id,
        oi.sequential,
        oi.material,
        oi.description,
        oi.gm9,
        oi.supplier_material,
        oi.asin,
        oi.quantity,
        oi.unit_measure,
        oi.vkp2_brl,
        oi.seller_unit_usd,
        oi.seller_total_usd,
        l.marketplace_order_date,
        l.marketplace_order_id,
        l.account_group,
        l.account_order_status,
        l.account_user,
        l.delivery_status,
        l.expected_delivery_date,
        l.carrier,
        l.carrier_tracking,
        l.wr_date,
        l.warehouse_receipt,
        l.eta,
        l.etd,
        l.invoice,
        l.di_date,
        l.entry_cd_date,
        l.customer_delivery_date,
        l.last_source_sync_at,
        coalesce((
          select json_agg(json_build_object(
            'id', e.id,
            'timestamp', e.occurred_at,
            'location', e.event_location,
            'status', e.event_status,
            'description', e.description
          ) order by e.occurred_at desc)
          from public.order_events e
          where e.order_item_id = oi.id
        ), '[]'::json) as events
      from public.orders o
      join public.order_items oi on oi.order_id = o.id
      left join public.logistics l on l.order_item_id = oi.id
      order by o.purchase_date desc, o.purchase_order, oi.sequential
    `);

    return result.rows.map((row): Order => {
      const status = row.status as OrderStatus;
      const shipmentStatus = (row.delivery_status || (
        status === 'Delivered' ? 'Delivered' :
        status === 'Cancelled' ? 'Cancelled' :
        status === 'Shipped' ? 'In Transit' : 'Preparing'
      )) as ShipmentStatus;
      const customerDelivery = dateOnly(row.customer_delivery_date);
      const syncTime = iso(row.last_source_sync_at) || iso(row.order_updated_at) || new Date().toISOString();

      return {
        id: `${row.purchase_order}-${row.sequential}-${row.material}`,
        date_order: dateOnly(row.purchase_date) || '',
        customer_name: row.customer_name,
        customer_email: '',
        sku: row.material,
        product_name: row.description,
        asin: row.asin || '',
        price_unit: Number(row.seller_unit_usd || 0),
        quantity: Number(row.quantity || 0),
        total_price: Number(row.seller_total_usd || 0),
        status,
        marketplace: row.seller,
        shipment: {
          is_shipped: status === 'Shipped' || status === 'Delivered',
          carrier: row.carrier || '',
          tracking_number: row.carrier_tracking || '',
          estimated_delivery: dateOnly(row.expected_delivery_date) || '',
          actual_delivery_date: customerDelivery || null,
          shipment_status: shipmentStatus,
          databricks_sync_time: syncTime,
          destination: 'Customer destination',
          origin_hub: row.seller_country || '',
          events: Array.isArray(row.events) ? row.events.map((event: any) => ({
            id: String(event.id),
            timestamp: iso(event.timestamp) || '',
            location: event.location || '',
            status: event.status as ShipmentStatus,
            description: event.description || '',
          })) : [],
        },
        created_at: iso(row.order_created_at) || new Date().toISOString(),
        updated_at: iso(row.order_updated_at) || new Date().toISOString(),
        purchase_order: row.purchase_order,
        customer_order_id: row.customer_order_id,
        vkp2_price: Number(row.vkp2_brl || 0),
        seller_usd_total: Number(row.seller_total_usd || 0),
        seller_country: row.seller_country || '',
        invoice: row.invoice || undefined,
        magaya_wr: row.warehouse_receipt || undefined,
        destination_hub: 'Demo Distribution Center',
        delivery_client_date: customerDelivery,
        entry_cd_date: dateOnly(row.entry_cd_date),
        sequencial: row.sequential,
        sts_compra: status === 'Delivered' ? 'ENTREGUE' : status === 'Cancelled' ? 'CANCELADO' : 'COMPRADO',
        unit_measure: row.unit_measure,
        operational_status: status === 'Cancelled' ? 'CANCELLED' : status === 'Delivered' ? 'DELIVERED' : 'ACTIVE',
        status_text: row.status_text || '',
        delivery_limit_days: Number(row.delivery_limit_days || 25),
        marketplace_order_date: dateOnly(row.marketplace_order_date),
        marketplace_order_id: row.marketplace_order_id || undefined,
        account_group: row.account_group || undefined,
        account_order_status: row.account_order_status || undefined,
        account_user: row.account_user || undefined,
        wr_date: dateOnly(row.wr_date),
        eta: dateOnly(row.eta),
        etd: dateOnly(row.etd),
        di_date: dateOnly(row.di_date),
        marketplace_purchase_confirmed: Boolean(row.purchase_confirmed),
        marketplace_purchase_confirmed_at: iso(row.purchase_confirmed_at),
        cancellation_reason: row.cancellation_reason || undefined,
        cancellation_updated_at: iso(row.cancelled_at),
      };
    });
  } finally {
    client.release();
  }
}

export async function closePostgresPool() {
  if (pool) await pool.end();
  pool = null;
}

const requirePool = () => {
  if (!pool || !postgresEnabled()) throw new Error('PostgreSQL is not connected.');
  return pool;
};

export async function savePurchaseConfirmationToPostgres(
  purchaseOrder: string,
  confirmed: boolean,
  confirmedAt: string | null,
  confirmedBy?: string,
) {
  const db = requirePool();
  const client = await db.connect();
  try {
    await client.query('begin');
    const updated = await client.query(
      `update public.orders
       set purchase_confirmed = $2, purchase_confirmed_at = $3, updated_at = now()
       where purchase_order = $1
       returning id`,
      [purchaseOrder, confirmed, confirmedAt],
    );
    if (!updated.rowCount) throw new Error(`Order ${purchaseOrder} was not found in PostgreSQL.`);
    await client.query(
      `insert into public.purchase_confirmation_history (order_id, confirmed, confirmed_by, confirmed_at)
       values ($1, $2, $3, coalesce($4::timestamptz, now()))`,
      [updated.rows[0].id, confirmed, confirmedBy || 'Dashboard user', confirmedAt],
    );
    await client.query('commit');
  } catch (error) {
    await client.query('rollback');
    throw error;
  } finally {
    client.release();
  }
}

export async function saveCancellationToPostgres(
  purchaseOrder: string,
  reason: string,
  cancelledAt: string,
  cancelledBy?: string,
) {
  const db = requirePool();
  const client = await db.connect();
  try {
    await client.query('begin');
    const updated = await client.query(
      `update public.orders
       set status = 'Cancelled', status_text = $2, cancellation_reason = $2,
           cancelled_at = $3, purchase_confirmed = false, purchase_confirmed_at = null, updated_at = now()
       where purchase_order = $1
       returning id`,
      [purchaseOrder, reason, cancelledAt],
    );
    if (!updated.rowCount) throw new Error(`Order ${purchaseOrder} was not found in PostgreSQL.`);
    await client.query(
      `insert into public.cancellation_history (order_id, reason, source, cancelled_by, cancelled_at)
       values ($1, $2, 'manual', $3, $4::timestamptz)`,
      [updated.rows[0].id, reason, cancelledBy || 'Dashboard user', cancelledAt],
    );
    await client.query(
      `update public.logistics l
       set delivery_status = 'Cancelled', updated_at = now()
       from public.order_items oi
       where l.order_item_id = oi.id and oi.order_id = $1`,
      [updated.rows[0].id],
    );
    await client.query('commit');
  } catch (error) {
    await client.query('rollback');
    throw error;
  } finally {
    client.release();
  }
}

export async function insertOrdersToPostgres(items: Order[]) {
  if (!items.length) return;
  const db = requirePool();
  const client = await db.connect();
  try {
    await client.query('begin');
    for (const item of items) {
      const purchaseOrder = item.purchase_order || item.id;
      const orderResult = await client.query(
        `insert into public.orders (
           purchase_order, customer_order_id, customer_name, purchase_date,
           seller, seller_country, status, status_text, delivery_limit_days,
           purchase_confirmed, purchase_confirmed_at, cancellation_reason, cancelled_at
         ) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13)
         on conflict (purchase_order) do update set
           customer_order_id = excluded.customer_order_id,
           customer_name = excluded.customer_name,
           seller = excluded.seller,
           seller_country = excluded.seller_country,
           status = excluded.status,
           status_text = excluded.status_text,
           updated_at = now()
         returning id`,
        [
          purchaseOrder,
          item.customer_order_id || purchaseOrder,
          item.customer_name,
          item.date_order.slice(0, 10),
          item.marketplace,
          item.seller_country || null,
          item.status,
          item.status_text || null,
          item.delivery_limit_days || 25,
          Boolean(item.marketplace_purchase_confirmed),
          item.marketplace_purchase_confirmed_at || null,
          item.cancellation_reason || null,
          item.cancellation_updated_at || null,
        ],
      );
      const orderDatabaseId = orderResult.rows[0].id;
      const itemResult = await client.query(
        `insert into public.order_items (
           order_id, sequential, material, description, gm9, supplier_material,
           asin, quantity, unit_measure, vkp2_brl, seller_unit_usd, seller_total_usd
         ) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12)
         on conflict (order_id, sequential, material) do update set
           description = excluded.description,
           asin = excluded.asin,
           quantity = excluded.quantity,
           unit_measure = excluded.unit_measure,
           vkp2_brl = excluded.vkp2_brl,
           seller_unit_usd = excluded.seller_unit_usd,
           seller_total_usd = excluded.seller_total_usd,
           updated_at = now()
         returning id`,
        [
          orderDatabaseId,
          item.sequencial || '10',
          item.sku,
          item.product_name,
          null,
          null,
          item.asin || null,
          item.quantity,
          item.unit_measure || 'PEÇ',
          item.vkp2_price || 0,
          item.price_unit || 0,
          item.seller_usd_total ?? item.total_price,
        ],
      );
      const itemDatabaseId = itemResult.rows[0].id;
      await client.query(
        `insert into public.logistics (
           order_item_id, marketplace_order_date, marketplace_order_id,
           account_group, account_order_status, account_user, delivery_status,
           expected_delivery_date, carrier, carrier_tracking, wr_date,
           warehouse_receipt, eta, etd, invoice, di_date, entry_cd_date,
           customer_delivery_date, last_source_sync_at
         ) values ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10,$11,$12,$13,$14,$15,$16,$17,$18,$19)
         on conflict (order_item_id) do update set
           delivery_status = excluded.delivery_status,
           expected_delivery_date = excluded.expected_delivery_date,
           carrier = excluded.carrier,
           carrier_tracking = excluded.carrier_tracking,
           wr_date = excluded.wr_date,
           warehouse_receipt = excluded.warehouse_receipt,
           eta = excluded.eta,
           etd = excluded.etd,
           invoice = excluded.invoice,
           di_date = excluded.di_date,
           entry_cd_date = excluded.entry_cd_date,
           customer_delivery_date = excluded.customer_delivery_date,
           last_source_sync_at = excluded.last_source_sync_at,
           updated_at = now()`,
        [
          itemDatabaseId,
          item.marketplace_order_date || null,
          item.marketplace_order_id || null,
          item.account_group || null,
          item.account_order_status || null,
          item.account_user || null,
          item.shipment.shipment_status,
          item.shipment.estimated_delivery?.slice(0, 10) || null,
          item.shipment.carrier || null,
          item.shipment.tracking_number || null,
          item.wr_date || null,
          item.magaya_wr || null,
          item.eta || null,
          item.etd || null,
          item.invoice || null,
          item.di_date || null,
          item.entry_cd_date || null,
          item.delivery_client_date || null,
          item.shipment.databricks_sync_time || null,
        ],
      );
    }
    await client.query('commit');
  } catch (error) {
    await client.query('rollback');
    throw error;
  } finally {
    client.release();
  }
}

export async function saveOrderStateToPostgres(items: Order[]) {
  if (!items.length) return;
  const db = requirePool();
  const client = await db.connect();
  const summary = items[0];
  const purchaseOrder = summary.purchase_order || summary.id;
  try {
    await client.query('begin');
    const updated = await client.query(
      `update public.orders
       set status = $2, status_text = $3, cancellation_reason = $4,
           cancelled_at = $5, updated_at = now()
       where purchase_order = $1
       returning id`,
      [purchaseOrder, summary.status, summary.status_text || null, summary.cancellation_reason || null, summary.cancellation_updated_at || null],
    );
    if (!updated.rowCount) throw new Error(`Order ${purchaseOrder} was not found in PostgreSQL.`);

    for (const item of items) {
      await client.query(
        `update public.logistics l
         set delivery_status = $4, carrier = $5, carrier_tracking = $6,
             expected_delivery_date = $7, customer_delivery_date = $8, updated_at = now()
         from public.order_items oi
         where l.order_item_id = oi.id and oi.order_id = $1
           and oi.sequential = $2 and oi.material = $3`,
        [
          updated.rows[0].id,
          item.sequencial || '10',
          item.sku,
          item.shipment.shipment_status,
          item.shipment.carrier || null,
          item.shipment.tracking_number || null,
          item.shipment.estimated_delivery?.slice(0, 10) || null,
          item.delivery_client_date || null,
        ],
      );
    }
    await client.query('commit');
  } catch (error) {
    await client.query('rollback');
    throw error;
  } finally {
    client.release();
  }
}
