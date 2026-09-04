import React, { useState } from 'react';
import { X, Plus, Sparkles, AlertCircle, CheckCircle2, DollarSign, Calendar, Truck, UploadCloud } from 'lucide-react';
import { Order } from '../types';

interface NewOrderModalProps {
  isOpen: boolean;
  onClose: () => void;
  onOrderCreated: (newOrder: Order) => void;
  onSwitchToBatch?: () => void;
}

export const NewOrderModal: React.FC<NewOrderModalProps> = ({
  isOpen,
  onClose,
  onOrderCreated,
  onSwitchToBatch,
}) => {
  const todayStr = new Date().toISOString().split('T')[0];

  const [dateOrder, setDateOrder] = useState(todayStr);
  const [customerName, setCustomerName] = useState('');
  const [customerEmail, setCustomerEmail] = useState('');
  const [customerPhone, setCustomerPhone] = useState('');
  const [sku, setSku] = useState('');
  const [productName, setProductName] = useState('');
  const [asin, setAsin] = useState('');
  const [priceUnit, setPriceUnit] = useState<string>('99.00');
  const [vkp2Price, setVkp2Price] = useState<string>('199.00');
  const [quantity, setQuantity] = useState<number>(1);
  const [marketplace, setMarketplace] = useState('Amazon (EUA)');
  const [destinationAddress, setDestinationAddress] = useState('Miami, FL, USA');
  const [estimatedDays, setEstimatedDays] = useState<number>(3);
  const [notes, setNotes] = useState('');

  const [isSubmitting, setIsSubmitting] = useState(false);
  const [errorMsg, setErrorMsg] = useState<string | null>(null);

  if (!isOpen) return null;

  const numPrice = parseFloat(priceUnit) || 0;
  const numVkp2 = parseFloat(vkp2Price) || 0;
  const numQty = quantity || 0;
  const calculatedTotal = (numPrice * numQty).toFixed(2);

  // Quick autofill presets
  const applyPreset = (type: 'tech' | 'gaming' | 'audio') => {
    if (type === 'tech') {
      setCustomerName('Lucas Silva');
      setCustomerEmail('lucas.silva@techcorp.com');
      setCustomerPhone('+1 (305) 912-3456');
      setProductName('Logitech MX Master 3S Wireless Performance Mouse');
      setSku('LOGI-MXM3S-GRY');
      setAsin('B09HM94VDS');
      setPriceUnit('99.99');
      setVkp2Price('799.00');
      setQuantity(2);
      setMarketplace('Amazon US');
      setDestinationAddress('Orlando, FL, USA');
      setEstimatedDays(3);
      setNotes('Customer requested package stealth packaging');
    } else if (type === 'gaming') {
      setCustomerName('Amanda Chen');
      setCustomerEmail('a.chen@esports.io');
      setCustomerPhone('+1 (206) 431-8977');
      setProductName('Valve Steam Deck OLED 512GB Handheld Gaming Console');
      setSku('VALVE-SDECK-512OLED');
      setAsin('B0CQKTY72K');
      setPriceUnit('549.00');
      setVkp2Price('4999.00');
      setQuantity(1);
      setMarketplace('Shopify Store');
      setDestinationAddress('Seattle, WA, USA');
      setEstimatedDays(2);
      setNotes('Fragile handling label required');
    } else {
      setCustomerName('Thiago Rossi');
      setCustomerEmail('thiago.rossi@sp.gov.br');
      setCustomerPhone('+55 11 99123-7766');
      setProductName('Bose QuietComfort 45 Bluetooth Wireless Headphones');
      setSku('BOSE-QC45-SLV');
      setAsin('B098FH5P3C');
      setPriceUnit('279.00');
      setVkp2Price('2499.00');
      setQuantity(1);
      setMarketplace('Mercado Livre');
      setDestinationAddress('Curitiba, PR, Brazil');
      setEstimatedDays(4);
      setNotes('Mercado Envios standard priority');
    }
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setErrorMsg(null);

    if (!customerName.trim()) {
      setErrorMsg('Please provide the customer name.');
      return;
    }
    if (!productName.trim()) {
      setErrorMsg('Please enter the product name or description.');
      return;
    }
    if (!sku.trim()) {
      setErrorMsg('Please provide a SKU code.');
      return;
    }
    if (!asin.trim()) {
      setErrorMsg('Please specify the ASIN (Amazon Standard Identification Number).');
      return;
    }
    if (numPrice <= 0 || numVkp2 <= 0 || numQty <= 0) {
      setErrorMsg('O custo em USD, o preço de venda VKP2 e a quantidade devem ser maiores que zero.');
      return;
    }

    setIsSubmitting(true);
    try {
      const response = await fetch('/api/orders', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
          date_order: dateOrder,
          customer_name: customerName,
          customer_email: customerEmail,
          customer_phone: customerPhone,
          sku,
          product_name: productName,
          asin,
          price_unit: numPrice,
          vkp2_price: numVkp2,
          quantity: numQty,
          marketplace,
          notes,
          destination_address: destinationAddress,
          estimated_delivery_days: estimatedDays,
        }),
      });

      if (!response.ok) {
        const data = await response.json();
        throw new Error(data.error || 'Failed to create order');
      }

      const data = await response.json();
      if (data.order) {
        onOrderCreated(data.order);
        onClose();
      }
    } catch (err: any) {
      setErrorMsg(err.message || 'Error communicating with order API');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="fixed inset-0 z-50 flex items-center justify-center p-4 bg-slate-900/60 backdrop-blur-xs overflow-y-auto">
      <div 
        className="bg-white rounded-2xl border border-slate-200 shadow-2xl max-w-2xl w-full max-h-[92vh] flex flex-col overflow-hidden my-auto"
        onClick={(e) => e.stopPropagation()}
      >
        {/* Header */}
        <div className="px-6 py-4 border-b border-slate-100 flex items-center justify-between bg-slate-50/70">
          <div>
            <h2 className="text-base font-bold text-slate-800 flex items-center gap-2">
              <Plus className="w-5 h-5 text-blue-600" />
              Insert New Marketplace Order
            </h2>
            <p className="text-xs text-slate-500">
              Registers order into ledger, schedules Databricks logistics delta table, and arms automated delivery alerts.
            </p>
          </div>
          <button
            onClick={onClose}
            className="p-2 rounded-lg text-slate-400 hover:text-slate-700 hover:bg-slate-200/50 transition-colors"
          >
            <X className="w-5 h-5" />
          </button>
        </div>

        {/* Quick Autofill Helper */}
        <div className="px-6 py-2.5 bg-blue-50/50 border-b border-blue-100 flex flex-wrap items-center justify-between gap-2 text-xs">
          <span className="text-blue-950 font-semibold flex items-center gap-1">
            <Sparkles className="w-3.5 h-3.5 text-blue-600" />
            Quick Test Presets:
          </span>
          <div className="flex items-center gap-1.5">
            <button
              type="button"
              onClick={() => applyPreset('tech')}
              className="px-2.5 py-1 rounded-lg bg-white border border-blue-200 text-blue-700 hover:bg-blue-50 font-medium text-[11px] shadow-2xs"
            >
              Logitech Mouse (Amazon)
            </button>
            <button
              type="button"
              onClick={() => applyPreset('gaming')}
              className="px-2.5 py-1 rounded-lg bg-white border border-blue-200 text-blue-700 hover:bg-blue-50 font-medium text-[11px] shadow-2xs"
            >
              Steam Deck (Shopify)
            </button>
            <button
              type="button"
              onClick={() => applyPreset('audio')}
              className="px-2.5 py-1 rounded-lg bg-white border border-blue-200 text-blue-700 hover:bg-blue-50 font-medium text-[11px] shadow-2xs"
            >
              Bose QC45 (Mercado Livre)
            </button>
          </div>
        </div>

        {/* Switch to Batch / Bulk Mode Banner */}
        {onSwitchToBatch && (
          <div className="px-6 py-2 bg-emerald-50/70 border-b border-emerald-100 flex items-center justify-between text-xs text-emerald-900">
            <span className="flex items-center gap-1.5 font-medium">
              <UploadCloud className="w-3.5 h-3.5 text-emerald-600" />
              Need to insert multiple orders at once from Excel, Sheets, or CSV?
            </span>
            <button
              type="button"
              onClick={() => {
                onClose();
                onSwitchToBatch();
              }}
              className="font-bold text-emerald-700 hover:text-emerald-800 underline ml-2 whitespace-nowrap"
            >
              Switch to Batch Mode →
            </button>
          </div>
        )}

        {/* Error message */}
        {errorMsg && (
          <div className="mx-6 mt-4 p-3 rounded-md bg-rose-50 border border-rose-200 text-rose-800 text-xs flex items-center gap-2">
            <AlertCircle className="w-4 h-4 shrink-0" />
            <span>{errorMsg}</span>
          </div>
        )}

        {/* Form Body */}
        <form onSubmit={handleSubmit} className="p-6 space-y-4 overflow-y-auto flex-1 text-xs">
          {/* Row 1: Order Date & Marketplace */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                Order Date (date_order) *
              </label>
              <input
                type="date"
                required
                value={dateOrder}
                onChange={(e) => setDateOrder(e.target.value)}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900"
              />
            </div>
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                Seller / Canal de Venda *
              </label>
              <select
                value={marketplace}
                onChange={(e) => setMarketplace(e.target.value)}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900 font-medium"
              >
                <option value="Amazon (EUA)">Amazon (EUA)</option>
                <option value="Amazon">Amazon</option>
                <option value="Mercado Livre">Mercado Livre</option>
                <option value="Walmart">Walmart</option>
                <option value="AliExpress">AliExpress</option>
                <option value="Shein">Shein</option>
              </select>
            </div>
          </div>

          {/* Row 2: Customer Name, Email, Phone */}
          <div className="grid grid-cols-1 sm:grid-cols-3 gap-3">
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                Customer Name (name of cliente) *
              </label>
              <input
                type="text"
                required
                placeholder="e.g. Johnathan Miller"
                value={customerName}
                onChange={(e) => setCustomerName(e.target.value)}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900"
              />
            </div>
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                Email (Automated Alerts)
              </label>
              <input
                type="email"
                placeholder="alerts@client.com"
                value={customerEmail}
                onChange={(e) => setCustomerEmail(e.target.value)}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900"
              />
            </div>
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                Phone (Push/SMS alerts)
              </label>
              <input
                type="tel"
                placeholder="+1 (555) 000-0000"
                value={customerPhone}
                onChange={(e) => setCustomerPhone(e.target.value)}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900"
              />
            </div>
          </div>

          {/* Row 3: Product Name/Description */}
          <div>
            <label className="block font-medium text-zinc-700 mb-1">
              Product Name / Description *
            </label>
            <input
              type="text"
              required
              placeholder="e.g. Sony WH-1000XM5 Wireless Noise Canceling Headphones"
              value={productName}
              onChange={(e) => setProductName(e.target.value)}
              className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900"
            />
          </div>

          {/* Row 4: SKU & ASIN */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                SKU (Stock Keeping Unit) *
              </label>
              <input
                type="text"
                required
                placeholder="e.g. AUDIO-WH1000-BLK"
                value={sku}
                onChange={(e) => setSku(e.target.value)}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 font-mono focus:outline-none focus:border-zinc-900 uppercase"
              />
            </div>
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                Product ASIN (Amazon Standard ID) *
              </label>
              <input
                type="text"
                required
                placeholder="e.g. B09XS7JWHH"
                value={asin}
                onChange={(e) => setAsin(e.target.value)}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 font-mono focus:outline-none focus:border-zinc-900 uppercase font-semibold"
              />
            </div>
          </div>

          {/* Row 5: Price Unit, Quantity & Live Total Price Calculation */}
          <div className="p-3 bg-zinc-50 rounded-lg border border-zinc-200 space-y-3">
            <div className="grid grid-cols-1 sm:grid-cols-4 gap-3 items-end">
              <div>
                <label className="block font-medium text-zinc-700 mb-1">
                  Custo unitário seller (USD) *
                </label>
                <div className="relative">
                  <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-zinc-400 font-semibold">$</span>
                  <input
                    type="number"
                    step="0.01"
                    min="0.01"
                    required
                    value={priceUnit}
                    onChange={(e) => setPriceUnit(e.target.value)}
                    className="w-full pl-6 pr-3 py-2 bg-white border border-zinc-300 rounded-md text-zinc-900 font-mono focus:outline-none focus:border-zinc-900"
                  />
                </div>
              </div>

              <div>
                <label className="block font-medium text-zinc-700 mb-1">
                  Preço de venda VKP2 (R$) *
                </label>
                <div className="relative">
                  <span className="absolute left-2.5 top-1/2 -translate-y-1/2 text-zinc-400 font-semibold">R$</span>
                  <input
                    type="number"
                    step="0.01"
                    min="0.01"
                    required
                    value={vkp2Price}
                    onChange={(e) => setVkp2Price(e.target.value)}
                    className="w-full pl-8 pr-3 py-2 bg-white border border-zinc-300 rounded-md text-zinc-900 font-mono focus:outline-none focus:border-zinc-900"
                  />
                </div>
              </div>

              <div>
                <label className="block font-medium text-zinc-700 mb-1">
                  Quantity *
                </label>
                <input
                  type="number"
                  min="1"
                  max="999"
                  required
                  value={quantity}
                  onChange={(e) => setQuantity(parseInt(e.target.value, 10) || 1)}
                  className="w-full px-3 py-2 bg-white border border-zinc-300 rounded-md text-zinc-900 font-mono focus:outline-none focus:border-zinc-900"
                />
              </div>

              {/* Total Price preview */}
              <div className="bg-white p-2.5 rounded-md border border-zinc-200 flex flex-col justify-center">
                <span className="text-[10px] uppercase font-semibold text-zinc-500 tracking-wider">
                  Custo total seller
                </span>
                <span className="text-base font-bold text-zinc-900 font-mono">
                  ${calculatedTotal}
                </span>
              </div>
            </div>
          </div>

          {/* Row 6: Shipment destination & Estimated Delivery */}
          <div className="grid grid-cols-1 sm:grid-cols-2 gap-4">
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                Destination City / State
              </label>
              <input
                type="text"
                placeholder="e.g. Austin, TX, USA"
                value={destinationAddress}
                onChange={(e) => setDestinationAddress(e.target.value)}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900"
              />
            </div>
            <div>
              <label className="block font-medium text-zinc-700 mb-1">
                Estimated Shipment Days
              </label>
              <select
                value={estimatedDays}
                onChange={(e) => setEstimatedDays(parseInt(e.target.value, 10))}
                className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900"
              >
                <option value={1}>1 Day (Next Day Express)</option>
                <option value={2}>2 Days (Prime Air / Priority)</option>
                <option value={3}>3 Days (Standard Ground)</option>
                <option value={5}>5 Days (Economy Freight)</option>
                <option value={7}>7 Days (Cross-border Logistics)</option>
              </select>
            </div>
          </div>

          {/* Row 7: Order Notes */}
          <div>
            <label className="block font-medium text-zinc-700 mb-1">
              Internal Notes / Special Instructions
            </label>
            <textarea
              rows={2}
              placeholder="e.g. High priority customer; expedite packaging"
              value={notes}
              onChange={(e) => setNotes(e.target.value)}
              className="w-full px-3 py-2 bg-zinc-50 border border-zinc-300 rounded-md text-zinc-900 focus:outline-none focus:border-zinc-900 resize-none"
            />
          </div>

          {/* Footer Controls */}
          <div className="pt-4 border-t border-slate-200 flex items-center justify-end gap-3">
            <button
              type="button"
              onClick={onClose}
              className="px-4 py-2.5 rounded-xl text-xs font-semibold text-slate-700 bg-slate-100 hover:bg-slate-200 transition-colors"
            >
              Cancel
            </button>
            <button
              id="btn-submit-order"
              type="submit"
              disabled={isSubmitting}
              className="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-xs font-semibold text-white bg-blue-600 hover:bg-blue-700 disabled:opacity-50 transition-colors shadow-xs"
            >
              {isSubmitting ? (
                <>
                  <span className="w-3.5 h-3.5 border-2 border-white border-t-transparent rounded-full animate-spin" />
                  <span>Registering Order...</span>
                </>
              ) : (
                <>
                  <CheckCircle2 className="w-4 h-4 text-white" />
                  <span>Insert Order into Marketplace</span>
                </>
              )}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
};
