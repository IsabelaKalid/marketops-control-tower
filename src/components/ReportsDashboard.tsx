import React, { useEffect, useMemo, useState } from 'react';
import { AlertCircle, CheckCircle2, CircleDollarSign, FileCheck2, Loader2, Mail, Package, Send, Timer, TrendingUp } from 'lucide-react';
import { DashboardStats, Order } from '../types';

interface Props { orders: Order[]; stats: DashboardStats | null; }
const money = (v: number) => v.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
const businessDays = (start?: string, end?: string) => {
  if (!start || !end) return null;
  const current = new Date(`${start.slice(0, 10)}T00:00:00`);
  const finish = new Date(`${end.slice(0, 10)}T00:00:00`);
  if (Number.isNaN(current.getTime()) || Number.isNaN(finish.getTime())) return null;
  if (finish < current) return 0;
  let total = 0;
  current.setDate(current.getDate() + 1);
  while (current <= finish) {
    const weekday = current.getDay();
    if (weekday !== 0 && weekday !== 6) total += 1;
    current.setDate(current.getDate() + 1);
  }
  return total;
};

const MonthlyLineChart = ({ data, valueKey, title, description, formatter, stroke }: {
  data: { month: string; [key: string]: string | number }[];
  valueKey: string;
  title: string;
  description: string;
  formatter: (value: number) => string;
  stroke: string;
}) => {
  const width = Math.max(720, data.length * 76);
  const height = 250;
  // Reserva espaço suficiente para rótulos como "R$ 98.325,00" sem cortar o R.
  const padding = { left: 96, right: 24, top: 28, bottom: 42 };
  const plotWidth = width - padding.left - padding.right;
  const plotHeight = height - padding.top - padding.bottom;
  const maxValue = Math.max(1, ...data.map(item => Number(item[valueKey]) || 0));
  const x = (index: number) => padding.left + (data.length <= 1 ? plotWidth / 2 : index * plotWidth / (data.length - 1));
  const y = (value: number) => padding.top + plotHeight - (value / maxValue) * plotHeight;
  const points = data.map((item, index) => `${x(index)},${y(Number(item[valueKey]) || 0)}`).join(' ');
  const labelStep = Math.max(1, Math.ceil(data.length / 12));

  return <section className="bg-white border rounded-2xl p-5 overflow-hidden">
    <h2 className="font-bold">{title}</h2>
    <p className="text-xs text-slate-500 mt-1">{description}</p>
    {data.length === 0 ? <p className="py-16 text-center text-sm text-slate-400">No data for the selected period.</p> :
      <div className="overflow-x-auto mt-4 pb-2">
        <svg width={width} height={height} role="img" aria-label={title}>
          {[0, 0.25, 0.5, 0.75, 1].map(tick => {
            const value = maxValue * tick;
            const lineY = y(value);
            return <g key={tick}><line x1={padding.left} y1={lineY} x2={width-padding.right} y2={lineY} stroke="#e2e8f0"/><text x={padding.left-8} y={lineY+4} textAnchor="end" fontSize="10" fill="#64748b">{formatter(value)}</text></g>;
          })}
          <polyline fill="none" stroke={stroke} strokeWidth="3" strokeLinejoin="round" strokeLinecap="round" points={points}/>
          {data.map((item,index) => {
            const value=Number(item[valueKey])||0;
            return <g key={item.month as string}><circle cx={x(index)} cy={y(value)} r="4" fill="white" stroke={stroke} strokeWidth="3"><title>{item.month}: {formatter(value)}</title></circle>{(index%labelStep===0||index===data.length-1)&&<text x={x(index)} y={height-15} textAnchor="middle" fontSize="10" fill="#64748b">{item.month}</text>}</g>;
          })}
        </svg>
      </div>}
  </section>;
};

export const ReportsDashboard: React.FC<Props> = ({ orders, stats }) => {
  const [reportLanguage, setReportLanguage] = useState<'pt' | 'en'>(() => localStorage.getItem('marketops-report-language') === 'en' ? 'en' : 'pt');
  const pt = reportLanguage === 'pt';
  const [to, setTo] = useState(() => localStorage.getItem('marketops-report-to') || '');
  const [cc, setCc] = useState(() => localStorage.getItem('marketops-report-cc') || '');
  const [subject, setSubject] = useState(`Monitoramento - Vendas Marketplace - ${new Date().toLocaleDateString('pt-BR')}`);
  const [message, setMessage] = useState('Prezados,\n\nSegue o monitoramento atualizado dos pedidos. A planilha detalhada está anexada.');
  const [sending, setSending] = useState(false); const [feedback, setFeedback] = useState<{ok:boolean;text:string}|null>(null);
  useEffect(() => { localStorage.setItem('marketops-report-to', to); }, [to]);
  useEffect(() => { localStorage.setItem('marketops-report-cc', cc); }, [cc]);
  useEffect(() => { localStorage.setItem('marketops-report-language', reportLanguage); }, [reportLanguage]);
  const changeReportLanguage = (language: 'pt' | 'en') => {
    setReportLanguage(language);
    setSubject(language === 'pt'
      ? `Monitoramento - Vendas Marketplace - ${new Date().toLocaleDateString('pt-BR')}`
      : `Monitoring Report - Marketplace Sales - ${new Date().toLocaleDateString('en-US')}`);
    setMessage(language === 'pt'
      ? 'Prezados,\n\nSegue o monitoramento atualizado dos pedidos. A planilha detalhada está anexada.'
      : 'Hello,\n\nPlease find the updated order monitoring report below. The detailed spreadsheet is attached.');
  };
  const data = useMemo(() => {
    const lines = orders.flatMap(o => o.items?.length ? o.items : [o]); const today = new Date(); today.setHours(0,0,0,0); const todayText = today.toISOString().slice(0,10);
    const valid = orders.filter(o => o.status !== 'Cancelled'); const open = orders.filter(o => o.status === 'Pending' || o.status === 'Shipped');
    const elapsed = (o: Order) => businessDays(o.date_order, todayText);
    const onTime = open.filter(o => { const d=elapsed(o); return d !== null && d <= 20; });
    const risk = open.filter(o => { const d=elapsed(o); return d !== null && d >= 21 && d <= 25; });
    const overdue = open.filter(o => { const d=elapsed(o); return d !== null && d > 25; });
    const unclassified = open.filter(o => elapsed(o) === null);
    const lead = orders.map(o => businessDays(o.date_order,o.shipment.estimated_delivery)).filter((d):d is number => d !== null && d >= 0);
    const products = new Map<string,{name:string;qty:number;value:number}>();
    const months = new Map<string,{ids:Set<string>;qty:number;salesBrl:number;cancelled:number}>();
    lines.forEach(i => { const p=products.get(i.sku)||{name:i.product_name,qty:0,value:0}; p.qty+=i.quantity;p.value+=i.total_price;products.set(i.sku,p); });
    orders.forEach(order => { const month=order.date_order?.slice(0,7)||'No date'; const x=months.get(month)||{ids:new Set<string>(),qty:0,salesBrl:0,cancelled:0}; x.ids.add(order.purchase_order||order.id); x.qty+=order.quantity; if(order.status==='Cancelled')x.cancelled+=1; else { const items=order.items?.length?order.items:[order]; x.salesBrl+=items.filter(item=>item.status!=='Cancelled').reduce((sum,item)=>sum+(item.vkp2_price??0)*item.quantity,0); } months.set(month,x); });
    const ps=[...products.entries()].map(([sku,v])=>({sku,...v})); const cutoff=new Date(today);cutoff.setDate(today.getDate()-7);
    const validLines = lines.filter(item => item.status !== 'Cancelled');
    const totalVkp2 = validLines.reduce((sum, item) => sum + (item.vkp2_price ?? 0) * item.quantity, 0);
    return { lines,valid,open,overdue,risk,onTime,unclassified,totalVkp2,avgLead:lead.length?Math.round(lead.reduce((a,b)=>a+b,0)/lead.length):0,
      statuses:['Pending','Shipped','Delivered','Cancelled'].map(status=>({status,count:orders.filter(o=>o.status===status).length})),
      months:[...months.entries()].sort(([a],[b])=>a.localeCompare(b)).map(([month,v])=>({month,orders:v.ids.size,qty:v.qty,salesBrl:Math.round(v.salesBrl*100)/100,cancelled:v.cancelled})),
      topQty:[...ps].sort((a,b)=>b.qty-a.qty).slice(0,10),topValue:[...ps].sort((a,b)=>b.value-a.value).slice(0,10),
      recent:lines.filter(i=>i.date_order&&new Date(i.date_order)>=cutoff).sort((a,b)=>b.date_order.localeCompare(a.date_order)).slice(0,20) };
  },[orders]);
  const maxStatus=Math.max(1,...data.statuses.map(x=>x.count));
  const send=async(e:React.FormEvent)=>{e.preventDefault();setSending(true);setFeedback(null);try{const r=await fetch('/api/reports/email',{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify({to,cc,subject,message,language:reportLanguage})});const j=await r.json();if(!r.ok)throw new Error(j.error||(pt?'Não foi possível enviar.':'Unable to send.'));setFeedback({ok:true,text:pt?`Relatório enviado para ${to}.`:`Report sent to ${to}.`});}catch(err:any){setFeedback({ok:false,text:err.message});}finally{setSending(false);}};
  const kpis:any[]=[[pt?'Total de pedidos':'Total Orders',orders.length,Package,'bg-blue-50 text-blue-600'],[pt?'Pedidos válidos':'Valid Orders',data.valid.length,FileCheck2,'bg-indigo-50 text-indigo-600'],[pt?'Pedidos em aberto':'Open Orders',data.open.length,TrendingUp,'bg-amber-50 text-amber-600'],[pt?'Entregues':'Delivered',stats?.delivered_orders??0,CheckCircle2,'bg-emerald-50 text-emerald-600'],[pt?'Cancelados':'Cancelled',stats?.cancelled_orders??0,AlertCircle,'bg-rose-50 text-rose-600'],[pt?'Vendas VKP2 (R$)':'VKP2 Sales (BRL)',`R$ ${money(data.totalVkp2)}`,CircleDollarSign,'bg-emerald-50 text-emerald-700'],[pt?'Custo seller (USD)':'Seller Cost (USD)',`$${money(stats?.total_revenue??0)}`,CircleDollarSign,'bg-green-50 text-green-600'],[pt?'Risco (21 a 25 dias úteis)':'Risk (21–25 business days)',data.risk.length,Timer,'bg-orange-50 text-orange-600'],[pt?'Prazo médio previsto':'Average Expected Lead Time',`${data.avgLead} ${pt?'dias úteis':'business days'}`,Timer,'bg-cyan-50 text-cyan-600']];
  return <div className="space-y-6">
    <div className="flex flex-col sm:flex-row sm:items-center justify-between gap-3"><div><h1 className="text-2xl font-bold text-slate-900">{pt?'Dashboard de Monitoramento':'Monitoring Dashboard'}</h1><p className="text-sm text-slate-500 mt-1">{pt?'Pedidos válidos = total menos cancelados. Prazos em dias úteis.':'Valid orders = total minus cancelled. Lead times use business days.'}</p></div><div className="inline-flex self-start rounded-xl border border-slate-200 bg-white p-1"><button onClick={()=>changeReportLanguage('pt')} className={`px-3 py-1.5 rounded-lg text-xs font-bold ${pt?'bg-blue-600 text-white':'text-slate-500'}`}>PT</button><button onClick={()=>changeReportLanguage('en')} className={`px-3 py-1.5 rounded-lg text-xs font-bold ${!pt?'bg-blue-600 text-white':'text-slate-500'}`}>EN</button></div></div>
    <div className="grid grid-cols-1 sm:grid-cols-2 xl:grid-cols-4 gap-4">{kpis.map(([l,v,I,c])=><div key={l} className="bg-white border rounded-2xl p-4 shadow-sm flex gap-3 items-center"><div className={`p-3 rounded-xl ${c}`}><I className="w-5 h-5"/></div><div><p className="text-[10px] uppercase font-bold text-slate-500">{l}</p><p className="text-xl font-bold">{v}</p></div></div>)}</div>
    <div className="grid grid-cols-1 xl:grid-cols-2 gap-6">
      <section className="bg-white border rounded-2xl p-5"><h2 className="font-bold">{pt?'Prazo — pedidos em aberto':'Lead Time — Open Orders'}</h2><p className="text-xs text-slate-500 mt-1">{pt?'No prazo até 20; risco de 21 a 25; atrasado acima de 25 dias úteis.':'On time through 20; risk from 21–25; overdue above 25 business days.'}</p><div className="grid grid-cols-2 gap-3 mt-4">{[[pt?'No prazo (até 20 dias úteis)':'On Time (up to 20 business days)',data.onTime.length,'bg-emerald-50 text-emerald-700'],[pt?'Risco (21 a 25 dias úteis)':'Risk (21–25 business days)',data.risk.length,'bg-amber-50 text-amber-700'],[pt?'Atrasado (mais de 25 dias úteis)':'Overdue (more than 25 business days)',data.overdue.length,'bg-rose-50 text-rose-700'],[pt?'Total em aberto':'Total Open',data.open.length,'bg-blue-50 text-blue-700']].map(([l,v,c]:any)=><div key={l} className={`p-4 rounded-xl ${c}`}><p className="text-xs font-semibold">{l}</p><p className="text-2xl font-bold">{v}</p></div>)}</div></section>
      <section className="bg-white border rounded-2xl p-5"><h2 className="font-bold">{pt?'Pedidos por status':'Orders by Status'}</h2><div className="space-y-3 mt-4">{data.statuses.map(x=><div key={x.status}><div className="flex justify-between text-xs"><span>{pt?({Pending:'Pendente',Shipped:'Em trânsito',Delivered:'Entregue',Cancelled:'Cancelado'} as Record<string,string>)[x.status]:x.status}</span><b>{x.count}</b></div><div className="h-2.5 bg-slate-100 rounded mt-1"><div className="h-full bg-blue-600 rounded" style={{width:`${x.count/maxStatus*100}%`}}/></div></div>)}</div></section>
      <section className="bg-white border rounded-2xl p-5 xl:col-span-2"><h2 className="font-bold">{pt?'Resumo do período filtrado':'Filtered Period Summary'}</h2><div className="grid grid-cols-2 gap-3 mt-4"><div className="rounded-xl bg-emerald-50 p-4"><p className="text-xs font-semibold text-emerald-700">{pt?'Faturamento':'Sales Revenue'}</p><p className="text-xl font-bold text-emerald-800">R$ {money(data.totalVkp2)}</p></div><div className="rounded-xl bg-rose-50 p-4"><p className="text-xs font-semibold text-rose-700">{pt?'Pedidos cancelados':'Cancelled Orders'}</p><p className="text-xl font-bold text-rose-800">{orders.filter(o=>o.status==='Cancelled').length}</p></div></div><p className="mt-3 text-xs text-slate-500">{pt?'Os valores refletem os filtros selecionados no menu de pedidos.':'Values reflect the filters selected in the orders menu.'}</p></section>
    </div>
    <div className="grid grid-cols-1 gap-6">
      <MonthlyLineChart data={data.months} valueKey="salesBrl" title={pt?'Faturamento mensal (BRL)':'Monthly Sales Revenue (BRL)'} description={pt?'Vendas VKP2 por mês da compra, sem pedidos cancelados.':'VKP2 sales by purchase month, excluding cancelled orders.'} formatter={value=>`R$ ${money(value)}`} stroke="#059669"/>
      <MonthlyLineChart data={data.months} valueKey="cancelled" title={pt?'Cancelamentos mensais':'Monthly Cancelled Orders'} description={pt?'Pedidos cancelados por ano e mês.':'Cancelled orders by year and month.'} formatter={value=>Math.round(value).toString()} stroke="#e11d48"/>
    </div>
    <div className="grid grid-cols-1 xl:grid-cols-2 gap-6">{[[pt?'Top 10 por quantidade':'Top 10 by Quantity',data.topQty],[pt?'Top 10 por custo seller':'Top 10 by Seller Cost',data.topValue]].map(([title,list]:any)=><section key={title} className="bg-white border rounded-2xl overflow-hidden"><h2 className="font-bold p-4 border-b">{title}</h2><table className="w-full text-xs"><thead className="bg-slate-900 text-white"><tr><th className="p-2">#</th><th className="p-2 text-left">SKU / {pt?'Produto':'Product'}</th><th className="p-2 text-right">{pt?'Qtd.':'Qty.'}</th><th className="p-2 text-right">{pt?'Custo USD':'Cost USD'}</th></tr></thead><tbody>{list.map((x:any,i:number)=><tr key={x.sku} className="border-b"><td className="p-2 text-center">{i+1}</td><td className="p-2"><b>{x.sku}</b><div className="max-w-72 truncate text-slate-500">{x.name}</div></td><td className="p-2 text-right">{x.qty}</td><td className="p-2 text-right">${money(x.value)}</td></tr>)}</tbody></table></section>)}</div>
    <section className="bg-white border rounded-2xl overflow-hidden"><h2 className="font-bold p-4 border-b">{pt?'Pedidos — últimos 7 dias':'Orders — Last 7 Days'}</h2><div className="overflow-x-auto"><table className="w-full text-xs whitespace-nowrap"><thead className="bg-slate-900 text-white"><tr>{(pt?['Data','Ordem Cliente','PO','SKU','Produto','Qtd.','Status','Rastreio','Previsão']:['Date','Customer Order','PO','SKU','Product','Qty.','Status','Tracking','ETA']).map(h=><th key={h} className="p-2 text-left">{h}</th>)}</tr></thead><tbody>{data.recent.length?data.recent.map(x=><tr key={x.id} className="border-b"><td className="p-2">{x.date_order}</td><td className="p-2">{x.customer_order_id}</td><td className="p-2">{x.purchase_order}</td><td className="p-2">{x.sku}</td><td className="p-2 max-w-72 truncate">{x.product_name}</td><td className="p-2">{x.quantity}</td><td className="p-2">{x.status}</td><td className="p-2">{x.shipment.tracking_number||'—'}</td><td className="p-2">{x.shipment.estimated_delivery||'—'}</td></tr>):<tr><td colSpan={9} className="p-6 text-center text-slate-500">{pt?'Nenhum pedido nos últimos 7 dias.':'No orders in the last 7 days.'}</td></tr>}</tbody></table></div></section>
    <section className="bg-white border border-blue-200 rounded-2xl p-6"><h2 className="font-bold flex gap-2"><Mail className="w-5 h-5 text-blue-600"/>{pt?'Enviar relatório completo por e-mail':'Send Full Report by Email'}</h2><p className="text-xs text-slate-500 mt-1">{pt?'Os destinatários ficam salvos neste navegador.':'Recipients are saved in this browser. Use semicolons for multiple addresses.'}</p><form onSubmit={send} className="grid grid-cols-1 md:grid-cols-2 gap-4 mt-5"><label className="text-xs font-semibold">{pt?'Para':'To'}<input required type="text" placeholder="email1@company.com; email2@company.com" value={to} onChange={e=>setTo(e.target.value)} className="mt-1 w-full p-2.5 rounded-xl border"/></label><label className="text-xs font-semibold">Cc ({pt?'opcional':'optional'})<input placeholder="email3@company.com" value={cc} onChange={e=>setCc(e.target.value)} className="mt-1 w-full p-2.5 rounded-xl border"/></label><label className="md:col-span-2 text-xs font-semibold">{pt?'Assunto':'Subject'}<input required value={subject} onChange={e=>setSubject(e.target.value)} className="mt-1 w-full p-2.5 rounded-xl border"/></label><label className="md:col-span-2 text-xs font-semibold">{pt?'Mensagem':'Message'}<textarea rows={4} value={message} onChange={e=>setMessage(e.target.value)} className="mt-1 w-full p-2.5 rounded-xl border"/></label><div className="md:col-span-2 flex justify-between items-center gap-3">{feedback?<span className={feedback.ok?'text-xs text-emerald-700':'text-xs text-red-700'}>{feedback.text}</span>:<span/>}<button disabled={sending} className="flex gap-2 items-center px-5 py-2.5 bg-blue-600 text-white rounded-xl font-semibold">{sending?<Loader2 className="w-4 h-4 animate-spin"/>:<Send className="w-4 h-4"/>}{sending?(pt?'Enviando...':'Sending...'):(pt?'Enviar relatório':'Send Report')}</button></div></form></section>
  </div>;
};
