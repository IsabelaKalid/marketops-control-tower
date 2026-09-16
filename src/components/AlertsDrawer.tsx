import React, { useEffect, useState } from 'react';
import {
  AlertCircle,
  Bell,
  CheckCircle2,
  Mail,
  Send,
  X,
} from 'lucide-react';
import { DeliveryAlert, Order } from '../types';
import { useAuth } from '../auth/AuthProvider';

interface AlertsDrawerProps {
  isOpen: boolean;
  onClose: () => void;
  alerts: DeliveryAlert[];
  orders: Order[];
  onSendDailyAlerts: (date: string) => Promise<{ found: number; sent: number; simulated: number; failed: number; skipped: number; recipients: string[] }>;
  onLoadDailyChanges: (date: string) => Promise<Array<{ order_id: string; customer_name: string; status: string }>>;
  onLoadChangeDates: () => Promise<Array<{ date: string; count: number }>>;
  language?: 'en' | 'pt';
}

const statusPresentation = (status: DeliveryAlert['status'], pt: boolean) => {
  switch (status) {
    case 'sent':
    case 'delivered':
      return { label: pt ? 'Enviado' : 'Sent', className: 'bg-emerald-100 text-emerald-800 border-emerald-200' };
    case 'simulated':
      return { label: pt ? 'Somente log' : 'Log only', className: 'bg-amber-100 text-amber-900 border-amber-200' };
    case 'failed':
      return { label: pt ? 'Falhou' : 'Failed', className: 'bg-rose-100 text-rose-800 border-rose-200' };
    default:
      return { label: pt ? 'Na fila' : 'Queued', className: 'bg-blue-100 text-blue-800 border-blue-200' };
  }
};

export const AlertsDrawer: React.FC<AlertsDrawerProps> = ({
  isOpen,
  onClose,
  alerts,
  onSendDailyAlerts,
  onLoadDailyChanges,
  onLoadChangeDates,
  language = 'en',
}) => {
  const pt = language === 'pt';
  const { canManageOrders } = useAuth();
  const canTestAlerts = canManageOrders;
  const [changeDate, setChangeDate] = useState(() => new Date().toISOString().slice(0, 10));
  const [dailyChanges, setDailyChanges] = useState<Array<{ order_id: string; customer_name: string; status: string }>>([]);
  const [changeDates, setChangeDates] = useState<Array<{ date: string; count: number }>>([]);
  const [isLoadingChanges, setIsLoadingChanges] = useState(false);
  const [isSending, setIsSending] = useState(false);
  const [feedback, setFeedback] = useState<{ message: string; error?: boolean } | null>(null);

  useEffect(() => {
    if (!isOpen) return;
    void onLoadChangeDates().then(dates => {
      setChangeDates(dates);
      if (dates.length && !dates.some(item => item.date === changeDate)) setChangeDate(dates[0].date);
    }).catch(error => setFeedback({ message: String(error), error: true }));
  }, [isOpen, onLoadChangeDates]);

  useEffect(() => {
    if (!isOpen || !changeDate) return;
    let active = true;
    setIsLoadingChanges(true);
    void onLoadDailyChanges(changeDate)
      .then(changes => { if (active) setDailyChanges(changes); })
      .catch(error => { if (active) setFeedback({ message: String(error), error: true }); })
      .finally(() => { if (active) setIsLoadingChanges(false); });
    return () => { active = false; };
  }, [isOpen, changeDate, onLoadDailyChanges]);

  if (!isOpen) return null;

  const handleSendDaily = async () => {
    setIsSending(true);
    setFeedback(null);
    try {
      const result = await onSendDailyAlerts(changeDate);
      const destination = result.recipients.length
        ? (pt ? ` Destino: ${result.recipients.join(', ')}.` : ` Recipient: ${result.recipients.join(', ')}.`)
        : '';
      setFeedback({
        message: pt
          ? `${result.found} alteração(ões) encontrada(s): ${result.sent} enviada(s), ${result.simulated} simulada(s), ${result.failed} falha(s) e ${result.skipped} já processada(s).${destination}`
          : `${result.found} change(s) found: ${result.sent} sent, ${result.simulated} simulated, ${result.failed} failed and ${result.skipped} already processed.${destination}`,
        error: result.failed > 0,
      });
    } catch (error) {
      setFeedback({ message: `${pt ? 'Erro ao processar alerta' : 'Alert error'}: ${error instanceof Error ? error.message : String(error)}`, error: true });
    } finally {
      setIsSending(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-end bg-slate-950/60 backdrop-blur-xs">
      <div
        className="bg-white w-full max-w-lg h-full shadow-2xl flex flex-col overflow-hidden text-xs border-l border-slate-200"
        onClick={(event) => event.stopPropagation()}
      >
        <div className="p-5 border-b border-slate-200 flex items-center justify-between bg-slate-50/70">
          <div className="flex items-center gap-3">
            <div className="p-2.5 rounded-xl bg-blue-100 text-blue-700">
              <Bell className="w-5 h-5" />
            </div>
            <div>
              <h2 className="text-sm font-bold text-slate-900">{pt ? 'Alertas automáticos de entrega' : 'Automated Delivery Alerts'}</h2>
              <p className="text-[11px] text-slate-500">{pt ? 'E-mails de status e histórico operacional' : 'Status emails and operational history'}</p>
            </div>
          </div>
          <button onClick={onClose} className="p-2 rounded-lg border border-slate-400 bg-slate-700 text-white hover:bg-slate-600 transition-colors" aria-label={pt ? 'Fechar' : 'Close'}>
            <X className="w-5 h-5" />
          </button>
        </div>

        {canTestAlerts && (
          <div className="px-4 pt-4 bg-slate-50/60">
            <div className="rounded-xl border border-blue-200 bg-blue-50/70 p-3 text-[11px] text-blue-950 leading-relaxed">
              <strong>{pt ? 'Fluxo planejado:' : 'Planned flow:'}</strong>{' '}
              {pt
                ? 'as mudanças recebidas do Databricks disparam automaticamente o e-mail correto. No teste local, escolha uma data para processar todas as alterações daquele dia em lote.'
                : 'changes received from Databricks automatically trigger the correct email. For local testing, choose a date to process every change from that day as a batch.'}
            </div>
          </div>
        )}

        {canTestAlerts && (
          <div className="p-4 bg-slate-50/60 border-b border-slate-200 space-y-3">
            <div className="rounded-xl border border-slate-200 bg-white p-3.5 space-y-3">
              <div className="flex items-center gap-2 font-bold text-slate-900">
                <Mail className="w-4 h-4 text-blue-700" />
                {pt ? 'Enviar atualizações do dia' : 'Send daily updates'}
              </div>
              <label className="block space-y-1">
                <span className="text-[10px] text-slate-600 font-semibold uppercase tracking-wider">{pt ? 'Data das alterações' : 'Change date'}</span>
                <input
                  type="date"
                  value={changeDate}
                  onChange={(event) => setChangeDate(event.target.value)}
                  className="w-full px-3 py-2 bg-white border border-slate-300 rounded-lg text-xs text-slate-900 focus:outline-none focus:border-blue-500"
                />
                <span className="block text-[10px] text-slate-500">
                  {pt ? 'O sistema encontra os pedidos alterados nessa data e usa automaticamente o status atual de cada um.' : 'The system finds orders changed on this date and automatically uses each current status.'}
                </span>
              </label>
              {changeDates.length > 0 && (
                <div>
                  <span className="text-[10px] text-slate-600 font-semibold uppercase tracking-wider">{pt ? 'Dias com mudanças' : 'Days with changes'}</span>
                  <div className="mt-1.5 flex flex-wrap gap-1.5">
                    {changeDates.map(item => (
                      <button key={item.date} type="button" onClick={() => setChangeDate(item.date)} className={`rounded-lg border px-2.5 py-1.5 text-[10px] font-bold ${changeDate === item.date ? 'border-blue-500 bg-blue-600 text-white' : 'border-slate-300 bg-white text-slate-700'}`}>
                        {item.date.split('-').reverse().join('/')} · {item.count}
                      </button>
                    ))}
                  </div>
                </div>
              )}
              <div className="max-h-32 overflow-y-auto rounded-lg bg-slate-100/80 p-2.5 text-[10px] text-slate-700 space-y-1.5">
                {isLoadingChanges ? (pt ? 'Buscando alterações...' : 'Loading changes...') : dailyChanges.length === 0 ? (
                  pt ? 'Nenhuma mudança de status encontrada nesta data.' : 'No status changes found for this date.'
                ) : dailyChanges.map(change => (
                  <div key={change.order_id} className="flex items-center justify-between gap-2 border-b border-slate-200 pb-1 last:border-0">
                    <span><strong>{change.order_id}</strong> — {change.customer_name}</span>
                    <span className="font-semibold text-blue-700">{change.status}</span>
                  </div>
                ))}
              </div>
              <button onClick={handleSendDaily} disabled={isSending || !changeDate || dailyChanges.length === 0} className="w-full py-2.5 px-3 rounded-xl bg-blue-600 text-white font-semibold hover:bg-blue-700 flex items-center justify-center gap-2 disabled:opacity-50 transition-colors">
                <Send className="w-3.5 h-3.5" />
                <span>{isSending ? (pt ? 'Processando lote...' : 'Processing batch...') : (pt ? 'Enviar todas as atualizações' : 'Send all updates')}</span>
              </button>
            </div>
          </div>
        )}

        {feedback && (
          <div className={`p-3 border-b flex items-center gap-2 text-[11px] ${feedback.error ? 'bg-rose-50 text-rose-900 border-rose-200' : 'bg-emerald-50 text-emerald-900 border-emerald-200'}`}>
            {feedback.error ? <AlertCircle className="w-3.5 h-3.5 shrink-0" /> : <CheckCircle2 className="w-3.5 h-3.5 shrink-0" />}
            <span>{feedback.message}</span>
          </div>
        )}

        <div className="p-4 flex-1 overflow-y-auto space-y-3 bg-white">
          <div className="flex items-center justify-between text-slate-500 text-[11px] mb-1">
            <span>{pt ? `Últimos alertas (${alerts.length})` : `Recent alerts (${alerts.length})`}</span>
            <span className="font-mono text-[10px]">{pt ? 'log do backend' : 'backend log'}</span>
          </div>

          {alerts.length === 0 ? (
            <div className="text-center py-12 text-slate-500">
              <Bell className="w-8 h-8 mx-auto mb-2 opacity-40" />
              <p>{pt ? 'Nenhum alerta processado ainda.' : 'No alerts processed yet.'}</p>
            </div>
          ) : alerts.map(alert => {
            const presentation = statusPresentation(alert.status, pt);
            return (
              <div key={alert.id} className="p-3.5 rounded-xl border border-slate-200 bg-white hover:border-blue-300 transition-colors shadow-xs space-y-1.5">
                <div className="flex items-center justify-between gap-2">
                  <span className="font-bold text-slate-900 text-[11px]">{alert.order_id}</span>
                  <span className={`inline-flex items-center px-2 py-0.5 rounded-full border text-[10px] font-bold ${presentation.className}`}>{presentation.label}</span>
                </div>
                <div className="font-semibold text-slate-900 text-[11px]">{alert.subject}</div>
                <p className="text-slate-600 text-[11px] leading-relaxed">{alert.message}</p>
                <div className="pt-2 border-t border-slate-100 space-y-1 text-[10px] text-slate-500">
                  <div className="flex justify-between gap-2"><span>{pt ? 'Destino' : 'To'}: <span className="font-mono text-slate-700">{alert.recipient_email || '—'}</span></span><span className="font-mono">{alert.timestamp}</span></div>
                  {alert.intended_email && alert.intended_email !== alert.recipient_email && <div>{pt ? 'E-mail original do cliente' : 'Original customer email'}: <span className="font-mono text-slate-700">{alert.intended_email}</span></div>}
                  {alert.recipient_phone && <div>{pt ? 'Telefone cadastrado' : 'Registered phone'}: <span className="font-mono text-slate-700">{alert.recipient_phone}</span></div>}
                  {alert.delivery_detail && <div className="text-slate-600">{alert.delivery_detail}</div>}
                </div>
              </div>
            );
          })}
        </div>

        <div className="p-3.5 border-t border-slate-200 bg-slate-50 flex items-center justify-between text-[11px] text-slate-600">
          <span>{pt ? 'Mudança de status → backend → e-mail → histórico' : 'Status change → backend → email → history'}</span>
          <button onClick={onClose} className="px-4 py-2 rounded-lg border border-blue-300 bg-blue-600 hover:bg-blue-500 text-white font-bold shadow-sm transition-colors">{pt ? 'Fechar' : 'Close'}</button>
        </div>
      </div>
    </div>
  );
};
