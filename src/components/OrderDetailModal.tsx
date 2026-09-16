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
  onCancelOrder: (orderId: string, reason: string) => Promise<void>;
  onRestoreCancellation: (orderId: string) => Promise<void>;
  onSendManualAlert: (orderId: string, eventType: string) => Promise<void>;
  onConfirmMarketplacePurchase: (orderId: string, confirmed: boolean) => Promise<void>;
  onSaveOrderNotes: (orderId: string, notes: string) => Promise<void>;
  onSaveCancellationReason: (orderId: string, reason: string) => Promise<void>;
  language?: 'en' | 'pt';
}

const orderItemSelectionKey = (item: Order) => `${item.sku}-${item.sequencial || item.id}`;

export const OrderDetailModal: React.FC<OrderDetailModalProps> = ({
  order,
  isOpen,
  onClose,
  onUpdateOrderStatus,
  onCancelOrder,
  onRestoreCancellation,
  onSendManualAlert,
  onConfirmMarketplacePurchase,
  onSaveOrderNotes,
  onSaveCancellationReason,
  language = 'en',
}) => {
  const pt = language === 'pt';
  const { canManageOrders } = useAuth();
  const [copiedKey, setCopiedKey] = useState<string | null>(null);
  const [alertSuccessMsg, setAlertSuccessMsg] = useState<string | null>(null);
  const [savingPurchase, setSavingPurchase] = useState(false);
  const [selectedPurchasedItems, setSelectedPurchasedItems] = useState<Set<string>>(new Set());
  const [orderNotes, setOrderNotes] = useState('');
  const [savingNotes, setSavingNotes] = useState(false);
  const [cancellationReason, setCancellationReason] = useState('');
  const [savingReason, setSavingReason] = useState(false);
  const [confirmingCancellation, setConfirmingCancellation] = useState(false);
  const [cancellingOrder, setCancellingOrder] = useState(false);
  const [restoringCancellation, setRestoringCancellation] = useState(false);
  const [actionError, setActionError] = useState('');

  useEffect(() => {
    setCancellationReason(order?.cancellation_reason === 'Justificativa pendente.' ? '' : order?.cancellation_reason || '');
    setConfirmingCancellation(false);
    setCancellingOrder(false);
    setRestoringCancellation(false);
    setActionError('');
  }, [order?.id, order?.cancellation_reason]);

  useEffect(() => {
    setOrderNotes(order?.notes || '');
    setSavingNotes(false);
  }, [order?.id, order?.notes]);

  useEffect(() => {
    if (!order) {
      setSelectedPurchasedItems(new Set());
      return;
    }
    const items = order.items?.length ? order.items : [order];
    setSelectedPurchasedItems(
      order.marketplace_purchase_confirmed
        ? new Set(items.map(orderItemSelectionKey))
        : new Set(),
    );
  }, [order?.id, order?.marketplace_purchase_confirmed]);

  if (!isOpen || !order) return null;

  const orderItems = order.items?.length ? order.items : [order];
  const requiresItemSelection = orderItems.length > 1 && !order.marketplace_purchase_confirmed;
  const selectedItemCount = orderItems.filter(item => selectedPurchasedItems.has(orderItemSelectionKey(item))).length;
  const allItemsSelected = !requiresItemSelection || selectedItemCount === orderItems.length;
  const totalOrderBrl = orderItems.reduce(
    (total, item) => total + ((item.vkp2_price ?? 0) * item.quantity),
    0,
  );
  const hasBrlValue = orderItems.some((item) => item.vkp2_price !== undefined);
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
    { label: pt ? 'Pedido registrado' : 'Order registered', date: latestDate(item => item.date_order), detail: pt ? 'Data em que o pedido entrou no MarketOps.' : 'Date the order entered MarketOps.' },
    { label: pt ? 'Preparando envio' : 'Preparing shipment', date: latestDate(item => item.marketplace_purchase_confirmed_at), detail: pt ? 'Compra confirmada no sistema.' : 'Purchase confirmed in the system.' },
    { label: pt ? 'Pedido enviado (ETD)' : 'Order sent (ETD)', date: latestDate(item => item.etd), detail: pt ? 'Saída da warehouse com destino a Manaus.' : 'Departure from the warehouse toward Manaus.' },
    { label: pt ? 'Chegou em Manaus (ETA)' : 'Arrived in Manaus (ETA)', date: latestDate(item => item.eta), detail: pt ? 'Chegada registrada em Manaus.' : 'Arrival registered in Manaus.' },
    { label: pt ? 'Chegou ao centro de distribuição' : 'Arrived at distribution center', date: latestDate(item => item.entry_cd_date), detail: pt ? 'Recebido no centro de distribuição da empresa.' : 'Received at the company distribution center.' },
    { label: pt ? 'Saiu para entrega' : 'Out for delivery', date: latestDate(item => item.billing_date), detail: pt ? 'Pedido faturado e liberado para entrega.' : 'Order invoiced and released for delivery.' },
    { label: pt ? 'Entregue' : 'Delivered', date: latestDate(item => item.delivery_client_date), detail: pt ? 'Entrega final ao cliente.' : 'Final delivery to the customer.' },
  ].filter((milestone): milestone is { label: string; date: string; detail: string } => Boolean(milestone.date));

  const shipmentStatusLabel = (status: Order['shipment']['shipment_status']) => {
    if (!pt) return status;
    return ({
      'Not Shipped': 'Ainda não enviado',
      Preparing: 'Preparando',
      'In Transit': 'Em trânsito',
      'At Distribution Center': 'No centro de distribuição',
      'Out for Delivery': 'Saiu para entrega',
      Delivered: 'Entregue',
      Returned: 'Devolvido',
      Cancelled: 'Cancelado',
    } as Record<string, string>)[status] || status;
  };

  const copyToClipboard = (text: string, key: string) => {
    navigator.clipboard.writeText(text);
    setCopiedKey(key);
    setTimeout(() => setCopiedKey(null), 1800);
  };

  const handleTriggerAlert = async (type: string) => {
    try {
      await onSendManualAlert(order.id, type);
      setAlertSuccessMsg(pt ? `Teste de alerta "${type}" processado. Confira o histórico de alertas para ver se foi enviado ou apenas simulado.` : `Alert test "${type}" processed. Check alert history to see whether it was sent or simulated.`);
      setTimeout(() => setAlertSuccessMsg(null), 4000);
    } catch (err: any) {
      console.error(err);
      setAlertSuccessMsg(pt ? `Falha ao enviar e-mail: ${err?.message || 'erro desconhecido'}` : `Email send failed: ${err?.message || 'unknown error'}`);
      setTimeout(() => setAlertSuccessMsg(null), 6000);
    }
  };

  const getStatusBadge = (status: OrderStatus) => {
    switch (status) {
      case 'Delivered':
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-green-100 text-green-700">
            <CheckCircle2 className="w-3.5 h-3.5 text-green-600" />
            {pt ? 'Entregue' : 'Delivered'}
          </span>
        );
      case 'Shipped':
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-blue-100 text-blue-700">
            <Truck className="w-3.5 h-3.5 text-blue-600" />
            {pt ? 'Em trânsito' : 'In Transit'}
          </span>
        );
      case 'Pending':
      case 'Processing':
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-amber-100 text-amber-700">
            <Clock className="w-3.5 h-3.5 text-amber-600" />
            {pt ? (status === 'Processing' ? 'Processando' : 'Pendente') : status}
          </span>
        );
      case 'Cancelled':
        return (
          <span className="inline-flex items-center gap-1.5 px-3 py-1 rounded-full text-xs font-bold bg-red-100 text-red-700">
            <XCircle className="w-3.5 h-3.5 text-red-600" />
            {pt ? 'Cancelado' : 'Cancelled'}
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
        <div className="relative border-b border-blue-200 bg-gradient-to-r from-blue-50 via-indigo-50 to-emerald-50 px-6 py-6">
          <button onClick={onClose} className="absolute right-4 top-4 p-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-white/70 transition-colors" aria-label={pt ? 'Fechar' : 'Close'}>
            <X className="w-5 h-5" />
          </button>
          <div className="flex flex-col gap-4 pr-10 sm:flex-row sm:items-start">
            <div className="w-14 h-14 shrink-0 rounded-2xl bg-gradient-to-br from-blue-600 to-indigo-700 text-white flex items-center justify-center font-black text-sm tracking-wider font-mono shadow-lg shadow-blue-500/20">
              PO
            </div>
            <div className="min-w-0 flex-1">
              <p className="text-[10px] font-bold uppercase tracking-[0.18em] text-blue-700">{pt ? 'Ordem de compra' : 'Purchase order'}</p>
              <div className="mt-1 flex flex-wrap items-center gap-2.5">
                <h2 className="text-2xl font-black tracking-tight text-slate-950 font-mono sm:text-3xl">
                  {order.purchase_order || order.id}
                </h2>
                <span className="px-2.5 py-1 rounded-md text-xs font-bold bg-orange-100 text-orange-800 border border-orange-200">
                  {order.marketplace}
                </span>
                {getStatusBadge(order.status)}
              </div>
              <div className="mt-3 flex flex-wrap gap-x-5 gap-y-2 text-xs text-slate-600">
                {order.customer_order_id && <span><strong className="text-slate-800">{pt ? 'Ordem do cliente' : 'Customer order'}:</strong> <span className="font-mono">{order.customer_order_id}</span></span>}
                <span><strong className="text-slate-800">{pt?'Data da compra':'Purchase date'}:</strong> <span className="font-mono">{order.date_order}</span></span>
                <span><strong className="text-slate-800">{pt?'Origem':'Origin'}:</strong> {order.seller_country || 'EUA'}</span>
                <span><strong className="text-slate-800">{pt?'Fonte':'Source'}:</strong> backend MarketOps</span>
              </div>
            </div>
          </div>
        </div>

        {/* Quick Alert Trigger Feedback */}
        {alertSuccessMsg && (
          <div className="mx-6 mt-3 p-2.5 rounded-lg bg-green-50 border border-green-200 text-green-800 text-xs flex items-center gap-2 animate-fadeIn">
            <CheckCircle2 className="w-4 h-4 text-green-600 shrink-0" />
            <span>{alertSuccessMsg}</span>
          </div>
        )}
        {actionError && (
          <div className="mx-6 mt-3 p-2.5 rounded-lg bg-rose-50 border border-rose-200 text-rose-800 text-xs flex items-center gap-2">
            <AlertCircle className="w-4 h-4 text-rose-600 shrink-0" />
            <span>{actionError}</span>
          </div>
        )}

        {/* Modal Content Scrollable */}
        <div className="p-6 space-y-6 overflow-y-auto flex-1">
          {/* Section 1: Customer & Product Info (2 columns) */}
          <div className="space-y-4">
            {/* Customer Box */}
            <div className="p-5 rounded-2xl border border-blue-200 bg-gradient-to-br from-white via-blue-50/60 to-indigo-50/50 space-y-3">
              <div className="flex items-center gap-2 text-slate-900 font-semibold text-xs border-b border-slate-200 pb-2">
                <User className="w-4 h-4 text-blue-600" />
                <span className="text-sm">{pt ? 'Informações do cliente' : 'Customer Information'}</span>
              </div>
              <div className="grid grid-cols-1 gap-3 pt-1 text-sm text-slate-700 sm:grid-cols-2 lg:grid-cols-3">
                <div>
                  <span className="text-slate-500">{pt ? 'Nome' : 'Name'}:</span>{' '}
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
                    <span className="text-zinc-500">{pt ? 'Telefone' : 'Phone'}:</span>{' '}
                    <span className="font-mono text-zinc-800">{order.customer_phone}</span>
                  </div>
                )}
                {order.customer_cpf && (
                  <div>
                    <span className="text-zinc-500">CPF:</span>{' '}
                    <span className="font-mono text-zinc-800">{order.customer_cpf}</span>
                    <span className="ml-1 text-[9px] text-zinc-400">({pt ? 'fictício para demonstração' : 'fictional demo data'})</span>
                  </div>
                )}
                {order.shipment.destination && !/customer destination|não informado/i.test(order.shipment.destination) && (
                  <div>
                    <span className="text-zinc-500">{pt ? 'Destino' : 'Destination'}:</span>{' '}
                    <strong className="text-zinc-900 font-semibold">{order.shipment.destination}</strong>
                  </div>
                )}
              </div>
            </div>

            {/* Products & Pricing Box */}
            <div className="p-5 rounded-2xl border border-zinc-200 bg-gradient-to-br from-white via-slate-50 to-emerald-50/30 space-y-3">
              <div className="flex items-center gap-2 text-zinc-900 font-semibold text-xs border-b border-zinc-200 pb-2">
                <Package className="w-4 h-4 text-zinc-600" />
                <span>{pt?'Produtos do pedido':'Order Products'} ({orderItems.length})</span>
              </div>
              <div className="space-y-2 pt-1 max-h-56 overflow-y-auto pr-1">
                {orderItems.map((item) => {
                  const itemSelectionKey = orderItemSelectionKey(item);
                  const itemSelected = order.marketplace_purchase_confirmed || selectedPurchasedItems.has(itemSelectionKey);
                  return (
                  <div
                    key={itemSelectionKey}
                    className={`rounded-lg border bg-white p-2.5 transition-colors ${
                      orderItems.length > 1 && itemSelected
                        ? 'border-emerald-300 ring-1 ring-emerald-100'
                        : 'border-zinc-200'
                    }`}
                  >
                    <div className="flex items-start justify-between gap-3">
                      <div className="font-medium text-zinc-900">{item.product_name}</div>
                      {orderItems.length > 1 && (
                        <label className={`shrink-0 inline-flex items-center gap-1.5 rounded-lg border px-2.5 py-1.5 text-[11px] font-bold ${
                          itemSelected
                            ? 'border-emerald-300 bg-emerald-50 text-emerald-800'
                            : 'border-slate-300 bg-slate-50 text-slate-600'
                        } ${canManageOrders && !order.marketplace_purchase_confirmed ? 'cursor-pointer' : 'cursor-default'}`}>
                          <input
                            type="checkbox"
                            checked={itemSelected}
                            disabled={!canManageOrders || order.marketplace_purchase_confirmed}
                            onChange={() => {
                              setSelectedPurchasedItems(previous => {
                                const next = new Set(previous);
                                if (next.has(itemSelectionKey)) next.delete(itemSelectionKey);
                                else next.add(itemSelectionKey);
                                return next;
                              });
                            }}
                            className="h-4 w-4 accent-emerald-600"
                          />
                          <span>{order.marketplace_purchase_confirmed ? (pt ? 'Confirmado' : 'Confirmed') : (pt ? 'Comprado' : 'Purchased')}</span>
                        </label>
                      )}
                    </div>
                    <div className="flex flex-wrap items-center gap-2 pt-1">
                      <span className="font-mono text-xs bg-blue-100 px-2 py-1 rounded-md text-blue-800 border border-blue-200 font-bold">SKU: {item.sku}</span>
                      <span className="font-mono text-[11px] bg-amber-100 text-amber-900 px-1.5 py-0.5 rounded font-semibold border border-amber-300">ASIN: {item.asin}</span>
                      {item.sequencial && <span className="font-mono text-[11px] text-zinc-500">Seq: {item.sequencial}</span>}
                    </div>
                    <div className="grid grid-cols-1 sm:grid-cols-2 gap-2 pt-2 text-xs">
                      <div className="rounded-lg bg-slate-50 border border-slate-200 px-3 py-2">
                        <span className="text-zinc-500 block">{pt ? 'Valor USD' : 'USD value'}</span>
                        <strong className="font-mono text-zinc-900 block mt-0.5">${item.total_price.toFixed(2)} USD</strong>
                        {item.quantity > 1 && (
                          <span className="text-[10px] text-zinc-400 block mt-0.5">
                            ${item.price_unit.toFixed(2)} USD × {item.quantity}
                          </span>
                        )}
                      </div>
                      {item.vkp2_price !== undefined && (
                        <div className="rounded-lg bg-emerald-50 border border-emerald-200 px-3 py-2 sm:text-right">
                          <span className="text-emerald-700 block font-semibold">{pt ? 'Valor R$' : 'BRL value'}</span>
                          <strong className="font-mono text-emerald-800 text-sm block mt-0.5">
                            R$ {(item.vkp2_price * item.quantity).toFixed(2)}
                          </strong>
                          {item.quantity > 1 && (
                            <span className="text-[10px] text-emerald-600 block mt-0.5">
                              R$ {item.vkp2_price.toFixed(2)} × {item.quantity}
                            </span>
                          )}
                        </div>
                      )}
                    </div>
                  </div>
                  );
                })}
                <div className="flex items-center justify-between gap-4 rounded-xl border border-emerald-200 bg-emerald-50 px-4 py-3 mt-2">
                  <div>
                    <strong className="block text-emerald-950">{pt ? 'Total do pedido' : 'Order total'}</strong>
                    <span className="text-[10px] text-emerald-700">
                      {pt ? 'Valor total gasto pelo cliente' : 'Total amount spent by the customer'}
                    </span>
                  </div>
                  <strong className="text-xl font-mono text-emerald-800 whitespace-nowrap">
                    {hasBrlValue ? `R$ ${totalOrderBrl.toFixed(2)}` : `R$ 0.00`}
                  </strong>
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
                    {order.marketplace_purchase_confirmed
                      ? `${pt ? 'OK registrado em' : 'OK registered on'} ${purchaseDate}.`
                      : requiresItemSelection
                        ? allItemsSelected
                          ? (pt ? 'Todos os produtos foram selecionados. A confirmação da compra está liberada.' : 'All products are selected. Purchase confirmation is now available.')
                          : (pt
                              ? `Selecione todos os produtos acima para liberar a confirmação da compra. ${selectedItemCount} de ${orderItems.length} selecionados.`
                              : `Select every product above to enable purchase confirmation. ${selectedItemCount} of ${orderItems.length} selected.`)
                        : (pt ? 'Use o ASIN acima para realizar a compra e depois registre o OK.' : 'Use the ASIN above to complete the purchase and then register the OK.')}
                  </p>
                </div>
              </div>
              {canManageOrders && (
                <button
                  type="button"
                  disabled={savingPurchase || (!order.marketplace_purchase_confirmed && !allItemsSelected)}
                  onClick={async () => { setSavingPurchase(true); setActionError(''); try { await onConfirmMarketplacePurchase(order.id, !order.marketplace_purchase_confirmed); } catch (error) { setActionError(error instanceof Error ? error.message : (pt?'Não foi possível salvar a confirmação.':'Could not save confirmation.')); } finally { setSavingPurchase(false); } }}
                  title={!order.marketplace_purchase_confirmed && !allItemsSelected ? (pt ? 'Selecione todos os produtos antes de confirmar.' : 'Select all products before confirming.') : undefined}
                  className={`px-4 py-2 rounded-lg text-xs font-bold text-white disabled:opacity-50 disabled:cursor-not-allowed ${order.marketplace_purchase_confirmed ? 'bg-slate-600 hover:bg-slate-700' : 'bg-emerald-600 hover:bg-emerald-700'}`}
                >
                  {savingPurchase ? (pt?'Salvando...':'Saving...') : order.marketplace_purchase_confirmed ? (pt?'Desfazer confirmação':'Undo confirmation') : (pt?'Marcar compra como OK':'Mark purchase as OK')}
                </button>
              )}
            </div>
          </div>}

          <div className="p-4 rounded-xl border border-slate-200 bg-slate-50/70">
            <div className="flex flex-col gap-3 sm:flex-row sm:items-start sm:justify-between">
              <div>
                <h3 className="font-bold text-slate-900">{pt ? 'Observação do pedido' : 'Order note'}</h3>
                <p className="mt-0.5 text-[11px] text-slate-500">
                  {pt ? 'Registre aqui informações internas importantes sobre este pedido.' : 'Store important internal information about this order here.'}
                </p>
              </div>
              {canManageOrders && (
                <button
                  type="button"
                  disabled={savingNotes || orderNotes.trim() === (order.notes || '').trim()}
                  onClick={async () => {
                    setSavingNotes(true);
                    setActionError('');
                    try {
                      await onSaveOrderNotes(order.id, orderNotes);
                    } catch (error) {
                      setActionError(error instanceof Error ? error.message : (pt ? 'Não foi possível salvar a observação.' : 'Could not save the order note.'));
                    } finally {
                      setSavingNotes(false);
                    }
                  }}
                  className="shrink-0 rounded-lg bg-blue-600 px-3 py-2 text-xs font-bold text-white hover:bg-blue-700 disabled:cursor-not-allowed disabled:opacity-50"
                >
                  {savingNotes ? (pt ? 'Salvando...' : 'Saving...') : (pt ? 'Salvar observação' : 'Save note')}
                </button>
              )}
            </div>
            <textarea
              rows={3}
              maxLength={1500}
              value={orderNotes}
              onChange={event => setOrderNotes(event.target.value)}
              disabled={!canManageOrders}
              placeholder={pt ? 'Ex.: cliente solicitou contato antes da entrega, item aguardando validação...' : 'Example: customer requested contact before delivery, item awaiting validation...'}
              className="mt-3 w-full resize-y rounded-lg border border-slate-300 bg-white p-3 text-sm text-slate-800 focus:border-blue-500 focus:outline-none disabled:cursor-not-allowed disabled:bg-slate-100"
            />
            <div className="mt-1 text-right text-[10px] text-slate-400">{orderNotes.length}/1500</div>
          </div>

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
              <div className="flex flex-wrap justify-end gap-2 mt-2">
                <button
                  type="button"
                  disabled={restoringCancellation}
                  onClick={async () => {
                    const confirmed = window.confirm(pt
                      ? 'Desfazer o cancelamento? O sistema vai recalcular o status usando os dados logísticos já registrados e manter o histórico do cancelamento.'
                      : 'Undo this cancellation? The system will recalculate status from the existing logistics data and keep the cancellation audit history.');
                    if (!confirmed) return;
                    setRestoringCancellation(true);
                    setActionError('');
                    try {
                      await onRestoreCancellation(order.id);
                    } catch (error) {
                      setActionError(error instanceof Error ? error.message : (pt?'Não foi possível desfazer o cancelamento.':'Could not undo cancellation.'));
                    } finally {
                      setRestoringCancellation(false);
                    }
                  }}
                  className="px-4 py-2 rounded-lg bg-white hover:bg-slate-100 text-slate-800 border border-slate-300 text-xs font-bold disabled:opacity-50"
                >
                  {restoringCancellation ? (pt?'Restaurando...':'Restoring...') : (pt?'Desfazer cancelamento':'Undo Cancellation')}
                </button>
                <button
                  type="button"
                  disabled={savingReason || !cancellationReason.trim()}
                  onClick={async () => { setSavingReason(true); setActionError(''); try { await onSaveCancellationReason(order.id, cancellationReason); } catch (error) { setActionError(error instanceof Error ? error.message : (pt?'Não foi possível salvar a justificativa.':'Could not save reason.')); } finally { setSavingReason(false); } }}
                  className="px-4 py-2 rounded-lg bg-rose-600 hover:bg-rose-700 text-white text-xs font-bold disabled:opacity-50"
                >{savingReason ? (pt?'Salvando...':'Saving...') : order.cancellation_reason && order.cancellation_reason !== 'Justificativa pendente.' ? (pt?'Atualizar justificativa':'Update Reason') : (pt?'Salvar justificativa':'Save Reason')}</button>
              </div>
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
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Entrada no CD</span>
                    <span className="font-mono font-bold text-slate-800">{new Date(`${order.entry_cd_date.slice(0, 10)}T00:00:00`).toLocaleDateString('pt-BR')}</span>
                  </div>
                )}
                {order.billing_date && (
                  <div className="bg-white p-2 rounded border border-blue-100">
                    <span className="text-[10px] text-slate-400 uppercase font-semibold block">Data de faturamento / saída para entrega</span>
                    <span className="font-mono font-bold text-blue-700">{new Date(`${order.billing_date.slice(0, 10)}T00:00:00`).toLocaleDateString('pt-BR')}</span>
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

          {/* Section 2: Logistics telemetry (future Databricks-ready data contract) */}
          <div className="p-4 rounded-lg border border-amber-200 bg-amber-50/30 space-y-4">
            <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-2 border-b border-amber-200/70 pb-3">
              <div className="flex items-center gap-2">
                <div className="p-1.5 rounded-md bg-amber-100 text-amber-800">
                  <Database className="w-4 h-4" />
                </div>
                <div>
                  <h3 className="font-bold text-zinc-900 text-sm">
                    {pt ? 'Telemetria logística do pedido' : 'Order Logistics Telemetry'}
                  </h3>
                  <p className="text-[11px] text-zinc-600">
                    {pt ? 'Estrutura preparada para receber dados de uma fonte corporativa futura, como Databricks.' : 'Structure prepared to receive data from a future corporate source such as Databricks.'}
                  </p>
                </div>
              </div>

            </div>

            {/* Shipment Key Metrics */}
            <div className="grid grid-cols-2 sm:grid-cols-4 gap-3 text-xs">
              <div className="p-2.5 rounded bg-white border border-zinc-200">
                <span className="text-zinc-500 block text-[10px] uppercase font-semibold">
                  {pt ? 'Transportadora' : 'Carrier'}
                </span>
                <span className="font-bold text-zinc-900 text-xs">
                  {order.shipment.carrier}
                </span>
              </div>

              <div className="p-2.5 rounded bg-white border border-zinc-200">
                <span className="text-zinc-500 block text-[10px] uppercase font-semibold">
                  {pt ? 'Número de rastreio' : 'Tracking Number'}
                </span>
                <div className="flex items-center gap-1 font-mono font-semibold text-zinc-900 truncate">
                  <span className="truncate">{order.shipment.tracking_number}</span>
                  <button
                    onClick={() => copyToClipboard(order.shipment.tracking_number, 'modal-trk')}
                    className="text-zinc-400 hover:text-zinc-700 shrink-0"
                    title={pt ? 'Copiar número de rastreio' : 'Copy tracking number'}
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
                  {pt ? 'Status da entrega' : 'Shipment Status'}
                </span>
                <span className="font-bold text-indigo-700">
                  {shipmentStatusLabel(order.shipment.shipment_status)}
                </span>
              </div>

              <div className="p-2.5 rounded bg-white border border-zinc-200">
                <span className="text-zinc-500 block text-[10px] uppercase font-semibold">
                  {order.shipment.actual_delivery_date ? (pt ? 'Entregue em' : 'Delivered At') : (pt ? 'Previsão de entrega' : 'Estimated Delivery')}
                </span>
                <span className="font-bold text-zinc-900 font-mono">
                  {order.shipment.actual_delivery_date || order.shipment.estimated_delivery}
                </span>
              </div>
            </div>

            {/* Logistics routing */}
            <div className="flex items-center gap-2 text-[11px] text-zinc-600 bg-white/80 p-2.5 rounded border border-zinc-200">
              <MapPin className="w-4 h-4 text-rose-500 shrink-0" />
              <span>
                <strong className="text-zinc-900">{pt ? 'Rota' : 'Routing'}:</strong> {order.shipment.origin_hub} →{' '}
                <strong className="text-zinc-900">{order.shipment.destination}</strong>
              </span>
              <span className="ml-auto font-mono text-[10px] text-zinc-400">
                {pt ? 'Atualizado' : 'Updated'}: {order.shipment.databricks_sync_time}
              </span>
            </div>

            {/* Chronological Event Timeline */}
            <div>
              <h4 className="font-semibold text-zinc-800 text-xs mb-2 flex items-center gap-1.5">
                <Clock className="w-3.5 h-3.5 text-zinc-600" />
                {pt ? 'Acompanhamento do pedido' : 'Order Tracking'} ({trackingMilestones.length})
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
                )) : <p className="text-[11px] text-zinc-500 pb-2">{pt ? 'Nenhum marco logístico foi registrado ainda.' : 'No logistics milestone has been registered yet.'}</p>}
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
                  {pt ? 'Envio de alertas automáticos de entrega' : 'Automated Delivery Alert Dispatcher'}
                </h3>
              </div>
              <span className="text-[10px] font-medium text-indigo-700 bg-indigo-100 px-2 py-0.5 rounded-full">
                {pt ? 'E-mail + log do alerta' : 'Email + alert log'}
              </span>
            </div>
            <p className="text-[11px] text-zinc-600">
              {pt ? 'Quando o backend recebe uma mudança real de status, o MarketOps pode enviar o e-mail automaticamente. Os botões abaixo servem apenas para testar a comunicação.' : 'When the backend receives a real status change, MarketOps can send the email automatically. The buttons below only test the communication.'}
            </p>
            <div className="flex flex-wrap items-center gap-2 pt-1">
              <button
                onClick={() => handleTriggerAlert('Shipment Dispatched')}
                className="px-2.5 py-1.5 rounded bg-white hover:bg-zinc-100 border border-zinc-300 text-zinc-800 text-[11px] font-medium transition-colors"
              >
                {pt ? "Enviar alerta 'Pedido enviado'" : "Send 'Dispatched' Alert"}
              </button>
              <button
                onClick={() => handleTriggerAlert('Out for Delivery')}
                className="px-2.5 py-1.5 rounded bg-white hover:bg-zinc-100 border border-zinc-300 text-zinc-800 text-[11px] font-medium transition-colors"
              >
                {pt ? "Enviar alerta 'Saiu para entrega'" : "Send 'Out for Delivery' Alert"}
              </button>
              <button
                onClick={() => handleTriggerAlert('Delivered')}
                className="px-2.5 py-1.5 rounded bg-white hover:bg-zinc-100 border border-zinc-300 text-zinc-800 text-[11px] font-medium transition-colors"
              >
                {pt ? "Enviar alerta 'Entregue'" : "Send 'Delivered' Alert"}
              </button>
            </div>
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
                    setActionError('');
                    try {
                      await onCancelOrder(order.id, '');
                      setConfirmingCancellation(false);
                    } catch (error) {
                      setActionError(error instanceof Error ? error.message : (pt?'Não foi possível cancelar o pedido.':'Could not cancel the order.'));
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
                <span>{pt ? 'Sincronização com Databricks preparada no backend; alterações operacionais do MarketOps são preservadas.' : 'Databricks synchronization is prepared in the backend; MarketOps operational changes are preserved.'}</span>
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
