import express from 'express';
import path from 'path';
import fs from 'fs';
import { createServer as createViteServer } from 'vite';
import { CSV_ORDERS } from './src/data/seededOrders';
import dotenv from 'dotenv';
import nodemailer from 'nodemailer';
import crypto from 'crypto';
import * as XLSX from 'xlsx';
import { requireRoles } from './server/auth';

import {
  loadOrdersFromPostgres,
  insertOrdersToPostgres,
  postgresEnabled,
  saveCancellationToPostgres,
  restoreCancellationInPostgres,
  saveOrderStateToPostgres,
  saveOrderNotesToPostgres,
  savePurchaseConfirmationToPostgres,
} from './server/postgresOrders';
import { databricksSyncEnabled, databricksTableName, loadOrdersFromDatabricks } from './server/databricksSync';

dotenv.config({ path: '.env.local' });
dotenv.config();

const app = express();
const PORT = Number(process.env.PORT || 3000);

// Batch spreadsheets can legitimately exceed Express' 100 KB default after
// conversion to JSON. Keep a bounded limit large enough for demo workbooks.
app.use(express.json({ limit: '5mb' }));

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
  const remoteAddress = request.socket.remoteAddress || '';
  const isLocalRequest = remoteAddress === '127.0.0.1'
    || remoteAddress === '::1'
    || remoteAddress === '::ffff:127.0.0.1';

  if (readOnlyMethods.includes(request.method)) {
    next();
    return;
  }

  if (request.path === '/reports/email') {
    if (isLocalRequest && process.env.NODE_ENV !== 'production') {
      next();
      return;
    }
    requireReportAccess(request, response, next);
    return;
  }

  // Local-only SMTP diagnostics may be used from read-only demo access. This
  // exception never applies to a deployed instance.
  if ((request.path === '/alerts/test' || request.path === '/alerts/send-daily') && isLocalRequest && process.env.NODE_ENV !== 'production') {
    next();
    return;
  }

  if (request.path === '/databricks/reconcile') {
    const configuredSecret = process.env.DATABRICKS_WEBHOOK_SECRET?.trim();
    const suppliedSecret = request.header('x-marketops-integration-key')?.trim();
    if (configuredSecret && suppliedSecret
      && configuredSecret.length === suppliedSecret.length
      && crypto.timingSafeEqual(Buffer.from(suppliedSecret), Buffer.from(configuredSecret))) {
      next();
      return;
    }
  }

  requireOrderManager(request, response, next);
});

// In-memory application state seeded with a fully synthetic demo dataset.
interface ShipmentEvent {
  id: string;
  timestamp: string;
  location: string;
  status: 'Not Shipped' | 'Preparing' | 'In Transit' | 'At Distribution Center' | 'Out for Delivery' | 'Delivered' | 'Returned' | 'Cancelled';
  description: string;
}

interface ShipmentData {
  is_shipped: boolean;
  carrier: string;
  tracking_number: string;
  estimated_delivery: string;
  actual_delivery_date: string | null;
  shipment_status: 'Not Shipped' | 'Preparing' | 'In Transit' | 'At Distribution Center' | 'Out for Delivery' | 'Delivered' | 'Returned' | 'Cancelled';
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
  customer_cpf?: string;
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
  billing_date?: string;
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
  status: 'queued' | 'sent' | 'delivered' | 'simulated' | 'failed';
  intended_email?: string;
  recipient_phone?: string;
  delivery_detail?: string;
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
const orderNotesPath = path.join(process.cwd(), 'data', 'order-notes.json');
type PurchaseConfirmation = { confirmed: boolean; confirmed_at: string };
let savedConfirmations: Record<string, PurchaseConfirmation> = {};
type SavedCancellation = string | { reason: string; updated_at?: string };
let savedCancellationReasons: Record<string, SavedCancellation> = {};
type SavedOrderNote = string | { notes: string; updated_at?: string };
let savedOrderNotes: Record<string, SavedOrderNote> = {};
try {
  if (fs.existsSync(confirmationsPath)) savedConfirmations = JSON.parse(fs.readFileSync(confirmationsPath, 'utf8'));
  if (fs.existsSync(cancellationReasonsPath)) savedCancellationReasons = JSON.parse(fs.readFileSync(cancellationReasonsPath, 'utf8'));
  if (fs.existsSync(orderNotesPath)) savedOrderNotes = JSON.parse(fs.readFileSync(orderNotesPath, 'utf8'));
} catch (error) {
  console.error('Could not read persisted operational data:', error);
}

let orders: Order[] = deduplicateOrderLines(CSV_ORDERS.map((o, index) => {
  const key = orderGroupKey(o);
  const savedCancellation = savedCancellationReasons[key];
  const cancellationReason = typeof savedCancellation === 'string' ? savedCancellation : savedCancellation?.reason;
  const cancellationUpdatedAt = typeof savedCancellation === 'string' ? undefined : savedCancellation?.updated_at;
  const savedConfirmationAt = savedConfirmations[key]?.confirmed_at;
  const savedOrderNote = savedOrderNotes[key];
  const persistedOrderNote = typeof savedOrderNote === 'string' ? savedOrderNote : savedOrderNote?.notes;
  const noteUpdatedAt = typeof savedOrderNote === 'string' ? undefined : savedOrderNote?.updated_at;
  const persistedUpdateDates = [o.updated_at, savedConfirmationAt, cancellationUpdatedAt, noteUpdatedAt].filter((value): value is string => Boolean(value));
  return {
    ...o,
    id: `${o.purchase_order || o.id}-${o.sequencial || o.sku || index}`,
    status: cancellationReason ? 'Cancelled' : o.status,
    sts_compra: cancellationReason ? 'CANCELADO' : o.sts_compra,
    shipment: cancellationReason ? { ...o.shipment, is_shipped: false, shipment_status: 'Cancelled' } : o.shipment,
    marketplace_purchase_confirmed: savedConfirmations[key]?.confirmed ?? Boolean(o.marketplace_order_date || o.marketplace_order_id),
    marketplace_purchase_confirmed_at: savedConfirmations[key]?.confirmed_at || o.marketplace_order_date || undefined,
    notes: persistedOrderNote ?? o.notes,
    cancellation_reason: cancellationReason || undefined,
    cancellation_updated_at: cancellationReason ? (cancellationUpdatedAt || o.cancellation_updated_at || new Date().toISOString()) : o.cancellation_updated_at,
    updated_at: persistedUpdateDates.sort().at(-1) || o.updated_at,
  };
}));

const DEMO_PHONE = '92 99999-9999';

const demoEmailFor = (name: string) => {
  const slug = (name || 'cliente-demo')
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '.')
    .replace(/^\.|\.$/g, '')
    .slice(0, 42) || 'cliente-demo';
  return `${slug}@example.com`;
};

const applyDemoContactDefaults = (source: Order[]) => {
  source.forEach((order) => {
    if (!order.customer_email) order.customer_email = demoEmailFor(order.customer_name);
    if (!order.customer_phone) order.customer_phone = DEMO_PHONE;
  });
  return source;
};

applyDemoContactDefaults(orders);

let activeDataSource: 'synthetic' | 'postgres' = 'synthetic';
let databaseConnectionStatus: 'disabled' | 'connected' | 'error' = 'disabled';
let databaseConnectionMessage = 'Using the bundled synthetic dataset.';
let lastDatabricksPullAt = 0;
let lastDatabricksPullIso = '';
let lastDatabricksPullError = '';
let databricksPullPromise: Promise<void> | null = null;

const databricksLineKey = (order: Order) => [
  normalizeKeyPart(order.purchase_order || order.id),
  normalizeKeyPart(order.sku),
].join(':::');

const mergeDatabricksItem = (source: Order, existing?: Order): Order => {
  if (!existing) return source;
  const hasLocalCancellation = Boolean(existing.cancellation_reason);
  return {
    ...existing,
    ...source,
    sequencial: existing.sequencial || source.sequencial,
    notes: existing.notes,
    marketplace_purchase_confirmed: existing.marketplace_purchase_confirmed,
    marketplace_purchase_confirmed_at: existing.marketplace_purchase_confirmed_at,
    cancellation_reason: hasLocalCancellation ? existing.cancellation_reason : source.cancellation_reason,
    cancellation_updated_at: hasLocalCancellation ? existing.cancellation_updated_at : source.cancellation_updated_at,
    status: hasLocalCancellation ? 'Cancelled' : source.status,
    status_text: hasLocalCancellation ? existing.status_text : source.status_text,
    shipment: {
      ...existing.shipment,
      ...source.shipment,
      shipment_status: hasLocalCancellation ? 'Cancelled' : source.shipment.shipment_status,
      actual_delivery_date: hasLocalCancellation ? null : source.shipment.actual_delivery_date,
      events: source.shipment.events.length ? source.shipment.events : existing.shipment.events,
    },
  };
};

const refreshDatabricksIfDue = async (force = false) => {
  if (!databricksSyncEnabled()) return;
  const intervalMs = Math.max(5000, Number(process.env.DATABRICKS_POLL_INTERVAL_MS || 15000));
  if (!force && Date.now() - lastDatabricksPullAt < intervalMs) return;
  if (databricksPullPromise) return databricksPullPromise;

  databricksPullPromise = (async () => {
    try {
      const sourceItems = await loadOrdersFromDatabricks();
      const currentByKey = new Map(orders.map(item => [databricksLineKey(item), item] as const));
      const mergedSourceItems = sourceItems.map(item => mergeDatabricksItem(item, currentByKey.get(databricksLineKey(item))));

      if (activeDataSource === 'postgres') {
        await insertOrdersToPostgres(mergedSourceItems);
        orders = applyDemoContactDefaults(deduplicateOrderLines(await loadOrdersFromPostgres()));
      } else {
        const sourceKeys = new Set(mergedSourceItems.map(databricksLineKey));
        const localOnly = orders.filter(item => !sourceKeys.has(databricksLineKey(item)));
        orders = applyDemoContactDefaults(deduplicateOrderLines([...mergedSourceItems, ...localOnly]));
      }

      lastDatabricksPullAt = Date.now();
      lastDatabricksPullIso = new Date().toISOString();
      lastDatabricksPullError = '';
      console.log(`Databricks synchronized: ${sourceItems.length} product lines from ${databricksTableName()}.`);
    } catch (error: any) {
      lastDatabricksPullAt = Date.now();
      lastDatabricksPullError = error?.message || String(error);
      console.error(`Databricks synchronization failed: ${lastDatabricksPullError}`);
    } finally {
      databricksPullPromise = null;
    }
  })();

  return databricksPullPromise;
};

const isCancellationStatus = (...values: unknown[]) => values.some(value =>
  typeof value === 'string' && value.toUpperCase().includes('CANCEL')
);

const reconcileLifecycle = (order: Order, source: Record<string, unknown> = {}) => {
  const value = (...keys: string[]) => keys.map(key => source[key]).find(item => item !== undefined && item !== null && item !== '');
  const asText = (...keys: string[]) => {
    const found = value(...keys);
    return found === undefined ? undefined : String(found).trim();
  };

  order.customer_email = asText('customer_email', 'email_cliente') ?? order.customer_email;
  order.customer_phone = asText('customer_phone', 'telefone_cliente') ?? order.customer_phone ?? DEMO_PHONE;
  order.customer_cpf = asText('customer_cpf', 'cpf_cliente', 'cpf') ?? order.customer_cpf;
  order.invoice = asText('invoice') ?? order.invoice;
  order.wr_date = asText('wr_date') ?? order.wr_date;
  order.eta = asText('eta') ?? order.eta;
  order.etd = asText('etd') ?? order.etd;
  order.di_date = asText('di_date', 'data_di') ?? order.di_date;
  order.entry_cd_date = asText('entry_cd_date', 'entrada_cd') ?? order.entry_cd_date;
  order.billing_date = asText('billing_date', 'data_faturamento', 'faturamento') ?? order.billing_date;
  order.delivery_client_date = asText('delivery_client_date', 'entrega_cliente') ?? order.delivery_client_date;
  order.shipment.carrier = asText('carrier', 'transportadora') ?? order.shipment.carrier;
  order.shipment.tracking_number = asText('tracking_number', 'rastreio') ?? order.shipment.tracking_number;
  order.shipment.estimated_delivery = asText('estimated_delivery', 'previsao_entrega') ?? order.shipment.estimated_delivery;
  order.shipment.destination = asText('destination', 'destino') ?? order.shipment.destination;
  order.shipment.origin_hub = asText('origin_hub', 'origem_logistica') ?? order.shipment.origin_hub;

  const explicitStatus = (asText('shipment_status', 'delivery_status', 'status_entrega') || '').toUpperCase();
  const isOutForDelivery = explicitStatus.includes('OUT FOR DELIVERY') || explicitStatus.includes('SAIU PARA ENTREGA') || explicitStatus.includes('ROTA DE ENTREGA');

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
  } else if (order.billing_date || isOutForDelivery) {
    order.status = 'Shipped';
    order.sts_compra = 'COMPRADO';
    order.shipment.is_shipped = true;
    order.shipment.shipment_status = 'Out for Delivery';
    order.shipment.actual_delivery_date = null;
  } else if (order.entry_cd_date) {
    order.status = 'Shipped';
    order.sts_compra = 'COMPRADO';
    order.shipment.is_shipped = true;
    order.shipment.shipment_status = 'At Distribution Center';
    order.shipment.actual_delivery_date = null;
  } else if (order.invoice || order.wr_date || order.etd || order.eta || order.di_date || explicitStatus.includes('TRANSIT')) {
    order.status = 'Shipped';
    order.sts_compra = 'COMPRADO';
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

const saveOrderNotes = () => {
  const payload: Record<string, { notes: string; updated_at?: string }> = {};
  for (const order of orders) {
    if (order.notes !== undefined) {
      payload[orderGroupKey(order)] = { notes: order.notes || '', updated_at: order.updated_at };
    }
  }
  fs.mkdirSync(path.dirname(orderNotesPath), { recursive: true });
  fs.writeFileSync(orderNotesPath, JSON.stringify(payload, null, 2), 'utf8');
};

const findOrderByIdOrPo = (identifier: string) => {
  return orders.find(
    o => o.id === identifier || o.purchase_order === identifier || o.customer_order_id === identifier
  );
};

const escapeHtml = (value: unknown) => String(value ?? '').replace(/[&<>"']/g, char => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' }[char] || char));

let alerts: DeliveryAlert[] = [];
const dailyAlertDispatchKeys = new Set<string>();

const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
const smtpSettings = () => {
  const host = process.env.SMTP_HOST?.trim();
  const port = Number(process.env.SMTP_PORT || 587);
  const user = process.env.SMTP_USER?.trim();
  const password = (process.env.SMTP_PASSWORD || '').replace(/\s+/g, '');
  const from = process.env.SMTP_FROM?.trim() || user;
  return {
    host,
    port,
    user,
    password,
    from,
    secure: String(process.env.SMTP_SECURE).toLowerCase() === 'true',
    connectionTimeout: Number(process.env.SMTP_CONNECTION_TIMEOUT_MS || 10_000),
    configured: Boolean(host && user && password && from),
  };
};

const createSmtpTransport = (smtp: ReturnType<typeof smtpSettings>) => nodemailer.createTransport({
  host: smtp.host,
  port: smtp.port,
  secure: smtp.secure,
  auth: { user: smtp.user, pass: smtp.password },
  connectionTimeout: smtp.connectionTimeout,
  greetingTimeout: smtp.connectionTimeout,
  socketTimeout: smtp.connectionTimeout,
});

const resendSettings = () => {
  const apiKey = process.env.RESEND_API_KEY?.trim();
  const from = process.env.RESEND_FROM?.trim() || 'MarketOps <onboarding@resend.dev>';
  return { apiKey, from, configured: Boolean(apiKey && from) };
};

const sendWithResend = async (payload: {
  to: string | string[];
  subject: string;
  text?: string;
  html?: string;
  cc?: string[];
  replyTo?: string;
  attachments?: Array<{ filename: string; content: Buffer }>;
}) => {
  const resend = resendSettings();
  if (!resend.configured) throw new Error('Resend não configurado.');
  const response = await fetch('https://api.resend.com/emails', {
    method: 'POST',
    headers: {
      Authorization: `Bearer ${resend.apiKey}`,
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      from: resend.from,
      to: Array.isArray(payload.to) ? payload.to : [payload.to],
      cc: payload.cc?.length ? payload.cc : undefined,
      reply_to: payload.replyTo || undefined,
      subject: payload.subject,
      text: payload.text,
      html: payload.html,
      attachments: payload.attachments?.map(file => ({
        filename: file.filename,
        content: file.content.toString('base64'),
      })),
    }),
  });
  const data: any = await response.json().catch(() => ({}));
  if (!response.ok) {
    throw new Error(data?.message || data?.error || `Resend retornou HTTP ${response.status}`);
  }
  return { messageId: data?.id || 'resend-accepted' };
};

const statusLabelPt = (status: ShipmentData['shipment_status']) => ({
  'Not Shipped': 'Pedido recebido',
  Preparing: 'Preparando envio',
  'In Transit': 'Em trânsito',
  'Out for Delivery': 'Saiu para entrega',
  Delivered: 'Entregue',
  Returned: 'Devolvido',
  Cancelled: 'Cancelado',
}[status] || status);

const eventTypeForShipmentStatus = (status: ShipmentData['shipment_status']): DeliveryAlert['event_type'] => {
  if (status === 'Not Shipped' || status === 'Preparing') return 'Order Placed';
  if (status === 'In Transit') return 'Shipment Dispatched';
  if (status === 'Out for Delivery') return 'Out for Delivery';
  if (status === 'Delivered') return 'Delivered';
  if (status === 'Cancelled') return 'Cancelled';
  return 'In Transit';
};

const eventTypeLabelPt = (eventType: DeliveryAlert['event_type']) => ({
  'Order Placed': 'Pedido recebido',
  'Shipment Dispatched': 'Pedido despachado',
  'In Transit': 'Em trânsito',
  'Out for Delivery': 'Saiu para entrega',
  'Delivered': 'Entregue',
  'Delivery Exception': 'Ocorrência na entrega',
  'Cancelled': 'Cancelado',
}[eventType] || eventType);

const customerStage = (order: Order) => {
  if (order.status === 'Cancelled' || order.shipment.shipment_status === 'Cancelled') {
    return { index: -1, title: 'Pedido cancelado', date: order.cancellation_updated_at, message: `O pedido ${order.purchase_order || order.id} foi cancelado. Motivo: ${order.cancellation_reason || 'motivo ainda não informado'}.` };
  }
  const stages = [
    { title: 'Pedido registrado', date: order.date_order, message: `O pedido ${order.purchase_order || order.id} foi registrado em nosso sistema.` },
    { title: 'Preparando envio', date: order.marketplace_purchase_confirmed_at, message: `A compra do pedido ${order.purchase_order || order.id} foi confirmada e está sendo preparada.` },
    { title: 'Pedido enviado', date: order.etd, message: `O pedido ${order.purchase_order || order.id} saiu da warehouse com destino a Manaus.${order.shipment.tracking_number ? ` Rastreio: ${order.shipment.tracking_number}.` : ''}` },
    { title: 'Chegou em Manaus', date: order.eta, message: `O pedido ${order.purchase_order || order.id} chegou a Manaus e seguirá para o centro de distribuição.` },
    { title: 'Chegou ao centro de distribuição', date: order.entry_cd_date, message: `O pedido ${order.purchase_order || order.id} chegou ao centro de distribuição da empresa.` },
    { title: 'Saiu para entrega', date: order.billing_date, message: `O pedido ${order.purchase_order || order.id} foi faturado e saiu para entrega ao cliente.` },
    { title: 'Pedido entregue', date: order.delivery_client_date, message: `O pedido ${order.purchase_order || order.id} foi entregue ao cliente.` },
  ];
  let index = 0;
  stages.forEach((stage, position) => { if (stage.date) index = position; });
  return { index, ...stages[index] };
};

const customerMessageForEvent = (order: Order, eventType: DeliveryAlert['event_type']) => {
  const stage = customerStage(order);
  if (stage.message) return stage.message;
  const po = order.purchase_order || order.id;
  const eta = order.shipment.estimated_delivery;
  const tracking = order.shipment.tracking_number;
  switch (eventType) {
    case 'Order Placed':
      return `Recebemos o pedido ${po}. Avisaremos automaticamente quando houver uma nova etapa logística.`;
    case 'Shipment Dispatched':
      return `Boa notícia: o pedido ${po} foi despachado e já está em trânsito.${tracking ? ` O código de rastreio é ${tracking}.` : ''}`;
    case 'In Transit':
      return order.entry_cd_date
        ? `O pedido ${po} chegou ao centro de distribuição em Manaus e seguirá para a etapa de entrega.${eta ? ` A previsão de entrega é ${eta}.` : ''}`
        : `O pedido ${po} continua em trânsito.${eta ? ` A previsão de entrega é ${eta}.` : ''}`;
    case 'Out for Delivery':
      return `Seu pedido ${po} saiu para entrega e está a caminho do destino final. Fique atento ao recebimento.`;
    case 'Delivered':
      return `O pedido ${po} foi marcado como entregue. Esperamos que tenha chegado tudo certo.`;
    case 'Delivery Exception':
      return `Identificamos uma ocorrência na entrega do pedido ${po}. Nossa equipe está acompanhando a atualização logística.`;
    case 'Cancelled':
      return `O pedido ${po} foi cancelado. Consulte o acompanhamento do pedido para mais detalhes.`;
    default:
      return `O pedido ${po} recebeu uma nova atualização logística.`;
  }
};

const buildDeliveryAlertHtml = (order: Order, title: string, message: string, eventType: DeliveryAlert['event_type']) => {
  const po = order.purchase_order || order.id;
  const stage = customerStage(order);
  const status = stage.title;
  const tracking = order.shipment.tracking_number || 'Será informado assim que disponível';
  const carrier = order.shipment.carrier || 'A definir';
  const eta = order.shipment.estimated_delivery || 'Em atualização';
  const steps = [
    { label: 'Pedido registrado', date: order.date_order },
    { label: 'Preparando envio', date: order.marketplace_purchase_confirmed_at },
    { label: 'Pedido enviado', date: order.etd },
    { label: 'Chegou em Manaus', date: order.eta },
    { label: 'Chegou ao CD', date: order.entry_cd_date },
    { label: 'Saiu para entrega', date: order.billing_date },
    { label: 'Entregue', date: order.delivery_client_date },
  ];
  const activeStep = stage.index;
  const progress = eventType === 'Cancelled'
    ? `<div style="margin:20px 0;padding:16px;border-radius:12px;background:#fff1f2;border:1px solid #fecdd3;color:#9f1239"><strong>Pedido cancelado</strong><div style="margin-top:6px;font-size:12px">Motivo: ${escapeHtml(order.cancellation_reason || 'Motivo ainda não informado')}</div></div>`
    : `<table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="margin:20px 0;table-layout:fixed"><tr>${steps.map((step, index) => {
        const complete = index <= activeStep;
        return `<td align="center" valign="top" style="position:relative"><div style="height:4px;background:${complete ? '#2563eb' : '#dbe4ef'};margin:10px 0 -12px"></div><div style="position:relative;margin:auto;width:20px;height:20px;line-height:20px;border-radius:50%;background:${complete ? '#2563eb' : '#dbe4ef'};color:white;font-size:10px;font-weight:700">${complete ? '✓' : index + 1}</div><div style="margin-top:8px;font-size:9px;line-height:1.25;color:${complete ? '#1e3a8a' : '#64748b'};font-weight:${index === activeStep ? '700' : '400'}">${step.label}</div><div style="margin-top:3px;font-size:8px;color:#64748b">${step.date ? escapeHtml(step.date.slice(0, 10).split('-').reverse().join('/')) : '—'}</div></td>`;
      }).join('')}</tr></table>`;
  return `<!doctype html><html><body style="margin:0;background:#f1f5f9;font-family:Arial,sans-serif;color:#172033">
    <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="background:#f1f5f9;padding:28px 12px"><tr><td align="center">
      <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="max-width:620px;background:#ffffff;border:1px solid #dbe4ef;border-radius:16px;overflow:hidden">
        <tr><td style="background:#17324d;color:#ffffff;padding:22px 26px"><div style="font-size:12px;opacity:.8">MarketOps • Atualização automática de entrega</div><h2 style="margin:6px 0 0;font-size:20px">${escapeHtml(stage.title || title)}</h2></td></tr>
        <tr><td style="padding:26px">
          <p style="margin:0 0 14px;font-size:14px">Olá, <strong>${escapeHtml(order.customer_name)}</strong>.</p>
          <p style="margin:0 0 18px;font-size:14px;line-height:1.6">${escapeHtml(message)}</p>
          ${progress}
          <table role="presentation" width="100%" cellpadding="0" cellspacing="0" style="border-collapse:separate;border-spacing:0 8px;font-size:13px">
            <tr><td style="color:#64748b;width:42%">Pedido</td><td style="font-weight:700">${escapeHtml(po)}</td></tr>
            <tr><td style="color:#64748b">CPF</td><td>${escapeHtml(order.customer_cpf || 'Não informado')} ${order.customer_cpf ? '<span style="color:#94a3b8;font-size:10px">(dado fictício de demonstração)</span>' : ''}</td></tr>
            <tr><td style="color:#64748b">Status</td><td style="font-weight:700;color:#1d4ed8">${escapeHtml(status)}</td></tr>
            <tr><td style="color:#64748b">Rastreio</td><td style="font-weight:700">${escapeHtml(tracking)}</td></tr>
            <tr><td style="color:#64748b">Transportadora</td><td>${escapeHtml(carrier)}</td></tr>
            <tr><td style="color:#64748b">Previsão de entrega</td><td>${escapeHtml(eta)}</td></tr>
          </table>
        </td></tr>
      </table>
    </td></tr></table>
  </body></html>`;
};

function recordDeliveryAlert(
  order: Order,
  eventType: DeliveryAlert['event_type'],
  customSubject?: string,
  customMsg?: string,
  recipientOverride?: string,
): DeliveryAlert {
  const alertId = `ALT-${Date.now().toString().slice(-6)}${Math.floor(Math.random() * 100)}`;
  const subject = customSubject || `[MarketOps] ${customerStage(order).title} • Pedido ${order.purchase_order || order.id}`;
  const message = customMsg || customerMessageForEvent(order, eventType);
  const intendedEmail = order.customer_email?.trim() || '';
  const selectedRecipient = recipientOverride?.trim() || intendedEmail;

  const alert: DeliveryAlert = {
    id: alertId,
    order_id: order.purchase_order || order.id,
    customer_name: order.customer_name,
    recipient_email: selectedRecipient,
    intended_email: intendedEmail,
    recipient_phone: order.customer_phone || DEMO_PHONE,
    type: 'email',
    event_type: eventType,
    subject,
    message,
    timestamp: new Date().toISOString().replace('T', ' ').substring(0, 19),
    status: 'queued',
  };

  alerts.unshift(alert);
  alerts = alerts.slice(0, 100);
  return alert;
}

async function dispatchDeliveryAlert(
  order: Order,
  eventType: DeliveryAlert['event_type'],
  customSubject?: string,
  customMsg?: string,
  recipientOverride?: string,
): Promise<DeliveryAlert> {
  const alert = recordDeliveryAlert(order, eventType, customSubject, customMsg, recipientOverride);
  const intended = alert.intended_email || '';
  const demoRedirect = process.env.DEMO_ALERT_RECIPIENT?.trim();
  const isReservedDemoAddress = /@example\.(com|org|net)$/i.test(intended);
  const recipient = recipientOverride?.trim() || (isReservedDemoAddress && demoRedirect ? demoRedirect : intended);
  const smtp = smtpSettings();
  const resend = resendSettings();

  if (!recipient || !emailPattern.test(recipient)) {
    alert.status = 'simulated';
    alert.delivery_detail = 'E-mail do cliente não disponível. O evento foi registrado no histórico.';
    return alert;
  }

  if (isReservedDemoAddress && !recipientOverride && !demoRedirect) {
    alert.status = 'simulated';
    alert.delivery_detail = 'Contato sintético: configure DEMO_ALERT_RECIPIENT para receber os alertas reais da demonstração.';
    return alert;
  }

  if (!resend.configured && !smtp.configured) {
    alert.status = 'simulated';
    alert.delivery_detail = 'Nenhum provedor de e-mail configurado. O alerta foi registrado, mas não enviado externamente.';
    return alert;
  }

  try {
    let messageId = '';
    let provider = '';
    if (resend.configured) {
      const info = await sendWithResend({
        to: recipient,
        subject: alert.subject,
        text: alert.message,
        html: buildDeliveryAlertHtml(order, eventTypeLabelPt(eventType), alert.message, eventType),
      });
      messageId = info.messageId;
      provider = 'Resend';
    } else {
      const transporter = createSmtpTransport(smtp);
      const info = await transporter.sendMail({
        from: smtp.from,
        to: recipient,
        subject: alert.subject,
        text: alert.message,
        html: buildDeliveryAlertHtml(order, eventTypeLabelPt(eventType), alert.message, eventType),
      });
      messageId = info.messageId;
      provider = 'SMTP';
    }
    alert.recipient_email = recipient;
    alert.status = 'sent';
    alert.delivery_detail = `${provider} aceitou a mensagem (${messageId}).`;
    return alert;
  } catch (error: any) {
    alert.status = 'failed';
    alert.delivery_detail = error?.message || 'Falha desconhecida ao enviar o e-mail.';
    return alert;
  }
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

app.get('/api/email/status', (_req, res) => {
  const smtp = smtpSettings();
  const resend = resendSettings();
  const senderAddress = smtp.from?.match(/<([^>]+)>/)?.[1] || smtp.from || smtp.user || '';
  res.json({
    configured: resend.configured || smtp.configured,
    demo_redirect_configured: Boolean(process.env.DEMO_ALERT_RECIPIENT?.trim()),
    mode: resend.configured ? 'resend' : (smtp.configured ? 'smtp' : 'log-only'),
    allowed_senders: process.env.NODE_ENV !== 'production'
      ? [...new Set([smtp.user, senderAddress, ...(process.env.SMTP_ALLOWED_FROM_ADDRESSES || '').split(/[;,]/)].map(value => value?.trim()).filter(Boolean))]
      : [],
  });
});

app.post('/api/email/verify', async (_req, res) => {
  const resend = resendSettings();
  if (resend.configured) {
    return res.json({ verified: true, provider: 'resend', message: 'Resend configurado. Faça um alerta de teste para validar o envio.' });
  }
  const smtp = smtpSettings();
  if (!smtp.configured) return res.status(503).json({ verified: false, error: 'Nenhum provedor de e-mail configurado.' });
  try {
    await createSmtpTransport(smtp).verify();
    res.json({ verified: true, provider: 'smtp', message: 'Conexão e autenticação SMTP verificadas.' });
  } catch (error: any) {
    res.status(502).json({ verified: false, error: error?.message || 'Falha na verificação SMTP.' });
  }
});

// 2. Dashboard Analytics & Summary Statistics
app.get('/api/dashboard/stats', async (req, res) => {
  await refreshDatabricksIfDue();
  const grouped = groupOrders(orders);
  const total = grouped.length;
  const pending = grouped.filter(o => o.status === 'Pending' || o.status === 'Processing').length;
  const shipped = grouped.filter(order => {
    const items = order.items?.length ? order.items : [order];
    return order.status !== 'Delivered' && order.status !== 'Cancelled' && items.some(item => Boolean(item.invoice?.trim()));
  }).length;
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
      last_sync: (lastDatabricksPullIso || new Date().toISOString()).replace('T', ' ').substring(0, 19) + ' UTC',
      table: databricksSyncEnabled() ? databricksTableName().replace(/`/g, '') : (activeDataSource === 'postgres' ? 'public.orders + public.order_items + public.logistics' : 'synthetic demo dataset'),
      total_records: total,
      status: lastDatabricksPullError ? 'connected' : 'healthy'
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
app.get('/api/orders', async (req, res) => {
  await refreshDatabricksIfDue();
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

  // Expose one visual order with all its product lines before applying status semantics.
  // "In Transit" is intentionally invoice-driven: an order enters this filter only
  // after at least one active product line has an Invoice and before customer delivery.
  let grouped = groupOrders(filtered);
  if (status && typeof status === 'string' && status !== 'All') {
    const normalizedStatus = status.toLowerCase();
    grouped = grouped.filter(order => {
      if (normalizedStatus === 'shipped') {
        const items = order.items?.length ? order.items : [order];
        return order.status !== 'Delivered' && order.status !== 'Cancelled' && items.some(item => Boolean(item.invoice?.trim()));
      }
      return order.status.toLowerCase() === normalizedStatus;
    });
  }
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
      if (operational === 'at_distribution_center') {
        const activeItems = items.filter(item => item.status !== 'Cancelled');
        const hasEntryCd = activeItems.some(item => Boolean(item.entry_cd_date));
        const hasBilling = activeItems.some(item => Boolean(item.billing_date));
        const hasDelivery = activeItems.some(item => Boolean(item.delivery_client_date));
        return activeItems.length > 0 && hasEntryCd && !hasBilling && !hasDelivery;
      }
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
app.post('/api/databricks/reconcile', async (req, res) => {
  const records = Array.isArray(req.body?.records) ? req.body.records : [];
  if (!records.length) return res.status(400).json({ error: 'Envie ao menos um registro em records.' });

  const updatedGroups = new Set<string>();
  const previousShipmentStatus = new Map<string, ShipmentData['shipment_status']>();
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
      const key = orderGroupKey(order);
      if (!previousShipmentStatus.has(key)) {
        const currentGroup = groupOrders(orders.filter(candidate => orderGroupKey(candidate) === key))[0];
        previousShipmentStatus.set(key, currentGroup?.shipment.shipment_status || order.shipment.shipment_status);
      }
      reconcileLifecycle(order, record);
      updatedGroups.add(key);
    });
  }

  const grouped = groupOrders(orders).filter(order => updatedGroups.has(orderGroupKey(order)));
  if (activeDataSource === 'postgres') {
    try {
      for (const groupedOrder of grouped) {
        await saveOrderStateToPostgres(groupedOrder.items?.length ? groupedOrder.items : [groupedOrder]);
      }
    } catch (error: any) {
      return res.status(500).json({ error: `Não foi possível persistir a reconciliação: ${error?.message || error}` });
    }
  }

  saveCancellationReasons();
  const triggeredAlerts: DeliveryAlert[] = [];
  for (const groupedOrder of grouped) {
    const previous = previousShipmentStatus.get(orderGroupKey(groupedOrder));
    const current = groupedOrder.shipment.shipment_status;
    if (previous && previous !== current) {
      triggeredAlerts.push(await dispatchDeliveryAlert(
        groupedOrder,
        eventTypeForShipmentStatus(current),
      ));
    }
  }

  res.json({ updated: grouped.length, orders: grouped, not_found: notFound, alerts_triggered: triggeredAlerts });
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

app.patch('/api/orders/:id/notes', async (req, res) => {
  const order = findOrderByIdOrPo(req.params.id);
  if (!order) return res.status(404).json({ error: `Order ${req.params.id} not found` });

  const notes = String(req.body?.notes ?? '').trim();
  if (notes.length > 1500) {
    return res.status(400).json({ error: 'A observação deve ter no máximo 1500 caracteres.' });
  }

  const relatedItems = orders.filter(candidate => orderGroupKey(candidate) === orderGroupKey(order));
  const updatedAt = new Date().toISOString();

  if (activeDataSource === 'postgres') {
    try {
      await saveOrderNotesToPostgres(
        order.purchase_order || order.id,
        notes,
        order.account_user,
      );
    } catch (error: any) {
      return res.status(500).json({ error: `Could not save the order note in PostgreSQL: ${error?.message || error}` });
    }
  }

  relatedItems.forEach(item => {
    item.notes = notes || undefined;
    item.updated_at = updatedAt;
  });
  saveOrderNotes();

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
  const groupedOrder = groupOrders(relatedItems)[0];
  await dispatchDeliveryAlert(
    groupedOrder,
    'Cancelled',
    `[MarketOps] Pedido ${groupedOrder.purchase_order || groupedOrder.id} cancelado`,
    `O pedido ${groupedOrder.purchase_order || groupedOrder.id} foi cancelado. Motivo: ${reason}`,
  );
  res.json({ success: true, order: groupedOrder });
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

app.patch('/api/orders/:id/restore-cancellation', async (req, res) => {
  const order = findOrderByIdOrPo(req.params.id);
  if (!order) return res.status(404).json({ error: `Order ${req.params.id} not found` });
  if (order.status !== 'Cancelled') return res.status(400).json({ error: 'Este pedido não está cancelado.' });

  const relatedItems = orders.filter(candidate => orderGroupKey(candidate) === orderGroupKey(order));
  const previousItems = relatedItems.map(item => structuredClone(item));
  const restoredAt = new Date().toISOString();

  relatedItems.forEach((item, index) => {
    item.status = 'Pending';
    item.sts_compra = 'COMPRADO';
    item.status_text = '';
    item.cancellation_reason = undefined;
    item.cancellation_updated_at = undefined;
    reconcileLifecycle(item);
    item.updated_at = restoredAt;
    item.shipment.events.unshift({
      id: `ev-restore-${Date.now()}-${index}`,
      timestamp: restoredAt.replace('T', ' ').substring(0, 19),
      location: 'Admin Portal',
      status: item.shipment.shipment_status,
      description: 'Cancelamento desfeito. O status foi recalculado a partir dos dados logísticos disponíveis.',
    });
  });

  if (activeDataSource === 'postgres') {
    try {
      await restoreCancellationInPostgres(relatedItems, order.account_user);
    } catch (error: any) {
      relatedItems.forEach((item, index) => Object.assign(item, previousItems[index]));
      return res.status(500).json({ error: `Não foi possível desfazer o cancelamento no PostgreSQL: ${error?.message || error}` });
    }
  }

  saveCancellationReasons();
  const groupedOrder = groupOrders(relatedItems)[0];
  res.json({
    success: true,
    message: 'Cancelamento desfeito. Se necessário, confirme novamente a compra no marketplace.',
    order: groupedOrder,
  });
});

// 5. Insert New Order
app.post('/api/orders', async (req, res) => {
  try {
    const {
      date_order,
      customer_name,
      customer_email,
      customer_phone,
      customer_cpf,
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
      customer_email: customer_email?.trim() || demoEmailFor(customer_name.trim()),
      customer_phone: customer_phone?.trim() || DEMO_PHONE,
      customer_cpf: customer_cpf?.trim() || '000.000.000-00',
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

    // Trigger the same customer communication flow used by logistics status changes.
    await dispatchDeliveryAlert(newOrder, 'Order Placed');

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
    const { orders: batchItems, default_status, sync_databricks = true } = req.body;

    if (!batchItems || !Array.isArray(batchItems) || batchItems.length === 0) {
      return res.status(400).json({ error: 'No orders provided in batch payload' });
    }
    if (batchItems.length > 1000) {
      return res.status(413).json({ error: 'O lote excede o limite de 1.000 linhas. Divida a planilha em arquivos menores.' });
    }

    const createdOrders: Order[] = [];
    const skippedDuplicates: Array<{ purchase_order: string; sku: string; reason: string }> = [];
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
        skippedDuplicates.push({
          purchase_order: incomingPo,
          sku: incomingSku,
          reason: alreadyExists ? 'Pedido e SKU já cadastrados no MarketOps.' : 'Pedido e SKU repetidos neste mesmo lote.',
        });
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

      const demoCustomerName = item.customer_name || (item.customer_order_id ? `Cliente Marketplace #${item.customer_order_id}` : `Cliente Marketplace Manaus`);
      const newOrder: Order = {
        id: orderId,
        date_order: dateOrder,
        customer_name: demoCustomerName,
        customer_email: item.customer_email?.trim() || demoEmailFor(demoCustomerName),
        customer_phone: item.customer_phone?.trim() || DEMO_PHONE,
        customer_cpf: item.customer_cpf?.trim() || item.cpf_cliente?.trim() || '000.000.000-00',
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
        billing_date: item.billing_date || item.data_faturamento || undefined,
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

      if (sync_databricks) reconcileLifecycle(newOrder, item);
      createdOrders.push(newOrder);
    }

    if (activeDataSource === 'postgres') {
      await insertOrdersToPostgres(createdOrders);
    }
    orders.unshift(...createdOrders);

    res.status(201).json({
      success: true,
      message: `Successfully ingested ${createdOrders.length} orders into MarketOps and reconciled the available logistics fields.`,
      count: createdOrders.length,
      skipped_count: skippedDuplicates.length,
      skipped_duplicates: skippedDuplicates,
      orders: createdOrders
    });
  } catch (err: any) {
    console.error('Error processing batch orders:', err);
    res.status(500).json({ error: err.message || 'Failed to process batch orders' });
  }
});

// 6. Demo logistics reconciliation endpoint for a specific order.
// Kept under the historical /sync-databricks path for UI compatibility; this is not a live Databricks connection.
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
      location: nextShipmentStatus === 'Delivered' ? item.shipment.destination : 'MarketOps Logistics Reconciliation',
      status: nextShipmentStatus,
      description: `Demo reconciliation updated the shipment status to [${nextShipmentStatus}]. Carrier checkpoint: ${item.shipment.carrier || 'not informed'}.`
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

  const groupedOrder = groupOrders(relatedItems)[0];
  const alert = currentStatus !== nextShipmentStatus
    ? await dispatchDeliveryAlert(
        groupedOrder,
        eventTypeForShipmentStatus(nextShipmentStatus),
      )
    : null;

  res.json({
    success: true,
    message: `Sincronização de demonstração concluída. Status: ${nextShipmentStatus}.`,
    order: groupedOrder,
    alert_triggered: alert
  });
});

// 7. Demo bulk logistics reconciliation. Production Databricks events use /api/databricks/reconcile.
app.post('/api/databricks/sync-all', async (req, res) => {
  if (databricksSyncEnabled()) {
    await refreshDatabricksIfDue(true);
    if (lastDatabricksPullError) return res.status(502).json({ error: lastDatabricksPullError });
    return res.json({
      success: true,
      message: 'Sincronização real com o Databricks concluída.',
      sync_time: lastDatabricksPullIso,
      integration_mode: 'databricks-sql-warehouse',
      lakehouse_table: databricksTableName().replace(/`/g, ''),
      orders: groupOrders(orders).length,
    });
  }
  const nowUtc = new Date().toISOString().replace('T', ' ').substring(0, 19) + ' UTC';
  const previousOrders = orders.map(order => structuredClone(order));
  const previousStatuses = new Map(
    groupOrders(orders).map(order => [orderGroupKey(order), order.shipment.shipment_status] as const)
  );

  orders.forEach(order => {
    // Demo/local mode: recalculate lifecycle from the logistics fields already stored.
    // Production Databricks changes should arrive through /api/databricks/reconcile.
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

  const triggeredAlerts: DeliveryAlert[] = [];
  for (const groupedOrder of groupOrders(orders)) {
    const previous = previousStatuses.get(orderGroupKey(groupedOrder));
    const current = groupedOrder.shipment.shipment_status;
    if (previous && previous !== current) {
      triggeredAlerts.push(await dispatchDeliveryAlert(
        groupedOrder,
        eventTypeForShipmentStatus(current),
      ));
    }
  }

  res.json({
    success: true,
    message: `${groupOrders(orders).length} pedidos foram reconciliados com base nos dados logísticos disponíveis.`,
    sync_time: nowUtc,
    integration_mode: 'demo-reconciliation',
    lakehouse_table: 'gold_logistics.marketplace_shipments',
    alerts_triggered: triggeredAlerts.length,
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
  const groupedOrder = groupOrders(relatedItems)[0];
  if (status && status !== oldStatus) {
    await dispatchDeliveryAlert(
      groupedOrder,
      eventTypeForShipmentStatus(groupedOrder.shipment.shipment_status),
    );
  }
  res.json({ success: true, order: groupedOrder });
});

// 9. Delivery Alerts log
app.get('/api/alerts', (req, res) => {
  res.json({
    total: alerts.length,
    alerts
  });
});

const statusChangeDate = (order: Order) => {
  if (order.shipment.shipment_status === 'Cancelled') return order.cancellation_updated_at?.slice(0, 10) || order.updated_at.slice(0, 10);
  if (order.shipment.shipment_status === 'Delivered') return order.delivery_client_date?.slice(0, 10) || order.updated_at.slice(0, 10);
  if (order.billing_date) return order.billing_date.slice(0, 10);
  if (order.entry_cd_date) return order.entry_cd_date.slice(0, 10);
  if (order.eta) return order.eta.slice(0, 10);
  if (order.etd) return order.etd.slice(0, 10);
  if (order.marketplace_purchase_confirmed_at) return order.marketplace_purchase_confirmed_at.slice(0, 10);
  return order.date_order.slice(0, 10) || order.updated_at.slice(0, 10);
};

const dailyStatusChanges = (date: string) => groupOrders(orders)
  .filter(order => statusChangeDate(order) === date)
  .map(order => ({
    order,
    date,
    status: order.shipment.shipment_status,
    event_type: eventTypeForShipmentStatus(order.shipment.shipment_status),
    recipient: order.customer_email,
  }));

app.get('/api/alerts/changes', (req, res) => {
  const date = String(req.query.date || '').trim();
  if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) return res.status(400).json({ error: 'Informe a data em YYYY-MM-DD.' });
  const changes = dailyStatusChanges(date);
  res.json({ date, count: changes.length, changes: changes.map(change => ({
    order_id: change.order.purchase_order || change.order.id,
    customer_name: change.order.customer_name,
    status: statusLabelPt(change.status),
    recipient_email: change.recipient,
  })) });
});

app.get('/api/alerts/change-dates', (_req, res) => {
  const counts = new Map<string, number>();
  groupOrders(orders).forEach(order => {
    const date = statusChangeDate(order);
    if (date) counts.set(date, (counts.get(date) || 0) + 1);
  });
  res.json({ dates: [...counts.entries()].sort(([a], [b]) => b.localeCompare(a)).map(([date, count]) => ({ date, count })) });
});

app.post('/api/alerts/send-daily', async (req, res) => {
  const date = String(req.body?.date || '').trim();
  if (!/^\d{4}-\d{2}-\d{2}$/.test(date)) return res.status(400).json({ error: 'Informe a data em YYYY-MM-DD.' });
  const isLocalGuestTest = process.env.NODE_ENV !== 'production' && !req.header('authorization');
  const localRecipient = process.env.DEMO_ALERT_RECIPIENT?.trim() || process.env.SMTP_USER?.trim();
  if (isLocalGuestTest && !localRecipient) return res.status(503).json({ error: 'Configure SMTP_USER ou DEMO_ALERT_RECIPIENT para o teste local.' });

  const changes = dailyStatusChanges(date);
  const results: DeliveryAlert[] = [];
  let skipped = 0;
  for (const change of changes) {
    const dispatchKey = `${date}:${orderGroupKey(change.order)}:${change.status}`;
    if (dailyAlertDispatchKeys.has(dispatchKey)) { skipped += 1; continue; }
    const alert = await dispatchDeliveryAlert(
      change.order,
      change.event_type,
      undefined,
      undefined,
      isLocalGuestTest ? localRecipient : undefined,
    );
    results.push(alert);
    if (alert.status === 'sent' || alert.status === 'simulated' || alert.status === 'delivered') dailyAlertDispatchKeys.add(dispatchKey);
  }
  res.json({
    success: results.every(alert => alert.status !== 'failed'),
    date,
    found: changes.length,
    sent: results.filter(alert => alert.status === 'sent').length,
    simulated: results.filter(alert => alert.status === 'simulated').length,
    failed: results.filter(alert => alert.status === 'failed').length,
    skipped,
    recipients: [...new Set(results.map(alert => alert.recipient_email).filter(Boolean))],
    alerts: results,
  });
});

// 10. Send / Test Custom Automated Alert
app.post('/api/alerts/test', async (req, res) => {
  const { order_id, event_type, recipient_email, message } = req.body;
  const targetOrder = findOrderByIdOrPo(String(order_id || ''));
  if (!targetOrder) return res.status(404).json({ error: `Order ${order_id || ''} not found` });
  if (recipient_email && !emailPattern.test(String(recipient_email).trim())) {
    return res.status(400).json({ error: 'Informe um e-mail de teste válido.' });
  }
  const remoteAddress = req.socket.remoteAddress || '';
  const isLocalGuestTest = process.env.NODE_ENV !== 'production'
    && (remoteAddress === '127.0.0.1' || remoteAddress === '::1' || remoteAddress === '::ffff:127.0.0.1')
    && !req.header('authorization');
  if (isLocalGuestTest) {
    const allowedRecipients = [process.env.SMTP_USER, process.env.DEMO_ALERT_RECIPIENT]
      .map(value => value?.trim().toLowerCase())
      .filter(Boolean);
    const requestedRecipient = String(recipient_email || '').trim().toLowerCase();
    if (!requestedRecipient || !allowedRecipients.includes(requestedRecipient)) {
      return res.status(403).json({ error: 'No teste visitante local, use somente SMTP_USER ou DEMO_ALERT_RECIPIENT.' });
    }
  }

  const event = (event_type || 'Out for Delivery') as DeliveryAlert['event_type'];
  const alert = await dispatchDeliveryAlert(
    targetOrder,
    event,
    `[TESTE] [MarketOps] ${eventTypeLabelPt(event)} • Pedido ${targetOrder.purchase_order || targetOrder.id}`,
    message || `Olá, ${targetOrder.customer_name}. Este é um teste: o pedido ${targetOrder.purchase_order || targetOrder.id} foi atualizado para ${eventTypeLabelPt(event)}.`,
    recipient_email,
  );

  res.json({
    success: alert.status !== 'failed',
    message: alert.status === 'sent' ? 'E-mail de teste enviado.' : 'Alerta de teste registrado no histórico.',
    alert
  });
});

// 11. Send the monitoring report through the configured corporate SMTP server.
app.post('/api/reports/email', async (req, res) => {
  try {
    const { to, cc, subject, message, language, sender_email, sender_name } = req.body || {};
    const isEnglish = language === 'en';
    const label = (pt: string, en: string) => isEnglish ? en : pt;
    const toList = String(to || '').split(/[;,]/).map(value => value.trim()).filter(Boolean);
    const invalidTo = toList.find(email => !emailPattern.test(email));
    if (!toList.length || invalidTo) {
      return res.status(400).json({ error: label('Informe um e-mail de destinatário válido.', 'Enter a valid recipient email address.') });
    }

    const smtp = smtpSettings();
    if (!smtp.configured) {
      return res.status(503).json({
        error: label(
          'O SMTP não está configurado neste ambiente. Em produção (Render), adicione SMTP_HOST, SMTP_PORT, SMTP_SECURE, SMTP_USER, SMTP_PASSWORD e SMTP_FROM em Environment.',
          'SMTP is not configured in this environment. In production (Render), add SMTP_HOST, SMTP_PORT, SMTP_SECURE, SMTP_USER, SMTP_PASSWORD and SMTP_FROM under Environment.'
        )
      });
    }
    const configuredSender = smtp.from?.match(/<([^>]+)>/)?.[1] || smtp.from || smtp.user || '';
    const allowedSenders = [...new Set([smtp.user, configuredSender, ...(process.env.SMTP_ALLOWED_FROM_ADDRESSES || '').split(/[;,]/)]
      .map(value => value?.trim().toLowerCase()).filter(Boolean))];
    const requestedSender = String(sender_email || configuredSender).trim().toLowerCase();
    if (!emailPattern.test(requestedSender) || !allowedSenders.includes(requestedSender)) {
      return res.status(400).json({ error: label('O remetente deve ser a conta SMTP ou um alias autorizado.', 'Sender must be the SMTP account or an authorized alias.') });
    }
    const safeSenderName = String(sender_name || 'MarketOps').trim().replace(/[\r\n"]/g, '').slice(0, 80) || 'MarketOps';
    const fromHeader = `${safeSenderName} <${requestedSender}>`;

    const grouped = groupOrders(orders);
    const headersPt = [
      'Data da compra', 'SKU Marketplace', 'Descrição do Material', 'SKU Principal (ASIN)', 'Seller',
      'Origem (País Seller)', 'Ordem de Cliente', 'Ordem de Compra', 'Quantidade',
      'Valor Unitário Seller (USD)', 'Valor Total Seller (USD)', 'Status do Pedido', 'Cliente',
      'E-mail', 'Telefone', 'CPF', 'Invoice', 'WR Magaya', 'Compra no Marketplace Confirmada', 'Data da Confirmação da Compra',
      'Número de Rastreio', 'Status da Entrega', 'Previsão de Entrega',
      'Unidade', 'Status Operacional', 'Descrição do Status', 'Limite de Entrega (dias)',
      'Data do Pedido Marketplace', 'ID do Pedido Marketplace', 'Grupo da Conta',
      'Status da Conta', 'Responsável', 'Data WR', 'ETA', 'ETD', 'Data DI', 'Entrada CD',
      'Data de Faturamento', 'Entrega ao Cliente', 'Justificativa do Cancelamento', 'Data da Atualização do Cancelamento'
    ];
    const headersEn = [
      'Purchase Date', 'Marketplace SKU', 'Material Description', 'Primary SKU (ASIN)', 'Seller',
      'Seller Country', 'Customer Order', 'Purchase Order', 'Quantity', 'Seller Unit Cost (USD)',
      'Seller Total Cost (USD)', 'Order Status', 'Customer', 'Email', 'Phone', 'CPF', 'Invoice', 'Warehouse Receipt',
      'Marketplace Purchase Confirmed', 'Purchase Confirmation Date', 'Tracking Number',
      'Shipment Status', 'Estimated Delivery', 'Unit', 'Operational Status', 'Status Description',
      'Delivery Limit (days)', 'Marketplace Order Date', 'Marketplace Order ID', 'Account Group',
      'Account Status', 'Owner', 'WR Date', 'ETA', 'ETD', 'DI Date', 'Distribution Center Entry',
      'Billing Date', 'Customer Delivery', 'Cancellation Reason', 'Cancellation Updated At'
    ];
    const headers = isEnglish ? headersEn : headersPt;
    const rows = orders.map(order => [
      order.date_order, String(order.sku || ''), order.product_name, String(order.asin || ''), order.marketplace,
      order.seller_country || '', String(order.customer_order_id || ''), String(order.purchase_order || order.id),
      order.quantity, order.price_unit, order.seller_usd_total ?? order.total_price, order.status,
      order.customer_name, order.customer_email || '', order.customer_phone || '', order.customer_cpf || '', order.invoice || '', order.magaya_wr || '', order.marketplace_purchase_confirmed ? label('SIM','YES') : label('NÃO','NO'),
      order.marketplace_purchase_confirmed_at || '', String(order.shipment.tracking_number || ''),
      order.shipment.shipment_status, order.shipment.estimated_delivery || '', order.unit_measure || '',
      order.operational_status || '', order.status_text || '', order.delivery_limit_days ?? '',
      order.marketplace_order_date || '', order.marketplace_order_id || '', order.account_group || '',
      order.account_order_status || '', order.account_user || '', order.wr_date || '', order.eta || '',
      order.etd || '', order.di_date || '', order.entry_cd_date || '', order.billing_date || '', order.delivery_client_date || '',
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

    const transporter = createSmtpTransport(smtp);
    const ccList = String(cc || '').split(/[;,]/).map(value => value.trim()).filter(Boolean);
    const invalidCc = ccList.find(email => !emailPattern.test(email));
    if (invalidCc) return res.status(400).json({ error: `E-mail em cópia inválido: ${invalidCc}` });

    const info = await transporter.sendMail({
      from: fromHeader,
      replyTo: requestedSender,
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
      orders = applyDemoContactDefaults(deduplicateOrderLines(databaseOrders));
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

  if (databricksSyncEnabled()) {
    await refreshDatabricksIfDue(true);
    if (lastDatabricksPullError) {
      console.error(`Databricks initial sync unavailable: ${lastDatabricksPullError}`);
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
