import React from 'react';
import { CalendarDays, ChevronRight, FileText, Package, UserRound, Warehouse, type LucideIcon } from 'lucide-react';
import { Order } from '../types';

interface LiveTrackingCardProps {
  order: Order | null;
  onViewFullOrder: (order: Order) => void;
  language?: 'en' | 'pt';
}

const formatDate = (value: string | null | undefined, language: 'en' | 'pt') => {
  if (!value) return language === 'pt' ? 'Não informado' : 'Not available';
  const normalized = value.length === 10 ? `${value}T12:00:00` : value;
  const date = new Date(normalized);
  return Number.isNaN(date.getTime()) ? value : new Intl.DateTimeFormat(language === 'pt' ? 'pt-BR' : 'en-US').format(date);
};

export const LiveTrackingCard: React.FC<LiveTrackingCardProps> = ({ order, onViewFullOrder, language = 'en' }) => {
  const pt = language === 'pt';
  if (!order) {
    return (
      <div className="w-full rounded-2xl border border-slate-800 bg-slate-900 p-6 text-white shadow-xl shadow-slate-200/50">
        <div className="mb-4 flex items-center gap-2">
          <FileText className="h-4 w-4 text-amber-400" />
          <h4 className="text-xs font-bold uppercase tracking-widest text-slate-300">{pt?'Invoices recentes':'Recent Invoices'}</h4>
        </div>
        <p className="text-sm leading-6 text-slate-400">{pt?'Nenhum pedido com invoice nos filtros atuais.':'No invoiced orders match the current filters.'}</p>
      </div>
    );
  }

  const items = order.items?.length ? order.items : [order];
  const invoicedItems = items.filter((item) => Boolean(item.invoice?.trim()));
  const invoices = Array.from(new Set(invoicedItems.map((item) => item.invoice!.trim())));
  const wrNumbers = Array.from(new Set(invoicedItems.map((item) => item.magaya_wr?.trim()).filter(Boolean)));
  const referenceItem = invoicedItems[0] || order;
  const statusStyles = order.status === 'Cancelled'
    ? 'border-rose-400/30 bg-rose-500/15 text-rose-300'
    : order.status === 'Delivered'
      ? 'border-emerald-400/30 bg-emerald-500/15 text-emerald-300'
      : 'border-amber-400/30 bg-amber-500/15 text-amber-300';

  return (
    <div className="flex flex-col rounded-2xl border border-slate-800 bg-slate-900 p-6 text-white shadow-xl shadow-slate-300/30">
      <div className="mb-5 flex items-start justify-between gap-3">
        <div>
          <div className="flex items-center gap-2">
            <span className="h-2 w-2 animate-pulse rounded-full bg-amber-400" />
            <h4 className="text-xs font-bold uppercase tracking-widest text-slate-300">{pt?'Invoice mais recente':'Latest Invoice'}</h4>
          </div>
          <p className="mt-1 text-[11px] text-slate-500">{pt?'Considerando os filtros atuais':'Based on current filters'}</p>
        </div>
        <span className={`rounded-full border px-2 py-1 text-[10px] font-bold uppercase ${statusStyles}`}>{order.status === 'Shipped' ? 'In Transit' : order.status}</span>
      </div>

      <div className="rounded-xl border border-amber-400/20 bg-amber-400/10 p-4">
        <p className="text-[10px] font-bold uppercase tracking-wider text-amber-300">Invoice</p>
        <p className="mt-1 break-words font-mono text-xl font-bold text-white">{invoices.join(', ')}</p>
      </div>

      <div className="mt-5 space-y-3">
        <Info icon={FileText} label={pt?'Ordem de Compra (PO)':'Purchase Order (PO)'} value={order.purchase_order || order.id} detail={`${pt?'Ordem do cliente':'Customer order'}: ${order.customer_order_id || '—'}`} mono />
        <Info icon={UserRound} label={pt?'Cliente':'Customer'} value={order.customer_name || (pt?'Não informado':'Not available')} detail={order.marketplace} />
        <Info icon={Package} label={pt?'Produtos do pedido':'Order Products'} value={`${items.length} ${pt?(items.length===1?'produto':'produtos'):(items.length===1?'product':'products')}`} detail={items.map((item) => item.product_name).join(' • ')} />
      </div>

      <div className="mt-5 grid grid-cols-2 gap-2">
        <Metric icon={CalendarDays} label={pt?'Data da compra':'Purchase Date'} value={formatDate(referenceItem.date_order, pt ? 'pt' : 'en')} />
        <Metric icon={Warehouse} label="WR Date" value={formatDate(referenceItem.wr_date, pt ? 'pt' : 'en')} />
        <Metric icon={CalendarDays} label="ETA" value={formatDate(referenceItem.eta, pt ? 'pt' : 'en')} amber />
        <Metric icon={Warehouse} label="WR Magaya" value={wrNumbers.join(', ') || (pt?'Não informado':'Not available')} amber />
      </div>

      <button onClick={() => onViewFullOrder(order)} className="mt-5 flex w-full items-center justify-center gap-1.5 rounded-lg bg-blue-600 px-3 py-2.5 text-xs font-semibold text-white shadow-sm transition-colors hover:bg-blue-700">
        <span>{pt?'Ver detalhes completos':'View Full Details'}</span>
        <ChevronRight className="h-3.5 w-3.5" />
      </button>
    </div>
  );
};

const Info = ({ icon: Icon, label, value, detail, mono = false }: { icon: LucideIcon; label: string; value: string; detail: string; mono?: boolean }) => (
  <div className="flex items-start gap-3">
    <Icon className="mt-0.5 h-4 w-4 shrink-0 text-blue-400" />
    <div className="min-w-0">
      <p className="text-[10px] font-bold uppercase tracking-wider text-slate-500">{label}</p>
      <p className={`truncate text-sm font-semibold text-slate-100 ${mono ? 'font-mono' : ''}`}>{value}</p>
      <p className="line-clamp-2 text-xs text-slate-400">{detail}</p>
    </div>
  </div>
);

const Metric = ({ icon: Icon, label, value, amber = false }: { icon: LucideIcon; label: string; value: string; amber?: boolean }) => (
  <div className="rounded-lg border border-slate-700 bg-slate-800/70 p-3">
    <Icon className={`mb-2 h-4 w-4 ${amber ? 'text-amber-400' : 'text-blue-400'}`} />
    <p className="text-[9px] font-bold uppercase text-slate-500">{label}</p>
    <p className="mt-0.5 break-words text-xs font-semibold text-slate-200">{value}</p>
  </div>
);
