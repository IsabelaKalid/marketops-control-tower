import React, { useMemo } from 'react';
import { CalendarDays, FileText, Package, Truck } from 'lucide-react';
import type { Order } from '../types';

interface Props {
  orders: Order[];
  language: 'en' | 'pt';
  onOpenOrder: (order: Order) => void;
}

const dateValue = (value?: string) => value ? new Date(value).getTime() || 0 : 0;
const formatDate = (value: string | undefined, pt: boolean) => value
  ? new Intl.DateTimeFormat(pt ? 'pt-BR' : 'en-US').format(new Date(`${value.slice(0, 10)}T12:00:00`))
  : '—';

export const InvoicesView: React.FC<Props> = ({ orders, language, onOpenOrder }) => {
  const pt = language === 'pt';
  const invoiceOrders = useMemo(() => orders
    .filter(order => order.status === 'Shipped' && (order.items?.length ? order.items : [order]).some(item => Boolean(item.invoice?.trim())))
    .slice()
    .sort((a, b) => Math.max(dateValue(b.billing_date), dateValue(b.entry_cd_date), dateValue(b.eta), dateValue(b.etd), dateValue(b.updated_at))
      - Math.max(dateValue(a.billing_date), dateValue(a.entry_cd_date), dateValue(a.eta), dateValue(a.etd), dateValue(a.updated_at))), [orders]);

  return <div className="space-y-5">
    <div>
      <h1 className="text-2xl font-bold text-slate-900">{pt ? 'Invoices recentes em trânsito' : 'Recent In-Transit Invoices'}</h1>
      <p className="mt-1 text-sm text-slate-500">{pt ? 'Todas as invoices ainda não entregues, ordenadas pela atualização logística mais recente.' : 'All undelivered invoices ordered by their latest logistics update.'}</p>
    </div>
    <div className="grid grid-cols-1 gap-4 xl:grid-cols-2">
      {invoiceOrders.map(order => {
        const items = order.items?.length ? order.items : [order];
        const invoices = [...new Set(items.map(item => item.invoice).filter(Boolean))].join(', ');
        return <button key={order.id} onClick={() => onOpenOrder(order)} className="rounded-2xl border border-slate-200 bg-white p-5 text-left shadow-sm transition hover:-translate-y-0.5 hover:border-blue-300 hover:shadow-lg">
          <div className="flex items-start justify-between gap-3">
            <div><p className="text-[10px] font-bold uppercase tracking-wider text-amber-600">Invoice</p><p className="font-mono text-lg font-bold text-slate-900">{invoices}</p></div>
            <span className="rounded-full border border-blue-200 bg-blue-50 px-2.5 py-1 text-[10px] font-bold text-blue-700">{order.billing_date ? (pt ? 'Faturado' : 'Invoiced') : (pt ? 'Em trânsito' : 'In transit')}</span>
          </div>
          <div className="mt-4 grid grid-cols-2 gap-3 text-xs">
            <Info icon={Package} label="PO" value={order.purchase_order || order.id}/>
            <Info icon={Truck} label={pt ? 'Rastreio' : 'Tracking'} value={order.shipment.tracking_number || '—'}/>
            <Info icon={CalendarDays} label="ETD" value={formatDate(order.etd, pt)}/>
            <Info icon={CalendarDays} label="ETA Manaus" value={formatDate(order.eta, pt)}/>
            <Info icon={FileText} label={pt ? 'Entrada CD' : 'DC arrival'} value={formatDate(order.entry_cd_date, pt)}/>
            <Info icon={FileText} label={pt ? 'Faturamento' : 'Billing'} value={formatDate(order.billing_date, pt)}/>
          </div>
          <p className="mt-4 truncate text-xs text-slate-500">{order.customer_name} · {items.length} {pt ? 'item(ns)' : 'item(s)'}</p>
        </button>;
      })}
    </div>
    {!invoiceOrders.length && <div className="rounded-2xl border border-dashed border-slate-300 bg-white p-12 text-center text-sm text-slate-500">{pt ? 'Nenhuma invoice em trânsito encontrada.' : 'No in-transit invoices found.'}</div>}
  </div>;
};

const Info = ({ icon: Icon, label, value }: { icon: typeof FileText; label: string; value: string }) => <div className="rounded-xl bg-slate-50 p-3"><div className="flex items-center gap-1.5 text-slate-500"><Icon className="h-3.5 w-3.5"/><span className="text-[9px] font-bold uppercase">{label}</span></div><p className="mt-1 truncate font-semibold text-slate-800">{value}</p></div>;
