import React from 'react';
import { 
  Package, 
  Clock, 
  Truck, 
  CheckCircle2, 
  XCircle, 
  DollarSign,
  Database,
  ArrowUpRight
} from 'lucide-react';
import { DashboardStats as StatsType } from '../types';

interface DashboardStatsProps {
  stats: StatsType | null;
  activeStatusFilter: string;
  onSelectStatus: (status: string) => void;
  onOpenDatabricksModal: () => void;
  language?: 'en' | 'pt';
}

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
    ? `${((stats.delivered_orders / stats.total_orders) * 100).toFixed(1)}%` 
    : '100%';

  const statCards = [
    {
      id: 'stat-total',
      label: pt ? 'Total de pedidos' : 'Total Orders',
      value: stats.total_orders.toLocaleString(),
      badgeText: '+12%',
      badgeClass: 'text-green-500 font-bold bg-green-50 px-2 py-0.5 rounded text-xs',
      filterValue: 'All',
      color: 'text-slate-900',
    },
    {
      id: 'stat-pending',
      label: pt ? 'Pendentes' : 'Pending',
      value: stats.pending_orders.toLocaleString(),
      badgeText: 'Critical',
      badgeClass: 'text-amber-500 font-bold bg-amber-50 px-2 py-0.5 rounded text-xs',
      filterValue: 'Pending',
      color: 'text-slate-900',
    },
    {
      id: 'stat-in-transit',
      label: pt ? 'Em trânsito' : 'In Transit',
      value: stats.shipped_orders.toLocaleString(),
      badgeText: 'Invoiced',
      badgeClass: 'text-blue-600 font-bold bg-blue-50 px-2 py-0.5 rounded text-xs',
      filterValue: 'Shipped',
      color: 'text-blue-600',
    },
    {
      id: 'stat-delivered',
      label: pt ? 'Entregues' : 'Delivered',
      value: stats.delivered_orders.toLocaleString(),
      badgeText: `${deliveryRate} Rate`,
      badgeClass: 'text-slate-500 text-xs font-medium',
      filterValue: 'Delivered',
      color: 'text-blue-600',
    },
    {
      id: 'stat-cancelled',
      label: pt ? 'Cancelados' : 'Cancelled',
      value: stats.cancelled_orders.toLocaleString(),
      badgeText: '-4%',
      badgeClass: 'text-red-500 font-bold bg-red-50 px-2 py-0.5 rounded text-xs',
      filterValue: 'Cancelled',
      color: 'text-red-500',
    },
    {
      id: 'stat-revenue',
      label: pt ? 'Faturamento (BRL)' : 'Sales Revenue (BRL)',
      value: `R$ ${stats.total_sales_brl.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 })}`,
      badgeText: pt ? 'Vendas filtradas' : 'Filtered Sales',
      badgeClass: 'text-slate-500 text-xs font-medium',
      filterValue: 'All',
      color: 'text-slate-900',
    }
  ];

  return (
    <div className="space-y-4">
      {/* Sleek KPI Cards Grid */}
      <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-3 2xl:grid-cols-6 gap-4 sm:gap-5">
        {statCards.map((card) => {
          const isSelected = activeStatusFilter === card.filterValue && card.filterValue !== 'All';

          return (
            <button
              key={card.id}
              id={card.id}
              onClick={() => onSelectStatus(card.filterValue)}
              className={`bg-white p-5 sm:p-6 min-h-32 min-w-0 overflow-hidden rounded-2xl shadow-sm border transition-all text-left group ${
                isSelected 
                  ? 'border-blue-500 ring-2 ring-blue-500/20 shadow-md' 
                  : 'border-slate-200/80 hover:border-slate-300 hover:shadow-md'
              }`}
            >
              <p className="text-xs font-bold text-slate-400 uppercase tracking-wider mb-2 whitespace-normal break-words leading-snug">
                {card.label}
              </p>
              <div className="flex min-w-0 flex-col items-start gap-1.5">
                <h3 className={`max-w-full text-[clamp(1.55rem,2.2vw,2.25rem)] leading-tight font-bold tracking-tight break-words ${card.color}`}>
                  {card.value}
                </h3>
                <span className={`max-w-full whitespace-normal break-words leading-snug ${card.badgeClass}`}>
                  {card.badgeText}
                </span>
              </div>
            </button>
          );
        })}
      </div>

      {/* Databricks Telemetry Banner */}
      <div className="bg-white rounded-2xl border border-slate-200/80 p-3.5 px-5 shadow-xs flex flex-col sm:flex-row items-start sm:items-center justify-between gap-3 text-xs text-slate-600">
        <div className="flex items-center gap-2.5">
          <div className="w-2.5 h-2.5 rounded-full bg-green-500 animate-pulse" />
          <div>
            <span className="font-semibold text-slate-800">{pt?'Databricks conectado:':'Databricks Connected:'}</span>{' '}
            {pt?'Atualizações logísticas da tabela Delta Lake':'Streaming logistics updates from Delta Lake table'}{' '}
            <code className="font-mono bg-slate-100 text-slate-800 px-1.5 py-0.5 rounded font-semibold text-[11px] border border-slate-200">
              {stats.databricks_sync_status.table}
            </code>
          </div>
        </div>
        <div className="flex items-center gap-4 self-end sm:self-center">
          <span className="text-slate-400">
            {pt?'Última sincronização:':'Last Delta Sync:'} <span className="font-mono text-slate-700 font-medium">{stats.databricks_sync_status.last_sync}</span>
          </span>
          <button
            id="btn-view-databricks-schema"
            onClick={onOpenDatabricksModal}
            className="text-blue-600 hover:text-blue-700 font-semibold inline-flex items-center gap-1 hover:underline text-xs"
          >
            {pt?'Detalhes do schema':'Schema Details'} <ArrowUpRight className="w-3.5 h-3.5" />
          </button>
        </div>
      </div>
    </div>
  );
};
