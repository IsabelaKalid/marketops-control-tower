import React from 'react';
import { Search, Calendar, X, RotateCcw, Download } from 'lucide-react';
import { OrderFilters } from '../types';

interface OrderFiltersBarProps {
  filters: OrderFilters;
  onChangeFilters: (filters: Partial<OrderFilters>) => void;
  onResetFilters: () => void;
  totalFiltered: number;
  totalOrders: number;
  availableSellers?: string[];
  onExport: () => void;
  language?: 'en' | 'pt';
}

export const OrderFiltersBar: React.FC<OrderFiltersBarProps> = ({
  filters,
  onChangeFilters,
  onResetFilters,
  totalFiltered,
  totalOrders,
  availableSellers,
  onExport,
  language = 'en',
}) => {
  const pt = language === 'pt';
  const statusOptions = ['All', 'Pending', 'Shipped', 'Delivered', 'Cancelled'];
  const operationalOptions = [
    ['All', pt ? 'Todas as situações' : 'All situations'],
    ['in_transit_invoiced', pt ? 'Em trânsito (faturado, não entregue)' : 'In Transit (invoiced, not delivered)'],
    ['not_purchased', pt ? 'Atenção: compra não confirmada' : 'Attention: purchase not confirmed'],
    ['missing_wr', pt ? 'Sem WR após 10+ dias da compra' : 'No WR record 10+ days after purchase'],
    ['wr_no_eta_invoice_10', pt ? 'Sem ETA ou Invoice (10+ dias na warehouse)' : 'No ETA or Invoice (stalled 10+ days at warehouse)'],
  ];
  
  // Only sellers present in the currently loaded order dataset.
  const sellerOptions = React.useMemo(() => {
    const unique = new Map<string, string>();
    (availableSellers || []).forEach((seller) => {
      const value = seller?.trim();
      if (value && value.toLowerCase() !== 'all') unique.set(value.toLocaleLowerCase(), value);
    });
    return ['All', ...Array.from(unique.values()).sort((a, b) => a.localeCompare(b))];
  }, [availableSellers]);

  const handleQuickDate = (daysAgo: number | 'today' | 'all') => {
    if (daysAgo === 'all') {
      onChangeFilters({ date_from: '', date_to: '' });
      return;
    }
    const today = new Date().toISOString().split('T')[0];
    if (daysAgo === 'today') {
      onChangeFilters({ date_from: today, date_to: today });
      return;
    }
    const past = new Date();
    past.setDate(past.getDate() - daysAgo);
    onChangeFilters({ date_from: past.toISOString().split('T')[0], date_to: today });
  };

  const hasActiveFilters = Boolean(
    filters.search ||
    filters.status !== 'All' ||
    filters.marketplace !== 'All' ||
    filters.operational !== 'All' ||
    filters.date_from ||
    filters.date_to
  );

  return (
    <div className="bg-white rounded-2xl border border-slate-200 p-4 space-y-3.5 shadow-sm">
      {/* Top Search & Marketplaces Row */}
      <div className="flex flex-col lg:flex-row items-stretch lg:items-center justify-between gap-3">
        {/* Main Search Input */}
        <div className="relative flex-1">
          <Search className="w-4 h-4 text-slate-400 absolute left-3 top-1/2 -translate-y-1/2" />
          <input
            id="input-search-orders"
            type="text"
            placeholder={pt ? 'Buscar por ordem de compra, ordem do cliente, SKU ou ASIN...' : 'Search by purchase order, customer order, SKU or ASIN...'}
            value={filters.search}
            onChange={(e) => onChangeFilters({ search: e.target.value })}
            className="w-full pl-9 pr-8 py-2 bg-slate-50 hover:bg-slate-100/70 focus:bg-white border border-slate-200 focus:border-blue-500 rounded-xl text-sm text-slate-800 placeholder:text-slate-400 focus:outline-none transition-colors"
          />
          {filters.search && (
            <button
              onClick={() => onChangeFilters({ search: '' })}
              className="absolute right-2.5 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
            >
              <X className="w-4 h-4" />
            </button>
          )}
        </div>

        {/* Seller / Marketplace Filter */}
        <div className="flex items-center gap-2">
          <label htmlFor="select-marketplace" className="text-xs font-semibold text-slate-500 whitespace-nowrap uppercase tracking-wider">
            Seller:
          </label>
          <select
            id="select-marketplace"
            value={filters.marketplace}
            onChange={(e) => onChangeFilters({ marketplace: e.target.value })}
            className="text-xs font-medium bg-slate-50 hover:bg-slate-100/70 border border-slate-200 text-slate-800 rounded-xl px-3 py-2 focus:outline-none focus:border-blue-500 cursor-pointer transition-colors shadow-2xs"
          >
            {sellerOptions.map((s) => (
              <option key={s} value={s}>
                {s === 'All' ? (pt ? 'Todos os sellers' : 'All Sellers') : s}
              </option>
            ))}
          </select>
        </div>
      </div>

      {/* Middle Status Tabs & Date Range Filter */}
      <div className="flex flex-col md:flex-row md:items-center justify-between gap-3 pt-3 border-t border-slate-100">
        {/* Status Pills */}
        <div className="flex items-center gap-1.5 overflow-x-auto pb-1 md:pb-0">
          <span className="text-xs font-semibold text-slate-400 mr-1 hidden sm:inline uppercase tracking-wider">Status:</span>
          {statusOptions.map((st) => {
            const isSelected = filters.status === st;
            return (
              <button
                key={st}
                id={`filter-status-${st.toLowerCase()}`}
                onClick={() => onChangeFilters({ status: st })}
                className={`px-3 py-1.5 rounded-lg text-xs font-semibold transition-colors whitespace-nowrap ${
                  isSelected
                    ? 'bg-blue-600 text-white shadow-xs'
                    : 'bg-slate-100 text-slate-600 hover:bg-slate-200 hover:text-slate-900'
                }`}
              >
                {pt ? ({All:'Todos',Pending:'Pendente',Shipped:'Em trânsito',Delivered:'Entregue',Cancelled:'Cancelado'} as Record<string,string>)[st] : (st === 'Shipped' ? 'In Transit' : st)}
              </button>
            );
          })}
        </div>

        {/* Specific Date Range Controls */}
        <div className="flex flex-wrap items-center gap-2 text-xs">
          <div className="flex items-center gap-1.5 text-slate-500">
            <Calendar className="w-3.5 h-3.5 text-slate-400" />
            <span className="font-semibold uppercase tracking-wider text-[11px]">{pt?'Datas:':'Dates:'}</span>
          </div>

          <input
            id="input-date-from"
            type="date"
            value={filters.date_from}
            onChange={(e) => onChangeFilters({ date_from: e.target.value })}
            title="Date from"
            className="px-2.5 py-1 bg-slate-50 border border-slate-200 rounded-lg text-xs text-slate-800 focus:outline-none focus:border-blue-500"
          />
          <span className="text-slate-400">{pt?'até':'to'}</span>
          <input
            id="input-date-to"
            type="date"
            value={filters.date_to}
            onChange={(e) => onChangeFilters({ date_to: e.target.value })}
            title="Date to"
            className="px-2.5 py-1 bg-slate-50 border border-slate-200 rounded-lg text-xs text-slate-800 focus:outline-none focus:border-blue-500"
          />

          {/* Quick date presets */}
          <div className="flex items-center gap-1">
            <button
              onClick={() => handleQuickDate('today')}
              className="px-2 py-1 bg-slate-100 hover:bg-slate-200 rounded-lg text-[11px] text-slate-600 font-medium transition-colors"
            >
              {pt?'Hoje':'Today'}
            </button>
            <button
              onClick={() => handleQuickDate(7)}
              className="px-2 py-1 bg-slate-100 hover:bg-slate-200 rounded-lg text-[11px] text-slate-600 font-medium transition-colors"
            >
              {pt?'Últimos 7d':'Last 7d'}
            </button>
            <button
              onClick={() => handleQuickDate(30)}
              className="px-2 py-1 bg-slate-100 hover:bg-slate-200 rounded-lg text-[11px] text-slate-600 font-medium transition-colors"
            >
              {pt?'Últimos 30d':'Last 30d'}
            </button>
          </div>

          {/* Reset Filters */}
          {hasActiveFilters && (
            <button
              id="btn-clear-filters"
              onClick={onResetFilters}
              className="inline-flex items-center gap-1 text-xs text-red-600 hover:text-red-700 font-medium ml-auto sm:ml-2 hover:underline"
            >
              <RotateCcw className="w-3 h-3" />
              <span>{pt ? 'Limpar' : 'Clear'}</span>
            </button>
          )}
        </div>
      </div>

      <div className="flex flex-col lg:flex-row lg:items-end lg:justify-between gap-3 pt-3 border-t border-slate-100">
        <div className="flex-1">
          <label htmlFor="select-operational-filter" className="mb-1 block text-xs font-semibold text-slate-500 uppercase tracking-wider">
            {pt ? 'Acompanhamento operacional' : 'Operational Tracking'}
          </label>
          <select
            id="select-operational-filter"
            value={filters.operational}
            onChange={(e) => onChangeFilters({ operational: e.target.value })}
            className="w-full lg:max-w-md text-xs font-medium bg-amber-50 border border-amber-200 text-slate-800 rounded-xl px-3 py-2 focus:outline-none focus:border-amber-500 cursor-pointer"
          >
            {operationalOptions.map(([value, label]) => <option key={value} value={value}>{label}</option>)}
          </select>
        </div>

        <div className="w-full lg:w-72">
          <label htmlFor="select-order-sort" className="mb-1 block text-xs font-semibold text-slate-500 uppercase tracking-wider">
            {pt ? 'Organizar pedidos' : 'Sort Orders'}
          </label>
          <select
            id="select-order-sort"
            value={`${filters.sort_by}:${filters.sort_direction}`}
            onChange={(e) => {
              const [sort_by, sort_direction] = e.target.value.split(':');
              onChangeFilters({ sort_by, sort_direction });
            }}
            className="w-full rounded-xl border border-blue-200 bg-blue-50 px-3 py-2 text-xs font-medium text-slate-800 focus:border-blue-500 focus:outline-none cursor-pointer"
          >
            <option value="updated_at:desc">{pt ? 'Atualizados recentemente' : 'Recently updated'}</option>
            <option value="date_order:desc">{pt ? 'Compras mais recentes' : 'Newest purchase date'}</option>
            <option value="date_order:asc">{pt ? 'Compras mais antigas' : 'Oldest purchase date'}</option>
          </select>
        </div>
      </div>

      {/* Filter Results Counter */}
      <div className="flex items-center justify-between text-xs text-slate-400 pt-1">
        <span>
          {pt ? 'Exibindo' : 'Showing'} <strong className="text-slate-800 font-semibold">{totalFiltered}</strong> {pt ? 'de' : 'of'}{' '}
          <span className="text-slate-600">{totalOrders}</span> {pt ? 'pedidos' : 'marketplace orders'}
        </span>
        <div className="flex items-center gap-2">
          {hasActiveFilters && (
            <span className="text-blue-600 font-semibold bg-blue-50 px-2 py-0.5 rounded-full border border-blue-100 text-[11px]">
              {pt ? 'Filtros ativos' : 'Active filters'}
            </span>
          )}
          <button
            id="btn-export-orders"
            type="button"
            onClick={onExport}
            disabled={totalFiltered === 0}
            className="inline-flex items-center gap-1.5 px-3 py-1.5 rounded-lg bg-emerald-600 hover:bg-emerald-700 text-white font-semibold disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
            title={hasActiveFilters ? 'Baixar os pedidos filtrados' : 'Baixar todos os pedidos'}
          >
            <Download className="w-3.5 h-3.5" />
            <span>{pt ? 'Baixar Excel' : 'Download Excel'} ({totalFiltered})</span>
          </button>
        </div>
      </div>
    </div>
  );
};
