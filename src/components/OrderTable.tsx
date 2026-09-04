import React, { useEffect, useMemo, useState } from 'react';
import { 
  Check, 
  Copy, 
  ExternalLink, 
  Eye, 
  Clock, 
  CheckCircle2, 
  XCircle, 
  Truck, 
  Package, 
  AlertCircle,
  Database,
  Table as TableIcon,
  LayoutGrid
} from 'lucide-react';
import { Order, OrderStatus } from '../types';
import { translatePurchaseStatus } from '../utils/statusTranslation';

interface OrderTableProps {
  orders: Order[];
  onSelectOrder: (order: Order) => void;
  selectedOrderId?: string;
  resetToFirstSignal?: number;
  language?: 'en' | 'pt';
  onBulkConfirmPurchase: (orderIds: string[]) => Promise<void>;
  onBulkCancel: (orderIds: string[]) => Promise<void>;
}

export const OrderTable: React.FC<OrderTableProps> = ({
  orders,
  onSelectOrder,
  selectedOrderId,
  resetToFirstSignal,
  language = 'en',
  onBulkConfirmPurchase,
  onBulkCancel,
}) => {
  const pt = language === 'pt';
  const [copiedId, setCopiedId] = useState<string | null>(null);
  const [viewMode, setViewMode] = useState<'standard' | 'spreadsheet'>('spreadsheet');
  const [selectedIds, setSelectedIds] = useState<Set<string>>(new Set());
  const [confirmBulkCancellation, setConfirmBulkCancellation] = useState(false);
  const [bulkBusy, setBulkBusy] = useState(false);
  const [bulkError, setBulkError] = useState('');
  const [currentPage, setCurrentPage] = useState(() => {
    const saved = Number(localStorage.getItem('marketops-orders-page'));
    return Number.isInteger(saved) && saved > 0 ? saved : 1;
  });
  const pageSize = 20;
  const totalPages = Math.max(1, Math.ceil(orders.length / pageSize));
  const displayedOrders = useMemo(
    () => orders.slice((currentPage - 1) * pageSize, currentPage * pageSize),
    [orders, currentPage]
  );

  useEffect(() => {
    localStorage.setItem('marketops-orders-page', String(currentPage));
  }, [currentPage]);

  useEffect(() => {
    if (resetToFirstSignal) setCurrentPage(1);
  }, [resetToFirstSignal]);

  useEffect(() => {
    if (currentPage > totalPages) setCurrentPage(totalPages);
  }, [currentPage, totalPages]);

  useEffect(() => {
    const available = new Set(orders.map(order => order.id));
    setSelectedIds(previous => new Set([...previous].filter(id => available.has(id))));
  }, [orders]);

  const toggleOrderSelection = (orderId: string) => {
    setSelectedIds(previous => {
      const next = new Set(previous);
      if (next.has(orderId)) next.delete(orderId); else next.add(orderId);
      return next;
    });
    setConfirmBulkCancellation(false);
    setBulkError('');
  };

  const allDisplayedSelected = displayedOrders.length > 0 && displayedOrders.every(order => selectedIds.has(order.id));
  const toggleDisplayedOrders = () => {
    setSelectedIds(previous => {
      const next = new Set(previous);
      if (allDisplayedSelected) displayedOrders.forEach(order => next.delete(order.id));
      else displayedOrders.forEach(order => next.add(order.id));
      return next;
    });
    setConfirmBulkCancellation(false);
    setBulkError('');
  };

  const selectedOrders = orders.filter(order => selectedIds.has(order.id));
  const purchaseEligibleIds = selectedOrders.filter(order => order.status !== 'Cancelled' && !order.marketplace_purchase_confirmed).map(order => order.id);
  const cancellationEligibleIds = selectedOrders.filter(order => order.status !== 'Cancelled' && order.status !== 'Delivered').map(order => order.id);

  const runBulkAction = async (action: 'purchase' | 'cancel') => {
    const ids = action === 'purchase' ? purchaseEligibleIds : cancellationEligibleIds;
    if (!ids.length) return;
    setBulkBusy(true);
    setBulkError('');
    try {
      if (action === 'purchase') await onBulkConfirmPurchase(ids);
      else await onBulkCancel(ids);
      setSelectedIds(new Set());
      setConfirmBulkCancellation(false);
    } catch (error: any) {
      setBulkError(error?.message || (pt ? 'Não foi possível concluir a ação.' : 'The action could not be completed.'));
    } finally {
      setBulkBusy(false);
    }
  };

  const handleCopy = (text: string, identifier: string, e: React.MouseEvent) => {
    e.stopPropagation();
    navigator.clipboard.writeText(text);
    setCopiedId(identifier);
    setTimeout(() => setCopiedId(null), 2000);
  };

  const getOrderStatusBadge = (status: OrderStatus) => {
    switch (status) {
      case 'Delivered':
        return (
          <span className="px-2.5 py-1 bg-emerald-100 text-emerald-800 rounded-full text-xs font-bold inline-flex items-center gap-1">
            <CheckCircle2 className="w-3 h-3 text-emerald-600" />
            Delivered
          </span>
        );
      case 'Shipped':
        return (
          <span className="px-2.5 py-1 bg-blue-100 text-blue-800 rounded-full text-xs font-bold inline-flex items-center gap-1">
            <Truck className="w-3 h-3 text-blue-600" />
            In Transit
          </span>
        );
      case 'Processing':
        return (
          <span className="px-2.5 py-1 bg-purple-100 text-purple-800 rounded-full text-xs font-bold inline-flex items-center gap-1">
            <Package className="w-3 h-3 text-purple-600" />
            Processing
          </span>
        );
      case 'Pending':
        return (
          <span className="px-2.5 py-1 bg-amber-100 text-amber-800 rounded-full text-xs font-bold inline-flex items-center gap-1">
            <Clock className="w-3 h-3 text-amber-600" />
            Pending
          </span>
        );
      case 'Cancelled':
        return (
          <span className="px-2.5 py-1 bg-rose-100 text-rose-800 rounded-full text-xs font-bold inline-flex items-center gap-1">
            <XCircle className="w-3 h-3 text-rose-600" />
            Cancelled
          </span>
        );
      default:
        return (
          <span className="px-2.5 py-0.5 rounded-full text-xs font-medium bg-slate-100 text-slate-700">
            {status}
          </span>
        );
    }
  };

  const getShipmentBadge = (shipment: Order['shipment']) => {
    const { is_shipped, shipment_status } = shipment;
    if (shipment_status === 'Delivered') {
      return (
        <span className="inline-flex items-center gap-1 text-xs font-semibold text-emerald-600">
          <span className="w-1.5 h-1.5 rounded-full bg-emerald-500" />
          Delivered
        </span>
      );
    }
    if (shipment_status === 'Out for Delivery') {
      return (
        <span className="inline-flex items-center gap-1 text-xs font-semibold text-blue-600 animate-pulse">
          <span className="w-1.5 h-1.5 rounded-full bg-blue-500" />
          Out for Delivery
        </span>
      );
    }
    if (is_shipped || shipment_status === 'In Transit') {
      return (
        <span className="inline-flex items-center gap-1 text-xs font-semibold text-blue-600">
          <span className="w-1.5 h-1.5 rounded-full bg-blue-500" />
          In Transit
        </span>
      );
    }
    if (shipment_status === 'Cancelled') {
      return (
        <span className="inline-flex items-center gap-1 text-xs font-bold text-rose-700">
          <span className="w-1.5 h-1.5 rounded-full bg-rose-500" />
          Cancelled
        </span>
      );
    }
    return (
      <span className="inline-flex items-center gap-1 text-xs font-medium text-amber-600">
        <span className="w-1.5 h-1.5 rounded-full bg-amber-400" />
        Not Shipped
      </span>
    );
  };

  if (orders.length === 0) {
    return (
      <div className="bg-white rounded-2xl border border-slate-200 p-12 text-center shadow-sm">
        <div className="w-12 h-12 rounded-full bg-slate-100 flex items-center justify-center mx-auto mb-3 text-slate-400">
          <AlertCircle className="w-6 h-6" />
        </div>
        <h3 className="text-base font-semibold text-slate-800">No marketplace orders match your criteria</h3>
        <p className="text-xs text-slate-500 mt-1 max-w-sm mx-auto">
          Try clearing your search filters or click "Send Multiple Orders" to import your 13-column spreadsheet orders.
        </p>
      </div>
    );
  }

  return (
    <div className="bg-white rounded-2xl shadow-sm border border-slate-200 overflow-hidden flex flex-col">
      {/* Table Header Banner with View Switcher */}
      <div className="px-6 py-3.5 border-b border-slate-100 bg-slate-50/70 flex flex-wrap justify-between items-center gap-3">
        <div className="flex items-center gap-3">
          <div className="flex items-center gap-2">
            <h4 className="font-bold text-slate-800 text-sm tracking-tight">Live Order Flow</h4>
            <span className="text-xs text-slate-400 font-mono">({orders.length})</span>
          </div>

          {/* View Mode Toggle */}
          <div className="flex items-center bg-slate-200/70 p-0.5 rounded-lg text-xs">
            <button
              type="button"
              onClick={() => setViewMode('spreadsheet')}
              className={`px-2.5 py-1 rounded-md font-semibold flex items-center gap-1.5 transition-all ${
                viewMode === 'spreadsheet'
                  ? 'bg-white text-blue-700 shadow-xs'
                  : 'text-slate-600 hover:text-slate-900'
              }`}
            >
              <TableIcon className="w-3.5 h-3.5 text-blue-600" />
              <span>13-Column Spreadsheet View</span>
            </button>
            <button
              type="button"
              onClick={() => setViewMode('standard')}
              className={`px-2.5 py-1 rounded-md font-semibold flex items-center gap-1.5 transition-all ${
                viewMode === 'standard'
                  ? 'bg-white text-blue-700 shadow-xs'
                  : 'text-slate-600 hover:text-slate-900'
              }`}
            >
              <LayoutGrid className="w-3.5 h-3.5 text-slate-500" />
              <span>Standard Card View</span>
            </button>
          </div>
        </div>

        <div className="text-xs text-slate-500 flex items-center gap-2">
          <div className="flex items-center gap-1.5">
            <span className="w-2 h-2 rounded-full bg-emerald-500 animate-pulse" />
            <span className="font-medium text-slate-600">Databricks Delta Lake Synchronized</span>
          </div>
        </div>
      </div>

      {selectedIds.size > 0 && (
        <div className="px-5 py-3 border-b border-blue-200 bg-blue-50/80">
          {confirmBulkCancellation ? (
            <div className="flex flex-col lg:flex-row lg:items-center justify-between gap-3 rounded-xl border border-rose-300 bg-rose-50 p-3">
              <div className="flex items-start gap-2 text-rose-800">
                <AlertCircle className="w-4 h-4 mt-0.5 shrink-0" />
                <div>
                  <p className="font-bold text-xs">{pt ? `Tem certeza de que deseja cancelar ${cancellationEligibleIds.length} pedidos?` : `Are you sure you want to cancel ${cancellationEligibleIds.length} orders?`}</p>
                  <p className="text-[11px] mt-0.5">{pt?'Essa ação alterará todos os pedidos selecionados para Cancelado.':'This action will change all selected orders to Cancelled.'}</p>
                </div>
              </div>
              <div className="flex items-center justify-end gap-3">
                <button type="button" disabled={bulkBusy} onClick={() => setConfirmBulkCancellation(false)} className="px-3 py-2 rounded-lg border border-slate-300 bg-white text-slate-700 text-xs font-semibold disabled:opacity-50">{pt?'Voltar':'Go Back'}</button>
                <button type="button" disabled={bulkBusy} onClick={() => void runBulkAction('cancel')} className="px-3 py-2 rounded-lg bg-rose-600 hover:bg-rose-700 text-white text-xs font-bold disabled:opacity-50">{bulkBusy?(pt?'Cancelando...':'Cancelling...'):(pt?`Sim, cancelar ${cancellationEligibleIds.length}`:`Yes, Cancel ${cancellationEligibleIds.length}`)}</button>
              </div>
            </div>
          ) : (
            <div className="flex flex-wrap items-center justify-between gap-3">
              <div className="flex flex-wrap items-center gap-3 text-xs">
                <strong className="text-blue-900">{selectedIds.size} {pt?'selecionados':'selected'}</strong>
                {selectedIds.size < orders.length && <button type="button" onClick={() => setSelectedIds(new Set(orders.map(order => order.id)))} className="font-semibold text-blue-700 hover:underline">{pt?`Selecionar todos os ${orders.length} pedidos filtrados`:`Select all ${orders.length} filtered orders`}</button>}
                <button type="button" onClick={() => setSelectedIds(new Set())} className="font-semibold text-slate-600 hover:underline">{pt?'Limpar seleção':'Clear selection'}</button>
              </div>
              <div className="flex flex-wrap items-center gap-3">
                <button type="button" disabled={bulkBusy || !purchaseEligibleIds.length} onClick={() => void runBulkAction('purchase')} className="px-3 py-2 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white text-xs font-bold disabled:opacity-40">{bulkBusy?(pt?'Salvando...':'Saving...'):(pt?`Confirmar compra (${purchaseEligibleIds.length})`:`Confirm Purchase (${purchaseEligibleIds.length})`)}</button>
                <button type="button" disabled={bulkBusy || !cancellationEligibleIds.length} onClick={() => setConfirmBulkCancellation(true)} className="px-3 py-2 rounded-lg border border-rose-300 bg-white text-rose-700 hover:bg-rose-50 text-xs font-bold disabled:opacity-40">{pt?`Cancelar pedidos (${cancellationEligibleIds.length})`:`Cancel Orders (${cancellationEligibleIds.length})`}</button>
              </div>
            </div>
          )}
          {bulkError && <p className="mt-2 text-xs font-semibold text-rose-700">{bulkError}</p>}
        </div>
      )}

      {/* Mode 1: 13-Column Spreadsheet Table View */}
      {viewMode === 'spreadsheet' ? (
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse min-w-[1280px]">
            <thead className="bg-slate-100/90 text-slate-600 text-[10px] uppercase font-bold tracking-wider sticky top-0 whitespace-nowrap border-b border-slate-200">
              <tr>
                <th className="px-3 py-3 text-center"><input type="checkbox" checked={allDisplayedSelected} onChange={toggleDisplayedOrders} aria-label={pt?'Selecionar pedidos desta página':'Select orders on this page'} className="w-4 h-4 accent-blue-600" /></th>
                <th className="px-3 py-3">#</th>
                <th className="px-3 py-3">{pt?'Data Compra':'Purchase Date'}</th>
                <th className="px-3 py-3">SKU Marketplace</th>
                <th className="px-3 py-3">{pt?'Descrição do Material':'Product Description'}</th>
                <th className="px-3 py-3">SKU Principal (ASIN)</th>
                <th className="px-3 py-3">Seller</th>
                <th className="px-3 py-3">{pt?'Origem (País)':'Origin (Country)'}</th>
                <th className="px-3 py-3">{pt?'Ordem Cliente':'Customer Order'}</th>
                <th className="px-3 py-3 bg-blue-50/80 text-blue-900 border-x border-blue-200/60 font-bold">{pt?'Ordem Compra (PO / ID)':'Purchase Order (PO / ID)'}</th>
                <th className="px-3 py-3">Seq</th>
                <th className="px-3 py-3">{pt?'Status da Compra':'Purchase Status'}</th>
                <th className="px-3 py-3 text-center">{pt?'Qtd':'Qty'}</th>
                <th className="px-3 py-3 text-right">{pt?'Preço VKP2':'VKP2 Price'}</th>
                <th className="px-3 py-3 text-right">{pt?'Valor Compra Seller':'Seller Purchase Cost'}</th>
                <th className="px-3 py-3">Databricks Tracking</th>
                <th className="px-3 py-3 text-right">{pt?'Ação':'Action'}</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-100 text-xs whitespace-nowrap bg-white">
              {displayedOrders.map((order, idx) => {
                const isTargeted = selectedOrderId === order.id;

                return (
                  <tr
                    key={order.id}
                    id={`row-${order.id}`}
                    onClick={() => onSelectOrder(order)}
                    className={`hover:bg-blue-50/40 transition-colors cursor-pointer ${
                      order.status === 'Cancelled' ? 'bg-rose-50/80 border-l-4 border-rose-500 ' : !order.marketplace_purchase_confirmed ? 'bg-amber-50/80 border-l-4 border-amber-500 ' : ''
                    }${
                      isTargeted ? 'bg-blue-50/30 ring-1 ring-inset ring-blue-500/30' : ''
                    }`}
                  >
                    <td className="px-3 py-3 text-center" onClick={(event) => event.stopPropagation()}>
                      <input type="checkbox" checked={selectedIds.has(order.id)} onChange={() => toggleOrderSelection(order.id)} aria-label={`${pt?'Selecionar pedido':'Select order'} ${order.purchase_order || order.id}`} className="w-4 h-4 accent-blue-600" />
                    </td>
                    {/* Index */}
                    <td className="px-3 py-3 font-mono text-slate-400 text-[11px]">
                      {(currentPage - 1) * pageSize + idx + 1}
                    </td>

                    {/* 1. Data da compra */}
                    <td className="px-3 py-3 font-mono text-slate-700">
                      {order.date_order}
                    </td>

                    {/* 2. SKU Marketplace */}
                    <td className="px-3 py-3 font-mono font-bold text-slate-900">
                      {order.sku}
                    </td>

                    {/* 3. Descrição do Material */}
                    <td className="px-3 py-3 max-w-[220px] truncate font-medium text-slate-800" title={order.product_name}>
                      {order.product_name}
                    </td>

                    {/* 4. SKU Principal */}
                    <td className="px-3 py-3 font-mono text-blue-600 font-semibold">
                      {order.asin}
                    </td>

                    {/* 5. Seller */}
                    <td className="px-3 py-3 text-slate-700">
                      {order.marketplace}
                    </td>

                    {/* 6. Origem (País Seller) */}
                    <td className="px-3 py-3 text-slate-600">
                      {order.seller_country || 'EUA'}
                    </td>

                    {/* 7. Ordem de Cliente */}
                    <td className="px-3 py-3 font-mono text-slate-700">
                      {order.customer_order_id || '—'}
                    </td>

                    {/* 8. Ordem de Compra (PO / Primary ID) */}
                    <td className="px-3 py-3 font-mono font-bold text-blue-700 bg-blue-50/40 border-x border-blue-100">
                      <div className="flex items-center gap-1">
                        <span>{order.purchase_order || order.id}</span>
                        <button
                          onClick={(e) => handleCopy(order.purchase_order || order.id, `po-${order.id}`, e)}
                          title="Copy Ordem de Compra (PO)"
                          className="text-slate-400 hover:text-blue-600 p-0.5"
                        >
                          {copiedId === `po-${order.id}` ? (
                            <Check className="w-2.5 h-2.5 text-emerald-600" />
                          ) : (
                            <Copy className="w-2.5 h-2.5" />
                          )}
                        </button>
                      </div>
                    </td>

                    {/* 9. Sequencial */}
                    <td className="px-3 py-3 font-mono text-slate-500">
                      {order.sequencial || '10'}
                    </td>

                    {/* 10. Sts de Compra */}
                    <td className="px-3 py-3">
                      {order.status === 'Cancelled' ? getOrderStatusBadge('Cancelled') : order.sts_compra ? (
                        <span
                          className={`inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold ${
                            order.sts_compra.includes('ENTREG')
                              ? 'bg-emerald-100 text-emerald-800'
                              : order.sts_compra.includes('CANCEL')
                              ? 'bg-rose-100 text-rose-800'
                              : order.sts_compra.includes('TRANSIT') || order.sts_compra.includes('ENVIAD')
                              ? 'bg-blue-100 text-blue-800'
                              : 'bg-amber-100 text-amber-800'
                          }`}
                        >
                          {translatePurchaseStatus(order.sts_compra, language)}
                        </span>
                      ) : (
                        getOrderStatusBadge(order.status)
                      )}
                      {order.status !== 'Cancelled' && !order.marketplace_purchase_confirmed && <div className="mt-1 text-[10px] font-bold text-rose-700">{pt?'COMPRA NÃO CONFIRMADA':'PURCHASE NOT CONFIRMED'}</div>}
                    </td>

                    {/* 11. Quantidade */}
                    <td className="px-3 py-3 text-center font-mono font-semibold text-slate-800">
                      {order.quantity}
                    </td>

                    {/* 12. Preço de venda VKP2 */}
                    <td className="px-3 py-3 text-right font-mono font-semibold text-emerald-700">
                      {order.vkp2_price !== undefined ? `R$ ${order.vkp2_price.toFixed(2)}` : '—'}
                    </td>

                    {/* 13. Valor Total Compra Seller */}
                    <td className="px-3 py-3 text-right font-mono font-bold text-slate-900">
                      {order.seller_usd_total !== undefined 
                        ? `$${order.seller_usd_total.toFixed(2)}` 
                        : `$${order.total_price.toFixed(2)}`}
                    </td>

                    {/* Databricks Tracking */}
                    <td className="px-3 py-3">
                      <div className="flex items-center gap-1.5">
                        {getShipmentBadge(order.shipment)}
                        <span className="font-mono text-[10px] text-slate-400">
                          ({order.shipment.tracking_number.slice(0, 10)}...)
                        </span>
                      </div>
                    </td>

                    {/* Actions */}
                    <td className="px-3 py-3 text-right">
                      <div className="flex items-center justify-end gap-1.5" onClick={(e) => e.stopPropagation()}>
                        <button
                          id={`btn-view-${order.id}`}
                          onClick={() => onSelectOrder(order)}
                          title="View order details"
                          className="p-1.5 rounded-lg bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs transition-colors"
                        >
                          <Eye className="w-3.5 h-3.5" />
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      ) : (
        /* Mode 2: Standard Card View */
        <div className="overflow-x-auto">
          <table className="w-full text-left border-collapse">
            <thead className="bg-slate-50 text-slate-400 text-[10px] uppercase font-bold tracking-widest sticky top-0">
              <tr className="border-b border-slate-100">
                <th className="px-4 py-4 text-center"><input type="checkbox" checked={allDisplayedSelected} onChange={toggleDisplayedOrders} aria-label={pt?'Selecionar pedidos desta página':'Select orders on this page'} className="w-4 h-4 accent-blue-600" /></th>
                <th className="px-6 py-4">Ordem de Compra (PO)</th>
                <th className="px-6 py-4">{pt?'Cliente':'Customer'}</th>
                <th className="px-6 py-4">Product Details</th>
                <th className="px-6 py-4 text-right">Financials</th>
                <th className="px-6 py-4">Status</th>
                <th className="px-6 py-4">
                  <span className="inline-flex items-center gap-1">
                    Databricks Shipment
                    <Database className="w-3 h-3 text-amber-500" />
                  </span>
                </th>
                <th className="px-6 py-4 text-right">Actions</th>
              </tr>
            </thead>
            <tbody className="divide-y divide-slate-50 text-sm">
              {displayedOrders.map((order) => {
                const itemCount = order.items?.length || 1;
                const isTargeted = selectedOrderId === order.id;

                return (
                  <tr
                    key={order.id}
                    id={`row-${order.id}`}
                    onClick={() => onSelectOrder(order)}
                    className={`hover:bg-blue-50/30 transition-colors cursor-pointer ${
                      order.status === 'Cancelled' ? 'bg-rose-50/80 border-l-4 border-rose-500 ' : !order.marketplace_purchase_confirmed ? 'bg-amber-50/80 border-l-4 border-amber-500 ' : ''
                    }${
                      isTargeted ? 'bg-blue-50/20 ring-1 ring-inset ring-blue-500/20' : ''
                    }`}
                  >
                    <td className="px-4 py-4 text-center" onClick={(event) => event.stopPropagation()}>
                      <input type="checkbox" checked={selectedIds.has(order.id)} onChange={() => toggleOrderSelection(order.id)} aria-label={`${pt?'Selecionar pedido':'Select order'} ${order.purchase_order || order.id}`} className="w-4 h-4 accent-blue-600" />
                    </td>
                    {/* Order Info: Ordem de Compra (PO) */}
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="flex items-center gap-2">
                        <span className="text-[10px] font-bold px-1.5 py-0.5 rounded bg-blue-100 text-blue-800 font-mono">
                          PO
                        </span>
                        <span className="font-bold text-slate-900 font-mono text-sm tracking-tight">
                          {order.purchase_order || order.id}
                        </span>
                        <button
                          onClick={(e) => handleCopy(order.purchase_order || order.id, order.id, e)}
                          title="Copy Ordem de Compra (PO)"
                          className="text-slate-400 hover:text-slate-700 p-0.5 transition-colors"
                        >
                          {copiedId === order.id ? (
                            <Check className="w-3 h-3 text-emerald-600" />
                          ) : (
                            <Copy className="w-3 h-3" />
                          )}
                        </button>
                      </div>
                      <div className="text-xs text-slate-500 font-mono mt-1">
                        {order.marketplace} • {order.date_order} • Origem: {order.seller_country || 'EUA'}
                      </div>
                      {order.customer_order_id && (
                        <div className="text-[11px] text-slate-400 font-mono mt-0.5">
                          Ordem Cliente: #{order.customer_order_id} {order.sequencial ? `• Seq ${order.sequencial}` : ''}
                        </div>
                      )}
                    </td>

                    {/* Customer Info */}
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="font-medium text-slate-800">{order.customer_name}</div>
                      {order.customer_email && (
                        <div className="text-xs text-slate-400 font-mono truncate max-w-[160px]" title={order.customer_email}>
                          {order.customer_email}
                        </div>
                      )}
                      {order.customer_phone && (
                        <div className="text-[11px] text-slate-400 font-mono">
                          {order.customer_phone}
                        </div>
                      )}
                    </td>

                    {/* Product Details */}
                    <td className="px-6 py-4 max-w-[240px]">
                      <div className="font-medium text-slate-800 line-clamp-1" title={order.product_name}>
                        {itemCount > 1 ? `${itemCount} produtos neste pedido` : order.product_name}
                      </div>
                      <div className="text-[10px] text-slate-400 font-mono mt-0.5">
                        {itemCount > 1 ? (
                          <span>SKUs: <strong className="text-slate-700">{order.items!.map(item => item.sku).join(', ')}</strong></span>
                        ) : (
                          <>SKU: <span className="font-bold text-slate-700">{order.sku}</span> • ASIN: {order.asin}</>
                        )}
                      </div>
                    </td>

                    {/* Financials */}
                    <td className="px-6 py-4 text-right whitespace-nowrap">
                      <div className="font-bold text-slate-800 font-mono">
                        ${order.seller_usd_total !== undefined ? order.seller_usd_total.toFixed(2) : order.total_price.toFixed(2)} USD
                      </div>
                      <div className="text-xs text-slate-400">
                        {order.vkp2_price ? (
                          <span className="text-emerald-600 font-medium font-mono text-[11px]">
                            VKP2: R$ {order.vkp2_price.toFixed(2)} (Qtd {order.quantity})
                          </span>
                        ) : (
                          `Qty: ${order.quantity} ($${order.price_unit.toFixed(2)} ea)`
                        )}
                      </div>
                    </td>

                    {/* Status Badge */}
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="space-y-1">
                        {getOrderStatusBadge(order.status)}
                        {order.sts_compra && (
                          <div className="text-[10px] text-slate-500 font-mono">
                            {pt?'Status':'Status'}: {translatePurchaseStatus(order.sts_compra, language)}
                          </div>
                        )}
                        {order.status !== 'Cancelled' && !order.marketplace_purchase_confirmed && <div className="text-[10px] font-bold text-rose-700">{pt?'Compra não confirmada':'Purchase not confirmed'}</div>}
                      </div>
                    </td>

                    {/* Databricks Shipment Tracking */}
                    <td className="px-6 py-4 whitespace-nowrap">
                      <div className="space-y-0.5">
                        <div className="flex items-center gap-2">
                          {getShipmentBadge(order.shipment)}
                          <span className="text-[10px] text-slate-300">•</span>
                          <span className="text-xs text-slate-600 font-medium">
                            {order.shipment.carrier}
                          </span>
                        </div>

                        {/* Tracking Number */}
                        <div className="flex items-center gap-1 font-mono text-[11px] text-slate-400">
                          <span>{order.shipment.tracking_number}</span>
                          <button
                            onClick={(e) => handleCopy(order.shipment.tracking_number, `trk-${order.id}`, e)}
                            title="Copy Tracking #"
                            className="text-slate-400 hover:text-slate-700"
                          >
                            {copiedId === `trk-${order.id}` ? (
                              <Check className="w-2.5 h-2.5 text-emerald-600" />
                            ) : (
                              <Copy className="w-2.5 h-2.5" />
                            )}
                          </button>
                        </div>

                        {/* Delivery Date */}
                        <div className="text-[10px] text-slate-400">
                          {order.shipment.actual_delivery_date ? (
                            <span className="text-emerald-600 font-medium">
                              Delivered {order.shipment.actual_delivery_date.split(' ')[0]}
                            </span>
                          ) : (
                            <span>
                              Est: <strong className="text-slate-600 font-medium">{order.shipment.estimated_delivery}</strong>
                            </span>
                          )}
                        </div>
                      </div>
                    </td>

                    {/* Action Buttons */}
                    <td className="px-6 py-4 text-right whitespace-nowrap">
                      <div className="flex items-center justify-end gap-2" onClick={(e) => e.stopPropagation()}>
                        <button
                          id={`btn-view-${order.id}`}
                          onClick={() => onSelectOrder(order)}
                          title="View order details and shipment timeline"
                          className="inline-flex items-center gap-1 px-2.5 py-1.5 rounded-lg bg-slate-100 hover:bg-slate-200 text-slate-700 text-xs font-medium transition-colors"
                        >
                          <Eye className="w-3 h-3" />
                          <span>View</span>
                        </button>
                      </div>
                    </td>
                  </tr>
                );
              })}
            </tbody>
          </table>
        </div>
      )}
      <div className="px-5 py-3 border-t border-slate-100 bg-slate-50 flex flex-wrap items-center justify-between gap-3 text-xs">
        <span className="text-slate-500">
          {pt?'Exibindo':'Showing'} <strong className="text-slate-800">{orders.length === 0 ? 0 : (currentPage - 1) * pageSize + 1}</strong>–<strong className="text-slate-800">{Math.min(currentPage * pageSize, orders.length)}</strong> {pt?'de':'of'} <strong className="text-slate-800">{orders.length}</strong> {pt?'pedidos':'orders'}
        </span>
        <div className="flex flex-wrap items-center justify-end gap-2">
          <button
            type="button"
            onClick={() => setCurrentPage(1)}
            disabled={currentPage === 1}
            className="px-3 py-1.5 rounded-lg border border-slate-200 bg-white text-slate-700 font-semibold hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed"
            title="Ir para a primeira página"
          >
            {pt?'Primeira':'First'}
          </button>
          <button
            type="button"
            onClick={() => setCurrentPage((page) => Math.max(1, page - 1))}
            disabled={currentPage === 1}
            className="px-3 py-1.5 rounded-lg border border-slate-200 bg-white text-slate-700 font-semibold hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            {pt?'Anterior':'Previous'}
          </button>
          <label className="flex items-center gap-1.5 font-medium text-slate-600 whitespace-nowrap">
            <span>{pt?'Página':'Page'}</span>
            <input
              type="number"
              min={1}
              max={totalPages}
              value={currentPage}
              onChange={(event) => {
                const page = Number(event.target.value);
                if (Number.isInteger(page) && page >= 1 && page <= totalPages) {
                  setCurrentPage(page);
                }
              }}
              className="w-14 px-2 py-1.5 text-center rounded-lg border border-slate-200 bg-white text-slate-800 font-bold focus:outline-none focus:border-blue-500"
              aria-label="Número da página"
            />
            <span>{pt?'de':'of'} {totalPages}</span>
          </label>
          <button
            type="button"
            onClick={() => setCurrentPage((page) => Math.min(totalPages, page + 1))}
            disabled={currentPage === totalPages}
            className="px-3 py-1.5 rounded-lg border border-slate-200 bg-white text-slate-700 font-semibold hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed"
          >
            {pt?'Próxima':'Next'}
          </button>
          <button
            type="button"
            onClick={() => setCurrentPage(totalPages)}
            disabled={currentPage === totalPages}
            className="px-3 py-1.5 rounded-lg border border-slate-200 bg-white text-slate-700 font-semibold hover:bg-slate-100 disabled:opacity-40 disabled:cursor-not-allowed"
            title="Ir para a última página"
          >
            {pt?'Última':'Last'}
          </button>
        </div>
      </div>
    </div>
  );
};
