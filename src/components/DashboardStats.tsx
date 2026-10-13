import React from 'react';
import {
  Package,
  Clock3,
  Clock,
  Truck,
  ReceiptText,
  CheckCircle2,
  XCircle,
  DollarSign,
  ArrowUpRight,
  LucideIcon,
} from 'lucide-react';
import { DashboardStats as StatsType } from '../types';

interface DashboardStatsProps {
  stats: StatsType | null;
  activeStatusFilter: string;
  onSelectStatus: (status: string) => void;
  onOpenDatabricksModal: () => void;
  language?: 'en' | 'pt';
}

type StatCard = {
  id: string;
  label: string;
  value: string;
  description?: string;
  filterValue: string;
  icon: LucideIcon;
  iconClass: string;
  color: string;
  badgeText?: string;
  badgeClass?: string;
  subtitle?: string;
};

export const DashboardStats: React.FC<DashboardStatsProps> = ({
  stats,
  activeStatusFilter,
  onSelectStatus,
  onOpenDatabricksModal,
  language = 'en',
}) => {
  const pt = language === 'pt';
  if (!stats) return null;

  const deliveryRate = stats.total_orders > 0
    ? ((stats.delivered_orders / stats.total_orders) * 100).toFixed(1)
    : '0.0';
  const cancellationRate = stats.total_orders > 0
    ? ((stats.cancelled_orders / stats.total_orders) * 100).toFixed(1)
    : '0.0';
  const revenueBrl = new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(stats.total_sales_brl);

  const statCards: StatCard[] = [
    {
      id: 'stat-total',
      label: pt ? 'Total de pedidos' : 'Total Orders',
      value: stats.total_orders.toLocaleString('pt-BR'),
      description: pt ? 'Pedidos nos filtros atuais' : 'Orders in the current filters',
      filterValue: 'All',
      color: 'text-slate-900',
      icon: Package,
      iconClass: 'bg-indigo-50 text-indigo-600',
      subtitle: pt ? 'Pedidos considerando os filtros atuais' : 'Orders in the current filters',
    },
    {
      id: 'stat-pending',
      label: pt ? 'Pendentes' : 'Pending',
      value: stats.pending_orders.toLocaleString(),
      badgeText: pt ? 'Crítico' : 'Critical',
      badgeClass: 'text-amber-500 font-bold bg-amber-50 px-2 py-0.5 rounded text-xs',
      filterValue: 'Pending',
      color: 'text-slate-900',
      icon: Clock,
      iconClass: 'bg-amber-50 text-amber-600',
      subtitle: pt ? 'Aguardando avanço operacional' : 'Awaiting operational progress',
    },
    {
      id: 'stat-in-transit',
      label: pt ? 'Em trânsito' : 'In Transit',
      value: stats.shipped_orders.toLocaleString(),
      badgeText: pt ? 'Com invoice' : 'With invoice',
      badgeClass: 'text-blue-600 font-bold bg-blue-50 px-2 py-0.5 rounded text-xs',
      filterValue: 'Shipped',
      color: 'text-blue-600',
      icon: Truck,
      iconClass: 'bg-blue-50 text-blue-600',
      subtitle: pt ? 'Pedidos abertos que já possuem invoice' : 'Open orders that already have an invoice',
    },
    {
      id: 'stat-delivered',
      label: pt ? 'Entregues' : 'Delivered',
      value: stats.delivered_orders.toLocaleString(),
      badgeText: pt ? `${deliveryRate} entregues` : `${deliveryRate} Rate`,
      badgeClass: 'text-slate-500 text-xs font-medium',
      filterValue: 'Delivered',
      color: 'text-blue-600',
      icon: CheckCircle2,
      iconClass: 'bg-emerald-50 text-emerald-600',
      subtitle: pt ? 'Pedidos entregues ao cliente' : 'Orders delivered to customers',
    },
    {
      id: 'stat-cancelled',
      label: pt ? 'Cancelados' : 'Cancelled',
      value: stats.cancelled_orders.toLocaleString('pt-BR'),
      description: pt ? `${cancellationRate}% dos pedidos` : `${cancellationRate}% of orders`,
      filterValue: 'Cancelled',
      color: 'text-red-500',
      icon: XCircle,
      iconClass: 'bg-rose-50 text-rose-600',
      subtitle: pt ? 'Pedidos cancelados nos filtros atuais' : 'Cancelled orders in current filters',
    },
    {
      id: 'stat-revenue',
      label: pt ? 'Faturamento (BRL)' : 'Sales Revenue (BRL)',
      value: revenueBrl,
      description: pt ? 'Valor total vendido nos filtros atuais' : 'Total sales in the current filters',
      filterValue: 'All',
      color: 'text-slate-900',
      icon: DollarSign,
      iconClass: 'bg-emerald-50 text-emerald-600',
      subtitle: pt ? 'Valor total gasto pelos clientes' : 'Total amount spent by customers',
    }
  ];

  const databricksSource = stats.databricks_sync_status.table;
  const isDatabricksActive = ![
    'public.orders + public.order_items + public.logistics',
    'synthetic demo dataset',
  ].includes(databricksSource);

  return (
    <div className="space-y-4">
      {/* Sleek KPI Cards Grid */}
      <div className="grid grid-cols-[repeat(auto-fit,minmax(220px,1fr))] gap-4">
        {statCards.map((card) => {
          const Icon = card.icon;
          const isSelected = activeStatusFilter === card.filterValue && card.filterValue !== 'All';
          const CardIcon = card.icon;

          return (
            <button
              key={card.id}
              id={card.id}
              type="button"
              onClick={() => onSelectStatus(card.filterValue)}
              className={`relative min-h-40 min-w-0 overflow-hidden rounded-2xl border bg-white p-5 text-left shadow-sm transition-all duration-300 group ${
                isSelected 
                  ? 'border-blue-500 ring-2 ring-blue-500/20 shadow-md' 
                  : 'border-slate-200/80 hover:border-slate-300 hover:shadow-md'
              }`}
            >
              <div className="mb-4 flex items-start justify-between gap-3">
                <p className="pt-1 text-xs font-bold uppercase tracking-[0.08em] text-slate-500">{card.label}</p>
                <span className={`flex h-10 w-10 shrink-0 items-center justify-center rounded-xl ${card.iconClass}`}><CardIcon className="h-5 w-5" /></span>
              </div>
              <div className="flex min-w-0 flex-col items-start gap-1.5">
                <h3 className={`marketops-kpi-value max-w-full leading-none font-black tracking-tight tabular-nums ${card.id === 'stat-revenue' ? 'whitespace-nowrap text-[clamp(1.3rem,2.2vw,1.85rem)]' : 'break-words text-[clamp(1.55rem,2.6vw,2rem)]'} ${card.color}`}>
                  {card.value}
                </h3>
                <span className={`max-w-full whitespace-normal break-words leading-snug ${card.badgeClass}`}>
                  {card.badgeText}
                </span>
                <p className="mt-1 text-[11px] leading-4 text-slate-500">{card.subtitle}</p>
              </div>

              {isSelected && (
                <span className="absolute inset-x-0 bottom-0 h-1 bg-blue-500" aria-hidden="true" />
              )}
            </button>
          );
        })}
      </div>

      {/* Current source + future Databricks architecture */}
      <div className="bg-white rounded-2xl border border-slate-200/80 p-3.5 px-5 shadow-xs flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 text-xs text-slate-600">
        <div className="flex items-center gap-2.5">
          <div className="w-2.5 h-2.5 rounded-full bg-blue-500" />
          <div>
            <span className="font-semibold text-slate-800">{pt?'Fonte operacional atual:':'Current operational source:'}</span>{' '}
            <code className="font-mono bg-slate-100 text-slate-800 px-1.5 py-0.5 rounded font-semibold text-[11px] border border-slate-200">
              {stats.databricks_sync_status.table}
            </code>
            <span className="ml-2 text-amber-700 font-semibold">{pt?'Databricks: integração futura':'Databricks: future integration'}</span>
          </div>
        </div>
        <div className="flex items-center gap-4 self-end sm:self-center">
          <span className="text-slate-500">
            {pt?'Última atualização:':'Last refresh:'} <span className="font-mono text-slate-700 font-medium">{stats.databricks_sync_status.last_sync}</span>
          </span>
          <button
            id="btn-view-databricks-schema"
            onClick={onOpenDatabricksModal}
            className="inline-flex items-center gap-1 text-xs font-semibold text-blue-600 hover:text-blue-700 hover:underline"
          >
            {pt?'Como integrar':'How to integrate'} <ArrowUpRight className="w-3.5 h-3.5" />
          </button>
        </div>
      </div>
    </div>
  );
};
