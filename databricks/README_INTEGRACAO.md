# MarketOps + Databricks — integração quase em tempo real

Este pacote deixa o MarketOps preparado para ler a tabela Delta do Databricks automaticamente e refletir as alterações no sistema.

## Arquitetura

- **Databricks**: origem dos dados importados e dos marcos logísticos (produto, seller, Invoice, WR, tracking, ETD, ETA, DI, Entrada CD, faturamento, entrega e destino).
- **PostgreSQL/Supabase**: continua guardando alterações operacionais feitas dentro do MarketOps, especialmente confirmação de compra, observações e cancelamentos manuais.
- **Backend MarketOps**: consulta o SQL Warehouse do Databricks aproximadamente a cada 10 segundos e faz upsert no PostgreSQL.
- **Frontend**: atualiza pedidos e indicadores aproximadamente a cada 10 segundos.

Assim, uma alteração no Databricks normalmente aparece no sistema em cerca de 10–20 segundos, dependendo do tempo para o SQL Warehouse responder.

## Arquivos de dados

Use `databricks/data/marketops_databricks_orders.csv` para a carga inicial. Ele contém 301 linhas de produtos e 38 campos.

Os dados de demonstração foram preparados com:

- e-mail único para todos os clientes: `isabelakalidossame@gmail.com`;
- telefone fictício: `(00) 00000-0000`;
- CPF fictício: `000.000.000-00`;
- destino no padrão `Cidade - UF`;
- pedidos com `entry_cd_date` preenchida e `billing_date`/`delivery_client_date` vazias classificados como `At Distribution Center`.

## Passo 1 — PostgreSQL / Supabase

Execute `database/008_databricks_destination.sql` no SQL Editor do Supabase. Ele adiciona o campo `destination` em `public.logistics`.

## Passo 2 — Criar a tabela no Databricks

O exemplo usa `main.marketops.orders_live`. Se sua empresa usa outro catálogo, troque `main` nos arquivos SQL e na variável `DATABRICKS_CATALOG`.

Você pode:

1. executar `databricks/001_create_orders_live.sql`; e depois carregar o CSV; **ou**
2. usar **New > Add or upload data > Create or modify a table** e importar diretamente `marketops_databricks_orders.csv`.

Confirme que a tabela final possui os mesmos nomes de coluna do CSV.

## Passo 3 — SQL Warehouse

Crie ou escolha um SQL Warehouse e anote o **Warehouse ID**. O backend usa a Statement Execution API para executar `SELECT` na tabela Delta.

## Passo 4 — Credenciais no Render

No serviço do MarketOps no Render, adicione as variáveis abaixo. Não coloque o token no React nem em variável `VITE_*`.

```env
DATA_SOURCE=postgres
DATABRICKS_SYNC_ENABLED=true
DATABRICKS_HOST=SEU_WORKSPACE.cloud.databricks.com
DATABRICKS_TOKEN=SEU_TOKEN
DATABRICKS_WAREHOUSE_ID=SEU_WAREHOUSE_ID
DATABRICKS_CATALOG=main
DATABRICKS_SCHEMA=marketops
DATABRICKS_TABLE=orders_live
DATABRICKS_POLL_INTERVAL_MS=10000
VITE_LIVE_REFRESH_MS=10000
```

Para teste inicial, o código aceita token do Databricks. Para produção corporativa, prefira autenticação OAuth/service principal conforme a política da empresa.

## Passo 5 — Deploy

Faça um novo deploy no Render depois de salvar as variáveis. No log deverá aparecer uma mensagem como:

```text
Databricks synchronized: 301 product lines from main.marketops.orders_live.
```

## Passo 6 — Validar

Execute `databricks/002_validation_queries.sql` no Databricks.

Depois abra o MarketOps e altere uma linha no Databricks. Use `databricks/003_test_live_update.sql` como exemplo. Em aproximadamente 10–20 segundos a tela deverá refletir a alteração.

## Regras de status usadas

- **Em trânsito**: pedido ativo com `invoice` preenchida e ainda não entregue.
- **No centro de distribuição**: `entry_cd_date` preenchida + `billing_date` vazia + `delivery_client_date` vazia.
- **Saiu para entrega**: `billing_date` preenchida e ainda sem `delivery_client_date`.
- **Entregue**: `delivery_client_date` preenchida.

## Campos do MarketOps preservados

A sincronização foi feita para não apagar mudanças operacionais locais: confirmação da compra, data da confirmação, observação do pedido e cancelamento manual. Os dados cadastrais/logísticos continuam vindo do Databricks.
