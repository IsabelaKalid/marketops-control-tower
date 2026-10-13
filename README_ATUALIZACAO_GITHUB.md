# Atualização do MarketOps para GitHub

Este pacote consolida a versão local mais recente do MarketOps com as melhorias feitas em 16/09/2026, incluindo integração Databricks Live.

## Antes do deploy

1. Não publique `.env.local` nem tokens/senhas no GitHub.
2. No Supabase SQL Editor, execute `database/008_databricks_destination.sql` uma única vez.
3. No Render, mantenha as variáveis Databricks configuradas no painel Environment.
4. Faça commit/push desta versão para a branch monitorada pelo Render.

## Databricks

Tabela configurada: `workspace.default.marketops_databricks_orders`.

A integração preserva campos operacionais mantidos pelo MarketOps e sincroniza os campos importados do Databricks.
