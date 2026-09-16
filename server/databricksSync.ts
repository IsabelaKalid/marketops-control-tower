import type { Order, OrderStatus, ShipmentStatus } from '../src/types';

type StatementParameter = {
  name: string;
  value?: string | null;
  type?: string;
};

type StatementResponse = {
  statement_id?: string;
  status?: { state?: string; error?: { message?: string } };
  manifest?: { schema?: { columns?: Array<{ name?: string }> }; total_chunk_count?: number };
  result?: { data_array?: unknown[][]; next_chunk_index?: number };
};

const envText = (name: string) => String(process.env[name] || '').trim();

const cleanHost = () => envText('DATABRICKS_HOST').replace(/\/+$/, '').replace(/^https?:\/\//, '');

const warehouseId = () => {
  const explicit = envText('DATABRICKS_WAREHOUSE_ID');
  if (explicit) return explicit;
  const httpPath = envText('DATABRICKS_HTTP_PATH');
  const match = httpPath.match(/\/warehouses\/([^/?#]+)/i);
  return match?.[1] || '';
};

const safeIdentifier = (value: string, label: string) => {
  if (!/^[A-Za-z0-9_-]+$/.test(value)) {
    throw new Error(`${label} do Databricks contém caracteres não permitidos.`);
  }
  return `\`${value}\``;
};

export const databricksSyncEnabled = () =>
  String(process.env.DATABRICKS_SYNC_ENABLED || '').toLowerCase() === 'true'
  && Boolean(cleanHost())
  && Boolean(envText('DATABRICKS_TOKEN'))
  && Boolean(warehouseId())
  && Boolean(envText('DATABRICKS_CATALOG'))
  && Boolean(envText('DATABRICKS_SCHEMA'))
  && Boolean(envText('DATABRICKS_TABLE'));

export const databricksTableName = () => {
  const catalog = safeIdentifier(envText('DATABRICKS_CATALOG'), 'Catálogo');
  const schema = safeIdentifier(envText('DATABRICKS_SCHEMA'), 'Schema');
  const table = safeIdentifier(envText('DATABRICKS_TABLE'), 'Tabela');
  return `${catalog}.${schema}.${table}`;
};

const apiUrl = (suffix = '') => `https://${cleanHost()}/api/2.0/sql/statements${suffix}`;

const requestJson = async (url: string, init: RequestInit): Promise<any> => {
  const response = await fetch(url, {
    ...init,
    headers: {
      Authorization: `Bearer ${envText('DATABRICKS_TOKEN')}`,
      'Content-Type': 'application/json',
      ...(init.headers || {}),
    },
  });
  const text = await response.text();
  let data: any = {};
  try { data = text ? JSON.parse(text) : {}; } catch { data = { raw: text }; }
  if (!response.ok) {
    throw new Error(`Databricks HTTP ${response.status}: ${data?.message || data?.error_code || text || 'erro desconhecido'}`);
  }
  return data;
};

const waitForStatement = async (initial: StatementResponse): Promise<StatementResponse> => {
  let payload = initial;
  const id = payload.statement_id;
  if (!id) return payload;

  for (let attempt = 0; attempt < 24; attempt += 1) {
    const state = payload.status?.state;
    if (state === 'SUCCEEDED') return payload;
    if (state === 'FAILED' || state === 'CANCELED' || state === 'CLOSED') {
      throw new Error(payload.status?.error?.message || `Databricks statement terminou com status ${state}.`);
    }
    await new Promise(resolve => setTimeout(resolve, 1250));
    payload = await requestJson(apiUrl(`/${id}`), { method: 'GET' });
  }
  throw new Error('Tempo limite aguardando a consulta do Databricks.');
};

export async function executeDatabricksStatement(
  statement: string,
  parameters: StatementParameter[] = [],
): Promise<{ columns: string[]; rows: unknown[][]; raw: StatementResponse }> {
  if (!databricksSyncEnabled()) throw new Error('Integração Databricks não está configurada.');

  const body: Record<string, unknown> = {
    warehouse_id: warehouseId(),
    catalog: envText('DATABRICKS_CATALOG'),
    schema: envText('DATABRICKS_SCHEMA'),
    statement,
    parameters,
    wait_timeout: '30s',
    on_wait_timeout: 'CONTINUE',
    disposition: 'INLINE',
    format: 'JSON_ARRAY',
    byte_limit: 20 * 1024 * 1024,
  };

  let payload: StatementResponse = await requestJson(apiUrl(), {
    method: 'POST',
    body: JSON.stringify(body),
  });
  payload = await waitForStatement(payload);

  const columns = (payload.manifest?.schema?.columns || []).map(column => String(column.name || ''));
  const rows: unknown[][] = [...(payload.result?.data_array || [])];
  let nextChunk = payload.result?.next_chunk_index;
  while (nextChunk !== undefined && payload.statement_id) {
    const chunk: StatementResponse = await requestJson(
      apiUrl(`/${payload.statement_id}/result/chunks/${nextChunk}`),
      { method: 'GET' },
    );
    rows.push(...(chunk.result?.data_array || []));
    nextChunk = chunk.result?.next_chunk_index;
  }

  return { columns, rows, raw: payload };
}

const asString = (value: unknown): string => value === null || value === undefined ? '' : String(value).trim();
const optional = (value: unknown): string | undefined => asString(value) || undefined;
const numberValue = (value: unknown): number => {
  const parsed = Number(value ?? 0);
  return Number.isFinite(parsed) ? parsed : 0;
};
const boolValue = (value: unknown): boolean => ['true', '1', 'sim', 'yes', 'y'].includes(asString(value).toLowerCase());

const normalizeOrderStatus = (row: Record<string, unknown>): OrderStatus => {
  const raw = asString(row.status).toLowerCase();
  if (raw.includes('cancel')) return 'Cancelled';
  if (optional(row.delivery_client_date) || raw === 'delivered') return 'Delivered';
  if (optional(row.invoice) || optional(row.wr_date) || optional(row.etd) || optional(row.eta) || optional(row.di_date) || optional(row.entry_cd_date) || optional(row.billing_date)) return 'Shipped';
  if (raw === 'processing') return 'Processing';
  return 'Pending';
};

const normalizeShipmentStatus = (row: Record<string, unknown>, orderStatus: OrderStatus): ShipmentStatus => {
  if (orderStatus === 'Cancelled') return 'Cancelled';
  if (optional(row.delivery_client_date)) return 'Delivered';
  if (optional(row.billing_date)) return 'Out for Delivery';
  if (optional(row.entry_cd_date)) return 'At Distribution Center';
  const raw = asString(row.shipment_status).toLowerCase();
  if (raw.includes('out for delivery') || raw.includes('saiu para entrega')) return 'Out for Delivery';
  if (raw.includes('delivered') || raw.includes('entregue')) return 'Delivered';
  if (raw.includes('cancel')) return 'Cancelled';
  if (optional(row.invoice) || optional(row.wr_date) || optional(row.etd) || optional(row.eta) || optional(row.di_date) || raw.includes('transit')) return 'In Transit';
  return 'Preparing';
};

const parseEvents = (text: unknown): Order['shipment']['events'] => {
  const raw = asString(text);
  if (!raw) return [];
  return raw.split(/\s+\/\s+/).map((part, index) => {
    const bits = part.split('|').map(value => value.trim());
    return {
      id: `dbx-event-${index}-${bits[0] || 'event'}`,
      timestamp: bits[0] || '',
      status: (bits[1] || 'In Transit') as ShipmentStatus,
      location: bits[2] || '',
      description: bits.slice(3).join(' | ') || '',
    };
  });
};

export async function loadOrdersFromDatabricks(): Promise<Order[]> {
  const table = databricksTableName();
  const { columns, rows } = await executeDatabricksStatement(`SELECT * FROM ${table} ORDER BY purchase_order, sku`);
  const now = new Date().toISOString();

  const mapped = rows.map((values, index): Order => {
    const row = Object.fromEntries(columns.map((name, columnIndex) => [name, values[columnIndex]]));
    const quantity = Math.max(1, numberValue(row.quantity));
    const totalUsd = numberValue(row.seller_total_usd);
    const orderStatus = normalizeOrderStatus(row);
    const shipmentStatus = normalizeShipmentStatus(row, orderStatus);
    const purchaseOrder = asString(row.purchase_order) || `DBX-${index + 1}`;
    const sku = asString(row.sku) || `SKU-${index + 1}`;
    const syncTime = optional(row.databricks_sync_time) || now;

    return {
      id: `${purchaseOrder}-${sku}`,
      date_order: asString(row.date_order).slice(0, 10),
      customer_name: asString(row.customer_name) || 'Cliente',
      customer_email: asString(row.customer_email),
      customer_phone: optional(row.customer_phone),
      customer_cpf: optional(row.customer_cpf),
      sku,
      product_name: asString(row.product_name),
      asin: asString(row.asin),
      price_unit: quantity ? totalUsd / quantity : totalUsd,
      quantity,
      total_price: totalUsd,
      status: orderStatus,
      marketplace: asString(row.marketplace),
      shipment: {
        is_shipped: orderStatus === 'Shipped' || orderStatus === 'Delivered',
        carrier: asString(row.carrier),
        tracking_number: asString(row.tracking_number),
        estimated_delivery: asString(row.estimated_delivery).slice(0, 10),
        actual_delivery_date: optional(row.delivery_client_date) || optional(row.actual_delivery_date) || null,
        shipment_status: shipmentStatus,
        databricks_sync_time: syncTime,
        destination: asString(row.destination) || 'Não informado',
        origin_hub: asString(row.origin_hub) || asString(row.seller_country),
        events: parseEvents(row.events_text),
      },
      created_at: now,
      updated_at: syncTime,
      purchase_order: purchaseOrder,
      customer_order_id: optional(row.customer_order_id),
      vkp2_price: numberValue(row.vkp2_price),
      seller_usd_total: totalUsd,
      seller_country: asString(row.seller_country),
      invoice: optional(row.invoice),
      magaya_wr: optional(row.magaya_wr),
      destination_hub: optional(row.destination),
      delivery_client_date: optional(row.delivery_client_date),
      entry_cd_date: optional(row.entry_cd_date),
      billing_date: optional(row.billing_date),
      sequencial: optional(row.sequencial),
      sts_compra: orderStatus === 'Delivered' ? 'ENTREGUE' : orderStatus === 'Cancelled' ? 'CANCELADO' : 'COMPRADO',
      unit_measure: optional(row.unit_measure) || 'PEÇ',
      operational_status: orderStatus === 'Cancelled' ? 'CANCELLED' : orderStatus === 'Delivered' ? 'DELIVERED' : 'ACTIVE',
      status_text: optional(row.status_text),
      marketplace_order_date: optional(row.marketplace_order_date),
      marketplace_order_id: optional(row.marketplace_order_id),
      account_group: optional(row.account_group),
      account_order_status: optional(row.account_order_status),
      account_user: optional(row.account_user),
      wr_date: optional(row.wr_date),
      eta: optional(row.eta),
      etd: optional(row.etd),
      di_date: optional(row.di_date),
      marketplace_purchase_confirmed: boolValue(row.marketplace_purchase_confirmed),
      marketplace_purchase_confirmed_at: optional(row.marketplace_purchase_confirmed_at),
      cancellation_reason: optional(row.cancellation_reason),
      cancellation_updated_at: optional(row.cancellation_updated_at),
    };
  });

  const counters = new Map<string, number>();
  mapped.forEach(item => {
    if (item.sequencial) return;
    const key = item.purchase_order || item.id;
    const next = (counters.get(key) || 0) + 1;
    counters.set(key, next);
    item.sequencial = String(next * 10);
  });

  return mapped;
}
