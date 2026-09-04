import React from 'react';
import { 
  Plus, 
  RefreshCw, 
  Bell, 
  Database, 
  Search,
  Menu,
  UploadCloud
} from 'lucide-react';

interface HeaderProps {
  onOpenNewOrder: () => void;
  onOpenBatchImport?: () => void;
  onOpenAlerts: () => void;
  onOpenDatabricksModal: () => void;
  onSyncAll: () => void;
  isSyncing: boolean;
  unreadAlertsCount: number;
  searchValue?: string;
  searchQuery?: string;
  onSearchChange?: (val: string) => void;
  onToggleMobileMenu?: () => void;
  language: 'en' | 'pt';
  onToggleLanguage: () => void;
  darkMode: boolean;
  onToggleDarkMode: () => void;
}

export const Header: React.FC<HeaderProps> = ({
  onOpenNewOrder,
  onOpenBatchImport,
  onOpenAlerts,
  onOpenDatabricksModal,
  onSyncAll,
  isSyncing,
  unreadAlertsCount,
  searchValue,
  searchQuery,
  onSearchChange,
  onToggleMobileMenu,
  language,
  onToggleLanguage,
  darkMode,
  onToggleDarkMode,
}) => {
  const currentSearch = searchQuery ?? searchValue ?? '';
  return (
    <header className="h-16 bg-white border-b border-slate-200 flex items-center justify-between px-4 sm:px-6 lg:px-8 sticky top-0 z-30">
      {/* Mobile Menu & Search Input */}
      <div className="flex items-center gap-3 flex-1 max-w-lg">
        {onToggleMobileMenu && (
          <button
            onClick={onToggleMobileMenu}
            className="md:hidden p-2 rounded-lg text-slate-500 hover:bg-slate-100 hover:text-slate-800 transition-colors"
            title="Toggle Menu"
          >
            <Menu className="w-5 h-5" />
          </button>
        )}

        {/* Sleek Search Pill */}
        <div className="flex items-center bg-slate-100 px-4 py-2 rounded-full w-full max-w-md border border-slate-200/80 focus-within:border-blue-500 focus-within:bg-white transition-all">
          <Search className="w-4 h-4 text-slate-400 mr-2 shrink-0" />
          <input
            id="header-global-search"
            type="text"
            placeholder={language === 'pt' ? 'Buscar ID, cliente, SKU, ASIN ou data...' : 'Search ID, customer, SKU, ASIN or date...'}
            value={currentSearch}
            onChange={(e) => onSearchChange && onSearchChange(e.target.value)}
            className="bg-transparent border-none outline-none text-sm w-full text-slate-800 placeholder:text-slate-400"
          />
        </div>
      </div>

      {/* Right Action Controls */}
      <div className="flex items-center gap-2 sm:gap-3 ml-3">
        <button onClick={onToggleLanguage} className="px-2.5 py-2 rounded-lg text-xs font-bold bg-slate-100 border border-slate-200 text-slate-700" title="Change interface language">
          {language === 'en' ? 'EN' : 'PT'}
        </button>
        <button onClick={onToggleDarkMode} className="px-2.5 py-2 rounded-lg text-xs font-medium bg-slate-100 border border-slate-200 text-slate-700" title={darkMode ? 'Use light mode' : 'Use dark mode'}>
          {darkMode ? '☀ Light' : '☾ Dark'}
        </button>
        {/* Databricks Connector Pill */}
        <button
          id="btn-databricks-status"
          onClick={onOpenDatabricksModal}
          title="Databricks Delta Lake Logistics status"
          className="hidden xl:flex items-center gap-2 px-3 py-1.5 rounded-lg text-xs font-medium text-slate-600 bg-slate-100 hover:bg-slate-200 border border-slate-200 transition-colors"
        >
          <Database className="w-3.5 h-3.5 text-amber-600" />
          <span>Databricks: <span className="font-mono text-slate-900 font-semibold">gold_logistics</span></span>
          <span className="w-2 h-2 rounded-full bg-green-500 animate-pulse" />
        </button>

        {/* Sync Databricks Action */}
        <button
          id="btn-sync-all"
          onClick={onSyncAll}
          disabled={isSyncing}
          title="Recalculate the logistics stage for all orders"
          className="inline-flex items-center gap-1.5 px-3 py-2 rounded-lg text-xs font-medium text-slate-700 bg-slate-50 border border-slate-200 hover:bg-slate-100 transition-colors disabled:opacity-50"
        >
          <RefreshCw className={`w-3.5 h-3.5 text-blue-600 ${isSyncing ? 'animate-spin' : ''}`} />
          <span className="hidden sm:inline">{isSyncing ? (language==='pt'?'Atualizando...':'Syncing all...') : (language==='pt'?'Atualizar pedidos':'Sync All Orders')}</span>
        </button>

        {/* Send Multiple Orders (Batch Import) Button */}
        {onOpenBatchImport && (
          <button
            id="btn-send-multiple-orders"
            onClick={onOpenBatchImport}
            className="bg-emerald-600 hover:bg-emerald-700 text-white px-3 sm:px-3.5 py-2 rounded-lg text-xs sm:text-sm font-semibold flex items-center gap-1.5 shadow-xs transition-all"
            title="Send multiple orders at once (paste table or CSV/TSV)"
          >
            <UploadCloud className="w-4 h-4" />
            <span className="whitespace-nowrap hidden sm:inline">{language==='pt'?'Enviar vários pedidos':'Send Multiple Orders'}</span>
            <span className="whitespace-nowrap sm:hidden">Batch</span>
          </button>
        )}

        {/* Insert New Order Button */}
        <button
          id="btn-insert-new-order"
          onClick={onOpenNewOrder}
          className="bg-blue-600 hover:bg-blue-700 text-white px-3 sm:px-3.5 py-2 rounded-lg text-xs sm:text-sm font-semibold flex items-center gap-1.5 shadow-xs transition-all"
        >
          <Plus className="w-4 h-4" />
          <span className="whitespace-nowrap hidden md:inline">{language==='pt'?'Inserir novo pedido':'Insert New Order'}</span>
          <span className="whitespace-nowrap md:hidden">New</span>
        </button>

        {/* Notification Bell with Sleek Red Dot */}
        <button
          id="btn-delivery-alerts"
          onClick={onOpenAlerts}
          title="Delivery Notifications & Email/Push Alerts"
          className="relative p-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition-colors"
        >
          {unreadAlertsCount > 0 && (
            <div className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full ring-2 ring-white animate-pulse" />
          )}
          <Bell className="w-5 h-5 text-slate-500" />
        </button>
      </div>
    </header>
  );
};
