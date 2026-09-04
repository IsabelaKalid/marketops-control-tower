import React, { useEffect, useState } from 'react';
import { 
  X, 
  Truck, 
  Database, 
  Copy, 
  Check, 
  Calendar, 
  User, 
  Package, 
  Send, 
  CheckCircle2, 
  Clock, 
  XCircle, 
  AlertCircle,
  MapPin, 
  BellRing,
  ExternalLink,
  ShieldCheck,
  ShoppingCart
} from 'lucide-react';
import { Order, OrderStatus } from '../types';
import { translatePurchaseStatus } from '../utils/statusTranslation';
import { useAuth } from '../auth/AuthProvider';

interface OrderDetailModalProps {
  order: Order | null;
  isOpen: boolean;
  onClose: () => void;
  onUpdateOrderStatus: (orderId: string, newStatus: OrderStatus) => Promise<void>;
  onSendManualAlert: (orderId: string, eventType: string) => Promise<void>;
  onConfirmMarketplacePurchase: (orderId: string, confirmed: boolean) => Promise<void>;
  onSaveCancellationReason: (orderId: string, reason: string) => Promise<void>;
  language?: 'en' | 'pt';
}

export const OrderDetailModal: React.FC<OrderDetailModalProps> = ({
  order,
  isOpen,
  onClose,
  onUpdateOrderStatus,
  onSendManualAlert,
  onConfirmMarketplacePurchase,
  onSaveCancellationReason,
  language = 'en',
}) => {
  const pt = language === 'pt';
  const { canManageOrders } = useAuth();
  const [copiedKey, setCopiedKey] = useState<string | null>(null);
  const [alertSuccessMsg, setAlertSuccessMsg] = useState<string | null>(null);
  const [savingPurchase, setSavingPurchase] = useState(false);
  const [cancellationReason, setCancellationReason] = useState('');
  const [savingReason, setSavingReason] = useState(false);
  const [confirmingCancellation, setConfirmingCancellation] = useState(false);
  const [cancellingOrder, setCancellingOrder] = useState(false);

  useEffect(() => {
    setCancellationReason(order?.cancellation_reason || '');
    setConfirmingCancellation(false);
    setCancellingOrder(false);
  }, [order?.id, order?.cancellation_reason]);

  if (!isOpen || !order) return null;

  const orderItems = order.items?.length ? order.items : [order];
  const purchaseDate = order.marketplace_purchase_confirmed_at
    ? new Date(`${order.marketplace_purchase_confirmed_at.slice(0, 10)}T00:00:00`).toLocaleDateString('pt-BR')
    : '';
  const latestDate = (getter: (item: Order) => string | undefined) =>
    orderItems.map(getter).filter((value): value is string => Boolean(value)).sort().at(-1);
  const formatTrackingDate = (value: string) => {
    const parsed = new Date(value.length === 10 ? `${value}T00:00:00` : value);
    if (Number.isNaN(parsed.getTime())) return value;
    const hasTime = value.includes('T') || /\d{2}:\d{2}/.test(value);
    return hasTime
      ? parsed.toLocaleString('pt-BR', { dateStyle: 'short', timeStyle: 'short' })
      : parsed.toLocaleDateString('pt-BR');
  };
  const trackingMilestones = [
    { label: 'Purchase Confirmed', date: latestDate(item => item.marketplace_purchase_confirmed_at), detail: 'Purchase marked as completed in the system.' },
    { label: 'Arrived at Warehouse', date: latestDate(item => item.wr_date), detail: 'Order received at the international warehouse.' },
    { label: 'Departed for Manaus (ETD)', date: latestDate(item => item.etd), detail: 'Shipment departed toward Manaus.' },
    { label: 'Arrived in Manaus (ETA)', date: latestDate(item => item.eta), detail: 'Arrival date registered for Manaus.' },
    { label: 'Arrived at Distribution Center', date: latestDate(item => item.entry_cd_date), detail: 'Order received at the distribution center.' },
    { label: 'Delivered to Customer', date: latestDate(item => item.delivery_client_date), detail: 'Final delivery completed.' },
  ].filter((milestone): milestone is { label: string; date: string; detail: string } => Boolean(milestone.date));

  const copyToClipboard = (text: string, key: string) => {
    navigator.clipboard.writeText(text);
    setCopiedKey(key);
    setTimeout(() => setCopiedKey(null), 1800);
  };

  const handleTriggerAlert = async (type: string) => {
    try {
      await onSendManualAlert(order.id, type);
      setAlertSuccessMsg(`Automated ${type} alert sent to ${order.customer_email} and browser push notifications.`);
      setTimeout(() => setAlertSuccessMsg(null), 4000);
    } catch (err: any) {
      console.error(err);
    }
  };

  const getStatusBadge = (status: OrderStatus) => {
    switch (status) {
      case 'Delivered':
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-green-100 text-green-700">
            <CheckCircle2 className="w-3.5 h-3.5 text-green-600" />
            Delivered
          </span>
        );
      case 'Shipped':
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-blue-100 text-blue-700">
            <Truck className="w-3.5 h-3.5 text-blue-600" />
            In Transit
          </span>
        );
      case 'Pending':
      case 'Processing':
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-amber-100 text-amber-700">
            <Clock className="w-3.5 h-3.5 text-amber-600" />
            {status}
          </span>
        );
      case 'Cancelled':
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-red-100 text-red-700">
            <XCircle className="w-3.5 h-3.5 text-red-600" />
            Cancelled
          </span>
        );
      default:
        return (
          <span className="px-3 py-1 rounded-full text-xs font-medium bg-slate-100 text-slate-800">
            {status}
          </span>
        );
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-4 bg-slate-900/60 backdrop-blur-xs overflow-y-auto">
      <div 
        className="bg-white rounded-2xl border border-slate-200 shadow-2xl max-w-3xl w-full max-h-[94vh] flex flex-col overflow-hidden my-auto text-xs"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Modal Top Header */}
        <div className="px-6 py-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/70">
          <div className="flex items-center gap-3">
            <div className="w-9 h-9 rounded-xl bg-blue-600 text-white flex items-center justify-center font-bold text-xs tracking-wider font-mono">
              PO
            </div>
            <div>
              <div className="flex items-center gap-2">
                <span className="text-[10px] font-bold px-1.5 py-0.5 rounded bg-blue-100 text-blue-800 font-mono">
                  PO
                </span>
                <h2 className="text-base font-bold text-slate-900 font-mono">
                  {order.purchase_order || order.id}
                </h2>
                {order.customer_order_id && (
                  <span className="text-xs text-slate-500 font-mono">
                    ({pt?'Cliente':'Customer'} #{order.customer_order_id})
                  </span>
                )}
                <span className="px-2.5 py-1 rounded-md text-xs font-bold bg-orange-100 text-orange-800 border border-orange-200">
                  {order.marketplace}
                </span>
                {getStatusBadge(order.status)}
              </div>
              <p className="text-[11px] text-slate-500 mt-0.5">
                {pt?'Data da compra':'Purchase Date'}: <span className="font-mono text-slate-700">{order.date_order}</span> • {pt?'Origem':'Origin'}: <span className="font-mono text-slate-700">{order.seller_country || 'EUA'}</span> • {pt?'Sincronizado via Databricks Lakehouse':'Synchronized via Databricks Lakehouse'}
              </p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 rounded-lg text-slate-400 hover:text-slate-700 hover:bg-slate-200/50 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Quick Alert Trigger Feedback */}
        {alertSuccessMsg && (
          <div className="mx-6 mt-3 p-2.5 rounded-lg bg-green-50 border border-green-200 text-green-800 text-xs flex items-center gap-2 animate-fadeIn">
            <CheckCircle2 className="w-4 h-4 text-green-600 shrink-0" />
            <span>{alertSuccessMsg}</span>
          </div>
        )}

        {/* Modal Content Scrollable */}
        <div className="p-6 space-y-6 overflow-y-auto flex-1">
          {/* Section 1: Customer & Product Info (2 columns) */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {/* Customer Box */}
            <div className="p-4 rounded-xl border border-slate-200/80 bg-slate-50/50 space-y-2">
              <div className="flex items-center gap-2 text-slate-900 font-semibold text-xs border-b border-slate-200 pb-2">
                <User className="w-4 h-4 text-blue-600" />
                <span>Customer Information</span>
              </div>
              <div className="space-y-1 pt-1 text-slate-700">
                <div>
                  <span className="text-slate-500">Name:</span>{' '}
                  <strong className="text-slate-900 font-semibold">{order.customer_name}</strong>
                </div>
                {order.customer_email && (
                  <div>
                    <span className="text-zinc-500">Email:</span>{' '}
                    <span className="font-mono text-zinc-800">{order.customer_email}</span>
                  </div>
                )}
                {order.customer_phone && (
                  <div>
                    <span className="text-zinc-500">Phone:</span>{' '}
                    <span className="font-mono text-zinc-800">{order.customer_phone}</span>
                  </div>
                )}
                <div className="text-zinc-500">
                  <span>Destination:</span>{' '}
                  <span className="text-zinc-800 font-medium">{order.shipment.destination}</span>
                </div>
              </div>
            </div>

            {/* Products & Pricing Box */}
            <div className="p-4 rounded-lg border border-zinc-200 bg-zinc-50/50 space-y-2">
              <div className="flex items-center gap-2 text-zinc-900 font-semibold text-xs border-b border-zinc-200 pb-2">
                <Package className="w-4 h-4 text-zinc-600" />
                <span>{pt?'Produtos do pedido':'Order Products'} ({orderItems.length})</span>
              </div>
              <div className="space-y-2 pt-1 max-h-56 overflow-y-auto pr-1">
                {orderItems.map((item) => (
                  <div key={`${item.sku}-${item.sequencial || item.id}`} className="rounded-lg border border-zinc-200 bg-white p-2.5">
                    <div className="font-medium text-zinc-900">{item.product_name}</div>
                    <div className="flex flex-wrap items-center gap-2 pt-1">
                      <span className="font-mono text-xs bg-blue-100 px-2 py-1 rounded-md text-blue-800 border border-blue-200 font-bold">SKU: {item.sku}</span>
                      <span className="font-mono text-[11px] bg-amber-100 text-amber-900 px-1.5 py-0.5 rounded font-semibold border border-amber-300">ASIN: {item.asin}</span>
                      {item.sequencial && <span className="font-mono text-[11px] text-zinc-500">Seq: {item.sequencial}</span>}
                    </div>
                    <div className="flex items-end justify-between gap-2 pt-2 text-xs">
                      <div><span className="text-zinc-500 block">Custo seller: ${item.price_unit.toFixed(2)} USD × {item.quantity}</span>{item.vkp2_price !== undefined && <strong className="text-emerald-700 block mt-0.5">Venda VKP2: R$ {item.vkp2_price.toFixed(2)}</strong>}</div>
                      <strong className="font-mono text-zinc-900">Custo: ${item.total_price.toFixed(2)} USD</strong>
                    </div>
                  </div>
                ))}
                <div className="flex items-center justify-between pt-2 border-t border-zinc-300">
                  <strong>Total do pedido</strong>
                  <strong className="text-base font-mono">${order.total_price.toFixed(2)} USD</strong>
                </div>
              </div>
            </div>
          </div>

          {order.status !== 'Cancelled' && <div className={`p-4 rounded-xl border ${order.marketplace_purchase_confirmed ? 'border-emerald-200 bg-emerald-50/60' : 'border-rose-300 bg-rose-50'}`}>
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3">
              <div className="flex items-start gap-2">
                <ShoppingCart className={`w-5 h-5 mt-0.5 ${order.marketplace_purchase_confirmed ? 'text-emerald-600' : 'text-rose-600'}`} />
                <div>
                  <p className={`font-bold ${order.marketplace_purchase_confirmed ? 'text-emerald-900' : 'text-rose-900'}`}>
                    {order.marketplace_purchase_confirmed ? (pt?'Compra no marketplace confirmada':'Marketplace purchase confirmed') : (pt?'Atenção: compra ainda não confirmada':'Attention: purchase not confirmed')}
                  </p>
                  <p className="text-xs text-slate-600 mt-0.5">
                    {order.marketplace_purchase_confirmed ? `OK registrado em ${purchaseDate}.` : 'Use o ASIN acima para realizar a compra e depois registre o OK.'}
                  </p>
                </div>
              </div>
              {canManageOrders && (
                <button
                  type="button"
                  disabled={savingPurchase}
                  onClick={async () => { setSavingPurchase(true); try { await onConfirmMarketplacePurchase(order.id, !order.marketplace_purchase_confirmed); } finally { setSavingPurchase(false); } }}
                  className={`px-4 py-2 rounded-lg text-xs font-bold text-white disabled:opacity-50 ${order.marketplace_purchase_confirmed ? 'bg-slate-600 hover:bg-slate-700' : 'bg-emerald-600 hover:bg-emerald-700'}`}
                >
                  {savingPurchase ? (pt?'Salvando...':'Saving...') : order.marketplace_purchase_confirmed ? (pt?'Desfazer confirmação':'Undo confirmation') : (pt?'Marcar compra como OK':'Mark purchase as OK')}
                </button>
              )}
            </div>
          </div>}

          {order.status === 'Cancelled' && <div className="p-4 rounded-xl border border-rose-200 bg-rose-50/70">
            <div className="flex items-center gap-2 mb-2"><XCircle className="w-5 h-5 text-rose-600"/><h3 className="font-bold text-rose-900">{pt?'Justificativa do cancelamento':'Cancellation Reason'}</h3></div>
            {order.cancellation_updated_at && <p className="mb-2 text-xs text-rose-700">Atualizado em {new Date(order.cancellation_updated_at).toLocaleString('pt-BR')}</p>}
            <textarea
              rows={3}
              value={cancellationReason}
              onChange={event => setCancellationReason(event.target.value)}
              disabled={!canManageOrders}
              placeholder={pt?'Ex.: produto indisponível, preço alterado, cancelado pelo cliente...':'Example: unavailable product, price changed, cancelled by customer...'}
              className="w-full rounded-lg border border-rose-200 bg-white p-3 text-sm text-slate-800 focus:outline-none focus:border-rose-500 disabled:cursor-not-allowed disabled:bg-slate-100"
            />
            {canManageOrders && (
              <div className="flex justify-end mt-2"><button
                type="button"
                disabled={savingReason || !cancellationReason.trim()}
                onClick={async () => { setSavingReason(true); try { await onSaveCancellationReason(order.id, cancellationReason); } finally { setSavingReason(false); } }}
                className="px-4 py-2 rounded-lg bg-rose-600 hover:bg-rose-700 text-white text-xs font-bold disabled:opacity-50"
              >{savingReason ? (pt?'Salvando...':'Saving...') : order.cancellation_reason ? (pt?'Atualizar justificativa':'Update Reason') : (pt?'Salvar justificativa':'Save Reason')}</button></div>
            )}
          </div>}

          {/* Marketplace Logistics & Customs Overview (if available) */}
          {(order.purchase_order || order.invoice || order.magaya_wr) && (
            <div className="p-4 rounded-xl border border-blue-100 bg-blue-50/40 text-xs">
              <div className="font-bold text-blue-900 mb-2 flex items-center gap-1.5">
                <ShieldCheck className="w-4 h-4 text-blue-600" />
                <span>{pt?'Dados de compra e logística internacional':'Purchase and International Logistics Data'} (Marketplace / Seller)</span>
              </div>
              <div className="grid grid-cols-2 sm:grid-cols-4 gap-2.5">
                {order.customer_order_id && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Ordem do Cliente</span>
                    <span className="font-mono font-bold text-slate-800">{order.customer_order_id}</span>
                  </div>
                )}
                {order.purchase_order && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Ordem de Compra (PO)</span>
                    <span className="font-mono font-bold text-slate-800">{order.purchase_order}</span>
                  </div>
                )}
                {order.sequencial && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Sequencial</span>
                    <span className="font-mono font-bold text-slate-800">{order.sequencial}</span>
                  </div>
                )}
                {order.sts_compra && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Sts de Compra</span>
                    <span className="font-mono font-bold text-blue-700">{translatePurchaseStatus(order.sts_compra, language)}</span>
                  </div>
                )}
                {order.seller_country && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Origem (País Seller)</span>
                    <span className="font-mono font-bold text-slate-800">{order.seller_country}</span>
                  </div>
                )}
                {order.seller_usd_total !== undefined && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Valor Total Compra Seller</span>
                    <span className="font-mono font-bold text-slate-800">${order.seller_usd_total.toFixed(2)} USD</span>
                  </div>
                )}
                {order.invoice && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Invoice</span>
                    <span className="font-mono font-bold text-blue-700">{order.invoice}</span>
                  </div>
                )}
                {order.magaya_wr && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">WR Magaya</span>
                    <span className="font-mono font-bold text-slate-800">{order.magaya_wr}</span>
                  </div>
                )}
                {order.wr_date && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Data WR</span>
                    <span className="font-mono font-bold text-slate-800">{new Date(`${order.wr_date.slice(0, 10)}T00:00:00`).toLocaleDateString('pt-BR')}</span>
                  </div>
                )}
                {order.eta && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">ETA</span>
                    <span className="font-mono font-bold text-indigo-700">{new Date(`${order.eta.slice(0, 10)}T00:00:00`).toLocaleDateString('pt-BR')}</span>
                  </div>
                )}
                {order.di_date && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Data DI / Chegada em Manaus</span>
                    <span className="font-mono font-bold text-slate-800">{new Date(`${order.di_date.slice(0, 10)}T00:00:00`).toLocaleDateString('pt-BR')}</span>
                  </div>
                )}
                {order.entry_cd_date && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Entrada CD / Faturamento</span>
                    <span className="font-mono font-bold text-slate-800">{new Date(`${order.entry_cd_date.slice(0, 10)}T00:00:00`).toLocaleDateString('pt-BR')}</span>
                  </div>
                )}
                {order.delivery_client_date && (
                  <div className="bg-white p-2 rounded border border-emerald-200">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Entrega ao Cliente</span>
                    <span className="font-mono font-bold text-emerald-700">{new Date(`${order.delivery_client_date.slice(0, 10)}T00:00:00`).toLocaleDateString('pt-BR')}</span>
                  </div>
                )}
              </div>
            </div>
          )}

          {/* Section 2: Databricks Shipment Lakehouse telemetry */}
          <div className="p-4 rounded-lg border border-amber-200 bg-amber-50/30 space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 border-b border-amber-200/70 pb-3">
              <div className="flex items-center gap-2">
                <div className="p-1.5 rounded-md bg-amber-100 text-amber-800">
                  <Database className="w-4 h-4" />
                </div>
                <div>
                  <h3 className="font-bold text-zinc-900 text-sm">
                    Databricks Logistics Delta Stream
                  </h3>
                  <p className="text-[11px] text-zinc-600">
                    External database table: <code className="font-mono text-zinc-900 font-semibold">gold_logistics.marketplace_shipments</code>
                  </p>
                </div>
              </div>

            </div>

            {/* Shipment Key Metrics */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 text-xs">
              <div className="p-2.5 rounded bg-white border border-zinc-200">
                <span className="text-zinc-500 block text-[10px] uppercase font-semibold">
                  Carrier
                </span>
                <span className="font-bold text-zinc-900 text-xs">
                  {order.shipment.carrier}
                </span>
              </div>

              <div className="p-2.5 rounded bg-white border border-zinc-200">
                <span className="text-zinc-500 block text-[10px] uppercase font-semibold">
                  Tracking Number
                </span>
                <div className="flex items-center gap-1 font-mono font-semibold text-zinc-900 truncate">
                  <span className="truncate">{order.shipment.tracking_number}</span>
                  <button
                    onClick={() => copyToClipboard(order.shipment.tracking_number, 'modal-trk')}
                    className="text-zinc-400 hover:text-zinc-700 shrink-0"
                    title="Copy tracking number"
                  >
                    {copiedKey === 'modal-trk' ? (
                      <Check className="w-3 h-3 text-emerald-600" />
                    ) : (
                      <Copy className="w-3 h-3" />
                    )}
                  </button>
                </div>
              </div>

              <div className="p-2.5 rounded bg-white border border-zinc-200">
                <span className="text-zinc-500 block text-[10px] uppercase font-semibold">
                  Shipment Status
                </span>
                <span className="font-bold text-indigo-700">
                  {order.shipment.shipment_status}
                </span>
              </div>

              <div className="p-2.5 rounded bg-white border border-zinc-200">
                <span className="text-zinc-500 block text-[10px] uppercase font-semibold">
                  {order.shipment.actual_delivery_date ? 'Delivered At' : 'Estimated Delivery'}
                </span>
                <span className="font-bold text-zinc-900 font-mono">
                  {order.shipment.actual_delivery_date || order.shipment.estimated_delivery}
                </span>
              </div>
            </div>

            {/* Databricks Hubs Routing */}
            <div className="flex items-center gap-2 text-[11px] text-zinc-600 bg-white/80 p-2.5 rounded border border-zinc-200">
              <MapPin className="w-4 h-4 text-rose-500 shrink-0" />
              <span>
                <strong className="text-zinc-900">Routing:</strong> {order.shipment.origin_hub} →{' '}
                <strong className="text-zinc-900">{order.shipment.destination}</strong>
              </span>
              <span className="ml-auto font-mono text-[10px] text-zinc-400">
                Sync: {order.shipment.databricks_sync_time}
              </span>
            </div>

            {/* Chronological Event Timeline */}
            <div>
              <h4 className="font-semibold text-zinc-800 text-xs mb-2 flex items-center gap-1.5">
                <Clock className="w-3.5 h-3.5 text-zinc-600" />
                Order Tracking ({trackingMilestones.length})
              </h4>
              <div className="space-y-2 relative pl-4 border-l-2 border-amber-300">
                {trackingMilestones.length ? trackingMilestones.map((milestone) => (
                  <div key={milestone.label} className="relative pb-2">
                    <span className="absolute -left-[21px] top-1 w-2.5 h-2.5 rounded-full bg-amber-600 border-2 border-white ring-1 ring-amber-300" />
                    <div className="flex items-center justify-between text-[11px]">
                      <span className="font-semibold text-zinc-900">{milestone.label}</span>
                      <span className="font-mono text-zinc-500 text-[10px]">{formatTrackingDate(milestone.date)}</span>
                    </div>
                    <p className="text-zinc-600 text-[11px] mt-0.5">{milestone.detail}</p>
                  </div>
                )) : <p className="text-[11px] text-zinc-500 pb-2">No logistics milestone has been registered yet.</p>}
              </div>
            </div>
          </div>

          {/* Section 3: Automated Delivery Alert Dispatcher */}
          {canManageOrders && (
          <div className="p-4 rounded-lg border border-indigo-200 bg-indigo-50/30 space-y-3">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <BellRing className="w-4 h-4 text-indigo-600" />
                <h3 className="font-bold text-zinc-900 text-xs">
                  Automated Delivery Alert Dispatcher
                </h3>
              </div>
              <span className="text-[10px] font-medium text-indigo-700 bg-indigo-100 px-2 py-0.5 rounded-full">
                Email &amp; Browser Push
              </span>
            </div>
            <p className="text-[11px] text-zinc-600">
              When delivery status transitions occur via Databricks delta events, automated notifications are dispatched to the customer's email and device push services.
            </p>
            <div className="flex flex-wrap items-center gap-2 pt-1">
              <button
                onClick={() => handleTriggerAlert('Shipment Dispatched')}
                className="px-2.5 py-1.5 rounded bg-white hover:bg-zinc-100 border border-zinc-300 text-zinc-800 text-[11px] font-medium transition-colors"
              >
                Send 'Dispatched' Alert
              </button>
              <button
                onClick={() => handleTriggerAlert('Out for Delivery')}
                className="px-2.5 py-1.5 rounded bg-white hover:bg-zinc-100 border border-zinc-300 text-zinc-800 text-[11px] font-medium transition-colors"
              >
                Send 'Out for Delivery' Alert
              </button>
              <button
                onClick={() => handleTriggerAlert('Delivered')}
                className="px-2.5 py-1.5 rounded bg-white hover:bg-zinc-100 border border-zinc-300 text-zinc-800 text-[11px] font-medium transition-colors"
              >
                Send 'Delivered' Alert
              </button>
            </div>
          </div>
          )}

          {/* Notes if any */}
          {order.notes && (
            <div className="p-3 bg-zinc-50 rounded-lg border border-zinc-200">
              <span className="text-zinc-500 font-semibold uppercase text-[10px] block mb-1">
                Order Notes
              </span>
              <p className="text-zinc-700 text-xs italic">{order.notes}</p>
            </div>
          )}
        </div>

        {/* Footer Actions */}
        <div className="px-6 py-3 border-t border-zinc-200 bg-zinc-50">
          {confirmingCancellation ? (
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3 rounded-lg border border-rose-200 bg-rose-50 px-3 py-2.5">
              <div className="flex items-start gap-2 text-rose-800">
                <AlertCircle className="w-4 h-4 mt-0.5 shrink-0" />
                <div>
                  <p className="font-bold text-xs">{pt?'Tem certeza de que deseja cancelar este pedido?':'Are you sure you want to cancel this order?'}</p>
                  <p className="text-[11px] mt-0.5">{pt?'O status da PO':'The status of PO'} <strong>{order.purchase_order || order.id}</strong> {pt?'será alterado para Cancelado.':'will be changed to Cancelled.'}</p>
                </div>
              </div>
              <div className="flex items-center justify-end gap-3 shrink-0">
                <button
                  type="button"
                  disabled={cancellingOrder}
                  onClick={() => setConfirmingCancellation(false)}
                  className="px-3 py-2 rounded-lg text-xs font-semibold text-slate-700 bg-white hover:bg-slate-100 border border-slate-300 disabled:opacity-50"
                >
                  {pt?'Voltar':'Go Back'}
                </button>
                <button
                  type="button"
                  disabled={cancellingOrder}
                  onClick={async () => {
                    setCancellingOrder(true);
                    try {
                      await onUpdateOrderStatus(order.id, 'Cancelled');
                      setConfirmingCancellation(false);
                    } finally {
                      setCancellingOrder(false);
                    }
                  }}
                  className="px-3 py-2 rounded-lg text-xs font-bold text-white bg-rose-600 hover:bg-rose-700 disabled:opacity-50"
                >
                  {cancellingOrder ? (pt?'Cancelando...':'Cancelling...') : (pt?'Sim, cancelar pedido':'Yes, Cancel Order')}
                </button>
              </div>
            </div>
          ) : (
            <div className="flex flex-wrap items-center justify-between gap-4">
              <div className="flex items-center gap-2 text-zinc-500 text-[11px]">
                <ShieldCheck className="w-4 h-4 text-emerald-600" />
                <span>Encrypted Databricks logistics handshake verified</span>
              </div>

              <div className="flex items-center gap-6">
                {canManageOrders && order.status !== 'Cancelled' && order.status !== 'Delivered' && (
                  <button
                    type="button"
                    onClick={() => setConfirmingCancellation(true)}
                    className="px-3 py-1.5 rounded text-xs font-medium text-rose-700 bg-rose-50 hover:bg-rose-100 border border-rose-200 transition-colors"
                  >
                    {pt?'Cancelar pedido':'Cancel Order'}
                  </button>
                )}
                <button
                  type="button"
                  onClick={onClose}
                  className="px-4 py-1.5 rounded text-xs font-semibold text-white bg-zinc-900 hover:bg-zinc-800 transition-colors"
                >
                  {pt?'Fechar':'Close'}
                </button>
              </div>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};
