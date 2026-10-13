-- Teste simples da atualização quase em tempo real.
-- Troque AKDN-80275 por uma PO existente na tabela, se necessário.

-- 1) Coloca o pedido no centro de distribuição, ainda sem faturamento/entrega.
UPDATE main.marketops.orders_live
SET entry_cd_date = current_date(),
    billing_date = NULL,
    delivery_client_date = NULL,
    shipment_status = 'At Distribution Center',
    destination = 'Manaus - AM',
    databricks_sync_time = current_timestamp()
WHERE purchase_order = 'AKDN-80275';

-- 2) Depois, para testar a saída para entrega:
-- UPDATE main.marketops.orders_live
-- SET billing_date = current_date(),
--     shipment_status = 'Out for Delivery',
--     databricks_sync_time = current_timestamp()
-- WHERE purchase_order = 'AKDN-80275';

-- 3) E para testar a entrega:
-- UPDATE main.marketops.orders_live
-- SET delivery_client_date = current_date(),
--     shipment_status = 'Delivered',
--     databricks_sync_time = current_timestamp()
-- WHERE purchase_order = 'AKDN-80275';
