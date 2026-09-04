export type OrderStatus = 'Pending' | 'Processing' | 'Shipped' | 'Delivered' | 'Cancelled';

export type ShipmentStatus = 'Not Shipped' | 'Preparing' | 'In Transit' | 'Out for Delivery' | 'Delivered' | 'Returned' | 'Cancelled';

export interface ShipmentEvent {
  id: string;
  timestamp: string;
  location: string;
  status: ShipmentStatus;
  description: string;
}

export interface ShipmentData {
  is_shipped: boolean;
  carrier: string;
  tracking_number: string;
  estimated_delivery: string;
  actual_delivery_date: string | null;
  shipment_status: ShipmentStatus;
  databricks_sync_time: string;
  destination: string;
  origin_hub: string;
  events: ShipmentEvent[];
}

export interface Order {
  id: string; // Order ID, e.g., ORD-2026-1049
  date_order: string; // YYYY-MM-DD
  customer_name: string;
  customer_email: string;
  customer_phone?: string;
  sku: string;
  product_name: string; // description or name of product
  asin: string; // Amazon Standard Identification Number
  price_unit: number;
  quantity: number;
  total_price: number;
  status: OrderStatus;
  marketplace: string; // e.g. Amazon, Mercado Livre, Shopify, eBay
  notes?: string;
  shipment: ShipmentData;
  created_at: string;
  updated_at: string;
  // Marketplace / Seller CSV logistics fields:
  purchase_order?: string; // Ordem de Compra
  customer_order_id?: string; // Ordem de Cliente
  vkp2_price?: number; // Preço de venda VKP2 (R$)
  seller_usd_total?: number; // Valor Total Compra Seller (USD)
  seller_country?: string; // Origem (País Seller)
  invoice?: string; // Invoice
  magaya_wr?: string; // WR Magaya
  destination_hub?: string; // CD Marketplace - Manaus, AM
  delivery_client_date?: string; // Data Entrega Cliente Marketplace
  entry_cd_date?: string; // Entrada no CD / faturamento para entrega ao cliente
  sequencial?: string; // Sequencial
  sts_compra?: string; // Sts de Compra (ENTREGUE, CANCELADO, COMPRADO)
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
  // All unique product lines that belong to the same customer order / PO.
  // The first item is also used as the order summary in list views.
  items?: Order[];
}

export interface DeliveryAlert {
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

export interface DashboardStats {
  total_orders: number;
  total_revenue: number;
  total_sales_brl: number;
  pending_orders: number;
  shipped_orders: number;
  delivered_orders: number;
  cancelled_orders: number;
  databricks_sync_status: {
    last_sync: string;
    table: string;
    total_records: number;
    status: 'connected' | 'syncing' | 'healthy';
  };
}

export interface OrderFilters {
  search: string;
  status: string;
  date_from: string;
  date_to: string;
  marketplace: string;
  operational: string;
  sort_by: string;
  sort_direction: string;
}
