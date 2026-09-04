import React from 'react';
import { 
  LayoutDashboard, 
  Package, 
  FileText, 
  Database, 
  Bell, 
  Plus, 
  CheckCircle2, 
  X,
  UploadCloud
} from 'lucide-react';
import { OrderStatus } from '../types';

interface SidebarProps {
  currentTab?: string;
  activeTab?: string;
  onSelectTab: (tab: any) => void;
  onOpenNewOrder: () => void;
  onOpenBatchImport?: () => void;
  onOpenAlerts: () => void;
  onOpenDatabricksModal: () => void;
  unreadAlertsCount: number;
  mobileOpen?: boolean;
  isMobileOpen?: boolean;
  onCloseMobile: () => void;
  activeStatusFilter?: string;
  onSelectStatusFilter?: (status: string) => void;
  language?: 'en' | 'pt';
}

export const Sidebar: React.FC<SidebarProps> = ({
  currentTab,
  activeTab,
  onSelectTab,
  onOpenNewOrder,
  onOpenBatchImport,
  onOpenAlerts,
  onOpenDatabricksModal,
  unreadAlertsCount,
  mobileOpen,
  isMobileOpen,
  onCloseMobile,
  activeStatusFilter = 'All',
  onSelectStatusFilter = (_status?: string) => {},
  language = 'en',
}) => {
  const pt = language === 'pt';
  const selectedTab = currentTab || activeTab || 'dashboard';
  const isMenuOpen = mobileOpen ?? isMobileOpen ?? false;
  return (
    <>
      {/* Mobile Backdrop */}
      {isMenuOpen && (
        <div 
          className="fixed inset-0 bg-slate-900/60 backdrop-blur-xs z-40 md:hidden"
          onClick={onCloseMobile}
        />
      )}

      {/* Sidebar Container */}
      <aside
        className={`fixed md:sticky top-0 left-0 z-40 h-screen w-64 bg-slate-900 text-slate-300 flex flex-col border-r border-slate-800 transition-transform duration-300 ease-in-out shrink-0 ${
          isMenuOpen ? 'translate-x-0' : '-translate-x-full md:translate-x-0'
        }`}
      >
        {/* Brand Header */}
        <div className="p-6 flex items-center justify-between">
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center text-white font-bold shadow-md shadow-blue-500/30">
              M
            </div>
            <div>
              <span className="text-xl font-bold text-white tracking-tight">MarketOps</span>
              <p className="text-[10px] text-blue-400 font-mono tracking-wider uppercase">Logistics Lakehouse</p>
            </div>
          </div>
          <button
            onClick={onCloseMobile}
            className="md:hidden text-slate-400 hover:text-white p-1"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Navigation Menu */}
        <nav className="flex-1 px-4 py-2 space-y-1.5 overflow-y-auto">
          {/* Dashboard Item */}
          <button
            id="nav-dashboard"
            onClick={() => {
              onSelectTab('dashboard');
              onSelectStatusFilter('All');
              onCloseMobile();
            }}
            className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg font-medium text-sm transition-colors text-left ${
              selectedTab === 'dashboard' && activeStatusFilter === 'All'
                ? 'bg-blue-600/15 text-blue-400 font-semibold'
                : 'hover:bg-slate-800 text-slate-300 hover:text-white'
            }`}
          >
            <LayoutDashboard className="w-5 h-5 text-blue-400" />
            <span>Dashboard</span>
          </button>

          {/* All Orders Item */}
          <button
            id="nav-all-orders"
            onClick={() => {
              onSelectTab('orders');
              onCloseMobile();
            }}
            className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg font-medium text-sm transition-colors text-left ${
              selectedTab === 'orders'
                ? 'bg-blue-600/15 text-blue-400 font-semibold'
                : 'hover:bg-slate-800 text-slate-300 hover:text-white'
            }`}
          >
            <Package className="w-5 h-5 text-slate-400" />
            <span>{pt ? 'Todos os pedidos' : 'All Orders'}</span>
          </button>

          {/* Databricks Sync */}
          <button
            id="nav-databricks-sync"
            onClick={() => {
              onOpenDatabricksModal();
              onCloseMobile();
            }}
            className="w-full flex items-center gap-3 px-4 py-3 hover:bg-slate-800 rounded-lg transition-colors text-sm text-left text-slate-300 hover:text-white group"
          >
            <Database className="w-5 h-5 text-amber-500 group-hover:scale-105 transition-transform" />
            <div className="flex-1">
              <span className="flex items-center gap-2">
                Databricks Sync
                <span className="w-1.5 h-1.5 rounded-full bg-green-500 animate-pulse" />
              </span>
            </div>
          </button>

          {/* Delivery Alerts */}
          <button
            id="nav-delivery-alerts"
            onClick={() => {
              onOpenAlerts();
              onCloseMobile();
            }}
            className="w-full flex items-center justify-between px-4 py-3 hover:bg-slate-800 rounded-lg transition-colors text-sm text-left text-slate-300 hover:text-white"
          >
            <div className="flex items-center gap-3">
              <Bell className="w-5 h-5 text-slate-400" />
              <span>{pt ? 'Alertas de entrega' : 'Delivery Alerts'}</span>
            </div>
            {unreadAlertsCount > 0 && (
              <span className="bg-blue-500 text-white font-bold text-[10px] px-2 py-0.5 rounded-full">
                {unreadAlertsCount}
              </span>
            )}
          </button>

          {/* Status Quick Filters in Sidebar */}
          <div className="pt-4 pb-2">
            <p className="px-4 text-[10px] font-bold uppercase tracking-wider text-slate-500">
              {pt ? 'Filtrar por status' : 'Filter by Status'}
            </p>
          </div>

          {[
            { label: pt ? 'Aguardando compra' : 'Pending Fulfillment', value: 'Pending', dot: 'bg-amber-400' },
            { label: pt ? 'Em trânsito / faturado' : 'In Transit / Invoiced', value: 'Shipped', dot: 'bg-blue-400' },
            { label: pt ? 'Entregue' : 'Delivered', value: 'Delivered', dot: 'bg-green-400' },
            { label: pt ? 'Cancelado' : 'Cancelled', value: 'Cancelled', dot: 'bg-red-400' },
          ].map((item) => (
            <button
              key={item.value}
              onClick={() => {
                onSelectStatusFilter(item.value);
                onSelectTab('orders');
                onCloseMobile();
              }}
              className={`w-full flex items-center gap-2.5 px-4 py-2 rounded-lg text-xs transition-colors text-left ${
                activeStatusFilter === item.value
                  ? 'bg-slate-800 text-white font-medium'
                  : 'text-slate-400 hover:text-slate-200 hover:bg-slate-800/60'
              }`}
            >
              <span className={`w-2 h-2 rounded-full ${item.dot}`} />
              <span>{item.label}</span>
            </button>
          ))}

          {/* Action Quick Buttons */}
          <div className="pt-4 px-2 space-y-2">
            {onOpenBatchImport && (
              <button
                id="sidebar-batch-order-btn"
                onClick={() => {
                  onOpenBatchImport();
                  onCloseMobile();
                }}
                className="w-full py-2.5 px-3 bg-emerald-600 hover:bg-emerald-700 text-white rounded-lg text-xs font-semibold flex items-center justify-center gap-2 shadow-xs transition-all"
                title="Send multiple orders at once"
              >
                <UploadCloud className="w-4 h-4" />
                <span>{pt ? 'Enviar vários pedidos' : 'Send Multiple Orders'}</span>
              </button>
            )}

            <button
              id="sidebar-new-order-btn"
              onClick={() => {
                onOpenNewOrder();
                onCloseMobile();
              }}
              className="w-full py-2.5 px-3 bg-blue-600 hover:bg-blue-700 text-white rounded-lg text-xs font-semibold flex items-center justify-center gap-2 shadow-xs transition-all"
            >
              <Plus className="w-4 h-4" />
              <span>{pt ? 'Inserir novo pedido' : 'Insert New Order'}</span>
            </button>
          </div>
        </nav>

        {/* User Account / Footer */}
        <div className="p-4 border-t border-slate-800">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-full bg-slate-700 flex items-center justify-center text-slate-200 font-semibold text-xs border border-slate-600">
              AU
            </div>
            <div className="flex-1 min-w-0">
              <p className="text-sm font-semibold text-white truncate">Admin User</p>
              <p className="text-xs text-slate-400 flex items-center gap-1.5 truncate">
                <span className="w-1.5 h-1.5 rounded-full bg-emerald-400"></span>
                Cloud Enterprise
              </p>
            </div>
          </div>
        </div>
      </aside>
    </>
  );
};
