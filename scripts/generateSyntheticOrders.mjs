import fs from 'node:fs';

const outputPath = new URL('../src/data/seededOrders.ts', import.meta.url);
const DAY = 86_400_000;
const start = new Date('2026-01-05T00:00:00Z');
const end = new Date('2026-09-03T00:00:00Z');

const products = [
  ['MARCADOR DE TEXTO COLORIDO PONTA CHANFRADA KIT COM 12 CORES', 'NovaMark'],
  ['FONE DE OUVIDO SEM FIO COM CANCELAMENTO DE RUÍDO E ESTOJO', 'NovaWave'],
  ['LUMINÁRIA DE MESA LED ARTICULADA COM CONTROLE DE INTENSIDADE', 'Lumina Home'],
  ['RELÓGIO INTELIGENTE ESPORTIVO COM MONITOR CARDÍACO E GPS', 'Orbit Labs'],
  ['LIQUIDIFICADOR PORTÁTIL RECARREGÁVEL COM COPO DE 500 ML', 'Nimbus Kitchen'],
  ['MONITOR LED 24 POLEGADAS FULL HD COM AJUSTE DE INCLINAÇÃO', 'Vista Digital'],
  ['MOUSE ERGONÔMICO SEM FIO COM SEIS BOTÕES PROGRAMÁVEIS', 'Terra Works'],
  ['CAIXA DE SOM BLUETOOTH PORTÁTIL RESISTENTE À ÁGUA', 'Pulse Audio'],
  ['MOCHILA DE VIAGEM IMPERMEÁVEL COM COMPARTIMENTO PARA NOTEBOOK', 'Atlas Gear'],
  ['FRITADEIRA ELÉTRICA SEM ÓLEO DIGITAL COM CAPACIDADE DE 4 LITROS', 'Solaris Home'],
  ['DOCK STATION USB-C COM HDMI LEITOR DE CARTÃO E REDE GIGABIT', 'Nexus Tech'],
  ['VENTILADOR DE TORRE SILENCIOSO COM CONTROLE REMOTO', 'Breeze Living'],
  ['TECLADO SEM FIO COMPACTO COM TECLAS SILENCIOSAS', 'PixelKey'],
  ['CÂMERA DE AÇÃO 4K COM ESTABILIZAÇÃO E ACESSÓRIOS', 'Motion Labs'],
  ['CHALEIRA ELÉTRICA EM AÇO INOX COM DESLIGAMENTO AUTOMÁTICO', 'Ember Kitchen'],
  ['TRAVESSEIRO VISCOELÁSTICO ORTOPÉDICO COM CAPA LAVÁVEL', 'Cloud Rest'],
  ['CONTROLE PARA JOGOS SEM FIO COM VIBRAÇÃO E CONEXÃO USB-C', 'Vector Play'],
  ['ASPIRADOR ROBÔ INTELIGENTE COM MAPEAMENTO E BASE CARREGADORA', 'Zenith Home'],
  ['WEBCAM FULL HD COM MICROFONE DUPLO E TAMPA DE PRIVACIDADE', 'Prism Digital'],
  ['SUPORTE AJUSTÁVEL PARA NOTEBOOK EM ALUMÍNIO ANTIDERRAPANTE', 'Flex Office'],
];

const sellers = [
  ['Amazon', 'USA'], ['Amazon', 'USA'], ['Amazon', 'USA'],
  ['Walmart', 'USA'], ['eBay', 'USA'], ['Target', 'USA'],
];

const firstNames = [
  'Ana Clara', 'Bruno', 'Camila', 'Daniel', 'Elisa', 'Felipe', 'Gabriela', 'Heitor',
  'Isadora', 'João Miguel', 'Larissa', 'Mateus', 'Natália', 'Otávio', 'Paula',
  'Rafael', 'Sofia', 'Tiago', 'Vitória', 'William',
];

const familyNames = [
  'Almeida Campos', 'Barbosa Lima', 'Cardoso Freitas', 'Duarte Nogueira',
  'Esteves Moraes', 'Ferreira Prado', 'Gomes Tavares', 'Henrique Moreira',
  'Ibrahim Costa', 'Jardim Ribeiro', 'Klein Martins', 'Lopes Azevedo',
  'Macedo Rocha', 'Neves Andrade', 'Oliveira Bastos',
];

const operatorNames = ['Marina Torres', 'Caio Nunes', 'Renata Alves', 'Lucas Monteiro'];

const pad = (value, size) => String(value).padStart(size, '0');
const iso = (date) => date.toISOString().slice(0, 10);
const addDays = (date, days) => new Date(date.getTime() + days * DAY);
const clampDate = (date) => date > end ? end : date;
const money = (value) => Number(value.toFixed(2));

function syntheticAsin(index) {
  const alphabet = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
  let state = (index + 17) * 7919;
  let value = 'B0';
  for (let i = 0; i < 8; i += 1) {
    state = (state * 48271) % 2147483647;
    value += alphabet[state % alphabet.length];
  }
  return value;
}

function orderStatus(orderIndex, purchaseDate) {
  const age = Math.floor((end - purchaseDate) / DAY);
  if (age < 5) return orderIndex % 3 === 0 ? 'Shipped' : 'Pending';
  const bucket = orderIndex % 20;
  if (bucket < 3) return 'Cancelled';
  if (bucket < 11) return 'Delivered';
  if (bucket < 16) return 'Shipped';
  return 'Pending';
}

function makeLine(lineIndex, orderIndex, itemIndex, lineCount) {
  const span = Math.floor((end - start) / DAY);
  const purchaseDate = addDays(start, Math.floor((orderIndex * span) / 284));
  const status = orderStatus(orderIndex, purchaseDate);
  const [productBase, brand] = products[(lineIndex * 7 + orderIndex) % products.length];
  const [marketplace, country] = sellers[orderIndex % sellers.length];
  const po = `AKDN-${pad(80000 + orderIndex, 5)}`;
  const customerOrder = String(900000000 + orderIndex * 29);
  const rawSku = 222232 + lineIndex * 17;
  const skuDigits = pad(rawSku % 1_000_000, 6);
  const sku = `${skuDigits.slice(0, 3)}-${skuDigits.slice(3)}`;
  const asin = syntheticAsin(lineIndex);
  const quantity = 1 + ((lineIndex + orderIndex) % 3 === 0 ? 1 : 0);
  const sellerUnit = money(8.5 + ((lineIndex * 37) % 8300) / 100);
  const sellerTotal = money(sellerUnit * quantity);
  const vkp2 = money(sellerTotal * (4.4 + (lineIndex % 7) * 0.12));
  const confirmed = status !== 'Cancelled' && !(status === 'Pending' && orderIndex % 4 === 0);
  const confirmedDate = confirmed ? clampDate(addDays(purchaseDate, orderIndex % 3)) : null;
  const itemDateOffset = itemIndex;
  const wrDate = status === 'Delivered' || status === 'Shipped'
    ? clampDate(addDays(purchaseDate, 5 + orderIndex % 7 + itemDateOffset))
    : (status === 'Pending' && orderIndex % 5 === 0 ? clampDate(addDays(purchaseDate, 8 + itemDateOffset)) : null);
  const hasInvoice = status === 'Delivered' || status === 'Shipped';
  const etd = hasInvoice ? clampDate(addDays(wrDate, 1 + orderIndex % 3)) : null;
  const eta = hasInvoice ? clampDate(addDays(etd, 4 + orderIndex % 5)) : null;
  const diDate = status === 'Delivered' ? clampDate(addDays(eta, 1 + orderIndex % 3)) : null;
  const entryCd = status === 'Delivered' ? clampDate(addDays(diDate, 1 + orderIndex % 2)) : null;
  const delivered = status === 'Delivered' ? clampDate(addDays(entryCd, 1 + orderIndex % 4)) : null;
  const cancelledAt = status === 'Cancelled' ? clampDate(addDays(purchaseDate, 1 + orderIndex % 5)) : null;
  const tracking = hasInvoice ? `DEMO${pad(orderIndex + 1, 6)}${pad(itemIndex + 1, 2)}` : '';
  const invoice = hasInvoice ? `NX-${pad(41000 + lineIndex, 6)}-26` : null;
  const wr = wrDate ? `RCPT-${pad(73000 + lineIndex, 6)}` : null;
  const events = [];

  if (delivered) events.push({ id: `delivery-${po}-${sku}`, timestamp: iso(delivered), location: 'Customer destination', status: 'Delivered', description: 'Synthetic delivery confirmation.' });
  if (entryCd) events.push({ id: `dc-${po}-${sku}`, timestamp: iso(entryCd), location: 'Distribution center', status: 'Out for Delivery', description: 'Synthetic distribution-center dispatch.' });
  if (eta) events.push({ id: `arrival-${po}-${sku}`, timestamp: iso(eta), location: 'Destination hub', status: 'In Transit', description: 'Synthetic arrival at destination hub.' });
  if (etd) events.push({ id: `departure-${po}-${sku}`, timestamp: iso(etd), location: 'Origin hub', status: 'In Transit', description: 'Synthetic international dispatch.' });
  if (wrDate) events.push({ id: `warehouse-${po}-${sku}`, timestamp: iso(wrDate), location: 'Warehouse', status: 'Preparing', description: 'Synthetic warehouse receipt.' });

  const shipmentStatus = status === 'Delivered' ? 'Delivered' : status === 'Cancelled' ? 'Cancelled' : status === 'Shipped' ? 'In Transit' : 'Preparing';
  const statusCompra = status === 'Delivered' ? 'ENTREGUE' : status === 'Cancelled' ? 'CANCELADO' : 'COMPRADO';
  const suffix = lineCount > 1 ? ` - ITEM ${itemIndex + 1}` : '';

  return {
    id: `${po}-${pad((itemIndex + 1) * 10, 2)}-${sku}`,
    date_order: iso(purchaseDate),
    customer_name: `${firstNames[orderIndex % firstNames.length]} ${familyNames[Math.floor(orderIndex / firstNames.length)]}`,
    customer_email: '',
    sku,
    product_name: `${brand.toUpperCase()} ${productBase}${suffix}`,
    asin,
    price_unit: sellerUnit,
    quantity,
    total_price: sellerTotal,
    status,
    marketplace,
    shipment: {
      is_shipped: status === 'Shipped' || status === 'Delivered',
      carrier: hasInvoice ? ['UPS Demo', 'FedEx Demo', 'Global Parcel Demo'][orderIndex % 3] : '',
      tracking_number: tracking,
      estimated_delivery: eta ? `${iso(eta)} 00:00:00` : '',
      actual_delivery_date: delivered ? iso(delivered) : null,
      shipment_status: shipmentStatus,
      databricks_sync_time: '2026-09-04 09:00:00Z',
      destination: 'Customer destination',
      origin_hub: country,
      events,
    },
    created_at: `${iso(purchaseDate)}T09:00:00.000Z`,
    updated_at: `${iso(delivered || cancelledAt || eta || wrDate || confirmedDate || purchaseDate)}T15:30:00.000Z`,
    purchase_order: po,
    customer_order_id: customerOrder,
    vkp2_price: vkp2,
    seller_usd_total: sellerTotal,
    seller_country: country,
    invoice,
    magaya_wr: wr,
    destination_hub: 'Demo Distribution Center',
    delivery_client_date: delivered ? iso(delivered) : null,
    entry_cd_date: entryCd ? iso(entryCd) : null,
    sequencial: String((itemIndex + 1) * 10),
    sts_compra: statusCompra,
    unit_measure: 'EA',
    operational_status: status === 'Cancelled' ? 'CANCELLED' : status === 'Delivered' ? 'DELIVERED' : 'ACTIVE',
    status_text: status === 'Cancelled' ? 'Synthetic cancellation record' : '',
    delivery_limit_days: 25,
    marketplace_order_date: confirmedDate ? iso(confirmedDate) : null,
    marketplace_order_id: confirmed ? `113-${pad(1000000 + orderIndex * 37, 7)}-${pad(2000000 + lineIndex * 31, 7)}` : null,
    account_group: 'Demo Commerce Group',
    account_order_status: status === 'Cancelled' ? 'Cancelled' : status === 'Delivered' ? 'Closed' : 'Open',
    account_user: operatorNames[orderIndex % operatorNames.length],
    wr_date: wrDate ? iso(wrDate) : null,
    eta: eta ? iso(eta) : null,
    etd: etd ? iso(etd) : null,
    di_date: diDate ? iso(diDate) : null,
    marketplace_purchase_confirmed: confirmed,
    marketplace_purchase_confirmed_at: confirmedDate ? iso(confirmedDate) : null,
    cancellation_reason: status === 'Cancelled' ? (orderIndex % 2 ? 'Cancelled by demo customer' : 'Cancelled by demo store') : null,
    cancellation_updated_at: cancelledAt ? iso(cancelledAt) : null,
  };
}

const orders = [];
let lineIndex = 0;
for (let orderIndex = 0; orderIndex < 285; orderIndex += 1) {
  const lineCount = orderIndex < 15 ? 2 : 1;
  for (let itemIndex = 0; itemIndex < lineCount; itemIndex += 1) {
    orders.push(makeLine(lineIndex, orderIndex, itemIndex, lineCount));
    lineIndex += 1;
  }
}

if (orders.length !== 300) throw new Error(`Expected 300 lines, generated ${orders.length}`);

const source = `// Fully synthetic demonstration dataset. No corporate/customer source records are included.\nimport { Order } from '../types';\n\nexport const CSV_ORDERS: Order[] = ${JSON.stringify(orders, null, 2)};\n`;
fs.writeFileSync(outputPath, source, 'utf8');
console.log(`Generated ${orders.length} synthetic lines across 285 purchase orders.`);
