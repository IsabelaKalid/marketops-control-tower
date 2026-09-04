import React from 'react';
import { 
  X, 
  Database, 
  Layers, 
  RefreshCw, 
  CheckCircle2, 
  ArrowRight, 
  Code, 
  BellRing,
  ExternalLink,
  Table
} from 'lucide-react';

interface DatabricksInfoModalProps {
  isOpen: boolean;
  onClose: () => void;
  onTriggerSyncAll: () => Promise<void>;
  isSyncing: boolean;
}

export const DatabricksInfoModal: React.FC<DatabricksInfoModalProps> = ({
  isOpen,
  onClose,
  onTriggerSyncAll,
  isSyncing,
}) => {
  if (!isOpen) return null;

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-3 sm:p-4 bg-slate-900/60 backdrop-blur-xs overflow-y-auto">
      <div 
        className="bg-white rounded-2xl border border-slate-200 shadow-2xl max-w-2xl w-full max-h-[92vh] flex flex-col overflow-hidden my-auto text-xs"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="px-6 py-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/70">
          <div className="flex items-center gap-3">
            <div className="p-2.5 rounded-xl bg-blue-50 text-blue-600">
              <Database className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-base font-bold text-slate-800">
                Databricks Lakehouse Logistics Architecture
              </h2>
              <p className="text-[11px] text-slate-400">
                Table: <code className="font-mono text-slate-700 font-semibold">gold_logistics.marketplace_shipments</code>
              </p>
            </div>
          </div>
          <button
            onClick={onClose}
            className="p-2 rounded-lg text-slate-400 hover:text-slate-700 hover:bg-slate-200/50 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Content */}
        <div className="p-6 space-y-5 overflow-y-auto flex-1">
          {/* Pipeline Flow Visualization */}
          <div className="p-4 rounded-xl bg-slate-50 border border-slate-200/80 space-y-3">
            <h3 className="font-bold text-slate-800 text-xs flex items-center gap-2">
              <Layers className="w-4 h-4 text-blue-600" />
              Live Lakehouse CDC &amp; Alert Ingestion Pipeline
            </h3>
            
            <div className="grid grid-cols-1 sm:grid-cols-3 gap-2.5 text-center text-xs">
              <div className="p-3 bg-white rounded-xl border border-slate-200 shadow-2xs space-y-1">
                <span className="font-bold text-slate-800 block">1. Marketplace API</span>
                <p className="text-[11px] text-slate-500">
                  Customer registers order with date, SKU, ASIN, and quantity.
                </p>
              </div>

              <div className="p-3 bg-blue-50/60 rounded-xl border border-blue-200 shadow-2xs space-y-1">
                <span className="font-bold text-blue-900 block">2. Databricks Delta</span>
                <p className="text-[11px] text-slate-600">
                  Joins carrier API streams (FedEx, UPS, Amazon) into <code className="font-mono text-[10px]">gold_logistics</code>.
                </p>
              </div>

              <div className="p-3 bg-green-50/60 rounded-xl border border-green-200 shadow-2xs space-y-1">
                <span className="font-bold text-green-900 block">3. Automated Alerts</span>
                <p className="text-[11px] text-slate-600">
                  CDC triggers instant email dispatch &amp; push alerts on status change.
                </p>
              </div>
            </div>
          </div>

          {/* Databricks Schema Definition */}
          <div className="space-y-2">
            <h4 className="font-bold text-slate-800 text-xs flex items-center gap-1.5">
              <Table className="w-4 h-4 text-blue-600" />
              Delta Lake Table Schema Definition
            </h4>
            <div className="p-3.5 bg-slate-900 text-slate-200 rounded-xl font-mono text-[11px] overflow-x-auto leading-relaxed border border-slate-800">
              <div className="text-amber-400">-- Databricks SQL Table: gold_logistics.marketplace_shipments</div>
              <div>CREATE TABLE IF NOT EXISTS gold_logistics.marketplace_shipments (</div>
              <div className="pl-4 text-slate-400">order_id STRING,</div>
              <div className="pl-4 text-slate-400">is_shipped BOOLEAN,</div>
              <div className="pl-4 text-slate-400">tracking_number STRING,</div>
              <div className="pl-4 text-slate-400">carrier STRING,</div>
              <div className="pl-4 text-slate-400">shipment_status STRING, <span className="text-slate-500">-- 'In Transit', 'Out for Delivery', 'Delivered'</span></div>
              <div className="pl-4 text-slate-400">estimated_delivery DATE,</div>
              <div className="pl-4 text-slate-400">invoice STRING,</div>
              <div className="pl-4 text-slate-400">di_date DATE,</div>
              <div className="pl-4 text-slate-400">entrada_cd DATE,</div>
              <div className="pl-4 text-slate-400">entrega_cliente DATE,</div>
              <div className="pl-4 text-slate-400">cancellation_reason STRING,</div>
              <div className="pl-4 text-slate-400">cancellation_updated_at TIMESTAMP,</div>
              <div className="pl-4 text-slate-400">actual_delivery_date TIMESTAMP,</div>
              <div className="pl-4 text-slate-400">origin_hub STRING,</div>
              <div className="pl-4 text-slate-400">destination STRING,</div>
              <div className="pl-4 text-slate-400">last_checkpoint_utc TIMESTAMP</div>
              <div>) USING DELTA;</div>
            </div>
          </div>

          {/* REST API Endpoints List */}
          <div className="space-y-2">
            <h4 className="font-bold text-slate-800 text-xs flex items-center gap-1.5">
              <Code className="w-4 h-4 text-blue-600" />
              REST API Endpoints Available
            </h4>
            <div className="space-y-1.5 font-mono text-[11px]">
              <div className="p-2.5 rounded-xl bg-slate-100 flex items-center justify-between">
                <div>
                  <span className="font-bold text-green-700 mr-2">GET</span>
                  <span className="text-slate-800">/api/orders</span>
                </div>
                <span className="text-slate-500 text-[10px]">Filter by search, date range &amp; status</span>
              </div>
              <div className="p-2.5 rounded-xl bg-slate-100 flex items-center justify-between">
                <div>
                  <span className="font-bold text-blue-700 mr-2">POST</span>
                  <span className="text-slate-800">/api/orders</span>
                </div>
                <span className="text-slate-500 text-[10px]">Insert new marketplace order</span>
              </div>
              <div className="p-2.5 rounded-xl bg-slate-100 flex items-center justify-between">
                <div>
                  <span className="font-bold text-purple-700 mr-2">POST</span>
                  <span className="text-slate-800">/api/orders/:id/sync-databricks</span>
                </div>
                <span className="text-slate-500 text-[10px]">Pull live Databricks shipment event</span>
              </div>
              <div className="p-2.5 rounded-xl bg-slate-100 flex items-center justify-between">
                <div>
                  <span className="font-bold text-amber-700 mr-2">POST</span>
                  <span className="text-slate-800">/api/databricks/sync-all</span>
                </div>
                <span className="text-slate-500 text-[10px]">Bulk delta table ingestion</span>
              </div>
              <div className="p-2.5 rounded-xl bg-slate-100 flex items-center justify-between">
                <div>
                  <span className="font-bold text-green-700 mr-2">GET</span>
                  <span className="text-slate-800">/api/dashboard/stats</span>
                </div>
                <span className="text-slate-500 text-[10px]">Order volume &amp; delivery metrics</span>
              </div>
              <div className="p-2.5 rounded-xl bg-slate-100 flex items-center justify-between">
                <div>
                  <span className="font-bold text-green-700 mr-2">GET</span>
                  <span className="text-slate-800">/api/alerts</span>
                </div>
                <span className="text-slate-500 text-[10px]">Automated email/push dispatch log</span>
              </div>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="px-6 py-4 border-t border-slate-100 bg-slate-50/70 flex items-center justify-between">
          <button
            onClick={onTriggerSyncAll}
            disabled={isSyncing}
            className="inline-flex items-center gap-2 px-4 py-2 rounded-xl bg-blue-600 hover:bg-blue-700 text-white font-semibold transition-colors disabled:opacity-50 shadow-xs"
          >
            <RefreshCw className={`w-3.5 h-3.5 ${isSyncing ? 'animate-spin' : ''}`} />
            <span>{isSyncing ? 'Running Lakehouse Sync...' : 'Trigger Full Databricks Sync Now'}</span>
          </button>

          <button
            onClick={onClose}
            className="px-4 py-2 rounded-xl text-xs font-semibold text-slate-700 bg-slate-200 hover:bg-slate-300 transition-colors"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  );
};
