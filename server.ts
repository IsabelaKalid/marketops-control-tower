import express from 'express';
import path from 'path';
import fs from 'fs';
import { createServer as createViteServer } from 'vite';
import { CSV_ORDERS } from './src/data/seededOrders';
import dotenv from 'dotenv';
import nodemailer from 'nodemailer';
import * as XLSX from 'xlsx';
import { requireRoles } from './server/auth';

import {
  loadOrdersFromPostgres,
  insertOrdersToPostgres,
  postgresEnabled,
  saveCancellationToPostgres,
  saveOrderStateToPostgres,
  savePurchaseConfirmationToPostgres,
} from './server/postgresOrders';

dotenv.config({ path: '.env.local' });
dotenv.config();

const app = express();
const PORT = Number(process.env.PORT || 3000);

app.use(express.json());

const requireOrderManager = requireRoles(
  'admin',
  'operations'
);

const requireReportAccess = requireRoles(
  'admin',
  'operations',
  'analyst'
);

app.use('/api', (request, response, next) => {
  const readOnlyMethods = ['GET', 'HEAD', 'OPTIONS'];

  if (readOnlyMethods.includes(request.method)) {
    next();
    return;
  }

  if (request.path === '/reports/email') {
    requireReportAccess(request, response, next);
    return;
  }

  requireOrderManager(request, response, next);
});

// In-memory application state seeded with a fully synthetic demo dataset.
interface ShipmentEvent {
  id: string;
  timestamp: string;
  location: string;
  status: 'Not Shipped' | 'Preparing' | 'In Transit' | 'Out for Delivery' | 'Delivered' | 'Returned' | 'Cancelled';
  description: string;
}

interface ShipmentData {
  is_shipped: boolean;
  carrier: string;
  tracking_number: string;
  estimated_delivery: string;
  actual_delivery_date: string | null;
  shipment_status: 'Not Shipped' | 'Preparing' | 'In Transit' | 'Out for Delivery' | 'Delivered' | 'Returned' | 'Cancelled';
  databricks_sync_time: string;
  destination: string;
  origin_hub: string;
  events: ShipmentEvent[];
}

interface Order {
  id: string;
  date_order: string;
  customer_name: string;
  customer_email: string;
  customer_phone?: string;
  sku: string;
  product_name: string;
  asin: string;
  price_unit: number;
  quantity: number;
  total_price: number;
  status: 'Pending' | 'Processing' | 'Shipped' | 'Delivered' | 'Cancelled';
  marketplace: string;
  notes?: string;
  shipment: ShipmentData;
  created_at: string;
  updated_at: string;
  purchase_order?: string;
  customer_order_id?: string;
  vkp2_price?: number;
  seller_usd_total?: number;
  seller_country?: string;
  invoice?: string;
  magaya_wr?: string;
  destination_hub?: string;
  delivery_client_date?: string;
  entry_cd_date?: string;
  sequencial?: string;
  sts_compra?: string;
  unit_measure?: string;
  operational_status?: string;
  status_text?: string;
  delivery_limit_days?: number;
  marketplace_order_date?: string;
  marketplace_order_id?: string;
  account_group?: string;
  account_order_status?: string;
  account_user?: string;
  wr_date?: string;
  eta?: string;
  etd?: string;
  di_date?: string;
  marketplace_purchase_confirmed?: boolean;
  marketplace_purchase_confirmed_at?: string;
  cancellation_reason?: string;
  cancellation_updated_at?: string;
  items?: Order[];
}

interface DeliveryAlert {
  id: string;
  order_id: string;
  customer_name: string;
  recipient_email: string;
  type: 'email' | 'push' | 'both';
  event_type: 'Order Placed' | 'Shipment Dispatched' | 'In Transit' | 'Out for Delivery' | 'Delivered' | 'Delivery Exception' | 'Cancelled';
  subject: string;
  message: string;
  timestamp: string;
  status: 'sent' | 'delivered';
}

// Synthetic marketplace orders used by the portfolio/demo environment.
// Order ID in menu principal and API defaults to Ordem de Compra (PO)
const normalizeKeyPart = (value?: string) => (value || '').toString().trim().toUpperCase();
const PENDING_CANCELLATION_REASON = 'Justificativa pendente.';

const generateUniquePurchaseOrder = () => {
  let value = '';
  do value = `AKDN-${Math.floor(10000 + Math.random() * 90000)}`;
  while (orders.some(order => normalizeKeyPart(order.purchase_order || order.id) === value));
  return value;
};

const generateUniqueCustomerOrder = () => {
  let value = '';
  do value = String(900000000 + Math.floor(Math.random() * 1000000));
  while (orders.some(order => normalizeKeyPart(order.customer_order_id) === value));
  return value;
};

const orderGroupKey = (order: Order) => {
  const po = normalizeKeyPart(order.purchase_order);
  const customerOrder = normalizeKeyPart(order.customer_order_id);
  if (po && customerOrder) return `${customerOrder}:::${po}`;
  return po || customerOrder || normalizeKeyPart(order.id);
};

const orderLineKey = (order: Order) => [
  orderGroupKey(order),
  normalizeKeyPart(order.sku),
  normalizeKeyPart(order.asin),
  normalizeKeyPart(order.sequencial),
].join(':::');

const deduplicateOrderLines = (source: Order[]) => {
  const seen = new Set<string>();
  return source.filter((order) => {
    const key = orderLineKey(order);
    if (seen.has(key)) return false;
    seen.add(key);
    return true;
  });
};

const groupOrders = (source: Order[]): Order[] => {
  const groups = new Map<string, Order[]>();
  for (const order of deduplicateOrderLines(source)) {
    const key = orderGroupKey(order);
    const group = groups.get(key) || [];
    group.push(order);
    groups.set(key, group);
  }

  return Array.from(groups.values()).map((items) => {
    const sortedItems = [...items].sort((a, b) =>
      (a.sequencial || '').localeCompare(b.sequencial || '', undefined, { numeric: true })
    );
    const summary = sortedItems[0];
    const hasVkp2 = sortedItems.some((item) => item.vkp2_price !== undefined);
    const purchaseConfirmed = sortedItems.every(item => item.marketplace_purchase_confirmed === true);
    const purchaseConfirmationDates = sortedItems.map(item => item.marketplace_purchase_confirmed_at).filter((value): value is string => Boolean(value)).sort();
    const activeItems = sortedItems.filter(item => item.status !== 'Cancelled');
    const groupedStatus: Order['status'] = activeItems.length === 0
      ? 'Cancelled'
      : activeItems.every(item => Boolean(item.delivery_client_date))
        ? 'Delivered'
        : activeItems.some(item => item.status === 'Shipped' || Boolean(item.invoice || item.wr_date || item.etd || item.eta || item.di_date || item.entry_cd_date))
          ? 'Shipped'
          : 'Pending';
    return {
      ...summary,
      id: summary.purchase_order || summary.customer_order_id || summary.id,
      quantity: sortedItems.reduce((sum, item) => sum + item.quantity, 0),
      total_price: sortedItems.reduce((sum, item) => sum + item.total_price, 0),
      seller_usd_total: sortedItems.reduce((sum, item) => sum + (item.seller_usd_total ?? item.total_price), 0),
      vkp2_price: hasVkp2
        ? sortedItems.reduce((sum, item) => sum + (item.vkp2_price ?? 0), 0)
        : undefined,
      marketplace_purchase_confirmed: purchaseConfirmed,
      marketplace_purchase_confirmed_at: purchaseConfirmed ? purchaseConfirmationDates.at(-1) : undefined,
      cancellation_reason: sortedItems.find(item => item.cancellation_reason)?.cancellation_reason,
      cancellation_updated_at: sortedItems.find(item => item.cancellation_updated_at)?.cancellation_updated_at,
      updated_at: sortedItems.map(item => item.updated_at).filter(Boolean).sort().at(-1) || summary.updated_at,
      status: groupedStatus,
      shipment: {
        ...summary.shipment,
        is_shipped: groupedStatus === 'Shipped' || groupedStatus === 'Delivered',
        shipment_status: groupedStatus === 'Delivered' ? 'Delivered' : groupedStatus === 'Shipped' ? 'In Transit' : groupedStatus === 'Cancelled' ? 'Cancelled' : 'Preparing',
        actual_delivery_date: groupedStatus === 'Delivered'
          ? activeItems.map(item => item.delivery_client_date).filter((value): value is string => Boolean(value)).sort().at(-1) || null
          : null,
      },
      items: sortedItems,
    };
  });
};

const confirmationsPath = path.join(process.cwd(), 'data', 'marketplace-purchase-confirmations.json');
const cancellationReasonsPath = path.join(process.cwd(), 'data', 'order-cancellation-reasons.json');
type PurchaseConfirmation = { confirmed: boolean; confirmed_at: string };
let savedConfirmations: Record<string, PurchaseConfirmation> = {};
type SavedCancellation = string | { reason: string; updated_at?: string };
let savedCancellationReasons: Record<string, SavedCancellation> = {};
try {
  if (fs.existsSync(confirmationsPath)) savedConfirmations = JSON.parse(fs.readFileSync(confirmationsPath, 'utf8'));
  if (fs.existsSync(cancellationReasonsPath)) savedCancellationReasons = JSON.parse(fs.readFileSync(cancellationReasonsPath, 'utf8'));
} catch (error) {
  console.error('Could not read purchase confirmations:', error);
}

let orders: Order[] = deduplicateOrderLines(CSV_ORDERS.map((o, index) => {
  const key = orderGroupKey(o);
  const savedCancellation = savedCancellationReasons[key];
  const cancellationReason = typeof savedCancellation === 'string' ? savedCancellation : savedCancellation?.reason;
  const cancellationUpdatedAt = typeof savedCancellation === 'string' ? undefined : savedCancellation?.updated_at;
  const savedConfirmationAt = savedConfirmations[key]?.confirmed_at;
  const persistedUpdateDates = [o.updated_at, savedConfirmationAt, cancellationUpdatedAt].filter((value): value is string => Boolean(value));
  return {
    ...o,
    id: `${o.purchase_order || o.id}-${o.sequencial || o.sku || index}`,
    status: cancellationReason ? 'Cancelled' : o.status,
    sts_compra: cancellationReason ? 'CANCELADO' : o.sts_compra,
    shipment: cancellationReason ? { ...o.shipment, is_shipped: false, shipment_status: 'Cancelled' } : o.shipment,
    marketplace_purchase_confirmed: savedConfirmations[key]?.confirmed ?? Boolean(o.marketplace_order_date || o.marketplace_order_id),
    marketplace_purchase_confirmed_at: savedConfirmations[key]?.confirmed_at || o.marketplace_order_date || undefined,
    cancellation_reason: cancellationReason || undefined,
    cancellation_updated_at: cancellationReason ? (cancellationUpdatedAt || o.cancellation_updated_at || new Date().toISOString()) : o.cancellation_updated_at,
    updated_at: persistedUpdateDates.sort().at(-1) || o.updated_at,
  };
}));

let activeDataSource: 'synthetic' | 'postgres' = 'synthetic';
let databaseConnectionStatus: 'disabled' | 'connected' | 'error' = 'disabled';
let databaseConnectionMessage = 'Using the bundled synthetic dataset.';

const isCancellationStatus = (...values: unknown[]) => values.some(value =>
  typeof value === 'string' && value.toUpperCase().includes('CANCEL')
);

const reconcileLifecycle = (order: Order, source: Record<string, unknown> = {}) => {
  const value = (...keys: string[]) => keys.map(key => source[key]).find(item => item !== undefined && item !== null && item !== '');
  const asText = (...keys: string[]) => {
    const found = value(...keys);
    return found === undefined ? undefined : String(found).trim();
  };

  order.invoice = asText('invoice') ?? order.invoice;
  order.wr_date = asText('wr_date') ?? order.wr_date;
  order.eta = asText('eta') ?? order.eta;
  order.etd = asText('etd') ?? order.etd;
  order.di_date = asText('di_date', 'data_di') ?? order.di_date;
  order.entry_cd_date = asText('entry_cd_date', 'entrada_cd') ?? order.entry_cd_date;
  order.delivery_client_date = asText('delivery_client_date', 'entrega_cliente') ?? order.delivery_client_date;

  const cancelled = isCancellationStatus(
    source.status,
    source.status_compra,
    source.sts_compra,
    source.order_status,
    source.delivery_status,
    order.status,
    order.sts_compra,
  ) || Boolean(order.cancellation_reason);
  const now = new Date().toISOString();
  if (cancelled) {
    order.status = 'Cancelled';
    order.sts_compra = 'CANCELADO';
    order.cancellation_reason = asText('cancellation_reason', 'justificativa_cancelamento') || order.cancellation_reason || 'Cancelamento informado na base de origem (cliente ou loja).';
    order.cancellation_updated_at = asText('cancellation_updated_at', 'data_cancelamento') || now;
    order.shipment.is_shipped = false;
    order.shipment.shipment_status = 'Cancelled';
    order.shipment.actual_delivery_date = null;
  } else if (order.delivery_client_date) {
    order.status = 'Delivered';
    order.sts_compra = 'ENTREGUE';
    order.shipment.is_shipped = true;
    order.shipment.shipment_status = 'Delivered';
    order.shipment.actual_delivery_date = order.delivery_client_date;
  } else if (order.invoice || order.wr_date || order.etd || order.eta || order.di_date || order.entry_cd_date) {
    order.status = 'Shipped';
    order.shipment.is_shipped = true;
    order.shipment.shipment_status = 'In Transit';
    order.shipment.actual_delivery_date = null;
  } else {
    order.status = 'Pending';
    order.shipment.is_shipped = false;
    order.shipment.shipment_status = 'Preparing';
    order.shipment.actual_delivery_date = null;
  }
  order.updated_at = now;
  order.shipment.databricks_sync_time = now.replace('T', ' ').substring(0, 19) + ' UTC';
};

const savePurchaseConfirmations = () => {
  const payload: Record<string, PurchaseConfirmation> = {};
  for (const order of orders) {
    if (order.marketplace_purchase_confirmed_at || order.marketplace_purchase_confirmed === false) {
      payload[orderGroupKey(order)] = {
        confirmed: Boolean(order.marketplace_purchase_confirmed),
        confirmed_at: order.marketplace_purchase_confirmed_at || '',
      };
    }
  }
  fs.mkdirSync(path.dirname(confirmationsPath), { recursive: true });
  fs.writeFileSync(confirmationsPath, JSON.stringify(payload, null, 2), 'utf8');
};

const saveCancellationReasons = () => {
  const payload: Record<string, { reason: string; updated_at?: string }> = {};
  for (const order of orders) {
    if (order.cancellation_reason) payload[orderGroupKey(order)] = { reason: order.cancellation_reason, updated_at: order.cancellation_updated_at };
  }
  fs.mkdirSync(path.dirname(cancellationReasonsPath), { recursive: true });
  fs.writeFileSync(cancellationReasonsPath, JSON.stringify(payload, null, 2), 'utf8');
};

const findOrderByIdOrPo = (identifier: string) => {
  return orders.find(
    o => o.id === identifier || o.purchase_order === identifier || o.customer_order_id === identifier
  );
};

let alerts: DeliveryAlert[] = [];

// Helper to record an automated delivery notification alert
function recordDeliveryAlert(
  order: Order,
  eventType: DeliveryAlert['event_type'],
  customSubject?: string,
  customMsg?: string
): DeliveryAlert {
  const alertId = `ALT-${Date.now().toString().slice(-4)}${Math.floor(Math.random() * 100)}`;
  const subject = customSubject || `Status Alert: Order ${order.id} is now ${eventType}`;
  const message = customMsg || `Shipment update for ${order.product_name}. Tracking: ${order.shipment.tracking_number} via ${order.shipment.carrier}. Current status: ${order.shipment.shipment_status}. Estimated delivery: ${order.shipment.estimated_delivery}`;

  const alert: DeliveryAlert = {
    id: alertId,
    order_id: order.id,
    customer_name: order.customer_name,
    recipient_email: order.customer_email,
    type: 'both',
    event_type: eventType,
    subject,
    message,
    timestamp: new Date().toISOString().replace('T', ' ').substring(0, 19),
    status: 'sent'
  };

  alerts.unshift(alert);
  return alert;
}

// ----------------------------------------------------
// API ROUTES
// ----------------------------------------------------

// 1. Health check
app.get('/api/health', (req, res) => {
  res.json({
    status: 'ok',
    environment: process.env.NODE_ENV || 'development',
    data_source: activeDataSource,
    database_status: databaseConnectionStatus,
    database_message: databaseConnectionMessage,
    orders_count: orders.length
  });
});

// 2. Dashboard Analytics & Summary Statistics
app.get('/api/dashboard/stats', (req, res) => {
  const grouped = groupOrders(orders);
  const total = grouped.length;
  const pending = grouped.filter(o => o.status === 'Pending' || o.status === 'Processing').length;
  const shipped = grouped.filter(o => o.status === 'Shipped').length;
  const delivered = grouped.filter(o => o.status === 'Delivered').length;
  const cancelled = grouped.filter(o => o.status === 'Cancelled').length;
  const total_revenue = orders.reduce((acc, curr) => acc + (curr.status !== 'Cancelled' ? curr.total_price : 0), 0);
  const total_sales_brl = orders.reduce((acc, curr) => acc + (curr.status !== 'Cancelled' ? (curr.vkp2_price ?? 0) * curr.quantity : 0), 0);

  res.json({
    total_orders: total,
    total_revenue: Math.round(total_revenue * 100) / 100,
    total_sales_brl: Math.round(total_sales_brl * 100) / 100,
    pending_orders: pending,
    shipped_orders: shipped,
    delivered_orders: delivered,
    cancelled_orders: cancelled,
    databricks_sync_status: {
      last_sync: new Date().toISOString().replace('T', ' ').substring(0, 19) + ' UTC',
      table: activeDataSource === 'postgres' ? 'public.orders + public.order_items + public.logistics' : 'synthetic demo dataset',
      total_records: total,
      status: databaseConnectionStatus === 'error' ? 'connected' : 'healthy'
    }
  });
});

app.get('/api/sellers', (_req, res) => {
  const sellers = Array.from(new Map(
    orders.map(order => String(order.marketplace || '').trim()).filter(Boolean)
      .map(value => [value.toLocaleLowerCase(), value])
  ).values()).sort((a, b) => a.localeCompare(b));
  res.json({ sellers });
});

// 3. Get all orders with multi-parameter filter & search
app.get('/api/orders', (req, res) => {
  const { search, status, date_from, date_to, marketplace, operational, sort_by, sort_direction } = req.query;

  let filtered = [...orders];

  if (search && typeof search === 'string' && search.trim() !== '') {
    const q = search.trim().toLowerCase();
    filtered = filtered.filter(o =>
      o.id.toLowerCase().includes(q) ||
      o.customer_name.toLowerCase().includes(q) ||
      o.sku.toLowerCase().includes(q) ||
      o.asin.toLowerCase().includes(q) ||
      o.product_name.toLowerCase().includes(q) ||
      (o.purchase_order && o.purchase_order.toLowerCase().includes(q)) ||
      (o.customer_order_id && o.customer_order_id.toLowerCase().includes(q)) ||
      (o.invoice && o.invoice.toLowerCase().includes(q)) ||
      o.shipment.tracking_number.toLowerCase().includes(q)
    );
  }

  if (status && typeof status === 'string' && status !== 'All') {
    filtered = filtered.filter(o => o.status.toLowerCase() === status.toLowerCase());
  }

  if (marketplace && typeof marketplace === 'string' && marketplace !== 'All') {
    const m = marketplace.toLowerCase().trim();
    filtered = filtered.filter(o => {
      const s = (o.marketplace || '').toLowerCase().trim();
      return (
        s === m ||
        s.includes(m) ||
        m.includes(s) ||
        (m.startsWith('amazon') && s.startsWith('amazon'))
      );
    });
  }

  if (date_from && typeof date_from === 'string') {
    filtered = filtered.filter(o => o.date_order >= date_from);
  }

  if (date_to && typeof date_to === 'string') {
    filtered = filtered.filter(o => o.date_order <= date_to);
  }

  // Expose one visual order with all its product lines, then apply the selected ordering.
  let grouped = groupOrders(filtered);
  const selectedSort: 'date_order' | 'updated_at' = sort_by === 'date_order' ? 'date_order' : 'updated_at';
  const direction = sort_direction === 'asc' ? 1 : -1;
  grouped.sort((a, b) => {
    const left = new Date(a[selectedSort] || 0).getTime();
    const right = new Date(b[selectedSort] || 0).getTime();
    const dateComparison = (left - right) * direction;
    return dateComparison || (a.purchase_order || a.id).localeCompare(b.purchase_order || b.id) * direction;
  });
  const calendarDaysSince = (value?: string) => value
    ? Math.floor((new Date().setHours(0, 0, 0, 0) - new Date(`${value.slice(0, 10)}T00:00:00`).getTime()) / 86400000)
    : null;
  if (operational && typeof operational === 'string' && operational !== 'All') {
    grouped = grouped.filter(order => {
      const items = order.items?.length ? order.items : [order];
      const isOpen = order.status !== 'Delivered' && order.status !== 'Cancelled';
      const any = (predicate: (item: Order) => boolean) => items.some(predicate);
      if (operational === 'in_transit_invoiced') return order.status === 'Shipped' && any(item => Boolean(item.invoice));
      if (operational === 'not_purchased') return order.status !== 'Cancelled' && !order.marketplace_purchase_confirmed;
      if (operational === 'missing_wr') {
        const elapsed = calendarDaysSince(order.marketplace_purchase_confirmed_at);
        return isOpen && Boolean(order.marketplace_purchase_confirmed) && elapsed !== null && elapsed >= 10 && any(item => !item.wr_date);
      }
      if (operational === 'wr_no_eta_invoice_10') {
        return isOpen && any(item => { const elapsed = calendarDaysSince(item.wr_date); return elapsed !== null && elapsed >= 10 && (!item.eta || !item.invoice); });
      }
      return true;
    });
  }

  res.json({
    count: grouped.length,
    total: groupOrders(orders).length,
    orders: grouped
  });
});

// Receives future Delta/Databricks changes and reconciles lifecycle status from source-of-truth fields.
// Expected body: { records: [{ purchase_order, sku?, status_compra?, invoice?, di_date?, entrada_cd?, entrega_cliente? }] }
app.post('/api/databricks/reconcile', (req, res) => {
  const records = Array.isArray(req.body?.records) ? req.body.records : [];
  if (!records.length) return res.status(400).json({ error: 'Envie ao menos um registro em records.' });

  const updatedGroups = new Set<string>();
  const notFound: unknown[] = [];
  for (const record of records) {
    const po = normalizeKeyPart(record.purchase_order || record.ordem_compra || record.id);
    const customerOrder = normalizeKeyPart(record.customer_order_id || record.ordem_cliente);
    const sku = normalizeKeyPart(record.sku || record.material);
    const matches = orders.filter(order => {
      const sameOrder = (po && normalizeKeyPart(order.purchase_order || order.id) === po)
        || (customerOrder && normalizeKeyPart(order.customer_order_id) === customerOrder);
      return sameOrder && (!sku || normalizeKeyPart(order.sku) === sku);
    });

    if (!matches.length) {
      notFound.push({ purchase_order: po, customer_order_id: customerOrder, sku });
      continue;
    }
    matches.forEach(order => {
      reconcileLifecycle(order, record);
      updatedGroups.add(orderGroupKey(order));
    });
  }

  saveCancellationReasons();
  const grouped = groupOrders(orders).filter(order => updatedGroups.has(orderGroupKey(order)));
  res.json({ updated: grouped.length, orders: grouped, not_found: notFound });
});

// 4. Get order by ID or PO
app.get('/api/orders/:id', (req, res) => {
  const order = findOrderByIdOrPo(req.params.id);
  if (!order) {
    return res.status(404).json({ error: `Order ${req.params.id} not found` });
  }
  res.json(order);
});

app.patch('/api/orders/:id/purchase-confirmation', async (req, res) => {
  const order = findOrderByIdOrPo(req.params.id);
  if (!order) return res.status(404).json({ error: `Order ${req.params.id} not found` });
  const confirmed = req.body?.confirmed !== false;
  const confirmedAt = confirmed ? new Date().toISOString() : '';
  const relatedItems = orders.filter(candidate => orderGroupKey(candidate) === orderGroupKey(order));
  if (activeDataSource === 'postgres') {
    try {
      await savePurchaseConfirmationToPostgres(
        order.purchase_order || order.id,
        confirmed,
        confirmedAt || null,
        order.account_user,
      );
    } catch (error: any) {
      return res.status(500).json({ error: `Could not save the purchase confirmation in PostgreSQL: ${error?.message || error}` });
    }
  }
  const updatedAt = new Date().toISOString();
  relatedItems.forEach(item => {
    item.marketplace_purchase_confirmed = confirmed;
    item.marketplace_purchase_confirmed_at = confirmedAt || undefined;
    item.updated_at = updatedAt;
  });
  savePurchaseConfirmations();
  res.json({ success: true, order: groupOrders(relatedItems)[0] });
});

app.patch('/api/orders/:id/cancel', async (req, res) => {
  const order = findOrderByIdOrPo(req.params.id);
  if (!order) return res.status(404).json({ error: `Order ${req.params.id} not found` });
  if (order.status === 'Delivered') return res.status(400).json({ error: 'Pedidos entregues não podem ser cancelados.' });

  const reason = String(req.body?.reason || '').trim() || PENDING_CANCELLATION_REASON;

  const relatedItems = orders.filter(candidate => orderGroupKey(candidate) === orderGroupKey(order));
  const cancellationUpdatedAt = new Date().toISOString();

  if (activeDataSource === 'postgres') {
    try {
      await saveCancellationToPostgres(
        order.purchase_order || order.id,
        reason,
        cancellationUpdatedAt,
        order.account_user,
      );
    } catch (error: any) {
      return res.status(500).json({ error: `Could not save the cancellation in PostgreSQL: ${error?.message || error}` });
    }
  }

  relatedItems.forEach((item, index) => {
    item.status = 'Cancelled';
    item.status_text = reason;
    item.sts_compra = 'CANCELADO';
    item.cancellation_reason = reason;
    item.cancellation_updated_at = cancellationUpdatedAt;
    item.marketplace_purchase_confirmed = false;
    item.marketplace_purchase_confirmed_at = undefined;
    item.shipment.is_shipped = false;
    item.shipment.shipment_status = 'Cancelled';
    item.updated_at = cancellationUpdatedAt;
    item.shipment.events.unshift({
      id: `ev-cancel-${Date.now()}-${index}`,
      timestamp: cancellationUpdatedAt.replace('T', ' ').substring(0, 19),
      location: 'Admin Portal',
      status: 'Cancelled',
      description: `Pedido cancelado. Justificativa: ${reason}`,
    });
  });

  savePurchaseConfirmations();
  saveCancellationReasons();
  res.json({ success: true, order: groupOrders(relatedItems)[0] });
});

app.patch('/api/orders/:id/cancellation-reason', async (req, res) => {
  const order = findOrderByIdOrPo(req.params.id);
  if (!order) return res.status(404).json({ error: `Order ${req.params.id} not found` });
  if (order.status !== 'Cancelled') return res.status(400).json({ error: 'A justificativa só pode ser registrada em pedidos cancelados.' });
  const reason = String(req.body?.reason || '').trim();
  if (!reason) return res.status(400).json({ error: 'Informe a justificativa do cancelamento.' });
  const relatedItems = orders.filter(candidate => orderGroupKey(candidate) === orderGroupKey(order));
  const cancellationUpdatedAt = new Date().toISOString();
  if (activeDataSource === 'postgres') {
    try {
      await saveCancellationToPostgres(order.purchase_order || order.id, reason, cancellationUpdatedAt, order.account_user);
    } catch (error: any) {
      return res.status(500).json({ error: `Could not save the cancellation in PostgreSQL: ${error?.message || error}` });
    }
  }
  relatedItems.forEach(item => { item.cancellation_reason = reason; item.status_text = reason; item.cancellation_updated_at = cancellationUpdatedAt; item.updated_at = cancellationUpdatedAt; });
  saveCancellationReasons();
  res.json({ success: true, order: groupOrders(relatedItems)[0] });
});

// 5. Insert New Order
app.post('/api/orders', async (req, res) => {
  try {
    const {
      date_order,
      customer_name,
      customer_email,
      customer_phone,
      sku,
      product_name,
      asin,
      price_unit,
      quantity,
      marketplace,
      notes,
      destination_address,
      estimated_delivery_days
    } = req.body;

    if (!customer_name || !sku || !product_name || !asin || !price_unit || !quantity) {
      return res.status(400).json({
        error: 'Missing required order fields (customer_name, sku, product_name, asin, price_unit, quantity)'
      });
    }

    const unitPrice = parseFloat(price_unit);
    const qty = parseInt(quantity, 10);
    const totalPrice = Math.round(unitPrice * qty * 100) / 100;

    const incomingPo = req.body.purchase_order ? req.body.purchase_order.toString().trim() : '';
    const incomingSku = (sku || '').toString().trim().toUpperCase();

    // DEDUPLICATION CHECK: Same Ordem de Compra (PO) + Same SKU cannot be repeated
    if (incomingPo && incomingSku) {
      const existingMatch = orders.find((o) => {
        const oPo = (o.purchase_order || o.id || '').toString().trim();
        const oSku = (o.sku || '').toString().trim().toUpperCase();
        return oPo === incomingPo && oSku === incomingSku;
      });

      if (existingMatch) {
        return res.status(409).json({
          error: `O pedido já existe! A Ordem de Compra (PO) "${incomingPo}" com o SKU "${incomingSku}" já está cadastrada no sistema. Não é permitido repetir a mesma Ordem de Compra e SKU.`,
          code: 'ORDER_ALREADY_EXISTS',
          duplicate: {
            purchase_order: incomingPo,
            sku: incomingSku,
            product_name: existingMatch.product_name,
            customer_order_id: existingMatch.customer_order_id,
          },
        });
      }
    }

    const orderSeq = Math.floor(1000 + Math.random() * 9000);
    // Order ID in menu principal defaults to Ordem de Compra (PO)
    let orderId = incomingPo || generateUniquePurchaseOrder();
    if (incomingPo && orders.some((o) => o.id === incomingPo)) {
      orderId = `${incomingPo}-${req.body.sequencial || incomingSku || orderSeq}`;
    }
    const today = date_order || new Date().toISOString().split('T')[0];

    // Estimated delivery calculation (default 3-5 days from order date)
    const estDeliveryDate = new Date();
    const addDays = estimated_delivery_days ? parseInt(estimated_delivery_days, 10) : 4;
    estDeliveryDate.setDate(estDeliveryDate.getDate() + addDays);
    const estDeliveryStr = estDeliveryDate.toISOString().split('T')[0];

    const customerOrderId = req.body.customer_order_id?.toString().trim() || generateUniqueCustomerOrder();

    const newOrder: Order = {
      id: orderId,
      date_order: today,
      customer_name: customer_name.trim(),
      customer_email: customer_email?.trim() || '',
      customer_phone: customer_phone || undefined,
      sku: sku.trim().toUpperCase(),
      product_name: product_name.trim(),
      asin: asin.trim().toUpperCase(),
      price_unit: unitPrice,
      quantity: qty,
      total_price: totalPrice,
      status: 'Pending',
      marketplace: marketplace || 'Amazon US',
      notes: notes || `PO: ${orderId}`,
      purchase_order: req.body.purchase_order || orderId,
      customer_order_id: customerOrderId,
      sequencial: req.body.sequencial || '10',
      sts_compra: req.body.sts_compra || 'COMPRADO',
      vkp2_price: req.body.vkp2_price ? parseFloat(req.body.vkp2_price) : undefined,
      seller_usd_total: req.body.seller_usd_total ? parseFloat(req.body.seller_usd_total) : totalPrice,
      seller_country: req.body.seller_country || 'EUA',
      invoice: req.body.invoice,
      magaya_wr: req.body.magaya_wr,
      shipment: {
        is_shipped: false,
        carrier: '',
        tracking_number: '',
        estimated_delivery: estDeliveryStr,
        actual_delivery_date: null,
        shipment_status: 'Preparing',
        databricks_sync_time: new Date().toISOString().replace('T', ' ').substring(0, 19) + ' UTC',
        destination: destination_address || 'Dallas, TX, USA',
        origin_hub: 'Central Logistics Delta Warehouse - Bay 4',
        events: [
          {
            id: `ev-${Date.now()}`,
            timestamp: new Date().toISOString().replace('T', ' ').substring(0, 19),
            location: 'Central Logistics Delta Warehouse',
            status: 'Preparing',
            description: 'New marketplace order acknowledged; awaiting fulfillment dispatch in Databricks sync queue'
          }
        ]
      },
      created_at: new Date().toISOString(),
      updated_at: new Date().toISOString()
    };

    if (activeDataSource === 'postgres') {
      await insertOrdersToPostgres([newOrder]);
    }
    orders.unshift(newOrder);

    // Trigger automated order placed alert
    recordDeliveryAlert(
      newOrder,
      'Order Placed',
      `Order Confirmed: ${newOrder.id} (${newOrder.product_name})`,
      `Thank you ${newOrder.customer_name}. Your marketplace order ${newOrder.id} has been received. Tracking will be added after the seller dispatches the order. Estimated delivery: ${newOrder.shipment.estimated_delivery}.`
    );

    res.status(201).json({
      success: true,
      message: 'Order created successfully and registered in marketplace ledger',
      order: newOrder
    });
  } catch (err: any) {
    console.error('Error inserting order:', err);
    res.status(500).json({ error: err.message || 'Failed to insert order' });
  }
});

// 5b. Batch Orders Ingestion endpoint: send multiple orders at once
app.post('/api/orders/batch', async (req, res) => {
  try {
    const { orders: batchItems, default_status } = req.body;

    if (!batchItems || !Array.isArray(batchItems) || batchItems.length === 0) {
      return res.status(400).json({ error: 'No orders provided in batch payload' });
    }

    const createdOrders: Order[] = [];
    const nowIso = new Date().toISOString();

    for (let i = 0; i < batchItems.length; i++) {
      const item = batchItems[i];
      const seq = Math.floor(1000 + Math.random() * 9000);

      const incomingPo = (item.purchase_order || item.id || '').toString().trim();
      const incomingSku = (item.sku || '').toString().trim().toUpperCase();
      const alreadyExists = orders.some((order) =>
        normalizeKeyPart(order.purchase_order || order.id) === normalizeKeyPart(incomingPo) &&
        normalizeKeyPart(order.sku) === incomingSku
      );
      const repeatedInBatch = createdOrders.some((order) =>
        normalizeKeyPart(order.purchase_order || order.id) === normalizeKeyPart(incomingPo) &&
        normalizeKeyPart(order.sku) === incomingSku
      );
      if (incomingPo && incomingSku && (alreadyExists || repeatedInBatch)) {
        continue;
      }
      
      // Determine unique order ID - Ordem de Compra (PO) is primary
      let orderId = incomingPo;
      if (!orderId) {
        if (item.customer_order_id) {
          orderId = `ORD-${item.customer_order_id}`;
          // Check collision
          if (orders.some(o => o.id === orderId)) {
            orderId = `ORD-${item.customer_order_id}-${seq}`;
          }
        } else {
          orderId = `ORD-2026-${seq}`;
        }
      }
      if (orders.some(o => o.id === orderId) || createdOrders.some(o => o.id === orderId)) {
        orderId = `${orderId}-${item.sequencial || incomingSku || seq}`;
      }

      // Date normalization
      let dateOrder = item.date_order || nowIso.split('T')[0];
      if (/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(dateOrder)) {
        const [d, m, y] = dateOrder.split('/');
        dateOrder = `${y}-${m.padStart(2, '0')}-${d.padStart(2, '0')}`;
      }

      // Status mapping
      let orderStatus: Order['status'] = 'Pending';
      const rawStatus = (item.sts_compra || item.status || default_status || 'Pending').toLowerCase();
      if (rawStatus.includes('cancel')) {
        orderStatus = 'Cancelled';
      } else if (item.delivery_client_date) {
        orderStatus = 'Delivered';
      } else if (item.invoice || item.wr_date || item.di_date || item.entry_cd_date || item.eta) {
        orderStatus = 'Shipped';
      } else if (rawStatus.includes('transit') || rawStatus.includes('ship') || rawStatus.includes('enviad')) {
        orderStatus = 'Shipped';
      }

      const qty = parseInt(item.quantity, 10) || 1;
      const sellerUsd = item.seller_usd_total !== undefined && item.seller_usd_total !== null
        ? parseFloat(item.seller_usd_total)
        : (parseFloat(item.price_unit) || 29.99) * qty;
      const totalPrice = Math.round(sellerUsd * 100) / 100;
      const unitPrice = Math.round((totalPrice / qty) * 100) / 100;
      const vkp2Price = item.vkp2_price !== undefined && item.vkp2_price !== null ? parseFloat(item.vkp2_price) : undefined;
      const stsCompra = item.sts_compra || (orderStatus === 'Delivered' ? 'ENTREGUE' : orderStatus === 'Cancelled' ? 'CANCELADO' : 'COMPRADO');

      // Shipment state setup
      const trackingNumber = item.tracking_number || '';
      const carrier = item.carrier || '';
      const destinationHub = item.destination_hub || '';

      let shipmentStatus: any = 'Preparing';
      let actualDeliveryDate: string | null = null;
      if (orderStatus === 'Delivered') {
        shipmentStatus = 'Delivered';
        actualDeliveryDate = item.delivery_client_date;
      } else if (orderStatus === 'Cancelled') {
        shipmentStatus = 'Cancelled';
      } else if (orderStatus === 'Shipped') {
        shipmentStatus = 'In Transit';
      }

      const newOrder: Order = {
        id: orderId,
        date_order: dateOrder,
        customer_name: item.customer_name || (item.customer_order_id ? `Cliente Marketplace #${item.customer_order_id}` : `Cliente Marketplace Manaus`),
        customer_email: item.customer_email || '',
        customer_phone: item.customer_phone || undefined,
        sku: (item.sku || `SKU-${seq}`).toString().trim(),
        product_name: (item.product_name || `Produto ${seq}`).trim(),
        asin: (item.asin || 'ASIN-GEN').trim().toUpperCase(),
        price_unit: unitPrice,
        quantity: qty,
        total_price: totalPrice,
        status: orderStatus,
        marketplace: item.seller || item.marketplace || 'Amazon',
        notes: item.notes || `Lote importado via MarketOps Batch Stream. Sequencial: ${item.sequencial || '10'}`,
        purchase_order: item.purchase_order ? item.purchase_order.toString() : orderId,
        customer_order_id: item.customer_order_id ? item.customer_order_id.toString() : orderId,
        sequencial: item.sequencial ? item.sequencial.toString() : '10',
        sts_compra: stsCompra,
        seller_usd_total: totalPrice,
        seller_country: item.seller_country || 'EUA',
        vkp2_price: vkp2Price,
        invoice: item.invoice || undefined,
        magaya_wr: item.magaya_wr || undefined,
        wr_date: item.wr_date || undefined,
        eta: item.eta || undefined,
        di_date: item.di_date || undefined,
        entry_cd_date: item.entry_cd_date || undefined,
        delivery_client_date: item.delivery_client_date || undefined,
        cancellation_reason: orderStatus === 'Cancelled' ? (item.cancellation_reason || 'Cancelamento informado na base de origem (cliente ou loja).') : undefined,
        cancellation_updated_at: orderStatus === 'Cancelled' ? nowIso : undefined,
        destination_hub: destinationHub,
        shipment: {
          is_shipped: orderStatus === 'Shipped' || orderStatus === 'Delivered',
          carrier,
          tracking_number: trackingNumber,
          estimated_delivery: `${dateOrder.substring(0, 8)}${Math.min(28, parseInt(dateOrder.substring(8, 10), 10) + 4)}`,
          actual_delivery_date: actualDeliveryDate,
          shipment_status: shipmentStatus,
          databricks_sync_time: nowIso.replace('T', ' ').substring(0, 19) + ' UTC',
          destination: destinationHub,
          origin_hub: 'Amazon Miami International Hub / DFW Sort',
          events: [
            {
              id: `ev-${Date.now()}-${i}`,
              timestamp: nowIso.replace('T', ' ').substring(0, 19),
              location: orderStatus === 'Delivered' ? destinationHub : 'Amazon Miami Logistics Hub',
              status: shipmentStatus,
              description: orderStatus === 'Delivered' 
                ? `Carga entregue com sucesso no ${destinationHub}. Recebido pelo cliente.` 
                : orderStatus === 'Cancelled'
                ? `Pedido cancelado no marketplace. Processo logístico estornado.`
                : `Ordem de Compra ${item.purchase_order || 'N/A'} registrada e sincronizada com Databricks gold_logistics.`
            }
          ]
        },
        created_at: nowIso,
        updated_at: nowIso
      };

      createdOrders.push(newOrder);
    }

    if (activeDataSource === 'postgres') {
      await insertOrdersToPostgres(createdOrders);
    }
    orders.unshift(...createdOrders);

    // Dispatched batch alert
    alerts.unshift({
      id: `ALT-BATCH-${Date.now()}`,
      order_id: createdOrders[0]?.id || 'BATCH',
      customer_name: 'MarketOps Batch Importer',
      recipient_email: 'logistica@marketplace.com.br',
      type: 'both',
      event_type: 'Order Placed',
      subject: `Batch Ingestion: ${createdOrders.length} novos pedidos integrados`,
      message: `Foram enviados e processados com sucesso ${createdOrders.length} pedidos no portal e sincronizados com a tabela gold_logistics do Databricks.`,
      timestamp: nowIso.replace('T', ' ').substring(0, 19),
      status: 'delivered'
    });

    res.status(201).json({
      success: true,
      message: `Successfully ingested ${createdOrders.length} orders into the platform and Databricks Lakehouse.`,
      count: createdOrders.length,
      orders: createdOrders
    });
  } catch (err: any) {
    console.error('Error processing batch orders:', err);
    res.status(500).json({ error: err.message || 'Failed to process batch orders' });
  }
});

// 6. Databricks Shipment Sync endpoint for a specific order
// Simulates / runs real-time sync with Databricks lakehouse table 'gold_logistics.marketplace_shipments'
app.post('/api/orders/:id/sync-databricks', async (req, res) => {
  const order = findOrderByIdOrPo(req.params.id);
  if (!order) {
    return res.status(404).json({ error: `Order ${req.params.id} not found` });
  }

  const { target_status } = req.body; // optional override: 'Shipped' | 'Out for Delivery' | 'Delivered' | 'In Transit'
  const relatedItems = orders.filter(candidate => orderGroupKey(candidate) === orderGroupKey(order));
  const previousItems = relatedItems.map(item => structuredClone(item));

  const currentStatus = order.shipment.shipment_status;
  let nextShipmentStatus = currentStatus;
  let nextOrderStatus = order.status;

  if (target_status) {
    nextShipmentStatus = target_status;
  } else {
    // Progress lifecycle logically
    if (currentStatus === 'Not Shipped' || currentStatus === 'Preparing') {
      nextShipmentStatus = 'In Transit';
      nextOrderStatus = 'Shipped';
    } else if (currentStatus === 'In Transit') {
      nextShipmentStatus = 'Out for Delivery';
      nextOrderStatus = 'Shipped';
    } else if (currentStatus === 'Out for Delivery') {
      // Delivery is finalized only when entrega_cliente arrives from the source data.
      nextShipmentStatus = 'Out for Delivery';
      nextOrderStatus = 'Shipped';
    }
  }

  const suppliedDeliveryDate = req.body.delivery_client_date || req.body.entrega_cliente;
  if (nextShipmentStatus === 'Delivered' && !suppliedDeliveryDate && !order.delivery_client_date) {
    return res.status(400).json({ error: 'Delivered exige a data entrega_cliente.' });
  }

  const isShipped = nextShipmentStatus !== 'Not Shipped' && nextShipmentStatus !== 'Preparing' && nextShipmentStatus !== 'Cancelled';
  if (nextShipmentStatus === 'Delivered') {
    nextOrderStatus = 'Delivered';
    order.delivery_client_date = suppliedDeliveryDate || order.delivery_client_date;
    order.shipment.actual_delivery_date = order.delivery_client_date || null;
  } else if (nextShipmentStatus === 'Cancelled') {
    nextOrderStatus = 'Cancelled';
  } else if (isShipped) {
    nextOrderStatus = 'Shipped';
  }

  const updateTimestamp = new Date().toISOString();
  relatedItems.forEach((item, index) => {
    item.status = nextOrderStatus;
    item.shipment.is_shipped = isShipped;
    item.shipment.shipment_status = nextShipmentStatus;
    item.shipment.databricks_sync_time = updateTimestamp.replace('T', ' ').substring(0, 19) + ' UTC';
    item.updated_at = updateTimestamp;
    if (nextShipmentStatus === 'Delivered') {
      item.delivery_client_date = suppliedDeliveryDate || item.delivery_client_date;
      item.shipment.actual_delivery_date = item.delivery_client_date || null;
    }
    item.shipment.events.unshift({
      id: `ev-${Date.now()}-${index}`,
      timestamp: updateTimestamp.replace('T', ' ').substring(0, 19),
      location: nextShipmentStatus === 'Delivered' ? item.shipment.destination : 'Databricks Regional Logistics Hub',
      status: nextShipmentStatus,
      description: `Databricks Sync: Delta Lake updated status to [${nextShipmentStatus}]. Carrier ${item.shipment.carrier} checkpoint synchronized.`
    });
  });

  if (activeDataSource === 'postgres') {
    try {
      await saveOrderStateToPostgres(relatedItems);
    } catch (error: any) {
      relatedItems.forEach((item, index) => Object.assign(item, previousItems[index]));
      return res.status(500).json({ error: `Could not save the logistics synchronization in PostgreSQL: ${error?.message || error}` });
    }
  }

  // Trigger automated email/push alert for the shipment status change!
  let alertEventType: DeliveryAlert['event_type'] = 'In Transit';
  if (nextShipmentStatus === 'In Transit') alertEventType = 'Shipment Dispatched';
  if (nextShipmentStatus === 'Out for Delivery') alertEventType = 'Out for Delivery';
  if (nextShipmentStatus === 'Delivered') alertEventType = 'Delivered';
  if (nextShipmentStatus === 'Cancelled') alertEventType = 'Cancelled';

  const groupedOrder = groupOrders(relatedItems)[0];
  const alert = recordDeliveryAlert(
    groupedOrder,
    alertEventType,
    `Delivery Alert: Order ${groupedOrder.id} is ${nextShipmentStatus}`,
    `Live Databricks status change: purchase order ${groupedOrder.purchase_order || groupedOrder.id}, containing ${relatedItems.length} product(s), is now ${nextShipmentStatus}.`
  );

  res.json({
    success: true,
    message: `Databricks shipment sync completed. Status updated to ${nextShipmentStatus}.`,
    order: groupedOrder,
    alert_triggered: alert
  });
});

// 7. Bulk sync all orders with Databricks
app.post('/api/databricks/sync-all', async (req, res) => {
  const nowUtc = new Date().toISOString().replace('T', ' ').substring(0, 19) + ' UTC';
  const previousOrders = orders.map(order => structuredClone(order));

  orders.forEach(order => {
    // Recalcula o estágio usando os dados já disponíveis. Quando a conexão
    // corporativa estiver ativa, os campos serão atualizados antes desta etapa.
    reconcileLifecycle(order);
  });

  if (activeDataSource === 'postgres') {
    try {
      for (const groupedOrder of groupOrders(orders)) {
        await saveOrderStateToPostgres(groupedOrder.items?.length ? groupedOrder.items : [groupedOrder]);
      }
    } catch (error: any) {
      orders = previousOrders;
      return res.status(500).json({ error: `Could not save the bulk synchronization in PostgreSQL: ${error?.message || error}` });
    }
  }

  res.json({
    success: true,
    message: `${groupOrders(orders).length} pedidos foram atualizados automaticamente com base nas datas logísticas disponíveis.`,
    sync_time: nowUtc,
    lakehouse_table: 'gold_logistics.marketplace_shipments'
  });
});

// 8. Update Order (e.g. status change, notes)
app.patch('/api/orders/:id', async (req, res) => {
  const order = findOrderByIdOrPo(req.params.id);
  if (!order) {
    return res.status(404).json({ error: `Order ${req.params.id} not found` });
  }

  const { status, notes, tracking_number, carrier, estimated_delivery, delivery_client_date, entrega_cliente } = req.body;
  if (status === 'Cancelled') {
    return res.status(400).json({ error: 'Use a rota de cancelamento e informe uma justificativa.' });
  }
  const relatedItems = orders.filter(candidate => orderGroupKey(candidate) === orderGroupKey(order));
  const previousItems = relatedItems.map(item => structuredClone(item));

  const oldStatus = order.status;
  const suppliedDeliveryDate = delivery_client_date || entrega_cliente;
  if (status === 'Delivered' && !suppliedDeliveryDate && !order.delivery_client_date) {
    return res.status(400).json({ error: 'Delivered exige a data entrega_cliente.' });
  }
  if (status) order.status = status;
  if (notes !== undefined) order.notes = notes;
  if (tracking_number) order.shipment.tracking_number = tracking_number;
  if (carrier) order.shipment.carrier = carrier;
  if (estimated_delivery) order.shipment.estimated_delivery = estimated_delivery;

  if (status && status !== oldStatus) {
    if (status === 'Shipped') {
      order.shipment.is_shipped = true;
      order.shipment.shipment_status = 'In Transit';
    } else if (status === 'Delivered') {
      order.shipment.is_shipped = true;
      order.shipment.shipment_status = 'Delivered';
      order.delivery_client_date = suppliedDeliveryDate || order.delivery_client_date;
      order.shipment.actual_delivery_date = order.delivery_client_date || null;
    } else if (status === 'Cancelled') {
      order.shipment.is_shipped = false;
      order.shipment.shipment_status = 'Cancelled';
      order.sts_compra = 'CANCELADO';
    }

    order.shipment.events.unshift({
      id: `ev-${Date.now()}`,
      timestamp: new Date().toISOString().replace('T', ' ').substring(0, 19),
      location: 'Admin Portal Dispatch',
      status: order.shipment.shipment_status,
      description: `Manual order status changed from [${oldStatus}] to [${status}]`
    });

    recordDeliveryAlert(
      order,
      status === 'Delivered' ? 'Delivered' : status === 'Shipped' ? 'Shipment Dispatched' : 'Cancelled',
      `Order ${order.id} update: ${status}`,
      `Your order status has changed to ${status}. Tracking: ${order.shipment.tracking_number}.`
    );
  }

  order.updated_at = new Date().toISOString();
  relatedItems.filter(item => item !== order).forEach((item, index) => {
    if (status) {
      const itemOldStatus = item.status;
      item.status = order.status;
      item.shipment.is_shipped = order.shipment.is_shipped;
      item.shipment.shipment_status = order.shipment.shipment_status;
      item.shipment.actual_delivery_date = order.shipment.actual_delivery_date;
      item.delivery_client_date = order.delivery_client_date;
      item.sts_compra = order.sts_compra;
      if (itemOldStatus !== status) {
        item.shipment.events.unshift({
          id: `ev-${Date.now()}-${index}`,
          timestamp: new Date().toISOString().replace('T', ' ').substring(0, 19),
          location: 'Admin Portal Dispatch',
          status: item.shipment.shipment_status,
          description: `Manual order status changed from [${itemOldStatus}] to [${status}]`
        });
      }
    }
    if (notes !== undefined) item.notes = notes;
    if (tracking_number) item.shipment.tracking_number = tracking_number;
    if (carrier) item.shipment.carrier = carrier;
    if (estimated_delivery) item.shipment.estimated_delivery = estimated_delivery;
    item.updated_at = new Date().toISOString();
  });
  if (activeDataSource === 'postgres') {
    try {
      await saveOrderStateToPostgres(relatedItems);
    } catch (error: any) {
      relatedItems.forEach((item, index) => Object.assign(item, previousItems[index]));
      return res.status(500).json({ error: `Could not save the order update in PostgreSQL: ${error?.message || error}` });
    }
  }
  res.json({ success: true, order: groupOrders(relatedItems)[0] });
});

// 9. Delivery Alerts log
app.get('/api/alerts', (req, res) => {
  res.json({
    total: alerts.length,
    alerts
  });
});

// 10. Send / Test Custom Automated Alert
app.post('/api/alerts/test', (req, res) => {
  const { order_id, event_type, recipient_email, message } = req.body;
  const targetOrder = findOrderByIdOrPo(String(order_id || ''));
  if (!targetOrder) return res.status(404).json({ error: `Order ${order_id || ''} not found` });

  const alert = recordDeliveryAlert(
    targetOrder,
    event_type || 'In Transit',
    `Automated Alert Test: ${event_type || 'Status Update'}`,
    message || `This is a test notification for order ${targetOrder.id} dispatched via simulated email/push service.`
  );

  res.json({
    success: true,
    message: 'Test notification alert successfully queued and dispatched',
    alert
  });
});

// 11. Send the monitoring report through the configured corporate SMTP server.
app.post('/api/reports/email', async (req, res) => {
  try {
    const { to, cc, subject, message, language } = req.body || {};
    const isEnglish = language === 'en';
    const label = (pt: string, en: string) => isEnglish ? en : pt;
    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const toList = String(to || '').split(/[;,]/).map(value => value.trim()).filter(Boolean);
    const invalidTo = toList.find(email => !emailPattern.test(email));
    if (!toList.length || invalidTo) {
      return res.status(400).json({ error: label('Informe um e-mail de destinatário válido.', 'Enter a valid recipient email address.') });
    }

    const smtpHost = process.env.SMTP_HOST;
    const smtpPort = Number(process.env.SMTP_PORT || 587);
    const smtpUser = process.env.SMTP_USER;
    const smtpPassword = (process.env.SMTP_PASSWORD || '').replace(/\s+/g, '');
    const smtpFrom = process.env.SMTP_FROM || smtpUser;
    if (!smtpHost || !smtpUser || !smtpPassword || !smtpFrom) {
      return res.status(503).json({
        error: 'O envio ainda não está configurado. Preencha SMTP_HOST, SMTP_PORT, SMTP_USER, SMTP_PASSWORD e SMTP_FROM no arquivo .env.local.'
      });
    }

    const grouped = groupOrders(orders);
    const headersPt = [
      'Data da compra', 'SKU Marketplace', 'Descrição do Material', 'SKU Principal (ASIN)', 'Seller',
      'Origem (País Seller)', 'Ordem de Cliente', 'Ordem de Compra', 'Quantidade',
      'Valor Unitário Seller (USD)', 'Valor Total Seller (USD)', 'Status do Pedido', 'Cliente',
      'Invoice', 'WR Magaya', 'Compra no Marketplace Confirmada', 'Data da Confirmação da Compra',
      'Número de Rastreio', 'Status da Entrega', 'Previsão de Entrega',
      'Unidade', 'Status Operacional', 'Descrição do Status', 'Limite de Entrega (dias)',
      'Data do Pedido Marketplace', 'ID do Pedido Marketplace', 'Grupo da Conta',
      'Status da Conta', 'Responsável', 'Data WR', 'ETA', 'ETD', 'Data DI', 'Entrada CD',
      'Entrega ao Cliente', 'Justificativa do Cancelamento', 'Data da Atualização do Cancelamento'
    ];
    const headersEn = [
      'Purchase Date', 'Marketplace SKU', 'Material Description', 'Primary SKU (ASIN)', 'Seller',
      'Seller Country', 'Customer Order', 'Purchase Order', 'Quantity', 'Seller Unit Cost (USD)',
      'Seller Total Cost (USD)', 'Order Status', 'Customer', 'Invoice', 'Warehouse Receipt',
      'Marketplace Purchase Confirmed', 'Purchase Confirmation Date', 'Tracking Number',
      'Shipment Status', 'Estimated Delivery', 'Unit', 'Operational Status', 'Status Description',
      'Delivery Limit (days)', 'Marketplace Order Date', 'Marketplace Order ID', 'Account Group',
      'Account Status', 'Owner', 'WR Date', 'ETA', 'ETD', 'DI Date', 'Distribution Center Entry',
      'Customer Delivery', 'Cancellation Reason', 'Cancellation Updated At'
    ];
    const headers = isEnglish ? headersEn : headersPt;
    const rows = orders.map(order => [
      order.date_order, String(order.sku || ''), order.product_name, String(order.asin || ''), order.marketplace,
      order.seller_country || '', String(order.customer_order_id || ''), String(order.purchase_order || order.id),
      order.quantity, order.price_unit, order.seller_usd_total ?? order.total_price, order.status,
      order.customer_name, order.invoice || '', order.magaya_wr || '', order.marketplace_purchase_confirmed ? label('SIM','YES') : label('NÃO','NO'),
      order.marketplace_purchase_confirmed_at || '', String(order.shipment.tracking_number || ''),
      order.shipment.shipment_status, order.shipment.estimated_delivery || '', order.unit_measure || '',
      order.operational_status || '', order.status_text || '', order.delivery_limit_days ?? '',
      order.marketplace_order_date || '', order.marketplace_order_id || '', order.account_group || '',
      order.account_order_status || '', order.account_user || '', order.wr_date || '', order.eta || '',
      order.etd || '', order.di_date || '', order.entry_cd_date || '', order.delivery_client_date || '',
      order.cancellation_reason || '', order.cancellation_updated_at || ''
    ]);
    const sheet = XLSX.utils.aoa_to_sheet([headers, ...rows]);
    sheet['!cols'] = headers.map((header, index) => ({ wch: index === 2 ? 42 : Math.max(14, Math.min(28, header.length + 2)) }));
    sheet['!autofilter'] = { ref: sheet['!ref'] || 'A1:R1' };
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, sheet, 'Pedidos');
    const attachment = XLSX.write(workbook, { bookType: 'xlsx', type: 'buffer' });

    const totalRevenue = orders.reduce((sum, order) => sum + (order.status === 'Cancelled' ? 0 : order.total_price), 0);
    const totalVkp2 = orders.reduce((sum, order) => sum + (order.status === 'Cancelled' ? 0 : (order.vkp2_price ?? 0) * order.quantity), 0);
    const counts = Object.fromEntries(['Pending', 'Shipped', 'Delivered', 'Cancelled'].map(status => [status, grouped.filter(order => order.status === status).length]));
    const escapeHtml = (value: unknown) => String(value ?? '').replace(/[&<>"']/g, char => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[char] || char));
    const messageHtml = escapeHtml(message || '').replace(/\n/g, '<br>');
    const validOrders = grouped.filter(order => order.status !== 'Cancelled');
    const openOrders = grouped.filter(order => order.status === 'Pending' || order.status === 'Shipped');
    const orderSalesBrl = (order: Order) => (order.items?.length ? order.items : [order])
      .reduce((sum, item) => sum + (item.vkp2_price ?? 0) * item.quantity, 0);
    const groupSalesBrl = (list: Order[]) => list.reduce((sum, order) => sum + orderSalesBrl(order), 0);
    const formatNumber = (value: number) => value.toFixed(2);
    const formatPercent = (value: number, total: number) => `${(total ? value / total * 100 : 0).toFixed(2)}%`;
    const today = new Date(); today.setHours(0, 0, 0, 0);
    const businessDays = (start?: string, end?: string) => {
      if (!start || !end) return null;
      const current = new Date(`${start.slice(0, 10)}T00:00:00`); const finish = new Date(`${end.slice(0, 10)}T00:00:00`);
      if (Number.isNaN(current.getTime()) || Number.isNaN(finish.getTime())) return null;
      if (finish < current) return 0;
      let total = 0; current.setDate(current.getDate() + 1);
      while (current <= finish) { const weekday = current.getDay(); if (weekday !== 0 && weekday !== 6) total += 1; current.setDate(current.getDate() + 1); }
      return total;
    };
    const todayText = today.toISOString().slice(0, 10);
    const elapsedDays = (order: Order) => businessDays(order.date_order, todayText);
    const onTimeOrders = openOrders.filter(order => { const d = elapsedDays(order); return d !== null && d <= 20; });
    const risk = openOrders.filter(order => { const d = elapsedDays(order); return d !== null && d >= 21 && d <= 25; });
    const overdue = openOrders.filter(order => { const d = elapsedDays(order); return d !== null && d > 25; });
    const onTime = onTimeOrders.length;
    const predictedLeadTimes = grouped.map(order => businessDays(order.date_order, order.shipment.estimated_delivery)).filter((d): d is number => d !== null);
    const averagePredictedLeadTime = predictedLeadTimes.length ? Math.round(predictedLeadTimes.reduce((sum, d) => sum + d, 0) / predictedLeadTimes.length) : 0;
    const productMap = new Map<string, { name: string; quantity: number; value: number }>();
    orders.forEach(order => { const p = productMap.get(order.sku) || { name: order.product_name, quantity: 0, value: 0 }; p.quantity += order.quantity; p.value += order.total_price; productMap.set(order.sku, p); });
    const productRows = [...productMap.entries()].map(([sku, value]) => ({ sku, ...value }));
    const topQuantity = [...productRows].sort((a, b) => b.quantity - a.quantity).slice(0, 10);
    const topValue = [...productRows].sort((a, b) => b.value - a.value).slice(0, 10);
    const monthlyMap = new Map<string, { ids: Set<string>; salesBrl: number; cancelled: Set<string> }>();
    grouped.forEach(order => { const month = order.date_order?.slice(0, 7) || 'Sem data'; const m = monthlyMap.get(month) || { ids: new Set<string>(), salesBrl: 0, cancelled: new Set<string>() }; const id=order.purchase_order||order.id; m.ids.add(id); if(order.status==='Cancelled')m.cancelled.add(id); else m.salesBrl+=orderSalesBrl(order); monthlyMap.set(month,m); });
    const monthly = [...monthlyMap.entries()].sort(([a], [b]) => a.localeCompare(b)).slice(-12);
    const cutoff = new Date(today); cutoff.setDate(today.getDate() - 7);
    const recent = orders.filter(order => order.date_order && new Date(order.date_order) >= cutoff).sort((a, b) => b.date_order.localeCompare(a.date_order)).slice(0, 15);
    const cell = 'padding:7px;border:1px solid #d9e0e8;text-align:center';
    const head = 'padding:8px;border:1px solid #d9e0e8;background:#17324d;color:white;text-align:center';
    const topTable = (title: string, list: typeof topQuantity) => `<h3 style="color:#c2413b;text-align:center;margin-top:28px">${title}</h3><table style="border-collapse:collapse;width:100%;font-size:11px"><tr><th style="${head}">#</th><th style="${head}">SKU</th><th style="${head}">${label('Produto','Product')}</th><th style="${head}">${label('Qtd.','Qty.')}</th><th style="${head}">${label('Custo seller USD','Seller Cost USD')}</th></tr>${list.map((item, index) => `<tr><td style="${cell}">${index + 1}</td><td style="${cell}">${escapeHtml(item.sku)}</td><td style="${cell};text-align:left">${escapeHtml(item.name)}</td><td style="${cell}">${item.quantity}</td><td style="${cell}">${item.value.toFixed(2)}</td></tr>`).join('')}</table>`;
    type MonthlyValue = { ids: Set<string>; salesBrl: number; cancelled: Set<string> };
    const monthlyBarChart = (
      title: string,
      color: string,
      valueOf: (value: MonthlyValue) => number,
      valueLabel: (value: number) => string,
    ) => {
      const maximum = Math.max(1, ...monthly.map(([, value]) => valueOf(value)));
      const rowsHtml = monthly.map(([month, value]) => {
        const amount = valueOf(value);
        const width = amount > 0 ? Math.max(3, Math.round(amount / maximum * 100)) : 0;
        return `<tr>
          <td style="width:72px;padding:6px 8px 6px 0;font-size:11px;color:#475569;white-space:nowrap">${escapeHtml(month)}</td>
          <td style="padding:6px 0">
            <table role="presentation" cellpadding="0" cellspacing="0" style="width:100%;border-collapse:collapse"><tr>
              <td style="width:${width}%;height:17px;background:${color};border-radius:4px"></td>
              <td style="padding-left:8px;font-size:11px;font-weight:bold;color:#1e293b;white-space:nowrap">${escapeHtml(valueLabel(amount))}</td>
            </tr></table>
          </td>
        </tr>`;
      }).join('');
      return `<div style="margin-top:24px;padding:18px;border:1px solid #dbe3ec;border-radius:10px;background:#f8fafc">
        <h3 style="margin:0 0 12px;color:#17324d;font-size:15px">${title}</h3>
        <table role="presentation" cellpadding="0" cellspacing="0" style="width:100%;border-collapse:collapse">${rowsHtml}</table>
      </div>`;
    };
    const emailCharts = monthly.length ? `${monthlyBarChart(
      label('Faturamento mensal (BRL)', 'Monthly Sales Revenue (BRL)'),
      '#059669',
      value => value.salesBrl,
      value => `R$ ${value.toFixed(2)}`,
    )}${monthlyBarChart(
      label('Cancelamentos por mês', 'Monthly Cancelled Orders'),
      '#e11d48',
      value => value.cancelled.size,
      value => String(Math.round(value)),
    )}` : '';
    const html = `<div style="font-family:Arial,sans-serif;color:#1e293b;max-width:850px;margin:auto">
      <div style="background:#17324d;color:white;padding:20px;border-radius:10px 10px 0 0"><h2 style="margin:0">${label('Monitoramento de Vendas Marketplace','Marketplace Sales Monitoring')}</h2></div>
      <div style="padding:22px;border:1px solid #dbe3ec">${messageHtml}<h3 style="color:#c2413b;text-align:center;margin-top:28px">${label('KPIs de acompanhamento','Monitoring KPIs')}</h3>
      <table style="border-collapse:collapse;width:100%;font-size:11px"><tr>${[label('Indicador','Metric'),label('Quantidade','Quantity'),label('Valor','Value'),label('Participação','Share')].map(x => `<th style="${head}">${x}</th>`).join('')}</tr>
      ${[
        [label('Total de pedidos','Total Orders'), grouped.length, `R$ ${formatNumber(totalVkp2)}`, '100.00%'],
        [label('Pedidos válidos','Valid Orders'), validOrders.length, `R$ ${formatNumber(groupSalesBrl(validOrders))}`, formatPercent(validOrders.length, grouped.length)],
        [label('Pedidos em aberto','Open Orders'), openOrders.length, `R$ ${formatNumber(groupSalesBrl(openOrders))}`, formatPercent(openOrders.length, validOrders.length)],
        [label('Em trânsito (com Invoice)','In Transit (invoiced)'), counts.Shipped, `R$ ${formatNumber(groupSalesBrl(grouped.filter(o=>o.status==='Shipped')))}`, formatPercent(counts.Shipped, validOrders.length)],
        [label('No prazo (até 20 dias úteis)','On Time (up to 20 business days)'), onTime, `R$ ${formatNumber(groupSalesBrl(onTimeOrders))}`, formatPercent(onTime, openOrders.length)],
        [label('Risco de atraso (21 a 25 dias úteis)','Delay Risk (21–25 business days)'), risk.length, `R$ ${formatNumber(groupSalesBrl(risk))}`, formatPercent(risk.length, openOrders.length)],
        [label('Atrasado (mais de 25 dias úteis)','Overdue (more than 25 business days)'), overdue.length, `R$ ${formatNumber(groupSalesBrl(overdue))}`, formatPercent(overdue.length, openOrders.length)],
        [label('Prazo médio previsto (dias úteis)','Average Expected Lead Time'), formatNumber(averagePredictedLeadTime), `${formatNumber(averagePredictedLeadTime)} ${label('dias','days')}`, '—'],
        [label('Entregues','Delivered'), counts.Delivered, `R$ ${formatNumber(groupSalesBrl(grouped.filter(o=>o.status==='Delivered')))}`, formatPercent(counts.Delivered, validOrders.length)],
        [label('Cancelados','Cancelled'), counts.Cancelled, `R$ ${formatNumber(groupSalesBrl(grouped.filter(o=>o.status==='Cancelled')))}`, formatPercent(counts.Cancelled, grouped.length)]
      ].map(r => `<tr>${r.map(v=>`<td style="${cell}">${v}</td>`).join('')}</tr>`).join('')}</table>
      <h3 style="color:#c2413b;text-align:center;margin-top:28px">${label('Acompanhamento mensal','Monthly Monitoring')}</h3><table style="border-collapse:collapse;width:100%;font-size:11px"><tr><th style="${head}">${label('Mês','Month')}</th><th style="${head}">${label('Pedidos','Orders')}</th><th style="${head}">${label('Vendas BRL','Sales BRL')}</th><th style="${head}">${label('Cancelados','Cancelled')}</th></tr>${monthly.map(([month,v])=>`<tr><td style="${cell}">${month}</td><td style="${cell}">${v.ids.size}</td><td style="${cell}">R$ ${v.salesBrl.toFixed(2)}</td><td style="${cell}">${v.cancelled.size}</td></tr>`).join('')}</table>
      ${emailCharts}
      <h3 style="color:#c2413b;text-align:center;margin-top:28px">${label('Completude logística','Logistics Data Completion')}</h3><table style="border-collapse:collapse;width:100%;font-size:11px"><tr>${[label('Campo','Field'),label('Preenchidos','Completed'),label('Total de itens','Total Items'),label('Cobertura','Coverage')].map(x=>`<th style="${head}">${x}</th>`).join('')}</tr>${[[label('Rastreio','Tracking'),orders.filter(o=>o.shipment.tracking_number).length],['Invoice',orders.filter(o=>o.invoice).length],['WR',orders.filter(o=>o.magaya_wr).length],[label('Previsão','Forecast'),orders.filter(o=>o.shipment.estimated_delivery).length]].map(([fieldName,count])=>`<tr><td style="${cell}">${fieldName}</td><td style="${cell}">${count}</td><td style="${cell}">${orders.length}</td><td style="${cell}">${orders.length?(Number(count)/orders.length*100).toFixed(1):0}%</td></tr>`).join('')}</table>
      ${topTable(label('Top 10 produtos por quantidade','Top 10 Products by Quantity'), topQuantity)}${topTable(label('Top 10 produtos por custo seller (USD)','Top 10 Products by Seller Cost (USD)'), topValue)}
      <h3 style="color:#c2413b;text-align:center;margin-top:28px">${label('Pedidos — últimos 7 dias','Orders — Last 7 Days')}</h3><table style="border-collapse:collapse;width:100%;font-size:10px"><tr>${(isEnglish?['Date','Customer Order','PO','SKU','Product','Qty.','Status','Tracking','ETA']:['Data','Ordem Cliente','PO','SKU','Produto','Qtd.','Status','Rastreio','Previsão']).map(x=>`<th style="${head}">${x}</th>`).join('')}</tr>${recent.length?recent.map(o=>`<tr><td style="${cell}">${o.date_order}</td><td style="${cell}">${o.customer_order_id||''}</td><td style="${cell}">${o.purchase_order||''}</td><td style="${cell}">${o.sku}</td><td style="${cell};text-align:left">${escapeHtml(o.product_name)}</td><td style="${cell}">${o.quantity}</td><td style="${cell}">${o.status}</td><td style="${cell}">${o.shipment.tracking_number||''}</td><td style="${cell}">${o.shipment.estimated_delivery||''}</td></tr>`).join(''):`<tr><td colspan="9" style="${cell}">${label('Nenhum pedido no período.','No orders in the selected period.')}</td></tr>`}</table>
      <p style="font-size:12px;color:#64748b;margin-top:20px">${label(`A planilha detalhada com ${rows.length} itens está anexada a este e-mail.`,`The detailed spreadsheet with ${rows.length} items is attached to this email.`)}</p></div></div>`;

    const transporter = nodemailer.createTransport({
      host: smtpHost,
      port: smtpPort,
      secure: String(process.env.SMTP_SECURE).toLowerCase() === 'true',
      auth: { user: smtpUser, pass: smtpPassword },
    });
    const ccList = String(cc || '').split(/[;,]/).map(value => value.trim()).filter(Boolean);
    const invalidCc = ccList.find(email => !emailPattern.test(email));
    if (invalidCc) return res.status(400).json({ error: `E-mail em cópia inválido: ${invalidCc}` });

    const info = await transporter.sendMail({
      from: smtpFrom,
      to: toList,
      cc: ccList,
      subject: subject || `${label('Relatório de Monitoramento','Monitoring Report')} - ${new Date().toLocaleDateString(isEnglish?'en-US':'pt-BR')}`,
      text: message || label('Segue o relatório atualizado de monitoramento.','Please find the updated monitoring report attached.'),
      html,
      attachments: [{ filename: `Marketplace_Orders_${new Date().toISOString().slice(0, 10)}.xlsx`, content: attachment }],
    });
    res.json({ success: true, messageId: info.messageId });
  } catch (error: any) {
    console.error('Report email error:', error);
    res.status(500).json({ error: `Falha ao enviar e-mail: ${error.message || 'erro desconhecido'}` });
  }
});

// ----------------------------------------------------
// VITE OR STATIC SERVING
// ----------------------------------------------------
async function startServer() {
  if (postgresEnabled()) {
    try {
      const databaseOrders = await loadOrdersFromPostgres();
      if (!databaseOrders.length) throw new Error('The database is connected but returned no order items.');
      orders = deduplicateOrderLines(databaseOrders);
      activeDataSource = 'postgres';
      databaseConnectionStatus = 'connected';
      databaseConnectionMessage = `PostgreSQL connected. Loaded ${orders.length} order items.`;
      console.log(databaseConnectionMessage);
    } catch (error: any) {
      activeDataSource = 'synthetic';
      databaseConnectionStatus = 'error';
      databaseConnectionMessage = `PostgreSQL connection failed; using the bundled synthetic dataset. ${error?.message || ''}`.trim();
      console.error(databaseConnectionMessage);
    }
  }

  if (process.env.NODE_ENV !== 'production') {
    const vite = await createViteServer({
      server: { middlewareMode: true },
      appType: 'spa',
    });
    app.use(vite.middlewares);
  } else {
    const distPath = path.join(process.cwd(), 'dist');
    app.use(express.static(distPath));
    app.get('*', (req, res) => {
      res.sendFile(path.join(distPath, 'index.html'));
    });
  }

  app.listen(PORT, '0.0.0.0', () => {
    console.log(`Server running on http://0.0.0.0:${PORT}`);
  });
}

startServer();
