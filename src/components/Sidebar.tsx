import React, { useState } from 'react';
import { useAuth } from '../auth/AuthProvider';
import {
  LayoutDashboard,
  Package,
  Database,
  X,
  ReceiptText,
  UsersRound,
  ChevronLeft,
  ChevronRight,
  LogOut,
  LucideIcon,
} from 'lucide-react';

interface SidebarProps {
  currentTab?: string;
  activeTab?: string;
  onSelectTab: (tab: any) => void;
  onOpenDatabricksModal: () => void;
  mobileOpen?: boolean;
  isMobileOpen?: boolean;
  onCloseMobile: () => void;
  onSelectStatusFilter?: (status: string) => void;
  language?: 'en' | 'pt';
}

export const Sidebar: React.FC<SidebarProps> = ({
  currentTab,
  activeTab,
  onSelectTab,
  onOpenDatabricksModal,
  mobileOpen,
  isMobileOpen,
  onCloseMobile,
  onSelectStatusFilter = (_status?: string) => {},
  language = 'en',
}) => {
  const pt = language === 'pt';
  const { user, role, isGuest, signOut } = useAuth();
  const selectedTab = currentTab || activeTab || 'dashboard';
  const isMenuOpen = mobileOpen ?? isMobileOpen ?? false;
  const [collapsed, setCollapsed] = useState(() => localStorage.getItem('marketops-sidebar-collapsed') === 'true');
  const toggleCollapsed = () => {
    setCollapsed(value => {
      localStorage.setItem('marketops-sidebar-collapsed', String(!value));
      return !value;
    });
  };

  const roleLabel = isGuest
    ? (pt ? 'Visitante (somente leitura)' : 'Guest (read-only)')
    : role === 'admin'
      ? (pt ? 'Administrador' : 'Administrator')
      : (pt ? 'Visualização' : 'Viewer');

  const NavItem = ({ id, icon: Icon, label, active = false, onClick }: { id: string; icon: LucideIcon; label: string; active?: boolean; onClick: () => void }) => (
    <button
      id={id}
      type="button"
      title={collapsed ? label : undefined}
      onClick={() => { onClick(); onCloseMobile(); }}
      className={`w-full flex items-center gap-3 rounded-lg px-3 py-2.5 text-sm transition-colors text-left ${collapsed ? 'md:justify-center md:px-2' : ''} ${
        active ? 'bg-slate-800 text-white font-semibold' : 'text-slate-400 hover:bg-slate-800/60 hover:text-white'
      }`}
    >
      <Icon className={`h-[18px] w-[18px] shrink-0 ${active ? 'text-blue-400' : ''}`} />
      <span className={collapsed ? 'md:hidden' : ''}>{label}</span>
    </button>
  );

  return (
    <>
      {/* Mobile Backdrop */}
      {isMenuOpen && (
        <div
          className="fixed inset-0 bg-slate-900/60 z-40 md:hidden"
          onClick={onCloseMobile}
        />
      )}

      <aside
        className={`fixed md:sticky top-0 left-0 z-40 h-screen ${collapsed ? 'md:w-[72px]' : 'md:w-60'} w-60 bg-slate-900 text-slate-300 flex flex-col border-r border-slate-800 transition-all duration-200 shrink-0 ${
          isMenuOpen ? 'translate-x-0' : '-translate-x-full md:translate-x-0'
        }`}
      >
        <button type="button" onClick={toggleCollapsed} className="absolute -right-3 top-16 z-50 hidden h-6 w-6 items-center justify-center rounded-full border border-slate-700 bg-slate-800 text-slate-300 hover:text-white md:flex" title={collapsed ? (pt ? 'Expandir menu' : 'Expand menu') : (pt ? 'Recolher menu' : 'Collapse menu')}>
          {collapsed ? <ChevronRight className="h-3.5 w-3.5"/> : <ChevronLeft className="h-3.5 w-3.5"/>}
        </button>

        {/* Brand */}
        <div className={`flex items-center px-5 py-5 ${collapsed ? 'md:justify-center md:px-3' : 'justify-between'}`}>
          <div className="flex items-center gap-2.5">
            <div className="w-8 h-8 bg-blue-600 rounded-lg flex items-center justify-center text-white font-bold">M</div>
            <span className={`text-lg font-bold text-white tracking-tight ${collapsed ? 'md:hidden' : ''}`}>MarketOps</span>
          </div>
          <button onClick={onCloseMobile} className="md:hidden text-slate-400 hover:text-white p-1">
            <X className="w-5 h-5" />
          </button>
        </div>

        <nav className="flex-1 px-3 py-2 space-y-1 overflow-y-auto">
          <NavItem
            id="nav-dashboard"
            icon={LayoutDashboard}
            label={pt ? 'Painel' : 'Dashboard'}
            active={selectedTab === 'dashboard'}
            onClick={() => { onSelectTab('dashboard'); onSelectStatusFilter('All'); }}
          />
          <NavItem
            id="nav-all-orders"
            icon={Package}
            label={pt ? 'Pedidos' : 'Orders'}
            active={selectedTab === 'orders'}
            onClick={() => onSelectTab('orders')}
          />
          <NavItem
            id="nav-invoices"
            icon={ReceiptText}
            label="Invoices"
            active={selectedTab === 'invoices'}
            onClick={() => onSelectTab('invoices')}
          />
          {role === 'admin' && !isGuest && (
            <NavItem
              id="nav-admin-users"
              icon={UsersRound}
              label={pt ? 'Administração' : 'Administration'}
              active={selectedTab === 'admin-users'}
              onClick={() => onSelectTab('admin-users')}
            />
          )}
          <NavItem
            id="nav-databricks-sync"
            icon={Database}
            label="Databricks"
            onClick={onOpenDatabricksModal}
          />
        </nav>

        {/* User Account / Footer */}
        <div className="border-t border-slate-800 p-3">
          <div className={`flex items-center gap-3 ${collapsed ? 'md:justify-center' : ''}`}>
            <div className="flex h-9 w-9 shrink-0 items-center justify-center rounded-full bg-slate-700 text-xs font-semibold text-slate-200">
              {isGuest ? 'GU' : (user?.email?.slice(0, 2) || 'US').toUpperCase()}
            </div>
            <div className={`min-w-0 flex-1 ${collapsed ? 'md:hidden' : ''}`}>
              <p className="truncate text-sm font-medium text-white">
                {isGuest ? (pt ? 'Visitante' : 'Guest') : user?.email || 'Authenticated User'}
              </p>
              <p className="truncate text-xs text-slate-400">{roleLabel}</p>
            </div>
          </div>
          <button
            type="button"
            onClick={() => void signOut()}
            title={pt ? 'Sair' : 'Sign out'}
            className={`mt-3 w-full flex items-center justify-center gap-2 rounded-lg px-3 py-2 text-xs font-medium text-slate-400 transition hover:bg-slate-800 hover:text-white`}
          >
            <LogOut className="h-4 w-4"/>
            <span className={collapsed ? 'md:hidden' : ''}>{pt ? 'Sair' : 'Sign out'}</span>
          </button>
        </div>
      </aside>
    </>
  );
};
