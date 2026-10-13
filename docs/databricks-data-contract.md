# Contrato Databricks → MarketOps

## Princípio

O Databricks envia somente fatos operacionais. O MarketOps calcula previsões em campos separados e dispara um e-mail quando detecta uma nova data real. Uma atualização repetida com os mesmos valores não cria um novo evento.

## Chave e granularidade

- Uma linha representa um produto do pedido.
- Chave de idempotência: `purchase_order + sku` (usar também `sequencial` quando o mesmo SKU puder aparecer em linhas distintas).
- `invoice` agrupa vários pedidos e produtos na tela de Invoices.
- Datas devem usar ISO 8601: `YYYY-MM-DD` ou timestamp com fuso.

## Campos esperados

| Campo canônico | Origem sugerida | Uso |
|---|---|---|
| `purchase_order` | Ordem Compra | Pedido/PO |
| `customer_order_id` | Ordem Cliente | Referência do cliente |
| `sku` | SKU Marketplace | Produto e idempotência |
| `invoice` | Invoice | Agrupamento de invoices |
| `customer_email` | E-mail cliente | Destinatário do alerta |
| `customer_phone` | Telefone | Cadastro; sem WhatsApp nesta versão |
| `customer_cpf` | CPF | Identificação no e-mail/detalhe |
| `customer_city`, `customer_state` | Cidade, UF | Destino resumido |
| `marketplace_purchase_confirmed_at` | Data Compra Seller | Preparando envio |
| `wr_date` | Data Chegada WH | Recebido na warehouse |
| `etd` | Data Embarque | Pedido enviado |
| `eta` | Data Chegada Manaus | Chegou em Manaus |
| `di_date` | Data DI | Desembaraço iniciado |
| `entry_cd_date` | Data Entrada CD | Entrou no centro de distribuição |
| `billing_date` | Data Emissão NF/faturamento | Saiu para entrega |
| `delivery_client_date` | Data Entrega Cliente | Entregue |
| `cancellation_reason` | Motivo/observação | Cancelamento comunicado |

## Previsão rolante v1

O retorno de cada pedido contém `forecast`, sem substituir as datas reais. O cálculo usa dias úteis e reinicia na última etapa real conhecida. Os limites conservadores foram derivados da linha de LT máximo da planilha fornecida:

| Próxima etapa | Prazo máximo inicial |
|---|---:|
| Chegada na warehouse | 9 dias úteis |
| Embarque/ETD | 6 dias úteis |
| Chegada em Manaus/ETA | 2 dias úteis |
| Entrada no CD (inclui desembaraço) | 14 dias úteis |
| Faturamento | 2 dias úteis |
| Entrega ao cliente | 4 dias úteis |

Antes da produção, esses parâmetros devem ser validados com Operações e preferencialmente movidos para uma tabela de SLA por origem, seller e modalidade.

## Envio automático

O Databricks Workflow deve enviar somente linhas novas ou alteradas para `POST /api/databricks/reconcile`. Em ambiente privado, defina `DATABRICKS_RECONCILE_TOKEN` e envie `Authorization: Bearer <token>`. O backend compara compra, ETD, ETA, entrada no CD, faturamento, entrega e cancelamento e envia o e-mail correspondente via SMTP.

Para produção, grave os eventos enviados em tabela persistente com chave `purchase_order + evento + data_real`; isso garante idempotência também depois de reiniciar o servidor.
