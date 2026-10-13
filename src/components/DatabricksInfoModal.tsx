import React from 'react';
import {
  ArrowRight,
  BellRing,
  Code,
  Database,
  Layers,
  RefreshCw,
  ShieldCheck,
  Table,
  X,
} from 'lucide-react';

interface DatabricksInfoModalProps {
  isOpen: boolean;
  onClose: () => void;
  onTriggerSyncAll: () => Promise<void>;
  isSyncing: boolean;
  language?: 'en' | 'pt';
}

export const DatabricksInfoModal: React.FC<DatabricksInfoModalProps> = ({
  isOpen,
  onClose,
  onTriggerSyncAll,
  isSyncing,
  language = 'en',
}) => {
  const pt = language === 'pt';
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-4 bg-slate-950/65 backdrop-blur-xs overflow-y-auto">
      <div
        className="bg-white rounded-2xl border border-slate-200 shadow-2xl max-w-3xl w-full max-h-[92vh] flex flex-col overflow-hidden my-auto text-xs"
        onClick={(event) => event.stopPropagation()}
      >
        <div className="px-6 py-4 border-b border-slate-200 flex items-center justify-between bg-slate-50/70">
          <div className="flex items-center gap-3">
            <div className="p-2.5 rounded-xl bg-blue-100 text-blue-700">
              <Database className="w-5 h-5" />
            </div>
            <div>
              <div className="flex flex-wrap items-center gap-2">
                <h2 className="text-base font-bold text-slate-900">{pt ? 'Integração MarketOps + Databricks' : 'MarketOps + Databricks integration'}</h2>
                <span className="rounded-full border border-amber-200 bg-amber-100 px-2 py-0.5 text-[10px] font-bold text-amber-900">{pt ? 'SINCRONIZAÇÃO AO VIVO' : 'LIVE SYNC'}</span>
              </div>
              <p className="text-[11px] text-slate-500 mt-0.5">
                {pt ? 'O backend já está preparado para consultar uma tabela Delta por SQL Warehouse quando as credenciais forem configuradas.' : 'The backend is ready to query a Delta table through a SQL Warehouse once credentials are configured.'}
              </p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-200/70 transition-colors" aria-label={pt ? 'Fechar' : 'Close'}>
            <X className="w-5 h-5" />
          </button>
        </div>

        <div className="p-6 space-y-5 overflow-y-auto flex-1">
          <div className="grid grid-cols-1 md:grid-cols-2 gap-3">
            <div className="rounded-xl border border-slate-200 bg-slate-50/80 p-4">
              <div className="flex items-center gap-2 font-bold text-slate-900 mb-2">
                <ShieldCheck className="w-4 h-4 text-slate-700" /> {pt ? 'Como funciona' : 'How it works'}
              </div>
              <p className="text-[11px] leading-relaxed text-slate-600">
                {pt
                  ? 'O PostgreSQL/Supabase mantém os dados operacionais do MarketOps. O backend consulta o Databricks periodicamente e atualiza os campos cadastrais e logísticos sem apagar confirmação de compra, observações e cancelamentos manuais.'
                  : 'PostgreSQL/Supabase keeps MarketOps operational data. The backend periodically queries Databricks and refreshes customer/product/logistics fields without overwriting purchase confirmations, notes, or manual cancellations.'}
              </p>
            </div>
            <div className="rounded-xl border border-blue-200 bg-blue-50/70 p-4">
              <div className="flex items-center gap-2 font-bold text-blue-950 mb-2">
                <Layers className="w-4 h-4 text-blue-700" /> {pt ? 'O que pode existir na empresa' : 'What can exist at the company'}
              </div>
              <p className="text-[11px] leading-relaxed text-blue-950/80">
                {pt
                  ? 'O Databricks pode concentrar e tratar os dados corporativos de pedidos, transportadoras e entregas. O MarketOps passa a consumir somente os dados que precisa e reage às mudanças de status.'
                  : 'Databricks can centralize and transform corporate order, carrier, and delivery data. MarketOps then consumes only the data it needs and reacts to status changes.'}
              </p>
            </div>
          </div>

          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200 space-y-3">
            <h3 className="font-bold text-slate-900 text-xs flex items-center gap-2">
              <BellRing className="w-4 h-4 text-blue-700" />
              {pt ? 'Fluxo da integração e alertas' : 'Integration and alert flow'}
            </h3>
            <div className="grid grid-cols-1 sm:grid-cols-4 gap-2 text-center">
              <div className="p-3 bg-white rounded-xl border border-slate-200">
                <span className="font-bold text-slate-900 block">1. {pt ? 'Fontes corporativas' : 'Corporate sources'}</span>
                <p className="mt-1 text-[10px] text-slate-600">Marketplace, ERP, WMS, APIs de transportadoras</p>
              </div>
              <div className="hidden sm:flex items-center justify-center text-slate-400"><ArrowRight className="w-4 h-4" /></div>
              <div className="p-3 bg-blue-50 rounded-xl border border-blue-200">
                <span className="font-bold text-blue-950 block">2. Databricks Delta / Gold</span>
                <p className="mt-1 text-[10px] text-slate-600">{pt ? 'Tabela tratada + mudanças incrementais (CDF)' : 'Curated table + incremental changes (CDF)'}</p>
              </div>
              <div className="p-3 bg-emerald-50 rounded-xl border border-emerald-200">
                <span className="font-bold text-emerald-950 block">3. MarketOps</span>
                <p className="mt-1 text-[10px] text-slate-600">{pt ? 'Reconcile → salva status → envia e-mail → grava alerta' : 'Reconcile → save status → send email → log alert'}</p>
              </div>
            </div>
            <p className="text-[10px] text-slate-500 leading-relaxed">
              {pt
                ? 'Nesta versão, o backend consulta o SQL Warehouse periodicamente. O endpoint /api/databricks/reconcile continua disponível como alternativa para integrações orientadas a eventos.'
                : 'In this version, the backend periodically queries the SQL Warehouse. The /api/databricks/reconcile endpoint remains available as an event-driven alternative.'}
            </p>
          </div>

          <div className="space-y-2">
            <h4 className="font-bold text-slate-900 flex items-center gap-1.5"><Table className="w-4 h-4 text-blue-700" />{pt ? 'Tabela Delta usada pela integração' : 'Delta table used by the integration'}</h4>
            <p className="text-[11px] text-slate-600">
              {pt ? 'Nome padrão configurado no pacote:' : 'Default table name configured by the package:'}{' '}
              <code className="font-mono font-semibold text-slate-900">main.marketops.orders_live</code>
            </p>
            <div className="p-3.5 bg-slate-950 text-slate-200 rounded-xl font-mono text-[11px] overflow-x-auto leading-relaxed border border-slate-800">
              <div className="text-slate-400">{'{'}</div>
              <div className="pl-4">&quot;purchase_order&quot;: &quot;AKDN-80015&quot;,</div>
              <div className="pl-4">&quot;sku&quot;: &quot;222-742&quot;,</div>
              <div className="pl-4">&quot;shipment_status&quot;: &quot;Out for Delivery&quot;,</div>
              <div className="pl-4">&quot;tracking_number&quot;: &quot;TRK-2026-0015&quot;,</div>
              <div className="pl-4">&quot;carrier&quot;: &quot;Carrier Demo&quot;,</div>
              <div className="pl-4">&quot;etd&quot;: &quot;2026-09-03&quot;,</div>
              <div className="pl-4">&quot;eta&quot;: &quot;2026-09-10&quot;,</div>
              <div className="pl-4">&quot;entry_cd_date&quot;: &quot;2026-09-11&quot;,</div>
              <div className="pl-4">&quot;billing_date&quot;: &quot;2026-09-12&quot;,</div>
              <div className="pl-4">&quot;customer_email&quot;: &quot;cliente@empresa.com&quot;,</div>
              <div className="pl-4">&quot;customer_phone&quot;: &quot;(92) 99999-0000&quot;,</div>
              <div className="pl-4">&quot;customer_cpf&quot;: &quot;000.000.000-00&quot;</div>
              <div className="text-slate-400">{'}'}</div>
            </div>
          </div>

          <div className="space-y-2">
            <h4 className="font-bold text-slate-900 flex items-center gap-1.5"><Code className="w-4 h-4 text-blue-700" />{pt ? 'Pontos da integração' : 'Integration points'}</h4>
            <div className="grid grid-cols-1 md:grid-cols-2 gap-2 font-mono text-[10px]">
              <div className="rounded-lg bg-slate-100 border border-slate-200 p-2.5"><strong className="text-emerald-700">POST</strong> /api/databricks/reconcile<br/><span className="font-sans text-slate-600">{pt ? 'Recebe linhas alteradas e dispara regras de status/alerta.' : 'Receives changed rows and runs status/alert rules.'}</span></div>
              <div className="rounded-lg bg-slate-100 border border-slate-200 p-2.5"><strong className="text-blue-700">POST</strong> /api/databricks/sync-all<br/><span className="font-sans text-slate-600">{pt ? 'Força uma leitura imediata do Databricks quando a conexão está ativa.' : 'Forces an immediate Databricks pull when the connection is active.'}</span></div>
              <div className="rounded-lg bg-slate-100 border border-slate-200 p-2.5"><strong className="text-blue-700">ENV</strong> DATABRICKS_HOST / WAREHOUSE_ID<br/><span className="font-sans text-slate-600">{pt ? 'Credenciais e SQL Warehouse usados somente pelo backend.' : 'Credentials and SQL Warehouse used only by the backend.'}</span></div>
              <div className="rounded-lg bg-slate-100 border border-slate-200 p-2.5"><strong className="text-amber-700">ENV</strong> DATABRICKS_WEBHOOK_SECRET<br/><span className="font-sans text-slate-600">{pt ? 'Chave de integração serviço-a-serviço para o endpoint.' : 'Service-to-service integration key for the endpoint.'}</span></div>
            </div>
          </div>

          <div className="rounded-xl border border-emerald-200 bg-emerald-50/80 p-3 text-[11px] text-emerald-950">
            <strong>{pt ? 'Atualização automática:' : 'Automatic refresh:'}</strong>{' '}
            {pt
              ? 'com as variáveis DATABRICKS_* configuradas, o backend consulta a tabela Delta e a interface busca as mudanças periodicamente. O token do Databricks nunca é enviado ao navegador.'
              : 'when the DATABRICKS_* variables are configured, the backend queries the Delta table and the UI periodically refreshes changes. The Databricks token is never sent to the browser.'}
          </div>
        </div>

        <div className="px-6 py-4 border-t border-slate-200 bg-slate-50/70 flex flex-wrap items-center justify-between gap-3">
          <button onClick={onTriggerSyncAll} disabled={isSyncing} className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-semibold transition-colors disabled:opacity-50">
            <RefreshCw className={`w-3.5 h-3.5 ${isSyncing ? 'animate-spin' : ''}`} />
            <span>{isSyncing ? (pt ? 'Sincronizando...' : 'Syncing...') : (pt ? 'Sincronizar agora' : 'Sync now')}</span>
          </button>
          <button onClick={onClose} className="px-4 py-2 rounded-xl text-xs font-semibold text-slate-800 bg-slate-200 hover:bg-slate-300 transition-colors">{pt ? 'Fechar' : 'Close'}</button>
        </div>
      </div>
    </div>
  );
};
