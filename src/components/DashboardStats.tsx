import React from 'react';
import {
  Package,
  Clock,
  Truck,
  CheckCircle2,
  XCircle,
  DollarSign,
  LucideIcon,
} from 'lucide-react';
import { DashboardStats as StatsType } from '../types';

interface DashboardStatsProps {
  stats: StatsType | null;
  activeStatusFilter: string;
  onSelectStatus: (status: string) => void;
  language?: 'en' | 'pt';
}

type StatCard = {
  id: string;
  label: string;
  value: string;
  hint?: string;
  filterValue: string;
  icon: LucideIcon;
  accent: string;
};

export const DashboardStats: React.FC<DashboardStatsProps> = ({
  stats,
  activeStatusFilter,
  onSelectStatus,
  language = 'en',
}) => {
  const pt = language === 'pt';
  if (!stats) return null;

  const percent = (value: number) => stats.total_orders > 0
    ? `${((value / stats.total_orders) * 100).toFixed(1)}%`
    : '0%';
  const revenueBrl = new Intl.NumberFormat('pt-BR', {
    style: 'currency',
    currency: 'BRL',
    minimumFractionDigits: 2,
    maximumFractionDigits: 2,
  }).format(stats.total_sales_brl);

  const statCards: StatCard[] = [
    { id: 'stat-total', label: pt ? 'Pedidos' : 'Orders', value: stats.total_orders.toLocaleString('pt-BR'), filterValue: 'All', icon: Package, accent: 'text-slate-500' },
    { id: 'stat-pending', label: pt ? 'Pendentes' : 'Pending', value: stats.pending_orders.toLocaleString('pt-BR'), hint: percent(stats.pending_orders), filterValue: 'Pending', icon: Clock, accent: 'text-amber-500' },
    { id: 'stat-in-transit', label: pt ? 'Em trânsito' : 'In transit', value: stats.shipped_orders.toLocaleString('pt-BR'), hint: percent(stats.shipped_orders), filterValue: 'Shipped', icon: Truck, accent: 'text-blue-500' },
    { id: 'stat-delivered', label: pt ? 'Entregues' : 'Delivered', value: stats.delivered_orders.toLocaleString('pt-BR'), hint: percent(stats.delivered_orders), filterValue: 'Delivered', icon: CheckCircle2, accent: 'text-emerald-500' },
    { id: 'stat-cancelled', label: pt ? 'Cancelados' : 'Cancelled', value: stats.cancelled_orders.toLocaleString('pt-BR'), hint: percent(stats.cancelled_orders), filterValue: 'Cancelled', icon: XCircle, accent: 'text-rose-500' },
    { id: 'stat-revenue', label: pt ? 'Vendas (BRL)' : 'Sales (BRL)', value: revenueBrl, filterValue: 'All', icon: DollarSign, accent: 'text-slate-500' },
  ];

  return (
    <div className="grid grid-cols-2 gap-3 md:grid-cols-3 xl:grid-cols-6">
      {statCards.map((card) => {
        const Icon = card.icon;
        const isSelected = activeStatusFilter === card.filterValue && card.filterValue !== 'All';

        return (
          <button
            key={card.id}
            id={card.id}
            type="button"
            onClick={() => onSelectStatus(card.filterValue)}
            className={`min-w-0 rounded-xl border bg-white px-4 py-3.5 text-left transition-colors ${
              isSelected ? 'border-blue-500 ring-1 ring-blue-500' : 'border-slate-200 hover:border-slate-300'
            }`}
          >
            <div className="flex items-center gap-2 text-xs font-medium text-slate-500">
              <Icon className={`h-4 w-4 ${card.accent}`} />
              <span className="truncate">{card.label}</span>
            </div>
            <div className="mt-2 flex items-baseline gap-2">
              <span className={`marketops-kpi-value font-bold tracking-tight tabular-nums text-slate-900 ${card.id === 'stat-revenue' ? 'text-lg whitespace-nowrap' : 'text-2xl'}`}>
                {card.value}
              </span>
              {card.hint && <span className="text-xs text-slate-400">{card.hint}</span>}
            </div>
          </button>
        );
      })}
    </div>
  );
};
