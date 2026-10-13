import React from 'react';
import { useAuth } from '../auth/AuthProvider';
import {
  Plus,
  RefreshCw,
  Bell,
  Search,
  Menu,
  UploadCloud,
  Moon,
  Sun,
} from 'lucide-react';

interface HeaderProps {
  onOpenNewOrder: () => void;
  onOpenBatchImport?: () => void;
  onOpenAlerts: () => void;
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
  const { canManageOrders } = useAuth();
  const pt = language === 'pt';
  const currentSearch = searchQuery ?? searchValue ?? '';
  const iconButton = 'p-2 rounded-lg text-slate-500 hover:bg-slate-100 hover:text-slate-800 transition-colors';

  return (
    <header className="h-16 bg-white border-b border-slate-200 flex items-center justify-between gap-3 px-4 sm:px-6 lg:px-8 sticky top-0 z-30">
      <div className="flex items-center gap-3 flex-1 max-w-lg">
        {onToggleMobileMenu && (
          <button onClick={onToggleMobileMenu} className={`md:hidden ${iconButton}`} title="Menu">
            <Menu className="w-5 h-5" />
          </button>
        )}

        <div className="flex items-center bg-slate-100 px-3.5 py-2 rounded-lg w-full max-w-md border border-transparent focus-within:border-blue-500 focus-within:bg-white transition-colors">
          <Search className="w-4 h-4 text-slate-400 mr-2 shrink-0" />
          <input
            id="header-global-search"
            type="text"
            placeholder={pt ? 'Buscar PO, cliente, SKU ou ASIN...' : 'Search PO, customer, SKU or ASIN...'}
            value={currentSearch}
            onChange={(e) => onSearchChange && onSearchChange(e.target.value)}
            className="bg-transparent border-none outline-none text-sm w-full text-slate-800 placeholder:text-slate-400"
          />
        </div>
      </div>

      <div className="flex items-center gap-1.5 sm:gap-2">
        <button onClick={onToggleLanguage} className={`${iconButton} text-xs font-bold w-9`} title={pt ? 'Mudar idioma' : 'Change language'}>
          {language === 'en' ? 'EN' : 'PT'}
        </button>
        <button onClick={onToggleDarkMode} className={iconButton} title={darkMode ? (pt ? 'Modo claro' : 'Light mode') : (pt ? 'Modo escuro' : 'Dark mode')}>
          {darkMode ? <Sun className="w-[18px] h-[18px]" /> : <Moon className="w-[18px] h-[18px]" />}
        </button>

        {canManageOrders && (
          <>
            <button onClick={onOpenAlerts} title={pt ? 'Alertas de entrega' : 'Delivery alerts'} className={`relative ${iconButton}`}>
              {unreadAlertsCount > 0 && <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full" />}
              <Bell className="w-[18px] h-[18px]" />
            </button>

            <span className="mx-1 hidden h-6 w-px bg-slate-200 sm:block" />

            <button
              id="btn-sync-all"
              onClick={onSyncAll}
              disabled={isSyncing}
              title={pt ? 'Atualizar etapas logísticas de todos os pedidos' : 'Recalculate the logistics stage for all orders'}
              className="inline-flex items-center gap-1.5 px-3 py-2 rounded-lg text-xs font-medium text-slate-700 border border-slate-200 hover:bg-slate-50 transition-colors disabled:opacity-50"
            >
              <RefreshCw className={`w-3.5 h-3.5 ${isSyncing ? 'animate-spin' : ''}`} />
              <span className="hidden lg:inline">{isSyncing ? (pt ? 'Atualizando...' : 'Syncing...') : (pt ? 'Atualizar' : 'Sync')}</span>
            </button>

            {onOpenBatchImport && (
              <button
                id="btn-send-multiple-orders"
                onClick={onOpenBatchImport}
                className="inline-flex items-center gap-1.5 px-3 py-2 rounded-lg text-xs font-medium text-slate-700 border border-slate-200 hover:bg-slate-50 transition-colors"
                title={pt ? 'Importar vários pedidos (planilha)' : 'Import multiple orders (spreadsheet)'}
              >
                <UploadCloud className="w-3.5 h-3.5" />
                <span className="hidden lg:inline">{pt ? 'Importar' : 'Import'}</span>
              </button>
            )}

            <button
              id="btn-insert-new-order"
              onClick={onOpenNewOrder}
              className="inline-flex items-center gap-1.5 bg-blue-600 hover:bg-blue-700 text-white px-3 py-2 rounded-lg text-xs font-semibold transition-colors"
            >
              <Plus className="w-4 h-4" />
              <span className="hidden md:inline whitespace-nowrap">{pt ? 'Novo pedido' : 'New order'}</span>
            </button>
          </>
        )}
      </div>
    </header>
  );
};
