import React, { useState, useMemo, useRef } from 'react';
import { apiFetch } from '../lib/api';
import { 
  X, 
  UploadCloud, 
  FileSpreadsheet, 
  CheckCircle2, 
  AlertCircle, 
  Trash2, 
  Copy, 
  Database, 
  Truck, 
  ArrowRight,
  Layers,
  Sparkles,
  Info
} from 'lucide-react';
import { 
  parseBatchOrderText, 
  ParsedBatchOrder, 
  SAMPLE_BATCH_INPUT 
} from '../utils/batchOrderParser';
import { Order } from '../types';

interface BatchOrderImportModalProps {
  isOpen: boolean;
  onClose: () => void;
  onOrdersImported: (importedOrders: Order[]) => void;
}

export const BatchOrderImportModal: React.FC<BatchOrderImportModalProps> = ({
  isOpen,
  onClose,
  onOrdersImported,
}) => {
  const [inputText, setInputText] = useState<string>(SAMPLE_BATCH_INPUT);
  const [activeTab, setActiveTab] = useState<'paste' | 'file'>('paste');
  const [defaultStatus, setDefaultStatus] = useState<string>('Pending');
  const [syncDatabricks, setSyncDatabricks] = useState<boolean>(true);
  const [destinationHub, setDestinationHub] = useState<string>('CD Marketplace - Manaus, AM');
  const [isSubmitting, setIsSubmitting] = useState<boolean>(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);
  const [dragOver, setDragOver] = useState<boolean>(false);
  const fileInputRef = useRef<HTMLInputElement>(null);

  // Parse orders live as user modifies text or status
  const parsedOrders = useMemo(() => {
    return parseBatchOrderText(inputText, defaultStatus);
  }, [inputText, defaultStatus]);

  const validCount = parsedOrders.filter((o) => o.isValid).length;
  const invalidCount = parsedOrders.length - validCount;

  if (!isOpen) return null;

  // Handle file upload
  const handleFileUpload = (file: File) => {
    const reader = new FileReader();
    reader.onload = (e) => {
      const text = e.target?.result as string;
      if (text) {
        setInputText(text);
        setActiveTab('paste');
      }
    };
    reader.readAsText(file);
  };

  const handleDrop = (e: React.DragEvent) => {
    e.preventDefault();
    setDragOver(false);
    if (e.dataTransfer.files && e.dataTransfer.files[0]) {
      handleFileUpload(e.dataTransfer.files[0]);
    }
  };

  // Submit all parsed orders to the backend
  const handleSubmitBatch = async () => {
    if (validCount === 0) {
      setErrorMsg('No valid orders found to import. Please check your data format.');
      return;
    }

    setIsSubmitting(true);
    setErrorMsg(null);

    try {
      const payload = {
        orders: parsedOrders.filter((o) => o.isValid).map((item) => ({
          ...item,
          destination_hub: destinationHub,
          sync_databricks: syncDatabricks,
        })),
        default_status: defaultStatus,
      };

      const res = await apiFetch('/api/orders/batch', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });

      if (!res.ok) {
        const errData = await res.json().catch(() => ({}));
        throw new Error(errData.error || `Server returned error ${res.status}`);
      }

      const data = await res.json();
      if (data.orders && Array.isArray(data.orders)) {
        onOrdersImported(data.orders);
        onClose();
      } else {
        throw new Error('Unexpected response format from server');
      }
    } catch (err: any) {
      console.error('Batch import failed:', err);
      setErrorMsg(err.message || 'Failed to submit batch orders');
    } finally {
      setIsSubmitting(false);
    }
  };

  const MARKETPLACE_COLUMNS = [
    'Data da compra',
    'SKU Marketplace',
    'Descrição do Material',
    'SKU Principal',
    'Seller',
    'Origem (País Seller)',
    'Ordem de Cliente',
    'Ordem de Compra',
    'Sequencial',
    'Sts de Compra',
    'Quantidade',
    'Preço de venda VKP2',
    'Valor Total Compra Seller',
  ];

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-xs overflow-y-auto">
      <div 
        id="batch-order-modal"
        className="bg-white rounded-2xl border border-slate-200 shadow-2xl w-full max-w-6xl max-h-[94vh] flex flex-col my-auto overflow-hidden animate-in fade-in zoom-in-95 duration-200"
      >
        {/* Modal Header */}
        <div className="px-6 py-4 bg-gradient-to-r from-slate-900 to-slate-800 text-white flex items-center justify-between border-b border-slate-700">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 rounded-xl bg-blue-600 flex items-center justify-center text-white shadow-md shadow-blue-500/30">
              <Layers className="w-5 h-5" />
            </div>
            <div>
              <div className="flex items-center gap-2">
                <h3 className="text-lg font-bold text-white tracking-tight">Send Multiple Orders at Once</h3>
                <span className="bg-blue-500/20 text-blue-300 border border-blue-400/30 text-[10px] font-semibold uppercase px-2 py-0.5 rounded-full">
                  13-Column Batch Ingestion
                </span>
              </div>
              <p className="text-xs text-slate-300">
                Paste spreadsheet table columns or upload CSV/TSV to ingest orders into MarketOps &amp; Databricks Lakehouse.
              </p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-1.5 text-slate-400 hover:text-white rounded-lg hover:bg-slate-700/60 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* 13-Column Schema Indicator Banner */}
        <div className="bg-slate-100/90 border-b border-slate-200 px-6 py-2 flex items-center gap-2 text-[11px] text-slate-600 overflow-x-auto whitespace-nowrap">
          <span className="font-semibold text-slate-800 flex items-center gap-1 shrink-0">
            <Info className="w-3.5 h-3.5 text-blue-600" />
            13 Columns Supported:
          </span>
          <div className="flex items-center gap-1 text-[10px] text-slate-500">
            {MARKETPLACE_COLUMNS.map((col, idx) => (
              <span 
                key={col} 
                className="bg-white px-2 py-0.5 rounded border border-slate-200 font-mono text-slate-700"
              >
                {idx + 1}. {col}
              </span>
            ))}
          </div>
        </div>

        {/* Modal Body */}
        <div className="p-6 flex-1 overflow-y-auto space-y-5">
          {/* Error Alert if any */}
          {errorMsg && (
            <div className="p-3.5 rounded-xl bg-rose-50 border border-rose-200 text-rose-800 text-xs flex items-center gap-2.5">
              <AlertCircle className="w-4 h-4 text-rose-600 shrink-0" />
              <span>{errorMsg}</span>
            </div>
          )}

          {/* Mode Tabs & Action shortcuts */}
          <div className="flex flex-wrap items-center justify-between gap-3 border-b border-slate-200 pb-3">
            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={() => setActiveTab('paste')}
                className={`px-3.5 py-1.5 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-colors ${
                  activeTab === 'paste'
                    ? 'bg-blue-600 text-white shadow-xs'
                    : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                }`}
              >
                <FileSpreadsheet className="w-3.5 h-3.5" />
                <span>Paste Table / Spreadsheet</span>
              </button>

              <button
                type="button"
                onClick={() => setActiveTab('file')}
                className={`px-3.5 py-1.5 rounded-lg text-xs font-semibold flex items-center gap-1.5 transition-colors ${
                  activeTab === 'file'
                    ? 'bg-blue-600 text-white shadow-xs'
                    : 'bg-slate-100 text-slate-600 hover:bg-slate-200'
                }`}
              >
                <UploadCloud className="w-3.5 h-3.5" />
                <span>Upload CSV / TSV File</span>
              </button>
            </div>

            {/* Quick Sample Ingestion Button */}
            <div className="flex items-center gap-2">
              <button
                type="button"
                onClick={() => {
                  setInputText(SAMPLE_BATCH_INPUT);
                  setActiveTab('paste');
                }}
                className="text-xs font-medium text-blue-600 hover:text-blue-700 bg-blue-50 hover:bg-blue-100 px-3 py-1.5 rounded-lg border border-blue-200 flex items-center gap-1.5 transition-colors"
                title="Load the 9 sample orders with all 13 columns (Óculos Sungait, Pochete Jucurri, Relógio CRRJU, Monitor Sceptre, etc.)"
              >
                <Sparkles className="w-3.5 h-3.5 text-blue-500" />
                <span>Load Sample (9 Orders with 13 Columns)</span>
              </button>

              <button
                type="button"
                onClick={() => setInputText('')}
                className="text-xs text-slate-400 hover:text-slate-600 px-2 py-1.5"
              >
                Clear
              </button>
            </div>
          </div>

          {/* Tab 1: Paste Table Input */}
          {activeTab === 'paste' && (
            <div className="space-y-2">
              <div className="flex items-center justify-between text-xs text-slate-500">
                <span>
                  Copy &amp; paste rows directly from <strong>Excel</strong>, <strong>Google Sheets</strong>, or TSV/CSV:
                </span>
                <span className="font-mono text-[11px] text-slate-400">
                  {inputText.split('\n').filter((l) => l.trim()).length} lines detected
                </span>
              </div>
              <textarea
                id="batch-order-textarea"
                rows={6}
                value={inputText}
                onChange={(e) => setInputText(e.target.value)}
                placeholder="Data da compra	SKU Marketplace	Descrição do Material	SKU Principal	Seller	Origem (País Seller)	Ordem de Cliente	Ordem de Compra	Sequencial	Sts de Compra	Quantidade	Preço de venda VKP2	Valor Total Compra Seller..."
                className="w-full font-mono text-xs p-3.5 rounded-xl border border-slate-300 focus:border-blue-500 focus:ring-1 focus:ring-blue-500 outline-none bg-slate-50/70 text-slate-800 placeholder:text-slate-400 resize-y leading-relaxed"
              />
            </div>
          )}

          {/* Tab 2: File Upload Zone */}
          {activeTab === 'file' && (
            <div
              onDragOver={(e) => {
                e.preventDefault();
                setDragOver(true);
              }}
              onDragLeave={() => setDragOver(false)}
              onDrop={handleDrop}
              onClick={() => fileInputRef.current?.click()}
              className={`border-2 border-dashed rounded-2xl p-8 text-center cursor-pointer transition-colors ${
                dragOver
                  ? 'border-blue-500 bg-blue-50/50'
                  : 'border-slate-300 hover:border-blue-400 bg-slate-50/50'
              }`}
            >
              <input
                ref={fileInputRef}
                type="file"
                accept=".csv,.tsv,.txt"
                className="hidden"
                onChange={(e) => {
                  if (e.target.files && e.target.files[0]) {
                    handleFileUpload(e.target.files[0]);
                  }
                }}
              />
              <div className="w-12 h-12 mx-auto rounded-full bg-blue-100 flex items-center justify-center text-blue-600 mb-3">
                <UploadCloud className="w-6 h-6" />
              </div>
              <h4 className="text-sm font-semibold text-slate-700">
                Click to browse or drag &amp; drop your spreadsheet file
              </h4>
              <p className="text-xs text-slate-400 mt-1">
                Supports .csv, .tsv, or tab-delimited text exports
              </p>
            </div>
          )}

          {/* Batch Options / Defaults */}
          <div className="p-3.5 rounded-xl bg-slate-50 border border-slate-200 grid grid-cols-1 sm:grid-cols-3 gap-3 text-xs">
            <div>
              <label className="block text-[11px] font-semibold uppercase tracking-wider text-slate-500 mb-1">
                Default Status Fallback
              </label>
              <select
                value={defaultStatus}
                onChange={(e) => setDefaultStatus(e.target.value)}
                className="w-full bg-white border border-slate-300 rounded-lg px-2.5 py-1.5 text-xs text-slate-800 focus:outline-none focus:border-blue-500"
              >
                <option value="Pending">Pending (Comprado)</option>
                <option value="Shipped">Shipped (Em Trânsito)</option>
                <option value="Delivered">Delivered (Entregue)</option>
                <option value="Cancelled">Cancelled (Cancelado)</option>
              </select>
            </div>

            <div>
              <label className="block text-[11px] font-semibold uppercase tracking-wider text-slate-500 mb-1">
                Destination Hub
              </label>
              <input
                type="text"
                value={destinationHub}
                onChange={(e) => setDestinationHub(e.target.value)}
                className="w-full bg-white border border-slate-300 rounded-lg px-2.5 py-1.5 text-xs text-slate-800 focus:outline-none focus:border-blue-500"
              />
            </div>

            <div className="flex items-center gap-2 pt-4">
              <label className="flex items-center gap-2 cursor-pointer select-none">
                <input
                  type="checkbox"
                  checked={syncDatabricks}
                  onChange={(e) => setSyncDatabricks(e.target.checked)}
                  className="rounded text-blue-600 focus:ring-blue-500 h-4 w-4"
                />
                <span className="text-xs font-medium text-slate-700 flex items-center gap-1">
                  <Database className="w-3.5 h-3.5 text-amber-500" />
                  Sync to Databricks Lakehouse
                </span>
              </label>
            </div>
          </div>

          {/* Real-Time Parsed Table Preview */}
          <div className="space-y-2">
            <div className="flex items-center justify-between">
              <div className="flex items-center gap-2">
                <h4 className="text-xs font-bold uppercase tracking-wider text-slate-700">
                  13-Columns Parsed Orders Preview
                </h4>
                <span className="bg-emerald-100 text-emerald-800 font-semibold px-2 py-0.5 rounded-full text-[11px]">
                  {validCount} valid order{validCount === 1 ? '' : 's'} ready
                </span>
                {invalidCount > 0 && (
                  <span className="bg-amber-100 text-amber-800 font-semibold px-2 py-0.5 rounded-full text-[11px]">
                    {invalidCount} invalid row{invalidCount === 1 ? '' : 's'}
                  </span>
                )}
              </div>
              <span className="text-[11px] text-slate-400">
                Horizontal scroll enabled to inspect all 13 columns
              </span>
            </div>

            {parsedOrders.length === 0 ? (
              <div className="p-8 text-center text-xs text-slate-400 bg-slate-50 rounded-xl border border-slate-200">
                No orders parsed yet. Paste order rows above or click "Load Sample" to begin.
              </div>
            ) : (
              <div className="border border-slate-200 rounded-xl overflow-x-auto shadow-2xs max-h-72">
                <table className="w-full text-left text-xs border-collapse min-w-[1100px]">
                  <thead className="bg-slate-100 text-slate-600 font-semibold uppercase text-[10px] tracking-wider sticky top-0 z-10 border-b border-slate-200 whitespace-nowrap">
                    <tr>
                      <th className="py-2.5 px-3">#</th>
                      <th className="py-2.5 px-3">Data Compra</th>
                      <th className="py-2.5 px-3">SKU Marketplace</th>
                      <th className="py-2.5 px-3">Descrição Material</th>
                      <th className="py-2.5 px-3">SKU Principal (ASIN)</th>
                      <th className="py-2.5 px-3">Seller</th>
                      <th className="py-2.5 px-3">Origem (País)</th>
                      <th className="py-2.5 px-3">Ordem Cliente</th>
                      <th className="py-2.5 px-3">Ordem Compra (PO)</th>
                      <th className="py-2.5 px-3">Seq</th>
                      <th className="py-2.5 px-3">Sts Compra</th>
                      <th className="py-2.5 px-3 text-center">Qtd</th>
                      <th className="py-2.5 px-3 text-right">Preço VKP2</th>
                      <th className="py-2.5 px-3 text-right">Valor Compra Seller</th>
                    </tr>
                  </thead>
                  <tbody className="divide-y divide-slate-100 bg-white whitespace-nowrap">
                    {parsedOrders.map((ord, idx) => (
                      <tr 
                        key={idx}
                        className={`hover:bg-slate-50/80 transition-colors ${
                          !ord.isValid ? 'bg-rose-50/60 text-rose-800' : ''
                        }`}
                      >
                        {/* Index */}
                        <td className="py-2 px-3 font-mono text-slate-400 text-[11px]">
                          {idx + 1}
                        </td>

                        {/* 1. Data da compra */}
                        <td className="py-2 px-3 text-slate-600 font-mono text-[11px]">
                          {ord.date_order}
                        </td>

                        {/* 2. SKU Marketplace */}
                        <td className="py-2 px-3 font-mono font-bold text-slate-800 text-[11px]">
                          {ord.sku}
                        </td>

                        {/* 3. Descrição do Material */}
                        <td className="py-2 px-3 max-w-[220px] truncate text-slate-800 font-medium" title={ord.product_name}>
                          {ord.product_name}
                        </td>

                        {/* 4. SKU Principal */}
                        <td className="py-2 px-3 font-mono text-blue-600 text-[11px]">
                          {ord.asin}
                        </td>

                        {/* 5. Seller */}
                        <td className="py-2 px-3 text-slate-700">
                          {ord.seller}
                        </td>

                        {/* 6. Origem (País Seller) */}
                        <td className="py-2 px-3 text-slate-600 text-[11px]">
                          {ord.seller_country || 'EUA'}
                        </td>

                        {/* 7. Ordem de Cliente */}
                        <td className="py-2 px-3 font-mono font-bold text-slate-700 text-[11px]">
                          {ord.customer_order_id || '—'}
                        </td>

                        {/* 8. Ordem de Compra */}
                        <td className="py-2 px-3 font-mono text-slate-600 text-[11px]">
                          {ord.purchase_order || '—'}
                        </td>

                        {/* 9. Sequencial */}
                        <td className="py-2 px-3 font-mono text-slate-500 text-[11px]">
                          {ord.sequencial || '10'}
                        </td>

                        {/* 10. Sts de Compra */}
                        <td className="py-2 px-3">
                          <span
                            className={`inline-flex items-center px-2 py-0.5 rounded-full text-[10px] font-bold ${
                              ord.status === 'Delivered'
                                ? 'bg-emerald-100 text-emerald-800'
                                : ord.status === 'Cancelled'
                                ? 'bg-rose-100 text-rose-800'
                                : ord.status === 'Shipped'
                                ? 'bg-blue-100 text-blue-800'
                                : 'bg-amber-100 text-amber-800'
                            }`}
                          >
                            {ord.sts_compra || ord.status}
                          </span>
                        </td>

                        {/* 11. Quantidade */}
                        <td className="py-2 px-3 font-mono text-center text-slate-800">
                          {ord.quantity || 1}
                        </td>

                        {/* 12. Preço de venda VKP2 */}
                        <td className="py-2 px-3 text-right font-mono font-semibold text-emerald-700">
                          {ord.vkp2_price !== undefined ? `R$ ${ord.vkp2_price.toFixed(2)}` : '—'}
                        </td>

                        {/* 13. Valor Total Compra Seller */}
                        <td className="py-2 px-3 text-right font-mono font-bold text-slate-800">
                          {ord.seller_usd_total !== undefined ? `$${ord.seller_usd_total.toFixed(2)}` : (
                            ord.total_price !== undefined ? `$${ord.total_price.toFixed(2)}` : '—'
                          )}
                        </td>
                      </tr>
                    ))}
                  </tbody>
                </table>
              </div>
            )}
          </div>
        </div>

        {/* Modal Footer */}
        <div className="px-6 py-4 bg-slate-50 border-t border-slate-200 flex items-center justify-between">
          <div className="text-xs text-slate-500">
            Ready to send <strong className="text-slate-800">{validCount} orders</strong> with 13 columns into the platform.
          </div>

          <div className="flex items-center gap-3">
            <button
              type="button"
              onClick={onClose}
              disabled={isSubmitting}
              className="px-4 py-2 text-xs font-semibold text-slate-600 hover:text-slate-800 hover:bg-slate-200 rounded-lg transition-colors"
            >
              Cancel
            </button>

            <button
              type="button"
              id="btn-confirm-batch-import"
              onClick={handleSubmitBatch}
              disabled={isSubmitting || validCount === 0}
              className="px-5 py-2.5 bg-blue-600 hover:bg-blue-700 text-white rounded-lg text-xs font-bold shadow-md shadow-blue-500/20 flex items-center gap-2 transition-all disabled:opacity-50 disabled:pointer-events-none"
            >
              {isSubmitting ? (
                <>
                  <div className="w-4 h-4 border-2 border-white/30 border-t-white rounded-full animate-spin" />
                  <span>Ingesting Orders...</span>
                </>
              ) : (
                <>
                  <UploadCloud className="w-4 h-4" />
                  <span>Send {validCount} Orders Now</span>
                </>
              )}
            </button>
          </div>
        </div>
      </div>
    </div>
  );
};
