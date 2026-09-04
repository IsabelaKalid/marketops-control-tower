export interface ParsedBatchOrder {
  id?: string;
  date_order: string;
  sku: string;
  product_name: string;
  asin: string;
  seller: string;
  seller_country?: string;
  customer_order_id?: string;
  purchase_order?: string;
  sequencial?: string;
  sts_compra?: string; // e.g. "ENTREGUE", "CANCELADO", "COMPRADO"
  status?: string; // Normalized: 'Delivered' | 'Cancelled' | 'Pending' | 'Shipped'
  quantity?: number;
  vkp2_price?: number; // Preço de venda VKP2 (R$)
  seller_usd_total?: number; // Valor Total Compra Seller (USD, e.g. 14.39)
  price_unit?: number;
  total_price?: number;
  customer_name?: string;
  customer_email?: string;
  invoice?: string;
  wr_date?: string;
  eta?: string;
  di_date?: string;
  entry_cd_date?: string;
  delivery_client_date?: string;
  raw_row_index: number;
  isValid: boolean;
  validationError?: string;
  isDuplicate?: boolean;
  duplicateReason?: string;
}

export const SAMPLE_BATCH_INPUT = `Data da compra\tSKU Marketplace\tDescrição do Material\tSKU Principal\tSeller\tOrigem (País Seller)\tOrdem de Cliente\tOrdem de Compra\tSequencial\tSts de Compra\tQuantidade\tPreço de venda VKP2\tValor Total Compra Seller
04/09/2026\t227-315\tCâmera de ação 4K com estabilização e acessórios\tB0DEMO1001\tAmazon\tUSA\t900000101\tAKDN-80301\t10\tCOMPRADO\t1\t349,90\t$36,13
04/09/2026\t227-316\tFone sem fio com cancelamento de ruído e estojo\tB0DEMO1002\teBay\tUSA\t900000102\tAKDN-80302\t10\tCOMPRADO\t2\t189,90\t$42,80`;

/**
 * Converts date like '01/08/2026' or '2026-08-01' into standardized 'YYYY-MM-DD'
 */
export function normalizeDate(raw: string): string {
  if (!raw) return new Date().toISOString().split('T')[0];
  const trimmed = raw.trim();

  // Format DD/MM/YYYY
  if (/^\d{1,2}\/\d{1,2}\/\d{4}$/.test(trimmed)) {
    const [day, month, year] = trimmed.split('/');
    return `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`;
  }

  // Format YYYY-MM-DD
  if (/^\d{4}-\d{2}-\d{2}$/.test(trimmed)) {
    return trimmed;
  }

  // Format DD-MM-YYYY
  if (/^\d{1,2}-\d{1,2}-\d{4}$/.test(trimmed)) {
    const [day, month, year] = trimmed.split('-');
    return `${year}-${month.padStart(2, '0')}-${day.padStart(2, '0')}`;
  }

  return new Date().toISOString().split('T')[0];
}

/**
 * Clean currency string to numeric float
 * Handles " $14,39 ", "R$ 139", "77.97", etc.
 */
export function parseCurrency(val: string | undefined | null): number | undefined {
  if (!val) return undefined;
  const cleanStr = val
    .replace(/[R$\s]/gi, '')
    .replace(',', '.')
    .trim();
  const num = parseFloat(cleanStr);
  return isNaN(num) ? undefined : num;
}

/**
 * Detects separator (tab, semicolon, or comma)
 */
function detectSeparator(firstLine: string): string {
  const tabs = (firstLine.match(/\t/g) || []).length;
  const semicolons = (firstLine.match(/;/g) || []).length;
  const commas = (firstLine.match(/,/g) || []).length;

  if (tabs >= 2) return '\t';
  if (semicolons >= 2) return ';';
  if (commas >= 2) return ',';
  return '\t';
}

/**
 * Splits CSV/TSV line properly respecting quotes
 */
function splitLine(line: string, separator: string): string[] {
  if (separator === '\t') {
    return line.split('\t').map((c) => c.trim().replace(/^["']|["']$/g, ''));
  }

  const result: string[] = [];
  let current = '';
  let inQuotes = false;

  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      inQuotes = !inQuotes;
    } else if (char === separator && !inQuotes) {
      result.push(current.trim().replace(/^["']|["']$/g, ''));
      current = '';
    } else {
      current += char;
    }
  }
  result.push(current.trim().replace(/^["']|["']$/g, ''));
  return result;
}

/**
 * Maps raw purchase status string (e.g. 'ENTREGUE', 'CANCELADO', 'COMPRADO')
 * to standard OrderStatus
 */
export function mapStsCompra(rawStatus: string, defaultStatus = 'Pending'): { status: string; sts_compra: string } {
  if (!rawStatus) return { status: defaultStatus, sts_compra: defaultStatus.toUpperCase() };
  const st = rawStatus.trim().toUpperCase();

  if (st.includes('ENTREG') || st.includes('DELIVER')) {
    return { status: 'Delivered', sts_compra: 'ENTREGUE' };
  }
  if (st.includes('CANCEL')) {
    return { status: 'Cancelled', sts_compra: 'CANCELADO' };
  }
  if (st.includes('TRANSIT') || st.includes('SHIP') || st.includes('ENVIAD')) {
    return { status: 'Shipped', sts_compra: 'EM TRÂNSITO' };
  }
  if (st.includes('COMPRAD') || st.includes('PEND')) {
    return { status: 'Pending', sts_compra: 'COMPRADO' };
  }

  return { status: defaultStatus, sts_compra: st };
}

/**
 * Parses raw tabular text (from Excel copy-paste, TSV, or CSV)
 * Supporting all 13 columns:
 * 1. Data da compra
 * 2. SKU Marketplace
 * 3. Descrição do Material
 * 4. SKU Principal
 * 5. Seller
 * 6. Origem (País Seller)
 * 7. Ordem de Cliente
 * 8. Ordem de Compra
 * 9. Sequencial
 * 10. Sts de Compra
 * 11. Quantidade
 * 12. Preço de venda VKP2
 * 13. Valor Total Compra Seller
 */
export function parseBatchOrderText(
  rawText: string,
  defaultStatus = 'Pending',
  existingOrders: { purchase_order?: string; id?: string; sku?: string }[] = []
): ParsedBatchOrder[] {
  if (!rawText || !rawText.trim()) return [];

  const rawLines = rawText
    .split(/\r?\n/)
    .map((l) => l.trim())
    .filter((l) => l.length > 0);

  if (rawLines.length === 0) return [];

  const separator = detectSeparator(rawLines[0]);
  const firstRowCols = splitLine(rawLines[0], separator);

  // Check if first line is a header row
  const headerCheckStr = firstRowCols.join(' ').toLowerCase();
  const isHeaderRow =
    headerCheckStr.includes('data') ||
    headerCheckStr.includes('sku') ||
    headerCheckStr.includes('material') ||
    headerCheckStr.includes('seller') ||
    headerCheckStr.includes('ordem') ||
    headerCheckStr.includes('cliente') ||
    headerCheckStr.includes('compra') ||
    headerCheckStr.includes('vkp2') ||
    headerCheckStr.includes('sts');

  const headers = isHeaderRow ? firstRowCols.map((h) => h.toLowerCase().trim()) : [];
  const dataRows = isHeaderRow ? rawLines.slice(1) : rawLines;

  // Header column index detectors
  let colDate = -1;
  let colSku = -1;
  let colDesc = -1;
  let colAsin = -1;
  let colSeller = -1;
  let colCountry = -1;
  let colCustomerOrder = -1;
  let colPurchaseOrder = -1;
  let colSeq = -1;
  let colStsCompra = -1;
  let colQty = -1;
  let colVkp2 = -1;
  let colSellerUsd = -1;
  let colInvoice = -1;
  let colWrDate = -1;
  let colEta = -1;
  let colDiDate = -1;
  let colEntryCd = -1;
  let colDeliveryClient = -1;

  if (isHeaderRow) {
    headers.forEach((h, idx) => {
      if (h === 'wr_date' || h.includes('data wr')) { colWrDate = idx; return; }
      if (h === 'di_date' || h.includes('data di')) { colDiDate = idx; return; }
      if (h === 'entrada_cd' || h.includes('entrada cd')) { colEntryCd = idx; return; }
      if (h === 'entrega_cliente' || h.includes('entrega cliente')) { colDeliveryClient = idx; return; }
      if (h === 'eta') { colEta = idx; return; }
      if (h === 'invoice' || h.includes('invoice')) { colInvoice = idx; return; }
      if (h.includes('data da compra') || (h.includes('data') && !h.includes('entrega')) || h.includes('date')) {
        colDate = idx;
      } else if (h.includes('sku marketplace') || (h.includes('sku') && !h.includes('principal'))) {
        colSku = idx;
      } else if (
        h.includes('descrição') ||
        h.includes('descricao') ||
        h.includes('material') ||
        h.includes('produto') ||
        h.includes('product')
      ) {
        colDesc = idx;
      } else if (h.includes('sku principal') || h.includes('asin') || (h.includes('principal') && !h.includes('seller'))) {
        colAsin = idx;
      } else if (
        (h.includes('seller') || h.includes('loja') || h.includes('marketplace')) &&
        !h.includes('origem') &&
        !h.includes('país') &&
        !h.includes('compra seller')
      ) {
        colSeller = idx;
      } else if (h.includes('origem') || h.includes('país') || h.includes('pais') || h.includes('country')) {
        colCountry = idx;
      } else if (h.includes('ordem de cliente') || h.includes('ordem cliente') || h.includes('cliente id')) {
        colCustomerOrder = idx;
      } else if (
        h.includes('ordem de compra') ||
        h.includes('ordem compra') ||
        h.includes('oc') ||
        h.includes('po')
      ) {
        colPurchaseOrder = idx;
      } else if (h.includes('sequencial') || h.includes('seq')) {
        colSeq = idx;
      } else if (h.includes('sts de compra') || h.includes('sts') || h.includes('status de compra') || h.includes('status')) {
        colStsCompra = idx;
      } else if (h.includes('quantidade') || h.includes('qtd') || h.includes('qty') || h.includes('quant')) {
        colQty = idx;
      } else if (h.includes('vkp2') || h.includes('preço de venda') || h.includes('preco de venda')) {
        colVkp2 = idx;
      } else if (
        h.includes('valor total compra seller') ||
        h.includes('compra seller') ||
        h.includes('total compra seller') ||
        h.includes('seller usd') ||
        h.includes('valor total')
      ) {
        colSellerUsd = idx;
      } else if (h === 'invoice' || h.includes('invoice')) {
        colInvoice = idx;
      } else if (h === 'wr_date' || h.includes('data wr')) {
        colWrDate = idx;
      } else if (h === 'eta') {
        colEta = idx;
      } else if (h === 'di_date' || h.includes('data di')) {
        colDiDate = idx;
      } else if (h === 'entrada_cd' || h.includes('entrada cd')) {
        colEntryCd = idx;
      } else if (h === 'entrega_cliente' || h.includes('entrega cliente')) {
        colDeliveryClient = idx;
      }
    });
  }

  // Positional fallback for 13-column format if any key columns are not matched
  if (colDate === -1) colDate = 0;
  if (colSku === -1 && firstRowCols.length > 1) colSku = 1;
  if (colDesc === -1 && firstRowCols.length > 2) colDesc = 2;
  if (colAsin === -1 && firstRowCols.length > 3) colAsin = 3;
  if (colSeller === -1 && firstRowCols.length > 4) colSeller = 4;
  if (colCountry === -1 && firstRowCols.length > 5) colCountry = 5;
  if (colCustomerOrder === -1 && firstRowCols.length > 6) colCustomerOrder = 6;
  if (colPurchaseOrder === -1 && firstRowCols.length > 7) colPurchaseOrder = 7;
  if (colSeq === -1 && firstRowCols.length > 8) colSeq = 8;
  if (colStsCompra === -1 && firstRowCols.length > 9) colStsCompra = 9;
  if (colQty === -1 && firstRowCols.length > 10) colQty = 10;
  if (colVkp2 === -1 && firstRowCols.length > 11) colVkp2 = 11;
  if (colSellerUsd === -1 && firstRowCols.length > 12) colSellerUsd = 12;

  const parsedOrders: ParsedBatchOrder[] = [];
  const seenInBatch = new Map<string, number>();
  const seenPoCounts = new Map<string, number>();

  dataRows.forEach((line, rowIndex) => {
    const cols = splitLine(line, separator);
    if (cols.length < 2 || cols.every((c) => !c.trim())) return;

    const rawDate = colDate >= 0 && cols[colDate] !== undefined ? cols[colDate] : '';
    const rawSku = colSku >= 0 && cols[colSku] !== undefined ? cols[colSku] : `SKU-${rowIndex + 1}`;
    const rawDesc = colDesc >= 0 && cols[colDesc] !== undefined ? cols[colDesc] : `Material Item ${rowIndex + 1}`;
    const rawAsin = colAsin >= 0 && cols[colAsin] !== undefined ? cols[colAsin] : 'ASIN-GEN';
    const rawSeller = colSeller >= 0 && cols[colSeller] !== undefined ? cols[colSeller] : 'Amazon';
    const rawCountry = colCountry >= 0 && cols[colCountry] !== undefined ? cols[colCountry] : 'EUA';
    const rawCustomerOrder = colCustomerOrder >= 0 && cols[colCustomerOrder] !== undefined ? cols[colCustomerOrder] : '';
    const rawPurchaseOrder = colPurchaseOrder >= 0 && cols[colPurchaseOrder] !== undefined ? cols[colPurchaseOrder] : '';
    const rawSeq = colSeq >= 0 && cols[colSeq] !== undefined ? cols[colSeq] : '10';
    const rawStsCompra = colStsCompra >= 0 && cols[colStsCompra] !== undefined ? cols[colStsCompra] : '';
    const rawQty = colQty >= 0 && cols[colQty] !== undefined ? cols[colQty] : '1';
    const rawVkp2 = colVkp2 >= 0 && cols[colVkp2] !== undefined ? cols[colVkp2] : '';
    const rawSellerUsd = colSellerUsd >= 0 && cols[colSellerUsd] !== undefined ? cols[colSellerUsd] : '';
    const rawInvoice = colInvoice >= 0 && cols[colInvoice] !== undefined ? cols[colInvoice] : '';
    const rawWrDate = colWrDate >= 0 && cols[colWrDate] !== undefined ? cols[colWrDate] : '';
    const rawEta = colEta >= 0 && cols[colEta] !== undefined ? cols[colEta] : '';
    const rawDiDate = colDiDate >= 0 && cols[colDiDate] !== undefined ? cols[colDiDate] : '';
    const rawEntryCd = colEntryCd >= 0 && cols[colEntryCd] !== undefined ? cols[colEntryCd] : '';
    const rawDeliveryClient = colDeliveryClient >= 0 && cols[colDeliveryClient] !== undefined ? cols[colDeliveryClient] : '';

    // Status mapping
    const mapped = mapStsCompra(rawStsCompra, defaultStatus);
    let orderStatus = mapped.status;
    let stsCompraClean = mapped.sts_compra;
    if (rawStsCompra.toUpperCase().includes('CANCEL')) {
      orderStatus = 'Cancelled';
      stsCompraClean = 'CANCELADO';
    } else if (rawDeliveryClient) {
      orderStatus = 'Delivered';
      stsCompraClean = 'ENTREGUE';
    } else if (rawInvoice || rawWrDate || rawDiDate || rawEntryCd || rawEta) {
      orderStatus = 'Shipped';
    } else {
      orderStatus = 'Pending';
    }

    // Quantity parsing
    const qty = parseInt(rawQty.trim(), 10) || 1;

    // Price parsing: VKP2 and Seller USD
    const vkp2Price = parseCurrency(rawVkp2);
    const sellerUsdTotal = parseCurrency(rawSellerUsd);

    // Calculate unit and total prices in USD
    const totalPrice = sellerUsdTotal !== undefined ? sellerUsdTotal : 29.99 * qty;
    const priceUnit = Math.round((totalPrice / qty) * 100) / 100;

    const normDate = normalizeDate(rawDate);
    const cleanPo = rawPurchaseOrder.trim();
    const cleanSku = rawSku.trim().toUpperCase();

    // DEDUPLICATION CONDITION:
    // Multiple different products under the SAME Ordem de Compra (PO) with different SKUs are VALID (1 customer buying multiple items).
    // BUT repeating the SAME Ordem de Compra (PO) with the SAME SKU is an ERROR (order already exists).
    let isDuplicate = false;
    let duplicateReason: string | undefined = undefined;

    if (cleanPo && cleanSku) {
      const dedupeKey = `${cleanPo}:::${cleanSku}`;

      // 1. Check if repeated in current batch
      if (seenInBatch.has(dedupeKey)) {
        const firstSeenLine = seenInBatch.get(dedupeKey);
        isDuplicate = true;
        duplicateReason = `Pedido repetido no lote: Ordem de Compra (PO) "${cleanPo}" com SKU "${cleanSku}" já consta na linha ${firstSeenLine}.`;
      } else {
        seenInBatch.set(dedupeKey, rowIndex + (isHeaderRow ? 2 : 1));

        // 2. Check if already exists in loaded system orders
        if (existingOrders && existingOrders.length > 0) {
          const matchExisting = existingOrders.find((o) => {
            const oPo = (o.purchase_order || o.id || '').trim();
            const oSku = (o.sku || '').trim().toUpperCase();
            return oPo === cleanPo && oSku === cleanSku;
          });

          if (matchExisting) {
            isDuplicate = true;
            duplicateReason = `O pedido já existe! A Ordem de Compra (PO) "${cleanPo}" com o SKU "${cleanSku}" já está cadastrada no sistema.`;
          }
        }
      }
    }

    // Unique internal ID for React keys and API lookup:
    // If multi-item order (same PO, different SKU), assign unique internal ID e.g. `${po}-${seq}`,
    // while `purchase_order` is always preserved as the pure PO number.
    let orderId: string;
    if (cleanPo) {
      const count = seenPoCounts.get(cleanPo) || 0;
      seenPoCounts.set(cleanPo, count + 1);
      orderId = count === 0 ? cleanPo : `${cleanPo}-${rawSeq || rawSku}`;
    } else if (rawCustomerOrder.trim()) {
      orderId = `ORD-${rawCustomerOrder.trim()}`;
    } else {
      orderId = `ORD-2026-${Math.floor(1000 + Math.random() * 9000)}`;
    }

    let isValid = Boolean(rawSku && rawDesc);
    let validationError: string | undefined = undefined;

    if (!isValid) {
      validationError = 'Missing SKU or Product Description';
    } else if (isDuplicate) {
      isValid = false;
      validationError = duplicateReason;
    }

    parsedOrders.push({
      id: orderId,
      date_order: normDate,
      sku: rawSku,
      product_name: rawDesc,
      asin: rawAsin,
      seller: rawSeller || 'Amazon',
      seller_country: rawCountry || 'EUA',
      customer_order_id: rawCustomerOrder,
      purchase_order: rawPurchaseOrder,
      sequencial: rawSeq,
      sts_compra: stsCompraClean,
      status: orderStatus,
      quantity: qty,
      vkp2_price: vkp2Price,
      seller_usd_total: sellerUsdTotal,
      price_unit: priceUnit,
      total_price: totalPrice,
      customer_name: rawCustomerOrder ? `Cliente Marketplace #${rawCustomerOrder}` : `Cliente Marketplace Manaus`,
      invoice: rawInvoice || undefined,
      wr_date: rawWrDate ? normalizeDate(rawWrDate) : undefined,
      eta: rawEta ? normalizeDate(rawEta) : undefined,
      di_date: rawDiDate ? normalizeDate(rawDiDate) : undefined,
      entry_cd_date: rawEntryCd ? normalizeDate(rawEntryCd) : undefined,
      delivery_client_date: rawDeliveryClient ? normalizeDate(rawDeliveryClient) : undefined,
      raw_row_index: rowIndex + (isHeaderRow ? 2 : 1),
      isValid,
      validationError,
      isDuplicate,
      duplicateReason,
    });
  });

  return parsedOrders;
}
