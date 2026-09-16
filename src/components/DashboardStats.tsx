import React from 'react';
import {
  Package,
  Clock3,
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
  description: string;
  filterValue: string;
  icon: LucideIcon;
  iconClass: string;
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
      icon: Package,
      iconClass: 'bg-indigo-50 text-indigo-600 ring-indigo-100',
    },
    {
      id: 'stat-pending',
      label: pt ? 'Pendentes' : 'Pending',
      value: stats.pending_orders.toLocaleString('pt-BR'),
      description: pt ? 'Aguardando avanço operacional' : 'Waiting for operational progress',
      filterValue: 'Pending',
      icon: Clock3,
      iconClass: 'bg-amber-50 text-amber-600 ring-amber-100',
    },
    {
      id: 'stat-in-transit',
      label: pt ? 'Em trânsito' : 'In Transit',
      value: stats.shipped_orders.toLocaleString('pt-BR'),
      description: pt ? 'Com invoice e ainda não entregues' : 'Invoiced and not yet delivered',
      filterValue: 'Shipped',
      icon: ReceiptText,
      iconClass: 'bg-blue-50 text-blue-600 ring-blue-100',
    },
    {
      id: 'stat-delivered',
      label: pt ? 'Entregues' : 'Delivered',
      value: stats.delivered_orders.toLocaleString('pt-BR'),
      description: pt ? `${deliveryRate}% dos pedidos` : `${deliveryRate}% of orders`,
      filterValue: 'Delivered',
      icon: CheckCircle2,
      iconClass: 'bg-emerald-50 text-emerald-600 ring-emerald-100',
    },
    {
      id: 'stat-cancelled',
      label: pt ? 'Cancelados' : 'Cancelled',
      value: stats.cancelled_orders.toLocaleString('pt-BR'),
      description: pt ? `${cancellationRate}% dos pedidos` : `${cancellationRate}% of orders`,
      filterValue: 'Cancelled',
      icon: XCircle,
      iconClass: 'bg-rose-50 text-rose-600 ring-rose-100',
    },
    {
      id: 'stat-revenue',
      label: pt ? 'Faturamento (BRL)' : 'Sales Revenue (BRL)',
      value: revenueBrl,
      description: pt ? 'Valor total vendido nos filtros atuais' : 'Total sales in the current filters',
      filterValue: 'All',
      icon: DollarSign,
      iconClass: 'bg-emerald-50 text-emerald-600 ring-emerald-100',
    },
  ];

  return (
    <div className="space-y-4">
      <div className="grid grid-cols-1 gap-4 sm:grid-cols-2 xl:grid-cols-3">
        {statCards.map((card) => {
          const Icon = card.icon;
          const isSelected = activeStatusFilter === card.filterValue && card.filterValue !== 'All';
          const isRevenue = card.id === 'stat-revenue';

          return (
            <button
              key={card.id}
              id={card.id}
              type="button"
              onClick={() => onSelectStatus(card.filterValue)}
              className={`group relative min-w-0 overflow-hidden rounded-2xl border bg-white p-5 text-left shadow-sm transition-all duration-200 hover:-translate-y-0.5 hover:shadow-md sm:p-6 ${
                isSelected
                  ? 'border-blue-400 ring-2 ring-blue-500/15 shadow-md'
                  : 'border-slate-200/90 hover:border-slate-300'
              }`}
            >
              <div className="flex min-w-0 items-start justify-between gap-4">
                <div className="min-w-0 flex-1">
                  <p className="text-[11px] font-bold uppercase tracking-[0.08em] text-slate-500 sm:text-xs">
                    {card.label}
                  </p>
                  <p
                    className={`mt-4 max-w-full font-bold tracking-tight text-slate-950 tabular-nums ${
                      isRevenue
                        ? 'whitespace-nowrap text-[clamp(1.55rem,2.4vw,2.15rem)]'
                        : 'text-[clamp(2rem,3vw,2.5rem)] leading-none'
                    }`}
                  >
                    {card.value}
                  </p>
                  <p className="mt-2 text-xs font-medium leading-5 text-slate-500 sm:text-sm">
                    {card.description}
                  </p>
                </div>

                <span className={`flex h-11 w-11 shrink-0 items-center justify-center rounded-xl ring-1 ${card.iconClass}`}>
                  <Icon className="h-5 w-5" strokeWidth={2} />
                </span>
              </div>

              {isSelected && (
                <span className="absolute inset-x-0 bottom-0 h-1 bg-blue-500" aria-hidden="true" />
              )}
            </button>
          );
        })}
      </div>

      <div className="flex flex-col items-start justify-between gap-3 rounded-2xl border border-slate-200/80 bg-white px-5 py-3.5 text-xs text-slate-600 shadow-xs sm:flex-row sm:items-center">
        <div className="flex items-center gap-2.5">
          <div className="h-2.5 w-2.5 rounded-full bg-blue-500" />
          <div>
            <span className="font-semibold text-slate-800">{pt ? 'Fonte operacional atual:' : 'Current operational source:'}</span>{' '}
            <code className="rounded border border-slate-200 bg-slate-100 px-1.5 py-0.5 font-mono text-[11px] font-semibold text-slate-800">
              {stats.databricks_sync_status.table}
            </code>
            <span className={`ml-2 font-semibold ${stats.databricks_sync_status.table.includes('orders_live') ? 'text-emerald-700' : 'text-amber-700'}`}>
              {stats.databricks_sync_status.table.includes('orders_live')
                ? (pt ? 'Databricks: sincronização ativa' : 'Databricks: live sync')
                : (pt ? 'Databricks: aguardando configuração' : 'Databricks: awaiting setup')}
            </span>
          </div>
        </div>
        <div className="flex items-center gap-4 self-end sm:self-center">
          <span className="text-slate-500">
            {pt ? 'Última atualização:' : 'Last refresh:'}{' '}
            <span className="font-mono font-medium text-slate-700">{stats.databricks_sync_status.last_sync}</span>
          </span>
          <button
            id="btn-view-databricks-schema"
            onClick={onOpenDatabricksModal}
            className="inline-flex items-center gap-1 text-xs font-semibold text-blue-600 hover:text-blue-700 hover:underline"
          >
            {pt ? 'Como integrar' : 'How to integrate'} <ArrowUpRight className="h-3.5 w-3.5" />
          </button>
        </div>
      </div>
    </div>
  );
};
