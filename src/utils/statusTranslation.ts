export function translatePurchaseStatus(value: string, language: string): string {
  if (language === 'pt' || !value) return value;

  const normalized = value
    .normalize('NFD')
    .replace(/[\u0300-\u036f]/g, '')
    .trim()
    .toUpperCase();

  const translations: Record<string, string> = {
    COMPRADO: 'Purchased',
    ENTREGUE: 'Delivered',
    CANCELADO: 'Cancelled',
    CANCELADA: 'Cancelled',
    PENDENTE: 'Pending',
    PROCESSANDO: 'Processing',
    FATURADO: 'Invoiced',
    FATURADA: 'Invoiced',
    ENVIADO: 'Shipped',
    ENVIADA: 'Shipped',
    'EM TRANSITO': 'In Transit',
    'NAO ENVIADO': 'Not Shipped',
    'NAO ENVIADA': 'Not Shipped',
  };

  return translations[normalized] || value;
}
