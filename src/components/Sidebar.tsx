import React, { useState } from 'react';
import { useAuth } from '../auth/AuthProvider';
import { 
  LayoutDashboard, 
  Package, 
  FileText, 
  Database, 
  Bell, 
  Plus, 
  CheckCircle2, 
  X,
  UploadCloud,
  ReceiptText,
  UsersRound,
  ChevronLeft,
  ChevronRight,
  LogOut,
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
  const {
  canManageOrders,
  user,
  role,
  isGuest,
  signOut,
} = useAuth();
  const selectedTab = currentTab || activeTab || 'dashboard';
  const isMenuOpen = mobileOpen ?? isMobileOpen ?? false;
  const [collapsed, setCollapsed] = useState(() => localStorage.getItem('marketops-sidebar-collapsed') === 'true');
  const toggleCollapsed = () => {
    setCollapsed(value => {
      localStorage.setItem('marketops-sidebar-collapsed', String(!value));
      return !value;
    });
  };
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
        className={`fixed md:sticky top-0 left-0 z-40 h-screen ${collapsed ? 'md:w-20' : 'md:w-64'} w-64 bg-slate-900 text-slate-300 flex flex-col border-r border-slate-800 transition-all duration-300 ease-in-out shrink-0 ${
          isMenuOpen ? 'translate-x-0' : '-translate-x-full md:translate-x-0'
        }`}
      >
        {/* Brand Header */}
        <button type="button" onClick={toggleCollapsed} className="absolute -right-3 top-20 z-50 hidden h-7 w-7 items-center justify-center rounded-full border border-slate-600 bg-slate-800 text-slate-200 shadow-lg hover:border-blue-400 hover:text-white md:flex" title={collapsed ? 'Expandir menu' : 'Recolher menu'}>
          {collapsed ? <ChevronRight className="h-4 w-4"/> : <ChevronLeft className="h-4 w-4"/>}
        </button>
        <div className={`${collapsed ? 'p-5 justify-center' : 'p-6 justify-between'} flex items-center`}>
          <div className="flex items-center gap-3">
            <div className="w-8 h-8 bg-blue-500 rounded-lg flex items-center justify-center text-white font-bold shadow-md shadow-blue-500/30">
              M
            </div>
            {!collapsed && <div>
              <span className="text-xl font-bold text-white tracking-tight">MarketOps</span>
              <p className="text-[10px] text-blue-400 font-mono tracking-wider uppercase">{pt ? 'Central de controle logístico' : 'Logistics Control Tower'}</p>
            </div>}
          </div>
          <button
            onClick={onCloseMobile}
            className="md:hidden text-slate-400 hover:text-white p-1"
          >
            <X className="w-5 h-5" />
          </button>

        </div>

        {/* Navigation Menu */}
        <nav className={`flex-1 px-4 py-2 space-y-1.5 overflow-y-auto ${collapsed ? '[&_button]:justify-center [&_button]:px-2' : ''}`}>
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
            {!collapsed && <span>{pt ? 'Painel' : 'Dashboard'}</span>}
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
            {!collapsed && <span>{pt ? 'Todos os pedidos' : 'All Orders'}</span>}
          </button>

          {/* Databricks Sync */}
          <button
            id="nav-invoices"
            onClick={() => { onSelectTab('invoices'); onCloseMobile(); }}
            className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg font-medium text-sm transition-colors text-left ${selectedTab === 'invoices' ? 'bg-blue-600/15 text-blue-400 font-semibold' : 'hover:bg-slate-800 text-slate-300 hover:text-white'}`}
          >
            <ReceiptText className="w-5 h-5 text-amber-400" />
            {!collapsed && <span>{pt ? 'Invoices recentes' : 'Recent Invoices'}</span>}
          </button>

          {role === 'admin' && !isGuest && (
            <button
              id="nav-admin-users"
              onClick={() => { onSelectTab('admin-users'); onCloseMobile(); }}
              className={`w-full flex items-center gap-3 px-4 py-3 rounded-lg font-medium text-sm transition-colors text-left ${selectedTab === 'admin-users' ? 'bg-blue-600/15 text-blue-400 font-semibold' : 'hover:bg-slate-800 text-slate-300 hover:text-white'}`}
            >
              <UsersRound className="w-5 h-5 text-violet-400" />
              {!collapsed && <span>{pt ? 'Administração' : 'Administration'}</span>}
            </button>
          )}

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
            {!collapsed && <div className="flex-1">
              <span className="flex items-center gap-2">
                {pt ? 'Integração Databricks' : 'Databricks Integration'}
                <span className="w-1.5 h-1.5 rounded-full bg-amber-500" />
              </span>
            </div>}
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
              {!collapsed && <span>{pt ? 'Alertas de entrega' : 'Delivery Alerts'}</span>}
            </div>
            {unreadAlertsCount > 0 && (
              <span className="bg-blue-500 text-white font-bold text-[10px] px-2 py-0.5 rounded-full">
                {unreadAlertsCount}
              </span>
            )}
          </button>

          {/* Action Quick Buttons */}
            {canManageOrders && (
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
                {!collapsed && <span>{pt ? 'Enviar vários pedidos' : 'Send Multiple Orders'}</span>}
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
              {!collapsed && <span>{pt ? 'Inserir novo pedido' : 'Insert New Order'}</span>}
            </button>
          </div> 
        )}
        </nav>

        {/* User Account / Footer */}
<div className="border-t border-slate-800 p-4">
  <div className="flex items-center gap-3">
    <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-full border border-slate-600 bg-slate-700 text-xs font-semibold text-slate-200">
      {isGuest
        ? 'GU'
        : (user?.email?.slice(0, 2) || 'US').toUpperCase()}
    </div>

    {!collapsed && <div className="min-w-0 flex-1">
      <p className="truncate text-sm font-semibold text-white">
        {isGuest
          ? 'Guest Viewer'
          : user?.email || 'Authenticated User'}
      </p>

      <p className="flex items-center gap-1.5 truncate text-xs capitalize text-slate-400">
        <span className="h-1.5 w-1.5 rounded-full bg-emerald-400" />
        {isGuest ? 'Read-only demo' : role}
      </p>
    </div>}
  </div>

  <button
    type="button"
    onClick={() => void signOut()}
    className={`mt-3 w-full rounded-lg border border-slate-700 px-3 py-2 text-xs font-semibold text-slate-300 transition hover:bg-slate-800 hover:text-white ${collapsed ? 'flex justify-center' : ''}`}
  >
    {collapsed ? <LogOut className="h-4 w-4"/> : isGuest ? (pt ? 'Sair da demonstração' : 'Exit demo') : (pt ? 'Sair' : 'Sign out')}
  </button>
</div>
      </aside>
    </>
  );
};
