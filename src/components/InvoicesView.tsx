import React, { useEffect, useMemo, useState } from 'react';
import { ChevronDown, ChevronRight, Search } from 'lucide-react';
import type { Order, OrderStatus } from '../types';
import { apiFetch } from '../lib/api';

interface Props {
  // Changes whenever the app refreshes orders; used as a signal to reload invoices.
  orders: Order[];
  language: 'en' | 'pt';
  onOpenOrder: (order: Order) => void;
}

type InvoiceStatus = 'in_transit' | 'completed';

interface InvoiceOrder {
  order: Order;
  // Product lines of this order that belong to the invoice.
  items: Order[];
  status: OrderStatus;
}

interface InvoiceGroup {
  invoice: string;
  status: InvoiceStatus;
  orders: InvoiceOrder[];
  open: number;
  delivered: number;
  cancelled: number;
  etd?: string;
  eta?: string;
  lastUpdate: number;
}

const isFinished = (status: OrderStatus) => status === 'Delivered' || status === 'Cancelled';

const formatDate = (value: string | undefined, pt: boolean) => {
  if (!value) return '—';
  const date = new Date(`${value.slice(0, 10)}T12:00:00`);
  return Number.isNaN(date.getTime()) ? value : new Intl.DateTimeFormat(pt ? 'pt-BR' : 'en-US').format(date);
};

const latest = (values: (string | undefined)[]) => values.filter(Boolean).sort().pop();

// A line set is delivered/cancelled only when every line is; otherwise it follows the order.
const linesStatus = (order: Order, items: Order[]): OrderStatus => {
  if (items.every(item => item.status === 'Cancelled')) return 'Cancelled';
  if (items.every(item => isFinished(item.status))) return 'Delivered';
  return isFinished(order.status) ? 'Shipped' : order.status;
};

const buildInvoices = (orders: Order[]): InvoiceGroup[] => {
  const byInvoice = new Map<string, InvoiceOrder[]>();
  orders.forEach(order => {
    const lines = order.items?.length ? order.items : [order];
    const linesByInvoice = new Map<string, Order[]>();
    lines.forEach(line => {
      const invoice = line.invoice?.trim();
      if (!invoice) return;
      linesByInvoice.set(invoice, [...(linesByInvoice.get(invoice) || []), line]);
    });
    linesByInvoice.forEach((items, invoice) => {
      byInvoice.set(invoice, [...(byInvoice.get(invoice) || []), { order, items, status: linesStatus(order, items) }]);
    });
  });

  return [...byInvoice.entries()].map(([invoice, invoiceOrders]): InvoiceGroup => {
    const lines = invoiceOrders.flatMap(entry => entry.items);
    const open = invoiceOrders.filter(entry => !isFinished(entry.status)).length;
    return {
      invoice,
      status: open > 0 ? 'in_transit' : 'completed',
      orders: invoiceOrders.sort((a, b) => Number(isFinished(a.status)) - Number(isFinished(b.status))),
      open,
      delivered: invoiceOrders.filter(entry => entry.status === 'Delivered').length,
      cancelled: invoiceOrders.filter(entry => entry.status === 'Cancelled').length,
      etd: latest(lines.map(line => line.etd)),
      eta: latest(lines.map(line => line.eta)),
      lastUpdate: Math.max(...invoiceOrders.map(entry => new Date(entry.order.updated_at).getTime() || 0)),
    };
  }).sort((a, b) => b.lastUpdate - a.lastUpdate);
};

const statusLabel = (status: OrderStatus, pt: boolean) => ({
  Pending: pt ? 'Pendente' : 'Pending',
  Processing: pt ? 'Em processamento' : 'Processing',
  Shipped: pt ? 'Em trânsito' : 'In transit',
  Delivered: pt ? 'Entregue' : 'Delivered',
  Cancelled: pt ? 'Cancelado' : 'Cancelled',
}[status]);

const statusDot: Record<OrderStatus, string> = {
  Pending: 'bg-amber-400',
  Processing: 'bg-amber-400',
  Shipped: 'bg-blue-500',
  Delivered: 'bg-emerald-500',
  Cancelled: 'bg-rose-500',
};

export const InvoicesView: React.FC<Props> = ({ orders, language, onOpenOrder }) => {
  const pt = language === 'pt';
  const [allOrders, setAllOrders] = useState<Order[] | null>(null);
  const [statusFilter, setStatusFilter] = useState<InvoiceStatus | 'all'>('in_transit');
  const [search, setSearch] = useState('');
  const [expanded, setExpanded] = useState<Set<string>>(new Set());

  // Invoices must always see every order, independently of the filters on the Orders page;
  // otherwise an invoice could look completed while some of its orders are just filtered out.
  useEffect(() => {
    let active = true;
    apiFetch('/api/orders')
      .then(response => response.ok ? response.json() : null)
      .then(data => { if (active && data) setAllOrders(data.orders || []); })
      .catch(error => console.error('Error fetching invoice orders:', error));
    return () => { active = false; };
  }, [orders]);

  const invoices = useMemo(() => buildInvoices(allOrders || []), [allOrders]);
  const counts = useMemo(() => ({
    in_transit: invoices.filter(group => group.status === 'in_transit').length,
    completed: invoices.filter(group => group.status === 'completed').length,
    all: invoices.length,
  }), [invoices]);

  const visible = useMemo(() => {
    const query = search.trim().toLowerCase();
    return invoices.filter(group => (statusFilter === 'all' || group.status === statusFilter)
      && (!query || group.invoice.toLowerCase().includes(query)
        || group.orders.some(({ order }) => (order.purchase_order || order.id).toLowerCase().includes(query)
          || order.customer_name.toLowerCase().includes(query))));
  }, [invoices, statusFilter, search]);

  const toggle = (invoice: string) => setExpanded(previous => {
    const next = new Set(previous);
    if (next.has(invoice)) next.delete(invoice); else next.add(invoice);
    return next;
  });

  const tabs: [InvoiceStatus | 'all', string][] = [
    ['in_transit', pt ? 'Em trânsito' : 'In transit'],
    ['completed', pt ? 'Concluídas' : 'Completed'],
    ['all', pt ? 'Todas' : 'All'],
  ];

  return <div className="space-y-4">
    <div>
      <h1 className="text-xl font-bold text-slate-900">Invoices</h1>
      <p className="mt-1 text-sm text-slate-500">
        {pt
          ? 'Em trânsito: possui pedidos em aberto. Concluída: todos os pedidos foram entregues ou cancelados.'
          : 'In transit: has open orders. Completed: every order was delivered or cancelled.'}
      </p>
    </div>

    <div className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
      <div className="flex gap-1 rounded-lg border border-slate-200 bg-white p-1">
        {tabs.map(([value, label]) => (
          <button
            key={value}
            type="button"
            onClick={() => setStatusFilter(value)}
            className={`rounded-md px-3 py-1.5 text-xs font-semibold transition-colors ${statusFilter === value ? 'bg-blue-600 text-white' : 'text-slate-600 hover:bg-slate-100'}`}
          >
            {label} <span className={statusFilter === value ? 'text-blue-100' : 'text-slate-400'}>{counts[value]}</span>
          </button>
        ))}
      </div>
      <div className="relative w-full sm:w-72">
        <Search className="absolute left-3 top-1/2 h-4 w-4 -translate-y-1/2 text-slate-400"/>
        <input
          type="text"
          value={search}
          onChange={event => setSearch(event.target.value)}
          placeholder={pt ? 'Buscar invoice, PO ou cliente...' : 'Search invoice, PO or customer...'}
          className="w-full rounded-lg border border-slate-200 bg-white py-2 pl-9 pr-3 text-sm text-slate-800 placeholder:text-slate-400 focus:border-blue-500 focus:outline-none"
        />
      </div>
    </div>

    {allOrders === null && <div className="rounded-xl border border-slate-200 bg-white p-10 text-center text-sm text-slate-500">{pt ? 'Carregando invoices...' : 'Loading invoices...'}</div>}

    <div className="space-y-2">
      {visible.map(group => {
        const isOpen = expanded.has(group.invoice);
        const finished = group.delivered + group.cancelled;
        return <div key={group.invoice} className="overflow-hidden rounded-xl border border-slate-200 bg-white">
          <button type="button" onClick={() => toggle(group.invoice)} className="flex w-full flex-wrap items-center gap-x-6 gap-y-2 px-4 py-3 text-left hover:bg-slate-50">
            <div className="flex min-w-[180px] flex-1 items-center gap-3">
              {isOpen ? <ChevronDown className="h-4 w-4 shrink-0 text-slate-400"/> : <ChevronRight className="h-4 w-4 shrink-0 text-slate-400"/>}
              <span className="font-mono text-sm font-semibold text-slate-900">{group.invoice}</span>
              <span className={`rounded-full px-2 py-0.5 text-[11px] font-semibold ${group.status === 'in_transit' ? 'bg-blue-50 text-blue-700' : 'bg-emerald-50 text-emerald-700'}`}>
                {group.status === 'in_transit' ? (pt ? 'Em trânsito' : 'In transit') : (pt ? 'Concluída' : 'Completed')}
              </span>
            </div>
            <div className="flex flex-wrap items-center gap-x-5 gap-y-1 text-xs text-slate-500">
              <span><strong className="font-semibold text-slate-800">{group.orders.length}</strong> {pt ? 'pedidos' : 'orders'}</span>
              {group.open > 0 && <span><strong className="font-semibold text-blue-700">{group.open}</strong> {pt ? 'em aberto' : 'open'}</span>}
              {group.delivered > 0 && <span><strong className="font-semibold text-emerald-700">{group.delivered}</strong> {pt ? 'entregues' : 'delivered'}</span>}
              {group.cancelled > 0 && <span><strong className="font-semibold text-rose-700">{group.cancelled}</strong> {pt ? 'cancelados' : 'cancelled'}</span>}
              <span>ETD {formatDate(group.etd, pt)}</span>
              <span>ETA {formatDate(group.eta, pt)}</span>
            </div>
            <div className="h-1.5 w-full overflow-hidden rounded-full bg-slate-100 sm:w-24" title={`${finished}/${group.orders.length}`}>
              <div className="h-full rounded-full bg-emerald-500" style={{ width: `${(finished / group.orders.length) * 100}%` }}/>
            </div>
          </button>

          {isOpen && <div className="overflow-x-auto border-t border-slate-100">
            <table className="w-full min-w-[640px] text-left text-xs">
              <thead className="bg-slate-50 text-[11px] font-semibold text-slate-500">
                <tr>
                  <th className="px-4 py-2">PO</th>
                  <th className="px-4 py-2">{pt ? 'Cliente' : 'Customer'}</th>
                  <th className="px-4 py-2">{pt ? 'Produtos' : 'Products'}</th>
                  <th className="px-4 py-2">Status</th>
                  <th className="px-4 py-2">{pt ? 'Entrega' : 'Delivery'}</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-100">
                {group.orders.map(({ order, items, status }) => (
                  <tr key={order.id} onClick={() => onOpenOrder(order)} className="cursor-pointer">
                    <td className="px-4 py-2.5 font-mono font-semibold text-blue-700">{order.purchase_order || order.id}</td>
                    <td className="max-w-[200px] truncate px-4 py-2.5 text-slate-700">{order.customer_name}</td>
                    <td className="max-w-[260px] truncate px-4 py-2.5 text-slate-600" title={items.map(item => item.product_name).join(', ')}>
                      {items.length > 1 ? `${items.length} ${pt ? 'produtos' : 'products'}` : items[0].product_name}
                    </td>
                    <td className="px-4 py-2.5">
                      <span className="inline-flex items-center gap-1.5 text-slate-700"><span className={`h-1.5 w-1.5 rounded-full ${statusDot[status]}`}/>{statusLabel(status, pt)}</span>
                    </td>
                    <td className="px-4 py-2.5 text-slate-500">
                      {order.shipment.actual_delivery_date
                        ? formatDate(order.shipment.actual_delivery_date, pt)
                        : status === 'Cancelled' ? '—' : `${pt ? 'Prev.' : 'Est.'} ${formatDate(order.shipment.estimated_delivery || undefined, pt)}`}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>}
        </div>;
      })}
    </div>

    {allOrders !== null && !visible.length && <div className="rounded-xl border border-dashed border-slate-300 bg-white p-10 text-center text-sm text-slate-500">
      {pt ? 'Nenhuma invoice encontrada.' : 'No invoices found.'}
    </div>}
  </div>;
};
