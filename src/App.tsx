import React, { useState, useEffect, useCallback, useMemo } from 'react';
import { Sidebar } from './components/Sidebar';
import { Header } from './components/Header';
import { DashboardStats } from './components/DashboardStats';
import { OrderFiltersBar } from './components/OrderFiltersBar';
import { OrderTable } from './components/OrderTable';
import { LiveTrackingCard } from './components/LiveTrackingCard';
import { NewOrderModal } from './components/NewOrderModal';
import { OrderDetailModal } from './components/OrderDetailModal';
import { AlertsDrawer } from './components/AlertsDrawer';
import { DatabricksInfoModal } from './components/DatabricksInfoModal';
import { BatchOrderImportModal } from './components/BatchOrderImportModal';
import { ReportsDashboard } from './components/ReportsDashboard';
import { apiFetch } from './lib/api';
import { useAuth } from './auth/AuthProvider';

import { 
  Order, 
  DashboardStats as StatsType, 
  OrderFilters, 
  DeliveryAlert, 
  OrderStatus 
} from './types';
import { CheckCircle2, X } from 'lucide-react';
import * as XLSX from 'xlsx';

export default function App() {
  const { isGuest, signOut } = useAuth();
  const [language, setLanguage] = useState<'en' | 'pt'>(() => localStorage.getItem('marketops-ui-language') === 'pt' ? 'pt' : 'en');
  const [darkMode, setDarkMode] = useState(() => localStorage.getItem('marketops-theme') === 'dark');
  // Navigation & UI States
  const [activeTab, setActiveTab] = useState('orders');
  const [isMobileMenuOpen, setIsMobileMenuOpen] = useState(false);

  // Data States
  const [orders, setOrders] = useState<Order[]>([]);
  const [stats, setStats] = useState<StatsType | null>(null);
  const [alerts, setAlerts] = useState<DeliveryAlert[]>([]);
  const [availableSellers, setAvailableSellers] = useState<string[]>([]);
  const [isLoading, setIsLoading] = useState<boolean>(true);

  // Filter States
  const [filters, setFilters] = useState<OrderFilters>(() => {
    const defaults: OrderFilters = {
      search: '', status: 'All', date_from: '', date_to: '', marketplace: 'All', operational: 'All',
      sort_by: 'updated_at', sort_direction: 'desc',
    };
    try {
      const saved = localStorage.getItem('marketops-order-filters');
      if (!saved) return defaults;
      const restored = { ...defaults, ...JSON.parse(saved) };
      if (restored.operational === 'purchased_no_wr_10') restored.operational = 'missing_wr';
      if (restored.operational === 'eta_invoice_to_cd') restored.operational = 'in_transit_invoiced';
      if (restored.operational === 'purchase_no_eta_invoice_20') restored.operational = 'All';
      return restored;
    } catch {
      return defaults;
    }
  });

  useEffect(() => {
    localStorage.setItem('marketops-order-filters', JSON.stringify(filters));
  }, [filters]);
  useEffect(() => {
    localStorage.setItem('marketops-ui-language', language);
    document.documentElement.lang = language === 'pt' ? 'pt-BR' : 'en';
  }, [language]);
  useEffect(() => {
    localStorage.setItem('marketops-theme', darkMode ? 'dark' : 'light');
    document.documentElement.classList.toggle('dark', darkMode);
  }, [darkMode]);

  // Modal / Drawer States
  const [isNewOrderModalOpen, setIsNewOrderModalOpen] = useState(false);
  const [isBatchImportModalOpen, setIsBatchImportModalOpen] = useState(false);
  const [isAlertsDrawerOpen, setIsAlertsDrawerOpen] = useState(false);
  const [isDatabricksModalOpen, setIsDatabricksModalOpen] = useState(false);
  const [selectedOrder, setSelectedOrder] = useState<Order | null>(null);
  const [selectedTrackingOrderId, setSelectedTrackingOrderId] = useState<string | null>(null);
  const [orderUpdateSignal, setOrderUpdateSignal] = useState(0);

  // Syncing Indicators
  const [isSyncingAll, setIsSyncingAll] = useState(false);
  const [syncingOrderId, setSyncingOrderId] = useState<string | null>(null);

  // Live Toast Notification
  const [toastMessage, setToastMessage] = useState<{
    id: string;
    title: string;
    description: string;
  } | null>(null);

  const showToast = (title: string, description: string) => {
    setToastMessage({ id: String(Date.now()), title, description });
    setTimeout(() => {
      setToastMessage((prev) => (prev?.title === title ? null : prev));
    }, 4500);
  };

  // Fetch Orders
  const fetchOrders = useCallback(async () => {
    try {
      const params = new URLSearchParams();
      if (filters.search) params.append('search', filters.search);
      if (filters.status && filters.status !== 'All') params.append('status', filters.status);
      if (filters.marketplace && filters.marketplace !== 'All') params.append('marketplace', filters.marketplace);
      if (filters.date_from) params.append('date_from', filters.date_from);
      if (filters.date_to) params.append('date_to', filters.date_to);
      if (filters.operational && filters.operational !== 'All') params.append('operational', filters.operational);
      params.append('sort_by', filters.sort_by || 'updated_at');
      params.append('sort_direction', filters.sort_direction || 'desc');

      const res = await apiFetch(`/api/orders?${params.toString()}`);
      if (res.ok) {
        const data = await res.json();
        setOrders(data.orders || []);
      }
    } catch (err) {
      console.error('Error fetching orders:', err);
    }
  }, [filters]);

  // Fetch Dashboard Stats
  const fetchStats = useCallback(async () => {
    try {
      const res = await apiFetch('/api/dashboard/stats');
      if (res.ok) {
        const data = await res.json();
        setStats(data);
      }
    } catch (err) {
      console.error('Error fetching stats:', err);
    }
  }, []);

  // Fetch Alerts
  const fetchAlerts = useCallback(async () => {
    try {
      const res = await apiFetch('/api/alerts');
      if (res.ok) {
        const data = await res.json();
        setAlerts(data.alerts || []);
      }
    } catch (err) {
      console.error('Error fetching alerts:', err);
    }
  }, []);

  const fetchSellers = useCallback(async () => {
    try {
      const res = await apiFetch('/api/sellers');
      if (res.ok) setAvailableSellers((await res.json()).sellers || []);
    } catch (err) {
      console.error('Error fetching sellers:', err);
    }
  }, []);

  // Initial Load
  useEffect(() => {
    const init = async () => {
      setIsLoading(true);
      await Promise.all([fetchOrders(), fetchStats(), fetchAlerts(), fetchSellers()]);
      setIsLoading(false);
    };
    init();
  }, [fetchOrders, fetchStats, fetchAlerts, fetchSellers]);

  // Active tracking order selected for the LiveTrackingCard
  const activeTrackingOrder = useMemo(() => {
    if (selectedTrackingOrderId) {
      const match = orders.find((o) => o.id === selectedTrackingOrderId);
      if (match) return match;
    }
    return orders[0] || null;
  }, [selectedTrackingOrderId, orders]);

  // Most recent order with an invoice among the orders visible in the current filters.
  // ETA is intentionally not used because it can be a future estimate.
  const latestInvoicedOrder = useMemo(() => {
    const getItems = (order: Order) => order.items?.length ? order.items : [order];
    const getReferenceTime = (order: Order) => {
      const timestamps = getItems(order)
        .filter((item) => Boolean(item.invoice?.trim()))
        .map((item) => item.wr_date || item.marketplace_order_date || item.date_order || item.updated_at)
        .map((value) => new Date(value).getTime())
        .filter((value) => Number.isFinite(value));
      return timestamps.length ? Math.max(...timestamps) : 0;
    };

    return orders
      .filter((order) => order.status === 'Shipped' && getItems(order).some((item) => Boolean(item.invoice?.trim())))
      .slice()
      .sort((a, b) => getReferenceTime(b) - getReferenceTime(a))[0] || null;
  }, [orders]);

  const filteredStats = useMemo<StatsType | null>(() => {
    if (!stats) return null;
    const lines = orders.flatMap(order => order.items?.length ? order.items : [order]);
    const validLines = lines.filter(item => item.status !== 'Cancelled');
    return {
      ...stats,
      total_orders: orders.length,
      pending_orders: orders.filter(order => order.status === 'Pending' || order.status === 'Processing').length,
      shipped_orders: orders.filter(order => order.status === 'Shipped').length,
      delivered_orders: orders.filter(order => order.status === 'Delivered').length,
      cancelled_orders: orders.filter(order => order.status === 'Cancelled').length,
      total_revenue: validLines.reduce((sum, item) => sum + item.total_price, 0),
      total_sales_brl: validLines.reduce((sum, item) => sum + (item.vkp2_price ?? 0) * item.quantity, 0),
    };
  }, [orders, stats]);

  const handleExportOrders = () => {
    const headers = [
      'Data da compra', 'SKU Marketplace', 'Descrição do Material', 'SKU Principal (ASIN)',
      'Seller', 'Origem (País Seller)', 'Ordem de Cliente', 'Ordem de Compra',
      'Quantidade', 'Preço de venda VKP2 (R$)',
      'Valor Total Compra Seller (USD)', 'Status do Pedido', 'Cliente', 'Email',
      'Telefone', 'Invoice', 'WR Magaya', 'Transportadora', 'Número de Rastreio',
      'Compra no Marketplace Confirmada', 'Data da Confirmação da Compra',
      'Status da Entrega', 'Previsão de Entrega', 'Data Real da Entrega', 'Data WR', 'ETA', 'Data DI',
      'Entrada CD', 'Entrega ao Cliente', 'Origem Logística', 'Destino', 'Última Sincronização Databricks',
      'Justificativa do Cancelamento', 'Data da Atualização do Cancelamento', 'Eventos da Entrega'
    ];

    const lines = orders.flatMap((group) => {
      const items = group.items?.length ? group.items : [group];
      return items.map((item) => [
        String(item.date_order || ''), String(item.sku || ''), item.product_name, String(item.asin || ''), item.marketplace,
        item.seller_country || '', String(item.customer_order_id || ''), String(item.purchase_order || item.id),
        item.quantity, item.vkp2_price ?? '',
        item.seller_usd_total ?? item.total_price, item.status, item.customer_name,
        item.customer_email, item.customer_phone || '', item.invoice || '', item.magaya_wr || '',
        item.shipment.carrier, String(item.shipment.tracking_number || ''),
        item.marketplace_purchase_confirmed ? 'SIM' : 'NÃO', item.marketplace_purchase_confirmed_at || '', item.shipment.shipment_status,
        String(item.shipment.estimated_delivery || ''), String(item.shipment.actual_delivery_date || ''), item.wr_date || '', item.eta || '', item.di_date || '',
        item.entry_cd_date || '', item.delivery_client_date || '', item.shipment.origin_hub, item.shipment.destination,
        item.shipment.databricks_sync_time, item.cancellation_reason || '', item.cancellation_updated_at || '',
        item.shipment.events.map((event) => `${event.timestamp} | ${event.status} | ${event.location} | ${event.description}`).join(' / ')
      ]);
    });

    const worksheet = XLSX.utils.aoa_to_sheet([headers, ...lines]);
    worksheet['!cols'] = headers.map((header, index) => ({
      wch: index === 2 ? 42 : index === headers.length - 1 ? 90 : Math.max(14, Math.min(36, header.length + 2))
    }));

    // Keep identifiers and dates as text; keep quantities and monetary fields numeric.
    const textColumns = [0, 1, 3, 6, 7, 18, 20, 22, 23, 24, 25, 26, 27, 28, 33];
    for (let row = 1; row <= lines.length; row += 1) {
      textColumns.forEach((column) => {
        const address = XLSX.utils.encode_cell({ r: row, c: column });
        if (worksheet[address]) worksheet[address].t = 's';
      });
      [9, 10].forEach((column) => {
        const address = XLSX.utils.encode_cell({ r: row, c: column });
        if (worksheet[address] && typeof worksheet[address].v === 'number') worksheet[address].z = '#,##0.00';
      });
    }

    worksheet['!autofilter'] = { ref: worksheet['!ref'] || 'A1:Z1' };
    const workbook = XLSX.utils.book_new();
    XLSX.utils.book_append_sheet(workbook, worksheet, 'Pedidos');
    const suffix = filters.search ? `-filtro-${filters.search.replace(/[^a-zA-Z0-9_-]/g, '-')}` : '-todos';
    XLSX.writeFile(workbook, `pedidos-marketplace${suffix}-${new Date().toISOString().slice(0, 10)}.xlsx`);
  };

  // Handle New Order Created
  const handleOrderCreated = (newOrder: Order) => {
    setOrders((prev) => [newOrder, ...prev]);
    setSelectedTrackingOrderId(newOrder.id);
    fetchStats();
    fetchAlerts();
    fetchSellers();
    showToast(
      'Order Registered & Databricks Queued',
      `Order ${newOrder.id} for ${newOrder.customer_name} placed. Tracking is awaiting seller dispatch.`
    );
  };

  const handleMarketplacePurchaseConfirmation = async (orderId: string, confirmed: boolean) => {
    const previousListOrder = orders.find(order => order.id === orderId);
    const previousSelectedOrder = selectedOrder?.id === orderId ? selectedOrder : null;
    const changedAt = new Date().toISOString();
    const makeOptimisticOrder = (order: Order): Order => ({
      ...order,
      marketplace_purchase_confirmed: confirmed,
      marketplace_purchase_confirmed_at: confirmed ? changedAt : undefined,
      updated_at: changedAt,
      items: order.items?.map(item => ({
        ...item,
        marketplace_purchase_confirmed: confirmed,
        marketplace_purchase_confirmed_at: confirmed ? changedAt : undefined,
        updated_at: changedAt,
      })),
    });

    // Update the interface immediately. The API persists the change in the background.
    setOrders(prev => {
      const updated = prev.map(order => order.id === orderId ? makeOptimisticOrder(order) : order);
      if (filters.sort_by === 'updated_at' && filters.sort_direction !== 'asc') {
        return [...updated].sort((a, b) => (b.updated_at || '').localeCompare(a.updated_at || ''));
      }
      return updated;
    });
    setSelectedOrder(prev => prev?.id === orderId ? makeOptimisticOrder(prev) : prev);

    try {
      const res = await apiFetch(`/api/orders/${encodeURIComponent(orderId)}/purchase-confirmation`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ confirmed }),
      });
      const data = await res.json();
      if (!res.ok) throw new Error(data.error || 'Não foi possível registrar a confirmação da compra.');

      // Reconcile only the changed order; do not reload or reset the current page/filter state.
      setOrders(prev => prev.map(order => order.id === orderId ? data.order : order));
      setSelectedOrder(prev => prev?.id === orderId ? data.order : prev);
      setOrderUpdateSignal(value => value + 1);
      void fetchStats();
      showToast(
        confirmed ? 'Compra confirmada' : 'Confirmação removida',
        confirmed ? `A compra da PO ${data.order.purchase_order || data.order.id} foi registrada.` : `A PO ${data.order.purchase_order || data.order.id} voltou para a lista de atenção.`
      );
    } catch (error) {
      // Restore the exact previous state if persistence fails.
      if (previousListOrder) {
        setOrders(prev => prev.map(order => order.id === orderId ? previousListOrder : order));
      }
      if (previousSelectedOrder) setSelectedOrder(previousSelectedOrder);
      const message = error instanceof Error ? error.message : 'Erro desconhecido.';
      showToast('Falha ao salvar', `A confirmação não foi gravada. ${message}`);
      throw error;
    }
  };

  const runOrderRequestsInBatches = async <T,>(ids: string[], request: (id: string) => Promise<T>) => {
    const results: T[] = [];
    for (let index = 0; index < ids.length; index += 8) {
      results.push(...await Promise.all(ids.slice(index, index + 8).map(request)));
    }
    return results;
  };

  const handleBulkPurchaseConfirmation = async (orderIds: string[]) => {
    const updatedOrders = await runOrderRequestsInBatches(orderIds, async orderId => {
      const response = await apiFetch(`/api/orders/${encodeURIComponent(orderId)}/purchase-confirmation`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ confirmed: true }),
      });
      const data = await response.json();
      if (!response.ok) throw new Error(data.error || `Could not confirm order ${orderId}.`);
      return data.order as Order;
    });
    const updatedById = new Map(updatedOrders.map(order => [order.id, order]));
    setOrders(previous => previous.map(order => updatedById.get(order.id) || order));
    void fetchStats();
    showToast(
      language === 'pt' ? 'Compras confirmadas' : 'Purchases Confirmed',
      language === 'pt' ? `${updatedOrders.length} pedidos foram confirmados.` : `${updatedOrders.length} orders were confirmed.`,
    );
  };

  const handleBulkCancellation = async (orderIds: string[], reason: string) => {
    const updatedOrders = await runOrderRequestsInBatches(orderIds, async orderId => {
      const response = await apiFetch(`/api/orders/${encodeURIComponent(orderId)}/cancel`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ reason }),
      });
      const data = await response.json();
      if (!response.ok) throw new Error(data.error || `Could not cancel order ${orderId}.`);
      return data.order as Order;
    });
    const updatedById = new Map(updatedOrders.map(order => [order.id, order]));
    setOrders(previous => previous.map(order => updatedById.get(order.id) || order));
    void fetchStats();
    void fetchAlerts();
    showToast(
      language === 'pt' ? 'Pedidos cancelados' : 'Orders Cancelled',
      language === 'pt' ? `${updatedOrders.length} pedidos foram cancelados.` : `${updatedOrders.length} orders were cancelled.`,
    );
  };

  const handleCancelOrder = async (orderId: string, reason: string) => {
    try {
      const response = await apiFetch(`/api/orders/${encodeURIComponent(orderId)}/cancel`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ reason }),
      });
      const data = await response.json().catch(() => ({}));
      if (!response.ok) throw new Error(data.error || 'Não foi possível cancelar o pedido.');

      setOrders(previous => previous.map(order => order.id === orderId ? data.order : order));
      setSelectedOrder(previous => previous?.id === orderId ? data.order : previous);
      setOrderUpdateSignal(value => value + 1);
      void fetchStats();
      void fetchAlerts();
      showToast('Pedido cancelado', `A PO ${data.order.purchase_order || data.order.id} foi cancelada. A justificativa pode ser preenchida nos detalhes do pedido.`);
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Não foi possível cancelar o pedido.';
      showToast('Falha ao cancelar', message);
      throw error;
    }
  };

  const handleSaveCancellationReason = async (orderId: string, reason: string) => {
    try {
      const res = await apiFetch(`/api/orders/${encodeURIComponent(orderId)}/cancellation-reason`, {
        method: 'PATCH', headers: { 'Content-Type': 'application/json' }, body: JSON.stringify({ reason }),
      });
      const data = await res.json().catch(() => ({}));
      if (!res.ok) throw new Error(data.error || 'Não foi possível salvar a justificativa.');
      setOrders(prev => prev.map(order => order.id === orderId ? data.order : order));
      setSelectedOrder(data.order);
      await fetchOrders();
      setOrderUpdateSignal(value => value + 1);
      showToast('Justificativa salva', `O motivo do cancelamento da PO ${data.order.purchase_order || data.order.id} foi registrado.`);
    } catch (error) {
      const message = error instanceof Error ? error.message : 'Não foi possível salvar a justificativa.';
      showToast('Falha ao salvar justificativa', message);
      throw error;
    }
  };

  // Handle Batch Orders Ingestion (Multiple Orders at Once)
  const handleBatchOrdersImported = async (importedOrders: Order[]) => {
    // Reload from the API so product lines sharing the same customer order / PO
    // are immediately rendered as one grouped order.
    await fetchOrders();
    if (importedOrders.length > 0) {
      setSelectedTrackingOrderId(importedOrders[0].id);
      setOrderUpdateSignal(value => value + 1);
    }
    fetchStats();
    fetchAlerts();
    fetchSellers();
    showToast(
      'Batch Orders Sent Successfully!',
      `${importedOrders.length} orders sent and processed into MarketOps & Databricks Lakehouse.`
    );
  };

  // Trigger Databricks Sync for a specific order
  const handleSyncOrderDatabricks = async (orderId: string, targetStatus?: string) => {
    setSyncingOrderId(orderId);
    try {
      const res = await apiFetch(`/api/orders/${orderId}/sync-databricks`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ target_status: targetStatus }),
      });

      if (!res.ok) throw new Error('Databricks sync failed');
      const data = await res.json();

      // Update in orders list
      setOrders((prev) =>
        prev.map((o) => (o.id === orderId ? data.order : o))
      );
      await fetchOrders();
      setOrderUpdateSignal(value => value + 1);

      // If this order is open in modal, update it
      if (selectedOrder && selectedOrder.id === orderId) {
        setSelectedOrder(data.order);
      }

      // Refresh stats & alerts
      fetchStats();
      fetchAlerts();

      showToast(
        `Databricks Checkpoint: ${data.order.shipment.shipment_status}`,
        `Tracking ${data.order.shipment.tracking_number} updated. Automated email & push alert dispatched!`
      );

      // Trigger browser notification if permitted
      if (typeof window !== 'undefined' && 'Notification' in window && Notification.permission === 'granted') {
        new Notification(`Order ${data.order.id}: ${data.order.shipment.shipment_status}`, {
          body: `Tracking ${data.order.shipment.tracking_number} via ${data.order.shipment.carrier}. Est. arrival: ${data.order.shipment.estimated_delivery}`,
        });
      }
    } catch (err: any) {
      console.error('Sync error:', err);
    } finally {
      setSyncingOrderId(null);
    }
  };

  // Trigger Bulk Databricks Sync
  const handleSyncAll = async () => {
    setIsSyncingAll(true);
    try {
      const res = await apiFetch('/api/databricks/sync-all', { method: 'POST' });
      if (!res.ok) throw new Error('Failed to bulk sync Databricks');
      const data = await res.json();

      await Promise.all([fetchOrders(), fetchStats(), fetchAlerts()]);
      showToast('Databricks Lakehouse Synchronized', data.message);
    } catch (err: any) {
      console.error('Bulk sync error:', err);
    } finally {
      setIsSyncingAll(false);
    }
  };

  // Update order status manually
  const handleUpdateOrderStatus = async (orderId: string, newStatus: OrderStatus) => {
    try {
      const res = await apiFetch(`/api/orders/${encodeURIComponent(orderId)}`, {
        method: 'PATCH',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ status: newStatus }),
      });

      const data = await res.json().catch(() => ({}));
      if (!res.ok) throw new Error(data.error || 'Failed to update status');

      setOrders((prev) =>
        prev.map((o) => (o.id === orderId ? data.order : o))
      );
      await fetchOrders();
      setOrderUpdateSignal(value => value + 1);
      if (selectedOrder && selectedOrder.id === orderId) {
        setSelectedOrder(data.order);
      }
      fetchStats();
      fetchAlerts();
      showToast(`Order Status Changed to ${newStatus}`, `Order ${orderId} updated.`);
    } catch (err: any) {
      console.error('Update status error:', err);
      showToast(
        language === 'pt' ? 'Falha ao atualizar pedido' : 'Order update failed',
        err?.message || (language === 'pt' ? 'A alteração não foi salva.' : 'The change was not saved.'),
      );
      throw err;
    }
  };

  // Trigger manual test delivery alert
  const handleTriggerTestAlert = async (orderId: string, eventType: string, customMsg?: string) => {
    const res = await apiFetch('/api/alerts/test', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ order_id: orderId, event_type: eventType, message: customMsg }),
    });
    if (!res.ok) throw new Error('Failed to dispatch alert test');
    fetchAlerts();
  };

  return (
    <div className="flex h-screen w-full bg-slate-50 overflow-hidden font-sans text-slate-800 antialiased">
      {/* Sleek Dark Left Sidebar */}
      <Sidebar
        currentTab={activeTab}
        activeTab={activeTab}
        onSelectTab={(tab) => {
          setActiveTab(tab);
          if (tab === 'shipments' && activeTrackingOrder) {
            setSelectedOrder(activeTrackingOrder);
          }
        }}
        onOpenNewOrder={() => setIsNewOrderModalOpen(true)}
        onOpenBatchImport={() => setIsBatchImportModalOpen(true)}
        onOpenDatabricksModal={() => setIsDatabricksModalOpen(true)}
        unreadAlertsCount={alerts.length}
        onOpenAlerts={() => setIsAlertsDrawerOpen(true)}
        mobileOpen={isMobileMenuOpen}
        isMobileOpen={isMobileMenuOpen}
        onCloseMobile={() => setIsMobileMenuOpen(false)}
        activeStatusFilter={filters.status}
        onSelectStatusFilter={(status) => setFilters((prev) => ({ ...prev, status }))}
        language={language}
      />

      {/* Main App Content Area */}
      <div className="flex-1 flex flex-col min-w-0 overflow-hidden">
        {/* Sleek Top Header */}
        <Header
          searchQuery={filters.search}
          onSearchChange={(query) => setFilters((prev) => ({ ...prev, search: query }))}
          onOpenNewOrder={() => setIsNewOrderModalOpen(true)}
          onOpenBatchImport={() => setIsBatchImportModalOpen(true)}
          onOpenAlerts={() => setIsAlertsDrawerOpen(true)}
          onOpenDatabricksModal={() => setIsDatabricksModalOpen(true)}
          onSyncAll={handleSyncAll}
          isSyncing={isSyncingAll}
          unreadAlertsCount={alerts.length}
          onToggleMobileMenu={() => setIsMobileMenuOpen((prev) => !prev)}
          language={language}
          onToggleLanguage={() => setLanguage(value => value === 'en' ? 'pt' : 'en')}
          darkMode={darkMode}
          onToggleDarkMode={() => setDarkMode(value => !value)}
        />

        {/* Scrollable Dashboard Body */}
        <main className="p-4 sm:p-6 lg:p-8 flex-1 flex flex-col gap-6 overflow-y-auto">
          {isGuest && (
  <div className="flex flex-col gap-3 rounded-xl border border-amber-300 bg-amber-50 px-4 py-3 text-amber-950 sm:flex-row sm:items-center sm:justify-between">
    <div>
      <p className="text-sm font-bold">
        Read-only demonstration
      </p>
      <p className="text-xs text-amber-800">
        You can explore the fictional data, but operational changes are disabled.
      </p>
    </div>

    <button
      type="button"
      onClick={() => void signOut()}
      className="rounded-lg border border-amber-400 bg-white px-3 py-2 text-xs font-bold text-amber-900 hover:bg-amber-100"
    >
      Exit demo
    </button>
  </div>
)}
          
          {activeTab === 'dashboard' ? (
            <ReportsDashboard orders={orders} stats={filteredStats} />
          ) : (
            <>
          {/* Top KPI Metric Cards & Lakehouse Status */}
          <DashboardStats
            stats={filteredStats}
            activeStatusFilter={filters.status}
            onSelectStatus={(st) => setFilters((prev) => ({ ...prev, status: st }))}
            onOpenDatabricksModal={() => setIsDatabricksModalOpen(true)}
            language={language}
          />

          {/* Filtering & Search Bar */}
          <OrderFiltersBar
            filters={filters}
            onChangeFilters={(f) => setFilters((prev) => ({ ...prev, ...f }))}
            onResetFilters={() =>
              setFilters({
                search: '',
                status: 'All',
                date_from: '',
                date_to: '',
                marketplace: 'All',
                operational: 'All',
                sort_by: 'updated_at',
                sort_direction: 'desc',
              })
            }
            totalFiltered={orders.length}
            totalOrders={stats?.total_orders || orders.length}
            availableSellers={availableSellers}
            onExport={handleExportOrders}
            language={language}
          />

          {/* Split Section: Live Order Flow & Live Tracking */}
          <div className="flex flex-col xl:flex-row gap-6 items-start">
            {/* Main Order Flow Table */}
            <div className="flex-1 min-w-0 w-full">
              <OrderTable
                orders={orders}
                language={language}
                onBulkConfirmPurchase={handleBulkPurchaseConfirmation}
                onBulkCancel={handleBulkCancellation}
                onSelectOrder={(order) => {
                  setSelectedTrackingOrderId(order.id);
                  setSelectedOrder(order);
                }}
                selectedOrderId={activeTrackingOrder?.id}
                resetToFirstSignal={orderUpdateSignal}
              />
            </div>

            {/* Right Live Tracking Card */}
            <div className="w-full xl:w-88 2xl:w-96 shrink-0">
              <LiveTrackingCard
                order={latestInvoicedOrder}
                language={language}
                onViewFullOrder={(order) => setSelectedOrder(order)}
              />
            </div>
          </div>
            </>
          )}
        </main>
      </div>

      {/* Modals & Drawers */}
      <NewOrderModal
        isOpen={isNewOrderModalOpen}
        onClose={() => setIsNewOrderModalOpen(false)}
        onOrderCreated={handleOrderCreated}
        onSwitchToBatch={() => setIsBatchImportModalOpen(true)}
      />

      <BatchOrderImportModal
        isOpen={isBatchImportModalOpen}
        onClose={() => setIsBatchImportModalOpen(false)}
        onOrdersImported={handleBatchOrdersImported}
      />

      <OrderDetailModal
        order={selectedOrder}
        isOpen={Boolean(selectedOrder)}
        onClose={() => setSelectedOrder(null)}
        onUpdateOrderStatus={handleUpdateOrderStatus}
        onCancelOrder={handleCancelOrder}
        onSendManualAlert={handleTriggerTestAlert}
        onConfirmMarketplacePurchase={handleMarketplacePurchaseConfirmation}
        onSaveCancellationReason={handleSaveCancellationReason}
        language={language}
      />

      <AlertsDrawer
        isOpen={isAlertsDrawerOpen}
        onClose={() => setIsAlertsDrawerOpen(false)}
        alerts={alerts}
        orders={orders}
        onTriggerTestAlert={handleTriggerTestAlert}
      />

      <DatabricksInfoModal
        isOpen={isDatabricksModalOpen}
        onClose={() => setIsDatabricksModalOpen(false)}
        onTriggerSyncAll={handleSyncAll}
        isSyncing={isSyncingAll}
      />

      {/* Toast Alert Feedback */}
      {toastMessage && (
        <div 
          id="toast-notification"
          className="fixed bottom-6 right-6 z-50 bg-slate-900 text-white p-4 rounded-2xl shadow-xl border border-slate-800 max-w-sm flex items-start gap-3 transition-all animate-fadeIn"
        >
          <div className="p-1.5 rounded-full bg-green-500/20 text-green-400 mt-0.5 shrink-0">
            <CheckCircle2 className="w-4 h-4" />
          </div>
          <div className="space-y-0.5 text-xs flex-1">
            <h4 className="font-bold text-slate-100">{toastMessage.title}</h4>
            <p className="text-slate-400 leading-relaxed">{toastMessage.description}</p>
          </div>
          <button
            onClick={() => setToastMessage(null)}
            className="text-slate-400 hover:text-white p-1"
          >
            <X className="w-4 h-4" />
          </button>
        </div>
      )}
    </div>
  );
}
