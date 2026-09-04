import React, { useState } from 'react';
import { 
  X, 
  Bell, 
  Mail, 
  Smartphone, 
  CheckCircle2, 
  Send, 
  AlertCircle,
  ExternalLink,
  Volume2
} from 'lucide-react';
import { DeliveryAlert, Order } from '../types';

interface AlertsDrawerProps {
  isOpen: boolean;
  onClose: () => void;
  alerts: DeliveryAlert[];
  orders: Order[];
  onTriggerTestAlert: (orderId: string, eventType: string, customMsg?: string) => Promise<void>;
}

export const AlertsDrawer: React.FC<AlertsDrawerProps> = ({
  isOpen,
  onClose,
  alerts,
  orders,
  onTriggerTestAlert,
}) => {
  const [selectedOrderId, setSelectedOrderId] = useState<string>(orders[0]?.id || '');
  const [selectedEventType, setSelectedEventType] = useState('Out for Delivery');
  const [browserNotificationAllowed, setBrowserNotificationAllowed] = useState(
    typeof window !== 'undefined' && 'Notification' in window ? Notification.permission === 'granted' : false
  );
  const [isSending, setIsSending] = useState(false);
  const [feedback, setFeedback] = useState<string | null>(null);

  if (!isOpen) return null;

  const requestBrowserPushPermission = async () => {
    if (typeof window !== 'undefined' && 'Notification' in window) {
      try {
        const perm = await Notification.requestPermission();
        if (perm === 'granted') {
          setBrowserNotificationAllowed(true);
          new Notification('Marketplace Alerts Enabled', {
            body: 'You will now receive native desktop push notifications for order delivery updates!',
            icon: '/favicon.ico'
          });
          setFeedback('Native browser push notifications granted!');
          setTimeout(() => setFeedback(null), 3500);
        } else {
          setFeedback('Notification permission was not granted by browser.');
          setTimeout(() => setFeedback(null), 3500);
        }
      } catch (err: any) {
        console.warn('Could not request notification permission in iframe:', err);
      }
    }
  };

  const handleSendTest = async () => {
    if (!selectedOrderId) return;
    setIsSending(true);
    try {
      await onTriggerTestAlert(selectedOrderId, selectedEventType);
      setFeedback(`Alert successfully sent for order ${selectedOrderId}!`);
      setTimeout(() => setFeedback(null), 3500);
    } catch (err: any) {
      setFeedback('Error sending alert: ' + err.message);
    } finally {
      setIsSending(false);
    }
  };

  const getAlertIcon = (type: DeliveryAlert['type']) => {
    if (type === 'both') {
      return (
        <div className="flex items-center gap-1 text-indigo-600">
          <Mail className="w-3 h-3" />
          <Smartphone className="w-3 h-3" />
        </div>
      );
    }
    if (type === 'push') {
      return <Smartphone className="w-3.5 h-3.5 text-purple-600" />;
    }
    return <Mail className="w-3.5 h-3.5 text-blue-600" />;
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-end bg-slate-900/50 backdrop-blur-xs">
      <div 
        className="bg-white w-full max-w-md h-full shadow-2xl flex flex-col overflow-hidden text-xs border-l border-slate-200"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Drawer Header */}
        <div className="p-5 border-b border-slate-100 flex items-center justify-between bg-slate-50/60">
          <div className="flex items-center gap-3">
            <div className="p-2.5 rounded-xl bg-blue-50 text-blue-600">
              <Bell className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-sm font-bold text-slate-800">
                Automated Delivery Alerts
              </h2>
              <p className="text-[11px] text-slate-400">
                Live email &amp; push notification logs
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

        {/* Browser Push Permission Banner */}
        <div className="p-3.5 bg-blue-50/50 border-b border-blue-100/70 flex items-center justify-between gap-2">
          <div className="flex items-center gap-2.5">
            <Smartphone className="w-4 h-4 text-blue-600 shrink-0" />
            <div>
              <span className="font-semibold text-slate-800 block text-[11px]">
                Desktop Push Alerts:
              </span>
              <span className="text-[10px] text-slate-500">
                {browserNotificationAllowed ? 'Active in browser' : 'Enable native OS popup notifications'}
              </span>
            </div>
          </div>
          {!browserNotificationAllowed ? (
            <button
              onClick={requestBrowserPushPermission}
              className="px-3 py-1.5 rounded-lg bg-blue-600 text-white font-semibold text-[11px] hover:bg-blue-700 shadow-xs transition-colors"
            >
              Enable Push
            </button>
          ) : (
            <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-green-700 bg-green-50 px-2.5 py-0.5 rounded-full border border-green-200">
              <CheckCircle2 className="w-3 h-3 text-green-600" />
              Enabled
            </span>
          )}
        </div>

        {/* Feedback message */}
        {feedback && (
          <div className="p-3 bg-green-50 text-green-800 border-b border-green-200 flex items-center gap-2 text-[11px]">
            <CheckCircle2 className="w-3.5 h-3.5 text-green-600 shrink-0" />
            <span>{feedback}</span>
          </div>
        )}

        {/* Test Alert Dispatcher Accordion / Card */}
        <div className="p-4 bg-slate-50/70 border-b border-slate-200 space-y-3">
          <span className="font-bold text-slate-800 block text-xs">
            Trigger Real-time Delivery Alert Test
          </span>
          <div className="grid grid-cols-2 gap-2.5">
            <div>
              <label className="text-[10px] text-slate-500 font-semibold block mb-1 uppercase tracking-wider">
                Select Order
              </label>
              <select
                value={selectedOrderId}
                onChange={(e) => setSelectedOrderId(e.target.value)}
                className="w-full px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs text-slate-800 focus:outline-none focus:border-blue-500"
              >
                {orders.map((o) => (
                  <option key={o.id} value={o.id}>
                    PO: {o.purchase_order || o.id} - {o.customer_name}
                  </option>
                ))}
              </select>
            </div>
            <div>
              <label className="text-[10px] text-slate-500 font-semibold block mb-1 uppercase tracking-wider">
                Delivery Event
              </label>
              <select
                value={selectedEventType}
                onChange={(e) => setSelectedEventType(e.target.value)}
                className="w-full px-2.5 py-1.5 bg-white border border-slate-200 rounded-lg text-xs text-slate-800 focus:outline-none focus:border-blue-500"
              >
                <option value="Shipment Dispatched">Shipment Dispatched</option>
                <option value="In Transit">In Transit</option>
                <option value="Out for Delivery">Out for Delivery</option>
                <option value="Delivered">Delivered</option>
                <option value="Delivery Exception">Delivery Exception</option>
              </select>
            </div>
          </div>
          <button
            onClick={handleSendTest}
            disabled={isSending || !selectedOrderId}
            className="w-full py-2 px-3 rounded-xl bg-blue-600 text-white font-semibold hover:bg-blue-700 flex items-center justify-center gap-2 disabled:opacity-50 shadow-xs transition-colors"
          >
            <Send className="w-3.5 h-3.5" />
            <span>{isSending ? 'Dispatching...' : 'Dispatch Automated Email & Push'}</span>
          </button>
        </div>

        {/* Alerts List */}
        <div className="p-4 flex-1 overflow-y-auto space-y-3 bg-white">
          <div className="flex items-center justify-between text-slate-400 text-[11px] mb-1">
            <span>Recent Dispatched Notifications ({alerts.length})</span>
            <span className="font-mono text-[10px]">Auto-logged</span>
          </div>

          {alerts.length === 0 ? (
            <div className="text-center py-12 text-slate-400">
              <Bell className="w-8 h-8 mx-auto mb-2 opacity-30" />
              <p>No delivery alerts triggered yet.</p>
            </div>
          ) : (
            alerts.map((alt) => (
              <div
                key={alt.id}
                className="p-3.5 rounded-xl border border-slate-200 bg-white hover:border-blue-200 transition-colors shadow-2xs space-y-1.5"
              >
                <div className="flex items-center justify-between">
                  <span className="font-bold text-slate-800 text-[11px] flex items-center gap-1">
                    {alt.order_id}
                  </span>
                  <div className="flex items-center gap-1.5">
                    {getAlertIcon(alt.type)}
                    <span className="font-mono text-[10px] text-slate-400">
                      {alt.timestamp.split(' ')[1] || alt.timestamp}
                    </span>
                  </div>
                </div>

                <div className="font-semibold text-slate-800 text-[11px]">
                  {alt.subject}
                </div>

                <p className="text-slate-600 text-[11px] leading-relaxed">
                  {alt.message}
                </p>

                <div className="pt-2 border-t border-slate-100 flex items-center justify-between text-[10px] text-slate-400">
                  <span>To: <span className="font-mono text-slate-600">{alt.recipient_email}</span></span>
                  <span className="text-green-600 font-semibold">✓ Dispatched</span>
                </div>
              </div>
            ))
          )}
        </div>

        {/* Footer */}
        <div className="p-3.5 border-t border-slate-200 bg-slate-50 flex items-center justify-between text-[11px] text-slate-500">
          <span>Automated via Databricks trigger</span>
          <button
            onClick={onClose}
            className="px-3.5 py-1.5 rounded-lg bg-slate-200 hover:bg-slate-300 text-slate-800 font-medium transition-colors"
          >
            Close
          </button>
        </div>
      </div>
    </div>
  );
};
